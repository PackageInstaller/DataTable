local SelectItemBaseView, Super = NewClass("SelectItemBaseView", BaseView)
SelectItemBaseView.uiResCls = UI_Events_Popup_Optional_OptimizedResource

function SelectItemBaseView:ctor(data)
  Super.ctor(self)
  self.tids = data.tids
  self.confirmFunc = data.confirmFunc
  self.selectTid = data.selectTid
  self:InitViewData()
end

function SelectItemBaseView:InitViewData()
  self.showList = self.tids
  self.curSelectTid = self.showList and self.showList[1] or 0
  if self.selectTid then
    self.curSelectTid = self.selectTid
  end
  local weaponList = ItemDataUtils.GetWeaponList()
  self.weaponTid2MaxLevelWeaponDataMap = {}
  for _, weaponData in pairs(weaponList) do
    local level = weaponData.level
    local cacheData = self.weaponTid2MaxLevelWeaponDataMap[weaponData.tid]
    local cacheLevel = cacheData and cacheData.level
    if not cacheLevel or level > cacheLevel then
      self.weaponTid2MaxLevelWeaponDataMap[weaponData.tid] = weaponData
    end
  end
end

function SelectItemBaseView:RegisterNotifications()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Details, System.fn(self, self.OnClickDetails))
  self:AddButtonClickListener(self.ui.Btn_Receive, System.fn(self, self.OnClickReceive))
  self:InitShowListView()
end

function SelectItemBaseView:InitShowListView()
  self.showListView = self:CreateTableview(self.ui.ScrollView, function()
    if not self.showList then
      return 0
    end
    return #self.showList
  end, function(view, index)
    do return self._ShowItemCellAtIndex, self, view end
    return self._ShowItemCellAtIndex, self, view, index
  end)
end

function SelectItemBaseView:_ShowItemCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Events_Item_Optional)
  local tid = self.showList[index]
  local weaponData = self.weaponTid2MaxLevelWeaponDataMap[tid]
  local viewData = {
    isSelect = self.curSelectTid == tid,
    clickFunc = function()
      self:_SetCurSelectTid(tid)
    end,
    weaponTid = tid,
    refineLevel = weaponData and weaponData.level,
    weaponUid = weaponData and weaponData.uid
  }
  self:AddViewComponentOnce(cell.gameObject, CompSelectWeaponItem, viewData)
  return cell
end

function SelectItemBaseView:RegisterEvents()
end

function SelectItemBaseView:OnClickReceive()
  if not self:_CheckSelectTidValid() or not self.confirmFunc then
    return
  end
  self.confirmFunc(self.curSelectTid)
  self:Close()
end

function SelectItemBaseView:OnClickDetails()
  if not self:_CheckSelectTidValid() then
    return
  end
  local weaponData = self.weaponTid2MaxLevelWeaponDataMap[self.curSelectTid]
  ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.TipsParentNode, weaponData and weaponData.uid, self.curSelectTid)
end

function SelectItemBaseView:OnEnterView()
  Super.OnEnterView(self)
  self:SetText(self.ui.Text_Title, LT.Text("WeaponSelectTitle"))
  self.showListView:ReloadData()
  self:SetButtonText(self.ui.Btn_Receive, LT.Text("UniversalConfirmButton"))
  if self.ui.Group_Tips_Left then
    self.ui.Group_Tips_Left:SetActive(false)
  end
  if self.ui.Group_Tips_Middle then
    self.ui.Group_Tips_Middle:SetActive(false)
  end
end

function SelectItemBaseView:_CheckSelectTidValid()
  return self.curSelectTid and 0 ~= self.curSelectTid
end

function SelectItemBaseView:_SetCurSelectTid(num)
  self.curSelectTid = num
  self.showListView:ReloadData()
end

return SelectItemBaseView
