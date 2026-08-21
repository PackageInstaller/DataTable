_class("UICommonItemInfo", UIController)
UICommonItemInfo = UICommonItemInfo

function UICommonItemInfo:Constructor()
end

function UICommonItemInfo:LoadDataOnEnter(TT, res, uiParams)
  self._reward = uiParams[1]
  self._deltaPosition = uiParams[2]
  self._infoPrefab = uiParams[3]
end

function UICommonItemInfo:OnShow(uiParams)
  self._animation = self:GetUIComponent("Animation", "animation")
  self._itemInfo = self:GetUIComponent("UISelectObjectPath", "itemInfo")
  if self._infoPrefab ~= nil then
    self._itemInfo:Engine():SetObjectName(self._infoPrefab)
  end
  self._tips = self._itemInfo:SpawnObject("UISelectInfo")
  self:Flush()
end

function UICommonItemInfo:OnHide()
end

function UICommonItemInfo:BtnAnywhereOnClick()
  self:CloseDialog()
end

function UICommonItemInfo:Flush()
  self._tips:SetData(self._reward.assetid, self._deltaPosition + self._animation.transform.position)
end
