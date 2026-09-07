pg = pg or {}
pg.GMTMgr = singletonClass("GMTMgr")
pg.GMTMgr.TYPE_DEFAULT_RES = 2
pg.GMTMgr.TYPE_L2D = 4
pg.GMTMgr.TYPE_PAINTING = 8
pg.GMTMgr.TYPE_CIPHER = 16

function pg.GMTMgr.Init(arg_1_0, arg_1_1)
	arg_1_0._gmtTimer = Timer.New(function()
		arg_1_0:onTimer()

		return
	end, 1, -1)

	if arg_1_1 then
		arg_1_1()
	end

	return
end

function pg.GMTMgr:initUI(arg_3_1)
	if self._go == nil then
		PoolMgr.GetInstance():GetUI("GMTUI", true, function(arg_4_0)
			self._go = arg_4_0

			self._go:SetActive(false)

			self._textTf = findTF(self._go, "ad/text")

			self._go.transform:SetParent(GameObject.Find("OverlayCamera/Overlay/UITop").transform, false)

			self._animator = GetComponent(self._go, typeof(Animator))

			arg_3_1()

			return
		end)
	end

	return
end

function pg.GMTMgr:onTimer()
	self._subTime = self._gmtTime - pg.TimeMgr.GetInstance():GetServerTime()

	if self._go == nil then
		self:initUI(function()
			self:showTip()

			return
		end)
	else
		self:showTip()
	end

	if self._subTime < 0 and self._gmtTimer.running then
		self._gmtTimer:Stop()
		self._go:SetActive(false)
	end

	return
end

function pg.GMTMgr:showGMT(arg_7_1)
	self._onceTime = Clone(pg.gameset.maintenance_message.description[1])
	self._repeatTime = Clone(pg.gameset.maintenance_message.description[2])
	self._gmtTime = arg_7_1

	if not self._gmtTimer.running then
		self._gmtTimer:Start()
	end

	self._triggerStop = false

	return
end

function pg.GMTMgr:showTip()
	print(self._subTime)

	local var_8_0 = false

	if self.focusShowTip then
		var_8_0 = true
		self.focusShowTip = false
	end

	if self._subTime <= self._repeatTime then
		var_8_0 = true
	else
		for iter_8_0 = #self._onceTime, 1, -1 do
			if self._subTime <= self._onceTime[iter_8_0] then
				table.remove(self._onceTime, iter_8_0)

				var_8_0 = true
			end
		end
	end

	if not var_8_0 then
		return
	end

	self._go:SetActive(false)
	self._go:SetActive(true)

	if self._subTime > self._repeatTime then
		self._animator:SetTrigger("once")
	elseif not self._triggerStop then
		self._triggerStop = true

		self._animator:SetTrigger("repeat")
	end

	setText(self._textTf, (self:getTimeTip()))

	return
end

function pg.GMTMgr:getTimeTip()
	if self._subTime > 0 then
		local var_9_0 = math.floor(self._subTime / 16)
		local var_9_1 = math.floor(self._subTime / 60)

		return i18n("maintenance_message_text", var_9_0 > 0 and tostring(var_9_0) .. i18n("word_hour") or var_9_1 > 0 and tostring(var_9_1) .. i18n("word_minute") or tostring(self._subTime % 60) .. i18n("word_second"))
	end

	return i18n("maintenance_message_stop_text")
end

return
