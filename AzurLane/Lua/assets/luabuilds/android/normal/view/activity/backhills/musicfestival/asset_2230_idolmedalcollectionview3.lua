class = var_0_10000

local var_0_0 = "IdolMedalCollectionView3"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IdolMedalCollectionView2"))

function var_0_1.GetContainerPositions(arg_1_0)
	return {
		0,
		100
	}
end

function var_0_1.GetActivityID(arg_2_0)
	ActivityConst = var_1_10001

	return var_1_10001.MUSIC_FESTIVAL_MEDALCOLLECTION_3
end

function var_0_1.getUIName(arg_3_0)
	return "IdolMedalCollectionUI3"
end

function var_0_1.didEnter(arg_4_0)
	math = var_1_10001

	local var_4_0 = var_1_10001.random()

	setActive = var_1_10002

	local var_4_1 = arg_4_0.bg

	var_1_10002(var_3.Find(var_4_1, "1"), var_4_0 >= 0.5)

	setActive = var_1_10002

	local var_4_2 = arg_4_0.bg

	var_1_10002(var_3.Find(var_4_2, "2"), var_4_0 < 0.5)
	var_0_1.super.didEnter(arg_4_0)

	onButton = var_2

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.helpBtn

	local function var_4_5()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_5_2.type = var_2_10003
		pg = var_2_10003
		var_5_2.helps = var_2_10003.gametip.idol3rd_collection.tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_4_3, var_4_4, var_4_5, var_1_10006)

	return
end

function var_0_1.IsShowMainTip(arg_6_0)
	Activity = var_1_10001

	return var_1_10001.IsActivityReady(arg_6_0)
end

return var_0_1
