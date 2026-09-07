local MainLive2dPainting = class("MainLive2dPainting", import(".MainBasePainting"))

function MainLive2dPainting:Ctor(arg_1_1, arg_1_2)
	MainLive2dPainting.super.Ctor(self, arg_1_1, arg_1_2)

	self.live2dContainer = arg_1_1:Find("live2d")
	self.cg = self.live2dContainer:GetComponent(typeof(CanvasGroup))
	self.currentWidth = Screen.width
	self.currentHeight = Screen.height
	self.isModifyOrder = false
	self.actionWaiting = false
	self.eventTrigger = GetOrAddComponent(self.live2dContainer, typeof(EventTriggerListener))

	self.eventTrigger:AddPointClickFunc(function()
		self:OnClick()
		self:TriggerPersonalTask(self.ship.groupId)

		return
	end)

	return
end

function MainLive2dPainting:GetHalfBodyOffsetY()
	if not self:IslimitYPos() then
		return 0
	end

	return MainPaintingShift.GetHalfBodyOffsetY(self.container.parent, self.live2dContainer)
end

function MainLive2dPainting:OnLoad(arg_4_1)
	if self.live2dChar then
		self:OnUnload()
	end

	local var_4_0 = Live2DPainting.GenerateData({
		loadPrefs = true,
		ship = self.ship,
		position = Vector3(0, 0, 100),
		parent = self.live2dContainer
	})

	self.actionWaiting = false

	self:SetContainerVisible(true)

	self.cg.blocksRaycasts = true
	self.live2dChar = Live2DPainting.New(var_4_0, function(arg_5_0)
		self:AdJustOrderInLayer(arg_5_0)

		if Live2dConst.l2d_bound_open then
			self:CreateL2dDragBound(arg_5_0)
		end

		if self._initTriggerAction then
			for iter_5_0, iter_5_1 in ipairs(self._initTriggerAction) do
				local var_5_0 = pg.AssistantInfo.GetAssistantEvents(iter_5_1).action

				if self.live2dChar:checkActionExist(var_5_0) then
					self.live2dChar:TriggerAction(var_5_0)

					self._initTriggerAction = nil

					break
				end
			end

			self._initTriggerAction = nil
		end

		arg_4_1()

		return
	end)
	self.shipGroup = getProxy(CollectionProxy):getShipGroup(self.ship.groupId)

	self:UpdateContainerPosition()
	self:AddScreenChangeTimer()

	self.cvLoaded = false

	self:preloadCv(function()
		self.cvLoaded = true

		if self.pretriggerEvent then
			self:_TriggerEvent(self.pretriggerEvent)

			self.pretriggerEvent = nil
		end

		return
	end)

	return
end

function MainLive2dPainting:ResetState()
	if not self.live2dChar then
		return
	end

	self.live2dChar:resetL2dData()

	return
end

function MainLive2dPainting:AdJustOrderInLayer(arg_8_1)
	arg_8_1:setSortingLayer(LayerWeightConst.L2D_DEFAULT_LAYER)

	return
end

function MainLive2dPainting:ResetOrderInLayer()
	if not self.live2dChar then
		return
	end

	self.live2dChar._go:GetComponent(typeof(CubismRenderController)).SortingOrder = 0

	return
end

function MainLive2dPainting:CreateL2dDragBound(arg_10_1)
	if not arg_10_1 then
		return
	end

	self._dragBoundsUI = self._dragBoundsUI or L2dBoundsUI.New()

	arg_10_1:SetLive2dPlayingCallback(function()
		if arg_10_1 then
			self._dragBoundsUI:ActionChange(arg_10_1)
		end

		return
	end)
	self._dragBoundsUI:InitUI(nil, function()
		if self._dragBoundsUI and arg_10_1 then
			self._dragBoundsUI:SetData(arg_10_1:GetDragBounds(), self.ship:getSkinId())
			self._dragBoundsUI:SetParent(self.container)
			self._dragBoundsUI:ActionChange(arg_10_1:GetLive2DStateData())
		end

		return
	end)

	return
end

function MainLive2dPainting:AddScreenChangeTimer()
	self:RemoveScreenChangeTimer()

	if not self:IslimitYPos() then
		return
	end

	self.screenTimer = Timer.New(function()
		if self.currentWidth ~= Screen.width or self.currentHeight ~= Screen.height then
			self.currentWidth = Screen.width
			self.currentHeight = Screen.height

			self:ResetContainerPosition()
			self:UpdateContainerPosition()
		end

		return
	end, 0.5, -1)

	self.screenTimer:Start()

	return
end

function MainLive2dPainting:RemoveScreenChangeTimer()
	if self.screenTimer then
		self.screenTimer:Stop()

		self.screenTimer = nil
	end

	return
end

function MainLive2dPainting:UpdateContainerPosition()
	local var_16_0 = self._shift and self._shift:GetL2dShift() or self.live2dContainer.localPosition

	if self:IslimitYPos() then
		var_16_0.y = self:GetHalfBodyOffsetY()
	end

	self.live2dContainer.localPosition = var_16_0

	return
end

function MainLive2dPainting:ResetContainerPosition()
	local var_17_0

	if self._shift then
		var_17_0 = self._shift:GetL2dShift()
	else
		var_17_0 = self.live2dContainer.localPosition
		var_17_0.z = 0
	end

	if self:IslimitYPos() then
		var_17_0.y = self:GetHalfBodyOffsetY()
	end

	self.live2dContainer.localPosition = var_17_0

	return
end

function MainLive2dPainting:OnUnload()
	if self.live2dChar then
		self:RemoveScreenChangeTimer()
		self:ResetContainerPosition()

		if self.isModifyOrder then
			self.isModifyOrder = false

			self:ResetOrderInLayer()
		end

		self.cg.blocksRaycasts = false

		self.live2dChar:saveLive2dData()
		self.live2dChar:Dispose()

		self.live2dChar = nil
	end

	if self._dragBoundsUI then
		self._dragBoundsUI:Dispose()

		self._dragBoundsUI = nil
	end

	return
end

function MainLive2dPainting:OnClick()
	local var_19_0

	if self.live2dChar and self.live2dChar.state == Live2DPainting.STATE_INITED and not self.live2dChar.ignoreReact then
		if not Input.mousePosition then
			return
		end

		local var_19_1 = self.live2dChar:GetTouchPart()

		if var_19_1 > 0 then
			local var_19_2 = self:GetTouchEvent(var_19_1)

			var_19_0 = var_19_2[math.ceil(math.random(#var_19_2))]
		else
			local var_19_3 = self:GetIdleEvents()

			var_19_0 = var_19_3[math.floor(math.Random(0, #var_19_3)) + 1]
		end
	end

	if var_19_0 then
		self:TriggerEvent(var_19_0)
	end

	return
end

function MainLive2dPainting:_TriggerEvent(arg_20_1)
	if not self.cvLoaded then
		self.pretriggerEvent = arg_20_1

		return
	end

	if not arg_20_1 then
		return
	end

	if self.actionWaiting then
		return
	end

	local var_20_0 = self:GetEventConfig(arg_20_1)

	local function var_20_1(arg_21_0)
		if arg_21_0 then
			if var_20_0.dialog ~= "" then
				self:DisplayWord(var_20_0.dialog)
			else
				self:TriggerNextEventAuto()
			end
		end

		self.actionWaiting = false

		return
	end

	local var_20_2, var_20_3, var_20_4, var_20_5, var_20_6, var_20_7 = ShipWordHelper.GetCvDataForShip(self.ship, var_20_0.dialog)
	local var_20_8 = var_20_0.action
	local var_20_9 = string.gsub(var_20_0.dialog, "main_", "main")

	var_20_8 = self.ship.propose and pg.character_voice[var_20_9] and self.shipGroup and self.shipGroup:VoiceReplayCodition(pg.character_voice[var_20_9]) and self.live2dChar:checkActionExist(var_20_8 .. "_ex") and var_20_8 .. "_ex" or var_20_8

	if not var_20_7 then
		self.actionWaiting = true

		var_20_1((self.live2dChar:TriggerAction(var_20_8)))
	else
		self.actionWaiting = true

		if not var_20_4 or var_20_4 == nil or var_20_4 == "" or var_20_4 == "nil" then
			self.actionWaiting = false

			var_20_1(true)
		end

		if not self.live2dChar:TriggerAction(var_20_8, nil, nil, var_20_1) then
			self.actionWaiting = false
		end
	end

	return
end

function MainLive2dPainting:PlayCV(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	self:RemoveSeTimer()

	if arg_22_1 then
		self.seTimer = Timer.New(function()
			pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. arg_22_1[1])

			return
		end, arg_22_1[2], 1)

		self.seTimer:Start()
	end

	self.cvLoader:Load(pg.CriMgr.GetCVBankName((ShipWordHelper.RawGetCVKey(self.ship:getSkinId()))), arg_22_3, arg_22_2, arg_22_4)

	return
end

function MainLive2dPainting:RemoveSeTimer()
	if self.seTimer then
		self.seTimer:Stop()

		self.seTimer = nil
	end

	return
end

function MainLive2dPainting:PlayChangeSkinActionIn(arg_25_1)
	if self.live2dChar:IsLoaded() then
		if self.live2dChar:checkActionExist("change_in") then
			self:TriggerEvent("event_change_in")
		else
			self:TriggerEvent("event_login")
		end
	else
		self._initTriggerAction = {
			"event_change_in",
			"event_login"
		}
	end

	if arg_25_1 and arg_25_1.callback then
		arg_25_1.callback({
			flag = true
		})
	end

	return
end

function MainLive2dPainting:PlayChangeSkinActionOut(arg_26_1)
	if self.live2dChar:IsLoaded() and self.live2dChar:checkActionExist("change_out") then
		self:playSkinOut(arg_26_1)
	elseif arg_26_1 and arg_26_1.callback then
		arg_26_1.callback({
			flag = true
		})
	end

	return
end

function MainLive2dPainting:UpdateBound()
	if not self._dragBoundsUI and self.live2dChar then
		self:CreateL2dDragBound(self.live2dChar)
		self._dragBoundsUI:SetVisible(Live2dConst.l2d_bound_open)
	elseif self._dragBoundsUI then
		if self._dragBoundsUI:GetDragsCount() == 0 then
			self._dragBoundsUI:SetData(self.live2dChar:GetDragBounds(), self.ship:getSkinId())
		end

		self._dragBoundsUI:SetVisible(Live2dConst.l2d_bound_open)
	end

	return
end

function MainLive2dPainting:playSkinOut(arg_28_1)
	local function var_28_0()
		if arg_28_1 and arg_28_1.callback then
			arg_28_1.callback({
				flag = true
			})
		end

		return
	end

	if not self.live2dChar:TriggerAction("change_out", function()
		return
	end, false, function()
		if var_28_0 then
			var_28_0()

			var_28_0 = nil
		end

		return
	end) and var_28_0 then
		var_28_0()

		var_28_0 = nil
	end

	return
end

function MainLive2dPainting:OnDisplayWorld()
	return
end

function MainLive2dPainting:OnPause()
	print("pause")
	self:RemoveScreenChangeTimer()
	self:ResetContainerPosition()

	self.actionWaiting = false

	self:OnUnload()

	return
end

function MainLive2dPainting:OnUpdateShip(arg_34_1)
	if arg_34_1 then
		self.live2dChar:updateShip(arg_34_1)
	end

	return
end

function MainLive2dPainting:SetContainerVisible(arg_35_1)
	return
end

function MainLive2dPainting:IsLoaded()
	if not self.live2dChar then
		return false
	end

	return MainLive2dPainting.super.IsLoaded(self)
end

function MainLive2dPainting:OnResume()
	self:SetContainerVisible(true)
	self:AddScreenChangeTimer()
	self:UpdateContainerPosition()
	onNextTick(function()
		if self.ship then
			self:Load(self.ship)
		end

		return
	end)

	return
end

function MainLive2dPainting:Dispose()
	MainLive2dPainting.super.Dispose(self)
	self:RemoveSeTimer()
	self:RemoveScreenChangeTimer()

	if self._dragBoundsUI then
		self._dragBoundsUI:Dispose()

		self._dragBoundsUI = nil
	end

	if self.eventTrigger then
		ClearEventTrigger(self.eventTrigger)
	end

	return
end

function MainLive2dPainting:GetOffset()
	return self.live2dContainer.localPosition.x
end

function MainLive2dPainting:GetCenterPos()
	return self.live2dContainer.position
end

function MainLive2dPainting:IslimitYPos()
	return MainPaintingShift.IsLimitYPos(self.ship:getPainting())
end

return MainLive2dPainting
