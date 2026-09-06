-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/caiqingdraw/config/CaiQingDrawConfig.lua

module("logic.extensions.caiqingdraw.config.CaiQingDrawConfig", package.seeall)

local CaiQingDrawConfig = class("CaiQingDrawConfig", BaseConfig)

function CaiQingDrawConfig:onInit()
	CaiQingDrawConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function CaiQingDrawConfig:getNames()
	return {
		"caiqing_activity",
		"caiqing_draw_plan",
		"caiqing_draw_jump_to_plan",
		"caiqing_draw_btn_plan"
	}
end

function CaiQingDrawConfig:handleConfig(name, content)
	if name == "caiqing_activity" then
		self._caiqing_activity = content
	elseif name == "caiqing_draw_plan" then
		self._caiqing_draw_plan = content
	elseif name == "caiqing_draw_jump_to_plan" then
		self._caiqing_draw_jump_to_plan = content
	elseif name == "caiqing_draw_btn_plan" then
		self._caiqing_draw_btn_plan = content
	end
end

function CaiQingDrawConfig:getActivityCfgById(id)
	return self._caiqing_activity[id]
end

function CaiQingDrawConfig:getPlanCfgById(planId)
	return self._caiqing_draw_plan[planId]
end

function CaiQingDrawConfig:getMaxHitReward(planId)
	local cfg = {}

	for i, v in ipairs(self._caiqing_draw_plan[planId]) do
		if v.maxHit > 0 then
			table.insert(cfg, v)
		end
	end

	return cfg
end

function CaiQingDrawConfig:getJumpToPlanCfgsById(jumpToPlanId)
	return self._caiqing_draw_jump_to_plan[jumpToPlanId]
end

function CaiQingDrawConfig:getBtnPlanCfgById(btnPlanId)
	return self._caiqing_draw_btn_plan[btnPlanId]
end

CaiQingDrawConfig.instance = CaiQingDrawConfig.New()

return CaiQingDrawConfig
