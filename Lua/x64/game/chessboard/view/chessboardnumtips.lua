local var_0_0 = class("ChessBoardNumTips", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.tipsList = {}

	for iter_3_0 = 1, 3 do
		local var_3_0 = string.format("tips%sObj_", iter_3_0)

		arg_3_0.tipsList[iter_3_0] = ChessBoardNumTipsItem.New(arg_3_0[var_3_0])
	end

	arg_3_0.playTipsIndex = 1
	arg_3_0.willPlayTipsList = {}
	arg_3_0.canShowAni = true
end

function var_0_0.ShowTips(arg_4_0, arg_4_1)
	table.insert(arg_4_0.willPlayTipsList, arg_4_1)
	arg_4_0:ShowAni()
end

function var_0_0.ShowAni(arg_5_0)
	if not arg_5_0.canShowAni then
		return
	end

	local var_5_0 = arg_5_0.willPlayTipsList[1]

	if not var_5_0 then
		return
	end

	if var_5_0 then
		table.remove(arg_5_0.willPlayTipsList, 1)
	end

	arg_5_0.canShowAni = false

	arg_5_0.tipsList[arg_5_0.playTipsIndex]:RefreshUI(var_5_0)

	arg_5_0.playTipsIndex = arg_5_0.playTipsIndex % 3 + 1

	arg_5_0:AddCDTimer()
end

function var_0_0.AddCDTimer(arg_6_0)
	arg_6_0:DelCDTimer()

	arg_6_0.cdTimer = Timer.New(function()
		arg_6_0.canShowAni = true

		arg_6_0:ShowAni()
	end, 0.5)

	arg_6_0.cdTimer:Start()
end

function var_0_0.DelCDTimer(arg_8_0)
	if arg_8_0.cdTimer then
		arg_8_0.cdTimer:Stop()

		arg_8_0.cdTimer = nil
	end
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:DelCDTimer()

	for iter_9_0, iter_9_1 in pairs(arg_9_0.tipsList) do
		iter_9_1:Dispose()
	end

	arg_9_0.super.Dispose(arg_9_0)
end

return var_0_0
