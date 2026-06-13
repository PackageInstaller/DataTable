---自动生成代码----start----
local GeneTipsView = BaseClass( 'GeneTipsView' , BaseView )
local M = GeneTipsView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Name = self:AddBaseCom( GameUIText ,'Name')
  self.Mask =   self._binder:GetValue('Mask')  
  self.imgStar = self:AddBaseCom( GameUIImage ,'imgStar')
  self.title1 = self:AddBaseCom( GameUIText ,'title1')
  self.title2 = self:AddBaseCom( GameUIText ,'title2')
  self.title3 = self:AddBaseCom( GameUIText ,'title3')
  self.title4 = self:AddBaseCom( GameUIText ,'title4')
  self.title5 = self:AddBaseCom( GameUIText ,'title5')
  self.title6 = self:AddBaseCom( GameUIText ,'title6')
  self.Detail1 =   self:AddValue('UI.Ctrl.RoleDevelop.UIDetailCtrl','UI.View.RoleDevelop.UIDetailView','Detail1')  
  self.Detail2 =   self:AddValue('UI.Ctrl.RoleDevelop.UIDetailCtrl','UI.View.RoleDevelop.UIDetailView','Detail2')  
  self.Detail3 =   self:AddValue('UI.Ctrl.RoleDevelop.UIDetailCtrl','UI.View.RoleDevelop.UIDetailView','Detail3')  
  self.Detail4 =   self:AddValue('UI.Ctrl.RoleDevelop.UIDetailCtrl','UI.View.RoleDevelop.UIDetailView','Detail4')  
  self.Detail5 =   self:AddValue('UI.Ctrl.RoleDevelop.UIDetailCtrl','UI.View.RoleDevelop.UIDetailView','Detail5')  
  self.Detail6 =   self:AddValue('UI.Ctrl.RoleDevelop.UIDetailCtrl','UI.View.RoleDevelop.UIDetailView','Detail6')  
  self.imgProfession = self:AddBaseCom( GameUIImage ,'imgProfession')


end

return GeneTipsView
---自动生成代码----end----