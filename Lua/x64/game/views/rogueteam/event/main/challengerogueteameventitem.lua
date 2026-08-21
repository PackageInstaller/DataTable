local var_0_0 = class("ChallengeRogueTeamEventItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()

	arg_1_0.richText_ = arg_1_0.descText_.transform:GetComponent("RichText")

	arg_1_0:AddListeners()

	arg_1_0.stateControllerEx_ = arg_1_0.controllerEx_:GetController("status")
	arg_1_0.showIconControllerEx_ = arg_1_0.controllerEx_:GetController("showIcon")
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0.richText_:RemoveAllListeners()

	arg_2_0.richText_ = nil

	var_0_0.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.lock_ then
			return
		end

		local var_4_0 = ChallengeRogueTeamData:EventGetCurrentID()

		ChallengeRogueTeamData:UISetEventIDAnimator(var_4_0, arg_3_0.optionData_.id)
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_EVENT_OPTION_SELECT, arg_3_0.optionData_)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.optionData_ = arg_5_1

	local var_5_0 = arg_5_1.id
	local var_5_1 = RogueTeamEventOptionCfg[var_5_0]

	arg_5_0.titleText_.text = var_5_1.title

	arg_5_0:RefreshText()

	arg_5_0.lock_ = arg_5_1.isLock

	local var_5_2 = var_5_1.hide_flag ~= 0

	if arg_5_0.lock_ and var_5_2 then
		arg_5_0:Show(false)
	else
		arg_5_0:RefreshState()
		arg_5_0:Show(true)
	end

	if var_5_1.option_icon ~= "" then
		arg_5_0.showIconControllerEx_:SetSelectedState("true")

		arg_5_0.icon_.sprite = getSprite("Atlas/Activity_RoulikeAtlas", var_5_1.option_icon)
	else
		arg_5_0.showIconControllerEx_:SetSelectedState("false")
	end
end

function var_0_0.RefreshState(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.optionData_.id

	if arg_6_0.lock_ then
		arg_6_0.stateControllerEx_:SetSelectedState("lock")

		local var_6_1 = RogueTeamEventOptionCfg[var_6_0]

		arg_6_0.descText_.text = var_6_1.lock_desc
	elseif arg_6_1 == var_6_0 then
		arg_6_0.stateControllerEx_:SetSelectedState("select")
		arg_6_0:RefreshText(true)
	else
		arg_6_0.stateControllerEx_:SetSelectedState("normal")
		arg_6_0:RefreshText(false)
	end
end

function var_0_0.RefreshText(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.optionData_
	local var_7_1 = var_7_0.id
	local var_7_2 = RogueTeamEventOptionCfg[var_7_1]
	local var_7_3 = arg_7_0.descText_.color
	local var_7_4 = string.format("#%s", ColorToHex(var_7_3))

	if not var_7_0.isLock then
		local var_7_5 = {}

		for iter_7_0, iter_7_1 in ipairs(var_7_0.itemList) do
			table.insert(var_7_5, GetI18NText(ChallengeRogueTeamTools.TextFormat(iter_7_1.id, iter_7_1.rare, var_7_4)))
		end

		local var_7_6 = 0

		for iter_7_2 in string.gmatch(var_7_2.desc, "%%s") do
			var_7_6 = var_7_6 + 1
		end

		for iter_7_3 = #var_7_5, var_7_6 do
			table.insert(var_7_5, "")
		end

		local var_7_7 = string.format(GetI18NText(var_7_2.desc), unpack(var_7_5))
		local var_7_8 = ChallengeRogueTeamTools.EventOptionReplaceText(var_7_7, var_7_2.attribute_id_list)

		arg_7_0.descText_.text = var_7_8
	else
		arg_7_0.descText_.text = var_7_2.lock_desc
	end
end

function var_0_0.Show(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

return var_0_0
