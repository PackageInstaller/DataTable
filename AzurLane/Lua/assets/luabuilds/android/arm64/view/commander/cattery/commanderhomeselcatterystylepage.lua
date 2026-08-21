local var_0_0 = class("CommanderHomeSelCatteryStylePage", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "CommanderHomeSelCatteryStylePage"
end

function var_0_0.OnCatteryUpdate(arg_2_0, arg_2_1)
	arg_2_0.cattery = arg_2_1

	arg_2_0:Update(arg_2_0.home, arg_2_1)

	return
end

function var_0_0.OnCatteryStyleUpdate(arg_3_0, arg_3_1)
	arg_3_0:OnCatteryUpdate(arg_3_1)

	return
end

function var_0_0.OnLoaded(arg_4_0)
	arg_4_0.scrollrect = arg_4_0._tf:Find("scrollrect"):GetComponent("LScrollRect")
	arg_4_0.okBtn = arg_4_0._tf:Find("ok_button")

	setActive(arg_4_0._tf, true)

	return
end

function var_0_0.OnInit(arg_5_0)
	arg_5_0.cards = {}

	function arg_5_0.scrollrect.onInitItem(arg_6_0)
		arg_5_0:OnInitItem(arg_6_0)

		return
	end

	function arg_5_0.scrollrect.onUpdateItem(arg_7_0, arg_7_1)
		arg_5_0:OnUpdateItem(arg_7_0, arg_7_1)

		return
	end

	onButton(arg_5_0, arg_5_0.okBtn, function()
		if arg_5_0.selectedID then
			arg_5_0:emit(CommanderHomeMediator.ON_CHANGE_STYLE, arg_5_0.cattery.id, arg_5_0.selectedID)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnInitItem(arg_9_0, arg_9_1)
	local var_9_0 = CatteryStyleCard.New(arg_9_1)

	onButton(arg_9_0, var_9_0._tf, function()
		if not var_9_0.style:IsOwn() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("cathome_style_unlock"))

			return
		end

		local var_10_0 = var_9_0.style.id

		arg_9_0.selectedID = var_9_0.style.id

		arg_9_0:emit(CatteryDescPage.CHANGE_STYLE, var_10_0)

		return
	end, SFX_PANEL)

	arg_9_0.cards[arg_9_1] = var_9_0

	return
end

function var_0_0.OnUpdateItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.cards[arg_11_2]
	local var_11_1

	if not arg_11_0.cards[arg_11_2] then
		arg_11_0:OnInitItem(arg_11_2)

		var_11_0 = arg_11_0.cards[arg_11_2]
		var_11_1 = arg_11_0.cattery:GetStyle() == arg_11_0.displays[arg_11_1 + 1].id
	end

	var_11_0:Update(arg_11_0.displays[arg_11_1 + 1], var_11_1)

	return
end

function var_0_0.Update(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:Show()

	arg_12_0.home = arg_12_1
	arg_12_0.cattery = arg_12_2
	arg_12_0.displays = {}

	local var_12_0 = arg_12_1:GetOwnStyles()

	for iter_12_0, iter_12_1 in ipairs(pg.commander_home_style.all) do
		table.insert(arg_12_0.displays, (CatteryStyle.New({
			id = iter_12_1,
			own = table.contains(var_12_0, iter_12_1)
		})))
	end

	arg_12_0.scrollrect:SetTotalCount(#arg_12_0.displays)

	return
end

function var_0_0.OnDestroy(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.cards) do
		iter_13_1:Dispose()
	end

	return
end

return var_0_0
