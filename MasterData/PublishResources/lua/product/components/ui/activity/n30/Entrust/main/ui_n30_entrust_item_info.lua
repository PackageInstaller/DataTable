_class("UIN30EntrustItemInfo", UIController)
UIN30EntrustItemInfo = UIN30EntrustItemInfo

function UIN30EntrustItemInfo:Constructor()
end

function UIN30EntrustItemInfo:LoadDataOnEnter(TT, res, uiParams)
  self._reward = uiParams[1]
  self._deltaPosition = uiParams[2]
end

function UIN30EntrustItemInfo:OnShow(uiParams)
  self._animation = self:GetUIComponent("Animation", "animation")
  self._itemInfo = self:GetUIComponent("UISelectObjectPath", "itemInfo")
  self._tips = self._itemInfo:SpawnObject("UISelectInfo")
  self:Flush()
end

function UIN30EntrustItemInfo:OnHide()
end

function UIN30EntrustItemInfo:BtnAnywhereOnClick()
  self:CloseDialog()
end

function UIN30EntrustItemInfo:Flush()
  self._tips:SetData(self._reward.assetid, self._deltaPosition + self._animation.transform.position)
end
