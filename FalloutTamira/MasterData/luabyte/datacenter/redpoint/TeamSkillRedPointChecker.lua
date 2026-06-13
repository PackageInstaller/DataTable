--编队技能
local TeamSkillRedPointChecker = BaseClass("TeamSkillRedPointChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = TeamSkillRedPointChecker

function M:Check(param)
    self.checkResult = CmderSkillMgr:CmderSkillRedPoint(param) and 1 or 0
end


return TeamSkillRedPointChecker