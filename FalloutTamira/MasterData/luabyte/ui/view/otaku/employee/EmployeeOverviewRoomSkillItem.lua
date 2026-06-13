---自动生成代码----start----
local EmployeeOverviewRoomSkillItem = BaseClass( 'EmployeeOverviewRoomSkillItem' , BaseView )
local M = EmployeeOverviewRoomSkillItem 
--desc

function M:__init(go)
--require

--declare
  local trans = go.transform 
  self.skillIcon = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "TitleBg/skillIcon" )
  self.skillName = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "TitleBg/skillName" )
  self.desc = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "desc" )
end
return EmployeeOverviewRoomSkillItem
---自动生成代码----end----