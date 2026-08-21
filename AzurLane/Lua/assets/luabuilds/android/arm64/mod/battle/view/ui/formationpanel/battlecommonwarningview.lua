ys = ys or {}

local var_0_1 = ys.Battle.BattleSkillEditCustomWarning
local var_0_2 = class("BattleCommonWarningView")

ys.Battle.BattleCommonWarningView = var_0_2
var_0_2.__name = "BattleCommonWarningView"
var_0_2.WARNING_TYPE_SUBMARINE = "submarine"
var_0_2.WARNING_TYPE_ARTILLERY = "artillery"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	arg_1_0._submarineCount = 0
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0._subIcon = arg_1_0._tf:Find("submarineIcon")
	arg_1_0._tips = arg_1_0._tf:Find("warningTips")
	arg_1_0._subWarn = arg_1_0._tf:Find("submarineWarningTips")
	arg_1_0._warningRequestTable = {
		{
			flag = false,
			type = var_0_2.WARNING_TYPE_ARTILLERY,
			tf = arg_1_0._tips
		},
		{
			flag = false,
			type = var_0_2.WARNING_TYPE_SUBMARINE,
			tf = arg_1_0._subWarn
		}
	}
	arg_1_0._customWarningTpl = arg_1_0._tf:Find("customWarningTpl")
	arg_1_0._customWarningContainer = arg_1_0._tf:Find("customWarningContainer")
	arg_1_0._customWarningList = {}

	return
end

function var_0_2.UpdateHostileSubmarineCount(arg_2_0, arg_2_1)
	if arg_2_1 > 0 and arg_2_0._submarineCount <= 0 then
		arg_2_0:activeSubmarineWarning()
	elseif arg_2_0._submarineCount > 0 and arg_2_1 <= 0 then
		arg_2_0:deactiveSubmarineWarning()
	end

	arg_2_0._submarineCount = arg_2_1

	return
end

function var_0_2.GetCount(arg_3_0)
	return arg_3_0._submarineCount
end

function var_0_2.ActiveWarning(arg_4_0, arg_4_1)
	local var_4_0 = #arg_4_0._warningRequestTable

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._warningRequestTable) do
		local var_4_1

		if arg_4_1 == iter_4_1.type then
			iter_4_1.flag = true

			if not false then
				SetActive(iter_4_1.tf, true)

				var_4_0 = iter_4_0
			else
				break
			end
		else
			var_4_1 = false or iter_4_1.flag

			if iter_4_1.flag and var_4_0 < iter_4_0 then
				SetActive(iter_4_1.tf, false)
			end
		end
	end

	return
end

function var_0_2.DeactiveWarning(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0._warningRequestTable) do
		if arg_5_1 == iter_5_1.type then
			iter_5_1.flag = false

			SetActive(iter_5_1.tf, false)
		elseif iter_5_1.flag then
			arg_5_0:ActiveWarning(iter_5_1.type)

			break
		end
	end

	return
end

function var_0_2.EditCustomWarning(arg_6_0, arg_6_1)
	if arg_6_1.op == var_0_1.OP_ADD then
		local var_6_0 = var_0.Battle.BattleCustomWarningLabel.New((cloneTplTo(arg_6_0._customWarningTpl, arg_6_0._customWarningContainer)))

		var_6_0:ConfigData(arg_6_1)

		arg_6_0._customWarningList[arg_6_1.key] = var_6_0
	elseif arg_6_1.op == var_0_1.OP_REMOVE then
		if arg_6_0._customWarningList[arg_6_1.key] then
			arg_6_0._customWarningList[arg_6_1.key]:SetExpire()
		end
	elseif arg_6_1.op == var_0_1.OP_REMOVE_PERMANENT then
		for iter_6_0, iter_6_1 in pairs(arg_6_0._customWarningList) do
			if iter_6_1:GetDuration() <= 0 then
				iter_6_1:SetExpire()
			end
		end
	elseif arg_6_1.op == var_0_1.OP_REMOVE_TEMPLATE then
		for iter_6_2, iter_6_3 in pairs(arg_6_0._customWarningList) do
			if iter_6_3:GetDuration() > 0 then
				iter_6_3:SetExpire()
			end
		end
	end

	return
end

function var_0_2.Update(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0._customWarningList) do
		iter_7_1:Update()

		if iter_7_1:IsExpire() then
			iter_7_1:Dispose()

			arg_7_0._customWarningList[iter_7_0] = nil
		end
	end

	return
end

function var_0_2.activeSubmarineWarning(arg_8_0)
	SetActive(arg_8_0._subIcon, true)
	arg_8_0:ActiveWarning(var_0_2.WARNING_TYPE_SUBMARINE)
	LeanTween.cancel(go(arg_8_0._subIcon))
	LeanTween.alpha(rtf(arg_8_0._subIcon), 1, 2):setFrom(0)

	return
end

function var_0_2.deactiveSubmarineWarning(arg_9_0)
	LeanTween.cancel(go(arg_9_0._subIcon))
	LeanTween.alpha(rtf(arg_9_0._subIcon), 0, 1):setFrom(1):setOnComplete(System.Action(function()
		SetActive(arg_9_0._subIcon, false)
		arg_9_0:DeactiveWarning(var_0_2.WARNING_TYPE_SUBMARINE)

		return
	end))

	return
end

function var_0_2.Dispose(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0._customWarningList) do
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
