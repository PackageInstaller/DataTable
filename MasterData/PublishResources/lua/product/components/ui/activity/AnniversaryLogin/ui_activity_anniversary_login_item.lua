_class("UIActivityAnniversaryLoginItem", UICustomWidget)
UIActivityAnniversaryLoginItem = UIActivityAnniversaryLoginItem

function UIActivityAnniversaryLoginItem:OnShow(uiParams)
end

function UIActivityAnniversaryLoginItem:OnHide(stamp)
end

function UIActivityAnniversaryLoginItem:SetData(roleAsset, state, tipsCallback)
  self._roleAsset = roleAsset
  self._tipsCallback = tipsCallback
  local itemId = roleAsset.assetid
  local itemCount = roleAsset.count
  UIWidgetHelper.SetItemIcon(self, itemId, "_icon")
  UIWidgetHelper.SetLocalizationText(self, "_text", itemCount)
  self:_SetState(state)
end

function UIActivityAnniversaryLoginItem:_SetState(state)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    [ETimeRewardRewardStatus.E_TIME_REWARD_UNKNOW] = {},
    [ETimeRewardRewardStatus.E_TIME_REWARD_CAN_RECV] = {
      "state_Completed"
    },
    [ETimeRewardRewardStatus.E_TIME_REWARD_RECVED] = {
      "state_Taken"
    },
    [ETimeRewardRewardStatus.E_TIME_REWARD_LOCK] = {
      "state_NotStart"
    }
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UIActivityAnniversaryLoginItem:BtnOnClick(go)
  if self._tipsCallback then
    self._tipsCallback(self._roleAsset.assetid, go.transform.position)
  end
end
