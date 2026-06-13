---自动生成代码----start----
local RoleActionItemView = BaseClass( 'RoleActionItemView' , BaseView )
local M = RoleActionItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.HeroItem =   self:AddValue('UI.Ctrl.Role.UIHeroItemCtrl','UI.View.Role.UIHeroItemView','HeroItem')  
  self.RedPoint =   self._binder:GetValue('RedPoint')  
  self.UIState =   self._binder:GetValue('UIState')  
  self.imgProfession = self:AddBaseCom( GameUIImage ,'imgProfession')
  self.levelTf = self:AddBaseCom( GameUIText ,'levelTf')


end

return RoleActionItemView
---自动生成代码----end----