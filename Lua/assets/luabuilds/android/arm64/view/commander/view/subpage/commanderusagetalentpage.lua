local var_0_0 = class("CommanderUsageTalentPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "CommanderCatUsageTalentUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.usageList = UIItemList.New(arg_2_0._tf:Find("bg/frame/bg/talents/content"), arg_2_0._tf:Find("bg/frame/bg/talents/content/talent"))
	arg_2_0.usageCancelBtn = arg_2_0._tf:Find("bg/frame/cancel_btn")
	arg_2_0.usageConfirmBtn = arg_2_0._tf:Find("bg/frame/confirm_btn")
	arg_2_0.usageConfirmUpgrade = arg_2_0._tf:Find("bg/frame/confirm_btn/upgrade")
	arg_2_0.usageConfirmILearned = arg_2_0._tf:Find("bg/frame/confirm_btn/learned")
	arg_2_0.usageTalent = arg_2_0._tf:Find("bg/frame/bg/talent")
	arg_2_0.usageCostIconTF = arg_2_0._tf:Find("bg/frame/consume/Image")
	arg_2_0.usageCostTxtTF = arg_2_0._tf:Find("bg/frame/consume/Text")
	arg_2_0.usageCostTxt = arg_2_0.usageCostTxtTF:GetComponent(typeof(Text))
	arg_2_0.usageCloseBtn = arg_2_0._tf:Find("bg/frame/close_btn")
	arg_2_0.replacePage = CommanderReplaceTalentPage.New(arg_2_0._parentTf.parent, arg_2_0.event)

	setText(arg_2_0._tf:Find("bg/frame/bg/title/Text"), i18n("commander_choice_talent_1"))
	setText(arg_2_0._tf:Find("bg/frame/bg/talents/title/Text"), i18n("commander_choice_talent_2"))
	setText(arg_2_0._tf:Find("bg/frame/consume/label"), i18n("word_consume"))

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0:RegisterEvent()
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.usageCancelBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.usageCloseBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.usageConfirmBtn, function()
		if arg_3_0.talent and arg_3_0.commanderVO:fullTalentCnt() and not arg_3_0.commanderVO:hasTalent(arg_3_0.talent) then
			arg_3_0.replacePage:ExecuteAction("Show", arg_3_0.commanderVO, arg_3_0.talent)
		elseif arg_3_0.talent then
			arg_3_0:emit(CommanderCatMediator.LEARN_TALENT, arg_3_0.commanderVO.id, arg_3_0.talent.id, 0)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.RegisterEvent(arg_8_0)
	arg_8_0:bind(CommanderCatScene.MSG_FETCH_TALENT_LIST, function(arg_9_0)
		if arg_8_0.commanderVO then
			arg_8_0:Flush((getProxy(CommanderProxy):getCommanderById(arg_8_0.commanderVO.id)))
		end

		return
	end)
	arg_8_0:bind(CommanderCatScene.MSG_LEARN_TALENT, function(arg_10_0)
		if arg_8_0.commanderVO then
			local var_10_0 = getProxy(CommanderProxy):getCommanderById(arg_8_0.commanderVO.id)

			if var_10_0:getTalentPoint() <= 0 then
				arg_8_0:Hide()

				return
			end

			arg_8_0:Flush(var_10_0)
		end

		return
	end)

	return
end

function var_0_0.Show(arg_11_0, arg_11_1)
	var_0_0.super.Show(arg_11_0)
	arg_11_0._tf:SetAsLastSibling()
	arg_11_0:Flush(arg_11_1)
	arg_11_0:UpdateStyle()

	return
end

function var_0_0.Flush(arg_12_0, arg_12_1)
	arg_12_0.commanderVO = arg_12_1

	local var_12_0 = arg_12_1:getNotLearnedList()

	if not var_12_0 or #var_12_0 == 0 then
		arg_12_0:FetchList()
	else
		arg_12_0:UpdateList()
	end

	return
end

function var_0_0.UpdateStyle(arg_13_0)
	setActive(arg_13_0.usageCostIconTF, false)
	setActive(arg_13_0.usageCostTxtTF, false)

	return
end

function var_0_0.FetchList(arg_14_0)
	arg_14_0:emit(CommanderCatMediator.FETCH_NOT_LEARNED_TALENT, arg_14_0.commanderVO.id)

	return
end

function var_0_0.UpdateList(arg_15_0)
	local var_15_0 = arg_15_0.commanderVO:getNotLearnedList()

	arg_15_0.usageList:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			arg_15_0:UpdateCard(var_15_0[arg_16_1 + 1], arg_16_2)

			if arg_16_1 == 0 then
				triggerToggle(arg_16_2, true)
			end
		end

		return
	end)
	arg_15_0.usageList:align(#arg_15_0.commanderVO:getNotLearnedList())

	return
end

function var_0_0.UpdateCard(arg_17_0, arg_17_1, arg_17_2)
	setActive(arg_17_2:Find("up"), (arg_17_0.commanderVO:hasTalent(arg_17_1)))
	GetImageSpriteFromAtlasAsync("CommanderTalentIcon/" .. arg_17_1:getConfig("icon"), "", arg_17_2)
	onToggle(arg_17_0, arg_17_2, function(arg_18_0)
		if arg_18_0 and (not arg_17_0.talent or arg_17_0.talent.id ~= arg_17_1.id) then
			arg_17_0.talent = arg_17_1

			arg_17_0:UpdateTalentCard(arg_17_0.usageTalent, arg_17_1)

			local var_18_0 = arg_17_1:getConfig("cost")

			setActive(arg_17_0.usageCostIconTF, var_18_0 > 0)
			setActive(arg_17_0.usageCostTxtTF, var_18_0 > 0)

			arg_17_0.usageCostTxt.text = var_18_0

			setActive(arg_17_0.usageConfirmUpgrade, var_0:hasTalent(arg_17_1))
			setActive(arg_17_0.usageConfirmILearned, not var_0:hasTalent(arg_17_1))
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateTalentCard(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1:Find("unlock")
	local var_19_1 = arg_19_1:Find("lock")

	if arg_19_2 then
		GetImageSpriteFromAtlasAsync("CommanderTalentIcon/" .. arg_19_2:getConfig("icon"), "", var_19_0:Find("icon"))

		local var_19_2 = var_19_0:Find("tree_btn")

		if var_19_2 then
			onButton(arg_19_0, var_19_2, function()
				arg_19_0.contextData.treePanel:ExecuteAction("Show", arg_19_2)

				return
			end, SFX_PANEL)
		end

		setText(var_19_0:Find("name_bg/Text"), arg_19_2:getConfig("name"))
		setScrollText(var_19_0:Find("desc/Text"), arg_19_2:getConfig("desc"))
	end

	setActive(var_19_0, arg_19_2)

	if var_19_1 then
		setActive(var_19_1, not arg_19_2)
	end

	return
end

function var_0_0.CanBack(arg_21_0)
	if arg_21_0.replacePage and arg_21_0.replacePage:GetLoaded() and arg_21_0.replacePage:isShowing() then
		arg_21_0.replacePage:Hide()

		return false
	end

	return true
end

function var_0_0.OnDestroy(arg_22_0)
	if arg_22_0.replacePage then
		arg_22_0.replacePage:Destroy()

		arg_22_0.replacePage = nil
	end

	return
end

return var_0_0
