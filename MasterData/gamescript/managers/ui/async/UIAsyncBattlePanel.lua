local UIAsyncBattlePanel, Super = NewClass("UIAsyncBattlePanel", UIAsyncLoadPanel)

function UIAsyncBattlePanel:___InitBridge()
  Super.___InitBridge(self)
  self:___AddBridges("boutAnimUI")
  self:___AddBridges("cardUI")
  self:___AddBridges("stageUI")
end

return UIAsyncBattlePanel
