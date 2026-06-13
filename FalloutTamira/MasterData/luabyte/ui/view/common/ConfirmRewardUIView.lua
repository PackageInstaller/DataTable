---自动生成代码----start----
local ConfirmRewardUIView = BaseClass( 'ConfirmRewardUIView' , BaseView )
local M = ConfirmRewardUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.title = self:AddBaseCom( GameUIText ,'title')
  self.describe = self:AddBaseCom( GameUIText ,'describe')
  self.tips = self:AddBaseCom( GameUIText ,'tips')
  self.itemContent =   self._binder:GetValue('itemContent')  
  self.itemPfb =   self._binder:GetValue('itemPfb')  
  self.getBtn =   self._binder:GetValue('getBtn')  
  self.recivedTag =   self._binder:GetValue('recivedTag')  
  self.closeBtn =   self._binder:GetValue('closeBtn')  


end

return ConfirmRewardUIView
---自动生成代码----end----