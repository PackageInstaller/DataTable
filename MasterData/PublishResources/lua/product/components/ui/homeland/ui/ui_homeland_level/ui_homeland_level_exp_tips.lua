_class("UIHomelandLevelExpTips", UIController)
UIHomelandLevelExpTips = UIHomelandLevelExpTips

function UIHomelandLevelExpTips:Constructor()
  self.itemCount = 4
end

function UIHomelandLevelExpTips:OnShow(uiParams)
  self.itemPool = self:GetUIComponent("UISelectObjectPath", "content")
  self:Flush()
end

function UIHomelandLevelExpTips:Flush()
  self.itemPool:SpawnObjects("UIHomelandLevelExpTipsItem", self.itemCount)
  local items = self.itemPool:GetAllSpawnList()
  for i = 1, self.itemCount do
    items[i]:Flush(i)
  end
end

function UIHomelandLevelExpTips:bgOnClick(go)
  self:CloseDialog()
end
