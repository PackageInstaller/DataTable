---自动生成代码----start----
local UIRewardView = BaseClass( 'UIRewardView' , BaseView )
local M = UIRewardView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.item =   self._binder:GetValue('item')  
  self.gridHero = self:AddBaseCom( CircularScrollView ,'gridHero')
  self.uiState =   self._binder:GetValue('uiState')  
  self.labNum1 = self:AddBaseCom( GameUIText ,'labNum1')
  self.labNum2 = self:AddBaseCom( GameUIText ,'labNum2')
  self.labTitle = self:AddBaseCom( GameUIText ,'labTitle')
  self.btn =   self._binder:GetValue('btn')  


end

return UIRewardView
---自动生成代码----end----