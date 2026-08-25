local T_Text = typeof(CS.UnityEngine.UI.Text)
local GmView, Super = NewClass("GmView", BaseView)
GmView.uiResCls = GmPanelResource

function GmView:ctor(sceneType)
  Super.ctor(self)
  self._sceneType = sceneType
  self._curSelectType = 0
  self._curSelectSubType = 0
  self._searchWord = ""
  self._displayGmObjs = {}
  self._mainTableView = nil
  self._subTableView = nil
  self._contentTableView = nil
end

function GmView:OnBuildView()
  if GmModel.Instance:HasRecentUseGm() then
    self._curSelectType = 0
    self._curSelectSubType = 0
  else
    self._curSelectType = 1
    self._curSelectSubType = 1
  end
  GmModel.Instance:BuildSubBtnData(self._curSelectType)
  GmModel.Instance:BuildMainBtnData()
  self:_BuildMainTableView()
  self:_BuildSubTableView()
  self:_BuildContentTableView()
end

function GmView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Exit, System.fn(self, self._OnClickBtnExit))
  self:AddButtonClickListener(self.ui.Btn_Active, System.fn(self, self._OnClickBtnActive))
  self:AddButtonClickListener(self.ui.Btn_Test, System.fn(self, self._OnClickBtnTest))
  self:AddButtonClickListener(self.ui.Btn_Battle_Test, System.fn(self, self._OnClickBattleTest))
  self:AddButtonClickListener(self.ui.Btn_Battle_Pvp_Test, System.fn(self, self._OnClickBattlePvpTest))
  self:AddButtonClickListener(self.ui.Btn_PvP_Match, System.fn(self, self._OnClickPvpMatch))
  self:AddButtonClickListener(self.ui.Btn_AVG_Test, System.fn(self, self._OnClickAvgTest))
end

function GmView:OnEnterView()
  Super.OnEnterView(self)
  self:SetRawText(self.ui.Text_Battle_Test, "战斗2.0")
  self:SetRawText(self.ui.Text_AVG_Test, "AVG剧情测试")
  self._searchWord = GmModel.Instance:GetSearchWord()
  if self._searchWord and #self._searchWord > 0 then
    self:SetInputText(self.ui.SearchInputField, self._searchWord)
  end
  GmModel.Instance:BuildGmObjsByType(self._curSelectType, self._curSelectSubType)
  self:_RefreshContentList()
  if self._mainTableView then
    self._mainTableView:ReloadData()
  end
  if self._subTableView then
    self._subTableView:ReloadData()
  end
  local curWord = self:GetInputText(self.ui.SearchInputField) or ""
  if #curWord > 0 then
    self._searchWord = ""
    self:_DoSearch()
  end
  self:BindTimer(0.1, -1, function()
    self:_DoSearch()
  end)
  self:_RefreshInfoText()
  self:BindTimer(1, -1, function()
    self:_RefreshInfoText()
  end)
end

function GmView:OnExitView()
  GmModel.Instance:SaveRecentUseGm()
  Super.OnExitView(self)
end

function GmView:_BuildMainTableView()
  local template = self.ui.Btn_Type1
  local cellTrans = template.transform
  local width, height = cellTrans.sizeDelta.x, cellTrans.sizeDelta.y
  self._mainTableView = self:CreateTableview(self.ui.TopView, function()
    return #GmModel.Instance:GetMainBtnData()
  end, function(view, idx)
    do return self._OnMainCellAtIndex, self, view, template end
    return self._OnMainCellAtIndex, self, view, template, idx
  end, function()
    return width, height
  end)
end

function GmView:_OnMainCellAtIndex(view, template, idx)
  local data = GmModel.Instance:GetMainBtnData()[idx]
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(template)
  local uiText = cell.gameObject.transform:GetChild(0):GetComponent(T_Text)
  if uiText then
    uiText.text = data.Name or ""
    if idx - 1 == self._curSelectType then
      uiText.color = CS.UnityEngine.Color.blue
    else
      uiText.color = CS.UnityEngine.Color.black
    end
  end
  self:AddButtonClickListener(cell.gameObject, function()
    self:_OnClickMainType(idx)
  end)
  return cell
end

function GmView:_BuildSubTableView()
  local template = self.ui.Btn_SubType
  local cellTrans = template.transform
  local width, height = cellTrans.sizeDelta.x, cellTrans.sizeDelta.y
  self._subTableView = self:CreateTableview(self.ui.LeftView, function()
    return #GmModel.Instance:GetSubBtnData()
  end, function(view, idx)
    do return self._OnSubCellAtIndex, self, view, template end
    return self._OnSubCellAtIndex, self, view, template, idx
  end, function()
    return width, height
  end)
end

function GmView:_OnSubCellAtIndex(view, template, idx)
  local data = GmModel.Instance:GetSubBtnData()[idx]
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(template)
  local uiText = cell.gameObject.transform:GetChild(0):GetComponent(T_Text)
  if uiText then
    uiText.text = data.Name or ""
    if idx == self._curSelectSubType then
      uiText.color = CS.UnityEngine.Color.blue
    else
      uiText.color = CS.UnityEngine.Color.black
    end
  end
  self:AddButtonClickListener(cell.gameObject, function()
    self:_OnClickSubType(idx)
  end)
  return cell
end

function GmView:_BuildContentTableView()
  self._contentTemplate = self.ui.GmcommandItem
  local cellTrans = self._contentTemplate.transform
  local width, height = cellTrans.sizeDelta.x, cellTrans.sizeDelta.y
  self._contentTableView = self:CreateTableview(self.ui.ScrollView_GmList, function()
    return #self._displayGmObjs
  end, function(view, idx)
    do return self._OnContentCellAtIndex, self, view end
    return self._OnContentCellAtIndex, self, view, idx
  end, function()
    return width, height
  end)
end

function GmView:_OnContentCellAtIndex(view, idx)
  local config = self._displayGmObjs[idx]
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self._contentTemplate)
  self:AddViewComponentOnce(cell.gameObject, GmCommandItem, config)
  return cell
end

function GmView:_RefreshContentList()
  local objs = GmModel.Instance:GetGmObjs()
  local display = {}
  for _, obj in ipairs(objs) do
    if obj.name and obj.name ~= "" and 0 ~= obj.show then
      table.insert(display, obj)
    end
  end
  self._displayGmObjs = display
  if self._contentTableView then
    self._contentTableView:ReloadData()
  end
end

function GmView:_OnClickMainType(idx)
  local newType = idx - 1
  self._curSelectType = newType
  GmModel.Instance:BuildSubBtnData(newType)
  if 0 == newType then
    self._curSelectSubType = 0
  else
    self._curSelectSubType = 1
  end
  GmModel.Instance:BuildGmObjsByType(newType, self._curSelectSubType)
  self:_RefreshContentList()
  if self._mainTableView then
    self._mainTableView:ReloadData()
  end
  if self._subTableView then
    self._subTableView:ReloadData()
  end
end

function GmView:_OnClickSubType(idx)
  self._curSelectSubType = idx
  GmModel.Instance:BuildGmObjsByType(self._curSelectType, idx)
  self:_RefreshContentList()
  if self._subTableView then
    self._subTableView:ReloadData()
  end
end

function GmView:_DoSearch()
  local curWord = self:GetInputText(self.ui.SearchInputField) or ""
  if curWord == self._searchWord then
    return
  end
  self._searchWord = curWord
  GmModel.Instance:FilterGmObjsBySearch(curWord)
  self:_RefreshContentList()
end

function GmView:_RefreshInfoText()
  self:SetRawText(self.ui.Text_User, self:_BuildUserInfoText())
  self:SetRawText(self.ui.Text_Net, self:_BuildNetInfoText())
end

function GmView:_BuildUserInfoText()
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
end

function GmView:_BuildNetInfoText()
  local strTime = TimeUtils.GetServerTime()
  strTime = TimeUtils.ServerTimestampToString(math.floor(strTime), TimeUtils.TimeExactType.MinuteShort)
  local fpsLimit = SettingManager:GetSettingData(CommonDefine.SettingUniqueName.FPSLimit)
  local commonId = SettingManager:GetSettingData(CommonDefine.SettingUniqueName.Resolution)
  if not commonId or not DT.CommonID[commonId] then
    return ""
  end
  local resolution = DT.CommonID[commonId].Desc
  local textLevel = string.format("帧率上限 %s 当前分辨率 %s", LT.Text(fpsLimit), LT.Text(resolution))
  do return string.format, "%s %s 网络:%sms ", strTime, textLevel end
  return string.format, "%s %s 网络:%sms ", strTime, textLevel, DataCenter.playerData.netDelayTime
end

function GmView:_OnClickBtnExit()
  self:Close()
end

function GmView:_OnClickBtnActive()
  GmManager.SetGmPanelVisible(false)
end

function GmView:_OnClickBtnTest()
  __ProtoTest.test()
end

function GmView:_OnClickBattleTest()
  UIManager.Instance:Reopen(Urls.BattleDbgEntryPanel, false)
  UIManager.Instance:CloseByUrl(Urls.GmPanel)
end

function GmView:_OnClickBattlePvpTest()
  UIManager.Instance:Reopen(Urls.BattleDbgEntryPanel, true)
  UIManager.Instance:CloseByUrl(Urls.GmPanel)
end

function GmView:_OnClickPvpMatch()
  UIManager.Instance:Reopen(Urls.PvPMatchPanel)
  UIManager.Instance:CloseByUrl(Urls.GmPanel)
end

function GmView:_OnClickAvgTest()
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
end

return GmView
