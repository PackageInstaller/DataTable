class = var_0_10000

local var_0_0 = "WinterFestival2025SkinMagazinePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CorSkinMagazineTemplatePage"))

var_0_1.EXPAND_WIDTH = 761
var_0_1.CLOSE_WIDTH = 164
var_0_1.DURATION_PARAMETER = 2500

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	ipairs = var_1

	for iter_1_0, iter_1_1 in var_1(arg_1_0.taskList) do
		local var_1_0 = arg_1_0.items
		local var_1_1 = var_6.GetChild(var_1_0, iter_1_0 - 1)
		local var_1_2 = var_6.Find(var_1_1, "got")
		local var_1_3 = arg_1_0.items
		local var_1_4 = var_7.GetChild(var_1_3, iter_1_0 - 1)
		local var_1_5 = var_7.Find(var_1_4, "got_short")

		setActive = var_1_4

		var_1_4(var_1_2, false)

		setActive = var_1_4

		var_1_4(var_1_5, false)
	end

	local var_1_6 = arg_1_0.activity
	local var_1_7 = var_1.getConfig(var_1_6, "config_client").story

	ipairs = var_1_6

	for iter_1_2, iter_1_3 in var_1_6(arg_1_0.taskList) do
		local var_1_8 = arg_1_0.taskProxy

		if var_7.getFinishTaskById(var_1_8, iter_1_3) and var_7:getTaskStatus() == 2 then
			checkExist = var_8

			if var_8(var_1_7, {
				iter_1_2
			}, {
				1
			}) then
				local var_1_9 = var_1_7[iter_1_2][1]

				pg = var_9

				local var_1_10 = var_9.NewStoryMgr.GetInstance()
				local var_1_11, var_1_12 = var_9.StoryName2StoryId(var_1_10, var_1_9)

				pg = var_11

				local var_1_13 = var_11.m02
				local var_1_14 = var_11.sendNotification

				GAME = var_1_10013

				var_1_14(var_1_13, var_1_10013.STORY_UPDATE, {
					storyId = var_1_9
				})
			end
		end
	end

	return
end

function var_0_1.OnUpdateFlush(arg_2_0)
	local var_2_0 = 0
	local var_2_1 = {}

	ipairs = var_1_10003

	for iter_2_0, iter_2_1 in var_1_10003(arg_2_0.taskList) do
		tobool = var_1_10008

		local var_2_2 = arg_2_0.taskProxy

		var_2_1[iter_2_1] = var_1_10008(var_9.getFinishTaskById(var_2_2, iter_2_1))

		if var_2_1[iter_2_1] then
			var_2_0 = var_2_0 + 1
		end

		local var_2_3 = arg_2_0.items
		local var_2_4 = var_1_10008.GetChild(var_2_3, iter_2_0 - 1)

		var_1_10008 = var_1_10008.Find(var_2_4, "got")

		local var_2_5 = arg_2_0.items
		local var_2_6 = var_9.GetChild(var_2_5, iter_2_0 - 1)
		local var_2_7 = var_9.Find(var_2_6, "got_short")
		local var_2_8 = var_1_10008
		local var_2_9 = var_1_10008.GetComponent

		typeof = var_1_10012
		DftAniEvent = var_1_10013

		local var_2_10 = var_2_9(var_2_8, var_1_10012(var_1_10013))

		var_1_10012 = var_2_7

		local var_2_11 = var_2_7.GetComponent

		typeof = var_1_10013
		DftAniEvent = var_1_10014

		local var_2_12 = var_2_11(var_1_10012, var_1_10013(var_1_10014))

		function var_1_10012()
			local var_3_0 = arg_2_0.activity
			local var_3_1 = var_0.getConfig(var_3_0, "config_client").story

			ipairs = var_3_0

			for iter_3_0, iter_3_1 in var_3_0(arg_2_0.taskList) do
				local var_3_2 = arg_2_0.taskProxy

				if var_6.getFinishTaskById(var_3_2, iter_3_1) then
					checkExist = var_3_2

					if var_3_2(var_3_1, {
						iter_3_0
					}, {
						1
					}) then
						local var_3_3 = var_3_1[iter_3_0][1]

						playStory = var_8

						var_8(var_3_3)
					end
				end
			end

			return
		end

		var_1_10014 = var_2_10

		var_2_10.SetEndEvent(var_1_10014, var_1_10012)

		var_1_10014 = var_2_12

		var_2_12.SetEndEvent(var_1_10014, var_1_10012)

		if arg_2_0.index == iter_2_0 then
			setActive = var_1_10013

			var_1_10013(var_1_10008, var_2_1[iter_2_1])

			setActive = var_1_10013

			var_1_10013(var_2_7, false)
		else
			setActive = var_1_10013

			var_1_10013(var_1_10008, false)

			setActive = var_1_10013

			var_1_10013(var_2_7, var_2_1[iter_2_1])
		end
	end

	if arg_2_0.usedCnt ~= var_2_0 then
		arg_2_0.usedCnt = var_2_0

		local var_2_13 = arg_2_0.activity

		var_2_13.data1 = arg_2_0.usedCnt
		getProxy = var_4
		ActivityProxy = var_5

		local var_2_14 = var_4(var_5)

		var_4.updateActivity(var_2_14, var_2_13)
	end

	arg_2_0:RefreshData()

	setText = var_3

	var_3(arg_2_0.countTf, arg_2_0.remainCnt)

	local var_2_15 = var_2_1[arg_2_0.taskList[arg_2_0.index]]

	setActive = var_4

	local var_2_16 = arg_2_0.awardTf

	var_4(var_5.Find(var_2_16, "got"), var_2_15)

	setActive = var_4

	local var_2_17 = arg_2_0.awardTf

	var_4(var_5.Find(var_2_17, "get"), arg_2_0.remainCnt > 0 and not var_2_15)

	return
end

return var_0_1
