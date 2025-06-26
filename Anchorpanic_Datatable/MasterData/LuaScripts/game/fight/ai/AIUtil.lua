module("fight.AIUtil", Class.impl())

--总体行为相关AI---------------------------------------
function createFightAI(cusVo)
	return fight.AIManager:createFightAI(cusVo);
end

function recoverFightAI(cusID)
	fight.AIManager:recoverFightAI(cusID);
end

--技能相关AI---------------------------------------
function createSkillAI(cusLivethingVo,cusMainTargetVo,cusSkillVo)
	local ai = fight.AIManager:createSkillAI(cusSkillVo:getRefID());
	ai:setData(cusLivethingVo,cusMainTargetVo,cusSkillVo);
	return ai;
end

function recoverSkillAI(cusSkillAI)
	fight.AIManager:recoverSkillAI(cusSkillAI);
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
