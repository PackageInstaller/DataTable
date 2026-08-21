local var_0_0 = class("IslandShipUpgradePage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandShipUpgradeUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.expBar = arg_2_0._tf:Find("frame/frame_1/exp/bar")
	arg_2_0.expBarPre = arg_2_0._tf:Find("frame/frame_1/exp/bar_pre")
	arg_2_0.levelTxt = arg_2_0._tf:Find("frame/frame_1/exp/level"):GetComponent(typeof(Text))
	arg_2_0.expTxt = arg_2_0._tf:Find("frame/frame_1/exp/Text"):GetComponent(typeof(Text))
	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/frame_1/close")
	arg_2_0.confirmBtn = arg_2_0._tf:Find("frame/btn_confirm")
	arg_2_0.delBtn = arg_2_0._tf:Find("frame/frame_2/del")
	arg_2_0.maxBtn = arg_2_0._tf:Find("frame/frame_2/max")
	arg_2_0.switchBtn = arg_2_0._tf:Find("frame/frame_1/switch")
	arg_2_0.uiBreakList = UIItemList.New(arg_2_0._tf:Find("frame/frame_1/attr/stars"), arg_2_0._tf:Find("frame/frame_1/attr/stars/tpl"))
	arg_2_0.uiAttrList = UIItemList.New(arg_2_0._tf:Find("frame/frame_1/attr/list"), arg_2_0._tf:Find("frame/frame_1/attr/list/tpl"))
	arg_2_0.uiItemList = UIItemList.New(arg_2_0._tf:Find("frame/frame_2/items"), arg_2_0._tf:Find("frame/frame_2/items/tpl"))

	setText(arg_2_0._tf:Find("frame/frame_1/title"), i18n("island_word_ship_level_upgrade"))
	setText(arg_2_0._tf:Find("frame/frame_2/sub_title/Text"), i18n("island_skill_consume_title"))
	setText(arg_2_0._tf:Find("frame/frame_1/attr/label"), i18n("island_word_ship_level_upgrade_1"))
	setText(arg_2_0._tf:Find("frame/frame_1/attr/title/Text"), i18n("island_word_ship_rank"))
	setText(arg_2_0.confirmBtn:Find("Text"), i18n("island_chara_up_button"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		if arg_3_0:NothingSelected() then
			return
		end

		arg_3_0:emit(IslandMediator.USE_SHIP_EXP_BOOK, arg_3_0.ship.id, arg_3_0.selected)
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.delBtn, function()
		arg_3_0.selected = {}

		arg_3_0:UpdateConsume(arg_3_0.ship)
		arg_3_0:UpdateLevelPreview()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.maxBtn, function()
		arg_3_0:FillSelected(arg_3_0.ship)
		arg_3_0:UpdateLevelPreview()

		return
	end, SFX_PANEL)

	arg_3_0.isShowAttrPanel = false

	onToggle(arg_3_0, arg_3_0.switchBtn, function(arg_9_0)
		arg_3_0.isShowAttrPanel = arg_9_0

		if arg_9_0 then
			arg_3_0:UpdateAttrs(arg_3_0.ship)
			arg_3_0:UpdateBreakOutLevel(arg_3_0.ship)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnShow(arg_10_0, arg_10_1)
	arg_10_0.ship = arg_10_1
	arg_10_0.selected = {}

	arg_10_0:UpdateLevelAndExp(arg_10_1)
	arg_10_0:UpdateConsume(arg_10_1)
	arg_10_0:BlurPanel()

	return
end

function var_0_0.UpdateLevelAndExp(arg_11_0, arg_11_1, arg_11_2)
	setActive(arg_11_0.expBarPre, false)

	local var_11_0 = arg_11_1:GetExp()
	local var_11_1 = arg_11_1:GetTargetExp()
	local var_11_2 = arg_11_1:GetLevel()

	if arg_11_1:IsMaxLevel() then
		setFillAmount(arg_11_0.expBar, 1)

		arg_11_0.expTxt.text = ""
	else
		setFillAmount(arg_11_0.expBar, var_11_0 / var_11_1)

		arg_11_0.expTxt.text = "<color=#39BFFF>" .. var_11_0 .. "</color>/" .. var_11_1
	end

	arg_11_0.levelTxt.text = var_11_2

	return
end

function var_0_0.UpdateConsume(arg_12_0, arg_12_1)
	local var_12_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetShipExpBooks()

	arg_12_0.uiItemList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			local var_13_0 = var_12_0[arg_13_1 + 1]

			updateCustomDrop(arg_13_2, Drop.New({
				type = DROP_TYPE_ISLAND_ITEM,
				id = var_12_0[arg_13_1 + 1].id,
				count = var_12_0[arg_13_1 + 1].count
			}))
			setActive(arg_13_2:Find("icon_bg/count_bg"), true)
			setText(arg_13_2:Find("icon_bg/count_bg/count"), "X" .. var_12_0[arg_13_1 + 1].count)
			onButton(arg_12_0, arg_13_2, function()
				if var_13_0.count <= 0 or arg_12_0:CheckMaxLevel() then
					return
				end

				arg_12_0:OpenCalcPanel(arg_13_2, var_13_0)

				return
			end, SFX_PANEL)
			arg_12_0:UpdateCalcPanel(arg_13_2, var_12_0[arg_13_1 + 1])
		end

		return
	end)
	arg_12_0.uiItemList:align(#getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetShipExpBooks())

	return
end

function var_0_0.OpenCalcPanel(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.selected[arg_15_2.id] or 0

	arg_15_0.selected[arg_15_2.id] = math.min(arg_15_2.count, var_15_0 + 1)

	arg_15_0:UpdateCalcPanel(arg_15_1, arg_15_2)
	arg_15_0:UpdateLevelPreview()

	return
end

function var_0_0.CheckMaxLevel(arg_16_0)
	local var_16_0 = Clone(arg_16_0.ship)

	var_16_0:AddExp((arg_16_0:CalcExpAddition(arg_16_0.selected)))

	return var_16_0:IsMaxLevel()
end

function var_0_0.UpdateLevelPreview(arg_17_0)
	local var_17_0 = Clone(arg_17_0.ship)
	local var_17_1 = arg_17_0:CalcExpAddition(arg_17_0.selected)

	var_17_0:AddExp(var_17_1)
	setActive(arg_17_0.expBarPre, var_17_1 > 0)

	local var_17_2 = arg_17_0.ship:GetLevel()

	if var_17_1 > 0 then
		local var_17_3 = var_17_0:GetExp()
		local var_17_4 = var_17_0:GetTargetExp()
		local var_17_5 = var_17_0:GetLevel()

		if var_17_0:IsMaxLevel() then
			setFillAmount(arg_17_0.expBarPre, 1)

			arg_17_0.expTxt.text = ""
		else
			setFillAmount(arg_17_0.expBarPre, var_17_3 / var_17_4)

			arg_17_0.expTxt.text = "<color=#39BFFF>" .. var_17_3 .. "</color>/" .. var_17_4
		end

		if var_17_2 < var_17_5 then
			arg_17_0.levelTxt.text = var_17_5

			setFillAmount(arg_17_0.expBar, 0)
		end
	else
		arg_17_0:UpdateLevelAndExp(arg_17_0.ship)
	end

	return
end

function var_0_0.UpdateCalcPanel(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.selected[arg_18_2.id] or 0

	setText(arg_18_1:Find("calc/Text"), var_18_0)
	setActive(arg_18_1:Find("calc"), var_18_0 > 0)
	onButton(arg_18_0, arg_18_1:Find("calc/bg"), function()
		local var_19_0 = arg_18_0.selected[arg_18_2.id] or 0

		arg_18_0.selected[arg_18_2.id] = var_19_0 - 1

		arg_18_0:UpdateCalcPanel(arg_18_1, arg_18_2)
		arg_18_0:UpdateLevelPreview()

		return
	end, SFX_PANEL)
	setGray(arg_18_0.confirmBtn, arg_18_0:NothingSelected(), true)
	arg_18_0:UpdateAttrs(arg_18_0.ship)
	arg_18_0:UpdateBreakOutLevel(arg_18_0.ship)

	return
end

function var_0_0.NothingSelected(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.selected) do
		if iter_20_1 > 0 then
			return false
		end
	end

	return true
end

function var_0_0.FillSelected(arg_21_0, arg_21_1)
	arg_21_0.selected = {}

	local var_21_0 = Clone(arg_21_1)
	local var_21_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetShipExpBooks()

	table.sort(var_21_1, function(arg_22_0, arg_22_1)
		return arg_22_0:GetRarity() > arg_22_1:GetRarity()
	end)

	for iter_21_0, iter_21_1 in ipairs(var_21_1) do
		for iter_21_2 = 1, iter_21_1.count do
			local var_21_2

			if var_21_0:IsMaxLevel() then
				do break end

				var_21_2 = var_21_0
			end

			var_21_0:AddExp((tonumber(iter_21_1:GetUseArg())))

			local var_21_3 = arg_21_0.selected[iter_21_1.id] or 0

			arg_21_0.selected[iter_21_1.id] = var_21_3 + 1
		end
	end

	arg_21_0:UpdateConsume(arg_21_0.ship)

	return
end

function var_0_0.CalcExpAddition(arg_23_0, arg_23_1)
	local var_23_0 = 0
	local var_23_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	for iter_23_0, iter_23_1 in pairs(arg_23_1) do
		for iter_23_2 = 1, iter_23_1 do
			local var_23_2 = var_23_1:GetItemById(iter_23_0)

			var_23_0 = var_23_0 + tonumber(var_23_2:GetUseArg())
		end
	end

	return var_23_0
end

function var_0_0.UpdateAttrs(arg_24_0, arg_24_1)
	if not arg_24_0.isShowAttrPanel then
		return
	end

	local var_24_0 = arg_24_1:GetGrowthAtt()

	arg_24_0.uiAttrList:make(function(arg_25_0, arg_25_1, arg_25_2)
		if arg_25_0 == UIItemList.EventUpdate then
			arg_25_2:Find("grade_bg"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/IslandShipUI_atlas", IslandShipAttr.Grade2Img((arg_24_1:GetAttrGrade(IslandShipAttr.ATTRS[arg_25_1 + 1])))[2])

			setText(arg_25_2:Find("name"), IslandShipAttr.ToChinese(IslandShipAttr.ATTRS[arg_25_1 + 1]))

			local var_25_0 = var_24_0[IslandShipAttr.ATTRS[arg_25_1 + 1]] or 0

			setText(arg_25_2:Find("value"), "+" .. var_25_0)
		end

		return
	end)
	arg_24_0.uiAttrList:align(#IslandShipAttr.ATTRS)

	return
end

function var_0_0.UpdateBreakOutLevel(arg_26_0, arg_26_1)
	if not arg_26_0.isShowAttrPanel then
		return
	end

	arg_26_0.uiBreakList:make(function(arg_27_0, arg_27_1, arg_27_2)
		if arg_27_0 == UIItemList.EventUpdate then
			setActive(arg_27_2:Find("Image"), true)
		end

		return
	end)
	arg_26_0.uiBreakList:align(arg_26_1:GetBreakLevel())

	return
end

function var_0_0.OnHide(arg_28_0)
	arg_28_0:UnBlurPanel()

	arg_28_0.selected = {}

	return
end

return var_0_0
