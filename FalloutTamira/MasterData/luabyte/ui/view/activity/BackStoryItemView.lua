---自动生成代码----start----
local BackStoryItemView = BaseClass( 'BackStoryItemView' , BaseView )
local M = BackStoryItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txt_task_desc = self:AddBaseCom( GameUIText ,'txt_task_desc')
  self.txt_task_prop = self:AddBaseCom( GameUIText ,'txt_task_prop')
  self.img_task_prog = self:AddBaseCom( GameUIImage ,'img_task_prog')
  self.list_task_award = self:AddBaseCom( CircularScrollView ,'list_task_award')
  self.rt_task_to =   self._binder:GetValue('rt_task_to')  
  self.rt_task_rece =   self._binder:GetValue('rt_task_rece')  
  self.rt_task_comp =   self._binder:GetValue('rt_task_comp')  
  self.rt_task_click =   self._binder:GetValue('rt_task_click')  
  self.btn_enter =   self._binder:GetValue('btn_enter')  
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_desc = self:AddBaseCom( GameUIText ,'txt_desc')
  self.rt_lock =   self._binder:GetValue('rt_lock')  
  self.rt_task_lock =   self._binder:GetValue('rt_task_lock')  


end

return BackStoryItemView
---自动生成代码----end----