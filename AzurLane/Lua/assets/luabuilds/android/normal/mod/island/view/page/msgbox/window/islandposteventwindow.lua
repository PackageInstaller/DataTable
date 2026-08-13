class = var_0_10000

local var_0_0 = "IslandPostEventWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseMsgboxWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandPostEventboxUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "title/Text")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.titleTxt = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "title/desc")
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.descTxt = var_2_5(var_2_4, var_3(var_1_10004))

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "title/icon_bg/icon")
	local var_2_8 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.icon = var_2_8(var_2_7, var_3(var_1_10004))

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_1.Find(var_2_9, "frame/ico")
	local var_2_11 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.bigIcon = var_2_11(var_2_10, var_3(var_1_10004))
	UIItemList = var_1

	local var_2_12 = var_1.New
	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_2.Find(var_2_13, "frame/items")
	local var_2_15 = arg_2_0._tf

	arg_2_0.itemsList = var_2_12(var_2_14, var_3.Find(var_2_15, "frame/items/tpl"))
	UIItemList = var_1

	local var_2_16 = var_1.New
	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_2.Find(var_2_17, "frame/addition")
	local var_2_19 = arg_2_0._tf

	arg_2_0.additionList = var_2_16(var_2_18, var_3.Find(var_2_19, "frame/addition/tpl"))

	local var_2_20 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_20, "frame/btns/close")

	local var_2_21 = arg_2_0._tf

	arg_2_0.openBtn = var_1.Find(var_2_21, "frame/btns/open")
	setText = var_1

	local var_2_22 = arg_2_0._tf
	local var_2_23 = var_2.Find(var_2_22, "title/event/Text")

	i18n = var_2_22

	var_1(var_2_23, var_2_22("island_post_event_label"))

	setText = var_1

	local var_2_24 = arg_2_0._tf
	local var_2_25 = var_2.Find(var_2_24, "frame/btns/close/Text")

	i18n = var_2_24

	var_1(var_2_25, var_2_24("island_post_event_close_label"))

	setText = var_1

	local var_2_26 = arg_2_0._tf
	local var_2_27 = var_2.Find(var_2_26, "frame/btns/open/Text")

	i18n = var_2_26

	var_1(var_2_27, var_2_26("island_post_event_open_label"))

	setText = var_1

	local var_2_28 = arg_2_0._tf
	local var_2_29 = var_2.Find(var_2_28, "frame/title/Text")

	i18n = var_2_28

	var_1(var_2_29, var_2_28("island_post_event_addition_label"))

	local var_2_30 = arg_2_0._tf
	local var_2_31 = var_1.GetComponent

	typeof = var_3
	Animation = var_4
	arg_2_0.animation = var_2_31(var_2_30, var_3(var_4))

	local var_2_32 = arg_2_0._tf
	local var_2_33 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_4
	arg_2_0.dftAniEvent = var_2_33(var_2_32, var_3(var_4))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		if not arg_3_0.isSwitch then
			local var_4_0 = arg_3_0

			var_0.Switch(var_4_0)

			return
		end

		triggerButton = var_0

		var_0(arg_3_0.closeBtn)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.openBtn

	local function var_3_8()
		local var_6_0 = arg_3_0.settings.onYes
		local var_6_1 = arg_3_0

		var_1.Hide(var_6_1)

		if var_6_0 then
			var_6_0()
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	return
end

function var_0_1.Switch(arg_7_0)
	if arg_7_0.isAnimating then
		return
	end

	arg_7_0.isAnimating = true

	local var_7_0 = arg_7_0.animation

	var_1.Play(var_7_0, "switch")

	return
end

function var_0_1.OnShow(arg_8_0)
	local var_8_0 = arg_8_0.dftAniEvent

	var_1.SetEndEvent(var_8_0, function()
		arg_8_0.isSwitch = true
		arg_8_0.isAnimating = false

		return
	end)

	arg_8_0.isSwitch = false
	arg_8_0.isAnimating = false

	local var_8_1 = arg_8_0.settings.rest
	local var_8_2 = var_1.GetEventInfo(var_8_1)

	pg = var_8_1
	arg_8_0.config = var_8_1.island_manage_event[var_8_2]

	arg_8_0:UpdateTitle(var_1)

	local var_8_3 = arg_8_0

	arg_8_0.UpdateMainView(var_8_3, var_1)

	if not arg_8_0.settings.isNew then
		triggerButton = var_3

		var_3(arg_8_0._tf)
	end

	if arg_8_0.settings.blur then
		var_8_3 = arg_8_0

		arg_8_0.BlurPanel(var_8_3)
	end

	if arg_8_0.settings.isNew then
		getProxy = var_3
		SettingsProxy = var_8_3

		local var_8_4 = var_3(var_8_3)

		var_3.RecordIslandRestEvet(var_8_4)
	end

	return
end

function var_0_1.BlurPanel(arg_10_0)
	local var_10_0 = arg_10_0.view.viewComponent

	var_1.BlurPanel(var_10_0, arg_10_0.view._tf)

	return
end

function var_0_1.UnBlurPanel(arg_11_0)
	local var_11_0 = arg_11_0.view.viewComponent
	local var_11_1 = var_1.UnOverlayPanel
	local var_11_2 = arg_11_0.view._tf

	pg = var_1_10004

	var_11_1(var_11_0, var_11_2, var_1_10004.UIMgr.GetInstance().OverlayMain)

	return
end

function var_0_1.UpdateTitle(arg_12_0, arg_12_1)
	arg_12_0.titleTxt.text = arg_12_0.config.name

	local var_12_0 = arg_12_0.descTxt

	string = var_3
	var_12_0.text = var_3.gsub(arg_12_0.config.desc, "$1", arg_12_1:getConfig("name"))

	local var_12_1 = "icon" .. arg_12_0.config.id

	GetSpriteFromAtlas = var_3

	local var_12_2 = var_3("ui/islandpostmsgboxui_atlas", var_12_1)

	arg_12_0.icon.sprite = var_12_2

	return
end

function var_0_1.UpdateMainView(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:WarpItemInfo(arg_13_1)
	local var_13_1 = arg_13_0.itemsList

	var_3.make(var_13_1, function(arg_14_0, arg_14_1, arg_14_2)
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventUpdate then
			local var_14_0 = var_13_0[arg_14_1 + 1]

			Drop = var_4

			local var_14_1 = var_4.New
			local var_14_2 = {
				count = 0
			}

			DROP_TYPE_ISLAND_ITEM = var_2_10006
			var_14_2.type = var_2_10006
			var_14_2.id = var_14_0.id

			local var_14_3 = var_14_1(var_14_2)

			updateCustomDrop = var_14_2

			var_14_2(arg_14_2, var_14_3)
		end

		return
	end)

	local var_13_2 = arg_13_0.itemsList

	var_3.align(var_13_2, #var_13_0)

	local var_13_3 = arg_13_0:WarpAdditionInfo()
	local var_13_4 = arg_13_0.additionList

	var_4.make(var_13_4, function(arg_15_0, arg_15_1, arg_15_2)
		UIItemList = var_2_10003

		if arg_15_0 == var_2_10003.EventUpdate then
			setText = var_3

			var_3(arg_15_2:Find("Text"), var_13_3[arg_15_1 + 1][1])

			setText = var_3

			var_3(arg_15_2:Find("value"), "+" .. var_13_3[arg_15_1 + 1][2] .. "%")
		end

		return
	end)

	local var_13_5 = arg_13_0.additionList

	var_4.align(var_13_5, #var_13_3)

	local var_13_6

	if not arg_13_1:getConfig("aera_group") then
		var_13_6 = 1
	end

	local var_13_7 = var_13_6 .. arg_13_0.config.id

	LoadSpriteAsync = var_5

	var_5("island/islandrestevent/" .. var_13_7, function(arg_16_0)
		IsNil = var_2_10001

		if var_2_10001(arg_13_0.bigIcon) then
			return
		end

		arg_13_0.bigIcon.sprite = arg_16_0

		return
	end)

	return
end

function var_0_1.WarpItemInfo(arg_17_0, arg_17_1)
	local var_17_0 = {}
	local var_17_1, var_17_2 = arg_17_1:GetEventInfo()

	getProxy = var_1_10005
	IslandProxy = var_1_10006

	local var_17_3 = var_1_10005(var_1_10006)
	local var_17_4 = var_5.GetIsland(var_17_3)
	local var_17_5 = var_5.GetInventoryAgency(var_17_4)

	ipairs = var_17_4

	for iter_17_0, iter_17_1 in var_17_4(arg_17_1:getConfig("item_id")) do
		local var_17_6

		if not var_17_5:GetItemById(iter_17_1[1]) then
			IslandItem = var_17_6
			var_17_6 = var_17_6.New({
				id = iter_17_1[1]
			})
		end

		if var_17_6 and var_17_2[var_17_6.id] then
			table = var_12

			var_12.insert(var_17_0, var_17_6)
		end
	end

	return var_17_0
end

function var_0_1.WarpAdditionInfo(arg_18_0)
	local var_18_0 = {}

	table = var_1_10002

	local var_18_1 = var_1_10002.insert
	local var_18_2 = var_18_0
	local var_18_3 = {}

	i18n = var_1_10005
	var_18_3[1] = var_1_10005("island_addition_influence")
	var_18_3[2] = arg_18_0.config.influence_bonus

	var_18_1(var_18_2, var_18_3)

	table = var_18_1

	local var_18_4 = var_18_1.insert
	local var_18_5 = var_18_0
	local var_18_6 = {}

	i18n = var_5
	var_18_6[1] = var_5("island_addition_sale")
	var_18_6[2] = arg_18_0.config.event_effect[1][1]

	var_18_4(var_18_5, var_18_6)

	return var_18_0
end

function var_0_1.OnHide(arg_19_0)
	if arg_19_0.settings.onHide then
		arg_19_0.settings.onHide()

		arg_19_0.settings.onHide = nil
	end

	if arg_19_0.dftAniEvent then
		local var_19_0 = arg_19_0.dftAniEvent

		var_1.SetEndEvent(var_19_0, nil)
	end

	if arg_19_0.settings.blur then
		arg_19_0:UnBlurPanel()
	end

	return
end

return var_0_1
