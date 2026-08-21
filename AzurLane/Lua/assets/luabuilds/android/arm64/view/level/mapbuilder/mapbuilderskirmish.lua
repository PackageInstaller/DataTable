local var_0_0 = class("MapBuilderSkirmish", import(".MapBuilderPermanent"))

function var_0_0.GetType(arg_1_0)
	return MapBuilder.TYPESKIRMISH
end

function var_0_0.getUIName(arg_2_0)
	return "skirmish_levels"
end

function var_0_0.UpdateView(arg_3_0)
	arg_3_0._tf.pivot = Vector2(0.21875, 1)
	arg_3_0._tf.anchorMin = Vector2(0.5, 1)
	arg_3_0._tf.anchorMax = Vector2(0.5, 1)
	arg_3_0._tf.anchoredPosition = Vector2((0.21875 - 0.5) * arg_3_0._parentTf.rect.width, 0)
	arg_3_0.map.pivot = Vector2(0.21875, 1)

	local var_3_0 = arg_3_0.map.rect.width / arg_3_0.map.rect.height < arg_3_0._parentTf.rect.width / arg_3_0._parentTf.rect.height and arg_3_0._parentTf.rect.width / arg_3_0._tf.rect.width or arg_3_0._parentTf.rect.height / arg_3_0._tf.rect.height

	arg_3_0._tf.localScale = Vector3(var_3_0, var_3_0, var_3_0)

	var_0_0.super.UpdateView(arg_3_0)

	return
end

local var_0_1 = Vector2(-193.5, 120.6)
local var_0_2 = Vector2(211.3, 116.5263)
local var_0_3 = Vector2(0, -622)
local var_0_4 = Vector2(-114, -372)

function var_0_0.UpdateMapItems(arg_4_0)
	var_0_0.super.UpdateMapItems(arg_4_0)

	local var_4_0 = getProxy(SkirmishProxy)

	if var_4_0:TryFetchNewTask() then
		return
	end

	local var_4_2 = arg_4_0._tf:Find("skirmish_items")
	local var_4_3 = arg_4_0._tf:Find("point_Links")
	local var_4_4 = arg_4_0._tf:Find("levelinfo")

	var_4_0:UpdateSkirmishProgress()

	local var_4_5 = var_4_0:getRawData()

	for iter_4_0 = 1, var_4_2.childCount do
		go(var_4_2:GetChild(iter_4_0 - 1)):SetActive(false)
	end

	for iter_4_1 = 1, var_4_3.childCount do
		go(var_4_3:GetChild(iter_4_1 - 1)):SetActive(false)
	end

	local var_4_6 = 0
	local var_4_7 = false
	local var_4_8 = 0
	local var_4_9 = 0

	for iter_4_2, iter_4_3 in ipairs(var_4_5) do
		local var_4_10 = iter_4_3
		local var_4_11 = var_4_2:GetChild(iter_4_2 - 1)

		if iter_4_2 - 2 >= 0 then
			go(var_4_3:GetChild(iter_4_2 - 2)):SetActive(var_4_10:GetState() > SkirmishVO.StateActive)
		end

		local var_4_12 = iter_4_3:GetState()

		setActive(var_4_11, var_4_12 > SkirmishVO.StateActive)
		setActive(var_4_11:Find("flag"), var_4_12 == SkirmishVO.StateWorking)
		setActive(var_4_11:Find("clear"), var_4_12 == SkirmishVO.StateClear)

		var_4_8 = var_4_12 > SkirmishVO.StateInactive and var_4_8 + 1 or var_4_8
		var_4_9 = var_4_12 == SkirmishVO.StateClear and var_4_9 + 1 or var_4_9

		if var_4_12 == SkirmishVO.StateWorking then
			var_4_6 = iter_4_2
		end

		if var_4_10.flagNew then
			var_4_10.flagNew = nil

			if iter_4_2 ~= 1 then
				go(var_4_11):SetActive(false)

				var_4_7 = true

				local var_4_13 = var_4_3:GetChild(iter_4_2 - 2):GetComponent(typeof(Image))

				var_4_13.fillAmount = 0

				LeanTween.value(go(var_4_11), 0, 1, 2):setOnUpdate(System.Action_float(function(arg_5_0)
					var_4_13.fillAmount = arg_5_0

					return
				end)):setOnComplete(System.Action(function()
					go(var_4_11):SetActive(true)
					go(var_4_4):SetActive(true)

					return
				end)):setDelay(0.5)
			end
		end

		local var_4_14 = var_4_10:getConfig("task_id")

		onButton(arg_4_0, var_4_11, function()
			if var_4_12 ~= SkirmishVO.StateWorking then
				return
			end

			local var_7_0 = var_4_10:GetType()
			local var_7_1 = var_4_10:GetEvent()

			if var_7_0 == SkirmishVO.TypeStoryOrExpedition then
				if tonumber(var_7_1) then
					var_7_1 = tonumber(var_7_1)

					local var_7_2 = arg_4_0.contextData

					arg_4_0:emit(LevelMediator2.ON_PERFORM_COMBAT, var_7_1, function()
						var_7_2.preparedTaskList = var_7_2.preparedTaskList or {}

						table.insert(var_7_2.preparedTaskList, var_4_14)

						return
					end)
				else
					pg.NewStoryMgr.GetInstance():Play(var_7_1, function()
						arg_4_0:emit(LevelMediator2.ON_SUBMIT_TASK, var_4_14)

						return
					end)
				end
			elseif var_7_0 == SkirmishVO.TypeChapter then
				arg_4_0:TryOpenChapterInfo((tonumber(var_7_1)))
			end

			return
		end)
	end

	if var_4_6 > 0 then
		setActive(var_4_4, not var_4_7)

		local var_4_15 = var_4_2:GetChild(var_4_6 - 1).anchoredPosition
		local var_4_16 = var_4_15

		if var_4_6 == 3 then
			local var_4_18 = var_0_2 or var_0_1

			var_4_4.anchoredPosition = var_4_17(var_4_16, var_4_18)

			setActive(var_4_4:Find("line1"), var_4_6 ~= 3)
			setActive(var_4_4:Find("line2"), var_4_6 == 3)
			setText(var_4_4:Find("info/position"), string.format("POSITION  %02d", var_4_6))
			setText(var_4_4:Find("info/name"), var_4_5[var_4_6]:getConfig("name"))
			onButton(arg_4_0, var_4_4, function()
				triggerButton(var_0)

				return
			end)

			if false then
				setActive(var_4_4, false)
			end

			local var_4_19 = var_4_1:Find("cloud")

			var_4_19.anchoredPosition = var_0_3

			LeanTween.value(go(var_4_19), var_0_3, var_0_4, 30):setOnUpdateVector2(function(arg_11_0)
				var_4_19.anchoredPosition = arg_11_0

				return
			end)

			arg_4_0.sceneParent.skirmishBar:Find("text"):GetComponent(typeof(Text)).text = var_4_8 - var_4_9

			return
		end
	end
end

function var_0_0.OnShow(arg_12_0)
	var_0_0.super.OnShow(arg_12_0)
	setActive(arg_12_0.sceneParent.topChapter:Find("type_skirmish"), true)
	setActive(arg_12_0.sceneParent.skirmishBar, true)
	setActive(arg_12_0.sceneParent.leftChapter:Find("buttons"), false)
	setActive(arg_12_0.sceneParent.rightChapter, false)

	return
end

function var_0_0.OnHide(arg_13_0)
	setActive(arg_13_0.sceneParent.topChapter:Find("type_skirmish"), false)
	setActive(arg_13_0.sceneParent.skirmishBar, false)
	setActive(arg_13_0.sceneParent.leftChapter:Find("buttons"), true)
	setActive(arg_13_0.sceneParent.rightChapter, true)

	local var_13_0 = arg_13_0._tf:Find("skirmish_items")

	for iter_13_0 = 1, var_13_0.childCount do
		LeanTween.cancel(go((var_13_0:GetChild(iter_13_0 - 1))))
	end

	LeanTween.cancel(go((arg_13_0._tf:Find("cloud"))))
	var_0_0.super.OnHide(arg_13_0)

	return
end

function var_0_0.HideFloat(arg_14_0)
	setActive(arg_14_0._tf:Find("skirmish_items"), false)

	return
end

function var_0_0.ShowFloat(arg_15_0)
	setActive(arg_15_0._tf:Find("skirmish_items"), true)

	return
end

return var_0_0
