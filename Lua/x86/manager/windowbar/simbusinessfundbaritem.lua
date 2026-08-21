local var_0_0 = class("WindowSimBusinessFundBarItem", import(".WindowBarItemBase"))

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.data = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	var_0_0.super.Init(arg_2_0)

	arg_2_0.typeCon_ = ControllerUtil.GetController(arg_2_0.transform_, "type")

	arg_2_0:RefreshUI()
end

function var_0_0.AddListeners(arg_3_0)
	var_0_0.super.AddListeners(arg_3_0)
end

function var_0_0.OnClick(arg_4_0)
	ShowPopItem(POP_ITEM, {
		SimBusinessData:GetSimBusinessFundItemID()
	})
end

function var_0_0.RefreshUI(arg_5_0)
	local var_5_0 = SimBusinessData:GetSimBusinessFundItemID()

	arg_5_0.icon_.sprite = ItemTools.getItemLittleSprite(var_5_0)

	local var_5_1 = SimBusinessTools.GetAvailableFund(arg_5_0.data:GetStage())

	arg_5_0.text_.text = var_5_1
end

function var_0_0.SetActive(arg_6_0, arg_6_1)
	var_0_0.super.SetActive(arg_6_0, arg_6_1)

	if arg_6_1 then
		arg_6_0:RefreshUI()
	end
end

function var_0_0.RegisterEvents(arg_7_0)
	arg_7_0:RegistEventListener(CURRENCY_UPDATE, handler(arg_7_0, arg_7_0.RefreshUI))
	arg_7_0:RegistEventListener("SIM_BUSINESS_SHELF_COST_UPDATE", handler(arg_7_0, arg_7_0.RefreshUI))
	arg_7_0:RegistEventListener("SIM_BUSINESS_STAGE_CHANGED", handler(arg_7_0, arg_7_0.RefreshUI))
end

local var_0_1 = class("SimBusinessFundBar")

function var_0_1.Ctor(arg_8_0, arg_8_1)
	arg_8_0.stage = arg_8_1
end

function var_0_1.GetStage(arg_9_0)
	if arg_9_0.stage then
		return arg_9_0.stage
	end

	return SimBusinessGame.GetInstance().stage
end

function var_0_1.GetBarClass(arg_10_0)
	return var_0_0
end

local var_0_2 = class("SimBusinessNormalStageFundBar", var_0_1)

function var_0_2.GetStage(arg_11_0)
	if arg_11_0.stage then
		return arg_11_0.stage
	end

	return SimBusinessTools.GetDefaultEnterDailyLevel()
end

var_0_0.bar = var_0_1
var_0_0.normalStageFundBar = var_0_2

return var_0_0
