_class("UIHomePetInviteEnable", UIController)
UIHomePetInviteEnable = UIHomePetInviteEnable

function UIHomePetInviteEnable:LoadDataOnEnter(TT, res, uiParams)
end

function UIHomePetInviteEnable:OnShow(uiParams)
  self._building = uiParams[1]
  self._buildId = self._building:GetBuildId()
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  self._homelandClient = homeLandModule:GetClient()
  self._inviteManager = self._homelandClient:GetHomelandPetInviteManager()
  self:GetComponent()
  self:RefreshUI()
end

function UIHomePetInviteEnable:OnHide()
end

function UIHomePetInviteEnable:RefreshUI()
  if self._building ~= nil then
    local cfg = Cfg.cfg_item_architecture[self._building:GetArchitecture().asset_id]
    self._titleText:SetText(StringTable.Get(cfg.Name))
    self:RefreshCanInvitedList()
  end
end

function UIHomePetInviteEnable:GetComponent()
  self._titleText = self:GetUIComponent("UILocalizationText", "titleText")
  self._dynamicList = self:GetUIComponent("UIDynamicScrollView", "caninvitepar")
  self._all = self:GetGameObject("all")
end

function UIHomePetInviteEnable:RefreshCanInvitedList()
  self._itemCountPerRow = 2
  self._invitEnableList = self._inviteManager:GetInteractEnablePetList(self._building)
  if self._invitEnableList ~= nil and #self._invitEnableList > 0 then
    self._dynamicListSize = #self._invitEnableList
    self._dynamicListRowSize = math.floor((self._dynamicListSize - 1) / self._itemCountPerRow + 1)
    self._all:SetActive(false)
    self._dynamicList:InitListView(self._dynamicListRowSize, function(scrollView, index)
      return self:_SpawnListItem(scrollView, index)
    end)
    self._dynamicList:MovePanelToItemIndex(0, 0)
  else
    self._all:SetActive(true)
  end
end

function UIHomePetInviteEnable:_SpawnListItem(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIHomePetInviteItemEnable", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local listItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    if itemIndex > self._dynamicListSize then
      listItem:GetGameObject():SetActive(false)
    else
      listItem:GetGameObject():SetActive(true)
      self:_SetListItemData(listItem, itemIndex)
    end
  end
  return item
end

function UIHomePetInviteEnable:BtnCloseOnClick(go)
  self:CloseDialog()
end

function UIHomePetInviteEnable:_SetListItemData(listItem, index)
  listItem:SetData(index, self._invitEnableList[index], self._inviteManager, function(idx)
    self:ListItemOnClick(idx)
  end, self._atlas)
end

function UIHomePetInviteEnable:ListItemOnClick(index)
end
