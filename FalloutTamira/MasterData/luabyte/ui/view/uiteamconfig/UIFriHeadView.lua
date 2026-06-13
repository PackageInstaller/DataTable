---自动生成代码----start----
local UIFriHeadView = BaseClass( 'UIFriHeadView' , BaseView )
local M = UIFriHeadView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.HeroHeadItem =   self._binder:GetValue('HeroHeadItem')  
  self.stateBreak =   self:AddValue('UI.Ctrl.UITeamConfig.UIBreakCtrl','UI.View.UITeamConfig.UIBreakView','stateBreak')  
  self.labFriendName = self:AddBaseCom( GameUIText ,'labFriendName')
  self.tfSame =   self._binder:GetValue('tfSame')  
  self.btnFri = self:AddBaseCom( UIButton ,'btnFri')


end

return UIFriHeadView
---自动生成代码----end----