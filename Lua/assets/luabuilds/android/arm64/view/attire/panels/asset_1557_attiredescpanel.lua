local AttireDescPanel = class("AttireDescPanel")

function AttireDescPanel:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = tf(arg_1_1)
	self.icon = findTF(self._tf, "icon")
	self.frame = findTF(self._tf, "frame")
	self.chatContainer = findTF(self._tf, "chatContainer")
	self.conditionTF = findTF(self._tf, "condition")
	self.nameTxt = findTF(self._tf, "name/Text"):GetComponent(typeof(Text))
	self.stateTxt = findTF(self._tf, "get_info/lock"):GetComponent(typeof(Text))
	self.timeTxt = findTF(self._tf, "get_info/time"):GetComponent(typeof(Text))
	self.conditionTxt = findTF(self._tf, "condition/Text"):GetComponent(typeof(Text))
	self.applyBtn = findTF(self._tf, "apply_btn")
	self.applyingBtn = findTF(self._tf, "applying_btn")
	self.getBtn = findTF(self._tf, "get_btn")

	return
end

function AttireDescPanel:Update(arg_2_1, arg_2_2)
	self:UpdateIconDesc(arg_2_1, arg_2_2)

	self.nameTxt.text = HXSet.hxLan(arg_2_1:getConfig("name"))

	local var_2_0 = arg_2_1:isOwned()

	self.stateTxt.text = setColorStr(var_2_0 and i18n("word_got") or i18n("word_not_get"), var_2_0 and "#3DC6FFFF" or "#a5afdf")

	local var_2_1 = arg_2_1:expiredType()

	self:RemoveTimer()

	if var_2_0 and var_2_1 then
		self:AddTimer(arg_2_1, arg_2_2)
	elseif var_2_0 and not var_2_1 then
		self.timeTxt.text = ""
	elseif not var_2_0 then
		self.timeTxt.text = ""
	end

	self.conditionTxt.text = HXSet.hxLan(arg_2_1:getConfig("desc"))

	local var_2_2 = arg_2_1:getState()
	local var_2_3 = arg_2_2:getAttireByType(arg_2_1:getType()) == arg_2_1.id

	setActive(self.applyBtn, var_2_2 == AttireFrame.STATE_UNLOCK and not var_2_3)
	setActive(self.applyingBtn, var_2_2 == AttireFrame.STATE_UNLOCK and var_2_3)
	setActive(self.getBtn, var_2_2 == AttireFrame.STATE_LOCK)

	return
end

function AttireDescPanel:UpdateIconDesc(arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1:getType() == AttireConst.TYPE_ICON_FRAME
	local var_3_1 = arg_3_1:getType() == AttireConst.TYPE_CHAT_FRAME

	if self.loadedIcon and self.loadedIconTF then
		if var_3_1 then
			self.loadedIconTF.transform:Find("Text"):GetComponent(typeof(Text)).supportRichText = false
		end

		PoolMgr.GetInstance():ReturnPrefab(self.loadedIcon:getIcon(), self.loadedIcon.id, self.loadedIconTF)
	end

	if var_3_0 then
		self.startList = self.startList or UIItemList.New(findTF(self._tf, "stars"), findTF(self._tf, "stars/tpl"))

		PoolMgr.GetInstance():GetPrefab(arg_3_1:getIcon(), arg_3_1:getConfig("id"), true, function(arg_4_0)
			self.loadedIcon = arg_3_1
			self.loadedIconTF = arg_4_0

			setParent(arg_4_0, self.frame, false)

			return
		end)

		local var_3_2 = arg_3_2:GetFlagShip()

		LoadSpriteAsync("qicon/" .. var_3_2:getPrefab(), function(arg_5_0)
			self.icon:GetComponent(typeof(Image)).sprite = arg_5_0

			return
		end)
		self.startList:align(var_3_2:getStar())
	elseif var_3_1 then
		PoolMgr.GetInstance():GetPrefab(arg_3_1:getIcon(), arg_3_1:getConfig("id") .. "_self", true, function(arg_6_0)
			self.loadedIcon = arg_3_1
			self.loadedIconTF = arg_6_0

			setParent(arg_6_0, self.chatContainer, false)

			tf(arg_6_0).localPosition = Vector3(0, 0, 0)
			findTF(arg_6_0, "Text"):GetComponent(typeof(Text)).supportRichText = true

			setText(findTF(arg_6_0, "Text"), arg_3_1:getConfig("desc"))

			return
		end)
	end

	setActive(self.conditionTF, not var_3_1)

	return
end

function AttireDescPanel:AddTimer(arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1:getExpiredTime()

	self.timer = Timer.New(function()
		local var_8_0 = var_7_0 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_8_0 > 0 then
			self.timeTxt.text = "/ " .. attireTimeStamp(var_8_0)
		else
			self:Update(arg_7_1, arg_7_2)
			self:RemoveTimer()
		end

		return
	end, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function AttireDescPanel:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function AttireDescPanel:Dispose()
	self:RemoveTimer()

	return
end

return AttireDescPanel
