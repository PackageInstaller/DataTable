---自动生成代码----start----
local MainPreheatActivityItemView = BaseClass( 'MainPreheatActivityItemView' , BaseView )
local M = MainPreheatActivityItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.uiState =   self._binder:GetValue('uiState')  
  self.img_pic = self:AddBaseCom( GameUIImage ,'img_pic')
  self.txt_openTime = self:AddBaseCom( GameUIText ,'txt_openTime')
  self.rectNew =   self._binder:GetValue('rectNew')  
  self.redPoint =   self._binder:GetValue('redPoint')  


end

return MainPreheatActivityItemView
---自动生成代码----end----