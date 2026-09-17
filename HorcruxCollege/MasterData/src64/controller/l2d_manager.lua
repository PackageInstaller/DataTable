local var_0_0 = {}
local var_0_1 = l2d.LAppLive2DManager:getInstance()

setmetatable(var_0_0, {
	__index = function(arg_1_0, arg_1_1)
		if var_0_1[arg_1_1] then
			local function var_1_0(arg_2_0, ...)
				return var_0_1[arg_1_1](var_0_1, ...)
			end

			arg_1_0[arg_1_1] = var_1_0

			return var_1_0
		end

		return nil
	end
})

local var_0_2 = {}
local var_0_3
local var_0_4
local var_0_5

function var_0_0.getLive2dVersion(arg_3_0)
	if var_0_1.getLive2dVersion then
		return var_0_1:getLive2dVersion()
	else
		return "2.0"
	end
end

function var_0_0:isVersion4()
	return self:getLive2dVersion() == "4.0"
end

function var_0_0:addModel(arg_5_1, ...)
	var_0_1:addModel(arg_5_1, ...)
	self:retain(arg_5_1)
end

function var_0_0.retain(arg_6_0, arg_6_1)
	var_0_2[arg_6_1] = (var_0_2[arg_6_1] or 0) + 1
end

function var_0_0.release(arg_7_0, arg_7_1)
	if not var_0_2[arg_7_1] then
		return
	end

	var_0_2[arg_7_1] = var_0_2[arg_7_1] - 1

	assert(var_0_2[arg_7_1] >= 0, "Reference Count Shouldn't be " .. var_0_2[arg_7_1])
end

function var_0_0.setNotRemoveModel(arg_8_0, arg_8_1)
	var_0_3 = arg_8_1
end

function var_0_0.setNotRemoveBGModel(arg_9_0, arg_9_1)
	var_0_4 = arg_9_1
end

function var_0_0.setNotRemoveFrontModel(arg_10_0, arg_10_1)
	var_0_5 = arg_10_1
end

function var_0_0.releaseAllModel(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(var_0_2) do
		if iter_11_0 ~= var_0_3 and iter_11_0 ~= var_0_4 and iter_11_0 ~= var_0_5 and iter_11_1 == 0 then
			var_0_1:releaseModelByName(iter_11_0)

			var_0_2[iter_11_0] = nil
		end
	end
end

function var_0_0.releaseAllModelForce(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(var_0_2) do
		var_0_1:releaseModelByName(iter_12_0)

		var_0_2[iter_12_0] = nil
	end
end

function var_0_0.removeModel(arg_13_0, arg_13_1)
	if not var_0_2[arg_13_1] then
		return
	end

	if var_0_2[arg_13_1] > 0 then
		return
	end

	if arg_13_1 == var_0_3 then
		return
	end

	if arg_13_1 == var_0_4 then
		return
	end

	if arg_13_1 == var_0_5 then
		return
	end

	var_0_1:releaseModelByName(arg_13_1)

	var_0_2[arg_13_1] = nil
end

function var_0_0.removeModelForce(arg_14_0)
	if not var_0_2[model] then
		return
	end

	var_0_1:releaseModelByName(model)

	var_0_2[model] = nil
end

function var_0_0.doModelMotion(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_3 = arg_15_3 or 0

	var_0_1:doModelMotion(arg_15_1, arg_15_2, arg_15_3, 3)
end

function var_0_0.setSayCallback(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1

	var_0_1:setSayCallback(arg_16_1, function(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
		local var_17_0 = cc.EventCustom:new("live2dsaytex")

		var_17_0.model = var_16_0
		var_17_0.sound = arg_17_0
		var_17_0.sayText = arg_17_1
		var_17_0.sayTextShowTime = arg_17_2
		var_17_0.isStay = arg_17_3

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_17_0)
	end)
end

return var_0_0
