class = var_0_10000

local var_0_0 = "AnniversarySixInvitationPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnDataSetting(arg_1_0)
	if arg_1_0.ptData then
		local var_1_0 = arg_1_0.ptData

		var_1.Update(var_1_0, arg_1_0.activity)
	else
		ActivityPtData = var_1
		arg_1_0.ptData = var_1.New(arg_1_0.activity)
	end

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.rtMarks = var_1.Find(var_2_0, "AD/progress")

	local var_2_1 = arg_2_0._tf

	arg_2_0.rtFinish = var_1.Find(var_2_1, "AD/award")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "AD/btn_list")

	onButton = var_1_10002

	local var_2_4 = arg_2_0
	local var_2_5 = var_2_3
	local var_2_6 = var_2_3.Find(var_2_5, "go")

	local function var_2_7()
		underscore = var_2_10000

		local var_3_0 = var_2_10000.detect

		getProxy = var_2_10002
		ActivityProxy = var_2_10004

		local var_3_1 = var_2_10002(var_2_10004)
		local var_3_2 = var_2.getActivitiesByType

		ActivityConst = var_2_10005

		if var_3_0(var_3_2(var_3_1, var_2_10005.ACTIVITY_TYPE_SHOP), function(arg_4_0)
			return arg_4_0:getConfig("config_id") == 3
		end) then
			local var_3_3 = var_0

			if var_0.isEnd(var_3_3) then
				pg = var_2_10001
				var_3_3 = var_2_10001.TipsMgr.GetInstance()
				var_2_10001 = var_2_10001.ShowTips
				i18n = var_3_1

				var_2_10001(var_3_3, var_3_1("challenge_end_tip"))

				return
			end

			getProxy = var_2_10001
			ActivityProxy = var_3_3

			local var_3_4 = var_2_10001(var_3_3)
			local var_3_5 = var_1.getActivityByType

			ActivityConst = var_3_1

			local var_3_8

			if var_3_5(var_3_4, var_3_1.ACTIVITY_TYPE_ISLAND) and not var_1:isEnd() then
				local var_3_6 = arg_2_0
				local var_3_7 = var_2.emit

				ActivityMediator = var_3_8
				var_3_8 = var_3_8.EVENT_GO_SCENE
				SCENE = var_2_10006
				var_2_10006 = var_2_10006.ANNIVERSARY_ISLAND_SEA

				local var_3_9 = {}

				SixthAnniversaryIslandScene = var_2_10008
				var_3_9.wraps = var_2_10008.SHOP

				var_3_7(var_3_6, var_3_8, var_2_10006, var_3_9)
			else
				local var_3_10 = arg_2_0
				local var_3_11 = var_2.emit

				ActivityMediator = var_3_8

				local var_3_12 = var_3_8.OPEN_LAYER

				Context = var_2_10006

				local var_3_13 = var_2_10006.New
				local var_3_14 = {}

				SixthAnniversaryIslandShopMediator = var_2_10009
				var_3_14.mediator = var_2_10009
				SixthAnniversaryIslandShopLayer = var_2_10009
				var_3_14.viewComponent = var_2_10009

				var_3_11(var_3_10, var_3_12, var_3_13(var_3_14))
			end

			return
		end
	end

	SFX_PANEL = var_2_5

	var_1_10002(var_2_4, var_2_6, var_2_7, var_2_5)

	onButton = var_1_10002

	local var_2_8 = arg_2_0
	local var_2_9 = var_2_3
	local var_2_10 = var_2_3.Find(var_2_9, "get")

	local function var_2_11()
		local var_5_0 = arg_2_0.ptData
		local var_5_1, var_5_2 = var_0.GetResProgress(var_5_0)
		local var_5_3 = arg_2_0
		local var_5_4 = var_2.emit

		ActivityMediator = var_2_10005

		local var_5_5 = var_2_10005.EVENT_PT_OPERATION
		local var_5_6 = {
			cmd = 1
		}
		local var_5_7 = arg_2_0.ptData

		var_5_6.activity_id = var_7.GetId(var_5_7)
		var_5_6.arg1 = var_5_2

		var_5_4(var_5_3, var_5_5, var_5_6)

		return
	end

	SFX_PANEL = var_2_9

	var_1_10002(var_2_8, var_2_10, var_2_11, var_2_9)

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	local var_6_0 = arg_6_0.ptData
	local var_6_1, var_6_2 = var_1.GetResProgress(var_6_0)
	local var_6_3 = arg_6_0.ptData
	local var_6_4 = var_3.CanGetAward(var_6_3)
	local var_6_5 = arg_6_0.ptData
	local var_6_6 = var_4.CanGetNextAward(var_6_5)
	local var_6_7 = arg_6_0._tf
	local var_6_8 = var_5.Find(var_6_7, "AD/btn_list")

	setActive = var_6_5

	var_6_5(var_6_8:Find("get"), var_6_4)

	setActive = var_6_5

	var_6_5(var_6_8:Find("got"), not var_6_6)

	setActive = var_6_5

	var_6_5(var_6_8:Find("go"), not var_6_4 and var_6_6)

	if var_6_6 then
		math = var_6_5
		var_6_1 = var_6_5.min(var_6_1, var_6_2)
	else
		var_6_1 = var_6_2 + 1
	end

	local var_6_9 = arg_6_0.rtMarks.childCount

	for iter_6_0 = 1, var_6_9 do
		local var_6_10 = arg_6_0.rtMarks
		local var_6_11 = var_11.GetChild(var_6_10, iter_6_0 - 1)

		setActive = var_1_10012

		var_1_10012(var_6_11:Find("mark"), iter_6_0 < var_6_1)

		setActive = var_1_10012

		var_1_10012(var_6_11:Find("icon"), iter_6_0 == var_6_1)
	end

	setGray = var_7

	local var_6_12 = arg_6_0.rtFinish

	var_7(var_9.Find(var_6_12, "Image"), not var_6_6)

	setActive = var_7

	local var_6_13 = arg_6_0.rtFinish

	var_7(var_9.Find(var_6_13, "got"), not var_6_6)

	return
end

return var_0_1
