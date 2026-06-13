---自动生成代码----start----
local RoleFashionUIView = BaseClass( 'RoleFashionUIView' , BaseView )
local M = RoleFashionUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.fashionCardList = self:AddBaseCom( BigMiddleScrollView ,'fashionCardList')
  self.posterBtn = self:AddBaseCom( UINewButton ,'posterBtn')
  self.weaponBtn = self:AddBaseCom( UINewButton ,'weaponBtn')
  self.state =   self._binder:GetValue('state')  
  self.btnDress = self:AddBaseCom( UINewButton ,'btnDress')
  self.btnBuy = self:AddBaseCom( UINewButton ,'btnBuy')
  self.btnGoToGet = self:AddBaseCom( UINewButton ,'btnGoToGet')
  self.arrowLeft = self:AddBaseCom( UINewButton ,'arrowLeft')
  self.arrowRight = self:AddBaseCom( UINewButton ,'arrowRight')
  self.HeroHeadItem =   self._binder:GetValue('HeroHeadItem')  
  self.fashionDes = self:AddBaseCom( GameUIText ,'fashionDes')
  self.fashionLeftName = self:AddBaseCom( GameUIText ,'fashionLeftName')
  self.fashionRightName = self:AddBaseCom( GameUIText ,'fashionRightName')
  self.wayValue = self:AddBaseCom( GameUIText ,'wayValue')
  self.weaponState =   self._binder:GetValue('weaponState')  
  self.comCost =   self:AddValue('UI.Ctrl.Common.ComItemSlipCtrl','UI.View.Common.ComItemSlipView','comCost')  


end

return RoleFashionUIView
---自动生成代码----end----