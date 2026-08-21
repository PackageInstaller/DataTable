local var_0_0 = class("CatteryDescPage", import("...base.BaseSubView"))

var_0_0.CHANGE_STYLE = "CatteryDescPage:CHANGE_STYLE"
var_0_0.CHANGE_COMMANDER = "CatteryDescPage:CHANGE_COMMANDER"

function var_0_0.getUIName(arg_1_0)
	return "CatteryDescPage"
end

function var_0_0.OnCatteryUpdate(arg_2_0, arg_2_1)
	arg_2_0:Flush(arg_2_1)

	if arg_2_0.page and arg_2_0.page:GetLoaded() and arg_2_0.page:isShowing() then
		arg_2_0.page:OnCatteryUpdate(arg_2_1)
	end

	return
end

function var_0_0.OnCatteryStyleUpdate(arg_3_0, arg_3_1)
	arg_3_0.cattery = arg_3_1

	arg_3_0:UpdateCatteryStyle()

	if arg_3_0.page and arg_3_0.page:GetLoaded() and arg_3_0.page:isShowing() and isa(arg_3_0.page, CommanderHomeSelCatteryStylePage) then
		arg_3_0.page:OnCatteryStyleUpdate(arg_3_1)
	end

	return
end

function var_0_0.OnLoaded(arg_4_0)
	arg_4_0.closeBtn = arg_4_0._tf:Find("right/close_btn")
	arg_4_0.styleIcon = arg_4_0._tf:Find("left/bg/mask/icon"):GetComponent(typeof(Image))
	arg_4_0.char = arg_4_0._tf:Find("left/bg/char")
	arg_4_0.commanderEmpty = arg_4_0._tf:Find("left/bg/info/empty")
	arg_4_0.styleInfo = arg_4_0.commanderEmpty
	arg_4_0.commanderExp = arg_4_0._tf:Find("left/bg/info/commander_exp")
	arg_4_0.commanderLevelTxt = arg_4_0.commanderExp:Find("level/Text"):GetComponent(typeof(Text))
	arg_4_0.commanderExpTxt = arg_4_0.commanderExp:Find("value_bg/Text"):GetComponent(typeof(Text))
	arg_4_0.commanderExpImg = arg_4_0.commanderExp:Find("exp/Image")
	arg_4_0.pageContainer = arg_4_0._tf:Find("")
	arg_4_0.toggleGroup = arg_4_0._tf:Find("left/tags"):GetComponent(typeof(ToggleGroup))
	arg_4_0.pagesTF = arg_4_0._tf:Find("right/pages")
	arg_4_0.tags = {
		arg_4_0._tf:Find("left/tags/commander"),
		arg_4_0._tf:Find("left/tags/home")
	}
	arg_4_0.pages = {
		CommanderHomeSelCommanderPage.New(arg_4_0.pagesTF, arg_4_0.event),
		CommanderHomeSelCatteryStylePage.New(arg_4_0.pagesTF, arg_4_0.event)
	}

	return
end

function var_0_0.OnInit(arg_5_0)
	arg_5_0:bind(var_0_0.CHANGE_STYLE, function(arg_6_0, arg_6_1)
		arg_5_0:PreviewCatteryStyle(arg_6_1)

		return
	end, SFX_PANEL)
	arg_5_0:bind(var_0_0.CHANGE_COMMANDER, function(arg_7_0, arg_7_1)
		arg_5_0:PreviewCatteryCommader(arg_7_1)

		return
	end)
	onButton(arg_5_0, arg_5_0._tf, function()
		arg_5_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.closeBtn, function()
		arg_5_0:Hide()

		return
	end, SFX_PANEL)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.tags) do
		onToggle(arg_5_0, iter_5_1, function(arg_10_0)
			if arg_10_0 then
				arg_5_0:SwitchPage(iter_5_0)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.SwitchPage(arg_11_0, arg_11_1)
	if arg_11_0.page == arg_11_0.pages[arg_11_1] then
		return
	end

	if arg_11_0.page then
		arg_11_0.page:Hide()
	end

	arg_11_0.pages[arg_11_1]:ExecuteAction("Update", arg_11_0.home, arg_11_0.cattery)

	arg_11_0.page = arg_11_0.pages[arg_11_1]

	local var_11_0 = isa(arg_11_0.pages[arg_11_1], CommanderHomeSelCatteryStylePage)

	setActive(arg_11_0.commanderEmpty, var_11_0)
	setActive(arg_11_0.commanderExp, not var_11_0)
	arg_11_0:FlushCatteryInfo()

	return
end

function var_0_0.Update(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:Show()

	arg_12_0.home = arg_12_1
	arg_12_0.cattery = arg_12_2
	arg_12_0.page = nil

	triggerToggle(arg_12_0.tags[1], true)

	if arg_12_2 then
		arg_12_0:Flush(arg_12_2)
	end

	return
end

function var_0_0.Show(arg_13_0)
	var_0_0.super.Show(arg_13_0)
	arg_13_0:emit(CommanderHomeLayer.DESC_PAGE_OPEN)

	return
end

function var_0_0.Flush(arg_14_0, arg_14_1)
	arg_14_0.cattery = arg_14_1

	arg_14_0:FlushCatteryInfo()
	arg_14_0:UpdateCatteryStyle()

	return
end

function var_0_0.FlushCatteryInfo(arg_15_0)
	if isa(arg_15_0.page, CommanderHomeSelCommanderPage) then
		local var_15_1 = arg_15_0.cattery:ExistCommander()
	end

	arg_15_0:UpdateCommander(arg_15_0.cattery:GetCommander())

	return
end

function var_0_0.UpdateCommander(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1 ~= nil

	arg_16_0:ReturnChar()

	if var_16_0 then
		arg_16_0:LoadChar(arg_16_1)

		arg_16_0.commanderLevelTxt.text = "LV." .. arg_16_1:getLevel()

		if arg_16_1:isMaxLevel() then
			arg_16_0.commanderExpTxt.text = "MAX"

			setFillAmount(arg_16_0.commanderExpImg, 1)
		else
			arg_16_0.commanderExpTxt.text = "<color=#92FC63FF>" .. arg_16_1.exp .. "</color>/" .. arg_16_1:getNextLevelExp()

			setFillAmount(arg_16_0.commanderExpImg, arg_16_1.exp / arg_16_1:getNextLevelExp())
		end
	end

	setActive(arg_16_0.commanderExp, var_16_0)
	setActive(arg_16_0.commanderEmpty, not var_16_0)

	return
end

function var_0_0.PreviewCatteryCommader(arg_17_0, arg_17_1)
	arg_17_0:UpdateCommander(arg_17_1)

	return
end

function var_0_0.UpdateCatteryStyle(arg_18_0)
	local var_18_0 = arg_18_0.cattery:_GetStyle_()

	arg_18_0.styleIcon.sprite = arg_18_0.cattery:ExistCommander() and GetSpriteFromAtlas("CatteryStyle/" .. var_18_0:GetName(arg_18_0.cattery:IsDirty()), "") or GetSpriteFromAtlas("CatteryStyle/" .. var_18_0:GetName(false), "")

	return
end

function var_0_0.PreviewCatteryStyle(arg_19_0, arg_19_1)
	arg_19_0.styleIcon.sprite = GetSpriteFromAtlas("CatteryStyle/" .. pg.commander_home_style[arg_19_1].name, "")

	return
end

function var_0_0.LoadChar(arg_20_0, arg_20_1)
	arg_20_0.painting = arg_20_1:getPainting()

	setCommanderPaintingPrefab(arg_20_0.char, arg_20_0.painting, "info")

	return
end

function var_0_0.ReturnChar(arg_21_0)
	if arg_21_0.painting then
		retCommanderPaintingPrefab(arg_21_0.char, arg_21_0.painting)

		arg_21_0.painting = nil
	end

	return
end

function var_0_0.Hide(arg_22_0)
	arg_22_0:emit(CommanderHomeLayer.DESC_PAGE_CLOSE)
	arg_22_0.toggleGroup:SetAllTogglesOff()
	var_0_0.super.Hide(arg_22_0)

	for iter_22_0, iter_22_1 in pairs(arg_22_0.pages) do
		if iter_22_1:GetLoaded() and iter_22_1:isShowing() then
			iter_22_1:Hide()
		end
	end

	return
end

function var_0_0.OnDestroy(arg_23_0)
	arg_23_0:ReturnChar()

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.pages) do
		iter_23_1:Destroy()
	end

	return
end

return var_0_0
