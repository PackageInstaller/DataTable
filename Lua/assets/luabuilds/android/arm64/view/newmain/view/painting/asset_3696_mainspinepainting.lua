local MainSpinePainting = class("MainSpinePainting", import(".MainBasePainting"))

function MainSpinePainting:Ctor(arg_1_1, arg_1_2, arg_1_3)
	MainSpinePainting.super.Ctor(self, arg_1_1, arg_1_2)

	self.bgTr = arg_1_3
	self.spTF = findTF(arg_1_1, "spinePainting")
	self.spBg = findTF(arg_1_3, "spinePainting")
	self.uiCam = GameObject.Find("UICamera"):GetComponent("Camera")
	self._initCallback = {}

	return
end

function MainSpinePainting:GetCenterPos()
	return self.spTF.position
end

function MainSpinePainting:OnLoad(arg_3_1)
	self:ClearScalePart()

	self.spinePainting = SpinePainting.New(SpinePainting.GenerateData({
		ship = self.ship,
		position = Vector3(0, 0, 0),
		parent = self.spTF,
		effectParent = self.spBg
	}), function(arg_4_0)
		self:AdJustOrderInLayer(arg_4_0)
		self:InitSpecialTouch()
		arg_3_1()

		for iter_4_0, iter_4_1 in ipairs(self._initCallback) do
			iter_4_1()
		end

		self._initCallback = {}

		if getProxy(PlayerProxy):getFlag("login") then
			getProxy(PlayerProxy):setFlag("login", nil)
			self:TriggerEvent("event_login")
		end

		self:InitScalePart()

		return
	end)

	self.spinePainting:setEventTriggerCallback(function(arg_5_0)
		self:onSpinePaintingEvent(arg_5_0)

		return
	end)

	return
end

function MainSpinePainting:AdJustOrderInLayer(arg_6_1)
	local var_6_0 = 0
	local var_6_1 = self.container:GetComponent(typeof(Canvas))

	if var_6_1 and var_6_1.overrideSorting and var_6_1.sortingOrder ~= 0 then
		for iter_6_0, iter_6_1 in ipairs((self.spTF:GetComponentsInChildren(typeof(Canvas)):ToTable())) do
			iter_6_1.overrideSorting = true
			var_6_0 = iter_6_1.sortingOrder - var_6_1.sortingOrder
			iter_6_1.sortingOrder = var_6_1.sortingOrder
		end
	end

	local var_6_2 = self.bgTr:GetComponent(typeof(Canvas))

	if var_6_2 and var_6_2.overrideSorting and var_6_2.sortingOrder ~= 0 then
		for iter_6_2, iter_6_3 in ipairs((self.spBg:GetComponentsInChildren(typeof(Canvas)):ToTable())) do
			iter_6_3.overrideSorting = true
			iter_6_3.sortingOrder = iter_6_3.sortingOrder - var_6_0
		end

		for iter_6_4, iter_6_5 in ipairs((self.spBg:GetComponentsInChildren(typeof("UnityEngine.ParticleSystemRenderer")):ToTable())) do
			iter_6_5.sortingOrder = iter_6_5.sortingOrder - var_6_0
		end
	end

	return
end

function MainSpinePainting:InitSpecialTouch()
	local var_7_0 = self.ship:getPainting()

	self.specialClickDic = {}

	local var_7_1 = findTF(self.spTF:GetChild(0), "hitArea")

	if not var_7_1 then
		return
	end

	eachChild(var_7_1, function(arg_8_0)
		if self:getDragTouchAble(arg_8_0.name, var_7_0) then
			self.dragEvent = GetOrAddComponent(arg_8_0, typeof(EventTriggerListener))

			self.dragEvent:AddPointDownFunc(function(arg_9_0, arg_9_1)
				self.dragActive = true
				self.dragStart = arg_9_1.position

				return
			end)
			self.dragEvent:AddPointUpFunc(function(arg_10_0, arg_10_1)
				if self.dragActive then
					self.dragActive = false
					self.dragOffset = Vector2(self.dragStart.x - arg_10_1.position.x, self.dragStart.y - arg_10_1.position.y)

					if math.abs(self.dragOffset.x) < 200 or math.abs(self.dragOffset.y) < 200 then
						self.dragUp = arg_10_1.position

						if self.spinePainting:isInAction() then
							return
						end

						if not ((self:getDragTouchAble(arg_8_0.name, var_7_0) or nil) and self.spinePainting:readyDragAction(arg_8_0.name, false)) then
							local var_10_1 = self.uiCam:ScreenToWorldPoint(arg_10_1.position)

							for iter_10_0 = 1, #self.specialClickDic do
								local var_10_2 = self.specialClickDic[iter_10_0].tf:InverseTransformPoint(var_10_1)

								if math.abs(var_10_2.x) < self.specialClickDic[iter_10_0].bound.x / 2 and math.abs(var_10_2.y) < self.specialClickDic[iter_10_0].bound.y / 2 then
									self:PrepareTriggerAction(self.specialClickDic[iter_10_0].name)
									self:TriggerPersonalTask(self.specialClickDic[iter_10_0].task)
								end
							end
						end
					end
				end

				return
			end)
			self.dragEvent:AddDragFunc(function(arg_11_0, arg_11_1)
				if self.dragActive then
					if self.isDragAndZoomState then
						self.dragActive = false

						return
					end

					if self.chatting then
						self.dragActive = false

						return
					end

					self.dragOffset = Vector2(self.dragStart.x - arg_11_1.position.x, self.dragStart.y - arg_11_1.position.y)

					if (math.abs(self.dragOffset.x) > 200 or math.abs(self.dragOffset.y) > 200) and self.spinePainting:readyDragAction(arg_8_0.name, true) then
						self.dragActive = false
					end

					self.spinePainting:OnDragMove(arg_8_0.name, self.dragOffset)
				end

				return
			end)
		else
			local var_8_0 = self:GetSpecialTouchEvent(arg_8_0.name)

			if var_8_0 then
				table.insert(self.specialClickDic, {
					name = var_8_0,
					task = self.ship.groupId,
					bound = arg_8_0.sizeDelta,
					tf = arg_8_0
				})
			end

			onButton(self, arg_8_0, function()
				if self.spinePainting:isInAction() then
					return
				end

				local var_12_0 = self:GetSpecialTouchEvent(arg_8_0.name)

				if self:getDragTouchAble(arg_8_0.name, var_7_0) then
					if self.isDragAndZoomState then
						return
					end

					if self.chatting then
						return
					end

					self.spinePainting:readyDragAction(arg_8_0.name, false)
				elseif var_12_0 and not self._asmrFlag then
					self:TriggerEvent(var_12_0)
					self:TriggerPersonalTask(self.ship.groupId)
				end

				return
			end)
		end

		return
	end)

	return
end

function MainSpinePainting:OnClick()
	if self.spinePainting:isInAction() or self._asmrFlag then
		return
	end

	local var_13_0 = self:CollectTouchEvents()

	self:TriggerEvent(var_13_0[math.ceil(math.random(#var_13_0))])

	return
end

function MainSpinePainting:OnEnableTimerEvent()
	return not self.spinePainting:isInAction() and not self._asmrFlag
end

function MainSpinePainting:PrepareTriggerAction(arg_15_1)
	if self._asmrFlag then
		return
	end

	local var_15_0
	local var_15_1 = false
	local var_15_2 = ""

	if pg.AssistantInfo.GetAssistantEvents(arg_15_1) then
		var_15_0 = pg.AssistantInfo.GetAssistantEvents(arg_15_1).action
		var_15_1 = self.spinePainting:getAnimationExist(var_15_0)
		var_15_2 = self.spinePainting:getIdleName()
	end

	if var_15_1 and var_15_2 == "normal" then
		self.spinePainting:SetOnceAction(var_15_0, nil, function()
			self:TryToTriggerEvent(arg_15_1)

			return
		end, true)
	else
		self:TryToTriggerEvent(arg_15_1)
	end

	return
end

function MainSpinePainting:GetEventExit(arg_17_1)
	return (pg.AssistantInfo.GetAssistantEvents(arg_17_1) or nil) and self.spinePainting:getAnimationExist(pg.AssistantInfo.GetAssistantEvents(arg_17_1).action)
end

function MainSpinePainting:TryToTriggerEvent(arg_18_1)
	self:_TriggerEvent(arg_18_1)

	return
end

function MainSpinePainting:onSpinePaintingEvent(arg_19_1)
	self:TryToTriggerEvent(arg_19_1)
	self:TriggerPersonalTask(self.ship.groupId)

	return
end

function MainSpinePainting:GetPaintingTransform()
	if self.spinePainting then
		return self.spinePainting:GetSpineTrasform()
	end

	return nil
end

function MainSpinePainting:GetPartScaleData()
	return pg.ship_skin_template[self.ship:getSkinId()].part_scale.spine
end

function MainSpinePainting:GetPartStateType()
	return MainPaintingView.STATE_SPINE_PAINTING
end

function MainSpinePainting:getDragTouchAble(arg_23_1, arg_23_2)
	if not SpinePaintingConst.ship_drag_datas[arg_23_2] then
		return false
	end

	if SpinePaintingConst.ship_drag_datas[arg_23_2].hit_area then
		return table.contains(SpinePaintingConst.ship_drag_datas[arg_23_2].hit_area, arg_23_1)
	end

	return false
end

function MainSpinePainting:OnDisplayWorld(arg_24_1)
	local var_24_0 = ShipExpressionHelper.GetExpression(self.paintingName, arg_24_1, self.ship:getCVIntimacy(), self.ship:getSkinId())

	if var_24_0 and var_24_0 ~= "" then
		self.spinePainting:SetAction(var_24_0, 1)
		self.spinePainting:displayWord(true)
	end

	return
end

function MainSpinePainting:OnDisplayWordEnd()
	MainSpinePainting.super.OnDisplayWordEnd(self)
	self.spinePainting:SetEmptyAction(1)
	self.spinePainting:displayWord(false)

	return
end

function MainSpinePainting:OnLongPress()
	if self.isFoldState then
		return
	end

	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
		shipId = self.ship.id
	})

	return
end

function MainSpinePainting:PlayChangeSkinActionIn(arg_27_1)
	if self.spinePainting then
		local function var_27_0()
			if arg_27_1 and arg_27_1.callback then
				arg_27_1.callback({
					flag = true
				})
			end

			return
		end

		local function var_27_1()
			local var_29_0 = self.spinePainting:GetDragDataConfig("change_in_hit")

			if var_29_0 and #var_29_0 > 0 then
				self.spinePainting:readyDragAction(var_29_0, false)
				var_27_0()
			elseif self.spinePainting:getAnimationExist("change_in") and self.spinePainting:checkActionPlayAble("change_in", false, 0) then
				self.spinePainting:SetOnceAction("change_in", nil, function()
					var_27_0()

					return
				end, true)
			else
				self:TriggerEvent("event_login")
				var_27_0()
			end

			return
		end

		if self.spinePainting:getInitFlag() then
			var_27_1()
		else
			self:pullInitCallback(var_27_1)
		end
	end

	return
end

function MainSpinePainting:pullInitCallback(arg_31_1)
	table.insert(self._initCallback, arg_31_1)

	return
end

function MainSpinePainting:PlayChangeSkinActionOut(arg_32_1)
	if self.spinePainting and self.spinePainting:getAnimationExist("change_out") then
		if self.spinePainting:checkActionPlayAble("change_out", false, 0) then
			self.spinePainting:SetOnceAction("change_out", function()
				return
			end, function()
				if arg_32_1 and arg_32_1.callback then
					arg_32_1.callback({
						flag = true
					})
				end

				return
			end, true)
		elseif arg_32_1 and arg_32_1.callback then
			arg_32_1.callback({
				flag = true
			})
		end
	elseif arg_32_1 and arg_32_1.callback then
		arg_32_1.callback({
			flag = true
		})
	end

	return
end

function MainSpinePainting:OnUnload()
	if self.spinePainting then
		self.spinePainting:Dispose()

		self.spinePainting = nil
	end

	if self.dragEvent then
		ClearEventTrigger(self.dragEvent)
	end

	return
end

function MainSpinePainting:GetOffset()
	return self.spTF.localPosition.x
end

function MainSpinePainting:OnPause()
	if self.spinePainting then
		self.spinePainting:SetVisible(false)
	end

	return
end

function MainSpinePainting:OnResume()
	if self.spinePainting then
		self.spinePainting:SetVisible(true)
		self.spinePainting:SetEmptyAction(1)
	end

	return
end

return MainSpinePainting
