local var_0_0 = class("NewWarChessDiceFrameItem", ReduxView)
local var_0_1 = {
	EQUAL = 3,
	BETWEEN = 4,
	EVEN = 6,
	ODD = 5,
	GREATER = 1,
	SMALLER = 2
}

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.clickHandler_ = arg_1_2
	arg_1_0.index_ = arg_1_3
	arg_1_0.frameIndex_ = 0
	arg_1_0.diceIndex_ = 0

	arg_1_0:ResetData()
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController_ = ControllerUtil.GetController(arg_3_0.transform_, "name")
	arg_3_0.pointController_ = ControllerUtil.GetController(arg_3_0.transform_, "points")
	arg_3_0.symbolController_ = ControllerUtil.GetController(arg_3_0.transform_, "symbol")
	arg_3_0.combolController_ = ControllerUtil.GetController(arg_3_0.transform_, "combo")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickHandler_ then
			arg_4_0.clickHandler_(arg_4_0.index_)
		else
			print("骰子框self.clickHandler_为空！！！！")
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.frameIndex_ = arg_6_1

	arg_6_0:ResetData()

	if arg_6_0.frameIndex_ == 0 then
		return
	else
		arg_6_0.frameCfg_ = NewWarChessDiceCfg[arg_6_0.frameIndex_]
		arg_6_0.type_ = arg_6_0.frameCfg_.type
		arg_6_0.inputRange_ = arg_6_0.frameCfg_.input_range
		arg_6_0.limitType_ = arg_6_0.frameCfg_.limit_type
	end

	arg_6_0:RefreshUI()
end

function var_0_0.SetInputDice(arg_7_0, arg_7_1)
	arg_7_0.diceData_ = NewWarChessData.GetDiceContinuousList()[arg_7_1]
	arg_7_0.diceIndex_ = arg_7_1
	arg_7_0.dicePoint_ = arg_7_0.diceData_[1]

	arg_7_0:RefreshUI()
end

function var_0_0.ResetData(arg_8_0)
	arg_8_0.limitType_ = 0
	arg_8_0.type_ = 0
	arg_8_0.frameCfg_ = nil
	arg_8_0.inputRange_ = {}

	arg_8_0:ResetDiceData()
end

function var_0_0.ResetDiceData(arg_9_0)
	arg_9_0.diceIndex_ = 0
	arg_9_0.diceData_ = nil
	arg_9_0.dicePoint_ = 0
end

function var_0_0.CheckInputLimit(arg_10_0, arg_10_1)
	local var_10_0 = NewWarChessData.GetDiceContinuousList()[arg_10_1][1]

	if arg_10_0.dicePoint_ ~= 0 then
		return false
	end

	if arg_10_0.limitType_ <= 4 then
		if var_10_0 < arg_10_0.inputRange_[1] or var_10_0 > arg_10_0.inputRange_[2] then
			return false
		end
	elseif arg_10_0.limitType_ == var_0_1.ODD then
		return var_10_0 % 2 == 1
	elseif arg_10_0.limitType_ == var_0_1.EVEN then
		return var_10_0 % 2 == 0
	end

	return true
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0.stateController_:SetSelectedIndex(arg_11_0.dicePoint_)

	if arg_11_0.dicePoint_ ~= 0 then
		arg_11_0.combolController_:SetSelectedState("empty")
		arg_11_0.symbolController_:SetSelectedState("empty")
		arg_11_0.pointController_:SetSelectedIndex(0)

		return
	end

	if arg_11_0.limitType_ <= 4 then
		arg_11_0.combolController_:SetSelectedState("empty")
	else
		arg_11_0.symbolController_:SetSelectedState("empty")
	end

	if arg_11_0.limitType_ == var_0_1.GREATER then
		arg_11_0.symbolController_:SetSelectedState("greater")
		arg_11_0.pointController_:SetSelectedIndex(arg_11_0.inputRange_[1])
	elseif arg_11_0.limitType_ == var_0_1.SMALLER then
		arg_11_0.symbolController_:SetSelectedState("smaller")
		arg_11_0.pointController_:SetSelectedIndex(arg_11_0.inputRange_[2])
	elseif arg_11_0.limitType_ == var_0_1.EQUAL then
		arg_11_0.symbolController_:SetSelectedState("empty")
		arg_11_0.pointController_:SetSelectedIndex(arg_11_0.inputRange_[1])
	elseif arg_11_0.limitType_ == var_0_1.BETWEEN then
		arg_11_0.symbolController_:SetSelectedState("empty")
		arg_11_0.pointController_:SetSelectedIndex(0)
	elseif arg_11_0.limitType_ == var_0_1.ODD then
		arg_11_0.combolController_:SetSelectedState("odd")
		arg_11_0.pointController_:SetSelectedIndex(0)
	elseif arg_11_0.limitType_ == var_0_1.EVEN then
		arg_11_0.combolController_:SetSelectedState("even")
		arg_11_0.pointController_:SetSelectedIndex(0)
	else
		arg_11_0.symbolController_:SetSelectedState("empty")
		arg_11_0.combolController_:SetSelectedState("empty")
		arg_11_0.pointController_:SetSelectedIndex(0)
	end
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.clickHandler_ = nil

	Object.Destroy(arg_12_0.gameObject_)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
