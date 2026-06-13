---自动生成代码----start----
local AchievementSelectPopupView = BaseClass( 'AchievementSelectPopupView' , BaseView )
local M = AchievementSelectPopupView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.scrollView = self:AddBaseCom( CircularScrollView ,'scrollView')
  self.saveBtn = self:AddBaseCom( GameUIImage ,'saveBtn')
  self.selectBtn =   self._binder:GetValue('selectBtn')  
  self.content =   self._binder:GetValue('content')  
  self.lv0 =   self._binder:GetValue('lv0')  
  self.lv2 =   self._binder:GetValue('lv2')  
  self.lv1 =   self._binder:GetValue('lv1')  
  self.lv3 =   self._binder:GetValue('lv3')  
  self.closeBtn =   self._binder:GetValue('closeBtn')  
  self.closeLv =   self._binder:GetValue('closeLv')  
  self.save =   self._binder:GetValue('save')  
  self.text = self:AddBaseCom( GameUIText ,'text')
  self.NoneTips =   self._binder:GetValue('NoneTips')  


end

return AchievementSelectPopupView
---自动生成代码----end----