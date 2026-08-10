local var_0_0 = class("OathHeroPlotSubView", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.items = {}

	arg_1_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_2_0)
	SetActive(arg_2_0.gameObject_, true)
end

function var_0_0.OnExit(arg_3_0)
	SetActive(arg_3_0.gameObject_, false)
end

function var_0_0.Dispose(arg_4_0)
	if arg_4_0.items then
		for iter_4_0, iter_4_1 in pairs(arg_4_0.items) do
			local var_4_0 = iter_4_1.gameObject_

			iter_4_1:Dispose()
			Object.Destroy(var_4_0)
		end
	end

	arg_4_0.items = nil
end

local function var_0_1(arg_5_0, arg_5_1)
	for iter_5_0 = arg_5_0.list_.childCount + 1, arg_5_1 do
		local var_5_0 = Object.Instantiate(arg_5_0.itemPrefab_, arg_5_0.list_)
	end

	local var_5_1 = arg_5_0.list_.childCount

	for iter_5_1 = 1, var_5_1 do
		local var_5_2 = arg_5_0.list_:GetChild(iter_5_1 - 1).gameObject

		arg_5_0.items[iter_5_1] = arg_5_0.items[iter_5_1] or var_0_0.PlotItem.New(var_5_2)

		arg_5_0.items[iter_5_1]:SetIsShow(iter_5_1 <= arg_5_1)
	end
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:GetAllPlots(arg_6_1)

	var_0_1(arg_6_0, #var_6_0)

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		arg_6_0.items[iter_6_0]:SetData(iter_6_1)
	end
end

function var_0_0.GetAllPlots(arg_7_0, arg_7_1)
	return WeddingNewsCfg.get_id_list_by_hero[arg_7_1]
end

local var_0_2 = class("OathHeroPlotItem", BaseView)

var_0_0.PlotItem = var_0_2

function var_0_2.Ctor(arg_8_0, arg_8_1)
	arg_8_0.gameObject_ = arg_8_1
	arg_8_0.transform_ = arg_8_1.transform

	arg_8_0:BindCfgUI()

	arg_8_0.unlockController = arg_8_0.controllers_:GetController("unlock")
end

function var_0_2.SetData(arg_9_0, arg_9_1)
	local var_9_0 = WeddingNewsCfg[arg_9_1]
	local var_9_1 = OathTools.IsCharaSecretUnlocked(arg_9_1)
	local var_9_2 = var_9_1 and "true" or "false"

	arg_9_0.unlockController:SetSelectedState(var_9_2)

	if var_9_1 then
		arg_9_0.desc_.text = GetI18NText(var_9_0.desc)
	else
		arg_9_0.lockCondition_.text = arg_9_0:GetUnlockCondition(var_9_0.condition)
	end
end

function var_0_2.SetIsShow(arg_10_0, arg_10_1)
	SetActive(arg_10_0.gameObject_, arg_10_1)
end

local function var_0_3(arg_11_0)
	local var_11_0 = ConditionCfg[arg_11_0]

	if var_11_0 then
		return GetI18NText(var_11_0.desc)
	end
end

function var_0_2.GetUnlockCondition(arg_12_0, arg_12_1)
	if arg_12_1 == nil or #arg_12_1 == 0 then
		return ""
	end

	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		local var_12_1 = var_0_3(iter_12_1)

		if var_12_1 and var_12_1 ~= "" then
			table.insert(var_12_0, var_12_1)
		end
	end

	return table.concat(var_12_0, "\n")
end

return var_0_0
