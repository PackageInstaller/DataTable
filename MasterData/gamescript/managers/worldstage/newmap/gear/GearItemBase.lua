local TMP_Text = CS.TMPro.TMP_Text
local CSTexture = typeof(CS.UnityEngine.Texture)
local CSMeshRenderer = typeof(CS.UnityEngine.MeshRenderer)
local CSAnimator = typeof(CS.UnityEngine.Animator)
local GearItemBase, Super = System.NewClass("GearItemBase", MapItemBase)

function GearItemBase:ctor(userData, mgr)
  Super.ctor(self)
  self.manager = mgr
  self.uid = userData and userData.uid
  self.spriteRender = nil
  self.nodeTypePostTriggerMap = {
    [DT.GetConstant("RelicKeyMapNodeType")] = System.fn(self, self.PlayEyeGoAnim)
  }
  EventMgr.Instance.CloseUIPanel:RegisterEvent(System.fn(self, self.OnCloseUIPanel))
end

function GearItemBase:GetModel()
  return self.manager and self.manager.parent and self.manager.parent.model
end

function GearItemBase:GetData()
  local model = self:GetModel()
  return model and model:GetGearDataByUid(self.uid)
end

function GearItemBase:GetTerrain()
  local posX, posY = self:GetGridPos()
  local terrainMgr = self.manager:GetComponent(MapTerrainManager)
  local terrain = terrainMgr:GetTerrainByPos(posX, posY)
  return terrain
end

function GearItemBase:PlayEyeGoAnim(callback)
  AudioManager.Instance:PostSoundEvent("Play_Explore_VFX_GetKey_MC")
  self.eyeGo:SetActive(true)
  TimerManager.Instance:CreateTimer(1, 0, nil, function()
    self.eyeGo:SetActive(false)
    if callback then
      callback()
    end
  end)
end

function GearItemBase:IsMonitored()
  local model = self:GetModel()
  return model and model:IsGearMonitored(self:GetUid())
end

function GearItemBase:SetDismissChoas(isDismiss)
  local model = self:GetModel()
  local isPreChoas = model and model:IsGearChoas(self:GetUid())
  if isDismiss then
    if model then
      model:SetGearDismissChoas(self:GetUid(), true)
    end
    if isPreChoas then
      self:SetSprite()
      AudioManager.Instance:PostSoundEvent("EXPLORE_BLOCK_CHAOS_TRANSFORM")
      self.smokeGo:SetActive(false)
      self.smokeGo:SetActive(true)
      self:SetName()
    end
  end
end

function GearItemBase:SetSprite()
  local laySprite = self:GetIconPath()
  if laySprite then
    self.isVisible = true
    local sprite = ResLoadMgr.LoadAsset(laySprite, self, CSTexture)
    self.layRender.material:SetTexture("_MainMap", sprite)
    sprite = ResLoadMgr.LoadAsset(laySprite, self, CSTexture)
    self.upRender.material:SetTexture("_MainMap", sprite)
    sprite = ResLoadMgr.LoadAsset(laySprite, self, CSTexture)
    self.upRender.material:SetTexture("_MainTexLight", sprite)
  else
    self.isVisible = false
    self:SetGoVisible(false)
  end
end

function GearItemBase:SetRenderEnable(state)
  self:_SetRenderEnable(self.layRender, state)
  self:_SetRenderEnable(self.upRender, state)
  self:SetGoVisible(state)
end

function GearItemBase:_SetRenderEnable(render, state)
  if render then
    render.enabled = state
  end
end

function GearItemBase:SetGoVisible(visibility)
  self:_SetGoVisible(self.layGo, visibility)
  self:_SetGoVisible(self.upGo, visibility)
end

function GearItemBase:_SetGoVisible(go, visibility)
  if go and not IsNil(go) then
    go:SetActive(visibility)
  end
end

function GearItemBase:SetIsRecovering(isRecovering)
  local model = self:GetModel()
  if model then
    model:SetGearRecovering(self:GetUid(), isRecovering)
  end
  if isRecovering then
    self:SetInTrigger()
  end
end

function GearItemBase:IsRecovering()
  local model = self:GetModel()
  return model and model:IsGearRecovering(self:GetUid())
end

function GearItemBase:LoadPrefab(prefabPath)
  Super.LoadPrefab(self, prefabPath)
end

local fontCodeMap = {
  CN = "UI/UI_Font/UX_Title_FZXiaoBiaoSong.asset",
  TW = "LangRes/TW/UI/UI_Font/UX_Title_FZXiaoBiaoSong_TW.asset",
  KR = "LangRes/KR/UI/UI_Font/UI_Text_SYSY_KR.asset",
  JP = "LangRes/JP/UI/UI_Font/UI_Text_SYSY_JP.asset",
  TH = "LangRes/TH/UI/UI_Font/UI_Text_SYSY_TH.asset",
  COM = "LangRes/COM/UI/UI_Font/UI_Text_SYSY_COM.asset"
}

function GearItemBase:SetFontRes()
  local langCode = DataCenter.gameData.CurrTextLanguage
  local resPath = fontCodeMap[langCode] or fontCodeMap.COM
  local fontAsset = ResLoadMgr.LoadAsset(resPath, self)
  return fontAsset
end

function GearItemBase:OnLoad()
  Super.OnLoad(self)
  local tf = self.tf
  local transform = tf.transform
  self.layGo = tf:Find("MUnit_Event_001").gameObject
  self.upGo = tf:Find("MUnit_Event_001 (1)").gameObject
  self.layRender = tf:Find("MUnit_Event_001"):GetComponent(CSMeshRenderer)
  self.upRender = tf:Find("MUnit_Event_001 (1)"):GetComponent(CSMeshRenderer)
  self.smokeGo = transform:Find("P_MUnit_EventChange").gameObject
  self.eyeGo = transform:Find("UI_Dbgcopy_eye_spere").gameObject
  self.tmpEventName = tf:Find("MUnit_Event_001 (1)/Text_Event_Name"):GetComponent(typeof(TMP_Text))
  self.tmpNameGo = self.tmpEventName.gameObject
  self.darkBgGo = tf:Find("MUnit_Event_001 (1)/UI_Dark_Mod").gameObject
  self.tmpEventName.font = self:SetFontRes()
  self:SetSprite()
  self:HideName()
  self:SetName()
  local model = self:GetModel()
  if model and model:IsGearRemovedMark(self:GetUid()) then
    self:SetRemovedMark(true)
  end
  self:_SetGoVisible(self.upGo, false)
  self:Refresh()
end

function GearItemBase:OnSyncGearInfo(data)
  local model = self:GetModel()
  if model then
    model:SyncGearData(self:GetUid(), data)
  end
  self:Refresh()
end

function GearItemBase:Refresh()
  local data = self:GetData()
  self:SetDismissChoas(data and data.isDismissChaos)
  local terrain = self:GetTerrain()
  if terrain then
    if not self:IsMonitored() then
      terrain:StopMonitedEffect()
    else
      terrain:PlayMonitedEffect()
    end
  end
end

function GearItemBase:ShowName()
  self:_EnableNameGroup(true)
end

function GearItemBase:HideName()
  self:_EnableNameGroup(false)
end

function GearItemBase:_EnableNameGroup(state)
  self.tmpNameGo:SetActive(state)
  self.darkBgGo:SetActive(state)
end

function GearItemBase:SetName()
  local name = self:GetGearTypeName()
  self.tmpEventName.text = name
end

function GearItemBase:OnCloseUIPanel(url)
  GlobalDispatcher:Dispatch(NotifyId.OnNewMapGearEventPanelClosed, self, url)
end

function GearItemBase:Dispose()
  Super.Dispose(self)
  self:OnDispose()
end

function GearItemBase:OnDispose()
  ResLoadMgr.UnloadAssetByTarget(self)
  EventMgr.Instance.CloseUIPanel:RemoveEvent(System.fn(self, self.OnCloseUIPanel))
  local model = self:GetModel()
  if model and model:IsGearEventPanelOpen(self:GetUid()) then
    UIManager.Instance:CloseByUrl(Urls.WorldStageEventPanel)
    self:AfterTrigger()
  end
end

function GearItemBase:_IsStorygListValid(storyList)
  return storyList and next(storyList) and #storyList <= 2
end

function GearItemBase:_PlayStoryList(storyList, svrData)
  local shadowFirst = storyList[1] == WorldStageConst.GEAR_DIALOG_SHADOW_TYPE
  local hasShadow = table.contains(storyList, WorldStageConst.GEAR_DIALOG_SHADOW_TYPE)
  local dialogVal = tonumber(storyList[1]) or tonumber(storyList[2])
  if hasShadow and not self._noShadowEffect then
    self:_StoryTriggerWithShdow(shadowFirst, dialogVal, svrData)
  else
    self:_StoryTrigger(dialogVal, svrData)
  end
end

function GearItemBase:_StoryTriggerWithShdow(shadowFirst, dialogVal, svrData)
  local effectMgr = self.manager:GetComponent(MapArtEffectManager)
  if shadowFirst then
    effectMgr:ChangeAtmosphere(4, function()
      self:_StoryTrigger(dialogVal, svrData)
    end)
  else
    self:_StoryTrigger(dialogVal, svrData, function()
      effectMgr:ChangeAtmosphere(4, function()
        if svrData then
          self:OnTrigger(svrData)
        end
      end)
    end)
  end
end

function GearItemBase:_StoryTrigger(dialogVal, svrData, endCallback)
  if not dialogVal then
    if endCallback then
      endCallback()
    elseif svrData then
      self:OnTrigger(svrData)
    end
    return
  end
  if AvgStoryManager.Instance:IsAvgBubble(dialogVal) then
    AvgStoryManager.Instance:StartStoryById(dialogVal)
    if svrData then
      self:OnTrigger(svrData)
    end
  else
    self.manager.parent:StopBGM()
    AvgStoryManager.Instance:StartStoryById(dialogVal, nil, function()
      self.manager.parent:PlayBGM()
      if endCallback then
        endCallback()
      elseif svrData then
        self:OnTrigger(svrData)
      end
    end)
  end
end

function GearItemBase:OnGearClick()
  GlobalDispatcher:Dispatch(NotifyId.OnNewMapGearClick, self)
end

function GearItemBase:ReqTrigger(uid, triggerMonitor)
  GlobalDispatcher:Dispatch(NotifyId.OnNewMapGearReqTrigger, self, uid, triggerMonitor)
end

function GearItemBase:OnTriggerGearData(svrData)
  GlobalDispatcher:Dispatch(NotifyId.OnNewMapGearTriggerData, self, svrData)
end

function GearItemBase:PreTrigger(svrData)
  GlobalDispatcher:Dispatch(NotifyId.OnNewMapGearPreTrigger, self, svrData)
end

function GearItemBase:OnTrigger(svrData)
  GlobalDispatcher:Dispatch(NotifyId.OnNewMapGearDoTrigger, self, svrData)
end

function GearItemBase:ShowMonitorOption(okFunc)
  local panel = UIManager.Instance:Show(Urls.WorldStageEventPanel, self:GetData())
  local eventId = self:GetMoniterdEffect()
  local eventData = {
    data = {eventId = eventId}
  }
  panel:RefreshDataByEventData(eventData)
  panel:SetCallFunc(function(optionIndex)
    if 2 == optionIndex and okFunc then
      okFunc()
    end
    panel:Close()
  end)
end

function GearItemBase:GetMoniterdEffect()
  do return self.GetChoasEffectByType, self end
  return self.GetChoasEffectByType, self, 2
end

function GearItemBase:GetChoasEffect()
  local model = self:GetModel()
  return model and model:GetGearChoasEffect(self:GetUid())
end

function GearItemBase:GetChoasEffectByType(choasType)
  local model = self:GetModel()
  return model and model:GetGearChoasEffectByType(self:GetUid(), choasType)
end

function GearItemBase:MoveAndDoTrigger()
  GlobalDispatcher:Dispatch(NotifyId.OnNewMapGearMoveAndTrigger, self)
end

function GearItemBase:TriggerAfterMonitorChoice()
  GlobalDispatcher:Dispatch(NotifyId.OnNewMapGearTriggerAfterMonitorChoice, self)
end

function GearItemBase:ReqGearItemHandle(...)
  GlobalDispatcher:Dispatch(NotifyId.OnNewMapGearReqHandle, self, ...)
end

function GearItemBase:GetConfigData()
  local model = self:GetModel()
  return model and model:GetGearConfigData(self:GetUid()) or {}
end

function GearItemBase:GetNodeTypeConfig()
  local model = self:GetModel()
  return model and model:GetGearNodeTypeConfig(self:GetUid())
end

function GearItemBase:GetGearTypeName()
  if self:GetIsChoas() then
    do return LT.Text end
    return LT.Text, "MapNodeChaosName", nil
  end
  local nodeTypeCfg = self:GetNodeTypeConfig()
  if nodeTypeCfg and nodeTypeCfg.HexIcon and nodeTypeCfg.Name then
    do return LT.Text end
    return LT.Text, nodeTypeCfg.Name
  end
  return ""
end

function GearItemBase:GetIsChoas()
  local model = self:GetModel()
  return model and model:IsGearChoas(self:GetUid())
end

function GearItemBase:GetIsCfgChoasNode()
  local model = self:GetModel()
  return model and model:GetGearChoasEffect(self:GetUid()) ~= nil
end

function GearItemBase:IsChoasNode()
  local model = self:GetModel()
  return model and model:IsGearChoasNode(self:GetUid())
end

function GearItemBase:GetTid()
  local model = self:GetModel()
  return model and model:GetGearTid(self.uid)
end

function GearItemBase:GetUid()
  return self.uid
end

function GearItemBase:GetType()
  local model = self:GetModel()
  return model and model:GetGearType(self:GetUid())
end

function GearItemBase:GetStatus()
  local model = self:GetModel()
  return model and model:GetGearStatus(self:GetUid())
end

function GearItemBase:GetIconPath()
  local nodeTypeCfg = self:GetNodeTypeConfig()
  if nodeTypeCfg and nodeTypeCfg.HexIcon and self:GetIsChoas() then
    do return table.unpack, DT.GetOriginalConstant("MapNodeChaosPic", {}) end
    return table.unpack, DT.GetOriginalConstant("MapNodeChaosPic", {})
  end
  do return table.unpack end
  return table.unpack, nodeTypeCfg and nodeTypeCfg.HexIcon or {}, DT.GetOriginalConstant("MapNodeChaosPic", {})
end

function GearItemBase:GetNameStr()
  local nodeTypeCfg = self:GetNodeTypeConfig()
  return nodeTypeCfg and nodeTypeCfg.Name or ""
end

function GearItemBase:IsHideMoveTip()
  local nodeTypeCfg = self:GetNodeTypeConfig()
  return nodeTypeCfg and 1 == nodeTypeCfg.HideMov
end

function GearItemBase:IsInMist()
  local mistMgr = self.manager:GetComponent(MapMistManager)
  if not mistMgr then
    return false
  end
  do return mistMgr.IsInMist, mistMgr, self:GetGridPos() end
  return mistMgr.IsInMist, mistMgr, self:GetGridPos()
end

function GearItemBase:OpenEventPanel(userData, callBack)
  GlobalDispatcher:Dispatch(NotifyId.OnNewMapGearOpenEventPanel, self, userData, callBack)
end

function GearItemBase:AudioPlay()
  local gearItemType = self:GetType()
  local audioEvent = GearAudioDefine.GearTypeAudio[gearItemType]
  if audioEvent then
    local eventId = self:SpecialTypeFix(audioEvent, gearItemType)
    AudioManager.Instance:PostSoundEvent(eventId)
  end
end

function GearItemBase:SpecialTypeFix(audioEvent, gearItemType)
  local eventId = audioEvent.eventId
  if CommonDefine.GearItemType.SingleTransport == gearItemType then
    local cfg = self:GetConfigData()
    local param = cfg.Effect and cfg.Effect[1]
    eventId = param and audioEvent.eventId[param] or eventId
  end
  return eventId
end

function GearItemBase:PlayShowAnim(state)
  local curTime = TimerManager.totalTime
  if self.playShowAnimTime and self.playShowAnimTime == curTime then
    return
  end
  self.playShowAnimTime = curTime
  if not self.isVisible then
    return
  end
  if state then
    self:PlayUp()
  end
  local MapGuideManager = self.manager:GetComponent(MapGuideManager)
  MapGuideManager:TriggerEvent(CommonDefine.GuideEvent.GearAppear, self:GetTid())
end

function GearItemBase:PlayUp()
  if self.go == nil then
    Logger.Error("PlayUp go nil")
    return
  end
  if self.playedUp then
    return
  end
  if not self.isVisible then
    return
  end
  self.playedUp = true
  self:SetGoVisible(true)
  local model = self:GetModel()
  if not model or not model:IsGearRemovedMark(self:GetUid()) then
    self:ShowName()
    local anim = self.go:GetComponent(CSAnimator)
    anim:Rebind()
    AnimatorUtils.PlayBlendParams(anim, "Multiply", "Float", 1)
    AnimatorUtils.PlayState(anim, "Base Layer.MUnit_Event_001a_A", -1, 0)
    local clipTime = AnimatorUtils.GetClipTime(anim, "MUnit_Event_001a_A")
    TimerManager.Instance:CreateTimer(1, clipTime, nil, function()
      if self.playedUp then
        self:_SetGoVisible(self.layGo, false)
      end
    end)
  end
  local terrain = self:GetTerrain()
  if terrain then
    terrain:DOOutlineScale()
  end
end

function GearItemBase:PlayDown(fromTime)
  if self.go == nil then
    Logger.Error("PlayDown go nil")
    return
  end
  if not self.playedUp then
    return
  end
  self.playedUp = nil
  self:SetGoVisible(true)
  if not self.isVisible then
    return
  end
  local model = self:GetModel()
  if model and model:IsGearRemovedMark(self:GetUid()) then
    return
  end
  local targetTime = fromTime or 0.55
  local anim = self.go:GetComponent(CSAnimator)
  AnimatorUtils.PlayBlendParams(anim, "Multiply", "Float", -1)
  AnimatorUtils.PlayState(anim, "Base Layer.MUnit_Event_001a_A", -1, targetTime)
  TimerManager.Instance:CreateTimer(1, targetTime, nil, function()
    if not self.playedUp then
      self:_SetGoVisible(self.upGo, false)
    end
  end)
end

function GearItemBase:AfterChoose(data)
  local handled = false
  if data and data.items then
    local type = data.items[1] and data.items[1].type or nil
    if type and type == CommonDefine.DropType.Relic then
      self:AfterTrigger()
      handled = true
    else
      UIManager.Instance:Show(Urls.WorldStageGetAwardTip, data, function()
        self:AfterTrigger()
      end)
      handled = true
    end
  end
  return handled
end

function GearItemBase:ReqChoose(index, eventId, callBack)
  GlobalDispatcher:Dispatch(NotifyId.OnNewMapGearReqChoose, self, index, eventId, callBack)
end

local SkipBattleCmdId = DT.GetConstant("SkipBattleCmd")

function GearItemBase:CheckIsSkipBattleEvent(index, eventId)
  local eventCfg = DT.Event[eventId]
  local cmdId = eventCfg and eventCfg["ChoiceEffect" .. index] and eventCfg["ChoiceEffect" .. index][1]
  return cmdId and cmdId == SkipBattleCmdId
end

function GearItemBase:InsertBattleSettleTip()
  CopyDataUtils.Set_needShowBattleSettleTips(true)
end

function GearItemBase:OnGearItemHandle()
end

function GearItemBase:AfterTrigger()
  GlobalDispatcher:Dispatch(NotifyId.OnNewMapGearAfterTrigger, self)
end

function GearItemBase:OnRemove()
  Logger.Info("[NewMap] GearItemBase OnRemove uid, tid, type", self:GetUid(), self:GetTid(), self:GetType())
  local model = self:GetModel()
  if model and model:IsGearRemovedMark(self:GetUid()) then
    return
  end
  local mapNode = DT.MapNode[self:GetTid()]
  local nodeType = mapNode and mapNode.NodeType
  local typeEffect = nodeType and DT.MapNodeType[nodeType] and DT.MapNodeType[nodeType].TypeEffect
  if self.nodeTypePostTriggerMap[typeEffect] then
    self.nodeTypePostTriggerMap[typeEffect]()
  end
  if self.playedUp then
    self:PlayDown(0.1)
  end
  self:OnDispose()
  self:SetRemovedMark(true)
end

function GearItemBase:SetRemovedMark(isRemoved)
  local model = self:GetModel()
  if model then
    model:SetGearRemoved(self:GetUid(), isRemoved)
  end
  if self.upRender then
    self.upRender.enabled = false
  end
  if self.layRender then
    self.layRender.material:SetFloat("_ColorMaskKey", isRemoved and 1 or 0)
    self.layRender.material:SetFloat("_MaskKey", isRemoved and 1 or 0)
    self.layRender.material:SetFloat("_AlphaFront", isRemoved and 0 or 1)
    self.layRender.material:EnableKeyword("_COLORMASKKEY_ON")
    self.layRender.material:EnableKeyword("_MASKKEY_ON")
    self:_EnableNameGroup(not isRemoved)
  end
end

function GearItemBase:IsRemoved()
  local model = self:GetModel()
  return model and model:IsGearRemoved(self:GetUid())
end

function GearItemBase:SetInTrigger()
  local model = self:GetModel()
  if model then
    model:SetGearInTrigger(self:GetUid())
  end
  local MapGuideManager = self.manager:GetComponent(MapGuideManager)
  MapGuideManager:TriggerEvent(CommonDefine.GuideEvent.GearTrigger, self:GetTid())
end

function GearItemBase:EndTriggering()
  local model = self:GetModel()
  if model then
    model:EndGearTrigger(self:GetUid())
  end
end

function GearItemBase:IsTriggering()
  local model = self:GetModel()
  return model and model:IsGearTriggering(self:GetUid())
end

function GearItemBase:SetWaitingForProto(isWaiting)
  local model = self:GetModel()
  if model then
    model:SetGearWaitingForProto(self:GetUid(), isWaiting)
  end
end

function GearItemBase:IsWaitingForProto()
  local model = self:GetModel()
  return model and model:IsGearWaitingForProto(self:GetUid())
end

local GearTypeToFile = {
  [CommonDefine.GearItemType.Event] = "GearItemEvent",
  [CommonDefine.GearItemType.Camp] = "GearItemCamp",
  [CommonDefine.GearItemType.Story] = "GearItemStory",
  [CommonDefine.GearItemType.Wall] = "GearItemWall",
  [CommonDefine.GearItemType.Door] = "GearItemDoor",
  [CommonDefine.GearItemType.DropTerrain] = "GearItemDropTerrain",
  [CommonDefine.GearItemType.HiddenChannel] = "GearItemHiddenChannel",
  [CommonDefine.GearItemType.Beacon] = "GearItemBeacon",
  [CommonDefine.GearItemType.SingleTransport] = "GearItemSingleTransport",
  [CommonDefine.GearItemType.MysteryShop] = "GearItemMysteryShop",
  [CommonDefine.GearItemType.Transport] = "GearItemTransport",
  [CommonDefine.GearItemType.Obstacle] = "GearItemObstacle",
  [CommonDefine.GearItemType.Machine] = "GearItemMachine",
  [CommonDefine.GearItemType.ShadowEffect] = "GearItemShadowEffect",
  [CommonDefine.GearItemType.HiddenAward] = "GearItemHiddenAward",
  [CommonDefine.GearItemType.StageGroup_1_Talent] = "GearItemEvent",
  [CommonDefine.GearItemType.StageGroup_2_Talent] = "GearItemEvent",
  [CommonDefine.GearItemType.ChangeAvatarRes] = "GearItemChangeAvatarRes",
  [CommonDefine.GearItemType.PoisonGas] = "GearItemPoisonGas",
  [CommonDefine.GearItemType.BloodPool] = "GearItemEvent"
}

function GearItemBase.Create(gearType, data, mgr)
  if gearType >= CommonDefine.GearItemType.LittleMonster and gearType <= CommonDefine.GearItemType.EliteMonster then
    do return GearItemMonster, data end
    return GearItemMonster, data, mgr
  elseif gearType == CommonDefine.GearItemType.Boss then
    do return GearItemBoss, data end
    return GearItemBoss, data, mgr
  elseif gearType == CommonDefine.GearItemType.Shop or gearType == CommonDefine.GearItemType.RelicShop or gearType == CommonDefine.GearItemType.EnchantShop or gearType == CommonDefine.GearItemType.CustomizeRelicShop or gearType == CommonDefine.GearItemType.CustomizeEnchantShop then
    do return GearItemShop, data end
    return GearItemShop, data, mgr
  elseif gearType == CommonDefine.GearItemType.SpecialShop then
    do return GearItemSpecialShop, data end
    return GearItemSpecialShop, data, mgr
  elseif gearType == CommonDefine.GearItemType.Treasure or gearType == CommonDefine.GearItemType.BoxDrop or gearType == CommonDefine.GearItemType.StoneDrop or gearType == CommonDefine.GearItemType.Relic then
    do return GearItemTreasure, data end
    return GearItemTreasure, data, mgr
  elseif GearTypeToFile[gearType] then
    do return require("GameScript.Managers.WorldStage.NewMap.Gear." .. GearTypeToFile[gearType]), data end
    return require("GameScript.Managers.WorldStage.NewMap.Gear." .. GearTypeToFile[gearType]), data, mgr
  end
  Logger.Warn("GearItemBase.Create, do not find type")
  do return GearItemBase, data end
  return GearItemBase, data, mgr
end

return GearItemBase
