class = var_0_10000

local var_0_0 = "MapBuilderSkirmish"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MapBuilderPermanent"))

function var_0_1.GetType(arg_1_0)
	MapBuilder = var_1_10001

	return var_1_10001.TYPESKIRMISH
end

function var_0_1.getUIName(arg_2_0)
	return "skirmish_levels"
end

function var_0_1.UpdateView(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = 0.21875

	Vector2 = var_1_10003
	var_3_0.pivot = var_1_10003(var_3_1, 1)
	Vector2 = var_3
	var_3_0.anchorMin = var_3(0.5, 1)
	Vector2 = var_3
	var_3_0.anchorMax = var_3(0.5, 1)

	local var_3_2 = (var_3_1 - 0.5) * arg_3_0._parentTf.rect.width

	Vector2 = var_4
	var_3_0.anchoredPosition = var_4(var_3_2, 0)

	local var_3_3 = arg_3_0.map

	Vector2 = var_5
	var_3_3.pivot = var_5(var_3_1, 1)

	local var_3_4 = arg_3_0.map.rect.width / arg_3_0.map.rect.height
	local var_3_5 = arg_3_0._parentTf.rect.width / arg_3_0._parentTf.rect.height
	local var_3_6

	if var_3_4 < var_3_5 then
		var_3_6 = arg_3_0._parentTf.rect.width / arg_3_0._tf.rect.width
	else
		var_3_6 = arg_3_0._parentTf.rect.height / arg_3_0._tf.rect.height
	end

	local var_3_7 = arg_3_0._tf

	Vector3 = var_1_10008
	var_3_7.localScale = var_1_10008(var_3_6, var_3_6, var_3_6)

	var_0_1.super.UpdateView(arg_3_0)

	return
end

Vector2 = var_1

local var_0_2 = var_1(-193.5, 120.6)

Vector2 = var_2

local var_0_3 = var_2(211.3, 116.5263)

Vector2 = var_3

local var_0_4 = var_3(0, -622)

Vector2 = var_4

local var_0_5 = var_4(-114, -372)

function var_0_1.UpdateMapItems(arg_4_0)
	var_0_1.super.UpdateMapItems(arg_4_0)

	getProxy = var_1
	SkirmishProxy = var_2

	local var_4_0 = var_1(var_2)

	if var_1.TryFetchNewTask(var_4_0) then
		return
	end

	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_2.Find(var_4_1, "skirmish_items")
	local var_4_3 = var_2:Find("point_Links")
	local var_4_4 = var_2:Find("levelinfo")

	var_1:UpdateSkirmishProgress()

	local var_4_5 = var_1:getRawData()

	for iter_4_0 = 1, var_4_2.childCount do
		go = var_1_10011

		local var_4_6 = var_1_10011(var_4_2:GetChild(iter_4_0 - 1))

		var_1_10011.SetActive(var_4_6, false)
	end

	for iter_4_1 = 1, var_4_3.childCount do
		go = var_1_10011

		local var_4_7 = var_1_10011(var_4_3:GetChild(iter_4_1 - 1))

		var_1_10011.SetActive(var_4_7, false)
	end

	local var_4_8 = 0
	local var_4_9 = false
	local var_4_10 = 0
	local var_4_11 = 0

	ipairs = var_1_10011

	for iter_4_2, iter_4_3 in var_1_10011(var_4_5) do
		local var_4_12 = iter_4_3
		local var_4_13 = var_4_2:GetChild(iter_4_2 - 1)

		if iter_4_2 - 2 >= 0 then
			go = var_18

			local var_4_14 = var_18(var_4_3:GetChild(iter_4_2 - 2))
			local var_4_15 = var_18.SetActive

			var_1_10021 = var_4_12

			local var_4_16 = var_4_12.GetState(var_1_10021)

			SkirmishVO = var_1_10021

			var_4_15(var_4_14, var_1_10021.StateActive < var_4_16)
		end

		local var_4_17 = iter_4_3
		local var_4_18 = iter_4_3.GetState(var_4_17)

		setActive = var_4_17

		local var_4_19 = var_4_13

		SkirmishVO = var_1_10021
		var_1_10021 = var_1_10021.StateActive < var_4_18

		var_4_17(var_4_19, var_1_10021)

		setActive = var_4_17
		var_1_10021 = var_4_13

		local var_4_20 = var_4_13.Find(var_1_10021, "flag")

		SkirmishVO = var_1_10021
		var_1_10021 = var_4_18 == var_1_10021.StateWorking

		var_4_17(var_4_20, var_1_10021)

		setActive = var_4_17
		var_1_10021 = var_4_13

		local var_4_21 = var_4_13.Find(var_1_10021, "clear")

		SkirmishVO = var_1_10021
		var_1_10021 = var_4_18 == var_1_10021.StateClear

		var_4_17(var_4_21, var_1_10021)

		SkirmishVO = var_4_17
		var_4_10 = var_4_17.StateInactive < var_4_18 and var_4_10 + 1 or var_4_10
		SkirmishVO = var_19
		var_4_11 = var_4_18 == var_19.StateClear and var_4_11 + 1 or var_4_11
		SkirmishVO = var_19

		if var_4_18 == var_19.StateWorking then
			var_4_8 = iter_4_2
		end

		if var_4_12.flagNew then
			var_4_12.flagNew = nil

			if iter_4_2 ~= 1 then
				go = var_19

				local var_4_22 = var_19(var_4_13)

				var_19.SetActive(var_4_22, false)

				var_4_9 = true

				local var_4_23 = var_4_3:GetChild(iter_4_2 - 2)
				local var_4_24 = var_19.GetComponent

				typeof = var_1_10021
				Image = var_22

				local var_4_25 = var_4_24(var_4_23, var_1_10021(var_22))

				var_4_25.fillAmount = 0
				LeanTween = var_20

				local var_4_26 = var_20.value

				go = var_1_10021
				var_1_10021 = var_4_26(var_1_10021(var_4_13), 0, 1, 2)

				local var_4_27 = var_20.setOnUpdate

				System = var_22
				var_1_10021 = var_4_27(var_1_10021, var_22.Action_float(function(arg_5_0)
					var_4_25.fillAmount = arg_5_0

					return
				end))

				local var_4_28 = var_20.setOnComplete

				System = var_22
				var_1_10021 = var_4_28(var_1_10021, var_22.Action(function()
					go = var_2_10000

					local var_6_0 = var_2_10000(var_4_13)

					var_0.SetActive(var_6_0, true)

					go = var_0

					local var_6_1 = var_0(var_4_4)

					var_0.SetActive(var_6_1, true)

					return
				end))

				var_20.setDelay(var_1_10021, 0.5)
			end
		end

		local var_4_29 = var_4_12
		local var_4_30 = var_4_12.getConfig(var_4_29, "task_id")

		onButton = var_4_29

		var_4_29(arg_4_0, var_4_13, function()
			local var_7_0 = var_4_18

			SkirmishVO = var_2_10001

			if var_7_0 ~= var_2_10001.StateWorking then
				return
			end

			local var_7_1 = var_4_12
			local var_7_2 = var_0.GetType(var_7_1)
			local var_7_3 = var_4_12
			local var_7_4 = var_1.GetEvent(var_7_3)

			SkirmishVO = var_7_3

			local var_7_5

			if var_7_2 == var_7_3.TypeStoryOrExpedition then
				tonumber = var_7_5

				if var_7_5(var_7_4) then
					tonumber = var_7_5
					var_7_4 = var_7_5(var_7_4)
					var_7_5 = arg_4_0.contextData

					local var_7_6 = arg_4_0
					local var_7_7 = var_3.emit

					LevelMediator2 = var_2_10005

					var_7_7(var_7_6, var_2_10005.ON_PERFORM_COMBAT, var_7_4, function()
						local var_8_0 = var_7_5
						local var_8_1

						if not var_7_5.preparedTaskList then
							var_8_1 = {}
						end

						var_8_0.preparedTaskList = var_8_1
						table = var_8_0

						var_8_0.insert(var_7_5.preparedTaskList, var_4_30)

						return
					end)
				else
					pg = var_7_5

					local var_7_8 = var_7_5.NewStoryMgr.GetInstance()

					var_7_5.Play(var_7_8, var_7_4, function()
						local var_9_0 = arg_4_0
						local var_9_1 = var_0.emit

						LevelMediator2 = var_3_10002

						var_9_1(var_9_0, var_3_10002.ON_SUBMIT_TASK, var_4_30)

						return
					end)
				end
			else
				SkirmishVO = var_7_5

				if var_7_2 == var_7_5.TypeChapter then
					tonumber = var_2

					local var_7_9 = var_2(var_7_4)
					local var_7_10 = arg_4_0

					var_3.TryOpenChapterInfo(var_7_10, var_7_9)
				end
			end

			return
		end)
	end

	if 0 < var_4_8 then
		setActive = var_11

		var_11(var_4_4, not var_4_9)

		local var_4_31 = var_4_2:GetChild(var_4_8 - 1).anchoredPosition
		local var_4_32 = var_12.Add
		local var_4_33

		if var_4_8 ~= 3 or not var_0_3 then
			var_4_33 = var_0_2
		end

		var_4_4.anchoredPosition = var_4_32(var_4_31, var_4_33)
		setActive = var_13

		var_13(var_4_4:Find("line1"), var_4_8 ~= 3)

		setActive = var_13

		var_13(var_4_4:Find("line2"), var_4_8 == 3)

		setText = var_13

		local var_4_34 = var_4_4
		local var_4_35 = var_4_4.Find(var_4_34, "info/position")

		string = var_4_34

		var_13(var_4_35, var_4_34.format("POSITION  %02d", var_4_8))

		setText = var_13

		local var_4_36 = var_4_4:Find("info/name")
		local var_4_37 = var_4_5[var_4_8]

		var_13(var_4_36, var_15.getConfig(var_4_37, "name"))

		onButton = var_13

		var_13(arg_4_0, var_4_4, function()
			triggerButton = var_2_10000

			var_2_10000(var_0)

			return
		end)
	else
		setActive = var_11

		var_11(var_4_4, false)
	end

	local var_4_38 = var_2:Find("cloud")

	var_4_38.anchoredPosition = var_0_4
	LeanTween = var_12

	local var_4_39 = var_12.value

	go = var_13

	local var_4_40 = var_4_39(var_13(var_4_38), var_0_4, var_0_5, 30)

	var_12.setOnUpdateVector2(var_4_40, function(arg_11_0)
		var_4_38.anchoredPosition = arg_11_0

		return
	end)

	local var_4_41 = arg_4_0.sceneParent.skirmishBar
	local var_4_42 = var_12.Find(var_4_41, "text")
	local var_4_43 = var_12.GetComponent

	typeof = var_14
	Text = var_15
	var_4_43(var_4_42, var_14(var_15)).text = var_4_10 - var_4_11

	return
end

function var_0_1.OnShow(arg_12_0)
	var_0_1.super.OnShow(arg_12_0)

	setActive = var_1

	local var_12_0 = arg_12_0.sceneParent.topChapter

	var_1(var_2.Find(var_12_0, "type_skirmish"), true)

	setActive = var_1

	var_1(arg_12_0.sceneParent.skirmishBar, true)

	setActive = var_1

	local var_12_1 = arg_12_0.sceneParent.leftChapter

	var_1(var_2.Find(var_12_1, "buttons"), false)

	setActive = var_1

	var_1(arg_12_0.sceneParent.rightChapter, false)

	return
end

function var_0_1.OnHide(arg_13_0)
	setActive = var_1_10001

	local var_13_0 = arg_13_0.sceneParent.topChapter

	var_1_10001(var_2.Find(var_13_0, "type_skirmish"), false)

	setActive = var_1_10001

	var_1_10001(arg_13_0.sceneParent.skirmishBar, false)

	setActive = var_1_10001

	local var_13_1 = arg_13_0.sceneParent.leftChapter

	var_1_10001(var_2.Find(var_13_1, "buttons"), true)

	setActive = var_1_10001

	var_1_10001(arg_13_0.sceneParent.rightChapter, true)

	local var_13_2 = arg_13_0._tf
	local var_13_3 = var_1.Find(var_13_2, "skirmish_items")

	for iter_13_0 = 1, var_13_3.childCount do
		local var_13_4 = var_13_3
		local var_13_5 = var_13_3.GetChild(var_13_4, iter_13_0 - 1)

		LeanTween = var_13_4

		local var_13_6 = var_13_4.cancel

		go = var_8

		var_13_6(var_8(var_13_5))
	end

	local var_13_7 = arg_13_0._tf
	local var_13_8 = var_2.Find(var_13_7, "cloud")

	LeanTween = var_13_7

	local var_13_9 = var_13_7.cancel

	go = var_4

	var_13_9(var_4(var_13_8))
	var_0_1.super.OnHide(arg_13_0)

	return
end

function var_0_1.HideFloat(arg_14_0)
	setActive = var_1_10001

	local var_14_0 = arg_14_0._tf

	var_1_10001(var_2.Find(var_14_0, "skirmish_items"), false)

	return
end

function var_0_1.ShowFloat(arg_15_0)
	setActive = var_1_10001

	local var_15_0 = arg_15_0._tf

	var_1_10001(var_2.Find(var_15_0, "skirmish_items"), true)

	return
end

return var_0_1
