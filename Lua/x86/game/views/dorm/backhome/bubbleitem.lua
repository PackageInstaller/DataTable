local var_0_0 = class("BubbleItem", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.duration = 4
end

local function var_0_1(arg_2_0)
	local var_2_0 = arg_2_0.taskDataCtx.bubbleObj

	return Time.time - var_2_0.startTime >= var_2_0.duration
end

local function var_0_2(arg_3_0, arg_3_1)
	arg_3_0.task = nil
	arg_3_0.text.text = ""

	arg_3_0.content:SetActive(false)

	if arg_3_1 then
		DormUtils.ShowCharaSpecialVfx(arg_3_1, Dorm.charaVfxActiveType)
	end
end

function var_0_0.ShowSubtitle(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.startTime = Time.time

	if arg_4_2 then
		arg_4_0.duration = arg_4_2
	end

	if arg_4_0.task == nil then
		local var_4_0 = {
			bubbleObj = arg_4_0
		}
		local var_4_1 = DormCharacterActionManager.frameTaskRunner:NewTask(var_4_0)

		var_4_1:WaitUntil(var_0_1)
		var_4_1:SetOnComplete(function()
			var_0_2(arg_4_0, arg_4_1)
		end)
		var_4_1:SetOnAbort(function()
			var_0_2(arg_4_0, arg_4_1)
		end)

		arg_4_0.task = var_4_1

		arg_4_0.task:Start()
		DormUtils.HideCharaSpecialVfx(arg_4_1)
	end
end

local function var_0_3(arg_7_0)
	return arg_7_0 == nil or arg_7_0 == "" or IsAllSpace(arg_7_0)
end

function var_0_0.SetData(arg_8_0, arg_8_1)
	if isNil(arg_8_0.content) then
		return
	end

	arg_8_0.text.text = arg_8_1

	if not var_0_3(arg_8_1) then
		arg_8_0.content:SetActive(true)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.content.transform)
	end
end

function var_0_0.Hide(arg_9_0)
	if arg_9_0.task then
		arg_9_0.task:Abort()

		arg_9_0.task = nil
	end
end

function var_0_0.IsPlaying(arg_10_0)
	return arg_10_0.task ~= nil
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)

	if arg_11_0.task then
		arg_11_0.task:Abort()

		arg_11_0.task = nil
	end

	if not isNil(arg_11_0.gameObject_) then
		arg_11_0.gameObject_:Destroy()
	end
end

return var_0_0
