---自动生成代码----start----
local Dorm_1 = BaseClass( 'Dorm_1' , BaseView )
local M = Dorm_1 
--desc

function M:__init(go)
--require

--declare
  local trans = go.transform 
  self.Door_Point = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.Transform) , "Door_Point" )
  self.Bed_Point = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.Transform) , "Bed_Point" )
  self.Sofa_Point = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.Transform) , "Sofa_Point" )
  self.Desk_Point = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.Transform) , "Desk_Point" )
  self.Chair_Point = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.Transform) , "Chair_Point" )
  self.Closet_Point = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.Transform) , "Closet_Point" )
  self.Toilet_Point = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.Transform) , "Toilet_Point" )
end

return Dorm_1
---自动生成代码----end----