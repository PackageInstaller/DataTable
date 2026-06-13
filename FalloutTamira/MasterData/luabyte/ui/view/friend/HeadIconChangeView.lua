---自动生成代码----start----
local HeadIconChangeView = BaseClass( 'HeadIconChangeView' , BaseView )
local M = HeadIconChangeView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.HeadState =   self._binder:GetValue('HeadState')  
  self.HeadIcon = self:AddBaseCom( GameUIImage ,'HeadIcon')
  self.HeadName = self:AddBaseCom( GameUIText ,'HeadName')
  self.HeadTips = self:AddBaseCom( GameUIText ,'HeadTips')
  self.ScrollView = self:AddBaseCom( CircularScrollView ,'ScrollView')
  self.BtnOK =   self._binder:GetValue('BtnOK')  
  self.BtnState =   self._binder:GetValue('BtnState')  
  self.Mask = self:AddBaseCom( GameUIImage ,'Mask')


end

return HeadIconChangeView
---自动生成代码----end----