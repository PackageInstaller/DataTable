class = var_0_10000

local var_0_0 = "CatteryDescPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

var_0_1.CHANGE_STYLE = "CatteryDescPage:CHANGE_STYLE"
var_0_1.CHANGE_COMMANDER = "CatteryDescPage:CHANGE_COMMANDER"

function var_0_1.getUIName(arg_1_0)
	return "CatteryDescPage"
end

function var_0_1.OnCatteryUpdate(arg_2_0, arg_2_1)
	arg_2_0:Flush(arg_2_1)

	if arg_2_0.page then
		local var_2_0 = arg_2_0.page

		if var_2.GetLoaded(var_2_0) then
			local var_2_1 = arg_2_0.page

			if var_2.isShowing(var_2_1) then
				local var_2_2 = arg_2_0.page

				var_2.OnCatteryUpdate(var_2_2, arg_2_1)
			end
		end
	end

	return
end

function var_0_1.OnCatteryStyleUpdate(arg_3_0, arg_3_1)
	arg_3_0.cattery = arg_3_1

	arg_3_0:UpdateCatteryStyle()

	if arg_3_0.page then
		local var_3_0 = arg_3_0.page

		if var_2.GetLoaded(var_3_0) then
			local var_3_1 = arg_3_0.page

			if var_2.isShowing(var_3_1) then
				isa = var_2

				local var_3_2 = arg_3_0.page

				CommanderHomeSelCatteryStylePage = var_1_10004

				if var_2(var_3_2, var_1_10004) then
					local var_3_3 = arg_3_0.page

					var_2.OnCatteryStyleUpdate(var_3_3, arg_3_1)
				end
			end
		end
	end

	return
end

function var_0_1.OnLoaded(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.closeBtn = var_1.Find(var_4_0, "right/close_btn")

	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_1.Find(var_4_1, "left/bg/mask/icon")
	local var_4_3 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_4_0.styleIcon = var_4_3(var_4_2, var_3(var_1_10004))

	local var_4_4 = arg_4_0._tf

	arg_4_0.char = var_1.Find(var_4_4, "left/bg/char")

	local var_4_5 = arg_4_0._tf

	arg_4_0.commanderEmpty = var_1.Find(var_4_5, "left/bg/info/empty")
	arg_4_0.styleInfo = arg_4_0.commanderEmpty

	local var_4_6 = arg_4_0._tf

	arg_4_0.commanderExp = var_1.Find(var_4_6, "left/bg/info/commander_exp")

	local var_4_7 = arg_4_0.commanderExp
	local var_4_8 = var_1.Find(var_4_7, "level/Text")
	local var_4_9 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_4_0.commanderLevelTxt = var_4_9(var_4_8, var_3(var_1_10004))

	local var_4_10 = arg_4_0.commanderExp
	local var_4_11 = var_1.Find(var_4_10, "value_bg/Text")
	local var_4_12 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_4_0.commanderExpTxt = var_4_12(var_4_11, var_3(var_1_10004))

	local var_4_13 = arg_4_0.commanderExp

	arg_4_0.commanderExpImg = var_1.Find(var_4_13, "exp/Image")

	local var_4_14 = arg_4_0._tf

	arg_4_0.pageContainer = var_1.Find(var_4_14, "")

	local var_4_15 = arg_4_0._tf
	local var_4_16 = var_1.Find(var_4_15, "left/tags")
	local var_4_17 = var_1.GetComponent

	typeof = var_3
	ToggleGroup = var_1_10004
	arg_4_0.toggleGroup = var_4_17(var_4_16, var_3(var_1_10004))

	local var_4_18 = arg_4_0._tf

	arg_4_0.pagesTF = var_1.Find(var_4_18, "right/pages")

	local var_4_19 = {}
	local var_4_20 = arg_4_0._tf

	var_4_19[1] = var_2.Find(var_4_20, "left/tags/commander")

	local var_4_21 = arg_4_0._tf

	var_4_19[2] = var_2.Find(var_4_21, "left/tags/home")
	arg_4_0.tags = var_4_19

	local var_4_22 = {}

	CommanderHomeSelCommanderPage = var_2
	var_4_22[1] = var_2.New(arg_4_0.pagesTF, arg_4_0.event)
	CommanderHomeSelCatteryStylePage = var_2
	var_4_22[2] = var_2.New(arg_4_0.pagesTF, arg_4_0.event)
	arg_4_0.pages = var_4_22

	return
end

function var_0_1.OnInit(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.bind
	local var_5_2 = var_0_1.CHANGE_STYLE

	local function var_5_3(arg_6_0, arg_6_1)
		local var_6_0 = arg_5_0

		var_2.PreviewCatteryStyle(var_6_0, arg_6_1)

		return
	end

	SFX_PANEL = var_1_10005

	var_5_1(var_5_0, var_5_2, var_5_3, var_1_10005)
	arg_5_0:bind(var_0_1.CHANGE_COMMANDER, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_5_0

		var_2.PreviewCatteryCommader(var_7_0, arg_7_1)

		return
	end)

	onButton = var_1

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0._tf

	local function var_5_6()
		local var_8_0 = arg_5_0

		var_0.Hide(var_8_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_5_4, var_5_5, var_5_6, var_1_10005)

	onButton = var_1

	local var_5_7 = arg_5_0
	local var_5_8 = arg_5_0.closeBtn

	local function var_5_9()
		local var_9_0 = arg_5_0

		var_0.Hide(var_9_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_5_7, var_5_8, var_5_9, var_1_10005)

	ipairs = var_1

	for iter_5_0, iter_5_1 in var_1(arg_5_0.tags) do
		onToggle = var_1_10006

		local var_5_10 = arg_5_0
		local var_5_11 = iter_5_1

		local function var_5_12(arg_10_0)
			if arg_10_0 then
				local var_10_0 = arg_5_0

				var_1.SwitchPage(var_10_0, iter_5_0)
			end

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_5_10, var_5_11, var_5_12, var_1_10010)
	end

	return
end

function var_0_1.SwitchPage(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.pages[arg_11_1]

	if arg_11_0.page == var_11_0 then
		return
	end

	if arg_11_0.page then
		local var_11_1 = arg_11_0.page

		var_3.Hide(var_11_1)
	end

	var_11_0:ExecuteAction("Update", arg_11_0.home, arg_11_0.cattery)

	arg_11_0.page = var_11_0
	isa = var_3

	local var_11_2 = var_11_0

	CommanderHomeSelCatteryStylePage = var_5

	local var_11_3 = var_3(var_11_2, var_5)

	setActive = var_11_2

	var_11_2(arg_11_0.commanderEmpty, var_11_3)

	setActive = var_11_2

	var_11_2(arg_11_0.commanderExp, not var_11_3)
	arg_11_0:FlushCatteryInfo()

	return
end

function var_0_1.Update(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:Show()

	arg_12_0.home = arg_12_1
	arg_12_0.cattery = arg_12_2
	arg_12_0.page = nil
	triggerToggle = var_3

	var_3(arg_12_0.tags[1], true)

	if arg_12_2 then
		arg_12_0:Flush(arg_12_2)
	end

	return
end

function var_0_1.Show(arg_13_0)
	var_0_1.super.Show(arg_13_0)

	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.emit

	CommanderHomeLayer = var_1_10003

	var_13_1(var_13_0, var_1_10003.DESC_PAGE_OPEN)

	return
end

function var_0_1.Flush(arg_14_0, arg_14_1)
	arg_14_0.cattery = arg_14_1

	arg_14_0:FlushCatteryInfo()
	arg_14_0:UpdateCatteryStyle()

	return
end

function var_0_1.FlushCatteryInfo(arg_15_0)
	local var_15_0 = false

	isa = var_1_10002

	local var_15_1 = arg_15_0.page

	CommanderHomeSelCommanderPage = var_1_10004

	if var_1_10002(var_15_1, var_1_10004) then
		local var_15_2 = arg_15_0.cattery
		local var_15_3 = var_2.ExistCommander(var_15_2)
	end

	local var_15_4 = arg_15_0
	local var_15_5 = arg_15_0.UpdateCommander
	local var_15_6 = arg_15_0.cattery

	var_15_5(var_15_4, var_4.GetCommander(var_15_6))

	local var_15_7 = arg_15_0.home

	return
end

function var_0_1.UpdateCommander(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1 ~= nil

	arg_16_0:ReturnChar()

	local var_16_1

	if var_16_0 then
		arg_16_0:LoadChar(arg_16_1)

		var_16_1 = arg_16_0.commanderLevelTxt
		var_16_1.text = "LV." .. arg_16_1:getLevel()

		if arg_16_1:isMaxLevel() then
			var_16_1 = arg_16_0.commanderExpTxt
			var_16_1.text = "MAX"
			setFillAmount = var_16_1

			var_16_1(arg_16_0.commanderExpImg, 1)
		else
			var_16_1 = arg_16_0.commanderExpTxt
			var_16_1.text = "<color=#92FC63FF>" .. arg_16_1.exp .. "</color>/" .. arg_16_1:getNextLevelExp()
			setFillAmount = var_16_1

			var_16_1(arg_16_0.commanderExpImg, arg_16_1.exp / arg_16_1:getNextLevelExp())
		end
	end

	setActive = var_16_1

	var_16_1(arg_16_0.commanderExp, var_16_0)

	setActive = var_16_1

	var_16_1(arg_16_0.commanderEmpty, not var_16_0)

	return
end

function var_0_1.PreviewCatteryCommader(arg_17_0, arg_17_1)
	arg_17_0:UpdateCommander(arg_17_1)

	return
end

function var_0_1.UpdateCatteryStyle(arg_18_0)
	local var_18_0 = arg_18_0.cattery
	local var_18_1 = var_1._GetStyle_(var_18_0)
	local var_18_2 = var_1

	if var_1.ExistCommander(var_18_2) then
		local var_18_3 = arg_18_0.styleIcon

		GetSpriteFromAtlas = var_18_2
		var_18_3.sprite = var_18_2("CatteryStyle/" .. var_18_1:GetName(var_1:IsDirty()), "")
	else
		local var_18_4 = arg_18_0.styleIcon

		GetSpriteFromAtlas = var_18_2
		var_18_4.sprite = var_18_2("CatteryStyle/" .. var_18_1:GetName(false), "")
	end

	return
end

function var_0_1.PreviewCatteryStyle(arg_19_0, arg_19_1)
	pg = var_1_10002

	local var_19_0 = var_1_10002.commander_home_style[arg_19_1].name
	local var_19_1 = arg_19_0.styleIcon

	GetSpriteFromAtlas = var_1_10004
	var_19_1.sprite = var_1_10004("CatteryStyle/" .. var_19_0, "")

	return
end

function var_0_1.LoadChar(arg_20_0, arg_20_1)
	arg_20_0.painting = arg_20_1:getPainting()
	setCommanderPaintingPrefab = var_2

	var_2(arg_20_0.char, arg_20_0.painting, "info")

	return
end

function var_0_1.ReturnChar(arg_21_0)
	if arg_21_0.painting then
		retCommanderPaintingPrefab = var_1

		var_1(arg_21_0.char, arg_21_0.painting)

		arg_21_0.painting = nil
	end

	return
end

function var_0_1.Hide(arg_22_0)
	local var_22_0 = arg_22_0
	local var_22_1 = arg_22_0.emit

	CommanderHomeLayer = var_1_10003

	var_22_1(var_22_0, var_1_10003.DESC_PAGE_CLOSE)

	local var_22_2 = arg_22_0.toggleGroup

	var_1.SetAllTogglesOff(var_22_2)
	var_0_1.super.Hide(arg_22_0)

	pairs = var_1

	for iter_22_0, iter_22_1 in var_1(arg_22_0.pages) do
		if iter_22_1:GetLoaded() and iter_22_1:isShowing() then
			iter_22_1:Hide()
		end
	end

	return
end

function var_0_1.OnDestroy(arg_23_0)
	arg_23_0:ReturnChar()

	ipairs = var_1

	for iter_23_0, iter_23_1 in var_1(arg_23_0.pages) do
		iter_23_1:Destroy()
	end

	return
end

return var_0_1
