class = var_0_10000

local var_0_0 = "PSSHei5Page"

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

		PSSHei5Mediator = var_2_10007
		var_3_4.mediator = var_2_10007
		PSSHei5Scene = var_2_10007
		var_3_4.viewComponent = var_2_10007

		var_3_1(var_3_0, var_3_2, var_3_3(var_3_4))

		return
	end

	SOUND_BACK = var_1_10006

	var_1(var_2_1, var_2_2, var_2_3, var_1_10006)

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

			var_5_0(var_5_1, var_5_2)

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

			SFX_PANEL = var_2_10010

			var_5_0(var_5_3, var_5_4, var_5_5, var_2_10010)
		end

		return
	end)

	local var_4_1 = arg_4_0.itemList

	var_1.align(var_4_1, #arg_4_0.config_client)

	return
end

return var_0_1
