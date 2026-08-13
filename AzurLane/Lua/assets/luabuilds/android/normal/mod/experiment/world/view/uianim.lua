class = var_0_10000

local var_0_0 = "UIAnim"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseEntity"))

var_0_1.Fields = {
	playing = "boolean",
	aniEvent = "userdata",
	onEnd = "function",
	transform = "userdata",
	prefab = "string",
	onTrigger = "function",
	onStart = "function"
}
var_0_1.EventLoaded = "UIAnim.EventLoaded"

function var_0_1.Setup(arg_1_0, arg_1_1)
	arg_1_0.prefab = arg_1_1

	return
end

function var_0_1.Dispose(arg_2_0)
	arg_2_0:Unload()
	arg_2_0:Clear()

	return
end

function var_0_1.Load(arg_3_0)
	local var_3_0 = arg_3_0.prefab

	PoolMgr = var_1_10002

	local var_3_1 = var_1_10002.GetInstance()

	var_2.GetUI(var_3_1, var_3_0, true, function(arg_4_0)
		if var_3_0 == arg_3_0.prefab then
			arg_3_0.transform = arg_4_0.transform

			local var_4_0 = arg_3_0

			var_1.Init(var_4_0)

			local var_4_1 = arg_3_0

			var_1.DispatchEvent(var_4_1, var_0_1.EventLoaded)
		else
			local var_4_2 = var_0

			var_1.ReturnUI(var_4_2, var_3_0, arg_4_0)
		end

		return
	end)

	return
end

function var_0_1.Unload(arg_5_0)
	if arg_5_0.prefab and arg_5_0.transform then
		PoolMgr = var_1

		local var_5_0 = var_1.GetInstance()

		var_1.ReturnUI(var_5_0, arg_5_0.prefab, arg_5_0.transform.gameObject)
	end

	arg_5_0.prefab = nil
	arg_5_0.transform = nil

	return
end

function var_0_1.Play(arg_6_0, arg_6_1)
	arg_6_0.playing = true
	arg_6_0.onStart = nil
	arg_6_0.onTrigger = nil
	arg_6_0.onEnd = arg_6_1

	arg_6_0:Update()

	return
end

function var_0_1.Stop(arg_7_0)
	arg_7_0.playing = false

	arg_7_0:Update()

	return
end

function var_0_1.Init(arg_8_0)
	setActive = var_1_10001

	var_1_10001(arg_8_0.transform, false)

	local var_8_0 = arg_8_0.transform

	arg_8_0.aniEvent = var_1.GetComponent(var_8_0, "DftAniEvent")

	arg_8_0:Update()

	return
end

function var_0_1.Update(arg_9_0)
	if arg_9_0.aniEvent then
		setActive = var_1

		var_1(arg_9_0.transform, arg_9_0.playing)

		if arg_9_0.playing then
			local var_9_0 = arg_9_0.aniEvent

			var_1.SetStartEvent(var_9_0, function()
				if arg_9_0.onStart then
					arg_9_0.onStart()
				end

				return
			end)

			local var_9_1 = arg_9_0.aniEvent

			var_1.SetTriggerEvent(var_9_1, function()
				if arg_9_0.onTrigger then
					arg_9_0.onTrigger()
				end

				return
			end)

			local var_9_2 = arg_9_0.aniEvent

			var_1.SetEndEvent(var_9_2, function(arg_12_0)
				local var_12_0 = arg_9_0

				var_1.Stop(var_12_0)

				if arg_9_0.onEnd then
					arg_9_0.onEnd()
				end

				return
			end)
		end
	end

	return
end

return var_0_1
