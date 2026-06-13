---自动生成代码----start----
local UIDayEnergyView = BaseClass( 'UIDayEnergyView' , BaseView )
local M = UIDayEnergyView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.imgLeft =   self:AddValue('UI.Ctrl.UIDayEnergy.UIDayEnergyItemCtrl','UI.View.UIDayEnergy.UIDayEnergyItemView','imgLeft')  
  self.imgRight =   self:AddValue('UI.Ctrl.UIDayEnergy.UIDayEnergyItemCtrl','UI.View.UIDayEnergy.UIDayEnergyItemView','imgRight')  


end

return UIDayEnergyView
---自动生成代码----end----