---自动生成代码----start----
local UIPosItemView = BaseClass( 'UIPosItemView' , BaseView )
local M = UIPosItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.uiState =   self._binder:GetValue('uiState')  
  self.lockTips = self:AddBaseCom( GameUIText ,'lockTips')
  self.labNumUse = self:AddBaseCom( GameUIText ,'labNumUse')
  self.labTimerUse = self:AddBaseCom( GameUIText ,'labTimerUse')
  self.scrollBarUse =   self._binder:GetValue('scrollBarUse')  
  self.labNumClear = self:AddBaseCom( GameUIText ,'labNumClear')
  self.labTimerClear = self:AddBaseCom( GameUIText ,'labTimerClear')
  self.scrollBarClear =   self._binder:GetValue('scrollBarClear')  
  self.imgHead = self:AddBaseCom( GameUIImage ,'imgHead')
  self.imgProfession = self:AddBaseCom( GameUIImage ,'imgProfession')


end

return UIPosItemView
---自动生成代码----end----