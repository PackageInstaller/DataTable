---自动生成代码----start----
local UIFirHeadView = BaseClass( 'UIFirHeadView' , BaseView )
local M = UIFirHeadView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.HeroHeadItem =   self._binder:GetValue('HeroHeadItem')  
  self.stateBreak =   self:AddValue('UI.Ctrl.UITeamConfig.UIBreakCtrl','UI.View.UITeamConfig.UIBreakView','stateBreak')  
  self.labName = self:AddBaseCom( GameUIText ,'labName')


end

return UIFirHeadView
---自动生成代码----end----