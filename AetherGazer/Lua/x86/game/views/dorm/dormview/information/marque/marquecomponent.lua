local var_0_0 = class("MarqueComponent", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.BuildContext(arg_2_0)
	arg_2_0.context = {
		totalLength = 0,
		contentWidth = 0,
		curDuration = 0,
		curSpeedPerTimeUnit = 0,
		timerPerChar = 6,
		startTime = 0
	}
end

function var_0_0.Init(arg_3_0)
	arg_3_0.marqueList = {}
	arg_3_0.choosePool = {}

	arg_3_0:BuildContext()
	arg_3_0:BindCfgUI()
end

function var_0_0.SetMarqueList(arg_4_0, arg_4_1)
	arg_4_0.marqueList = arg_4_1
end

function var_0_0.StartMarque(arg_5_0)
	if #arg_5_0.marqueList > 0 then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_0.marqueContainer_.transform)

		arg_5_0.context.contentWidth = arg_5_0.marqueContainer_.rect.width
		arg_5_0.context.startTime = 0
		arg_5_0.context.curDuration = 0
		arg_5_0.context.curSpeedPerTimeUnit = 0
		arg_5_0.context.totalLength = 0

		arg_5_0:StopMarque()
		arg_5_0:TryNext()

		arg_5_0.marqueTimer = FrameTimer.New(function()
			arg_5_0:TryNext()
		end, 1, -1)

		arg_5_0.marqueTimer:Start()
	end
end

function var_0_0.TryNext(arg_7_0)
	local var_7_0 = false

	if arg_7_0.context.startTime == 0 then
		var_7_0 = true
	elseif Time.time - arg_7_0.context.startTime > arg_7_0.context.curDuration then
		var_7_0 = true
	end

	if var_7_0 then
		local var_7_1 = arg_7_0:AcquireNewMarque()

		arg_7_0.marqueTxt_.text = var_7_1

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.marqueTxt_.transform)

		local var_7_2 = string.len(var_7_1)

		arg_7_0.context.curSpeedPerTimeUnit = arg_7_0.context.contentWidth / arg_7_0.context.timerPerChar
		arg_7_0.context.totalLength = arg_7_0.context.contentWidth + arg_7_0.marqueTxt_.transform.rect.width

		local var_7_3 = arg_7_0.context.totalLength / arg_7_0.context.curSpeedPerTimeUnit

		arg_7_0.context.startTime = Time.time
		arg_7_0.context.curDuration = var_7_3
		arg_7_0.marqueTxt_.transform.anchoredPosition = Vector3.New(arg_7_0.context.contentWidth, 0, 0)
	else
		local var_7_4 = (Time.time - arg_7_0.context.startTime) * arg_7_0.context.curSpeedPerTimeUnit

		arg_7_0.marqueTxt_.transform.anchoredPosition = Vector3.New(arg_7_0.context.contentWidth - var_7_4, 0, 0)
	end
end

function var_0_0.StopMarque(arg_8_0)
	if arg_8_0.marqueTimer then
		arg_8_0.marqueTimer:Stop()

		arg_8_0.marqueTimer = nil
	end
end

function var_0_0.AcquireNewMarque(arg_9_0)
	if #arg_9_0.choosePool == 0 then
		arg_9_0:RebuildMarqueChoosePool()
	end

	local var_9_0 = math.random(1, #arg_9_0.choosePool)
	local var_9_1 = arg_9_0.marqueList[arg_9_0.choosePool[var_9_0]]

	table.remove(arg_9_0.choosePool, var_9_0)

	return var_9_1
end

function var_0_0.RebuildMarqueChoosePool(arg_10_0)
	arg_10_0.choosePool = {}

	local var_10_0 = #arg_10_0.marqueList

	for iter_10_0 = 1, var_10_0 do
		table.insert(arg_10_0.choosePool, iter_10_0)
	end
end

function var_0_0.Hide(arg_11_0)
	arg_11_0.transform_.parent.gameObject:SetActive(false)
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:StopMarque()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
