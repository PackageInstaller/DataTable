---自动生成代码----start----
local ProfileItemView = BaseClass( 'ProfileItemView' , BaseView )
local M = ProfileItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.title = self:AddBaseCom( GameUIText ,'title')
  self.textBg =   self._binder:GetValue('textBg')  
  self.lockBg =   self._binder:GetValue('lockBg')  
  self.value = self:AddBaseCom( GameUIText ,'value')
  self.lockLabel = self:AddBaseCom( GameUIText ,'lockLabel')
  self.bgAlpha =   self._binder:GetValue('bgAlpha')  
  self.state =   self._binder:GetValue('state')  


end

return ProfileItemView
---自动生成代码----end----