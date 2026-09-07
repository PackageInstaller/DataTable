local PlantNaximofuPage = class("PlantNaximofuPage", import(".TemplatePage.SkinTemplatePage"))

function PlantNaximofuPage:OnInit()
	PlantNaximofuPage.super.OnInit(self)

	self.clickTime = nil

	return
end

function PlantNaximofuPage:initSkin()
	if self.activity.data3 < self.itmeNum then
		self.showItemNum = self.activity.data3 or self.itmeNum
	end

	self.skinTf = findTF(self._tf, "AD/skinPage")

	setActive(self.skinTf, false)

	self.descClose = findTF(self._tf, "AD/skinPage/descClose")

	setText(self.descClose, i18n("island_act_tips1"))

	self.skinIndex = 1

	self:pageUpdate()

	self.bottom = findTF(self.skinTf, "bottom")

	onButton(self, self.bottom, function()
		if self.clickTime and Time.realtimeSinceStartup - self.clickTime < 0.5 then
			return
		end

		self.clickTime = Time.realtimeSinceStartup

		self:displayWindow(false)

		if self.playHandle then
			self.playHandle()

			self.playHandle = nil
		end

		return
	end)
	onButton(self, findTF(self.skinTf, "leftGo/left"), function()
		if self.clickTime and Time.realtimeSinceStartup - self.clickTime < 0.5 then
			return
		end

		self.clickTime = Time.realtimeSinceStartup

		if self.skinIndex > 1 then
			local var_4_0 = self.displayDayList[self.skinIndex]

			self.skinIndex = self.skinIndex - 1

			self:updateSkinUI()
			setActive(findTF(self.skinTf, "skins/skin" .. self.displayDayList[self.skinIndex]), true)
			self:StartTimer(function()
				setActive(findTF(self.skinTf, "skins/skin" .. var_4_0), false)

				return
			end)
			findTF(self.skinTf, "skins/skin" .. self.displayDayList[self.skinIndex]):GetComponent(typeof(Animation)):Play("anim_zhenhaimuseum_skin_left")
		end

		return
	end)
	onButton(self, findTF(self.skinTf, "rightGo/right"), function()
		if self.clickTime and Time.realtimeSinceStartup - self.clickTime < 0.5 then
			return
		end

		self.clickTime = Time.realtimeSinceStartup

		if self.displayDayList[self.skinIndex] < self.showItemNum then
			local var_6_0 = self.displayDayList[self.skinIndex]

			self.skinIndex = self.skinIndex + 1

			self:updateSkinUI()
			setActive(findTF(self.skinTf, "skins/skin" .. self.displayDayList[self.skinIndex]), true)
			self:StartTimer(function()
				setActive(findTF(self.skinTf, "skins/skin" .. var_6_0), false)

				return
			end)
			findTF(self.skinTf, "skins/skin" .. self.displayDayList[self.skinIndex]):GetComponent(typeof(Animation)):Play("anim_zhenhaimuseum_skin_right")
		end

		return
	end)

	for iter_2_0 = 1, #self.displayDayList do
		local var_2_0 = self.displayDayList[iter_2_0]

		onButton(self, findTF(self.skinTf, "page/" .. self.displayDayList[iter_2_0]), function()
			if self.clickTime and Time.realtimeSinceStartup - self.clickTime < 0.5 then
				return
			end

			self.clickTime = Time.realtimeSinceStartup

			if self.skinIndex ~= iter_2_0 then
				local var_8_0 = self.displayDayList[self.skinIndex]

				if self.skinIndex < iter_2_0 then
					self.skinIndex = self.skinIndex + 1

					self:updateSkinUI()
					setActive(findTF(self.skinTf, "skins/skin" .. self.displayDayList[self.skinIndex]), true)
					self:StartTimer(function()
						setActive(findTF(self.skinTf, "skins/skin" .. var_8_0), false)

						return
					end)
					findTF(self.skinTf, "skins/skin" .. self.displayDayList[self.skinIndex]):GetComponent(typeof(Animation)):Play("anim_zhenhaimuseum_skin_right")
				elseif self.skinIndex > 1 then
					self.skinIndex = self.skinIndex - 1

					self:updateSkinUI()
					setActive(findTF(self.skinTf, "skins/skin" .. self.displayDayList[self.skinIndex]), true)
					self:StartTimer(function()
						setActive(findTF(self.skinTf, "skins/skin" .. var_8_0), false)

						return
					end)
					findTF(self.skinTf, "skins/skin" .. self.displayDayList[self.skinIndex]):GetComponent(typeof(Animation)):Play("anim_zhenhaimuseum_skin_left")
				end
			end

			return
		end)
		setActive(findTF(self.skinTf, "page/" .. var_2_0), var_2_0 <= self.showItemNum)
	end

	return
end

function PlantNaximofuPage:UpdateTask(arg_11_1, arg_11_2)
	PlantNaximofuPage.super.UpdateTask(self, arg_11_1, arg_11_2)

	local var_11_0 = self.taskProxy:getTaskById(self.taskGroup[self.nday][arg_11_1 + 1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][arg_11_1 + 1])

	onButton(self, arg_11_2:Find("get_btn"), function()
		if self.nday <= self.itmeNum then
			function self.playHandle()
				self:emit(ActivityMediator.ON_TASK_SUBMIT, var_11_0)

				return
			end

			if self:GetDayIndex(self.displayDayList, self.nday) then
				self.skinIndex = self:GetNextDayIndex(self.displayDayList, self.nday)

				self:displayWindow(true)
			else
				self.playHandle()

				self.playHandle = nil
			end
		else
			self:emit(ActivityMediator.ON_TASK_SUBMIT, var_11_0)
		end

		return
	end, SFX_PANEL)
	onButton(self, arg_11_2:Find("got_btn"), function()
		self:displayWindow(true)

		return
	end, SFX_PANEL)
	onButton(self, self.bg:Find("review_btn"), function()
		self:displayWindow(true)

		return
	end, SFX_PANEL)

	return
end

function PlantNaximofuPage:GetDayIndex(arg_16_1, arg_16_2)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		if iter_16_1 == arg_16_2 then
			return iter_16_0
		end
	end

	return
end

function PlantNaximofuPage:GetNextDayIndex(arg_17_1, arg_17_2)
	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		if arg_17_2 <= iter_17_1 then
			return iter_17_0
		end
	end

	return 1
end

function PlantNaximofuPage:GetLastDay(arg_18_1, arg_18_2)
	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		if iter_18_1 == arg_18_2 then
			return self.displayDayList[iter_18_0 - 1]
		end
	end

	return 0
end

function PlantNaximofuPage:pageUpdate()
	for iter_19_0, iter_19_1 in ipairs(self.displayDayList) do
		setActive(findTF(self.skinTf, "page/" .. iter_19_1), iter_19_1 <= self.showItemNum)
		setActive(findTF(self.skinTf, "page/" .. iter_19_1 .. "/selected"), self.skinIndex == iter_19_0)
		setActive(findTF(self.skinTf, "skins/skin" .. iter_19_1), self.skinIndex == iter_19_0)

		findTF(self.skinTf, "skins/skin" .. iter_19_1):GetComponent(typeof(Image)).fillAmount = 1
	end

	return
end

function PlantNaximofuPage:OnFirstFlush()
	self.displayDayList = self.activity:getConfig("config_client").displayDay or {
		0,
		1,
		2,
		3,
		4,
		5,
		6,
		7
	}
	self.itmeNum = #self.activity:getConfig("config_data")

	PlantNaximofuPage.super.OnFirstFlush(self)

	self.skinIndex = self:GetNextDayIndex(self.displayDayList, self.activity.data3 > self.itmeNum and 0 or self.activity.data3)

	self:initSkin()

	return
end

function PlantNaximofuPage:OnUpdateFlush()
	self.nday = self.activity.data3

	local var_21_0 = self.activity:getConfig("config_client").story

	if checkExist(var_21_0, {
		1
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_21_0[1][1])
	end

	self.uilist:align(#self.taskGroup[self.nday])

	return
end

function PlantNaximofuPage:updateSkinUI()
	if self.playHandle then
		setActive(findTF(self.skinTf, "leftGo"), false)
		setActive(findTF(self.skinTf, "rightGo"), false)
		setActive(findTF(self.skinTf, "page"), false)
	else
		findTF(self.skinTf, "leftGo/left"):GetComponent(typeof(CanvasGroup)).alpha = self.skinIndex > 1 and 1 or 0.2
		findTF(self.skinTf, "rightGo/right"):GetComponent(typeof(CanvasGroup)).alpha = self.displayDayList[self.skinIndex] < self.showItemNum and 1 or 0.2

		setActive(findTF(self.skinTf, "page"), true)
	end

	self:pageUpdate()

	return
end

function PlantNaximofuPage:displayWindow(arg_23_1)
	if self.blurFlag == arg_23_1 then
		return
	end

	if arg_23_1 then
		setActive(self.skinTf, true)
		self.skinTf:GetComponent(typeof(Animation)):Play("anim_plantNaximofu_in")
		pg.UIMgr.GetInstance():BlurPanel(self.skinTf, {
			staticBlur = true
		})

		if self.activity.data3 < self.itmeNum then
			self.showItemNum = self.activity.data3 or self.itmeNum
		end

		if (self.taskProxy:getTaskById(self.taskGroup[self.nday][1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][1])):getTaskStatus() ~= 2 then
			self.showItemNum = self.showItemNum - 1
		end

		self:updateSkinUI()

		if self.playHandle then
			local var_23_0 = self:GetLastDay(self.displayDayList, self.nday)

			setActive(findTF(self.skinTf, "skins/skin" .. var_23_0), true)
			self:StartTimer(function()
				setActive(findTF(self.skinTf, "skins/skin" .. var_23_0), false)

				return
			end)
			findTF(self.skinTf, "skins/skin" .. self.displayDayList[self.skinIndex]):GetComponent(typeof(Animation)):Play("anim_zhenhaimuseum_skin_right")
		end
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(self.skinTf)
		self.skinTf:GetComponent(typeof(Animation)):Play("anim_plantNaximofu_out")
		self:StartTimer(function()
			setActive(self.skinTf, false)
			SetParent(self.skinTf, self._tf)

			return
		end)
	end

	self.blurFlag = arg_23_1

	return
end

function PlantNaximofuPage:StartTimer(arg_26_1)
	self:RemoveTimer()

	self.timer = Timer.New(arg_26_1, 0.5, 1)

	self.timer:Start()

	return
end

function PlantNaximofuPage:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function PlantNaximofuPage:OnDestroy()
	PlantNaximofuPage.super.OnDestroy(self)
	self:displayWindow(false)
	self:RemoveTimer()

	return
end

function PlantNaximofuPage:GetProgressColor()
	return "#34480CFF", "#34480C66"
end

return PlantNaximofuPage
