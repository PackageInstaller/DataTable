_class("UIQuestAwardsInfoController", UIController)
UIQuestAwardsInfoController = UIQuestAwardsInfoController

function UIQuestAwardsInfoController:OnShow(uiParams)
  self._reward = uiParams[1]
  self._titleName = uiParams[2]
  self._itemCountPerRow = 1
  self._count = table.count(self._reward)
  self:_GetComponents()
  self:_OnValue()
end

function UIQuestAwardsInfoController:OnHide()
end

function UIQuestAwardsInfoController:_GetComponents()
  self._titleNameTex = self:GetUIComponent("UILocalizationText", "titleName")
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
  self._itemInfo = self:GetUIComponent("UISelectObjectPath", "itemInfo")
  self._selectInfo = self._itemInfo:SpawnObject("UISelectInfo")
end

function UIQuestAwardsInfoController:_OnValue()
  if self._titleName then
    self._titleNameTex:SetText(StringTable.Get(self._titleName))
  end
  local scrollView = self:GetGameObject("itemScrollView")
  local content = self:GetGameObject("pool")
  if self._count > 5 then
    scrollView:GetComponent("ScrollRect").enabled = true
    content:GetComponent("ContentSizeFitter").enabled = true
    content:GetComponent("GridLayoutGroup").padding.left = 88
    content:GetComponent("GridLayoutGroup").padding.right = 88
  else
    scrollView:GetComponent("ScrollRect").enabled = false
    content:GetComponent("ContentSizeFitter").enabled = false
    content:GetComponent("GridLayoutGroup").padding.left = 0
    local width = scrollView:GetComponent("RectTransform").sizeDelta.x
    content:GetComponent("RectTransform").sizeDelta = Vector2(width, content:GetComponent("RectTransform").sizeDelta.y)
  end
  self._pool:SpawnObjects("UIQuestAwardsInfoItem", self._count)
  self._items = self._pool:GetAllSpawnList()
  for i = 1, #self._items do
    self._items[i]:SetData(i, self._reward[i], function(matid, pos)
      self._selectInfo:SetData(matid, pos)
    end)
  end
  local bgCanvas = self:GetUIComponent("Canvas", "BGCanvas")
  self._blur = self:GetUIComponent("H3DUIBlurHelper", "Blur")
  self._blur.OwnerCamera = bgCanvas.worldCamera
  self._blur:RefreshBlurTexture()
end

function UIQuestAwardsInfoController:bgOnClick()
  self:CloseDialog()
end
