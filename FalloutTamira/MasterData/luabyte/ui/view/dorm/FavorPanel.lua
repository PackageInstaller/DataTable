---自动生成代码----start----
local FavorPanel = BaseClass( 'FavorPanel' , BaseView )
local M = FavorPanel 
--desc

function M:__init(go)
  local trans = go.transform 
  self.favorProgress = self:AddBaseCom( GameUIText ,'favorProgress')
  self.Name = self:AddBaseCom( GameUIText ,'Name')
  self.Button = self:AddBaseCom( GameUIImage ,'Button')
  self.favorLevel = self:AddBaseCom( GameUIText ,'favorLevel')
  self.Star1 = self:AddBaseCom( GameUIImage ,'Star1')
  self.Star2 = self:AddBaseCom( GameUIImage ,'Star2')
  self.Star3 = self:AddBaseCom( GameUIImage ,'Star3')
  self.Star4 = self:AddBaseCom( GameUIImage ,'Star4')
  self.UpValueState =   self._binder:GetValue('UpValueState')  
  self.UpValue1 = self:AddBaseCom( GameUIImage ,'UpValue1')
  self.UpValue2 = self:AddBaseCom( GameUIImage ,'UpValue2')
  self.UpValue3 = self:AddBaseCom( GameUIImage ,'UpValue3')
  self.UpValue =   self._binder:GetValue('UpValue')  
  self.UpValueAnimator =   self._binder:GetValue('UpValueAnimator')  


end

return FavorPanel
---自动生成代码----end----