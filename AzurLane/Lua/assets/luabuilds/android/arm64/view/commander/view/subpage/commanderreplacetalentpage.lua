local var_0_0 = class("CommanderReplaceTalentPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "CommanderCatReplaceTalentUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.replaceList = UIItemList.New(arg_2_0._tf:Find("bg/frame/bg/talents/content"), arg_2_0._tf:Find("bg/frame/bg/talents/content/talent"))
	arg_2_0.replaceTargetTF = arg_2_0._tf:Find("bg/frame/bg/talent")
	arg_2_0.replaceTalent = arg_2_0._tf:Find("bg/frame/bg/replace")
	arg_2_0.replaceCloseBtn = arg_2_0._tf:Find("bg/frame/close_btn")
	arg_2_0.replaceCancelBtn = arg_2_0._tf:Find("bg/frame/cancel_btn")
	arg_2_0.confirmBtn = arg_2_0._tf:Find("bg/frame/confirm_btn")

	setActive(arg_2_0._tf:Find("bg/frame/consume"), false)
	setText(arg_2_0._tf:Find("bg/frame/bg/title/Text"), i18n("commander_choice_talent_3"))
	setText(arg_2_0._tf:Find("bg/frame/bg/talents/title/Text"), i18n("commander_choice_talent_2"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.replaceCloseBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.replaceCancelBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_7_0, arg_7_1, arg_7_2)
	var_0_0.super.Show(arg_7_0)
	arg_7_0._tf:SetAsLastSibling()

	arg_7_0.commander = arg_7_1

	arg_7_0:UpdateTalents(arg_7_2, nil)
	arg_7_0:UpdateList(arg_7_2)

	return
end

function var_0_0.UpdateList(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.commander:getTalents()

	arg_8_0.replaceList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			local var_9_0 = var_8_0[arg_9_1 + 1]

			onButton(arg_8_0, arg_9_2, function()
				if arg_8_0.prevToggle ~= arg_9_2 then
					arg_8_0:UpdateTalents(arg_8_1, var_9_0)

					if arg_8_0.prevToggle then
						setActive(arg_8_0.prevToggle:Find("mark"), false)
					end

					arg_8_0.prevToggle = arg_9_2

					setActive(arg_9_2:Find("mark"), true)
				end

				return
			end, SFX_PANEL)
			GetImageSpriteFromAtlasAsync("CommanderTalentIcon/" .. var_8_0[arg_9_1 + 1]:getConfig("icon"), "", arg_9_2)
		end

		return
	end)
	arg_8_0.replaceList:align(#arg_8_0.commander:getTalents())

	return
end

function var_0_0.UpdateTalents(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.commander

	arg_11_0:UpdateTalentCard(arg_11_0.replaceTargetTF, arg_11_1)
	arg_11_0:UpdateTalentCard(arg_11_0.replaceTalent, arg_11_2)
	onButton(arg_11_0, arg_11_0.confirmBtn, function()
		if arg_11_2 and arg_11_1 and var_11_0 then
			if arg_11_2:getConfig("worth") > 1 then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("commander_ability_replace_warning"),
					onYes = function()
						arg_11_0:emit(CommanderCatMediator.LEARN_TALENT, var_11_0.id, arg_11_1.id, arg_11_2.id)
						arg_11_0:Hide()

						return
					end
				})
			else
				arg_11_0:emit(CommanderCatMediator.LEARN_TALENT, var_11_0.id, arg_11_1.id, arg_11_2.id)
				arg_11_0:Hide()
			end
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateTalentCard(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1:Find("unlock")
	local var_14_1 = arg_14_1:Find("lock")

	if arg_14_2 then
		GetImageSpriteFromAtlasAsync("CommanderTalentIcon/" .. arg_14_2:getConfig("icon"), "", var_14_0:Find("icon"))

		local var_14_2 = var_14_0:Find("tree_btn")

		if var_14_2 then
			onButton(arg_14_0, var_14_2, function()
				arg_14_0.contextData.treePanel:ExecuteAction("Show", arg_14_2)

				return
			end, SFX_PANEL)
		end

		setText(var_14_0:Find("name_bg/Text"), arg_14_2:getConfig("name"))
		setScrollText(var_14_0:Find("desc/Text"), arg_14_2:getConfig("desc"))
	end

	setActive(var_14_0, arg_14_2)

	if var_14_1 then
		setActive(var_14_1, not arg_14_2)
	end

	return
end

function var_0_0.Hide(arg_16_0)
	var_0_0.super.Hide(arg_16_0)

	if arg_16_0.prevToggle then
		setActive(arg_16_0.prevToggle:Find("mark"), false)

		arg_16_0.prevToggle = nil
	end

	return
end

function var_0_0.OnDestroy(arg_17_0)
	return
end

return var_0_0
