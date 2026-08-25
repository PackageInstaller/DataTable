local TextMeshProUGUI = CS.TMPro.TextMeshProUGUI
local typeof = _ENV.typeof
local TMPTypewriter = CS.TMPTypewriter
local Vector2 = CS.UnityEngine.Vector2
local TextAlignmentOptions = CS.TMPro.TextAlignmentOptions
local GmEventPreviewPlaceholder = "xx"
local gearSoundMap = {
  [CommonDefine.GearItemType.Beacon] = {
    "EXPLORE_FOGCRYSTAL_TAKEEFFECT",
    "Play_Explore_Vfx_MistDispel"
  }
}
local WorldStageEventPanel, Super = System.NewClass("WorldStageEventPanel", UIBasePanel)
WorldStageEventPanel.uiResCls = UI_Dbgcopy_Popup_Event_NewResource

function WorldStageEventPanel:ctor(gearData, _, callBack, tearDown)
  Super.ctor(self)
  self.gearData = gearData
  self.callFunc = callBack
  self.tearDown = tearDown
  self.optionUIObjList = {}
  self.nodeType2PostSoundMap = {
    [DT.GetConstant("RelicKeyMapNodeType")] = "Play_Explore_Popup_Getkey"
  }
end

function WorldStageEventPanel:OnBind(binder)
  self.binder = binder
  self.binder:LoadAllLangFont(self.ui.Text_Desc)
  self:PostOpenSound()
  self:BindOptionItems(binder)
  self:InitData()
  binder:BindToText(self.ui.Text_Desc, function()
    do return LT.Text end
    return LT.Text, self.textDesc.value
  end)
  UICommonBtnVibes.BindCommonBtnVibes(self.binder, self.ui.UI_Common_Btn_Vibes, self.gearData.uid)
  local commonPopupTipsData = {
    sizeType = CommonDefine.PopupTipsType.L,
    textTitleCN = self.textTitle.value,
    clickFunc = nil
  }
  binder:BindComponent(CommonPopupTips(self.ui.UI_Common_Popup_Tips_L, commonPopupTipsData))
  binder:BindToImage(self.ui.Image_D_Event, function()
    return self.imageBG.value
  end)
  binder:BindToVisible(self.ui.Image_D_Event, function()
    return self.imageBG.value ~= ""
  end)
  binder:BindToRaw(function(_, evt, _)
    AudioManager.Instance:PostSoundEvent(evt)
  end, function()
    return self.musicEvt.value
  end)
  self:BindEyeBtn()
end

function WorldStageEventPanel:BindOptionItems(binder)
  local uiOptionNum = CommonDefine.UINodeOptionNum
  for optionIndex = 1, uiOptionNum do
    local optionItem = self.ui["Item_Event_" .. optionIndex]
    local optionUI = self.optionUIObjList[optionIndex]
    if nil == optionUI then
      optionUI = UI_Dbgcopy_Item_Event_Choice_NewResource(optionItem)
      binder:SetActive(optionUI.Image_Mask, false)
      binder:BindButtonClick(optionUI.Btn_View, function()
        self:ShowOptionDisplayPanel(optionIndex)
      end)
      binder:BindButtonClick(optionUI.Content, System.bind(self.OnClickOption, self, optionIndex))
      self.optionUIObjList[optionIndex] = optionUI
    end
  end
end

function WorldStageEventPanel:BindEyeBtn()
  local eyeRes = Btn_Block_WindowResource(self.ui.Btn_Block_Window)
  self.eyeOpenIcon = eyeRes.Image_Open
  self.eyeCloseIcon = eyeRes.Image_Close
  self.eyeOpenIcon:SetActive(true)
  self.eyeCloseIcon:SetActive(false)
  self.visible = true
  self.binder:BindButtonClick(self.ui.Btn_Block_Window, function()
    self:ToggleVisible()
  end)
end

function WorldStageEventPanel:ToggleVisible()
  self.visible = not self.visible
  self:RefreshEyeVisible()
end

function WorldStageEventPanel:RefreshEyeVisible()
  self.eyeOpenIcon:SetActive(self.visible)
  self.eyeCloseIcon:SetActive(not self.visible)
  local Vector3 = CS.UnityEngine.Vector3
  if self.visible then
    self.ui.UI_Common_Popup_Tips_L.transform.localPosition = Vector3(0, 0, 0)
  else
    self.ui.UI_Common_Popup_Tips_L.transform.localPosition = Vector3(0, 10000, 0)
  end
end

function WorldStageEventPanel:InitData()
  self.eventId = nil
  if self.gearData and self.gearData.data then
    self.eventId = self.gearData.data.eventId
  end
  self.textTitle = Vue.ref()
  self.textDesc = Vue.ref()
  self.imageBG = Vue.ref()
  self.musicEvt = Vue.ref()
  self.validOptions = {}
  if self.eventId then
    self:RefreshDataByEventData(self.gearData)
  end
end

function WorldStageEventPanel:RefreshDataByEventData(eventData)
  local eventId = eventData.data.eventId
  self.eventId = eventId
  self.gearData = eventData
  local eventCfg = DT.Event[eventId] or {}
  self.textTitle.value = eventCfg.Name or ""
  self.textDesc.value = eventCfg.Desc or ""
  self.imageBG.value = eventCfg.Bg or ""
  self.musicEvt.value = eventCfg.Music or ""
  self.banClick = false
  self:RefreshValidOptions(eventId, eventData.data.option or {})
  Logger.Debug("EventOptionData:", table.tostring(self.gearData.data))
  for optionIndex = 1, cd.UINodeOptionNum do
    self:SetOption(eventData, self.validOptions, optionIndex)
  end
  self:SetOptionItems()
  self:AdaptTextViewHeight()
end

function WorldStageEventPanel:RefreshValidOptions(eventId, options)
  self.validOptions = {}
  local eventCfg = DT.Event[eventId] or {}
  local checkKey = "ChoiceDesc"
  for optionIndex = 1, CommonDefine.MaxNodeOptionNum do
    local optionData = table.clone(options[optionIndex] or {})
    if not optionData.isHide and eventCfg[checkKey .. optionIndex] then
      optionData.realIndex = optionIndex
      table.insert(self.validOptions, optionData)
    end
  end
end

function WorldStageEventPanel:SetOption(eventData, options, optionIndex)
  if not options or not options[optionIndex] then
    return
  end
  local eventId = eventData.data.eventId
  local optionData = options and options[optionIndex] or {}
  local eventCfg = DT.Event[eventId] or {}
  local realIndex = optionData.realIndex or optionIndex
  optionData.optionArgs = {}
  local optionDesc = LT.Text(eventCfg["ChoiceDesc" .. realIndex]) or ""
  local isGmPreview = eventData.data and eventData.data.isGmPreview
  local maxReplaceArgsCount = 5
  for matchStr in string.gmatch(optionDesc, "%[ExDesc%d+%]") do
    local text = ""
    if optionData.exDescs and optionData.exDescs[matchStr] then
      text = LT.Text(optionData.exDescs[matchStr])
    elseif isGmPreview then
      text = GmEventPreviewPlaceholder
    end
    optionDesc = string.gsub(optionDesc, "%[ExDesc%d+%]", text, 1)
  end
  for i = 1, maxReplaceArgsCount do
    if string.find(optionDesc, "Arg" .. i) then
      if isGmPreview and optionData["Arg" .. i] == nil then
        optionDesc = string.gsub(optionDesc, "%(%w+%.Arg" .. i .. "%)", GmEventPreviewPlaceholder)
      else
        optionDesc = string.replace(optionDesc, "Arg" .. i, math.abs(math.ceil(optionData["Arg" .. i] or 0)))
        local parsedDesc, cfgName, cfgId = self:ParseOptionText(optionDesc, isGmPreview)
        optionDesc = parsedDesc
        if cfgName and cfgId then
          table.insert(optionData.optionArgs, {cfgName = cfgName, cfgId = cfgId})
        end
      end
    end
  end
  optionData.optionDesc = optionDesc or ""
end

function WorldStageEventPanel:SetOptionItems()
  for optionIndex = 1, cd.UINodeOptionNum do
    local optionUI = self.optionUIObjList[optionIndex]
    local optionData = self.validOptions[optionIndex]
    optionUI.uiNode:SetActive(nil ~= optionData)
    self.binder:SetText(optionUI.Text_Desc, LT.Text(optionData and optionData.optionDesc or ""))
    local optionArgs = optionData and optionData.optionArgs or {}
    optionUI.Btn_View:SetActive(#optionArgs > 0)
    local textTf = optionUI.Text_Desc:GetComponent(typeof(CS.UnityEngine.RectTransform))
    local contentTf = optionUI.Content:GetComponent(typeof(CS.UnityEngine.RectTransform))
    local size = textTf.sizeDelta.x
    StrUtils.SetPreferredHeight(optionUI.Text_Desc, 20)
    if textTf.sizeDelta.y > 120 then
      optionUI.Text_DescView:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect)).enabled = true
      contentTf.sizeDelta = textTf.sizeDelta
      textTf.anchoredPosition = Vector2(0, 0)
      textTf.sizeDelta = Vector2(size, 0)
      optionUI.Text_Desc:GetComponent(typeof(CS.TMPro.TMP_Text)).alignment = TextAlignmentOptions.TopLeft
      optionUI.Text_DescView:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect)).verticalNormalizedPosition = 1
    else
      contentTf.sizeDelta = Vector2(size, 100)
      textTf.sizeDelta = Vector2(size, 100)
      contentTf.anchoredPosition = Vector2(0.5 * size, -50)
      textTf.anchoredPosition = Vector2(0, -50)
      optionUI.Text_DescView:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect)).enabled = false
      optionUI.Text_Desc:GetComponent(typeof(CS.TMPro.TMP_Text)).alignment = TextAlignmentOptions.MidlineLeft
    end
    optionUI.Image_Mask:SetActive(optionData and false == optionData.isChoose)
  end
end

function WorldStageEventPanel:ParseOptionText(content, isGmPreview)
  local pattern = "%((%w+)%.(%d+)%)"
  local rawCfgName, cfgIdStr = string.match(content, pattern)
  local cfgId = tonumber(cfgIdStr)
  local cfgName = rawCfgName
  if rawCfgName and cfgId then
    cfgName, cfgId = self:ResolveEventOptionCfgName(rawCfgName, cfgId)
    local cfg = DT[cfgName] and DT[cfgName][cfgId]
    local itemName = cfg and LT.Text(cfg.Name) or ""
    if "" == itemName and isGmPreview then
      itemName = GmEventPreviewPlaceholder
    end
    local itemNamePattern = "<[^:]+:(.-)>"
    local rawName = string.match(itemName, itemNamePattern)
    content = string.replace(content, "(" .. rawCfgName .. "." .. cfgIdStr .. ")", rawName or itemName, true)
  end
  return content, cfgName, cfgId
end

function WorldStageEventPanel:ShowOptionDisplayPanel(optionIndex)
  local optionData = self.validOptions[optionIndex]
  local optionArgs = optionData and optionData.optionArgs or {}
  local firstArg = optionArgs[1]
  if not firstArg then
    return
  end
  for _, arg in ipairs(optionArgs) do
    local resName, resId = self:ResolveEventOptionCfgName(arg.cfgName, arg.cfgId)
    arg.cfgName = resName
    arg.cfgId = resId
  end
  local optionDisplayList = {}
  for index, arg in ipairs(optionArgs) do
    optionDisplayList[arg.cfgName] = optionDisplayList[arg.cfgName] or {
      showIdx = index,
      content = {},
      cfgName = arg.cfgName
    }
    table.insert(optionDisplayList[arg.cfgName].content, optionArgs[index])
  end
  table.sort(optionDisplayList, function(a, b)
    return a.showIdx < b.showIdx
  end)
  local finalList = {}
  local showIdx = 0
  for _, data in pairs(optionDisplayList) do
    showIdx = showIdx + 1
    finalList[showIdx] = data
  end
  UIManager.Instance:Reopen(Urls.WorldStageEventOptionPanel, finalList)
end

function WorldStageEventPanel:SetCallFunc(callBack)
  self.callFunc = callBack
end

function WorldStageEventPanel:OnClickOption(index)
  local option = self.validOptions[index]
  if option and option.isChoose == false then
    local eventCfg = DT.Event[self.eventId] or {}
    if eventCfg["Tips" .. index] then
      Alert.ShowStr(eventCfg["Tips" .. index])
    else
      Alert.Show(10714)
    end
    return
  end
  if self.banClick then
    return
  end
  self.banClick = true
  self.binder:BindTimer(1, 0, nil, function()
    self.banClick = false
  end)
  if self.callFunc then
    self:PostEventSound()
    self.callFunc(option.realIndex, self.eventId, System.fn(self, self.OnReqBack))
  end
end

function WorldStageEventPanel:OnReqBack(index)
end

function WorldStageEventPanel:PrintText(textObj, content)
  if nil == content or "" == content then
    return
  end
  self.binder:SetText(textObj, content)
  local textComp = textObj:GetComponent(typeof(TextMeshProUGUI))
  local maxCharacterNum = textComp.textInfo.characterCount
  if 0 == maxCharacterNum then
    FrameWaiter.RemoveWaiter(self._frameWaiter)
    self._frameWaiter = FrameWaiter.OnNextFrame(function()
      self:PrintText(textObj, content)
    end)
    return
  end
  local updateTime = 0.06
  local totalTime = 0.5
  local playSpeed = math.ceil(maxCharacterNum / math.floor(totalTime / updateTime))
  local compTMPTypewriter = TMPTypewriter.Get(textComp.gameObject)
  compTMPTypewriter.chAppearSpeed = updateTime
  compTMPTypewriter.chFadeInSpeed = 0.5
  compTMPTypewriter.chAppearPace = math.max(1, playSpeed)
  compTMPTypewriter:StartPrinting()
end

function WorldStageEventPanel:AdaptTextViewHeight()
  local transform = self.ui.ScrollView:GetComponent(typeof(CS.UnityEngine.RectTransform))
  local optionNum = #self.validOptions
  if self.ui["Selection_Height_" .. optionNum] then
    local rt = self.ui["Selection_Height_" .. optionNum]:GetComponent(typeof(CS.UnityEngine.RectTransform))
    transform.sizeDelta = Vector2(transform.sizeDelta.x, rt.rect.height)
  end
end

function WorldStageEventPanel:PostEventSound(opIdx)
  local nodeCfg = DT.MapNode[self.gearData.tid]
  local nodeTypeCfg = nodeCfg and nodeCfg.NodeType and DT.MapNodeType[nodeCfg.NodeType]
  if not nodeTypeCfg or not nodeTypeCfg.TypeEffect then
    return
  end
  local eventList = gearSoundMap[nodeTypeCfg.TypeEffect]
  if eventList then
    for _, event in ipairs(eventList) do
      AudioManager.Instance:PostSoundEvent(event)
    end
  end
end

function WorldStageEventPanel:PostOpenSound()
  local soundEvent = self.nodeType2PostSoundMap[self.gearData.type]
  if soundEvent then
    AudioManager.Instance:PostSoundEvent(soundEvent)
  end
end

function WorldStageEventPanel:OnClose()
  self:Close()
end

function WorldStageEventPanel:Close()
  Logger.Info("WorldStageEventPanel.Close>>>>>>", debug.traceback())
  if self.timer then
    self.binder:StopTimer(self.timer)
    self.timer = nil
  end
  Super.Close(self)
end

function WorldStageEventPanel:OnUnbind()
  Logger.Info("WorldStageEventPanel.OnUnbind>>>>>>", debug.traceback())
  FrameWaiter.RemoveWaiter(self._frameWaiter)
  if self.tearDown then
    self.tearDown()
  end
end

local OptionCfgFallbackList = {
  "RelicConfig",
  "EnchantConfig",
  "Skill"
}

function WorldStageEventPanel:ResolveEventOptionCfgName(cfgName, cfgId)
  if not cfgName or not cfgId then
    return cfgName, cfgId
  end
  local tbl = DT[cfgName]
  local cfg = tbl and tbl[cfgId]
  if cfg then
    return cfgName, cfgId
  end
  for _, name in ipairs(OptionCfgFallbackList) do
    if name ~= cfgName then
      local fallbackCfg = DT[name] and DT[name][cfgId]
      if fallbackCfg then
        Logger.Warn("WorldStageEventPanel.ResolveEventOptionCfgName fix cfgName %s -> %s, id=%s, eventId=%s", cfgName, name, tostring(cfgId), tostring(self.eventId))
        return name, cfgId
      end
    end
  end
  return cfgName, cfgId
end

return WorldStageEventPanel
