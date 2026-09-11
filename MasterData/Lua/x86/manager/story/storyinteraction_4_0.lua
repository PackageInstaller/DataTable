local StoryAction_4_0 = class("StoryAction_4_0")

function StoryAction_4_0:Ctor()
	return
end

function StoryAction_4_0:InitData(arg_2_1, arg_2_2)
	self.prefabPath = "Widget/System/Story/ActionPrefab/StoryAction_4_0_Panel"
	self.player = arg_2_1
	self.param = arg_2_2
	self.state = "start"

	local var_2_0 = Object.Instantiate(Asset.Load(self.prefabPath), arg_2_1.showGo_.transform)

	var_2_0.transform.anchoredPosition = Vector3.New(0, 0, 0)
	var_2_0.name = "photoitem"
end

function StoryAction_4_0:InitUI()
	self.player.compontList = {}
	self.player.lastPositionX = 0
	self.player.lastPositionY = 0
	self.player.actionTime = 0

	local var_3_0 = self.player.showGo_.transform:Find("photoitem").gameObject
	local var_3_1 = var_3_0.transform:Find("StoryAction_4_0/photomask/Image")
	local var_3_2 = var_3_0.transform:Find("StoryAction_4_0/photomask/photo").GetComponent(var_3_1, typeof(Image))

	var_3_1:GetComponent(typeof(CanvasGroup)).alpha = 1
	self.player.allBtn_.enabled = false

	self.player.hideBtnsController_:SetSelectedIndex(self.param and self.param.isHideBtn and 1 or 0)

	self.tweenList = {}
	var_3_2.sprite = pureGetSpriteWithoutAtlas(self.param.path)
	self.animator = var_3_0.transform:Find("StoryAction_4_0"):GetComponent(typeof(Animator))
end

function StoryAction_4_0:UpdateAction(arg_4_1)
	local var_4_0 = self.player
	local var_4_1 = self.player.showGo_.transform:Find("photoitem").gameObject
	local var_4_2 = var_4_1.transform:Find("StoryAction_4_0/photomask/Image"):GetComponent(typeof(CanvasGroup))

	if not self.player.compontList[var_4_1.name] then
		local var_4_3 = var_4_1:AddComponent(typeof(EventTriggerListener))

		SetActive(self.player.showGo_, true)

		function self.player.BeginDrag(arg_5_0, arg_5_1, arg_5_2)
			return
		end

		local var_4_4 = LeanTween.value(var_4_1, 1, 0, 1)
		local var_4_5 = self.tweenList

		self.player.speed = 0

		local var_4_6 = self.param.detectX or 10
		local var_4_7 = self.param.detectY or 5
		local var_4_8 = self.param.deltaValue or arg_4_1
		local var_4_9 = self.easeInCubic
		local var_4_10 = self.animator

		function self.player.Drag(arg_6_0, arg_6_1, arg_6_2)
			local var_6_0 = math.abs(arg_6_2.position.y - var_4_0.lastPositionY)

			if var_4_0.time_ - var_4_0.actionTime > arg_4_1 * 2 and (math.abs(arg_6_2.position.x - var_4_0.lastPositionX) > var_4_6 or var_4_7 > var_4_7) then
				var_4_0.speed = var_4_0.speed + var_4_8

				local var_6_2 = var_4_9(var_4_0.speed, 0, 1, 1 / var_4_8)

				var_4_2.alpha = var_4_2.alpha - var_4_8
				var_4_0.actionTime = var_4_0.time_
			end

			var_4_0.lastPositionX = arg_6_2.position.x
			var_4_0.lastPositionY = arg_6_2.position.y

			local var_6_3, var_6_4 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(var_4_0.showGo_.transform, arg_6_2.position, manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, nil)

			var_4_1.transform.anchoredPosition = var_6_4
		end

		function self.player:EndDrag(arg_7_1, arg_7_2)
			if var_4_1 then
				local var_7_1 = LeanTween.moveLocal(var_4_1, Vector3.New(0, 0, 0), 0.15):setEase(LeanTweenType.easeInOutQuad)

				var_7_1:setOnComplete(System.Action(function()
					LeanTween.cancel(var_4_1)
					var_7_1:setOnUpdate(nil):setOnComplete(nil)
				end))
				table.insert(var_4_5, var_4_4)
			end

			if var_4_2.alpha <= 0 then
				if self.state ~= "end" then
					AnimatorTools.PlayAnimationWithCallback(var_4_10, "StoryAction_4_0", function()
						var_4_0.allBtn_.enabled = true

						SetActive(var_4_0.showGo_, false)
						var_4_0.hideBtnsController_:SetSelectedIndex(0)
						var_4_0.playNext_(1)
						AnimatorTools.Stop()
					end)
				end

				self.state = "end"
			end
		end

		var_4_3:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(self.player, self.player.BeginDrag)))
		var_4_3:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(self.player, self.player.Drag)))
		var_4_3:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(self.player, self.player.EndDrag)))

		self.player.compontList[var_4_1.name] = var_4_3
	end
end

function StoryAction_4_0:Dispose()
	player.hideBtnsController_:SetSelectedIndex(0)
	Asset.Unload(Asset.Load(self.prefabPath))

	for iter_10_0, iter_10_1 in ipairs(self.tweenList) do
		if iter_10_1 then
			iter_10_1:setOnComplete(nil):setOnUpdate(nil):setEase(nil)
			LeanTween.cancel(iter_10_1.id)
		end
	end

	AnimatorTools.Stop()

	self.tweenList = nil
end

function StoryAction_4_0:easeInExpo(arg_11_1, arg_11_2, arg_11_3)
	return self == 0 and arg_11_1 or arg_11_2 * math.pow(2, 10 * (self / (arg_11_3 - 0.1))) + arg_11_1
end

function StoryAction_4_0:easeOutQuad(arg_12_1, arg_12_2, arg_12_3)
	self = self / arg_12_3

	return -arg_12_2 * self * (self - 2) + arg_12_1
end

function StoryAction_4_0:easeInCubic(arg_13_1, arg_13_2, arg_13_3)
	self = self / arg_13_3

	return arg_13_2 * self * self * self + arg_13_1
end

return StoryAction_4_0
