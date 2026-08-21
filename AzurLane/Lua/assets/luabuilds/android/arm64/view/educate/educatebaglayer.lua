local var_0_0 = class("EducateBagLayer", import(".base.EducateBaseUI"))
local var_0_1 = "FFFFFF"
local var_0_2 = "939495"

function var_0_0.getUIName(arg_1_0)
	return "EducateBagUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_0.initData(arg_3_0)
	arg_3_0.itemVOs = getProxy(EducateProxy):GetItemList()

	return
end

function var_0_0.findUI(arg_4_0)
	arg_4_0.anim = arg_4_0._tf:Find("anim_root"):GetComponent(typeof(Animation))
	arg_4_0.animEvent = arg_4_0._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	arg_4_0.animEvent:SetEndEvent(function()
		arg_4_0:emit(var_0_0.ON_CLOSE)

		return
	end)

	arg_4_0.windowTF = arg_4_0._tf:Find("anim_root/window")

	setText(arg_4_0.windowTF:Find("title/Text"), i18n("child_btn_bag"))

	arg_4_0.closeBtn = arg_4_0.windowTF:Find("close_btn")
	arg_4_0.togglesTF = arg_4_0.windowTF:Find("toggles")
	arg_4_0.itemView = arg_4_0.windowTF:Find("item_scrollview")
	arg_4_0.emptyTF = arg_4_0.windowTF:Find("empty")

	setText(arg_4_0.emptyTF:Find("Text"), i18n("child_bag_empty_tip"))

	return
end

function var_0_0.addListener(arg_6_0)
	onButton(arg_6_0, arg_6_0._tf:Find("anim_root/bg"), function()
		arg_6_0:_close()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.closeBtn, function()
		arg_6_0:_close()

		return
	end, SFX_PANEL)
	eachChild(arg_6_0.togglesTF, function(arg_9_0)
		setText(arg_9_0:Find("Text"), i18n("child_item_type" .. arg_9_0.name))
		onToggle(arg_6_0, arg_9_0, function(arg_10_0)
			if arg_10_0 then
				setImageColor(arg_9_0:Find("icon"), Color.NewHex(var_10_0))
				setTextColor(arg_9_0:Find("Text"), Color.NewHex(var_10_0))

				if arg_10_0 then
					arg_6_0.anim:Play("anim_educate_bag_change")
					arg_6_0:updateItems(tonumber(arg_9_0.name))
				end

				return
			end
		end)

		return
	end)

	return
end

function var_0_0.didEnter(arg_11_0)
	arg_11_0:OverlayPanel(arg_11_0._tf, {
		groupDelta = 1
	})
	arg_11_0:initItems()
	triggerToggle(arg_11_0.togglesTF:Find("0"), true)

	return
end

function var_0_0.initItems(arg_12_0)
	arg_12_0.itemRect = arg_12_0.itemView:GetComponent("LScrollRect")

	function arg_12_0.itemRect.onInitItem(arg_13_0)
		arg_12_0:initItem(arg_13_0)

		return
	end

	function arg_12_0.itemRect.onUpdateItem(arg_14_0, arg_14_1)
		arg_12_0:updateItem(arg_14_0, arg_14_1)

		return
	end

	function arg_12_0.itemRect.onReturnItem(arg_15_0, arg_15_1)
		arg_12_0:returnItem(arg_15_0, arg_15_1)

		return
	end

	return
end

function var_0_0.updateItems(arg_16_0, arg_16_1)
	arg_16_0.showVOs = {}
	arg_16_0.showVOs = underscore.select(arg_16_0.itemVOs, function(arg_17_0)
		return arg_17_0:IsShow() and (arg_16_1 == 0 or arg_17_0:GetType() == arg_16_1)
	end)

	table.sort(arg_16_0.showVOs, CompareFuncs({
		function(arg_18_0)
			return arg_18_0:CanUse() and 1 or 0
		end,
		function(arg_19_0)
			return -arg_19_0:GetRarity()
		end,
		function(arg_20_0)
			return -arg_20_0.count
		end,
		function(arg_21_0)
			return -arg_21_0.id
		end
	}))
	arg_16_0.itemRect:SetTotalCount(#arg_16_0.showVOs, -1)
	setActive(arg_16_0.emptyTF, #arg_16_0.showVOs <= 0)

	return
end

function var_0_0.initItem(arg_22_0, arg_22_1)
	return
end

function var_0_0.updateItem(arg_23_0, arg_23_1, arg_23_2)
	EducateHelper.UpdateDropShow(arg_23_2, (arg_23_0.showVOs[arg_23_1 + 1]:GetShowInfo()))
	onButton(arg_23_0, arg_23_2, function()
		arg_23_0:emit(var_0_0.EDUCATE_ON_ITEM, {
			drop = var_0
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.returnItem(arg_25_0, arg_25_1, arg_25_2)
	removeOnButton(arg_25_2)

	return
end

function var_0_0._close(arg_26_0)
	arg_26_0.anim:Play("anim_educate_bag_out")

	return
end

function var_0_0.onBackPressed(arg_27_0)
	arg_27_0:_close()

	return
end

function var_0_0.willExit(arg_28_0)
	arg_28_0.animEvent:SetEndEvent(nil)
	arg_28_0:UnOverlayPanel(arg_28_0._tf)

	return
end

return var_0_0
