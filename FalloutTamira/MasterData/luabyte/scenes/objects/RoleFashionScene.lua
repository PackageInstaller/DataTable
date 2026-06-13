---自动生成代码----start----
local RoleFashionScene = BaseClass( 'RoleFashionScene' , BaseView )
local M = RoleFashionScene 
--desc

function M:__init(go)
  local trans = go.transform 
  self.showGirlRoot =   self._binder:GetValue('showGirlRoot')  
  self.blur =   self._binder:GetValue('blur')  
  self.CameraNode =   self._binder:GetValue('CameraNode')  
  self.tfbg =   self._binder:GetValue('tfbg')  
  self.geneSpinMat =   self._binder:GetValue('geneSpinMat')  
  self.factionScene =   self._binder:GetValue('factionScene')  
  self.geneSpin =   self._binder:GetValue('geneSpin')  
  self.tfCoreEffect =   self._binder:GetValue('tfCoreEffect')  


end

return RoleFashionScene
---自动生成代码----end----