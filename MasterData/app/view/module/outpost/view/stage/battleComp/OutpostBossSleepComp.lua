local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.const.ConstMgr.outpostConst
local var_0_2 = g.core.model.User.outpostData
local OutpostBossSleepComp = class("OutpostBossSleepComp", require("app.fairyGUI.outpost.UI_OutpostBossSleepComp"))

function OutpostBossSleepComp:ctor()
	self.m_effectHolder:addEffectSpine({
		anim = "play",
		name = "eff_ui_outpost_bossglow",
		remove = false,
		isLoop = true
	})
	self.m_effectHolder:runFGAction((fgui.FFadeIn:create(0.3)))
end

function OutpostBossSleepComp:updateComp(arg_2_1)
	local var_2_0 = arg_2_1:getActiveTime()

	if var_2_0 - var_0_0:getTime() <= 0 or arg_2_1:isClear() then
		self:setVisible(false)

		return
	end

	self:setVisible(true)
	self.m_timeTxt:setText(var_0_0:getLeftMSFormat(var_2_0, true))

	local var_2_1 = 0

	for iter_2_0, iter_2_1 in ipairs((arg_2_1.world:getVirtualMap():queryRangeEntities(arg_2_1.x, arg_2_1.y, arg_2_1:getEyeRange()))) do
		if iter_2_1:isKnight() and iter_2_1:canVictim() then
			var_2_1 = var_2_1 + 1
		end
	end

	self.m_numTxt:setText(g.core.lang:get(432620, {
		num = var_2_1,
		max = var_0_2:getBuildData():getBuild({
			type = var_0_1.BuildType.Main
		}):getMaxRoleNum()
	}))
end

function OutpostBossSleepComp:onActiveBoss()
	self:runFGAction((fgui.FSequence:create({
		fgui.FFadeOut:create(0.3),
		fgui.FCallFunc:create(function()
			self:removeFromParent()
		end)
	})))
end

return OutpostBossSleepComp
