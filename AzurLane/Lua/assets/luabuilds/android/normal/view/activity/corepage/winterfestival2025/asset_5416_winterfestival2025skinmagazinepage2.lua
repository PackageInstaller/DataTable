class = var_0_10000

local var_0_0 = "WinterFestival2025SkinMagazinePage2"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CorSkinMagazineTemplatePage"))

var_0_1.EXPAND_WIDTH = 689
var_0_1.CLOSE_WIDTH = 146
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

		local var_1_6 = arg_1_0.items
		local var_1_7 = var_8.GetChild(var_1_6, iter_1_0 - 1)
		local var_1_8 = var_8.Find(var_1_7, "expand")
		local var_1_9 = arg_1_0.items
		local var_1_10 = var_9.GetChild(var_1_9, iter_1_0 - 1)
		local var_1_11 = var_9.Find(var_1_10, "expand_hx")

		setActive = var_1_10

		local var_1_12 = var_1_8

		HXSet = var_1_10012

		var_1_10(var_1_12, not var_1_10012.isHx())

		setActive = var_1_10

		local var_1_13 = var_1_11

		HXSet = var_1_10012

		var_1_10(var_1_13, var_1_10012.isHx())

		local var_1_14 = arg_1_0.items
		local var_1_15 = var_10.GetChild(var_1_14, iter_1_0 - 1)
		local var_1_16 = var_10.Find(var_1_15, "close")

		var_1_10012 = arg_1_0.items
		var_1_10012 = var_11.GetChild(var_1_10012, iter_1_0 - 1)

		local var_1_17 = var_11.Find(var_1_10012, "close_hx")

		setActive = var_1_10012
		var_1_10013 = var_1_16
		HXSet = var_1_10014

		var_1_10012(var_1_10013, not var_1_10014.isHx())

		setActive = var_1_10012
		var_1_10013 = var_1_17
		HXSet = var_1_10014

		var_1_10012(var_1_10013, var_1_10014.isHx())

		setImageAlpha = var_1_10012
		HXSet = var_1_10013
		var_1_10013 = var_1_10013.isHx() and var_1_17 or var_1_16
		var_1_10014 = iter_1_0 == arg_1_0.index and 0 or 1

		var_1_10012(var_1_10013, var_1_10014)
	end

	local var_1_18 = arg_1_0.activity
	local var_1_19 = var_1.getConfig(var_1_18, "config_client").story

	ipairs = var_1_18

	for iter_1_2, iter_1_3 in var_1_18(arg_1_0.taskList) do
		local var_1_20 = arg_1_0.taskProxy

		if var_7.getFinishTaskById(var_1_20, iter_1_3) and var_7:getTaskStatus() == 2 then
			checkExist = var_8

			if var_8(var_1_19, {
				iter_1_2
			}, {
				1
			}) then
				local var_1_21 = var_1_19[iter_1_2][1]

				pg = var_9

				local var_1_22 = var_9.NewStoryMgr.GetInstance()
				local var_1_23, var_1_24 = var_9.StoryName2StoryId(var_1_22, var_1_21)

				pg = var_11

				local var_1_25 = var_11.m02
				local var_1_26 = var_11.sendNotification

				GAME = var_1_10013

				var_1_26(var_1_25, var_1_10013.STORY_UPDATE, {
					storyId = var_1_21
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

function var_0_1.SelectItem(arg_4_0, arg_4_1)
	if arg_4_0.index == arg_4_1 then
		return
	end

	arg_4_0.index = arg_4_1
	ipairs = var_2

	local var_4_0

	if not arg_4_0.LTList then
		var_4_0 = {}
	end

	for iter_4_0, iter_4_1 in var_2(var_4_0) do
		LeanTween = var_1_10007

		var_1_10007.cancel(iter_4_1)
	end

	arg_4_0.LTList = {}

	for iter_4_2 = 1, arg_4_0.items.childCount do
		local var_4_1 = arg_4_0.items
		local var_4_2 = var_6.GetChild(var_4_1, iter_4_2 - 1)
		local var_4_3 = var_6.GetComponent

		typeof = var_1_10009
		LayoutElement = var_1_10010

		local var_4_4 = var_4_3(var_4_2, var_1_10009(var_1_10010)).preferredWidth

		if iter_4_2 ~= arg_4_1 or not arg_4_0.EXPAND_WIDTH then
			var_1_10009 = arg_4_0.CLOSE_WIDTH
		end

		if var_4_4 ~= var_1_10009 then
			math = var_1_10010
			var_1_10010 = var_1_10010.abs(var_1_10009 - var_4_4) / arg_4_0.DURATION_PARAMETER
			HXSet = var_11

			if var_11.isHx() then
				var_1_10012 = var_6

				local var_4_5

				if not var_6.Find(var_1_10012, "close_hx") then
					var_1_10012 = var_6
					var_4_5 = var_6.Find(var_1_10012, "close")
				end

				var_4_5 = var_4_5 or var_6:Find("close")
				table = var_1_10012
				var_1_10012 = var_1_10012.insert

				local var_4_6 = arg_4_0.LTList

				LeanTween = var_1_10014
				var_1_10014 = var_1_10014.value
				go = var_1_10015
				var_1_10015 = var_1_10014(var_1_10015(var_6), var_4_4, var_1_10009, var_1_10010)
				var_1_10014 = var_1_10014.setEase
				LeanTweenType = var_16
				var_1_10015 = var_1_10014(var_1_10015, var_16.easeOutSine)
				var_1_10014 = var_1_10014.setOnUpdate
				System = var_16

				var_1_10012(var_4_6, var_1_10014(var_1_10015, var_16.Action_float(function(arg_5_0)
					var_0.preferredWidth = arg_5_0

					return
				end)).uniqueId)

				table = var_1_10012
				var_1_10012 = var_1_10012.insert

				local var_4_7 = arg_4_0.LTList

				LeanTween = var_1_10014
				var_1_10015 = var_1_10014.alpha(var_4_5, iter_4_2 == arg_4_1 and 0 or 1, var_1_10010)
				var_1_10014 = var_1_10014.setEase
				LeanTweenType = var_16

				var_1_10012(var_4_7, var_1_10014(var_1_10015, var_16.easeOutSine).uniqueId)
			end
		end
	end

	arg_4_0:UpdateDrop()

	return
end

return var_0_1
