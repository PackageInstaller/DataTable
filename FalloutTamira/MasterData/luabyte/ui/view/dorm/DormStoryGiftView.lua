---自动生成代码----start----
local DormStoryGiftView = BaseClass( 'DormStoryGiftView' , BaseView )
local M = DormStoryGiftView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Tab =   self:AddValue('UI.Ctrl.Dorm.DormStoryGiftTabCtrl','UI.View.Dorm.DormStoryGiftTab','Tab')  
  self.ScrollView = self:AddBaseCom( CircularScrollView ,'ScrollView')
  self.Item =   self:AddValue('','UI.View.Dorm.DormStoryGivingItem','Item')  
  self.Content =   self._binder:GetValue('Content')  
  self.BtnCancel =   self._binder:GetValue('BtnCancel')  
  self.BtnConfirm =   self._binder:GetValue('BtnConfirm')  


end

return DormStoryGiftView
---自动生成代码----end----