ys = ys or {}

local var_0_0 = ys.Battle.BattleConfig

ys.Battle.BattleGridmanSkillFloatView = class("BattleGridmanSkillFloatView")
ys.Battle.BattleGridmanSkillFloatView.__name = "BattleGridmanSkillFloatView"

function ys.Battle.BattleGridmanSkillFloatView:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = tf(arg_1_1)

	self:init()

	return
end

function ys.Battle.BattleGridmanSkillFloatView:init()
	self._fusion = {}
	self._fusion[var_0_0.FRIENDLY_CODE] = self._tf:Find("fusion_1")
	self._fusion[var_0_0.FOE_CODE] = self._tf:Find("fusion_-1")
	self._skillList = {}

	local function var_2_0(arg_3_0)
		self._skillList[arg_3_0] = {}

		for iter_3_0 = 1, 3 do
			table.insert(self._skillList[arg_3_0], {
				idle = true,
				tf = self._tf:Find("skill_" .. iter_3_0 * arg_3_0)
			})
		end

		return
	end

	var_2_0(var_0_0.FRIENDLY_CODE)
	var_2_0(var_0_0.FOE_CODE)

	self._resource = self._tf:Find("res")

	return
end

function ys.Battle.BattleGridmanSkillFloatView:DoSkillFloat(arg_4_1, arg_4_2)
	local var_4_0

	for iter_4_0 = 1, 3 do
		if self._skillList[arg_4_2][iter_4_0].idle then
			var_4_0 = self._skillList[arg_4_2][iter_4_0]

			break
		end
	end

	if not var_4_0 then
		return
	end

	var_4_0.idle = false

	local var_4_1 = var_4_0.tf
	local var_4_2 = var_4_0.tf:Find("anima")

	setImageSprite(var_4_2, self._resource:Find(arg_4_1):GetComponent(typeof(Image)).sprite, true)
	setActive(var_4_0.tf, true)
	var_4_2:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_5_0)
		var_4_0.idle = true

		setActive(var_4_1, false)

		return
	end)

	return
end

function ys.Battle.BattleGridmanSkillFloatView:DoFusionFloat(arg_6_1)
	local var_6_0 = self._fusion[arg_6_1]

	setActive(self._fusion[arg_6_1], true)
	self._fusion[arg_6_1]:Find("anima"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_7_0)
		setActive(var_6_0, false)

		return
	end)

	return
end

function ys.Battle.BattleGridmanSkillFloatView.Dispose(arg_8_0)
	return
end

return
