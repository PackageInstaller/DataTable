_class("UIHomelandLevelSignPop", UIController)
UIHomelandLevelSignPop = UIHomelandLevelSignPop

function UIHomelandLevelSignPop:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.data = self.mHomeland:GetHomelandLevelData()
end

function UIHomelandLevelSignPop:OnShow(uiParams)
  self.Content = self:GetUIComponent("UISelectObjectPath", "Content")
  self:Flush()
end

function UIHomelandLevelSignPop:OnHide()
end

function UIHomelandLevelSignPop:Flush()
  local levels = self.data.levels
  self.Content:SpawnObjects("UIHomelandLevelSignPopItem", #levels)
  local uis = self.Content:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    local level = levels[i]
    ui:Flush(level)
  end
end

function UIHomelandLevelSignPop:bgOnClick(go)
  self:CloseDialog()
end
