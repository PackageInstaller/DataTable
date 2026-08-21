local var_0_0 = class("SimBusinessGuestInfoItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.statusController = arg_2_0.controllers_:GetController("status")
	arg_2_0.selectController = arg_2_0.controllers_:GetController("select")
	arg_2_0.hpBarController = arg_2_0.controllers_:GetController("showHp")
	arg_2_0.typeController = arg_2_0.controllers_:GetController("category")
	arg_2_0.specialController = arg_2_0.controllers_:GetController("special")

	arg_2_0:AddUIListener()
	arg_2_0:RegisterEvents()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.clickFunc then
			arg_3_0:clickFunc()
		end
	end)
end

function var_0_0.RegisterEvents(arg_5_0)
	arg_5_0:RegistEventListener("SIM_BUSINESS_GUEST_HP_CHANGE", handler(arg_5_0, arg_5_0.OnSetHp))
end

local function var_0_1(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return 0, 0
	end

	local var_6_0
	local var_6_1

	if arg_6_0.eid and Dorm.DormEntityManager.IsValidEntityID(arg_6_0.eid) then
		local var_6_2 = DormUtils.GetEntityData(arg_6_0.eid)

		var_6_0, var_6_1 = var_6_2.hp, var_6_2.max
	else
		var_6_0, var_6_1 = arg_6_0.remain, arg_6_0.max
	end

	local var_6_3 = math.max(var_6_0, 0)

	var_6_1 = var_6_1 or var_6_3

	return var_6_3, var_6_1
end

function var_0_0.HideIfHpBarEmpty(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.hideEmptyBar = arg_7_1

	if not arg_7_2 then
		return
	end

	if arg_7_0.showHp then
		if arg_7_1 then
			arg_7_0.hpBarController:SetSelectedState(arg_7_0.bar_.fillAmount == 0 and "normal" or "none")
		else
			arg_7_0.hpBarController:SetSelectedState("normal")
		end
	else
		arg_7_0.hpBarController:SetSelectedState("none")
	end
end

function var_0_0.RefreshData(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	local var_8_0 = arg_8_1.id

	arg_8_0.focus = arg_8_1
	arg_8_0.guestID = arg_8_1.id
	arg_8_0.index = arg_8_2

	local var_8_1 = SimBusinessGuestCfg[var_8_0]

	arg_8_0.icon_.sprite = SimBusinessTools.GetClientIcon(var_8_0)

	local var_8_2 = var_8_1.special_effect and var_8_1.special_effect ~= 0

	arg_8_0.specialController:SetSelectedState(var_8_2 and "true" or "false")
	arg_8_0.typeController:SetSelectedState(tostring(var_8_1.love_type))
	arg_8_0:SetSelected(arg_8_3)

	local var_8_3, var_8_4 = var_0_1(arg_8_1, arg_8_4)

	arg_8_0:SetHpBar(arg_8_4, arg_8_5, var_8_3, var_8_4)

	if arg_8_0.statusController then
		arg_8_0.statusController:SetSelectedState(var_8_3 == 0 and "happy" or "sad")
	end
end

function var_0_0.SetSelected(arg_9_0, arg_9_1)
	arg_9_0.selectController:SetSelectedState(arg_9_1 and "true" or "false")
end

function var_0_0.SetHpBar(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	arg_10_0.showHp, arg_10_0.reverseHpBarFill = arg_10_1, arg_10_2

	if arg_10_1 then
		if arg_10_2 then
			arg_10_3 = arg_10_4 - arg_10_3
		end

		local var_10_0 = 1

		if arg_10_4 ~= 0 then
			var_10_0 = arg_10_3 / arg_10_4
		end

		arg_10_0.bar_.fillAmount = var_10_0
		arg_10_0.progressText_.text = arg_10_3
	end

	if arg_10_0.hideEmptyBar and arg_10_0.bar_.fillAmount == 0 then
		arg_10_1 = false
	end

	arg_10_0.hpBarController:SetSelectedState(arg_10_1 and "normal" or "none")
end

function var_0_0.OnSetHp(arg_11_0, arg_11_1)
	if arg_11_1 == nullable(arg_11_0.focus, "eid") then
		arg_11_0:SetHpBar(arg_11_0.showHp, arg_11_0.reverseHpBarFill, var_0_1({
			eid = arg_11_1
		}, arg_11_0.showHp))
	end
end

function var_0_0.RegisterClickFunc(arg_12_0, arg_12_1)
	arg_12_0.clickFunc = arg_12_1
end

function var_0_0.SetNewRedpoint(arg_13_0, arg_13_1)
	manager.redPoint:SetRedPointIndependent(arg_13_0.transform_, arg_13_1, nil, RedPointStyle.SHOW_NEW_TAG)
end

return var_0_0
