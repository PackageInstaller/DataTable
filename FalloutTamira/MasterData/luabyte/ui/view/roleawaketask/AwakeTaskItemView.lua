---自动生成代码----start----
local AwakeTaskItemView = BaseClass( 'AwakeTaskItemView' , BaseView )
local M = AwakeTaskItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.state =   self._binder:GetValue('state')  
  self.taskPreDes = self:AddBaseCom( GameUIText ,'taskPreDes')
  self.taskDes = self:AddBaseCom( GameUIText ,'taskDes')
  self.reward1 =   self._binder:GetValue('reward1')  
  self.reward2 =   self._binder:GetValue('reward2')  
  self.rewardBtn =   self._binder:GetValue('rewardBtn')  
  self.rewardState =   self._binder:GetValue('rewardState')  
  self.tipText =   self._binder:GetValue('tipText')  
  self.animator =   self._binder:GetValue('animator')  
  self.itemBtn =   self._binder:GetValue('itemBtn')  


end

return AwakeTaskItemView
---自动生成代码----end----