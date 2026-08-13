class = var_0_10000

local var_0_0 = "RyzaAtelierCompositeRePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	onButton = var_1_10001

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0._tf

	var_1_10001(var_1_0, var_4.Find(var_1_1, "adapt/helpBtn"), function()
		pg = var_2_10000

		local var_2_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_2_1 = var_0.ShowMsgBox
		local var_2_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_2_2.type = var_2_10004
		i18n = var_2_10004
		var_2_2.helps = var_2_10004("ryza_composite_help_tip")

		var_2_1(var_2_0, var_2_2)

		return
	end)

	onButton = var_1_10001

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0._tf

	var_1_10001(var_1_2, var_4.Find(var_1_3, "adapt/storeBtn"), function()
		getProxy = var_2_10000
		ContextProxy = var_2_10002

		local var_3_0 = var_2_10000(var_2_10002)
		local var_3_1 = var_0.getCurrentContext(var_3_0)
		local var_3_2 = var_0.getContextByMediator

		CoreActivityMainMediator = var_2_10004

		local var_3_3 = var_3_2(var_3_1, var_2_10004)

		addSubLayer = var_3_0
		Context = var_2_10004

		local var_3_4 = var_2_10004.New
		local var_3_5 = {}

		AtelierStoreBaseMediator = var_2_10007
		var_3_5.mediator = var_2_10007
		AtelierStoreBaseScene = var_2_10007
		var_3_5.viewComponent = var_2_10007

		local var_3_6 = {}

		getProxy = var_2_10008
		ActivityProxy = var_2_10010

		local var_3_7 = var_2_10008(var_2_10010)
		local var_3_8 = var_8.getActivityByType

		ActivityConst = var_2_10011
		var_3_6.activity = var_3_8(var_3_7, var_2_10011.ACTIVITY_TYPE_ATELIER_LINK)
		var_3_5.data = var_3_6

		var_3_0(var_3_4(var_3_5), var_3_3)

		return
	end)

	onButton = var_1_10001

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0._tf

	var_1_10001(var_1_4, var_4.Find(var_1_5, "adapt/atelierBtn"), function()
		local var_4_0 = arg_1_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_4_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_4_1(var_4_0, var_4_2, var_2_10004.ATELIER_COMPOSITE, {
			activityID = 50043,
			versionIndex = 1
		})

		return
	end)

	return
end

return var_0_1
