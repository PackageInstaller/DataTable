local var_0_0 = class("SpringFestivalZumaTalentInfoView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.lockController = arg_2_0.controller_:GetController("lockState")

	arg_2_0:AddBtnListener(arg_2_0.unlockBtn_, nil, function()
		ShowTips("ACTIVITY_ZUMA_TALENT_LOCK")
	end)
	arg_2_0:AddBtnListener(arg_2_0.openBtn_, nil, function()
		arg_2_0:OnClickLockBtn()
	end)

	arg_2_0.descTextList = {}

	table.insert(arg_2_0.descTextList, SpringFestivalZumaTalentDescItem.New(arg_2_0.describeGo_))

	for iter_2_0 = 1, 4 do
		local var_2_0 = arg_2_0[string.format("enhance%sGo_", iter_2_0)]

		table.insert(arg_2_0.descTextList, SpringFestivalZumaTalentDescItem.New(var_2_0))
	end
end

function var_0_0.OnClickLockBtn(arg_5_0)
	if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_3_11_ZUMA) then
		ShowTips("TIME_OVER")

		return
	end

	local var_5_0 = ActivityZumaTalentCfg[arg_5_0.useTalentID]

	if not var_5_0 then
		return
	end

	if var_5_0.need > ZumaData:GetZumaCoin() then
		ShowTips("ACTIVITY_ZUMA_TALENT_COST")

		return
	end

	ZumaAction.OpenZumaTalent(arg_5_0.useTalentID)
end

function var_0_0.CheckIsShow(arg_6_0)
	return arg_6_0.isShow
end

function var_0_0.Show(arg_7_0, arg_7_1)
	arg_7_0.isShow = arg_7_1

	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.RefreshTalentInfoUI(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:Show(true)

	local var_8_0 = ActivityZumaTalentCfg[arg_8_1]

	if ZumaData:GetZumaCoin() < var_8_0.need then
		arg_8_0.costValueText_.text = string.format("<color=#FF000B>%s</color>", var_8_0.need)
	else
		arg_8_0.costValueText_.text = var_8_0.need
	end

	arg_8_0.useTalentID = arg_8_1

	local var_8_1 = var_8_0.pre_id_list

	if arg_8_1 == ZumaConst.ZUMA_FINALLY_ID then
		arg_8_0.conditionText_.text = GetTips("ACTIVITY_SPRING_FESTIVAL_ZUMA_NEED_TO_UNLOCK_OTHER_TALENT")
	else
		local var_8_2 = ""
		local var_8_3 = false
		local var_8_4 = 0

		for iter_8_0, iter_8_1 in pairs(var_8_1) do
			if iter_8_1 ~= 0 then
				local var_8_5 = true

				if var_8_4 == 0 then
					var_8_2 = string.format("%s%s", var_8_2, ActivityZumaTalentCfg[iter_8_1].name)
				else
					var_8_2 = string.format("%s,%s", var_8_2, ActivityZumaTalentCfg[iter_8_1].name)
				end

				var_8_4 = var_8_4 + 1
			end
		end

		local var_8_6 = string.format(GetTips("ACTIVITY_ZUMA_TALENT_UNLOCK_CONDITION"), var_8_2)

		arg_8_0.conditionText_.text = var_8_6
	end

	if ZumaData:GetZumaTalentIsOpen(arg_8_1) then
		arg_8_0.lockController:SetSelectedState("isUse")
	elseif ZumaData:GetZumaTalentIsCanOpen(arg_8_1) then
		arg_8_0.lockController:SetSelectedState("canOpen")
	else
		arg_8_0.lockController:SetSelectedState("lock")
	end

	local var_8_7 = arg_8_1

	if #var_8_0.pre_id_list == 1 and var_8_0.pre_id_list[1] ~= 0 then
		var_8_7 = var_8_0.pre_id_list[1]
	end

	arg_8_0.nameText_.text = ActivityZumaTalentCfg[var_8_7].name

	for iter_8_2, iter_8_3 in pairs(arg_8_0.descTextList) do
		iter_8_3:Show(false)
	end

	local var_8_8 = ZumaData:GetSkillGroupList(arg_8_1)
	local var_8_9 = 0

	if var_8_7 ~= arg_8_1 then
		var_8_9 = 1
	end

	for iter_8_4, iter_8_5 in pairs(var_8_8) do
		local var_8_10 = arg_8_0.descTextList[iter_8_4 + var_8_9]

		if var_8_10 and (ZumaData:GetZumaTalentIsOpen(iter_8_5) or iter_8_5 == arg_8_1) then
			var_8_10:Show(true)
			var_8_10:RefreshUI(iter_8_5)
		end
	end
end

function var_0_0.Dispose(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.descTextList) do
		if iter_9_1 then
			iter_9_1:Dispose()

			iter_9_1 = nil
		end
	end

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
