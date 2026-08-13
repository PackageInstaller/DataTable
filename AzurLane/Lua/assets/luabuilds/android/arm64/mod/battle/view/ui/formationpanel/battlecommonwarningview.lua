ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction
local var_0_2 = var_0.Battle.BattleSkillEditCustomWarning

class = var_0_10003

local var_0_3 = var_0_10003("BattleCommonWarningView")

var_0.Battle.BattleCommonWarningView = var_0_3
var_0_3.__name = "BattleCommonWarningView"
var_0_3.WARNING_TYPE_SUBMARINE = "submarine"
var_0_3.WARNING_TYPE_ARTILLERY = "artillery"

function var_0_3.Ctor(arg_1_0, arg_1_1)
	arg_1_0._submarineCount = 0
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0._subIcon = var_2.Find(var_1_0, "submarineIcon")

	local var_1_1 = arg_1_0._tf

	arg_1_0._tips = var_2.Find(var_1_1, "warningTips")

	local var_1_2 = arg_1_0._tf

	arg_1_0._subWarn = var_2.Find(var_1_2, "submarineWarningTips")
	arg_1_0._warningRequestTable = {
		{
			flag = false,
			type = var_0_3.WARNING_TYPE_ARTILLERY,
			tf = arg_1_0._tips
		},
		{
			flag = false,
			type = var_0_3.WARNING_TYPE_SUBMARINE,
			tf = arg_1_0._subWarn
		}
	}

	local var_1_3 = arg_1_0._tf

	arg_1_0._customWarningTpl = var_2.Find(var_1_3, "customWarningTpl")

	local var_1_4 = arg_1_0._tf

	arg_1_0._customWarningContainer = var_2.Find(var_1_4, "customWarningContainer")
	arg_1_0._customWarningList = {}

	return
end

function var_0_3.UpdateHostileSubmarineCount(arg_2_0, arg_2_1)
	if arg_2_1 > 0 and arg_2_0._submarineCount <= 0 then
		arg_2_0:activeSubmarineWarning()
	elseif arg_2_0._submarineCount > 0 and arg_2_1 <= 0 then
		arg_2_0:deactiveSubmarineWarning()
	end

	arg_2_0._submarineCount = arg_2_1

	return
end

function var_0_3.GetCount(arg_3_0)
	return arg_3_0._submarineCount
end

function var_0_3.ActiveWarning(arg_4_0, arg_4_1)
	local var_4_0 = false
	local var_4_1 = #arg_4_0._warningRequestTable

	ipairs = var_1_10004

	for iter_4_0, iter_4_1 in var_1_10004(arg_4_0._warningRequestTable) do
		if arg_4_1 == iter_4_1.type then
			iter_4_1.flag = true

			if not var_4_0 then
				SetActive = var_9

				var_9(iter_4_1.tf, true)

				var_4_1 = iter_4_0
			else
				break
			end
		else
			var_4_0 = var_4_0 or iter_4_1.flag

			if iter_4_1.flag and var_4_1 < iter_4_0 then
				SetActive = var_9

				var_9(iter_4_1.tf, false)
			end
		end
	end

	return
end

function var_0_3.DeactiveWarning(arg_5_0, arg_5_1)
	ipairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_0._warningRequestTable) do
		if arg_5_1 == iter_5_1.type then
			iter_5_1.flag = false
			SetActive = var_7

			var_7(iter_5_1.tf, false)
		elseif iter_5_1.flag then
			arg_5_0:ActiveWarning(iter_5_1.type)

			break
		end
	end

	return
end

function var_0_3.EditCustomWarning(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.op
	local var_6_1 = arg_6_1.key

	if var_6_0 == var_0_2.OP_ADD then
		cloneTplTo = var_4

		local var_6_2 = var_4(arg_6_0._customWarningTpl, arg_6_0._customWarningContainer)
		local var_6_3 = var_0.Battle.BattleCustomWarningLabel.New(var_6_2)

		var_5.ConfigData(var_6_3, arg_6_1)

		arg_6_0._customWarningList[var_6_1] = var_5
	elseif var_6_0 == var_0_2.OP_REMOVE then
		if arg_6_0._customWarningList[var_6_1] then
			var_4:SetExpire()
		end
	elseif var_6_0 == var_0_2.OP_REMOVE_PERMANENT then
		pairs = var_4

		for iter_6_0, iter_6_1 in var_4(arg_6_0._customWarningList) do
			if iter_6_1:GetDuration() <= 0 then
				iter_6_1:SetExpire()
			end
		end
	elseif var_6_0 == var_0_2.OP_REMOVE_TEMPLATE then
		pairs = var_4

		for iter_6_2, iter_6_3 in var_4(arg_6_0._customWarningList) do
			if iter_6_3:GetDuration() > 0 then
				iter_6_3:SetExpire()
			end
		end
	end

	return
end

function var_0_3.Update(arg_7_0)
	pairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0._customWarningList) do
		iter_7_1:Update()

		if iter_7_1:IsExpire() then
			iter_7_1:Dispose()

			arg_7_0._customWarningList[iter_7_0] = nil
		end
	end

	return
end

function var_0_3.activeSubmarineWarning(arg_8_0)
	SetActive = var_1_10001

	var_1_10001(arg_8_0._subIcon, true)

	local var_8_0 = arg_8_0

	arg_8_0.ActiveWarning(var_8_0, var_0_3.WARNING_TYPE_SUBMARINE)

	LeanTween = var_1

	local var_8_1 = var_1.cancel

	go = var_8_0

	var_8_1(var_8_0(arg_8_0._subIcon))

	LeanTween = var_8_1

	local var_8_2 = var_8_1.alpha

	rtf = var_3

	local var_8_3 = var_8_2(var_3(arg_8_0._subIcon), 1, 2)

	var_1.setFrom(var_8_3, 0)

	return
end

function var_0_3.deactiveSubmarineWarning(arg_9_0)
	LeanTween = var_1_10001

	local var_9_0 = var_1_10001.cancel

	go = var_1_10003

	var_9_0(var_1_10003(arg_9_0._subIcon))

	LeanTween = var_9_0

	local var_9_1 = var_9_0.alpha

	rtf = var_3

	local var_9_2 = var_9_1(var_3(arg_9_0._subIcon), 0, 1)
	local var_9_3 = var_1.setFrom(var_9_2, 1)
	local var_9_4 = var_1.setOnComplete

	System = var_4

	var_9_4(var_9_3, var_4.Action(function()
		SetActive = var_2_10000

		var_2_10000(arg_9_0._subIcon, false)

		local var_10_0 = arg_9_0

		var_0.DeactiveWarning(var_10_0, var_0_3.WARNING_TYPE_SUBMARINE)

		return
	end))

	return
end

function var_0_3.Dispose(arg_11_0)
	pairs = var_1_10001

	for iter_11_0, iter_11_1 in var_1_10001(arg_11_0._customWarningList) do
		iter_11_1:Dispose()

		arg_11_0._customWarningList[iter_11_0] = nil
	end

	arg_11_0._customWarningList = nil
	arg_11_0._go = nil
	arg_11_0._tf = nil
	arg_11_0._icon = nil
	arg_11_0._tips = nil

	return
end

return
