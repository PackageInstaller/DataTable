local var_0_0 = class("EducateSchedulePlanCard")
local var_0_1 = {
	top = 0,
	spacing = 8,
	size = {
		x = 216,
		y = 142
	}
}
local var_0_2 = {
	top = 4,
	spacing = 14,
	size = {
		x = 216,
		y = 328
	}
}
local var_0_3 = {
	x = 0,
	y = 87
}
local var_0_4 = {
	x = 0,
	y = 110
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0._go = arg_1_1
	arg_1_0._tf = tf(arg_1_0._go)
	arg_1_0.viewComponent = arg_1_2
	arg_1_0.selectedTF = arg_1_0._tf:Find("selected")
	arg_1_0.iconBgTF = arg_1_0._tf:Find("icon_bg")
	arg_1_0.iconTF = arg_1_0.iconBgTF:Find("icon")
	arg_1_0.progressTF = arg_1_0._tf:Find("progress")
	arg_1_0.sliderTF = arg_1_0._tf:Find("slider")
	arg_1_0.nameTF = arg_1_0._tf:Find("name_mask")
	arg_1_0.nameTextTF = arg_1_0.nameTF:Find("name")
	arg_1_0.enNameTF = arg_1_0._tf:Find("name_en")
	arg_1_0.limitTF = arg_1_0._tf:Find("limit")
	arg_1_0.limitUIList = UIItemList.New(arg_1_0.limitTF, arg_1_0.limitTF:Find("tpl"))

	arg_1_0.limitUIList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			arg_1_0:updateLimitItem(arg_2_1, arg_2_2)
		end

		return
	end)

	arg_1_0.costTF = arg_1_0._tf:Find("cost")
	arg_1_0.costEmptyTF = arg_1_0._tf:Find("cost_empty")

	setText(arg_1_0.costEmptyTF:Find("Text"), i18n("child_plan_no_cost"))

	arg_1_0.costUIList = UIItemList.New(arg_1_0.costTF, arg_1_0.costTF:Find("tpl"))

	arg_1_0.costUIList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			arg_1_0:updateCostItem(arg_3_1, arg_3_2)
		end

		return
	end)

	arg_1_0.awardTF = arg_1_0._tf:Find("award")
	arg_1_0.awardUIList = UIItemList.New(arg_1_0.awardTF:Find("content"), arg_1_0.awardTF:Find("content/tpl"))

	arg_1_0.awardUIList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			arg_1_0:updateAwardItem(arg_4_1, arg_4_2)
		end

		return
	end)

	arg_1_0.foldBtn = arg_1_0.awardTF:Find("fold_btn")
	arg_1_0.unfoldBtn = arg_1_0.awardTF:Find("unfold_btn")
	arg_1_0.awardLayouCom = arg_1_0.awardTF:Find("content"):GetComponent(typeof(VerticalLayoutGroup))
	arg_1_0.char = getProxy(EducateProxy):GetCharData()

	return
end

function var_0_0.updateLimitItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.limitCfg[arg_5_1 + 1]

	LoadImageSpriteAtlasAsync("ui/educatecommonui_atlas", "attr_" .. arg_5_0.limitCfg[arg_5_1 + 1][2], findTF(arg_5_2, "icon_bg/icon"), true)
	setText(findTF(arg_5_2, "value"), var_5_0[3])
	setText(findTF(arg_5_2, "name"), pg.child_attr[arg_5_0.limitCfg[arg_5_1 + 1][2]].name)
	setTextColor(findTF(arg_5_2, "value"), Color.NewHex(var_5_0[4] and "606064" or "ed7373"))
	setTextColor(findTF(arg_5_2, "name"), Color.NewHex(var_5_1))

	return
end

function var_0_0.updateCostItem(arg_6_0, arg_6_1, arg_6_2)
	LoadImageSpriteAtlasAsync("ui/educatecommonui_atlas", "res_" .. arg_6_0.costCfg[arg_6_1 + 1].id, findTF(arg_6_2, "icon"), true)
	setText(findTF(arg_6_2, "value"), "-" .. arg_6_0.costCfg[arg_6_1 + 1].num)
	setText(findTF(arg_6_2, "name"), pg.child_resource[arg_6_0.costCfg[arg_6_1 + 1].id].name)

	return
end

function var_0_0.updateAwardItem(arg_7_0, arg_7_1, arg_7_2)
	EducateHelper.UpdateDropShowForAttr(arg_7_2, {
		type = arg_7_0.awardCfg[arg_7_1 + 1][1],
		id = arg_7_0.awardCfg[arg_7_1 + 1][2],
		number = arg_7_0.awardCfg[arg_7_1 + 1][3]
	})

	return
end

function var_0_0.update(arg_8_0, arg_8_1, arg_8_2)
	setActive(arg_8_0.selectedTF, arg_8_1.id == arg_8_2)
	GetImageSpriteFromAtlasAsync("ui/educatescheduleui_atlas", arg_8_1:GetIconBgName(), arg_8_0.iconBgTF, true)
	LoadImageSpriteAsync("educateprops/" .. arg_8_1:getConfig("icon"), arg_8_0.iconTF, true)

	local var_8_0 = arg_8_1:getConfig("pre_next")

	setActive(arg_8_0.progressTF, var_8_0 ~= 0)
	setActive(arg_8_0.sliderTF, var_8_0 ~= 0)
	setActive(arg_8_0.enNameTF, var_8_0 == 0)

	if var_8_0 ~= 0 then
		assert(pg.child_plan[var_8_0], "no exist next plan id" .. var_8_0)

		local var_8_1 = pg.child_plan[var_8_0].pre[2]
		local var_8_2 = getProxy(EducateProxy):GetPlanProxy():GetHistoryCntById(arg_8_1.id)
		local var_8_3 = var_8_2 / pg.child_plan[var_8_0].pre[2]

		setSlider(arg_8_0.sliderTF, 0, 1, var_8_2 / pg.child_plan[var_8_0].pre[2])
		setText(arg_8_0.progressTF, var_8_3 >= 1 and "MAX" or var_8_2 .. "/" .. var_8_1)
	end

	setScrollText(arg_8_0.nameTextTF, arg_8_1:getConfig("name"))

	local var_8_5 = arg_8_0.nameTF

	if var_8_0 == 0 then
		local var_8_6 = var_0_4 or var_0_3

		var_8_4(var_8_5, var_8_6)

		local var_8_7 = not arg_8_1:IsMatchAttr(arg_8_0.char)

		setActive(arg_8_0.limitTF, var_8_7)

		local var_8_8 = arg_8_1:getConfig("ability")

		arg_8_0.limitCfg = {}

		for iter_8_0 = 1, #var_8_8 do
			local var_8_9 = Clone(var_8_8[iter_8_0])

			table.insert(var_8_9, arg_8_0.char:GetAttrById(var_8_9[2]) >= var_8_9[3])
			table.insert(arg_8_0.limitCfg, var_8_9)
		end

		table.sort(arg_8_0.limitCfg, CompareFuncs({
			function(arg_9_0)
				return arg_9_0[4] and 1 or 0
			end
		}))
		arg_8_0.limitUIList:align(#arg_8_0.limitCfg)

		arg_8_0.costCfg = {}

		local var_8_10, var_8_11 = arg_8_1:GetCost()

		if var_8_10 > 0 then
			table.insert(arg_8_0.costCfg, {
				id = EducateChar.RES_MONEY_ID,
				num = var_8_10
			})
		end

		if var_8_11 > 0 then
			table.insert(arg_8_0.costCfg, {
				id = EducateChar.RES_MOOD_ID,
				num = var_8_11
			})
		end

		setActive(arg_8_0.costTF, not var_8_7)
		setActive(arg_8_0.costEmptyTF, not var_8_7 and #arg_8_0.costCfg == 0)
		arg_8_0.costUIList:align(#arg_8_0.costCfg)

		arg_8_0.awardCfg = arg_8_1:GetResult()

		arg_8_0:setAwardParam(var_0_1)
		arg_8_0.awardUIList:align(#arg_8_0.awardCfg > 2 and 2 or #arg_8_0.awardCfg)
		setActive(arg_8_0.unfoldBtn, #arg_8_0.awardCfg > 2)
		setActive(arg_8_0.foldBtn, false)
		onButton(arg_8_0, arg_8_0.unfoldBtn, function()
			arg_8_0:setAwardParam(var_0_2)
			setActive(arg_8_0.foldBtn, true)
			setActive(arg_8_0.unfoldBtn, false)
			setActive(arg_8_0.limitTF, false)
			setActive(arg_8_0.costTF, false)
			setActive(arg_8_0.costEmptyTF, false)
			arg_8_0.awardUIList:align(#arg_8_0.awardCfg)

			return
		end, SFX_PANEL)
		onButton(arg_8_0, arg_8_0.foldBtn, function()
			arg_8_0:setAwardParam(var_0_1)
			setActive(arg_8_0.foldBtn, false)
			setActive(arg_8_0.unfoldBtn, true)
			setActive(arg_8_0.limitTF, var_8_7)
			setActive(arg_8_0.costTF, not var_8_7)
			setActive(arg_8_0.costEmptyTF, not var_8_7 and #arg_8_0.costCfg == 0)
			arg_8_0.awardUIList:align(#arg_8_0.awardCfg > 2 and 2 or #arg_8_0.awardCfg)

			return
		end, SFX_PANEL)
		onButton(arg_8_0, arg_8_0._tf, function()
			arg_8_0.viewComponent:OnPlanCardClick(arg_8_1)

			return
		end, SFX_PANEL)

		return
	end
end

function var_0_0.setAwardParam(arg_13_0, arg_13_1)
	setSizeDelta(arg_13_0.awardTF, arg_13_1.size)

	arg_13_0.awardLayouCom.spacing = arg_13_1.spacing
	arg_13_0.awardLayouCom.padding.top = arg_13_1.top

	return
end

function var_0_0.dispose(arg_14_0)
	pg.DelegateInfo.Dispose(arg_14_0)

	return
end

return var_0_0
