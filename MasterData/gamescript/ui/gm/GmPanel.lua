local InputField = typeof(CS.UnityEngine.UI.InputField)
local Text = CS.UnityEngine.UI.Text
local GmPanel, Super = System.NewClass("GmPanel", UIBasePanel)
GmPanel.uiResCls = GmPanelResource

function GmPanel:ctor()
  Super.ctor(self)
  self.gmObjs = Vue.ref({})
end

function GmPanel:OnBind(binder)
  self.searchWord = GmPanel.SearchWord
  if self.searchWord then
    self.ui.SearchInputField:GetComponent(InputField).text = self.searchWord
  end
  self.recentUseGm = self:GetRecentUseGm()
  if type(self.recentUseGm) == "table" and next(self.recentUseGm) then
    self.curSelectType = Vue.ref(0)
    self.curSelectSubType = Vue.ref(0)
  else
    self.recentUseGm = {}
    self.curSelectType = Vue.ref(1)
    self.curSelectSubType = Vue.ref(1)
  end
  self.binder = binder
  self:UpdateSubBtnData()
  self:UpdateTopBtnData()
  self.gmBtnList = {}
  self.mainBtnTypeList = {}
  self.subBtnTypeList = {}
  self.binder:BindButtonClick(self.ui.Btn_Exit, System.fn(self, self.OnClickBtnExit))
  self.binder:BindButtonClick(self.ui.Btn_Active, function()
    GmManager.SetGmPanelVisible(false)
  end)
  self.binder:BindButtonClick(self.ui.Btn_Test, function()
    __ProtoTest.test()
  end)
  binder:BindToCircularListView(self.ui.TopView, function()
    return self.mainBtnData
  end, function(childBinder, item, index)
    local data = self.mainBtnData
    data = data[index]
    local uiText = item.transform:GetChild(0):GetComponent(typeof(Text))
    uiText.text = data.Name
    childBinder:BindButtonClick(item, function()
      self:OnClickMainTypeBtn(index)
    end)
    self.mainBtnTypeList[index] = uiText
  end, function(index)
    self.mainBtnTypeList[index] = nil
  end)
  binder:BindToCircularListView(self.ui.LeftView, function()
    return self.subBtnData
  end, function(childBinder, item, index)
    local data = self.subBtnData
    data = data[index]
    local uiText = item.transform:GetChild(0):GetComponent(typeof(Text))
    uiText.text = data.Name
    if index == self.curSelectSubType.value then
      uiText.color = CS.UnityEngine.Color.blue
    else
      uiText.color = CS.UnityEngine.Color.black
    end
    childBinder:BindButtonClick(item, function()
      self:OnClickSubTypeBtn(index)
    end)
    self.subBtnTypeList[index] = uiText
  end, function(index)
    self.subBtnTypeList[index] = nil
  end)
  binder:BindToRaw(function(_, new, old)
    self:UpdateSubBtnData()
    self:GenGmBtnListByType(new, self.curSelectSubType.value)
    self:UpdateTopBtnSelectState(new, old)
    if 0 == new then
      self.curSelectSubType.value = 0
    else
      self.curSelectSubType.value = 1
    end
  end, function()
    return self.curSelectType.value
  end)
  binder:BindToRaw(function(_, new, old)
    self:GenGmBtnListByType(self.curSelectType.value, new)
    self:UpdateSubBtnSelectState(new, old)
  end, function()
    return self.curSelectSubType.value
  end)
  binder:BindToRaw(function(childBinder, gmObjs, old)
    local itemIndex = 0
    for i, obj in ipairs(gmObjs) do
      if obj.name and obj.name ~= "" and 0 ~= obj.show then
        itemIndex = itemIndex + 1
        childBinder:BindNewComponent(self.ui.Content, require("GameScript." .. Urls.GmCommandItem), GmcommandItemResource, obj, self)
      end
    end
  end, function()
    return self.gmObjs.value
  end)
  self.searchWord = self.ui.SearchInputField:GetComponent(InputField).text
  self:InitSearchClearBtn(binder)
  binder:BindTimer(0.1, -1, function()
    self:OnSearch()
  end)
  if self.searchWord and #self.searchWord > 0 then
    self.searchWord = ""
    self:OnSearch()
  end
  binder:BindButtonClick(self.ui.Btn_Battle_Test, function()
    UIManager.Instance:Reopen(Urls.BattleDbgEntryPanel, false)
    UIManager.Instance:CloseByUrl(Urls.GmPanel)
  end)
  binder:BindButtonClick(self.ui.Btn_Battle_Pvp_Test, function()
    UIManager.Instance:Reopen(Urls.BattleDbgEntryPanel, true)
    UIManager.Instance:CloseByUrl(Urls.GmPanel)
  end)
  binder:BindButtonClick(self.ui.Btn_PvP_Match, function()
    UIManager.Instance:Reopen(Urls.PvPMatchPanel)
    UIManager.Instance:CloseByUrl(Urls.GmPanel)
  end)
  binder:SetText(self.ui.Text_Battle_Test, "战斗2.0")
  binder:BindButtonClick(self.ui.Btn_AVG_Test, function()
    local storyList = GmClientUtils.GetStoryTextList()
    UIManager.Instance:Reopen(Urls.SimpleListView, storyList, function(data)
      DataCenter.playerData.isClickGmAvg = true
      UIManager.Instance:CloseByUrl(Urls.SimpleListView)
      AvgStoryManager.Instance:ResetAvgCfg()
      AvgStoryManager.Instance:StartStoryById(data.id, nil, function()
        DataCenter.playerData.isClickGmAvg = false
      end)
    end, true, "GmAvgStoryListPanel")
    UIManager.Instance:CloseByUrl(Urls.GmPanel)
  end)
  binder:SetText(self.ui.Text_AVG_Test, "AVG剧情测试")
  binder:BindToRawText(self.ui.Text_User, function()
    local str = ""
    local buildVersion = CS.FrameWork.Z1Const.GetBuildVerion()
    str = str .. string.format("%s ", buildVersion or "")
    local platformName = ""
    if CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.WindowsEditor then
      platformName = "PC"
    elseif CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.Android then
      platformName = "Android"
    elseif CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.IPhonePlayer then
      platformName = "iOS"
    end
    str = str .. string.format("%s ", platformName)
    if CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.WindowsEditor then
      local branchName = GmManager.Instance:GetClientGitBranch()
      if branchName and "" ~= branchName then
        str = str .. string.format("Git(%s)", branchName)
      end
    end
    if not DataCenter.gameData.IsShowAccountState then
      return str
    end
    if not LoginMgr or not LoginMgr.Instance then
      return str
    end
    local account = LoginMgr.Instance.model.account or ""
    local roleId = DataCenter.playerData.DRole.uid
    local serverName = LoginMgr.Instance.model.serverName or ""
    local serverNode = LoginMgr.Instance.model:GetServerNode()
    str = str .. string.format("%s UserId:%s, %s(%s)", account, roleId, serverName, serverNode)
    return str
  end)
  self.binder:BindToRawText(self.ui.Text_Net, function()
    local text
    local strTime = TimeUtils.GetServerTime()
    strTime = TimeUtils.ServerTimestampToString(math.floor(strTime), TimeUtils.TimeExactType.MinuteShort)
    local textLevel
    local fpsLimit = SettingManager:GetSettingData(CommonDefine.SettingUniqueName.FPSLimit)
    local commonId = SettingManager:GetSettingData(CommonDefine.SettingUniqueName.Resolution)
    if not commonId or not DT.CommonID[commonId] then
      return
    end
    local resolution = DT.CommonID[commonId].Desc
    textLevel = string.format("帧率上限 %s 当前分辨率 %s", LT.Text(fpsLimit), LT.Text(resolution))
    text = string.format("%s %s 网络:%sms ", strTime, textLevel, DataCenter.playerData.netDelayTime)
    return text or ""
  end)
end

function GmPanel:InitSearchClearBtn(binder)
  local searchGo = self.ui.SearchInputField
  if not searchGo then
    return
  end
  local searchTrans = searchGo.transform
  local existBtn = searchTrans:Find("Btn_ClearSearch")
  if existBtn then
    binder:BindButtonClick(existBtn.gameObject, System.fn(self, self.OnClickClearSearch))
    return
  end
  for i = 0, searchTrans.childCount - 1 do
    local childRect = searchTrans:GetChild(i):GetComponent(typeof(CS.UnityEngine.RectTransform))
    if childRect then
      childRect.offsetMax = CS.UnityEngine.Vector2(-36, childRect.offsetMax.y)
    end
  end
  local btnGo = CS.UnityEngine.GameObject("Btn_ClearSearch")
  btnGo.layer = searchGo.layer
  btnGo.transform:SetParent(searchTrans, false)
  local img = btnGo:AddComponent(typeof(CS.UnityEngine.UI.Image))
  img.color = CS.UnityEngine.Color(1, 1, 1, 0)
  img.raycastTarget = true
  btnGo:AddComponent(typeof(CS.UnityEngine.UI.Button))
  local btnRect = btnGo:GetComponent(typeof(CS.UnityEngine.RectTransform))
  btnRect.anchorMin = CS.UnityEngine.Vector2(1, 0.5)
  btnRect.anchorMax = CS.UnityEngine.Vector2(1, 0.5)
  btnRect.pivot = CS.UnityEngine.Vector2(1, 0.5)
  btnRect.anchoredPosition = CS.UnityEngine.Vector2(-2, 0)
  btnRect.sizeDelta = CS.UnityEngine.Vector2(36, 36)
  local textGo = CS.UnityEngine.GameObject("Text")
  textGo.layer = searchGo.layer
  textGo.transform:SetParent(btnGo.transform, false)
  local uiText = textGo:AddComponent(typeof(Text))
  uiText.text = "×"
  uiText.alignment = CS.UnityEngine.TextAnchor.MiddleCenter
  uiText.color = CS.UnityEngine.Color(0.25, 0.25, 0.25, 1)
  uiText.fontSize = 28
  uiText.raycastTarget = false
  local placeholder = searchTrans:Find("Text_C_Placeholder")
  if placeholder then
    local placeholderText = placeholder:GetComponent(typeof(Text))
    if placeholderText and placeholderText.font then
      uiText.font = placeholderText.font
    end
  end
  local textRect = textGo:GetComponent(typeof(CS.UnityEngine.RectTransform))
  textRect.anchorMin = CS.UnityEngine.Vector2.zero
  textRect.anchorMax = CS.UnityEngine.Vector2.one
  textRect.offsetMin = CS.UnityEngine.Vector2.zero
  textRect.offsetMax = CS.UnityEngine.Vector2.zero
  binder:BindButtonClick(btnGo, System.fn(self, self.OnClickClearSearch))
end

function GmPanel:OnClickClearSearch()
  local input = self.ui.SearchInputField:GetComponent(InputField)
  if not input then
    return
  end
  input.text = ""
  self:OnSearch()
end

function GmPanel:OnSearch()
  local curWord = self.ui.SearchInputField:GetComponent(InputField).text
  if curWord == self.searchWord then
    return
  end
  self.searchWord = curWord
  GmPanel.SearchWord = curWord
  local filterList = {}
  local reg = ""
  for i = 1, #curWord do
    reg = reg .. string.sub(curWord, i, i) .. ".*"
  end
  local gmConfig = GmClientUtils.GetGmConfig()
  for k, value in pairs(gmConfig) do
    if 0 == #curWord or string.find((value.namePingyin or "") .. (value.name or ""), reg) then
      table.insert(filterList, value)
    end
  end
  self.gmObjs.value = filterList
end

function GmPanel:UpdateTopBtnSelectState(new, old)
  if self.mainBtnTypeList[new + 1] then
    self.mainBtnTypeList[new + 1].color = CS.UnityEngine.Color.blue
  end
  if old and self.mainBtnTypeList[old + 1] then
    self.mainBtnTypeList[old + 1].color = CS.UnityEngine.Color.black
  end
end

function GmPanel:UpdateSubBtnSelectState(new, old)
  if self.subBtnTypeList[new] then
    self.subBtnTypeList[new].color = CS.UnityEngine.Color.blue
  end
  if old and self.subBtnTypeList[old] then
    self.subBtnTypeList[old].color = CS.UnityEngine.Color.black
  end
end

function GmPanel:OnClickMainTypeBtn(index)
  self.curSelectType.value = index - 1
end

function GmPanel:OnClickSubTypeBtn(index)
  self.curSelectSubType.value = index
end

function GmPanel:UpdateSubBtnData()
  local mainType = self.curSelectType.value
  if self.subBtnData == nil then
    self.subBtnData = {}
  else
    table.clear(self.subBtnData)
  end
  if 0 == mainType then
    return self.subBtnData
  end
  for _, v in pairs(DT.GMSubtypeConfig) do
    if mainType == v.TypeID then
      table.insert(self.subBtnData, v)
    end
  end
  if not DT.GMTypeConfig[mainType] then
    local subTypeCount = #self.subBtnData
    local gmConfig = GmClientUtils.GetGmConfig()
    for _, cfg in pairs(gmConfig) do
      if cfg.subtype and nil == tonumber(cfg.subtype) then
        local isFind = false
        for _, v in pairs(self.subBtnData) do
          if v.Name == cfg.subtype then
            isFind = true
            break
          end
        end
        if not isFind then
          table.insert(self.subBtnData, {
            ID = subTypeCount + 1,
            TypeID = subTypeCount + 1,
            SubtypeID = subTypeCount + 1,
            Name = cfg.subtype,
            Sort = cfg.id
          })
          subTypeCount = subTypeCount + 1
        end
      end
    end
    table.sort(self.subBtnData, function(a, b)
      return a.Sort < b.Sort
    end)
  end
  return self.subBtnData
end

function GmPanel:UpdateTopBtnData()
  local tbl = DT.GMTypeConfig
  if self.mainBtnData == nil then
    self.mainBtnData = table.clone(tbl)
  else
    table.clear(self.mainBtnData)
    for k, v in pairs(tbl) do
      table.insert(self.mainBtnData, v)
    end
  end
  local btnCount = #self.mainBtnData
  local gmConfig = GmClientUtils.GetGmConfig()
  for _, cfg in pairs(gmConfig) do
    if cfg.gmType and nil == tonumber(cfg.gmType) then
      local isFind = false
      for _, v in pairs(self.mainBtnData) do
        if v.Name == cfg.gmType then
          isFind = true
          break
        end
      end
      if not isFind then
        table.insert(self.mainBtnData, {
          TypeID = btnCount + 1,
          Name = cfg.gmType,
          Sort = cfg.id
        })
        btnCount = btnCount + 1
      end
    end
  end
  table.sort(self.mainBtnData, function(a, b)
    return a.Sort < b.Sort
  end)
  table.insert(self.mainBtnData, 1, {
    Name = "最近使用"
  })
  return self.mainBtnData
end

function GmPanel:GetRecentUseGm()
  do return MobileFileDataManager.Instance.GetCommFileValue, MobileFileDataManager.Instance, CommonDefine.LocalSaveKeyCommon.RecentGm end
  return MobileFileDataManager.Instance.GetCommFileValue, MobileFileDataManager.Instance, CommonDefine.LocalSaveKeyCommon.RecentGm, nil
end

function GmPanel:InitGmBtnList(mainType, subType)
  local gmObjs = {}
  local gmConfig = GmClientUtils.GetGmConfig()
  if 0 == mainType then
    local tbl = self.recentUseGm
    if tbl then
      for _, v in ipairs(tbl) do
        local tmp = gmConfig[tonumber(v)]
        if tmp then
          table.insert(gmObjs, tmp)
        end
      end
    end
  else
    local btnTypeCfg = self.mainBtnData[mainType + 1]
    local subTypeCfg = self.subBtnData[subType]
    if not subTypeCfg then
      return
    end
    local mainTypeIndex = tostring(mainType or 1)
    for k, v in pairs(gmConfig) do
      if v.gmType == mainTypeIndex and v.subtype == subType then
        table.insert(gmObjs, v)
      elseif v.gmType == btnTypeCfg.Name and v.subtype == subTypeCfg.Name then
        table.insert(gmObjs, v)
      end
    end
    table.sort(gmObjs, function(a, b)
      if a.order and b.order and a.order ~= b.order then
        return a.order < b.order
      end
      return a.id < b.id
    end)
  end
  self.gmObjs.value = gmObjs
end

function GmPanel:GenGmBtnListByType(type, subtype)
  self:InitGmBtnList(type, subtype)
end

function GmPanel:OnUnbind()
  if next(self.recentUseGm) then
    MobileFileDataManager.Instance:SetCommFileValue(CommonDefine.LocalSaveKeyCommon.RecentGm, self.recentUseGm)
    MobileFileDataManager.Instance:OnSaveCommInfo()
  end
  local select = self.curSelectType.value
  if self.mainBtnTypeList[select + 1] then
    self.mainBtnTypeList[select + 1].color = CS.UnityEngine.Color.black
  end
  select = self.curSelectSubType.value
  if self.subBtnTypeList[select] then
    self.subBtnTypeList[select].color = CS.UnityEngine.Color.black
  end
end

function GmPanel:CreateGmCommondBtn(gmConfig)
  do return self.binder.BindNewComponent, self.binder, self.ui.Content, require(Urls.GmCommandItem), GmcommandItemResource, gmConfig end
  return self.binder.BindNewComponent, self.binder, self.ui.Content, require(Urls.GmCommandItem), GmcommandItemResource, gmConfig, self
end

function GmPanel:OnClickBtnExit()
  UIManager.Instance:CloseByUrl(Urls.GmPanel)
end

return GmPanel
