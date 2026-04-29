_class("UIN25IdolCollection", UIController)
UIN25IdolCollection = UIN25IdolCollection

function UIN25IdolCollection:InitData()
  self._idEndCG = 1
  self._idMemory = 2
  self._idAchieve = 3
  self._idEndingA = 0
  self._idEndingB = 0
  self._idEndingC = 0
  local comCfgID = self._idolComponent:GetComponentCfgId()
  local name = {
    "_idEndingA",
    "_idEndingB",
    "_idEndingC"
  }
  local allEnding = Cfg.cfg_component_idol_ending({ComponentID = comCfgID})
  local index = 1
  table.sort(allEnding, function(a, b)
    return a.EndingId < b.EndingId
  end)
  for i, v in ipairs(allEnding) do
    self[name[index]] = i
    index = index + 1
  end
  if index ~= 4 then
    BuildError("###偶像养成结局只有三种，cfg_component_idol_ending配置错误")
  end
  self._idEndingID = self._idEndingA
  self._idSheetID = self._idAchieve
end

function UIN25IdolCollection:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign.New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N25, ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL)
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._idolComponent = self._localProcess:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL)
  self:InitData()
end

function UIN25IdolCollection:OnShow(uiParams)
  self._atlas = self:GetAsset("UIN25Idol.spriteatlas", LoadType.SpriteAtlas)
  self._uiWidget = self:GetUIComponent("RectTransform", "uiWidget")
  self._uiShow = self:GetUIComponent("RectTransform", "uiShow")
  self._itemInfo = self:GetUIComponent("UISelectObjectPath", "itemInfo")
  self._tips = self._itemInfo:SpawnObject("UIN25SelectInfo")
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "ltBtn")
  self._lockedEndCG = self:GetUIComponent("RectTransform", "lockedEndCG")
  self._unlockEndCG = self:GetUIComponent("RectTransform", "unlockEndCG")
  self._imgEndingCG = self:GetUIComponent("RawImage", "imgEndingCG")
  self._imgEndingCGLoader = self:GetUIComponent("RawImageLoader", "imgEndingCG")
  self._imgEndingCGFull = self:GetUIComponent("RawImage", "imgEndingCGFull")
  self._imgEndingCGFullLoader = self:GetUIComponent("RawImageLoader", "imgEndingCGFull")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._txtEndingDesc = self:GetUIComponent("UILocalizationText", "txtEndingDesc")
  self._maskEndingCGFull = self:GetUIComponent("RectTransform", "maskEndingCGFull")
  self._memoryContent = self:GetUIComponent("UISelectObjectPath", "memoryContent")
  self._achieveContent = self:GetUIComponent("UISelectObjectPath", "achieveContent")
  self._txtEndingTitle = self:GetUIComponent("UILocalizationText", "txtEndingTitle")
  self._groupEnding = self:GetUIComponent("RectTransform", "groupEnding")
  self._contentEndCG = self:GetUIComponent("RectTransform", "contentEndCG")
  self._contentMemory = self:GetUIComponent("RectTransform", "contentMemory")
  self._contentAchieve = self:GetUIComponent("RectTransform", "contentAchieve")
  self._srMemory = self:GetChildComponent(self._contentMemory, "ScrollRect", "Scroll View")
  self._srAchieve = self:GetChildComponent(self._contentAchieve, "ScrollRect", "Scroll View")
  self._tglEndCG = self:GetUIComponent("Toggle", "tglEndCG")
  self._tglMemory = self:GetUIComponent("Toggle", "tglMemory")
  self._tglAchieve = self:GetUIComponent("Toggle", "tglAchieve")
  self._tglEndA = self:GetUIComponent("Toggle", "tglA")
  self._tglEndB = self:GetUIComponent("Toggle", "tglB")
  self._tglEndC = self:GetUIComponent("Toggle", "tglC")
  self._tglSheet = {
    [self._idEndCG] = {
      tgl = self._tglEndCG,
      txtUncheck = self:GetChildComponent(self._tglEndCG, "UILocalizationText", "02/txtUncheck"),
      txtChecked = self:GetChildComponent(self._tglEndCG, "UILocalizationText", "02/txtChecked"),
      content = {
        self._groupEnding,
        self._contentEndCG
      },
      fnGetRedDot = N25IdolCollectionReddot.GetEndCGReddot,
      redDot = self:GetChildComponent(self._tglEndCG, "UISelectObjectPath", "02/reddot"),
      redDotSpawn = nil
    },
    [self._idMemory] = {
      tgl = self._tglMemory,
      txtUncheck = self:GetChildComponent(self._tglMemory, "UILocalizationText", "03/txtUncheck"),
      txtChecked = self:GetChildComponent(self._tglMemory, "UILocalizationText", "03/txtChecked"),
      content = {
        self._contentMemory
      },
      fnGetRedDot = N25IdolCollectionReddot.GetMemoryReddot,
      redDot = self:GetChildComponent(self._tglMemory, "UISelectObjectPath", "03/reddot"),
      redDotSpawn = nil
    },
    [self._idAchieve] = {
      tgl = self._tglAchieve,
      txtUncheck = self:GetChildComponent(self._tglAchieve, "UILocalizationText", "01/txtUncheck"),
      txtChecked = self:GetChildComponent(self._tglAchieve, "UILocalizationText", "01/txtChecked"),
      content = {
        self._contentAchieve
      },
      fnGetRedDot = N25IdolCollectionReddot.GetAchieveReddot,
      redDot = self:GetChildComponent(self._tglAchieve, "UISelectObjectPath", "01/reddot"),
      redDotSpawn = nil
    }
  }
  self._tglEnding = {
    [self._idEndingA] = {
      tgl = self._tglEndA,
      title = self:GetChildComponent(self._tglEndA, "UILocalizationText", "txtEnding"),
      titleChk = self:GetChildComponent(self._tglEndA, "UILocalizationText", "txtEndingChk"),
      redDot = self:GetChildComponent(self._tglEndA, "UISelectObjectPath", "redEnding"),
      redDotSpawn = nil
    },
    [self._idEndingB] = {
      tgl = self._tglEndB,
      title = self:GetChildComponent(self._tglEndB, "UILocalizationText", "txtEnding"),
      titleChk = self:GetChildComponent(self._tglEndB, "UILocalizationText", "txtEndingChk"),
      redDot = self:GetChildComponent(self._tglEndB, "UISelectObjectPath", "redEnding"),
      redDotSpawn = nil
    },
    [self._idEndingC] = {
      tgl = self._tglEndC,
      title = self:GetChildComponent(self._tglEndC, "UILocalizationText", "txtEnding"),
      titleChk = self:GetChildComponent(self._tglEndC, "UILocalizationText", "txtEndingChk"),
      redDot = self:GetChildComponent(self._tglEndC, "UISelectObjectPath", "redEnding"),
      redDotSpawn = nil
    }
  }
  self._reddot = N25IdolCollectionReddot:New()
  self._idEndingID = self._idEndingA
  self._tglEnding[self._idEndingID].tgl.isOn = true
  self:CreateMemoryPool()
  self:CreateAchievePool()
  self:EnterFullScreenBg(false)
  self:EnterFullScreenCg(false)
  self:InitCommonTopButton()
  self:OnShowSheet(self._idSheetID)
  self:FlushEnding()
  self:FlushMemory(true)
  self:FlushAchieve(true)
  self:FlushRedDot()
  self:DiffLanguage()
end

function UIN25IdolCollection:OnHide()
end

function UIN25IdolCollection:GetRedDot()
  return self._reddot
end

function UIN25IdolCollection:GetAtlas()
  return self._atlas
end

function UIN25IdolCollection:GetChildComponent(parent, componentTypeName, name)
  local child = parent.transform:Find(name)
  if child == nil then
    return nil
  end
  return child:GetComponent(componentTypeName)
end

function UIN25IdolCollection:CreateMemoryPool()
  local comCfgID = self._idolComponent:GetComponentCfgId()
  local allEvents = Cfg.cfg_component_idol_event({ComponentID = comCfgID})
  local poolData = {}
  for k, v in pairs(allEvents) do
    if v.PetId ~= nil then
      table.insert(poolData, v)
    end
  end
  local countEvents = #poolData
  self._memoryPoolData = poolData
  self._memoryPool = self._memoryContent:SpawnObjects("UIN25IdolMemoryDetails", countEvents)
end

function UIN25IdolCollection:CreateAchievePool()
  local comCfgID = self._idolComponent:GetComponentCfgId()
  local allAchieves = Cfg.cfg_component_idol_achieve({ComponentID = comCfgID})
  local poolData = {}
  for k, v in pairs(allAchieves) do
    table.insert(poolData, v)
  end
  local countAchieves = #poolData
  self._achievePoolData = poolData
  self._achievePool = self._achieveContent:SpawnObjects("UIN25IdolAchieveDetails", countAchieves)
end

function UIN25IdolCollection:EnterFullScreenBg(isEnter)
  self._uiWidget.gameObject:SetActive(not isEnter)
  self._uiShow.gameObject:SetActive(isEnter)
end

function UIN25IdolCollection:EnterFullScreenCg(isEnter)
  self._maskEndingCGFull.gameObject:SetActive(isEnter)
end

function UIN25IdolCollection:InitCommonTopButton()
  self._backBtns = self._ltBtn:SpawnObject("UINewCommonTopButton")
  self._backBtns:SetData(function()
    local lockName = "UIN25IdolCollection:_backAnim"
    self:StartTask(function(TT)
      self:CallUIMethod("UIN25IdolLogin", "OnCollectionBack", true)
      self:Lock(lockName)
      self._animation:Play("uieff_UIN25IdolCollection_contengroup_out")
      YIELD(TT, 233)
      self:UnLock(lockName)
      self._reddot:ClearNew()
      self:CloseDialog()
    end)
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end, true, nil, function()
    self:EnterFullScreenBg(true)
  end)
end

function UIN25IdolCollection:OnShowSheetTask(animName, animLength, fnStartPerform, fnEndPerform)
  local lockName = "UIN25IdolCollection:_showSheetAnim"
  self:StartTask(function(TT)
    fnStartPerform()
    self:Lock(lockName)
    self._animation:Play(animName)
    YIELD(TT, animLength)
    self:UnLock(lockName)
    YIELD(TT, 20)
    fnEndPerform()
  end)
end

function UIN25IdolCollection:OnPreShowSheet(sheetKey)
  self._idSheetID = sheetKey
  local displaySheet = self._tglSheet[sheetKey]
  if displaySheet == nil then
    return
  end
  for k, v in pairs(self._tglSheet) do
    v.tgl.isOn = false
  end
  displaySheet.tgl.isOn = true
  for k, tr in pairs(displaySheet.content) do
    tr.gameObject:SetActive(true)
  end
  for k, v in pairs(self._tglSheet) do
    v.txtUncheck.gameObject:SetActive(not v.tgl.isOn)
    v.txtChecked.gameObject:SetActive(v.tgl.isOn)
  end
end

function UIN25IdolCollection:OnShowSheet(sheetKey)
  self._idSheetID = sheetKey
  local displaySheet = self._tglSheet[sheetKey]
  if displaySheet == nil then
    return
  end
  for k, v in pairs(self._tglSheet) do
    v.tgl.isOn = false
  end
  displaySheet.tgl.isOn = true
  for k, v in pairs(self._tglSheet) do
    v.txtUncheck.gameObject:SetActive(not v.tgl.isOn)
    v.txtChecked.gameObject:SetActive(v.tgl.isOn)
    for k, tr in pairs(v.content) do
      tr.gameObject:SetActive(v.tgl.isOn)
    end
  end
end

function UIN25IdolCollection:DiffLanguage()
  local txtUncheck = self._tglSheet[self._idEndCG].txtUncheck
  local txtChecked = self._tglSheet[self._idEndCG].txtChecked
  local language = Localization.GetCurLanguage()
  if LanguageType.us == language then
    txtUncheck.fontSize = 35
    txtChecked.fontSize = 35
  else
    txtUncheck.fontSize = 45
    txtChecked.fontSize = 45
  end
end

function UIN25IdolCollection:FlushRedDot()
  if self._reddot == nil then
    self._reddot = N25IdolCollectionReddot:New()
  end
  for k, v in pairs(self._tglSheet) do
    local showRedDot = v.fnGetRedDot(self._reddot)
    v.redDot.gameObject:SetActive(showRedDot)
    if showRedDot and v.redDotSpawn == nil then
      v.redDotSpawn = v.redDot:SpawnOneObject("ManualLoad0")
    end
  end
  for k, v in pairs(self._tglEnding) do
    local showRedDot = self._reddot:GetEndCGTitleReddot(k)
    v.redDot.gameObject:SetActive(showRedDot)
    if showRedDot and v.redDotSpawn == nil then
      v.redDotSpawn = v.redDot:SpawnOneObject("ManualLoad0")
    end
  end
  for k, v in pairs(self._memoryPool) do
    local showRedDot = self._reddot:GetMemoryTitleReddot(v:ID())
    v:SetRedDot(showRedDot)
  end
  for k, v in pairs(self._achievePool) do
    local showRedDot = self._reddot:GetAchieveTitleReddot(v:ID())
    v:SetRedDot(showRedDot)
    local showRedDot = self._reddot:GetAchieveRewardReddot(v:ID())
    v:SetRewardRedDot(showRedDot)
  end
end

function UIN25IdolCollection:FlushEnding()
  local unlocked = self._reddot:GetEndCGUnlocked()
  local allEnding = Cfg.cfg_component_idol_ending({})
  for k, v in pairs(self._tglEnding) do
    v.tgl.isOn = k == self._idEndingID
    v.title.gameObject:SetActive(not v.tgl.isOn)
    v.titleChk.gameObject:SetActive(v.tgl.isOn)
    local cfg = allEnding[k]
    local endCGTitle = ""
    local endCGDesc = ""
    if unlocked[k] ~= nil then
      endCGTitle = StringTable.Get(cfg.Name)
      endCGDesc = StringTable.Get(allEnding[self._idEndingID].DescriptionTxt)
    else
      endCGTitle = StringTable.Get("str_n25_idol_y_coll_unlock_ending_title")
      endCGDesc = StringTable.Get("str_n25_idol_y_coll_unlock_ending_desc")
    end
    v.title:SetText(endCGTitle)
    v.titleChk:SetText(endCGTitle)
    if k == self._idEndingID then
      self._txtEndingTitle:SetText(endCGTitle)
      self._txtEndingDesc:SetText(endCGDesc)
    end
  end
  if unlocked[self._idEndingID] ~= nil then
    self._lockedEndCG.gameObject:SetActive(false)
    self._unlockEndCG.gameObject:SetActive(true)
  else
    self._lockedEndCG.gameObject:SetActive(true)
    self._unlockEndCG.gameObject:SetActive(false)
  end
  if unlocked[self._idEndingID] ~= nil then
    local cfg = allEnding[self._idEndingID]
    self._imgEndingCGLoader:LoadImage(cfg.CgDrawing)
    self._imgEndingCGFullLoader:LoadImage(cfg.CgPreview)
    self:FlushEndingCGImage(self._imgEndingCG, cfg.CgDrawingTransform)
    self:FlushEndingCGImage(self._imgEndingCGFull, cfg.CgPreviewTransform)
  end
end

function UIN25IdolCollection:FlushEndingCGImage(rawImage, cfgTransform)
  if cfgTransform == nil then
    return
  end
  local localPosition = Vector2.zero
  local localScale = Vector3.one
  local transform = rawImage.transform
  local sizeDelta = Vector2(2048, 2048)
  if 5 <= #cfgTransform then
    sizeDelta = Vector2(cfgTransform[4], cfgTransform[5])
  end
  if 3 <= #cfgTransform then
    localPosition = Vector3(cfgTransform[1], cfgTransform[2], 0)
    localScale = Vector3(cfgTransform[3], cfgTransform[3], 1)
  end
  transform.sizeDelta = sizeDelta
  transform.localPosition = localPosition
  transform.localScale = localScale
end

function UIN25IdolCollection:FlushMemory(reorder)
  if reorder then
    local unlocked = self._reddot:GetMemoryUnlocked()
    table.sort(self._memoryPoolData, function(a, b)
      local unlockedA = unlocked[a.ID] ~= nil
      local unlockedB = unlocked[b.ID] ~= nil
      if unlockedA and not unlockedB then
        return true
      elseif not unlockedA and unlockedB then
        return false
      else
        return a.ID < b.ID
      end
    end)
  end
  for k, v in pairs(self._memoryPoolData) do
    local ui = self._memoryPool[k]
    ui:SetData(self, v)
  end
end

function UIN25IdolCollection:FlushAchieve(reorder)
  if reorder then
    local canRecv = 1
    local locked = 2
    local recved = 3
    local unlocked = self._reddot:GetAchieveUnlocked()
    table.sort(self._achievePoolData, function(a, b)
      local stateA = unlocked[a.ID]
      local stateB = unlocked[b.ID]
      if stateA == nil then
        stateA = locked
      elseif stateA == IdolAchieveState.IdolAchieveState_CanRecv then
        stateA = canRecv
      elseif stateA == IdolAchieveState.IdolAchieveState_Recved then
        stateA = recved
      end
      if stateB == nil then
        stateB = locked
      elseif stateB == IdolAchieveState.IdolAchieveState_CanRecv then
        stateB = canRecv
      elseif stateB == IdolAchieveState.IdolAchieveState_Recved then
        stateB = recved
      end
      if stateA ~= stateB then
        return stateA < stateB
      else
        return a.ID < b.ID
      end
    end)
  end
  for k, v in pairs(self._achievePoolData) do
    local ui = self._achievePool[k]
    ui:SetData(self, v)
  end
end

function UIN25IdolCollection:OnMemoryDetails(cfg)
  local unlocked = self._reddot:GetMemoryUnlocked()
  if unlocked[cfg.ID] == nil then
    local message = StringTable.Get("str_n25_idol_y_coll_unlock_event")
    ToastManager.ShowToast(message)
  else
    self:ShowDialog("UIN25IdolStoryController", cfg.StoryId, function()
    end, true)
    self._reddot:AddViewedMemory(cfg.ID, true)
    self:FlushRedDot()
  end
end

function UIN25IdolCollection:OnAchieveDetails(cfg)
  local unlocked = self._reddot:GetAchieveUnlocked()
  local achieveState = unlocked[cfg.ID]
  if achieveState == nil then
    local message = StringTable.Get("str_n25_idol_y_coll_unlock_achiev")
    ToastManager.ShowToast(message)
  elseif achieveState == IdolAchieveState.IdolAchieveState_CanRecv then
    self:Lock("UIN25IdolCollection:OnGetAchieveRewardTask")
    self:StartTask(self.OnGetAchieveRewardTask, self, cfg.ID)
  elseif achieveState == IdolAchieveState.IdolAchieveState_Recved then
  end
end

function UIN25IdolCollection:OnShowItemInfo(matid, pos)
  self._tips:SetData(matid, pos)
end

function UIN25IdolCollection:BtnUiShowOnClick(go)
  self:EnterFullScreenBg(false)
end

function UIN25IdolCollection:TglEndCGOnClick(go)
  local animCfg = {
    [self._idAchieve] = {
      "uieff_UIN25IdolCollection_contengroup_AchievetoCG",
      533
    },
    [self._idMemory] = {
      "uieff_UIN25IdolCollection_contengroup_MemorytoCG",
      533
    }
  }
  local anim = animCfg[self._idSheetID]
  if anim == nil then
    return
  end
  self:OnShowSheetTask(anim[1], anim[2], function()
    self:OnPreShowSheet(self._idEndCG)
  end, function()
    self:OnShowSheet(self._idEndCG)
  end)
end

function UIN25IdolCollection:TglMemoryOnClick(go)
  local animCfg = {
    [self._idAchieve] = {
      "uieff_UIN25IdolCollection_contengroup_AchievetoMemory",
      800
    },
    [self._idEndCG] = {
      "uieff_UIN25IdolCollection_contengroup_CGtoMemory",
      967
    }
  }
  local anim = animCfg[self._idSheetID]
  if anim == nil then
    return
  end
  self:OnShowSheetTask(anim[1], anim[2], function()
    self._srMemory.verticalNormalizedPosition = 1
    self:FlushMemory(true)
    self:OnPreShowSheet(self._idMemory)
  end, function()
    self:OnShowSheet(self._idMemory)
  end)
end

function UIN25IdolCollection:TglAchieveOnClick(go)
  local animCfg = {
    [self._idEndCG] = {
      "uieff_UIN25IdolCollection_contengroup_CGtoAchieve",
      667
    },
    [self._idMemory] = {
      "uieff_UIN25IdolCollection_contengroup_MemorytoAchieve",
      667
    }
  }
  local anim = animCfg[self._idSheetID]
  if anim == nil then
    return
  end
  self:OnShowSheetTask(anim[1], anim[2], function()
    self._srAchieve.verticalNormalizedPosition = 1
    self:FlushAchieve(true)
    self:OnPreShowSheet(self._idAchieve)
  end, function()
    self:OnShowSheet(self._idAchieve)
  end)
end

function UIN25IdolCollection:TglAOnClick(go)
  self._idEndingID = self._idEndingA
  self:FlushEnding()
  self._reddot:AddViewedEngCG(self._idEndingID, true)
  self:FlushRedDot()
end

function UIN25IdolCollection:TglBOnClick(go)
  self._idEndingID = self._idEndingB
  self:FlushEnding()
  self._reddot:AddViewedEngCG(self._idEndingID, true)
  self:FlushRedDot()
end

function UIN25IdolCollection:TglCOnClick(go)
  self._idEndingID = self._idEndingC
  self:FlushEnding()
  self._reddot:AddViewedEngCG(self._idEndingID, true)
  self:FlushRedDot()
end

function UIN25IdolCollection:BtnCGFullScreenOnClick(go)
  self:EnterFullScreenCg(true)
  self._reddot:AddViewedEngCG(self._idEndingID, true)
  self:FlushRedDot()
end

function UIN25IdolCollection:BtnCloseEndingCGFullOnClick(go)
  self:EnterFullScreenCg(false)
end

function UIN25IdolCollection:PopupAchieveReward(achieveId)
  local allAchieves = Cfg.cfg_component_idol_achieve({})
  local cfg = allAchieves[achieveId]
  if cfg == nil then
    return
  end
  local assetAwards = {}
  for k, v in pairs(cfg.RewardList) do
    if 2 <= #v then
      local roleAsset = RoleAsset:New()
      roleAsset.assetid = v[1]
      roleAsset.count = v[2]
      table.insert(assetAwards, roleAsset)
    end
  end
  self:ShowDialog("UIN25IdolGetItem", assetAwards, function()
  end)
end

function UIN25IdolCollection:OnGetAchieveRewardTask(TT, achieveId)
  local idolComponent = self._reddot:GetIdolComponent()
  local res = AsyncRequestRes:New()
  idolComponent:HandleIdolGetAchieveReward(TT, res, achieveId)
  if not res:GetSucc() then
    local errorContent = string.format("偶像养成领取奖励失败，code=%d, id=%d", res:GetResult(), achieveId)
    ToastManager.ShowToast(errorContent)
  else
    self._reddot:AddViewedAchieve(achieveId, true)
    self._reddot:FlushUnlocked()
    self:FlushRedDot()
    self:FlushAchieve(false)
    self:PopupAchieveReward(achieveId)
  end
  self:UnLock("UIN25IdolCollection:OnGetAchieveRewardTask")
end
