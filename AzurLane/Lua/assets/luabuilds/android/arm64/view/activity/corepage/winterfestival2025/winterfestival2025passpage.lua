class = var_0_10000

local var_0_0 = "WinterFestival2025PassPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_1, "items")

	local var_1_2 = arg_1_0.items

	arg_1_0.item = var_1.Find(var_1_2, "item")

	local var_1_3 = arg_1_0.bg

	arg_1_0.btn = var_1.Find(var_1_3, "btn")
	UIItemList = var_1
	arg_1_0.itemList = var_1.New(arg_1_0.items, arg_1_0.item)

	local var_1_4 = arg_1_0.btn

	arg_1_0.red = var_1.Find(var_1_4, "red")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	local var_2_0 = arg_2_0.activity

	arg_2_0.config_client = var_1.getConfig(var_2_0, "config_client")[1]
	getProxy = var_1
	TaskProxy = var_2_0
	arg_2_0.taskProxy = var_1(var_2_0)
	setActive = var_1

	var_1(arg_2_0.item, false)

	onButton = var_1

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.btn

	local function var_2_3()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_3_2 = var_2_10003.OPEN_LAYER

		Context = var_2_10004

		local var_3_3 = var_2_10004.New
		local var_3_4 = {}

		WinterFestival2025Mediator = var_2_10007
		var_3_4.mediator = var_2_10007
		WinterFestival2025Scene = var_2_10007
		var_3_4.viewComponent = var_2_10007

		var_3_1(var_3_0, var_3_2, var_3_3(var_3_4))

		return
	end

	SOUND_BACK = var_1_10006

	var_1(var_2_1, var_2_2, var_2_3, var_1_10006)

	local var_2_4 = arg_2_0.bg
	local var_2_5

	var_2_5, setText = var_1.Find(var_2_4, "btn/Text"), var_1_10002
	i18n = var_2_3

	var_1_10002(var_2_5, var_2_3("winter_battlepass_proceed"))

	if arg_2_0.coreActivityUI.contextData.openPass then
		triggerButton = var_2

		var_2(arg_2_0.btn)
	end

	SetActive = var_2

	local var_2_6 = arg_2_0.red
	local var_2_7 = arg_2_0.activity

	var_2(var_2_6, #var_5.GetHei5UnreceiveAward(var_2_7) > 0)

	return
end

function var_0_1.OnUpdateFlush(arg_4_0)
	local var_4_0 = arg_4_0.itemList

	var_1.make(var_4_0, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventInit then
			local var_5_0 = arg_5_2
			local var_5_1 = arg_5_2.Find(var_5_0, "item")

			Drop = var_2_10004

			local var_5_2 = var_2_10004.Create({
				arg_4_0.config_client[arg_5_1 + 1][1],
				arg_4_0.config_client[arg_5_1 + 1][2],
				arg_4_0.config_client[arg_5_1 + 1][3]
			})

			updateDrop = var_5_0

			var_5_0(var_5_1:Find("mask"), var_5_2)

			onButton = var_5_0

			local var_5_3 = arg_4_0
			local var_5_4 = arg_5_2

			local function var_5_5()
				local var_6_0 = arg_4_0
				local var_6_1 = var_0.emit

				BaseUI = var_3_10003

				var_6_1(var_6_0, var_3_10003.ON_DROP, var_5_2)

				return
			end

			SFX_PANEL = var_10

			var_5_0(var_5_3, var_5_4, var_5_5, var_10)
		end

		return
	end)

	local var_4_1 = arg_4_0.itemList

	var_1.align(var_4_1, #arg_4_0.config_client)

	return
end

return var_0_1
