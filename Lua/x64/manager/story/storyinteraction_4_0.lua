local var_0_0 = class("StoryAction_4_0")

function var_0_0.Ctor(arg_1_0)
	return
end

function var_0_0.InitData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.prefabPath = "Widget/System/Story/ActionPrefab/StoryAction_4_0_Panel"
	arg_2_0.player = arg_2_1
	arg_2_0.param = arg_2_2
	arg_2_0.state = "start"

	local var_2_0 = Object.Instantiate(Asset.Load(arg_2_0.prefabPath), arg_2_1.showGo_.transform)

	var_2_0.transform.anchoredPosition = Vector3.New(0, 0, 0)
	var_2_0.name = "photoitem"
end

function var_0_0.InitUI(arg_3_0)
	local var_3_0 = arg_3_0.player

	var_3_0.compontList = {}
	var_3_0.lastPositionX = 0
	var_3_0.lastPositionY = 0
	var_3_0.actionTime = 0

	local var_3_1 = var_3_0.showGo_.transform:Find("photoitem").gameObject
	local var_3_2 = var_3_1.transform:Find("StoryAction_4_0/photomask/Image"):GetComponent(typeof(CanvasGroup))
	local var_3_3 = var_3_1.transform:Find("StoryAction_4_0/photomask/photo"):GetComponent(typeof(Image))
	local var_3_4 = 0
	local var_3_5 = 10

	var_3_2.alpha = 1
	var_3_0.allBtn_.enabled = false

	var_3_0.hideBtnsController_:SetSelectedIndex(arg_3_0.param and arg_3_0.param.isHideBtn and 1 or 0)

	arg_3_0.tweenList = {}
	var_3_3.sprite = pureGetSpriteWithoutAtlas(arg_3_0.param.path)
	arg_3_0.animator = var_3_1.transform:Find("StoryAction_4_0"):GetComponent(typeof(Animator))
end

function var_0_0.UpdateAction(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.player
	local var_4_1 = var_4_0.showGo_.transform:Find("photoitem").gameObject
	local var_4_2 = var_4_1.transform:Find("StoryAction_4_0/photomask/Image"):GetComponent(typeof(CanvasGroup))

	if not var_4_0.compontList[var_4_1.name] then
		local var_4_3 = var_4_1:AddComponent(typeof(EventTriggerListener))

		SetActive(var_4_0.showGo_, true)

		function var_4_0.BeginDrag(arg_5_0, arg_5_1, arg_5_2)
			local var_5_0 = arg_5_2.position
		end

		local var_4_4 = LeanTween.value(var_4_1, 1, 0, 1)
		local var_4_5 = arg_4_0.tweenList

		var_4_0.speed = 0

		local var_4_6 = arg_4_0.param.detectX or 10
		local var_4_7 = arg_4_0.param.detectY or 5
		local var_4_8 = arg_4_0.param.deltaValue or arg_4_1
		local var_4_9 = arg_4_0.easeInCubic
		local var_4_10 = arg_4_0.animator

		function var_4_0.Drag(arg_6_0, arg_6_1, arg_6_2)
			local var_6_0 = arg_6_2.position
			local var_6_1 = var_4_0.time_ - var_4_0.actionTime
			local var_6_2 = math.abs(var_6_0.x - var_4_0.lastPositionX)
			local var_6_3 = math.abs(var_6_0.y - var_4_0.lastPositionY)

			if var_6_1 > arg_4_1 * 2 and (var_6_2 > var_4_6 or var_4_7 > var_4_7) then
				local var_6_4 = 1 - var_4_2.alpha

				var_4_0.speed = var_4_0.speed + var_4_8

				local var_6_5 = var_4_9(var_4_0.speed, 0, 1, 1 / var_4_8)

				var_4_2.alpha = var_4_2.alpha - var_4_8
				var_4_0.actionTime = var_4_0.time_
			end

			var_4_0.lastPositionX = var_6_0.x
			var_4_0.lastPositionY = var_6_0.y

			local var_6_6 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
			local var_6_7, var_6_8 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(var_4_0.showGo_.transform, arg_6_2.position, var_6_6, nil)

			var_4_1.transform.anchoredPosition = var_6_8
		end

		function var_4_0.EndDrag(arg_7_0, arg_7_1, arg_7_2)
			local var_7_0 = var_4_1.transform.anchoredPosition

			if var_4_1 then
				local var_7_1 = LeanTween.moveLocal(var_4_1, Vector3.New(0, 0, 0), 0.15):setEase(LeanTweenType.easeInOutQuad)

				var_7_1:setOnComplete(System.Action(function()
					LeanTween.cancel(var_4_1)
					var_7_1:setOnUpdate(nil):setOnComplete(nil)
				end))
				table.insert(var_4_5, var_4_4)
			end

			local var_7_2 = arg_7_2.position

			if var_4_2.alpha <= 0 then
				if arg_7_0.state ~= "end" then
					AnimatorTools.PlayAnimationWithCallback(var_4_10, "StoryAction_4_0", function()
						var_4_0.allBtn_.enabled = true

						SetActive(var_4_0.showGo_, false)
						var_4_0.hideBtnsController_:SetSelectedIndex(0)
						var_4_0.playNext_(1)
						AnimatorTools.Stop()
					end)
				end

				arg_7_0.state = "end"
			end
		end

		var_4_3:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(var_4_0, var_4_0.BeginDrag)))
		var_4_3:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(var_4_0, var_4_0.Drag)))
		var_4_3:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(var_4_0, var_4_0.EndDrag)))

		var_4_0.compontList[var_4_1.name] = var_4_3
	end
end

function var_0_0.Dispose(arg_10_0)
	player.hideBtnsController_:SetSelectedIndex(0)
	Asset.Unload(Asset.Load(arg_10_0.prefabPath))

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.tweenList) do
		if iter_10_1 then
			iter_10_1:setOnComplete(nil):setOnUpdate(nil):setEase(nil)
			LeanTween.cancel(iter_10_1.id)
		end
	end

	AnimatorTools.Stop()

	arg_10_0.tweenList = nil
end

function var_0_0.easeInExpo(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	return arg_11_0 == 0 and arg_11_1 or arg_11_2 * math.pow(2, 10 * (arg_11_0 / (arg_11_3 - 0.1))) + arg_11_1
end

function var_0_0.easeOutQuad(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0 = arg_12_0 / arg_12_3

	return -arg_12_2 * arg_12_0 * (arg_12_0 - 2) + arg_12_1
end

function var_0_0.easeInCubic(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0 = arg_13_0 / arg_13_3

	return arg_13_2 * arg_13_0 * arg_13_0 * arg_13_0 + arg_13_1
end

return var_0_0
