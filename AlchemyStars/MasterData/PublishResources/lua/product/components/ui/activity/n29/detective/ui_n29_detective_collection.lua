require("ui_select_info")
_class("UIN29DetectiveCollection", UIController)
UIN29DetectiveCollection = UIN29DetectiveCollection

function UIN29DetectiveCollection:Constructor()
  self._anywhere_none = 0
  self._anywhere_fullBg = 1
  self._anywhere_fullCg = 2
  self._anywhereType = 0
  self._idEndCG = 1
  self._idMemory = 2
  self._idAchieve = 3
  self._idEndingA = 0
  self._idEndingB = 0
  self._idEndingC = 0
  self._idSheet = self._idAchieve
  self._idEnding = self._idEndingA
end

function UIN29DetectiveCollection:LoadDataOnEnter(TT, res, uiParams)
  self._localDb = UIN29DetectiveLocalDb:New()
  self._localDb:ViewedLoadDB()
  local name = {
    "_idEndingA",
    "_idEndingB",
    "_idEndingC"
  }
  local allEnding = self._localDb:GetAllEnding()
  local index = 1
  for k, v in pairs(allEnding) do
    self[name[index]] = v.CgId
    index = index + 1
  end
  self._idEnding = self._idEndingA
end

function UIN29DetectiveCollection:OnShow(uiParams)
  self._btnAnywhere = self:GetUIComponent("RectTransform", "btnAnywhere")
  self._uiWidget = self:GetUIComponent("RectTransform", "uiWidget")
  self._maskEndingCGFull = self:GetUIComponent("RectTransform", "maskEndingCGFull")
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "ltBtn")
  self._itemInfo = self:GetUIComponent("UISelectObjectPath", "itemInfo")
  self._tips = self._itemInfo:SpawnObject("UIN29DetectiveSelectInfo")
  self._layerUnchecked = self:GetUIComponent("RectTransform", "layerUnchecked")
  self._layerChecked = self:GetUIComponent("RectTransform", "layerChecked")
  self._tglEndCG = self:GetUIComponent("Toggle", "tglEndCG")
  self._tglAchieve = self:GetUIComponent("Toggle", "tglAchieve")
  self._tglEndA = self:GetUIComponent("Toggle", "tglA")
  self._tglEndB = self:GetUIComponent("Toggle", "tglB")
  self._tglEndC = self:GetUIComponent("Toggle", "tglC")
  self._contentEndCG = self:GetUIComponent("RectTransform", "contentEndCG")
  self._contentAchieve = self:GetUIComponent("RectTransform", "contentAchieve")
  self._srAchieve = self:GetChildComponent(self._contentAchieve, "ScrollRect", "Scroll View")
  self._txtEndingTitle = self:GetUIComponent("UILocalizationText", "txtEndingTitle")
  self._txtEndingDesc = self:GetUIComponent("UILocalizationText", "txtEndingDesc")
  self._lockedEndCG = self:GetUIComponent("RectTransform", "lockedEndCG")
  self._unlockEndCG = self:GetUIComponent("RectTransform", "unlockEndCG")
  self._achieveContent = self:GetUIComponent("UISelectObjectPath", "achieveContent")
  self._imgEndingCG = self:GetUIComponent("RawImage", "imgEndingCG")
  self._imgEndingCGLoader = self:GetUIComponent("RawImageLoader", "imgEndingCG")
  self._imgEndingCGFull = self:GetUIComponent("RawImage", "imgEndingCGFull")
  self._imgEndingCGFullLoader = self:GetUIComponent("RawImageLoader", "imgEndingCGFull")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._contentEndCGAnim = self._contentEndCG:GetComponent("Animation")
  self._contentAchieveAnim = self._contentAchieve:GetComponent("Animation")
  self._tglSheet = {
    [self._idEndCG] = {
      tgl = self._tglEndCG,
      animation = self._tglEndCG:GetComponent("Animation"),
      nameSelect = "uieff_UIN29DetectiveCollection_tglEngdCG_select",
      nameUnselect = "uieff_UIN29DetectiveCollection_tglEngdCG_unselect",
      txtUncheck = self:GetChildComponent(self._tglEndCG, "UILocalizationText", "offset/txtUncheck"),
      txtChecked = self:GetChildComponent(self._tglEndCG, "UILocalizationText", "offset/txtChecked"),
      content = {
        self._tglEndA,
        self._tglEndB,
        self._contentEndCG
      },
      fnGetRedDot = UIN29DetectiveLocalDb.GetEndCGReddot,
      redDot = self:GetChildComponent(self._tglEndCG, "UISelectObjectPath", "offset/reddot"),
      redDotSpawn = nil
    },
    [self._idAchieve] = {
      tgl = self._tglAchieve,
      animation = self._tglAchieve:GetComponent("Animation"),
      nameSelect = "uieff_UIN29DetectiveCollection_tglAchieve_select",
      nameUnselect = "uieff_UIN29DetectiveCollection_tglAchieve_unselect",
      txtUncheck = self:GetChildComponent(self._tglAchieve, "UILocalizationText", "offset/txtUncheck"),
      txtChecked = self:GetChildComponent(self._tglAchieve, "UILocalizationText", "offset/txtChecked"),
      content = {
        self._contentAchieve
      },
      fnGetRedDot = UIN29DetectiveLocalDb.GetAchieveReddot,
      redDot = self:GetChildComponent(self._tglAchieve, "UISelectObjectPath", "offset/reddot"),
      redDotSpawn = nil
    }
  }
  self._tglEnding = {
    [self._idEndingA] = {
      tgl = self._tglEndA,
      animation = self._tglEndA:GetComponent("Animation"),
      nameSelect = "uieff_UIN29DetectiveCollection_tglA_select",
      nameUnselect = "uieff_UIN29DetectiveCollection_tglA_unselect",
      title = self:GetChildComponent(self._tglEndA, "UILocalizationText", "txtEnding"),
      titleChk = self:GetChildComponent(self._tglEndA, "UILocalizationText", "txtEndingChk"),
      redDot = self:GetChildComponent(self._tglEndA, "UISelectObjectPath", "redEnding"),
      redDotSpawn = nil
    },
    [self._idEndingB] = {
      tgl = self._tglEndB,
      animation = self._tglEndB:GetComponent("Animation"),
      nameSelect = "uieff_UIN29DetectiveCollection_tglB_select",
      nameUnselect = "uieff_UIN29DetectiveCollection_tglB_unselect",
      title = self:GetChildComponent(self._tglEndB, "UILocalizationText", "txtEnding"),
      titleChk = self:GetChildComponent(self._tglEndB, "UILocalizationText", "txtEndingChk"),
      redDot = self:GetChildComponent(self._tglEndB, "UISelectObjectPath", "redEnding"),
      redDotSpawn = nil
    },
    [self._idEndingC] = {
      tgl = self._tglEndC,
      animation = self._tglEndC:GetComponent("Animation"),
      title = self:GetChildComponent(self._tglEndC, "UILocalizationText", "txtEnding"),
      titleChk = self:GetChildComponent(self._tglEndC, "UILocalizationText", "txtEndingChk"),
      redDot = self:GetChildComponent(self._tglEndC, "UISelectObjectPath", "redEnding"),
      redDotSpawn = nil
    }
  }
  self:CreateAchievePool()
  self:CheckDisplayEnding()
  self:EnterFullScreenBg(false)
  self:EnterFullScreenCg(false)
  self:InitCommonTopButton()
  self:OnShowSheet(self._idSheet)
  self:OnChangeLayer(self._idSheet)
  self:FlushEnding()
  self:FlushAchieve(true)
  self:FlushRedDot()
  self:InAnimation()
end

function UIN29DetectiveCollection:OnHide()
end

function UIN29DetectiveCollection:TglEndCGOnClick(go)
  if self._idSheetID == self._idEndCG then
    return
  end
  self:OnShowSheet(self._idEndCG)
  self:OnChangeLayer(self._idEndCG, self._idEnding)
  local sheetAchieve = self._tglSheet[self._idAchieve]
  local sheetEndCG = self._tglSheet[self._idEndCG]
  local endingU
  local endingC = self._tglEnding[self._idEnding]
  if self._idEnding == self._idEndingA then
    endingU = self._tglEnding[self._idEndingB]
  else
    endingU = self._tglEnding[self._idEndingA]
  end
  sheetEndCG.tgl.transform:SetParent(self._layerUnchecked)
  sheetAchieve.tgl.transform:SetParent(self._layerChecked)
  sheetEndCG.txtChecked.gameObject:SetActive(true)
  sheetEndCG.txtUncheck.gameObject:SetActive(true)
  sheetAchieve.txtChecked.gameObject:SetActive(true)
  sheetAchieve.txtUncheck.gameObject:SetActive(true)
  endingC.title.gameObject:SetActive(true)
  endingC.titleChk.gameObject:SetActive(true)
  endingU.title.gameObject:SetActive(true)
  endingU.titleChk.gameObject:SetActive(true)
  self._contentEndCG.gameObject:SetActive(true)
  self._contentAchieve.gameObject:SetActive(true)
  local lockName = "UIN29DetectiveCollection:TglEndCGOnClick"
  self:StartTask(function(TT)
    self:Lock(lockName)
    sheetEndCG.animation:Play(sheetEndCG.nameSelect)
    sheetAchieve.animation:Play(sheetAchieve.nameUnselect)
    endingC.animation:Play(endingC.nameSelect)
    endingU.animation:Play(endingU.nameUnselect)
    self._contentEndCGAnim:Play("uieff_UIN29DetectiveCollection_contentEndCG_in")
    self._contentAchieveAnim:Play("uieff_UIN29DetectiveCollection_contentAchieve_out")
    YIELD(TT, 132)
    sheetEndCG.tgl.transform:SetParent(self._layerChecked)
    sheetAchieve.tgl.transform:SetParent(self._layerUnchecked)
    YIELD(TT, 168)
    self._contentEndCG.gameObject:SetActive(true)
    self._contentAchieve.gameObject:SetActive(false)
    self:UnLock(lockName)
  end)
end

function UIN29DetectiveCollection:TglAchieveOnClick(go)
  if self._idSheetID == self._idAchieve then
    return
  end
  self._srAchieve.verticalNormalizedPosition = 1
  self:FlushAchieve(true)
  self:FlushRedDot()
  self:OnShowSheet(self._idAchieve)
  self:OnChangeLayer(self._idAchieve)
  local sheetAchieve = self._tglSheet[self._idAchieve]
  local sheetEndCG = self._tglSheet[self._idEndCG]
  sheetAchieve.tgl.transform:SetParent(self._layerUnchecked)
  sheetEndCG.tgl.transform:SetParent(self._layerChecked)
  sheetAchieve.txtChecked.gameObject:SetActive(true)
  sheetAchieve.txtUncheck.gameObject:SetActive(true)
  sheetEndCG.txtChecked.gameObject:SetActive(true)
  sheetEndCG.txtUncheck.gameObject:SetActive(true)
  self._contentEndCG.gameObject:SetActive(true)
  self._contentAchieve.gameObject:SetActive(true)
  local lockName = "UIN29DetectiveCollection:TglAchieveOnClick"
  self:StartTask(function(TT)
    self:Lock(lockName)
    sheetAchieve.animation:Play(sheetAchieve.nameSelect)
    sheetEndCG.animation:Play(sheetEndCG.nameUnselect)
    self._contentAchieveAnim:Play("uieff_UIN29DetectiveCollection_contentAchieve_in")
    self._contentEndCGAnim:Play("uieff_UIN29DetectiveCollection_contentEndCG_out")
    for k, v in pairs(self._uiAchievePool) do
      v:PlayAnimation("uieff_UIN29DetectiveAchieveDetails_in")
    end
    YIELD(TT, 132)
    sheetAchieve.tgl.transform:SetParent(self._layerChecked)
    sheetEndCG.tgl.transform:SetParent(self._layerUnchecked)
    YIELD(TT, 168)
    self._contentAchieve.gameObject:SetActive(true)
    self._contentEndCG.gameObject:SetActive(false)
    self:UnLock(lockName)
  end)
end

function UIN29DetectiveCollection:TglAOnClick(go)
  if self._idEnding == self._idEndingA then
    return
  end
  self._idEnding = self._idEndingA
  self._localDb:AddViewedEngCG(self._idEnding, true)
  self:FlushRedDot()
  self:OnChangeLayer(self._idEndCG, self._idEnding)
  local endingA = self._tglEnding[self._idEndingA]
  local endingB = self._tglEnding[self._idEndingB]
  endingA.tgl.transform:SetParent(self._layerUnchecked)
  endingB.tgl.transform:SetParent(self._layerChecked)
  endingA.title.gameObject:SetActive(true)
  endingA.titleChk.gameObject:SetActive(true)
  endingB.title.gameObject:SetActive(true)
  endingB.titleChk.gameObject:SetActive(true)
  local lockName = "UIN29DetectiveCollection:TglAOnClick"
  self:StartTask(function(TT)
    self:Lock(lockName)
    endingA.animation:Play(endingA.nameSelect)
    endingB.animation:Play(endingB.nameUnselect)
    YIELD(TT, 132)
    endingA.tgl.transform:SetParent(self._layerChecked)
    endingB.tgl.transform:SetParent(self._layerUnchecked)
    YIELD(TT, 168)
    self:UnLock(lockName)
  end)
  local lockName = "UIN29DetectiveCollection:TglAOnClick - 2"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._contentEndCGAnim:Play("uieff_UIN29DetectiveCollection_contentEndCG_out")
    YIELD(TT, 168)
    self:FlushEnding()
    self._contentEndCGAnim:Play("uieff_UIN29DetectiveCollection_contentEndCG_in")
    self:UnLock(lockName)
  end)
end

function UIN29DetectiveCollection:TglBOnClick(go)
  if self._idEnding == self._idEndingB then
    return
  end
  self._idEnding = self._idEndingB
  self._localDb:AddViewedEngCG(self._idEnding, true)
  self:FlushRedDot()
  self:OnChangeLayer(self._idEndCG, self._idEnding)
  local endingA = self._tglEnding[self._idEndingA]
  local endingB = self._tglEnding[self._idEndingB]
  endingA.tgl.transform:SetParent(self._layerChecked)
  endingB.tgl.transform:SetParent(self._layerUnchecked)
  endingA.title.gameObject:SetActive(true)
  endingA.titleChk.gameObject:SetActive(true)
  endingB.title.gameObject:SetActive(true)
  endingB.titleChk.gameObject:SetActive(true)
  local lockName = "UIN29DetectiveCollection:TglBOnClick"
  self:StartTask(function(TT)
    self:Lock(lockName)
    endingA.animation:Play(endingA.nameUnselect)
    endingB.animation:Play(endingB.nameSelect)
    YIELD(TT, 132)
    endingA.tgl.transform:SetParent(self._layerUnchecked)
    endingB.tgl.transform:SetParent(self._layerChecked)
    YIELD(TT, 168)
    self:UnLock(lockName)
  end)
  local lockName = "UIN29DetectiveCollection:TglBOnClick - 2"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._contentEndCGAnim:Play("uieff_UIN29DetectiveCollection_contentEndCG_out")
    YIELD(TT, 168)
    self:FlushEnding()
    self._contentEndCGAnim:Play("uieff_UIN29DetectiveCollection_contentEndCG_in")
    self:UnLock(lockName)
  end)
end

function UIN29DetectiveCollection:TglCOnClick(go)
  if self._idEnding == self._idEndingC then
    return
  end
  self._idEnding = self._idEndingC
  self:FlushEnding()
  self._localDb:AddViewedEngCG(self._idEnding, true)
  self:FlushRedDot()
  self:OnChangeLayer(self._idEndCG, self._idEnding)
end

function UIN29DetectiveCollection:BtnCGFullScreenOnClick(go)
  self:EnterFullScreenCg(true)
  self._localDb:AddViewedEngCG(self._idEnding, true)
  self:FlushRedDot()
end

function UIN29DetectiveCollection:BtnAnywhereOnClick(go)
  if self._anywhereType == self._anywhere_fullBg then
    self:EnterFullScreenBg(false)
  elseif self._anywhereType == self._anywhere_fullCg then
    self:EnterFullScreenCg(false)
  end
end

function UIN29DetectiveCollection:BtnCloseOnClick(go)
  self:StartTask(function()
    self._animation:Play("uieff_UIN29DetectiveCollection_out")
    YIELD(TT, 133)
    self:CallUIMethod("UIN29DetectiveLogin", "ReFlushCollectionRedDot")
    self:CloseDialog()
  end)
end

function UIN29DetectiveCollection:BtnReceiveOnClick(cfg)
  self:StartTask(function(this, TT, cfg)
    this:Lock("UIN29DetectiveCollection:BtnReceiveOnClick")
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    local questComponent = this._localDb:QuestComponent()
    questComponent:HandleQuestTake(TT, res, cfg.quest_id)
    if res.m_result == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED then
      ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    elseif res.m_result == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_CLOSE then
      ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    elseif not res:GetSucc() then
      local errorContent = string.format("【N29侦探】领取奖励失败，code=%d, id=%d", res:GetResult(), cfg.quest_id)
      ToastManager.ShowToast(errorContent)
    else
      this._localDb:AddViewedAchieve(cfg.quest_id, true)
      this._localDb:FlushUnlocked()
      this:FlushRedDot()
      this:FlushAchieve(false, cfg.quest_id)
      this:ShowDialog("UIGetItemController", cfg.rewards, function()
      end)
    end
    this:UnLock("UIN29DetectiveCollection:BtnReceiveOnClick")
  end, self, cfg)
end

function UIN29DetectiveCollection:GetChildComponent(parent, componentTypeName, name)
  local child = parent.transform:Find(name)
  if child == nil then
    return nil
  end
  return child:GetComponent(componentTypeName)
end

function UIN29DetectiveCollection:GetLocalDb()
  return self._localDb
end

function UIN29DetectiveCollection:CreateAchievePool()
  self._dataAchievePool = {}
  self._uiAchievePool = {}
  local questModule = self:GetModule(QuestModule)
  local questComponent = self._localDb:QuestComponent()
  local infoComponent = questComponent:GetComponentInfo()
  for k, v in pairs(infoComponent.m_accept_cam_quest_list) do
    local quest = questModule:GetQuest(v)
    local qinfo = quest:QuestInfo()
    table.insert(self._dataAchievePool, qinfo)
  end
  local count = #self._dataAchievePool
  self._uiAchievePool = self._achieveContent:SpawnObjects("UIN29DetectiveAchieveDetails", count)
end

function UIN29DetectiveCollection:CheckDisplayEnding()
  local clkName = {
    "A",
    "B",
    "C"
  }
  for k, v in pairs(clkName) do
    local id = "_idEnding" .. v
    local tgl = "_tglEnd" .. v
    if self[id] == 0 then
      self[tgl].gameObject:SetActive(false)
      self._tglEnding[self[id]] = nil
    end
  end
end

function UIN29DetectiveCollection:InitCommonTopButton()
  self._backBtns = self._ltBtn:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:SwitchState(UIStateType.UIN29DetectiveLogin)
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end, true, function()
    self:EnterFullScreenBg(true)
  end)
  self._ltBtn:Engine().gameObject:SetActive(false)
end

function UIN29DetectiveCollection:EnterFullScreenBg(isEnter)
  self._uiWidget.gameObject:SetActive(not isEnter)
  self._btnAnywhere.gameObject:SetActive(isEnter)
  if isEnter then
    self._anywhereType = self._anywhere_fullBg
  else
    self._anywhereType = self._anywhere_none
  end
end

function UIN29DetectiveCollection:EnterFullScreenCg(isEnter)
  self._maskEndingCGFull.gameObject:SetActive(isEnter)
  self._btnAnywhere.gameObject:SetActive(isEnter)
  if isEnter then
    self._anywhereType = self._anywhere_fullCg
  else
    self._anywhereType = self._anywhere_none
  end
end

function UIN29DetectiveCollection:OnShowItemInfo(matid, pos, count)
  self._tips:SetData(matid, pos, nil, count)
end

function UIN29DetectiveCollection:OnChangeLayer(idSheet, idEnding)
  for k, v in pairs(self._tglSheet) do
    v.tgl.transform:SetParent(self._layerUnchecked)
  end
  for k, v in pairs(self._tglEnding) do
    v.tgl.transform:SetParent(self._layerUnchecked)
  end
  if idSheet ~= nil then
    local v = self._tglSheet[idSheet]
    v.tgl.transform:SetParent(self._layerChecked)
  end
  if idEnding ~= nil then
    local v = self._tglEnding[idEnding]
    v.tgl.transform:SetParent(self._layerChecked)
  end
end

function UIN29DetectiveCollection:OnShowSheet(idSheet)
  self._idSheetID = idSheet
  local displaySheet = self._tglSheet[idSheet]
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

function UIN29DetectiveCollection:FlushEnding()
  local unlocked = self._localDb:GetEndCGUnlocked()
  local allItem = Cfg.cfg_component_detective_item({})
  for k, v in pairs(self._tglEnding) do
    v.tgl.isOn = self._idEnding == k
    v.title.gameObject:SetActive(not v.tgl.isOn)
    v.titleChk.gameObject:SetActive(v.tgl.isOn)
    local endCGTitle = ""
    local endCGDesc = ""
    if unlocked[k] ~= nil then
      local cfg = allItem[k]
      endCGTitle = StringTable.Get(cfg.Name)
      endCGDesc = StringTable.Get(cfg.Info)
    else
      endCGTitle = StringTable.Get("str_n29_detective_coll_unlock_ending_title")
      endCGDesc = StringTable.Get("str_n29_detective_coll_unlock_ending_desc")
    end
    v.title:SetText(endCGTitle)
    v.titleChk:SetText(endCGTitle)
    if k == self._idEnding then
      self._txtEndingTitle:SetText(endCGTitle)
      self._txtEndingDesc:SetText(endCGDesc)
    end
  end
  if unlocked[self._idEnding] ~= nil then
    self._lockedEndCG.gameObject:SetActive(false)
    self._unlockEndCG.gameObject:SetActive(true)
  else
    self._lockedEndCG.gameObject:SetActive(true)
    self._unlockEndCG.gameObject:SetActive(false)
  end
  if unlocked[self._idEnding] ~= nil then
    local cfg = allItem[self._idEnding]
    self._imgEndingCGLoader:LoadImage(cfg.CG)
    self._imgEndingCGFullLoader:LoadImage(cfg.CG)
    self:FlushEndingCGImage(self._imgEndingCG, cfg.CgDrawingTransform)
    self:FlushEndingCGImage(self._imgEndingCGFull, cfg.CgPreviewTransform)
  end
end

function UIN29DetectiveCollection:FlushEndingCGImage(rawImage, cfgTransform)
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

function UIN29DetectiveCollection:FlushAchieve(reorder, recreateId)
  if reorder then
    local canRecv = 1
    local locked = 2
    local recved = 3
    
    local function fnStateId(status)
      if status == QuestStatus.QUEST_Completed then
        return canRecv
      elseif status == QuestStatus.QUEST_NotStart then
        return locked
      elseif status == QuestStatus.QUEST_Accepted then
        return locked
      elseif status == QuestStatus.QUEST_Taken then
        return recved
      end
    end
    
    table.sort(self._dataAchievePool, function(a, b)
      local stateA = fnStateId(a.status)
      local stateB = fnStateId(b.status)
      if stateA ~= stateB then
        return stateA < stateB
      else
        return a.quest_id < b.quest_id
      end
    end)
  end
  if recreateId ~= nil then
    local questModule = self:GetModule(QuestModule)
    for k, v in pairs(self._dataAchievePool) do
      if v.quest_id == recreateId then
        local quest = questModule:GetQuest(recreateId)
        self._dataAchievePool[k] = quest:QuestInfo()
        break
      end
    end
  end
  for k, v in pairs(self._dataAchievePool) do
    local ui = self._uiAchievePool[k]
    ui:SetData(self, v)
  end
end

function UIN29DetectiveCollection:FlushRedDot()
  for k, v in pairs(self._tglSheet) do
    local showRedDot = v.fnGetRedDot(self._localDb)
    v.redDot.gameObject:SetActive(showRedDot)
    if showRedDot and v.redDotSpawn == nil then
      v.redDotSpawn = v.redDot:SpawnOneObject("ManualLoad0")
    end
  end
  for k, v in pairs(self._tglEnding) do
    local showRedDot = self._localDb:GetEndCGTitleReddot(k)
    v.redDot.gameObject:SetActive(showRedDot)
    if showRedDot and v.redDotSpawn == nil then
      v.redDotSpawn = v.redDot:SpawnOneObject("ManualLoad0")
    end
  end
  for k, v in pairs(self._uiAchievePool) do
    local showRedDot = self._localDb:GetAchieveTitleReddot(v:ID())
    v:SetRedDot(showRedDot)
    local showRedDot = self._localDb:GetAchieveRewardReddot(v:ID())
    v:SetRewardRedDot(showRedDot)
  end
end

function UIN29DetectiveCollection:InAnimation()
  local sheetAchieve = self._tglSheet[self._idAchieve]
  local sheetEndCG = self._tglSheet[self._idEndCG]
  sheetAchieve.tgl.transform:SetParent(self._layerUnchecked)
  sheetEndCG.tgl.gameObject:SetActive(false)
  local lockName = "UIN29DetectiveCollection:InAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    sheetAchieve.animation:Play(sheetAchieve.nameSelect)
    for k, v in pairs(self._uiAchievePool) do
      v:PlayAnimation("uieff_UIN29DetectiveAchieveDetails_in")
    end
    YIELD(TT, 132)
    sheetEndCG.tgl.gameObject:SetActive(true)
    sheetAchieve.tgl.transform:SetParent(self._layerChecked)
    YIELD(TT, 268)
    self:UnLock(lockName)
  end)
end

_class("UIN29DetectiveAchieveDetails", UICustomWidget)
UIN29DetectiveAchieveDetails = UIN29DetectiveAchieveDetails

function UIN29DetectiveAchieveDetails:Constructor()
  self._parent = nil
  self._cfg = nil
end

function UIN29DetectiveAchieveDetails:OnShow(uiParams)
  self._txtCondition = self:GetUIComponent("UILocalizationText", "txtCondition")
  self._txtDescription = self:GetUIComponent("UILocalizationText", "txtDescription")
  self._rewardContent = self:GetUIComponent("UISelectObjectPath", "rewardContent")
  self._stateReceive = self:GetUIComponent("RectTransform", "stateReceive")
  self._stateReceived = self:GetUIComponent("RectTransform", "stateReceived")
  self._stateLocked = self:GetUIComponent("RectTransform", "stateLocked")
  self._redDotReward = self:View():GetUIComponent("UISelectObjectPath", "redDotReward")
  self._redDotRewardSpawn = nil
  self._animation = self:GetUIComponent("Animation", "animation")
  self._arContentPool = nil
end

function UIN29DetectiveAchieveDetails:OnHide()
  self._localDb:ViewedClearNew()
end

function UIN29DetectiveAchieveDetails:BtnReceiveOnClick(go)
  self._parent:BtnReceiveOnClick(self._cfg)
end

function UIN29DetectiveAchieveDetails:SetRedDot(showRedDot)
end

function UIN29DetectiveAchieveDetails:SetRewardRedDot(showRedDot)
  self._redDotReward.gameObject:SetActive(showRedDot)
  if showRedDot and self._redDotRewardSpawn == nil then
    self._redDotRewardSpawn = self._redDotReward:SpawnOneObject("ManualLoad0")
  end
end

function UIN29DetectiveAchieveDetails:ID()
  return self._cfg.quest_id
end

function UIN29DetectiveAchieveDetails:SetData(parent, cfg)
  self._parent = parent
  self._cfg = cfg
  self._localDb = parent:GetLocalDb()
  self._txtCondition:SetText(StringTable.Get(cfg.CondDesc))
  self._txtDescription:SetText(StringTable.Get(cfg.QuestDesc))
  local countReward = 0
  local cfgRewardList = cfg.rewards
  if cfgRewardList ~= nil then
    countReward = #cfgRewardList
  end
  self._arContentPool = self._rewardContent:SpawnObjects("UIN29DetectiveAchieveReward", countReward)
  for i = 1, countReward do
    local ui = self._arContentPool[i]
    local data = cfgRewardList[i]
    ui:SetData(self._parent, data)
  end
  self._stateReceive.gameObject:SetActive(false)
  self._stateReceived.gameObject:SetActive(false)
  self._stateLocked.gameObject:SetActive(false)
  self._txtDescription.gameObject:SetActive(false)
  if cfg.status == QuestStatus.QUEST_NotStart then
    self._stateLocked.gameObject:SetActive(true)
  elseif cfg.status == QuestStatus.QUEST_Accepted then
    self._stateLocked.gameObject:SetActive(true)
  elseif cfg.status == QuestStatus.QUEST_Completed then
    self._stateReceive.gameObject:SetActive(true)
    self._txtDescription.gameObject:SetActive(true)
  elseif cfg.status == QuestStatus.QUEST_Taken then
    self._stateReceived.gameObject:SetActive(true)
    self._txtDescription.gameObject:SetActive(true)
  end
end

function UIN29DetectiveAchieveDetails:PlayAnimation(animName)
  self._animation:Play(animName)
end

_class("UIN29DetectiveAchieveReward", UICustomWidget)
UIN29DetectiveAchieveReward = UIN29DetectiveAchieveReward

function UIN29DetectiveAchieveReward:OnShow(uiParams)
  self._iconLoader = self:GetUIComponent("RawImageLoader", "imgIcon")
  self._iconImg = self:GetUIComponent("RawImage", "imgIcon")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
end

function UIN29DetectiveAchieveReward:SetData(parent, data)
  self._parent = parent
  self._data = data
  local cfgItem = Cfg.cfg_item[data.assetid]
  if cfgItem ~= nil then
    self._iconLoader:LoadImage(cfgItem.Icon)
  end
  self._txtName.gameObject:SetActive(false)
  self._txtCount:SetText(string.format("X %d", data.count))
end

function UIN29DetectiveAchieveReward:ButtonOnClick(go)
  self:RootUIOwner():OnShowItemInfo(self._data.assetid, go.transform.position, self._data.count)
end

_class("UIN29DetectiveSelectInfo", UISelectInfo)
UIN29DetectiveSelectInfo = UIN29DetectiveSelectInfo

function UIN29DetectiveSelectInfo:Constructor()
  self._diyItem = true
end

function UIN29DetectiveSelectInfo:OnShow()
  self._lockName = "OpenSelectInfoLock"
  self._pos = self:GetGameObject("pos")
  local passEvent = self._pos:GetComponent("PassEventComponent")
  passEvent:SetClickCallback(function()
    self:closeOnClick()
  end)
  self._selectInfo = self:GetUIComponent("RectTransform", "select_info")
  self:GetOffset()
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "select_info")
  self._selectInfo.anchoredPosition = Vector2(10000, 0)
  self._pos:SetActive(false)
  self._g1 = self:GetGameObject("g1")
  self._g2 = self:GetGameObject("g2")
  self._g3 = self:GetGameObject("g3")
  self._g3RectTrans = self:GetUIComponent("RectTransform", "g3")
  self._g3CustomObj = self:GetUIComponent("UISelectObjectPath", "g3")
  self._g1:SetActive(false)
  self._g2:SetActive(false)
  self._g3:SetActive(false)
  self._itemInfoName = self:GetUIComponent("UILocalizationText", "txt_item_name")
  self._itemInfoName2 = self:GetUIComponent("UILocalizationText", "txt_item_name2")
  self._itemInfoDesc = self:GetUIComponent("UILocalizationText", "txt_item_simple_desc")
  self._itemInfoDesc2 = self:GetUIComponent("UILocalizationText", "txt_item_simple_desc2")
  self._itemInfoCount = self:GetUIComponent("UILocalizationText", "txt_item_own_count")
  self._itemInfoCount2 = self:GetUIComponent("UILocalizationText", "txt_item_own_count2")
  self._enter = false
  self._exit = false
  self._isDispose = false
  if not self._diyItem then
    local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
    self.uiItem = sop:SpawnObject("UIItem")
    self.uiItem:SetForm(UIItemForm.Base)
    local sop2 = self:GetUIComponent("UISelectObjectPath", "uiitem2")
    self.uiItem2 = sop2:SpawnObject("UIItem")
    self.uiItem2:SetForm(UIItemForm.Base)
    self:SetType(1)
  else
    self._txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
    self._iconLoader = self:GetUIComponent("RawImageLoader", "icon")
    self:SetType(1)
    self._showItem = {
      SetData = function()
      end
    }
  end
end

function UIN29DetectiveSelectInfo:SetData(item_id, pos, des, count)
  UISelectInfo.SetData(self, item_id, pos, des)
  if self._diyItem then
    local cfgItem = Cfg.cfg_item[item_id]
    if cfgItem ~= nil then
      self._iconLoader:LoadImage(cfgItem.Icon)
    end
    self._txtCount:SetText(string.format("x%d", count))
  end
end
