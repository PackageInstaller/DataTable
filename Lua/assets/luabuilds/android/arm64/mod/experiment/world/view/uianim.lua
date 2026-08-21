local var_0_0 = class("UIAnim", import("...BaseEntity"))

var_0_0.Fields = {
	playing = "boolean",
	aniEvent = "userdata",
	onEnd = "function",
	transform = "userdata",
	prefab = "string",
	onTrigger = "function",
	onStart = "function"
}
var_0_0.EventLoaded = "UIAnim.EventLoaded"

function var_0_0.Setup(arg_1_0, arg_1_1)
	arg_1_0.prefab = arg_1_1

	return
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0:Unload()
	arg_2_0:Clear()

	return
end

function var_0_0.Load(arg_3_0)
	local var_3_0 = PoolMgr.GetInstance()

	PoolMgr.GetInstance():GetUI(arg_3_0.prefab, true, function(arg_4_0)
		if var_0 == arg_3_0.prefab then
			arg_3_0.transform = arg_4_0.transform

			arg_3_0:Init()
			arg_3_0:DispatchEvent(var_0_0.EventLoaded)
		else
			var_3_0:ReturnUI(var_0, arg_4_0)
		end

		return
	end)

	return
end

function var_0_0.Unload(arg_5_0)
	if arg_5_0.prefab and arg_5_0.transform then
		PoolMgr.GetInstance():ReturnUI(arg_5_0.prefab, arg_5_0.transform.gameObject)
	end

	arg_5_0.prefab = nil
	arg_5_0.transform = nil

	return
end

function var_0_0.Play(arg_6_0, arg_6_1)
	arg_6_0.playing = true
	arg_6_0.onStart = nil
	arg_6_0.onTrigger = nil
	arg_6_0.onEnd = arg_6_1

	arg_6_0:Update()

	return
end

function var_0_0.Stop(arg_7_0)
	arg_7_0.playing = false

	arg_7_0:Update()

	return
end

function var_0_0.Init(arg_8_0)
	setActive(arg_8_0.transform, false)

	arg_8_0.aniEvent = arg_8_0.transform:GetComponent("DftAniEvent")

	arg_8_0:Update()

	return
end

function var_0_0.Update(arg_9_0)
	if arg_9_0.aniEvent then
		setActive(arg_9_0.transform, arg_9_0.playing)

		if arg_9_0.playing then
			arg_9_0.aniEvent:SetStartEvent(function()
				if arg_9_0.onStart then
					arg_9_0.onStart()
				end

				return
			end)
			arg_9_0.aniEvent:SetTriggerEvent(function()
				if arg_9_0.onTrigger then
					arg_9_0.onTrigger()
				end

				return
			end)
			arg_9_0.aniEvent:SetEndEvent(function(arg_12_0)
				arg_9_0:Stop()

				if arg_9_0.onEnd then
					arg_9_0.onEnd()
				end

				return
			end)
		end
	end

	return
end

return var_0_0
