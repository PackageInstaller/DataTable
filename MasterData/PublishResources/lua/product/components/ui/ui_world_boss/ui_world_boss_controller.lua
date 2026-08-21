_class("UIWorldBossController", UIController)
UIWorldBossController = UIWorldBossController

function UIWorldBossController:Constructor()
  self._loginModule = self:GetModule(LoginModule)
  self._roleModule = self:GetModule(RoleModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._missionModule = self:GetModule(MissionModule)
  self._bossIds = nil
  self._curSelectTeamIndex = 0
  self._allTeam = nil
  self._maxPetsCount = 5
  self._allPets = nil
  self._defaultSelectTeamIndex = 1
  self._defaultDan = 0
  self._danResulting = false
  self._timeEvents = {}
  self._materialReq = nil
  self._material = nil
end

function UIWorldBossController:LoadDataOnEnter(TT, res, uiParams)
  self._worldBossModule = self:GetModule(WorldBossModule)
  local getDataRes = self._worldBossModule:ReqWorldBossData(TT)
  if not getDataRes:GetSucc() then
    res:SetSucc(false)
    return
  end
  self._worldBossData = self._worldBossModule.m_world_boss_data
  self._useClientCal = true
  if self._useClientCal then
    local getListRes = self._worldBossModule:CheckGetWorldBossRankDamageList(TT)
    local rankList = self._worldBossModule.m_rank_damage_list
    local tmp_promote = 0
    self._curDan, self._curRank = UIActivityHelper.CalClientDan(rankList, self._worldBossData.cur_dan, self._worldBossData.rank, tmp_promote, self._worldBossData.max_total_damage, self._worldBossData.boss_mission_id)
  else
    self._curDan = self._worldBossData.cur_dan
    self._curRank = self._worldBossData.rank
  end
  local cfg = Cfg.cfg_world_boss_mission[self._worldBossData.boss_mission_id]
  if not cfg then
    Log.exception("cfg_world_boss_mission中缺少配置:", self._worldBossData.boss_mission_id)
  end
  self._isEliminate = cfg.SubMatchType and cfg.SubMatchType == MatchType.MT_PopStarPro
end

function UIWorldBossController:OnShow(uiParams)
  self._screeShot = uiParams[1]
  self:_GetComponents()
  self:_OnValue()
  self:_AddEvent()
  self:_RecordFirstOpen()
  self:_RecordMissionId()
  self:FlushRedQuest()
  self:Lock("UIWorldBossController_OnShow")
  local te = GameGlobal.Timer():AddEvent(600, function()
    self:UnLock("UIWorldBossController_OnShow")
  end)
  table.insert(self._timeEvents, te)
end

function UIWorldBossController:_RecordFirstOpen()
  if LocalDB.GetInt("UIWorldBossControllerOpenRecord" .. self._loginModule:GetRoleShowID(), 0) <= 0 then
    LocalDB.SetInt("UIWorldBossControllerOpenRecord" .. self._loginModule:GetRoleShowID(), 1)
  end
end

function UIWorldBossController:_RecordMissionId()
  LocalDB.SetInt("UIWorldBossMissionId" .. self._loginModule:GetRoleShowID(), self._worldBossData.boss_mission_id)
end

function UIWorldBossController:_AddEvent()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
  self:AttachEvent(GameEventType.WorldBossDanResult, self._OnWorldBossDanResult)
end

function UIWorldBossController:OnHide()
  for key, value in pairs(self._timeEvents) do
    GameGlobal.Timer():CancelEvent(value)
  end
  if self._materialReq then
    self._materialReq:Dispose()
    self._material = nil
    self._materialReq = nil
  end
end

function UIWorldBossController:_GetComponents()
  self._backBtn = self:GetUIComponent("UISelectObjectPath", "BackBtn")
  self._commonTopBtn = self._backBtn:SpawnObject("UICommonTopButton")
  self._commonTopBtn:SetData(function()
    self:_Close()
  end, function()
    if self._isEliminate then
      self:ShowDialog("UIHelpController", "UIWorldBossController_Eliminate")
    else
      self:ShowDialog("UIHelpController", "UIWorldBossController")
    end
  end)
  self._uianim = self:GetGameObject("uianim")
  self._remainingTime = self:GetUIComponent("UILocalizationText", "RemainingTime")
  self._danName = self:GetUIComponent("UILocalizationText", "GradeName")
  self._danBadgeGen = self:GetUIComponent("UISelectObjectPath", "DanBadgeGen")
  self._danBadgeGenGo = self:GetGameObject("DanBadgeGen")
  self._danBadgeGenRect = self:GetUIComponent("RectTransform", "DanBadgeGen")
  self._maxScoreGray = self:GetUIComponent("UILocalizationText", "MaxScoreGray")
  self._maxScoreValue = self:GetUIComponent("UILocalizationText", "MaxScoreValue")
  self._curScoreGray = self:GetUIComponent("UILocalizationText", "CurScoreGray")
  self._curScoreValue = self:GetUIComponent("UILocalizationText", "CurScoreValue")
  self._team = self:GetUIComponent("UISelectObjectPath", "Content")
  self._teamScoreGray = self:GetUIComponent("UILocalizationText", "TeamScoreGray")
  self._teamScoreValue = self:GetUIComponent("UILocalizationText", "TeamScoreValue")
  self._bossAlias = self:GetUIComponent("UILocalizedTMP", "BossAlias")
  self._bossName = self:GetUIComponent("UILocalizedTMP", "BossName")
  self._bossDesc = self:GetUIComponent("UILocalizationText", "bossDesc")
  self._pets = self:GetUIComponent("UISelectObjectPath", "Pets")
  self._bossCg = self:GetUIComponent("RawImageLoader", "BossCg")
  self._bossCgRawImage = self:GetUIComponent("RawImage", "BossCg")
  self._bossCgRect = self:GetUIComponent("RectTransform", "BossCg")
  self._challengeBtnLock = self:GetGameObject("ChallengeBtnLock")
  self._challengeArrow = self:GetGameObject("challengeArrow")
  self._curDanAreaGo = self:GetGameObject("CurDanArea")
  self._curDanNoInfoAreaGo = self:GetGameObject("CurDanArea1")
  self.remaintimeGo = self:GetGameObject("remaintimeGo")
  self.overTimeGo = self:GetGameObject("overTimeGo")
  self._multiAwards = self:GetGameObject("MultiAwards")
  self._multiAwardsText = self:GetUIComponent("UILocalizationText", "MultiAwardsText")
  self._redQuest = self:View():GetUIComponent("UISelectObjectPath", "redQuest")
  self._redQuestSpawn = nil
  self._bossElementPool = self:GetUIComponent("UISelectObjectPath", "bossElement")
  self._needHideGoNames = {
    "Left",
    "Right",
    "BgCover"
  }
  self._needHideGos = {}
  for index, value in ipairs(self._needHideGoNames) do
    local hideGo = self:GetGameObject(value)
    if hideGo then
      table.insert(self._needHideGos, hideGo)
    end
  end
  self._useBadgeAnim = true
  if self._useBadgeAnim then
    self:_InitWidgetBadgeAnim()
  end
  self._enterShot = self:GetUIComponent("RawImage", "enterShot")
  if self._screeShot then
    self._enterShot.gameObject:SetActive(true)
    self._enterShot.texture = self._screeShot
  else
    self._enterShot.gameObject:SetActive(false)
  end
  self._eliminateTip = self:GetGameObject("EliminateTip")
end

function UIWorldBossController:_InitWidgetBadgeAnim()
  self._anim = self:GetUIComponent("Animation", "UIWorldBossController")
  self._rankTextFomAnim = self:GetUIComponent("UILocalizationText", "RankText")
  self._lastDanText = self:GetUIComponent("UILocalizationText", "LastDanText")
  self._lastDanTextGo = self:GetGameObject("LastDanText")
  if self._lastDanTextGo then
    self._lastDanTextGo:SetActive(false)
  end
  self._curDanAreaGoForAnim = self:GetGameObject("curItem")
  self._lastDanAreaGoForAnim = self:GetGameObject("LastItem")
  self._curBadgeIconBase = self:GetUIComponent("RawImageLoader", "CurDanIcon")
  self._curBadgeIconBaseImg = self:GetUIComponent("RawImage", "CurDanIcon")
  self._curBadgeIconBaseForAnimMr = self:GetUIComponent("MeshRenderer", "CurDanIconForAnim")
  self._curBadgeMaskMr = self:GetUIComponent("MeshRenderer", "CurDanMask")
  self._curBadgeIconBaseGo = self:GetGameObject("CurDanIcon")
  self._curBadgePlusIconGo = self:GetGameObject("CurDanPlusIcon")
  self._curBadgeIconFrontGo = self:GetGameObject("CurDanIconFrontBg")
  self._curBadgeIconFrontText = self:GetUIComponent("UILocalizationText", "CurDanIconFrontText")
  self._curBadgeIconFrontTextBack = self:GetUIComponent("UILocalizationText", "CurDanIconFrontTextBack")
  self._lastBadgeIconBase = self:GetUIComponent("RawImageLoader", "LastDanIconBase")
  self._lastBadgeIconBaseGo = self:GetGameObject("LastDanIconBase")
  self._lastBadgePlusIconGo = self:GetGameObject("LastDanPlusIcon")
  self._lastBadgeIconFrontGo = self:GetGameObject("LastDanIconFrontBg")
  self._lastBadgeIconFrontText = self:GetUIComponent("UILocalizationText", "LastDanIconFrontText")
  self._lastBadgeIconFrontTextBack = self:GetUIComponent("UILocalizationText", "LastDanIconFrontTextBack")
end

function UIWorldBossController:_FillCurBadge(danId, rankLevel)
  if UIWorldBossHelper.IsNoDan(danId, rankLevel) then
    self._curBadgeIconBase:LoadImage("1601191_logo")
    self._curBadgeIconBaseGo:SetActive(false)
    self._curBadgeIconFrontGo:SetActive(false)
    return
  end
  local badgeBase = UIWorldBossHelper.GetDanBadgeBase(danId, rankLevel)
  if badgeBase then
    self._curBadgeIconBase:LoadImage(badgeBase)
    self._curBadgeIconBaseForAnimMr.sharedMaterial:SetTexture("_MainTex", self._curBadgeIconBaseImg.material.mainTexture)
    self._curBadgeMaskMr.sharedMaterial:SetTexture("_MainTex", self._curBadgeIconBaseImg.material.mainTexture)
    if 0 < rankLevel then
      self._curBadgeIconFrontGo:SetActive(true)
      self._curBadgeIconFrontText:SetText(tostring(rankLevel))
      if self._curBadgeIconFrontTextBack then
        self._curBadgeIconFrontTextBack:SetText(tostring(rankLevel))
      end
    else
      self._curBadgeIconFrontGo:SetActive(false)
    end
    local bPlus = UIWorldBossHelper.IsPlusDan(danId, rankLevel)
    self._curBadgePlusIconGo:SetActive(bPlus)
  end
end

function UIWorldBossController:_FillDanName(danId, rankLevel)
  local danName = UIWorldBossHelper.GetDanName(danId, rankLevel)
  if danName and self._danName then
    self._danName:SetText(StringTable.Get(danName))
  end
end

function UIWorldBossController:_FillLastBadge(danId, rankLevel)
  if UIWorldBossHelper.IsNoDan(danId, rankLevel) then
    self._lastBadgeIconBase:LoadImage("1601191_logo")
    self._lastBadgeIconBaseGo:SetActive(false)
    self._lastBadgeIconFrontGo:SetActive(false)
    return
  end
  local badgeBase = UIWorldBossHelper.GetDanBadgeBase(danId, rankLevel)
  if badgeBase then
    self._lastBadgeIconBaseGo:SetActive(true)
    self._lastBadgeIconBase:LoadImage(badgeBase)
    if 0 < rankLevel then
      self._lastBadgeIconFrontGo:SetActive(true)
      self._lastBadgeIconFrontText:SetText(tostring(rankLevel))
      if self._lastBadgeIconFrontTextBack then
        self._lastBadgeIconFrontTextBack:SetText(tostring(rankLevel))
      end
    else
      self._lastBadgeIconFrontGo:SetActive(false)
    end
    local bPlus = UIWorldBossHelper.IsPlusDan(danId, rankLevel)
    self._lastBadgePlusIconGo:SetActive(bPlus)
  end
end

function UIWorldBossController:_CheckDoBadgeAnim()
  if self._oldRank > 0 and 0 < self._newRank then
    if self._oldRank <= self._newRank then
      self:_FillCurBadge(self._newDan, self._newRank)
      self:_FillDanName(self._newDan, self._newRank)
    else
      self:_PlayBadgeAnim_RankUp()
    end
  elseif self._oldDan < self._newDan then
    if self._oldRank == 0 and self._newRank == 0 then
      if self._oldDan == 0 then
        if UIWorldBossHelper.IsNormalTopDan(self._newDan, self._newRank) then
          self:_PlayBadgeAnim_NoDanToNormalTop()
        else
          self:_PlayBadgeAnim_NoDanToNormal()
        end
      elseif UIWorldBossHelper.IsNormalTopDan(self._newDan, self._newRank) then
        self:_PlayBadgeAnim_DanUpToNormalTop()
      else
        self:_PlayBadgeAnim_DanUpToNormal()
      end
    elseif 0 < self._newRank then
      if self._oldDan == 0 then
        self:_PlayBadgeAnim_NoDanToLegend()
      else
        self:_PlayBadgeAnim_DanUpToLegend()
      end
    else
      self:_FillCurBadge(self._newDan, self._newRank)
      self:_FillDanName(self._newDan, self._newRank)
    end
  else
    self:_FillCurBadge(self._newDan, self._newRank)
    self:_FillDanName(self._newDan, self._newRank)
  end
end

function UIWorldBossController:_PlayBadgeAnim_RankUp()
  self:_FillLastBadge(self._oldDan, self._oldRank)
  self:_FillDanName(self._newDan, self._newRank)
  self:_FillCurBadge(self._oldDan, self._oldRank)
  self._anim:Play("uieff_WorldBoss_Dan_NewRank")
  self:_LockForBadgeAnim(5333)
  local te
  te = GameGlobal.Timer():AddEvent(1, function()
    self:_FillCurBadge(self._newDan, self._newRank)
  end)
  table.insert(self._timeEvents, te)
  self._rankTextFomAnim:SetText(self._oldRank)
  te = GameGlobal.Timer():AddEvent(1155, function()
    local duration = 0.8
    DoTweenHelper.DoUpdateInt(self._oldRank, self._newRank + 1, duration, function(val)
      local rank = math.floor(val)
      self._rankTextFomAnim:SetText(rank)
    end)
  end)
  table.insert(self._timeEvents, te)
  te = GameGlobal.Timer():AddEvent(2055, function()
    self._rankTextFomAnim:SetText(self._newRank)
  end)
  table.insert(self._timeEvents, te)
end

function UIWorldBossController:_PlayBadgeAnim_NoDanToNormal()
  local te
  self:_FillLastBadge(self._oldDan, self._oldRank)
  self:_FillDanName(self._oldDan, self._oldRank)
  te = GameGlobal.Timer():AddEvent(2000, function()
    self:_FillDanName(self._newDan, self._newRank)
  end)
  table.insert(self._timeEvents, te)
  self:_FillCurBadge(self._oldDan, self._oldRank)
  self._anim:Play("uieff_WorldBoss_Dan_NewDan_Y")
  self:_LockForBadgeAnim(3433)
  local animState = self._anim:get_Item("uieff_WorldBoss_Dan_NewDan_Y")
  local percent = 0.3268627450980392
  animState.normalizedTime = percent
  te = GameGlobal.Timer():AddEvent(1, function()
    self:_FillCurBadge(self._newDan, self._newRank)
  end)
  table.insert(self._timeEvents, te)
end

function UIWorldBossController:_PlayBadgeAnim_NoDanToNormalTop()
  local te
  self:_FillLastBadge(self._oldDan, self._oldRank)
  te = GameGlobal.Timer():AddEvent(333, function()
    self:_FillDanName(self._newDan, self._newRank)
  end)
  table.insert(self._timeEvents, te)
  self:_FillCurBadge(self._oldDan, self._oldRank)
  self._anim:Play("uieff_WorldBoss_Dan_NewDan")
  self:_LockForBadgeAnim(3433)
  local animState = self._anim:get_Item("uieff_WorldBoss_Dan_NewDan")
  local percent = 0.3268627450980392
  animState.normalizedTime = percent
  te = GameGlobal.Timer():AddEvent(1, function()
    self:_FillCurBadge(self._newDan, self._newRank)
  end)
  table.insert(self._timeEvents, te)
end

function UIWorldBossController:_PlayBadgeAnim_DanUpToNormalTop()
  local te
  self:_FillLastBadge(self._oldDan, self._oldRank)
  self:_FillDanName(self._oldDan, self._oldRank)
  te = GameGlobal.Timer():AddEvent(2000, function()
    self:_FillDanName(self._newDan, self._newRank)
  end)
  table.insert(self._timeEvents, te)
  self:_FillCurBadge(self._oldDan, self._oldRank)
  self._anim:Play("uieff_WorldBoss_Dan_NewDan")
  self:_LockForBadgeAnim(5100)
  te = GameGlobal.Timer():AddEvent(1, function()
    self:_FillCurBadge(self._newDan, self._newRank)
  end)
  table.insert(self._timeEvents, te)
end

function UIWorldBossController:_PlayBadgeAnim_DanUpToNormal()
  local te
  self:_FillLastBadge(self._oldDan, self._oldRank)
  self:_FillDanName(self._oldDan, self._oldRank)
  te = GameGlobal.Timer():AddEvent(2000, function()
    self:_FillDanName(self._newDan, self._newRank)
  end)
  table.insert(self._timeEvents, te)
  self:_FillCurBadge(self._oldDan, self._oldRank)
  self._anim:Play("uieff_WorldBoss_Dan_NewDan_Y")
  self:_LockForBadgeAnim(5100)
  te = GameGlobal.Timer():AddEvent(1, function()
    self:_FillCurBadge(self._newDan, self._newRank)
  end)
  table.insert(self._timeEvents, te)
end

function UIWorldBossController:_PlayBadgeAnim_DanUpToLegend()
  local te
  self:_FillLastBadge(self._oldDan, self._oldRank)
  self:_FillDanName(self._oldDan, self._oldRank)
  te = GameGlobal.Timer():AddEvent(2000, function()
    self:_FillDanName(self._newDan, self._newRank)
  end)
  table.insert(self._timeEvents, te)
  self:_FillCurBadge(self._oldDan, self._oldRank)
  self._anim:Play("uieff_WorldBoss_Dan_NewDan")
  self:_LockForBadgeAnim(5100)
  te = GameGlobal.Timer():AddEvent(1, function()
    self:_FillCurBadge(self._newDan, self._newRank)
    local tmpRank = 0
    self._curBadgeIconFrontText:SetText(tostring(tmpRank))
    if self._curBadgeIconFrontTextBack then
      self._curBadgeIconFrontTextBack:SetText(tostring(tmpRank))
    end
  end)
  table.insert(self._timeEvents, te)
  te = GameGlobal.Timer():AddEvent(3000, function()
    local duration = 0.66
    DoTweenHelper.DoUpdateInt(0, self._newRank, duration, function(val)
      local rank = math.floor(val)
      self._curBadgeIconFrontText:SetText(tostring(rank))
      if self._curBadgeIconFrontTextBack then
        self._curBadgeIconFrontTextBack:SetText(tostring(rank))
      end
    end)
  end)
  table.insert(self._timeEvents, te)
end

function UIWorldBossController:_PlayBadgeAnim_NoDanToLegend()
  local te
  te = GameGlobal.Timer():AddEvent(333, function()
    self:_FillDanName(self._newDan, self._newRank)
  end)
  table.insert(self._timeEvents, te)
  self._anim:Play("uieff_WorldBoss_Dan_NewDan")
  self:_LockForBadgeAnim(3433)
  local animState = self._anim:get_Item("uieff_WorldBoss_Dan_NewDan")
  local percent = 0.3268627450980392
  animState.normalizedTime = percent
  te = GameGlobal.Timer():AddEvent(1, function()
    self:_FillCurBadge(self._newDan, self._newRank)
    local tmpRank = 0
    self._curBadgeIconFrontText:SetText(tostring(tmpRank))
    if self._curBadgeIconFrontTextBack then
      self._curBadgeIconFrontTextBack:SetText(tostring(tmpRank))
    end
  end)
  table.insert(self._timeEvents, te)
  te = GameGlobal.Timer():AddEvent(1333, function()
    local duration = 0.66
    DoTweenHelper.DoUpdateInt(0, self._newRank, duration, function(val)
      local rank = math.floor(val)
      self._curBadgeIconFrontText:SetText(tostring(rank))
      if self._curBadgeIconFrontTextBack then
        self._curBadgeIconFrontTextBack:SetText(tostring(rank))
      end
    end)
  end)
  table.insert(self._timeEvents, te)
end

function UIWorldBossController:_LockForBadgeAnim(timeLen)
  self:Lock("_LockForBadgeAnim")
  local te = GameGlobal.Timer():AddEvent(timeLen, function()
    self:UnLock("_LockForBadgeAnim")
  end)
  table.insert(self._timeEvents, te)
end

function UIWorldBossController:_OnValue()
  self:_CreateTeam()
  self:_CreatePets()
  self:_RefreshUIInfo(true)
  self:_TriggerGuide()
end

function UIWorldBossController:_TriggerGuide()
  self:StartTask(function(TT)
    local oldGuideId = 6012
    self:Lock("UIWorldBossController")
    if self:GetModule(GuideModule):IsGuideDone(oldGuideId) then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIWorldBossController_B)
    else
      GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIWorldBossController_C)
    end
    self:UnLock("UIWorldBossController")
  end, self)
end

function UIWorldBossController:_AfterUILayerChanged()
  self:_CheckShowDanResult()
end

function UIWorldBossController:_OnWorldBossDanResult()
  self:StartTask(function(TT)
    local res = self._worldBossModule:ReqWorldBossData(TT)
    if not res:GetSucc() then
      return
    end
    self._worldBossData = self._worldBossModule.m_world_boss_data
    self._curDan = self._worldBossData.cur_dan
    self._curRank = self._worldBossData.rank
    self._defaultDan = 0
    self._defaultSelectTeamIndex = 1
    local cfg = Cfg.cfg_world_boss_mission[self._worldBossData.boss_mission_id]
    if not cfg then
      Log.exception("cfg_world_boss_mission中缺少配置:", self._worldBossData.boss_mission_id)
    end
    self._isEliminate = cfg.SubMatchType and cfg.SubMatchType == MatchType.MT_PopStarPro
    self:_RefreshUIInfo(false)
  end)
end

function UIWorldBossController:_RefreshUIInfo(bInit)
  local cfg_world_boss_mission = Cfg.cfg_world_boss_mission[self._worldBossData.boss_mission_id]
  local cfg_monster_class, cfg_monster, cfg_monster_list = self:_GetBossCfg(self._worldBossData.boss_mission_id)
  local bossAlias, bossName
  self._bossIds = {}
  if cfg_monster then
    for _, cfg in ipairs(cfg_monster_list) do
      table.insert(self._bossIds, cfg.ID)
    end
    if not self.bossElement then
      self.bossElement = self._bossElementPool:SpawnObject("UIWorldBossElement")
    end
    self.bossElement:SetData(cfg_monster)
  else
    Log.error("err UIWorldBossController:_RefreshUIInfo can't find cfg_monster with boss_mission_id = " .. self._worldBossData.boss_mission_id)
  end
  if cfg_monster_class then
    bossAlias = StringTable.Get(cfg_monster_class.Alias)
    bossName = StringTable.Get(cfg_monster_class.Name)
    local cfg_world_boss_cg = Cfg.cfg_world_boss_cg[cfg_monster_class.ID]
    if cfg_world_boss_cg then
      self._bossCgRect.localScale = Vector3(cfg_world_boss_cg.scale, cfg_world_boss_cg.scale, 1)
      self._bossCgRect.anchoredPosition3D = Vector3(cfg_world_boss_cg.offset[1], cfg_world_boss_cg.offset[2], 0)
    end
  end
  local cfg_world_boss_mission = Cfg.cfg_world_boss_mission[self._worldBossData.boss_mission_id]
  if cfg_world_boss_mission then
    self._bossCg:LoadImage(cfg_world_boss_mission.BossImg)
    self._bossCgRawImage.enabled = cfg_world_boss_mission.BossImg ~= nil
  end
  self._bossName:SetText(bossName)
  self._bossDesc:SetText(StringTable.Get(cfg_world_boss_mission.BossDesc))
  self._multiAwards:SetActive(self._worldBossModule:AwardMultiOpen())
  self._multiAwardsText:SetText(StringTable.Get("str_n18_worldboss_extradrop"))
  self:FlushRedQuest()
  local bIsNoDan = UIWorldBossHelper.IsNoDan(self._curDan, self._curRank)
  self._curDanAreaGo:SetActive(not bIsNoDan)
  self._curDanNoInfoAreaGo:SetActive(bIsNoDan)
  if bIsNoDan then
    if self._useBadgeAnim then
      self._worldBossModule:SetUiOldDan(self._curDan, self._curRank, self._worldBossData.boss_mission_id)
    end
    self._curDanAreaGoForAnim:SetActive(false)
  elseif self._useBadgeAnim then
    self._oldDan = 0
    self._oldRank = 0
    self._oldDan, self._oldRank = self._worldBossModule:GetUiOldDan(self._worldBossData.boss_mission_id)
    if self._oldDan and 0 <= self._oldDan then
    else
      self._oldDan = self._curDan
      self._oldRank = self._curRank
    end
    self._newDan = self._curDan
    self._newRank = self._curRank
    if not bInit then
      self._oldDan = self._curDan
      self._oldRank = self._curRank
    end
    self._curDanAreaGoForAnim:SetActive(true)
    self:_CheckDoBadgeAnim()
    self._worldBossModule:SetUiOldDan(self._curDan, self._curRank, self._worldBossData.boss_mission_id)
  else
    UIWorldBossHelper.InitDanBadge(self._danBadgeGen, self._danBadgeGenGo, self._danBadgeGenRect, self._curDan, self._curRank)
    self:_FillDanName(self._curDan, self._curRank)
  end
  local showAnim = false
  if bInit and showAnim then
    local te = GameGlobal.Timer():AddEvent(1, function()
      local duration = 0.5
      DoTweenHelper.DoUpdateInt(0, self._worldBossData.max_total_damage, duration, function(val)
        local damage = math.floor(val)
        self._maxScoreValue:SetText(UIActivityHelper.AddZeroFrontNum(8, damage))
      end)
    end)
    table.insert(self._timeEvents, te)
  else
    self._maxScoreValue:SetText(UIActivityHelper.AddZeroFrontNum(8, self._worldBossData.max_total_damage))
  end
  self:_RefreshTimeInfo()
  self._curSelectTeamIndex = 0
  self:_RefreshCurDamage(bInit)
  self:_RefreshTeam()
  self:_ClickTeam(self._defaultSelectTeamIndex, self._defaultDan, bInit)
  self:_CheckShowDanResult()
  self:_RefreshType()
end

function UIWorldBossController:_RefreshTimeInfo()
  local remainTime = self._worldBossData.end_time - self._svrTimeModule:GetServerTime() * 0.001
  if remainTime < 0 and 0 < self._worldBossData.boss_mission_id then
    self._danResulting = true
  else
    self._danResulting = false
  end
  self.overTimeGo:SetActive(self._danResulting)
  self.remaintimeGo:SetActive(not self._danResulting)
  if self._danResulting then
  else
    self._remainingTime:SetText(self:_GetRemainTime(remainTime))
  end
  self._challengeBtnLock:SetActive(self._danResulting)
  self._challengeArrow:SetActive(not self._danResulting)
end

function UIWorldBossController:_RefreshCurDamage(bInit)
  local curDamage = self:_CalcCurDamage()
  local showAnim = false
  if bInit and showAnim then
    local te = GameGlobal.Timer():AddEvent(1, function()
      local duration = 0.5
      DoTweenHelper.DoUpdateInt(0, curDamage, duration, function(val)
        local damage = math.floor(val)
        self._curScoreValue:SetText(UIActivityHelper.AddZeroFrontNum(8, damage))
      end)
    end)
    table.insert(self._timeEvents, te)
  else
    self._curScoreValue:SetText(UIActivityHelper.AddZeroFrontNum(8, curDamage))
  end
end

function UIWorldBossController:_CalcCurDamage()
  local damage = 0
  if 0 < #self._worldBossData.formation_info.formation_list then
    for key, value in pairs(self._worldBossData.formation_info.formation_list) do
      damage = damage + value.formation_damage
    end
  end
  return damage
end

function UIWorldBossController:_CreateTeam()
  local missionId = self._worldBossData.boss_mission_id
  local cfg_formation = Cfg.cfg_world_boss_formation({MissionId = missionId})
  local teamCount = #cfg_formation
  self._team:SpawnObjects("UIWorldBossTeam", teamCount)
  self._allTeam = self._team:GetAllSpawnList()
  local curDanLevel = UIWorldBossHelper.GetCurDanLevel(self._curDan)
  local preSelectTeamIndex = self._worldBossModule:GetCurSelectTeamIndex()
  for i = 1, teamCount do
    if i == preSelectTeamIndex and curDanLevel >= cfg_formation[i].NeedDan then
      self._defaultSelectTeamIndex = i
      self._defaultDan = cfg_formation[i].NeedDan
    end
    self._allTeam[i]:SetData(i, cfg_formation[i].NeedDan, function(index, dan)
      self:_ClickTeam(index, dan, false)
    end)
  end
end

function UIWorldBossController:_RefreshTeam()
  for key, value in pairs(self._allTeam) do
    value:Refresh(self._curDan)
  end
end

function UIWorldBossController:_CreatePets()
  self._pets:SpawnObjects("UIWorldBossPet", self._maxPetsCount)
  self._allPets = self._pets:GetAllSpawnList()
  for i = 1, self._maxPetsCount do
    self._allPets[i]:SetData(0)
  end
end

function UIWorldBossController:_ClickTeam(index, dan, bInit)
  if self._curSelectTeamIndex == index then
    return
  end
  local curDanLevel = UIWorldBossHelper.GetCurDanLevel(self._curDan)
  if dan > curDanLevel then
    local cfg = Cfg.cfg_world_boss_dan({
      MissionID = self._worldBossData.boss_mission_id,
      DanLevel = dan
    })
    if cfg then
      ToastManager.ShowToast(StringTable.Get("str_world_boss_team_lock", StringTable.Get(cfg[1].DanName)))
    end
    return
  end
  self._curSelectTeamIndex = index
  self._worldBossModule:SetCurSelectTeamIndex(self._curSelectTeamIndex)
  self:_SetTeamBtnMark(self._curSelectTeamIndex)
  self:_RefreshPets(self._curSelectTeamIndex)
  self:_RefreshCurTeamDamage(self._curSelectTeamIndex, bInit)
end

function UIWorldBossController:_SetTeamBtnMark(index)
  for key, value in pairs(self._allTeam) do
    value:SetSelectMark(key == index)
  end
end

function UIWorldBossController:_RefreshPets(index)
  local teamRecord = self:_GetTeamRecordByIndex(index)
  for key, value in pairs(self._allPets) do
    local pstId = 0
    if teamRecord and key <= #teamRecord.pet_list then
      pstId = teamRecord.pet_list[key]
    end
    value:SetData(pstId)
  end
end

function UIWorldBossController:_RefreshCurTeamDamage(index, bInit)
  local damage = 0
  local record = self:_GetTeamRecordByIndex(index)
  if record then
    damage = record.formation_damage
  end
  local showAnim = false
  if bInit and showAnim then
    local te = GameGlobal.Timer():AddEvent(1, function()
      local duration = 0.5
      DoTweenHelper.DoUpdateInt(0, damage, duration, function(val)
        local tmpDamage = math.floor(val)
        self._teamScoreValue:SetText(UIActivityHelper.AddZeroFrontNum(8, tmpDamage))
      end)
    end)
    table.insert(self._timeEvents, te)
  else
    self._teamScoreValue:SetText(UIActivityHelper.AddZeroFrontNum(8, damage))
  end
end

function UIWorldBossController:_GetTeamRecordByIndex(index)
  return self._worldBossModule:GetRecordByTeamIndex(index)
end

function UIWorldBossController:ResetBtnOnClick(go)
  if self._danResulting then
    ToastManager.ShowToast(StringTable.Get("str_world_boss_dan_resulting"))
    return
  end
  local record = self:_GetTeamRecordByIndex(self._curSelectTeamIndex)
  if not record then
    return
  end
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, StringTable.Get("str_activity_common_notice_title"), StringTable.Get("str_world_boss_reset_tips"), function()
    self:StartTask(function(TT)
      local res = self._worldBossModule:ReqResetRecord(TT, self._curSelectTeamIndex)
      if res:GetSucc() then
        self:_RefreshPets(self._curSelectTeamIndex)
        self:_RefreshCurDamage(false)
        self:_RefreshCurTeamDamage(self._curSelectTeamIndex, false)
      end
    end, self)
  end, nil)
end

function UIWorldBossController:ChallengeBtnOnClick(go)
  if self._danResulting then
    ToastManager.ShowToast(StringTable.Get("str_world_boss_can_not_challenge"))
    return
  end
  local bossMissionId = self._worldBossData.boss_mission_id
  local cfg = Cfg.cfg_world_boss_mission[bossMissionId]
  if cfg.SelectDiff then
    self:ShowDialog("UIWorldBossDiffSelectController", bossMissionId, function(index)
      self._worldBossModule:SetBossLevelDifficultyIndex(index)
      self:StartTask(function(TT)
        local team = self:_GetTeamByIndex(self._curSelectTeamIndex)
        local res = self._worldBossModule:ReqWorldBossChangeFormationInfo(TT, team[1].pet_list)
        if res:GetSucc() then
          self:_ShowUITeams(team)
        end
      end, self)
    end)
  else
    self._worldBossModule:SetBossLevelDifficultyIndex(1)
    self:StartTask(function(TT)
      local team = self:_GetTeamByIndex(self._curSelectTeamIndex)
      local res = self._worldBossModule:ReqWorldBossChangeFormationInfo(TT, team[1].pet_list)
      if res:GetSucc() then
        self:_ShowUITeams(team)
      end
    end, self)
  end
end

function UIWorldBossController:_ShowUITeams(team)
  local ctx = self._missionModule:TeamCtx()
  ctx:InitWorldBossTeams(team)
  ctx:Init(TeamOpenerType.WorldBoss, {
    self._worldBossData.boss_mission_id
  })
  self:Lock("DoEnterTeam")
  ctx:ShowDialogUITeams()
end

function UIWorldBossController:_GetTeamByIndex(index)
  local team = {
    {}
  }
  local record = self:_GetTeamRecordByIndex(index)
  if record then
    team[1].id = 1
    team[1].pet_list = record.pet_list
  else
    team[1].id = 1
    team[1].pet_list = {
      0,
      0,
      0,
      0,
      0
    }
  end
  return team
end

function UIWorldBossController:EnemyInfoBtnOnClick(go)
  if table.count(self._bossIds) > 0 then
    self:ShowDialog("UIEnemyTip", self._bossIds)
  end
end

function UIWorldBossController:DanDetailBtnOnClick(go)
  self:ShowDialog("UIWorldBossDanDetailController", self._worldBossData.boss_mission_id, function(missionId, curDan, curRank)
    self:_RefreshDanInfo(missionId, curDan, curRank)
    self:_RefreshTimeInfo()
  end, function()
    self:_ShowFuncUi(false)
  end, self._isEliminate)
end

function UIWorldBossController:DanDetailBtn1OnClick(go)
  self:ShowDialog("UIWorldBossDanDetailController", self._worldBossData.boss_mission_id, function(missionId, curDan, curRank)
    self:_RefreshDanInfo(missionId, curDan, curRank)
    self:_RefreshTimeInfo()
  end, function()
    self:_ShowFuncUi(false)
  end)
end

function UIWorldBossController:_RefreshDanInfo(missionId, curDan, curRank)
  self:_ShowFuncUi(true)
  if self._worldBossData.boss_mission_id == missionId and (self._curDan ~= curDan or self._curRank ~= curRank) then
    UIWorldBossHelper.InitDanBadge(self._danBadgeGen, self._danBadgeGenGo, self._danBadgeGenRect, curDan, curRank)
    local danName = UIWorldBossHelper.GetDanName(curDan, curRank)
    self._danName:SetText(StringTable.Get(danName))
  end
end

function UIWorldBossController:_Close()
  if self:Manager():CurUIStateType() == UIStateType.UIWorldBoss then
    self:SwitchState(UIStateType.UIDiscovery)
  else
    self:CloseDialog()
  end
end

function UIWorldBossController:_GetRemainTime(time)
  local day, hour, minute
  day = math.floor(time / 86400)
  hour = math.floor(time / 3600) % 24
  minute = math.floor(time / 60) % 60
  local timestring = ""
  if 0 < day then
    timestring = day .. StringTable.Get("str_activity_common_day") .. hour .. StringTable.Get("str_activity_common_hour")
  elseif 0 < hour then
    timestring = hour .. StringTable.Get("str_activity_common_hour") .. minute .. StringTable.Get("str_activity_common_minute")
  elseif 0 < minute then
    timestring = minute .. StringTable.Get("str_activity_common_minute")
  else
    timestring = StringTable.Get("str_activity_common_less_minute")
  end
  return string.format(StringTable.Get("str_activity_common_over"), timestring)
end

function UIWorldBossController:_GetBossCfg(levelId)
  local cfg
  local cfg_world_boss_mission = Cfg.cfg_world_boss_mission[levelId]
  if not cfg_world_boss_mission then
    return cfg
  end
  local cfg_level = Cfg.cfg_level[cfg_world_boss_mission.FightLevel[1]]
  if not cfg_level then
    return cfg
  end
  local cfg_monster_wave = Cfg.cfg_monster_wave[cfg_level.MonsterWave[1]]
  if not cfg_monster_wave then
    return cfg
  end
  local cfg_refresh = Cfg.cfg_refresh[cfg_monster_wave.WaveBeginRefreshID]
  if not cfg_refresh then
    return cfg
  end
  local cfg_refresh_monster = Cfg.cfg_refresh_monster[cfg_refresh.MonsterRefreshIDList[1]]
  if not cfg_refresh_monster then
    return cfg
  end
  local cfg_monster = Cfg.cfg_monster
  local cfg_monster_class = Cfg.cfg_monster_class
  local monster_list = {}
  for key, value in pairs(cfg_refresh_monster.MonsterIDList) do
    local cfg_monster_temp = cfg_monster[value]
    if cfg_monster_temp then
      table.insert(monster_list, cfg_monster_temp)
    end
  end
  for key, value in pairs(cfg_refresh_monster.MonsterIDList) do
    local cfg_monster_temp = cfg_monster[value]
    if cfg_monster_temp then
      local cfg_monster_class_temp = cfg_monster_class[cfg_monster_temp.ClassID]
      if cfg_monster_class_temp and cfg_monster_class_temp.MonsterType == MonsterType.WorldBoss then
        cfg = cfg_monster_class_temp
        return cfg, cfg_monster_temp, monster_list
      end
    end
  end
  return cfg, nil, nil
end

function UIWorldBossController:_CheckShowDanResult()
  local preMissionId = LocalDB.GetInt("UIWorldBossDanResult" .. self._loginModule:GetRoleShowID(), 0)
  local preDan = self._roleModule:GetWorldBossRecordDan()
  local preRand = self._roleModule:GetWorldBossRecordRank()
  local isTopUI = GameGlobal.UIStateManager():IsTopUI("UIWorldBossController")
  if isTopUI and preMissionId ~= self._worldBossData.boss_mission_id and 0 < preDan then
    local danName = UIWorldBossHelper.GetDanName(preDan, preRand)
    self:ShowDialog("UIWorldBossDanResult", preDan, preRand, danName, self._worldBossData.boss_mission_id)
  end
end

function UIWorldBossController:_ShowFuncUi(bShow)
  for index, value in ipairs(self._needHideGos) do
    value:SetActive(bShow)
  end
end

function UIWorldBossController:FlushRedQuest()
  local showRedDot = self._worldBossModule:QuestHaveRedPoint()
  if self._redQuest.gameObject.activeSelf ~= showRedDot then
    self._redQuest.gameObject:SetActive(showRedDot)
  end
  if showRedDot and self._redQuestSpawn == nil then
    self._redQuestSpawn = self._redQuest:SpawnOneObject("ManualLoad0")
  end
end

function UIWorldBossController:_RefreshType()
  local bossNameRect = self:GetUIComponent("RectTransform", "BossName")
  if self._isEliminate then
    self._eliminateTip:SetActive(true)
    self._bossName.fontSizeMax = 96
    bossNameRect.anchoredPosition = Vector2(105, -248)
  else
    self._eliminateTip:SetActive(false)
    self._bossName.fontSizeMax = 128
    bossNameRect.anchoredPosition = Vector2(105, -232)
  end
end

function UIWorldBossController:TaskBtnOnClick(go)
  self:ShowDialog("UIWorldBossQuest")
end

function UIWorldBossController:ShopBtnOnClick(go)
  local jumpModule = self:GetModule(QuestModule).uiModule
  local jumpType = UIJumpType.UI_JumpMall
  local jumpParam = {
    2,
    2,
    12
  }
  jumpModule:SetJumpUIData(jumpType, jumpParam)
  jumpModule:Jump()
end

function UIWorldBossController:GuideVideoOnClick()
  self:ShowDialog("UIGuideVideoController", 1, true)
end

function UIWorldBossController:MultiAwardsOnClick(go)
  ToastManager.ShowToast(StringTable.Get("str_world_boss_multi_tips"))
end
