---自动生成代码----start----
local ChapterItemView = BaseClass( 'ChapterItemView' , BaseView )
local M = ChapterItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txt_index = self:AddBaseCom( GameUIText ,'txt_index')
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_title = self:AddBaseCom( GameUIText ,'txt_title')
  self.lockTag =   self._binder:GetValue('lockTag')  
  self.tgl_normal = self:AddBaseCom( UIToggle ,'tgl_normal')
  self.selectState =   self._binder:GetValue('selectState')  
  self.redPoint =   self._binder:GetValue('redPoint')  
  self.itemState =   self._binder:GetValue('itemState')  


end

return ChapterItemView
---自动生成代码----end----