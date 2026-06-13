---自动生成代码----start----
local UIGeneClassView = BaseClass( 'UIGeneClassView' , BaseView )
local M = UIGeneClassView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.state =   self._binder:GetValue('state')  
  self.itemState1 =   self._binder:GetValue('itemState1')  
  self.itemState2 =   self._binder:GetValue('itemState2')  
  self.itemState3 =   self._binder:GetValue('itemState3')  
  self.itemState4 =   self._binder:GetValue('itemState4')  
  self.itemState5 =   self._binder:GetValue('itemState5')  
  self.itemState6 =   self._binder:GetValue('itemState6')  
  self.labLockTips = self:AddBaseCom( GameUIText ,'labLockTips')
  self.btn =   self._binder:GetValue('btn')  


end

return UIGeneClassView
---自动生成代码----end----