---自动生成代码----start----
local PlotStoryUnlockUIView = BaseClass( 'PlotStoryUnlockUIView' , BaseView )
local M = PlotStoryUnlockUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.looplist = self:AddBaseCom( CircularScrollView ,'looplist')
  self.img_bannerM = self:AddBaseCom( GameUIImage ,'img_bannerM')
  self.img_bannerT = self:AddBaseCom( GameUIImage ,'img_bannerT')
  self.img_bannerB = self:AddBaseCom( GameUIImage ,'img_bannerB')
  self.uiState =   self._binder:GetValue('uiState')  
  self.rotateAni =   self._binder:GetValue('rotateAni')  
  self.btn_play =   self._binder:GetValue('btn_play')  
  self.btn_unlock =   self._binder:GetValue('btn_unlock')  


end

return PlotStoryUnlockUIView
---自动生成代码----end----