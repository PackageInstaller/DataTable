local CommanderBoxCard = class("CommanderBoxCard")

function CommanderBoxCard:Ctor(arg_1_1, arg_1_2)
	self._parent = arg_1_1
	self._tf = arg_1_2
	self._go = go(arg_1_2)
	self.startingTF = self._tf:Find("ongoing")
	self.idleTF = self._tf:Find("idle")
	self.waitTF = self._tf:Find("wait")
	self.timerTxt = self.startingTF:Find("time/Text"):GetComponent(typeof(Text))
	self.slider = self.startingTF:Find("slider/bar")
	self.boxParent = self._tf:Find("char")
	self.titleStarting = self.startingTF:Find("title_starting")
	self.titleFinish = self.startingTF:Find("title_finish")
	self.quicklyTool = self.startingTF:Find("quickly_tool")

	return
end

function CommanderBoxCard:Update(arg_2_1)
	self.boxVO = arg_2_1

	local var_2_0 = arg_2_1:getState()

	self:removeTimer()
	self:removeWaitingTimer()
	removeOnButton(self._tf)

	if var_2_0 == CommanderBox.STATE_EMPTY then
		-- block empty
	elseif var_2_0 == CommanderBox.STATE_WAITING then
		self.waitTimer = Timer.New(function()
			self:removeWaitingTimer()
			self:Update(arg_2_1)
			self._parent:updateCntLabel()

			return
		end, arg_2_1.beginTime - pg.TimeMgr.GetInstance():GetServerTime(), 1)

		self.waitTimer:Start()
	elseif var_2_0 == CommanderBox.STATE_STARTING then
		local var_2_1 = arg_2_1:getFinishTime()
		local var_2_2 = var_2_1 - arg_2_1.beginTime

		self.timer = Timer.New(function()
			local var_4_0 = var_2_1 - pg.TimeMgr.GetInstance():GetServerTime()

			if var_4_0 <= 0 then
				self:removeTimer()
				self:Update(arg_2_1)
			else
				self.timerTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_4_0)

				setFillAmount(self.slider, 1 - var_4_0 / var_2_2)
			end

			return
		end, 1, -1)

		self.timer:Start()
		self.timer.func()
		onButton(self._parent, self.quicklyTool, function()
			self._parent:emit(CommanderCatScene.EVENT_QUICKLY_TOOL, arg_2_1.id)

			return
		end, SFX_PANEL)
	elseif var_2_0 == CommanderBox.STATE_FINISHED then
		self.timerTxt.text = "COMPLETE"

		setFillAmount(self.slider, 1)
		onButton(self._parent, self._tf, function()
			if getProxy(PlayerProxy):getData().commanderBagMax <= getProxy(CommanderProxy):getCommanderCnt() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("commander_capcity_is_max"))

				return
			end

			self._parent:emit(CommanderCatMediator.GET, arg_2_1.id)

			return
		end, SFX_PANEL)
	end

	setActive(self.quicklyTool, var_2_0 == CommanderBox.STATE_STARTING and not LOCK_CATTERY)
	setActive(self.titleStarting, var_2_0 == CommanderBox.STATE_STARTING)
	setActive(self.titleFinish, var_2_0 == CommanderBox.STATE_FINISHED)
	setActive(self.startingTF, var_2_0 == CommanderBox.STATE_STARTING or var_2_0 == CommanderBox.STATE_FINISHED)
	setActive(self.idleTF, var_2_0 == CommanderBox.STATE_EMPTY)
	setActive(self.waitTF, var_2_0 == CommanderBox.STATE_WAITING)
	self:loadBox(arg_2_1:getPrefab(), self.boxParent)

	return
end

function CommanderBoxCard:playAnim(arg_7_1)
	self:loadBox(self.boxVO:getFetchPrefab(), self.boxParent, function(arg_8_0)
		self.spineAnimUI = arg_8_0

		arg_8_0:SetActionCallBack(function(arg_9_0)
			if arg_9_0 == "finish" then
				arg_8_0:SetActionCallBack(nil)
				arg_7_1()
			end

			return
		end)

		return
	end)

	return
end

function CommanderBoxCard:loadBox(arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_1 then
		self:returnChar()
	else
		if self.prefabName == arg_10_1 then
			return
		end

		self:returnChar()

		self.prefabName = arg_10_1

		local var_10_0 = arg_10_1

		PoolMgr.GetInstance():GetSpineChar(arg_10_1, true, function(arg_11_0)
			if self.exited or var_10_0 ~= self.prefabName then
				PoolMgr.GetInstance():ReturnSpineChar(var_10_0, arg_11_0)

				return
			end

			self.modelTf = tf(arg_11_0)
			self.modelTf.localScale = Vector3(0.7, 0.7, 1)
			self.modelTf.localPosition = Vector3(0, -123, 0)

			pg.ViewUtils.SetLayer(self.modelTf, Layer.UI)
			setParent(self.modelTf, arg_10_2)

			local var_11_0 = arg_11_0:GetComponent("SpineAnimUI")

			var_11_0:SetAction("normal", 0)

			if arg_10_3 then
				arg_10_3(var_11_0)
			end

			return
		end)
	end

	return
end

function CommanderBoxCard:removeTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function CommanderBoxCard:removeWaitingTimer()
	if self.waitTimer then
		self.waitTimer:Stop()

		self.waitTimer = nil
	end

	return
end

function CommanderBoxCard:returnChar()
	if self.modelTf and self.prefabName then
		PoolMgr.GetInstance():ReturnSpineChar(self.prefabName, self.modelTf.gameObject)

		self.modelTf = nil
		self.prefabName = nil
	end

	return
end

function CommanderBoxCard:Clear()
	self:removeTimer()
	self:removeWaitingTimer()
	removeOnButton(self._tf)

	self.boxVO = nil

	return
end

function CommanderBoxCard:Destroy()
	self:Clear()
	self:returnChar()

	self.exited = true
	self.boxVO = nil
	self.loading = nil

	return
end

return CommanderBoxCard
