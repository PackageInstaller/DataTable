---自动生成代码----start----
local ItemAmountUIView = BaseClass( 'ItemAmountUIView' , BaseView )
local M = ItemAmountUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.itemPfb =   self._binder:GetValue('itemPfb')  
  self.txt_left = self:AddBaseCom( GameUIText ,'txt_left')
  self.txt_right = self:AddBaseCom( GameUIText ,'txt_right')
  self.uiState =   self._binder:GetValue('uiState')  


end

return ItemAmountUIView
---自动生成代码----end----