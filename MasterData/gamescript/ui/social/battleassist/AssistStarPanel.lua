local AssistStarPanel, Super = System.NewClass("AssistStarPanel", UIBasePanel)
AssistStarPanel.uiResCls = "UI/UI_Social/UI_Social_Prefab/UI_Social_Popup_CommonlyAssist.prefab"

function AssistStarPanel:ctor(assistModel)
  Super.ctor(self)
  self.model = assistModel
end

function AssistStarPanel:OnBind(binder)
  self.binder = binder
  self.nameLengthMin, self.nameLengthMax = StrUtils.GetNameLengthRange()
  self.binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self.binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  self.showAssistData = {}
  self._isSearchMode = false
  self:BindEvents()
  self:_OnBindCount()
  self:_OnBindSearchGroup()
  self:_OnBindTableview()
end

function AssistStarPanel:BindEvents()
  self.binder:BindEvent(EventMgr.Instance.SocialStarAssistChanged, System.fn(self, self._RefreshStarAssistData))
  self.binder:BindEvent(EventMgr.Instance.SocialSetStarAssist, System.fn(self, self._RefreshSingleStarAssistData))
end

function AssistStarPanel:_OnBindCount()
  self.binder:BindToText(self.ui.Text_Count, function()
    local limit = DT.GetConstant("CommonUseBattleHelpNumLimit")
    local count = #self.model.starAssistList
    do return LT.Textf, "CommonlyAssistCount", count end
    return LT.Textf, "CommonlyAssistCount", count, limit
  end)
end

function AssistStarPanel:_OnBindSearchGroup()
  self.binder:BindZ1Button(self.ui.Btn_Search, System.fn(self, self._OnClickSearch))
  self.binder:BindToInputValueChange(self.ui.InputField_Player, System.fn(self, self._OnInputValueChange))
end

function AssistStarPanel:_OnInputValueChange()
  local inputStr = self.binder:GetInputText(self.ui.InputField_Player)
  local subStr = StrUtils.SubStr(inputStr, self.nameLengthMax)
  if subStr ~= inputStr then
    self.binder:SetInputText(self.ui.InputField_Player, subStr)
  end
end

function AssistStarPanel:_OnBindTableview()
  self.cbinderMap = {}
  local w = self.ui.UI_Social_Panel_HelpList_Item.transform.sizeDelta.x
  local h = self.ui.UI_Social_Panel_HelpList_Item.transform.sizeDelta.y
  self.StarAssistView = self:CreateTableview(self.ui.ScrollView_Assist, function()
    if not self.showAssistData then
      return 0
    end
    return #self.showAssistData
  end, function(view, index)
    local cell = self:DequeueCell(view, self.ui.UI_Social_Panel_HelpList_Item)
    local cbinder = self.cbinderMap[cell.gameObject]
    if cbinder then
      cbinder:teardown()
    end
    cbinder = self.binder:createChild(cell.gameObject)
    self.cbinderMap[cell.gameObject] = cbinder
    self:_UpdateAssistStarItem(cbinder, cell.gameObject, index)
    return cell
  end, function()
    return w, h
  end)
end

function AssistStarPanel:_UpdateAssistStarItem(childBinder, go, index)
  local data = self.showAssistData[index]
  local itemUI = UI_Social_Panel_HelpList_ItemResource(go)
  local weaponUIs = {
    UI_Dungeons_Item_WeaponResource(itemUI.UI_Dungeons_Item_Weapon_1),
    UI_Dungeons_Item_WeaponResource(itemUI.UI_Dungeons_Item_Weapon_2)
  }
  childBinder:BindComponent(BattleAssistStarItem(itemUI, self.model, data, weaponUIs))
end

function AssistStarPanel:_SetShowAssistData(data)
  self.showAssistData = data
end

function AssistStarPanel:_RefreshStarAssistData(data, isSearchMode)
  self._isSearchMode = true == isSearchMode
  self:_SetShowAssistData(data)
  self:_RefreshStarAssistView()
  self:_RefreshCount()
end

function AssistStarPanel:_RefreshSingleStarAssistData(assistData, isStarAssist)
  self.model:UpdateAssistStarAssist(assistData, isStarAssist)
  if isStarAssist then
    self.model:AddStarAssist(assistData)
  else
    self.model:RemoveStarAssist(assistData)
  end
  if self._isSearchMode then
    self:_SetShowAssistData(self.model:GetSearchAssistList())
  else
    self:_SetShowAssistData(self.model:GetstarAssistList())
  end
  self:_RefreshStarAssistView()
  self:_RefreshCount()
end

function AssistStarPanel:_RefreshCount()
  local limit = DT.GetConstant("CommonUseBattleHelpNumLimit")
  local count = #self.model:GetstarAssistList()
  self.binder:SetText(self.ui.Text_Count, LT.Textf("CommonlyAssistCount", count, limit))
end

function AssistStarPanel:_RefreshStarAssistView()
  self.StarAssistView:ReloadData()
  self.binder:SetActive(self.ui.Group_Null_Black, #self.showAssistData <= 0)
end

function AssistStarPanel:_OnClickSearch()
  local inputStr = self.binder:GetInputText(self.ui.InputField_Player)
  if string.isempty(inputStr) then
    Alert.ShowStr(LT.Text("SocialSystemEnterUID"))
    return
  end
  if inputStr == tostring(PlayerDataUtils.GetPlayerUid()) then
    Alert.ShowStr(LT.Text("SocialSystemCannotSearchForOneself"))
    return
  end
  SocialDataUtils.ReqOnSocialVisit(tonumber(inputStr), function(playerData)
    if playerData then
      local assistAwakerInfo = playerData.facade.team.assistAwaker
      SocialDataUtils.ReqQueryAwaker(playerData.facade.uid, assistAwakerInfo.tid, function(awakerData)
        local assistList = self.model:CreateSearchStarAssistList(playerData, awakerData)
        self.model:SetSearchAssistList(assistList)
        self:_RefreshStarAssistData(self.model:GetSearchAssistList(), true)
      end)
    end
  end, function()
    Alert.ShowStr(LT.Text("SocialSystemNoFoundInTheSearch"))
  end)
  return
end

function AssistStarPanel:OnUnbind()
  Super.OnUnbind(self)
end

return AssistStarPanel
