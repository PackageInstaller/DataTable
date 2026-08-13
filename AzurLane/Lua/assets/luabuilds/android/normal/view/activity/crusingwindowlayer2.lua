class = var_0_10000

local var_0_0 = "CrusingWindowLayer2"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CrusingWindowLayer"))

function var_0_1.getUIName(arg_1_0)
	return "CrusingWindowUI2"
end

function var_0_1.init(arg_2_0)
	setImageSprite = var_1_10001

	local var_2_0 = arg_2_0._tf

	var_1_10001(var_2.Find(var_2_0, "panel"), arg_2_0.windowSprite, true)

	local var_2_1 = arg_2_0._tf

	arg_2_0.rtBg = var_1.Find(var_2_1, "bg")

	local var_2_2 = arg_2_0._tf

	arg_2_0.btnGo = var_1.Find(var_2_2, "panel/btn_go")
	setText = var_1

	local var_2_3 = arg_2_0.btnGo
	local var_2_4 = var_2.Find(var_2_3, "Text")

	i18n = var_2_3

	var_1(var_2_4, var_2_3("cruise_tip_skin"))

	local var_2_5 = arg_2_0._tf

	arg_2_0.itemContent = var_1.Find(var_2_5, "panel/content")
	getProxy = var_1
	ActivityProxy = var_2_5

	local var_2_6 = var_1(var_2_5)
	local var_2_7 = var_1.getAliveActivityByType

	ActivityConst = var_3

	local var_2_8 = var_2_7(var_2_6, var_3.ACTIVITY_TYPE_PT_CRUSING)

	pg = var_2_6

	local var_2_9

	if not var_2_6.battlepass_event_pt[var_2_8.id].equip_skin then
		var_2_9 = {}
	end

	UIItemList = var_3

	local var_2_10 = var_3.New
	local var_2_11 = arg_2_0.itemContent
	local var_2_12 = arg_2_0.itemContent

	arg_2_0.itemList = var_2_10(var_2_11, var_5.GetChild(var_2_12, 0))

	local var_2_13 = arg_2_0.itemList

	var_3.make(var_2_13, function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_1 = arg_3_1 + 1
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			Drop = var_3

			local var_3_0 = var_3.Create(var_2_9[arg_3_1])

			updateDrop = var_4

			var_4(arg_3_2:Find("IconTpl"), var_3_0)

			onButton = var_4

			local var_3_1 = arg_2_0
			local var_3_2 = arg_3_2

			local function var_3_3()
				local var_4_0 = arg_2_0

				var_0.emit(var_4_0, var_0_1.ON_DROP, var_3_0)

				return
			end

			SFX_PANEL = var_2_10008

			var_4(var_3_1, var_3_2, var_3_3, var_2_10008)
		end

		return
	end)

	local var_2_14 = arg_2_0.itemList

	var_3.align(var_2_14, #var_2_9)

	return
end

function var_0_1.didEnter(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_5_0, arg_5_0._tf)

	onButton = var_1

	local var_5_1 = arg_5_0
	local var_5_2 = arg_5_0.rtBg

	local function var_5_3()
		local var_6_0 = arg_5_0

		var_0.closeView(var_6_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_5_1, var_5_2, var_5_3, var_1_10005)

	onButton = var_1

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.btnGo

	local function var_5_6()
		local var_7_0 = arg_5_0
		local var_7_1 = var_0.emit

		CrusingWindowMediator = var_2_10002

		var_7_1(var_7_0, var_2_10002.GO_CRUSING)

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_5_4, var_5_5, var_5_6, var_1_10005)

	return
end

return var_0_1
