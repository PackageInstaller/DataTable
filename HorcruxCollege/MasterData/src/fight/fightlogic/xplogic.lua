local FightUIElementsManager = require("fight.FightUIElementsManager")
local var_0_1 = {}

local function var_0_2(arg_1_0)
	local var_1_0 = {
		main = arg_1_0.skeletonindex,
		show = {}
	}
	local var_1_1, var_1_2 = arg_1_0:getTarget()

	if var_1_1 then
		if var_1_2 then
			for iter_1_0, iter_1_1 in ipairs(var_1_1) do
				var_1_0.show[iter_1_1.skeletonindex] = true
			end
		else
			var_1_0.show[var_1_1.skeletonindex] = true
		end
	elseif arg_1_0._locktargetpool then
		for iter_1_2, iter_1_3 in pairs(FightManager[arg_1_0._locktargetpool]) do
			var_1_0.show[iter_1_3.skeletonindex] = true
		end
	end

	return var_1_0
end

function var_0_1.run(arg_2_0, arg_2_1)
	local var_2_0 = var_0_2(arg_2_0)

	FightUIElementsManager.showOnXP(var_2_0)
	SmallFightLayer.getInstance():showXPBg()

	if lockscreen and lockscreen.file then
		local var_2_1 = SmallFightLayer.getInstance()

		var_2_1:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
			var_2_1:playLockAni(lockscreen)
		end)))
	end

	return var_2_0
end

function var_0_1.endxp(arg_4_0)
	if not arg_4_0 then
		return
	end

	FightUIElementsManager.endOnXP(arg_4_0)
	SmallFightLayer.getInstance():hideXPBg()
end

function var_0_1:playLockAni(arg_5_1, arg_5_2)
	if arg_5_1 and arg_5_1.file then
		self.skeleton:pause()
		SmallFightLayer.getInstance():playLockAni(arg_5_1, function()
			self.skeleton:resume()

			if arg_5_2 then
				arg_5_2()
			end
		end)
	elseif arg_5_2 then
		arg_5_2()
	end
end

return var_0_1
