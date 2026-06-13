---自动生成代码----start----
local WeeklyTaskUIView = BaseClass( 'WeeklyTaskUIView' , BaseView )
local M = WeeklyTaskUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.listScrollView = self:AddBaseCom( CircularScrollView ,'listScrollView')
  self.activityScrollView = self:AddBaseCom( CircularScrollView ,'activityScrollView')
  self.txtMaxValue = self:AddBaseCom( GameUIText ,'txtMaxValue')
  self.txtCurValue = self:AddBaseCom( GameUIText ,'txtCurValue')
  self.togReceiveAll = self:AddBaseCom( UIButton ,'togReceiveAll')
  self.rectWeeklyPanel =   self._binder:GetValue('rectWeeklyPanel')  
  self.imgBgProgress = self:AddBaseCom( GameUIImage ,'imgBgProgress')
  self.imgFgProgress = self:AddBaseCom( GameUIImage ,'imgFgProgress')
  self.togReceiveAllState =   self._binder:GetValue('togReceiveAllState')  


end

return WeeklyTaskUIView
---自动生成代码----end----