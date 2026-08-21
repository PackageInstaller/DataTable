local var_0_0 = class("WorldBossRankPage", import("....base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "WorldBossRankUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.numberTF1 = arg_2_0._tf:Find("frame/list/number1")

	setActive(arg_2_0.numberTF1, false)

	arg_2_0.numberTF2 = arg_2_0._tf:Find("frame/list/number2")

	setActive(arg_2_0.numberTF2, false)

	arg_2_0.numberTF3 = arg_2_0._tf:Find("frame/list/number3")

	setActive(arg_2_0.numberTF3, false)

	arg_2_0.numberTF4 = arg_2_0._tf:Find("frame/list/number4")

	setActive(arg_2_0.numberTF4, false)

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Update(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.bossProxy = arg_5_1
	arg_5_0.bossId = arg_5_2

	arg_5_0:Show()
	arg_5_0:UpdateRankList()

	return
end

function var_0_0.UpdateRankList(arg_6_0)
	local var_6_0 = arg_6_0.bossProxy:GetRank(arg_6_0.bossId)

	if var_6_0 == nil then
		arg_6_0:emit(WorldBossMediator.ON_RANK_LIST, arg_6_0.bossId)
	else
		arg_6_0:UpdateRanks(var_6_0)
	end

	return
end

function var_0_0.UpdateRanks(arg_7_0, arg_7_1)
	for iter_7_0 = 1, 3 do
		setActive(arg_7_0["numberTF" .. iter_7_0], arg_7_1[iter_7_0])

		if arg_7_1[iter_7_0] then
			arg_7_0:UpdateRank(arg_7_0["numberTF" .. iter_7_0], arg_7_1[iter_7_0])
		end
	end

	local var_7_0 = getProxy(PlayerProxy):getRawData().id
	local var_7_1

	for iter_7_1, iter_7_2 in ipairs(arg_7_1) do
		if iter_7_2.id == var_7_0 then
			var_7_1 = iter_7_2
			var_7_1.number = iter_7_1

			break
		end
	end

	if var_7_1 then
		arg_7_0:UpdateMyRank(arg_7_0.numberTF4, var_7_1)
	else
		setActive(arg_7_0.numberTF4, false)
	end

	return
end

function var_0_0.UpdateRank(arg_8_0, arg_8_1, arg_8_2)
	setText(arg_8_1:Find("Text"), arg_8_2.name)
	setText(arg_8_1:Find("damage/Text"), arg_8_2.damage)

	local var_8_0 = getProxy(PlayerProxy)

	setActive(arg_8_1:Find("view"), arg_8_2.id ~= var_8_0:getRawData().id)
	onButton(arg_8_0, arg_8_1:Find("view"), function()
		arg_8_0:emit(WorldBossMediator.FETCH_RANK_FORMATION, arg_8_2.id, arg_8_0.bossId)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateMyRank(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:UpdateRank(arg_10_1, arg_10_2)
	setText(arg_10_1:Find("number"), arg_10_2.number)

	return
end

function var_0_0.isActive(arg_11_0)
	return isActive(arg_11_0._tf)
end

function var_0_0.OnDestroy(arg_12_0)
	return
end

return var_0_0
