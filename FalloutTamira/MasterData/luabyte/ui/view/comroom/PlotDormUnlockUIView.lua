---自动生成代码----start----
local PlotDormUnlockUIView = BaseClass( 'PlotDormUnlockUIView' , BaseView )
local M = PlotDormUnlockUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.looplist = self:AddBaseCom( CircularScrollView ,'looplist')
  self.btn_back =   self._binder:GetValue('btn_back')  


end

return PlotDormUnlockUIView
---自动生成代码----end----