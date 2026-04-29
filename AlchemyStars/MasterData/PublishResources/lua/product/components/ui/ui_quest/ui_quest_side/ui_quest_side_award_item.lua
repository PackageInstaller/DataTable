_class("UIQuestSideAwardItem", UICustomWidget)
UIQuestSideAwardItem = UIQuestSideAwardItem

function UIQuestSideAwardItem:OnShow(uiParams)
end

function UIQuestSideAwardItem:SetData(id, params, callback, hideRaycast)
  local sop = self:GetUIComponent("UISelectObjectPath", "pool")
  self.item = sop:SpawnObject("UIAsset")
  self.item:SetItemData(params)
  self.item:SetData(id)
  self.id = id
  self.callback = callback
  if hideRaycast ~= nil then
    self:HideRaycast(hideRaycast)
  end
end

function UIQuestSideAwardItem:HideRaycast(hide)
  local g = self:GetUIComponent("Graphic", "Btn")
  if g then
    if hide then
      g.raycastTarget = false
    else
      g.raycastTarget = true
    end
  end
end

function UIQuestSideAwardItem:BtnOnClick(go)
  if self.callback then
    self.callback(self.id, go.transform.position)
  end
end
