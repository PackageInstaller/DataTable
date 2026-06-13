---自动生成代码----start----
local BridgeInfoItemView = BaseClass( 'BridgeInfoItemView' , BaseView )
local M = BridgeInfoItemView 
--desc

function M:__init(go)
--require

--declare
  local trans = go.transform 
  self.name = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "name" )
  self.num = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "Icon/num" )
  self.level = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "level" )
end
return BridgeInfoItemView
---自动生成代码----end----