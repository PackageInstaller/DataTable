local ONEPAGESHOWNUM = 4
local ItemUseSelectView, Super = NewClass("ItemUseSelectView", BaseView)
ItemUseSelectView.uiResCls = UI_Passport_Choose_TipResource

function ItemUseSelectView:ctor(data, isPreview)
  Super.ctor(self)
  self._itemId = data.itemId
  self._useNum = data.useNum
  self._isPreview = isPreview or false
  self._rewardComps = {}
end

function ItemUseSelectView:OnBuildView()
  ItemUseSelectModel.Instance:SetItemId(self._itemId)
  ItemUseSelectModel.Instance:SetUseNum(self._useNum)
end

function ItemUseSelectView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnItemUseSelectChanged, self._OnSelectChanged, self)
end

function ItemUseSelectView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._OnClickConfirm))
  self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self._OnClickCancel))
end

function ItemUseSelectView:OnEnterView()
  Super.OnEnterView(self)
  self:SetActive(self.ui.Btn_Direct, false)
  self:SetActive(self.ui.Text_Num, false)
  self:SetActive(self.ui.ScrollView, false)
  self:SetActive(self.ui.ScrollView_Middle, true)
  if self._isPreview then
    self:SetText(self.ui.Text_Title, LT.Text("ChestPreviewTitle"))
    self:SetActive(self.ui.Btn_Confirm, false)
    self:SetActive(self.ui.Btn_Cancel, true)
  end
  self:_RefreshButtonText()
  self:_RefreshAllSlots()
end

function ItemUseSelectView:OnExitView()
  Super.OnExitView(self)
end

function ItemUseSelectView:IsItemSelected(tid)
  return ItemUseSelectModel.Instance:GetCurSelectTid() == tid
end

function ItemUseSelectView:SelectItem(tid)
  ItemUseSelectModel.Instance:SetCurSelectTid(tid)
  self:LocalNotify(NotifyId.OnItemUseSelectChanged)
end

function ItemUseSelectView:_OnSelectChanged()
  self:_RefreshButtonState()
  self:_RefreshSelectState()
end

function ItemUseSelectView:_RefreshButtonState()
  local notSelect = ItemUseSelectModel.Instance:IsNotSelect()
  if notSelect then
    self:SetButtonState(self.ui.Btn_Confirm, CommonDefine.BtnType.Unclickable)
  else
    self:SetButtonState(self.ui.Btn_Confirm, CommonDefine.BtnType.High)
  end
end

function ItemUseSelectView:_RefreshSelectState()
  local dropList = ItemUseSelectModel.Instance:GetDropList()
  local curSelectTid = ItemUseSelectModel.Instance:GetCurSelectTid()
  for i = 1, ONEPAGESHOWNUM do
    local itemData = dropList[i]
    local comp = self._rewardComps[i]
    if itemData and comp then
      comp:SetSelected(curSelectTid == itemData.tid)
    end
  end
end

function ItemUseSelectView:_RefreshButtonText()
  self:SetButtonText(self.ui.Btn_Confirm, LT.Text("BPChooseConfirmBtn"))
  if self._isPreview then
    self:SetButtonText(self.ui.Btn_Cancel, LT.Text("PreviewClose"))
  else
    self:SetButtonText(self.ui.Btn_Cancel, LT.Text("UniversalCancelButton"))
  end
end

function ItemUseSelectView:_RefreshAllSlots()
  local dropList = ItemUseSelectModel.Instance:GetDropList()
  local useNum = ItemUseSelectModel.Instance:GetUseNum()
  local curSelectTid = ItemUseSelectModel.Instance:GetCurSelectTid()
  for i = 1, ONEPAGESHOWNUM do
    local itemData = dropList[i]
    local obj = self.ui["UI_Passport_Choose_Reward_" .. i]
    if itemData then
      local num = itemData.num * useNum
      if curSelectTid == itemData.tid then
        ItemUseSelectModel.Instance:SetCurSelectNum(num)
      end
      local viewData = {
        tid = itemData.tid,
        num = num,
        isPreview = self._isPreview
      }
      local comp = self:AddViewComponentOnce(obj, CompItemUseSelectRewardItem, viewData)
      self._rewardComps[i] = comp
      obj:SetActive(true)
    else
      self:RemoveViewComponentOnce(obj, CompItemUseSelectRewardItem)
      self._rewardComps[i] = nil
      obj:SetActive(false)
    end
  end
end

function ItemUseSelectView:_OnClickConfirm()
  if ItemUseSelectModel.Instance:IsNotSelect() then
    Alert.ShowStr(LT.Text("BPChooseSelectHint"))
    return
  end
  PublicUIController.Instance:ReqUseChooseItem()
end

function ItemUseSelectView:_OnClickCancel()
  self:Close()
end

return ItemUseSelectView
