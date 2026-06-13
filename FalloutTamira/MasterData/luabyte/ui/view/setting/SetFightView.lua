---自动生成代码----start----
local SetFightView = BaseClass( 'SetFightView' , BaseView )
local M = SetFightView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.tg_operationView = self:AddBaseCom( UIToggle ,'tg_operationView')
  self.tg_shakeCamera = self:AddBaseCom( UIToggle ,'tg_shakeCamera')
  self.tg_skillShow = self:AddBaseCom( UIToggle ,'tg_skillShow')
  self.tg_cameraFocus = self:AddBaseCom( UIToggle ,'tg_cameraFocus')
  self.tg_showMonsterHp = self:AddBaseCom( UIToggle ,'tg_showMonsterHp')
  self.tg_hideMonsterHp = self:AddBaseCom( UIToggle ,'tg_hideMonsterHp')
  self.toggleGroup_showMonsterHp = self:AddBaseCom( UIToggleGroup ,'toggleGroup_showMonsterHp')
  self.tg_deployGridShowAllways = self:AddBaseCom( UIToggle ,'tg_deployGridShowAllways')


end

return SetFightView
---自动生成代码----end----