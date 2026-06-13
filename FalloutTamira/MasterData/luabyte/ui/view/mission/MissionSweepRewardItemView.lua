---自动生成代码----start----
local MissionSweepRewardItemView = BaseClass( 'MissionSweepRewardItemView' , BaseView )
local M = MissionSweepRewardItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txt_num = self:AddBaseCom( GameUIText ,'txt_num')
  self.itemPfb =   self._binder:GetValue('itemPfb')  


end

return MissionSweepRewardItemView
---自动生成代码----end----