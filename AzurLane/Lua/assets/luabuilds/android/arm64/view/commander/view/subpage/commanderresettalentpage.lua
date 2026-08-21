local var_0_0 = class("CommanderResetTalentPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "CommanderCatResetTalentUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.resetCancelBtn = arg_2_0._tf:Find("bg/frame/cancel_btn")
	arg_2_0.resetConfirmBtn = arg_2_0._tf:Find("bg/frame/confirm_btn")
	arg_2_0.resetCloseBtn = arg_2_0._tf:Find("bg/frame/close_btn")
	arg_2_0.resetGoldTxt = arg_2_0._tf:Find("bg/frame/bg/tip/texts/Text"):GetComponent(typeof(Text))
	arg_2_0.resetPointTxt = arg_2_0._tf:Find("bg/frame/bg/tip/texts1/Text"):GetComponent(typeof(Text))
	arg_2_0.resetList = UIItemList.New(arg_2_0._tf:Find("bg/frame/bg/talents/content"), arg_2_0._tf:Find("bg/frame/bg/talents/content/talent_tpl"))

	local var_2_0 = string.split(i18n("commander_choice_talent_reset"), "$1")
	local var_2_1 = string.split(var_2_0[2], "\t")
	local var_2_2 = string.split(var_2_1[2], "$2")

	setText(arg_2_0._tf:Find("bg/frame/bg/tip/texts/label"), var_2_0[1] .. " ")
	setText(arg_2_0._tf:Find("bg/frame/bg/tip/texts/label1"), " " .. var_2_1[1])
	setText(arg_2_0._tf:Find("bg/frame/bg/tip/texts1/label"), var_2_2[1] .. " ")
	setText(arg_2_0._tf:Find("bg/frame/bg/tip/texts1/label1"), " " .. var_2_2[2])

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.resetCloseBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.resetCancelBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.resetConfirmBtn, function()
		if arg_3_0.commanderVO then
			local var_7_0 = getProxy(PlayerProxy):getRawData()

			if var_7_0.gold < arg_3_0.total then
				GoShoppingMsgBox(i18n("switch_to_shop_tip_2", i18n("word_gold")), ChargeScene.TYPE_ITEM, {
					{
						59001,
						arg_3_0.total - var_7_0.gold,
						arg_3_0.total
					}
				})

				return
			end

			arg_3_0.contextData.msgBox:ExecuteAction("Show", {
				content = i18n("commander_reset_talent_tip"),
				onYes = function()
					arg_3_0:emit(CommanderCatMediator.RESET_TALENT, arg_3_0.commanderVO.id)
					arg_3_0:Hide()

					return
				end
			})
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_9_0, arg_9_1)
	var_0_0.super.Show(arg_9_0)
	arg_9_0._tf:SetAsLastSibling()

	arg_9_0.commanderVO = arg_9_1

	arg_9_0:Flush()

	return
end

function var_0_0.Flush(arg_10_0)
	local var_10_0 = arg_10_0.commanderVO:getTalentOrigins()

	arg_10_0.resetList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			arg_10_0:UpdateTalentCard(arg_11_2, var_10_0[arg_11_1 + 1])
		end

		return
	end)
	arg_10_0.resetList:align(#arg_10_0.commanderVO:getTalentOrigins())

	local var_10_1 = getProxy(PlayerProxy):getRawData()

	arg_10_0.total = arg_10_0.commanderVO:getResetTalentConsume()

	local var_10_2 = arg_10_0.resetGoldTxt

	if var_10_1.gold < arg_10_0.total then
		var_10_2.text = "<color=" .. COLOR_RED .. ">" .. arg_10_0.total .. "</color>" or arg_10_0.total
		arg_10_0.resetPointTxt.text = arg_10_0.commanderVO:getTotalPoint()
		GetComponent(arg_10_0.resetGoldTxt, typeof(Outline)).enabled = var_10_1.gold >= arg_10_0.total

		return
	end
end

function var_0_0.UpdateTalentCard(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1:Find("unlock")
	local var_12_1 = arg_12_1:Find("lock")

	if arg_12_2 then
		GetImageSpriteFromAtlasAsync("CommanderTalentIcon/" .. arg_12_2:getConfig("icon"), "", var_12_0:Find("icon"))

		local var_12_2 = var_12_0:Find("tree_btn")

		if var_12_2 then
			onButton(arg_12_0, var_12_2, function()
				arg_12_0.contextData.treePanel:ExecuteAction("Show", arg_12_2)

				return
			end, SFX_PANEL)
		end

		setText(var_12_0:Find("name_bg/Text"), arg_12_2:getConfig("name"))
		setScrollText(var_12_0:Find("desc/Text"), arg_12_2:getConfig("desc"))
	end

	setActive(var_12_0, arg_12_2)

	if var_12_1 then
		setActive(var_12_1, not arg_12_2)
	end

	return
end

function var_0_0.OnDestroy(arg_14_0)
	return
end

return var_0_0
