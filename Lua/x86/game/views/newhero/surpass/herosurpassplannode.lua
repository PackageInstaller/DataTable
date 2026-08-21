local var_0_0 = class("HeroSurpassPlanNode", ReduxView)
local var_0_1 = {
	lockState = {
		selectLock = "SelectLock",
		name = "lock",
		lock = "2",
		unlock = "1"
	},
	selectState = {
		name = "select",
		use = "state1",
		unUse = "state0"
	},
	upState = {
		unUp = "state0",
		name = "up",
		canUp = "state1"
	}
}

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitPlanList()
	arg_2_0:ShowView(false)
end

function var_0_0.ShowView(arg_3_0, arg_3_1)
	arg_3_0.gameObject_:SetActive(arg_3_1)
	arg_3_0:CancelSelect()

	arg_3_0.selectIndex = nil
end

function var_0_0.ShowAndNotCancelSelect(arg_4_0)
	arg_4_0.gameObject_:SetActive(true)
end

function var_0_0.GetSelectIndex(arg_5_0)
	return arg_5_0.selectIndex
end

function var_0_0.GetSelectStar(arg_6_0)
	return arg_6_0.selectIndex and arg_6_0.planStarList[arg_6_0.selectIndex] or nil
end

function var_0_0.InitPlanList(arg_7_0)
	arg_7_0.planList = {}

	for iter_7_0 = 1, 4 do
		local var_7_0 = arg_7_0:CreatePlanItem(iter_7_0)

		arg_7_0.planList[iter_7_0] = var_7_0
	end
end

function var_0_0.CreatePlanItem(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1 = arg_8_0["planbtn" .. arg_8_1 .. "Go_"]

	ComponentBinder.GetInstance():BindCfgUI(var_8_0, var_8_1)

	var_8_0.gameObject = var_8_1
	var_8_0.lockController = var_8_0.Controllerexcollection_:GetController(var_0_1.lockState.name)
	var_8_0.selectController = var_8_0.Controllerexcollection_:GetController(var_0_1.selectState.name)
	var_8_0.upController = var_8_0.Controllerexcollection_:GetController(var_0_1.upState.name)

	arg_8_0:AddBtnListener(var_8_0.planBtn_, nil, function()
		arg_8_0:ClickPlanItem(arg_8_1)
	end)

	return var_8_0
end

function var_0_0.CancelSelect(arg_10_0)
	if arg_10_0.selectIndex then
		arg_10_0.planList[arg_10_0.selectIndex].selectController:SetSelectedState(var_0_1.selectState.unUse)
	end
end

function var_0_0.ClickPlanItem(arg_11_0, arg_11_1)
	if arg_11_0.selectIndex == arg_11_1 then
		return
	end

	arg_11_0:CancelSelect()
	arg_11_0.planList[arg_11_1].selectController:SetSelectedState(var_0_1.selectState.use)

	arg_11_0.selectIndex = arg_11_1

	local var_11_0 = arg_11_0.planStarList[arg_11_1]

	if arg_11_0.clickCallBack then
		arg_11_0.clickCallBack(var_11_0)
	end
end

function var_0_0.ClickPlanItemByStarID(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.planStarList) do
		if iter_12_1 == arg_12_1 then
			arg_12_0:ClickPlanItem(iter_12_0)

			break
		end
	end
end

function var_0_0.SetClickCallBack(arg_13_0, arg_13_1)
	arg_13_0.clickCallBack = arg_13_1
end

function var_0_0.RefreshUi(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_2.star
	local var_14_1 = SurpassTools.GetNextSurpassStarID(var_14_0)

	arg_14_0.planStarList = {}

	local var_14_2 = HeroStarCfg.get_id_list_by_star[arg_14_1]
	local var_14_3 = 0

	for iter_14_0, iter_14_1 in ipairs(var_14_2) do
		local var_14_4 = HeroStarCfg[iter_14_1]

		if var_14_4 and var_14_4.phase > 0 then
			table.insert(arg_14_0.planStarList, iter_14_1)

			var_14_3 = var_14_3 + 1

			local var_14_5 = var_0_1.upState.noUp
			local var_14_6 = var_14_4.gold_cost

			if checkGold(var_14_6, false) and var_14_1 and arg_14_2.piece >= var_14_4.star_up and var_14_1 == iter_14_1 then
				var_14_5 = var_0_1.upState.canUp
			end

			arg_14_0.planList[var_14_3].upController:SetSelectedState(var_14_5)

			local var_14_7

			if var_14_1 and var_14_1 == iter_14_1 then
				var_14_7 = var_0_1.lockState.selectLock
			else
				var_14_7 = var_14_1 and iter_14_1 < var_14_1 and var_0_1.lockState.unlock or var_0_1.lockState.lock
			end

			arg_14_0.planList[var_14_3].lockController:SetSelectedState(var_14_7)
		end
	end

	for iter_14_2, iter_14_3 in pairs(arg_14_0.planList) do
		SetActive(iter_14_3.gameObject, iter_14_2 <= var_14_3 and true or false)
	end

	SetActive(arg_14_0.lineGo_, var_14_3 ~= 0)
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
