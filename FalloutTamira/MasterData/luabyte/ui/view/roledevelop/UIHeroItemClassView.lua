---自动生成代码----start----
local UIHeroItemClassView = BaseClass( 'UIHeroItemClassView' , BaseView )
local M = UIHeroItemClassView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.HeroItem =   self:AddValue('UI.Ctrl.Role.UIHeroItemCtrl','UI.View.Role.UIHeroItemView','HeroItem')  
  self.RedPoint =   self._binder:GetValue('RedPoint')  
  self.UIState =   self._binder:GetValue('UIState')  
  self.imgProfession = self:AddBaseCom( GameUIImage ,'imgProfession')


end

return UIHeroItemClassView
---自动生成代码----end----