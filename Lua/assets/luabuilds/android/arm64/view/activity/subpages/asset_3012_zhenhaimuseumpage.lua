local ZhenhaiMuseumPage = class("ZhenhaiMuseumPage", import(".TemplatePage.SkinTemplatePage"))
local var_0_1 = 7
local var_0_2

function ZhenhaiMuseumPage:initSkin()
	if self.activity.data3 < var_0_1 then
		self.showItemNum = self.activity.data3 or var_0_1
	end

	self.skinTf = findTF(self._tf, "AD/skinPage")

	setActive(self.skinTf, false)

	self.descClose = findTF(self._tf, "AD/skinPage/descClose")

	setText(self.descClose, i18n("island_act_tips1"))

	self.skinIndex = 0

	self:pageUpdate()

	self.bottom = findTF(self.skinTf, "bottom")

	onButton(self, self.bottom, function()
		if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 0.5 then
			return
		end

		var_0_2 = Time.realtimeSinceStartup

		if self.playHandle then
			self.playHandle()

			self.playHandle = nil
		end

		self:displayWindow(false)

		return
	end)
	onButton(self, findTF(self.skinTf, "left"), function()
		if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 0.5 then
			return
		end

		var_0_2 = Time.realtimeSinceStartup

		if self.skinIndex > 0 then
			local var_3_0 = self.skinIndex

			self.skinIndex = self.skinIndex - 1

			self:updateSkinUI()
			setActive(findTF(self.skinTf, "skins/skin" .. self.skinIndex), true)
			self:StartTimer(function()
				setActive(findTF(self.skinTf, "skins/skin" .. var_3_0), false)

				return
			end)
			findTF(self.skinTf, "skins/skin" .. self.skinIndex):GetComponent(typeof(Animation)):Play("anim_zhenhaimuseum_skin_left")
		end

		return
	end)
	onButton(self, findTF(self.skinTf, "right"), function()
		if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 0.5 then
			return
		end

		var_0_2 = Time.realtimeSinceStartup

		if self.skinIndex < self.showItemNum then
			local var_5_0 = self.skinIndex

			self.skinIndex = self.skinIndex + 1

			self:updateSkinUI()
			setActive(findTF(self.skinTf, "skins/skin" .. self.skinIndex), true)
			self:StartTimer(function()
				setActive(findTF(self.skinTf, "skins/skin" .. var_5_0), false)

				return
			end)
			findTF(self.skinTf, "skins/skin" .. self.skinIndex):GetComponent(typeof(Animation)):Play("anim_zhenhaimuseum_skin_right")
		end

		return
	end)

	for iter_1_0 = 0, var_0_1 do
		onButton(self, findTF(self.skinTf, "page/" .. iter_1_0), function()
			if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 0.5 then
				return
			end

			var_0_2 = Time.realtimeSinceStartup

			if self.skinIndex ~= iter_1_0 then
				local var_7_0 = self.skinIndex

				if self.skinIndex < iter_1_0 then
					self.skinIndex = self.skinIndex + 1

					self:updateSkinUI()
					setActive(findTF(self.skinTf, "skins/skin" .. self.skinIndex), true)
					self:StartTimer(function()
						setActive(findTF(self.skinTf, "skins/skin" .. var_7_0), false)

						return
					end)
					findTF(self.skinTf, "skins/skin" .. self.skinIndex):GetComponent(typeof(Animation)):Play("anim_zhenhaimuseum_skin_right")
				else
					self.skinIndex = self.skinIndex - 1

					self:updateSkinUI()
					setActive(findTF(self.skinTf, "skins/skin" .. self.skinIndex), true)
					self:StartTimer(function()
						setActive(findTF(self.skinTf, "skins/skin" .. var_7_0), false)

						return
					end)
					findTF(self.skinTf, "skins/skin" .. self.skinIndex):GetComponent(typeof(Animation)):Play("anim_zhenhaimuseum_skin_left")
				end
			end

			return
		end)
		setActive(findTF(self.skinTf, "page/" .. iter_1_0), iter_1_0 <= self.showItemNum)
	end

	setActive(self.skinTf, false)

	return
end

function ZhenhaiMuseumPage:UpdateTask(arg_10_1, arg_10_2)
	ZhenhaiMuseumPage.super.UpdateTask(self, arg_10_1, arg_10_2)

	local var_10_0 = self.taskProxy:getTaskById(self.taskGroup[self.nday][arg_10_1 + 1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][arg_10_1 + 1])

	onButton(self, arg_10_2:Find("get_btn"), function()
		if self.nday <= var_0_1 then
			self.skinIndex = self.nday

			function self.playHandle()
				self:emit(ActivityMediator.ON_TASK_SUBMIT, var_10_0)

				return
			end

			self:displayWindow(true)
		else
			self:emit(ActivityMediator.ON_TASK_SUBMIT, var_10_0)
		end

		return
	end, SFX_PANEL)
	onButton(self, arg_10_2:Find("got_btn"), function()
		self:displayWindow(true)

		return
	end, SFX_PANEL)
	onButton(self, self.bg:Find("review_btn"), function()
		self:displayWindow(true)

		return
	end, SFX_PANEL)

	return
end

function ZhenhaiMuseumPage:pageUpdate()
	for iter_15_0 = 0, var_0_1 do
		setActive(findTF(self.skinTf, "page/" .. iter_15_0), iter_15_0 <= self.showItemNum)
		setActive(findTF(self.skinTf, "page/" .. iter_15_0 .. "/selected"), self.skinIndex == iter_15_0)
		setActive(findTF(self.skinTf, "skins/skin" .. iter_15_0), self.skinIndex == iter_15_0)

		findTF(self.skinTf, "skins/skin" .. iter_15_0):GetComponent(typeof(Image)).fillAmount = 1
	end

	return
end

function ZhenhaiMuseumPage:OnFirstFlush()
	ZhenhaiMuseumPage.super.OnFirstFlush(self)

	self.skinIndex = self.activity.data3 > var_0_1 and 0 or self.activity.data3

	self:initSkin()

	return
end

function ZhenhaiMuseumPage:OnUpdateFlush()
	self.nday = self.activity.data3

	local var_17_0 = self.activity:getConfig("config_client").story

	if checkExist(var_17_0, {
		1
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_17_0[1][1])
	end

	self.uilist:align(#self.taskGroup[self.nday])

	return
end

function ZhenhaiMuseumPage:updateSkinUI()
	if self.playHandle then
		setActive(findTF(self.skinTf, "left"), false)
		setActive(findTF(self.skinTf, "right"), false)
		setActive(findTF(self.skinTf, "page"), false)
	else
		setActive(findTF(self.skinTf, "left"), self.skinIndex > 0)
		setActive(findTF(self.skinTf, "right"), self.skinIndex < self.showItemNum)
		setActive(findTF(self.skinTf, "page"), true)
	end

	self:pageUpdate()

	return
end

function ZhenhaiMuseumPage:displayWindow(arg_19_1)
	if self.blurFlag == arg_19_1 then
		return
	end

	if arg_19_1 then
		setActive(self.skinTf, true)
		self.skinTf:GetComponent(typeof(Animation)):Play("anim_zhenhaimuseum_in")
		pg.UIMgr.GetInstance():BlurPanel(self.skinTf, {
			staticBlur = true
		})

		if self.activity.data3 < var_0_1 then
			self.showItemNum = self.activity.data3 or var_0_1
		end

		if (self.taskProxy:getTaskById(self.taskGroup[self.nday][1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][1])):getTaskStatus() ~= 2 then
			self.showItemNum = self.showItemNum - 1
		end

		self:updateSkinUI()

		if self.playHandle then
			local var_19_0 = self.nday - 1

			setActive(findTF(self.skinTf, "skins/skin" .. self.nday - 1), true)
			self:StartTimer(function()
				setActive(findTF(self.skinTf, "skins/skin" .. var_19_0), false)

				return
			end)
			findTF(self.skinTf, "skins/skin" .. self.skinIndex):GetComponent(typeof(Animation)):Play("anim_zhenhaimuseum_skin_right")
		end
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(self.skinTf)
		self.skinTf:GetComponent(typeof(Animation)):Play("anim_zhenhaimuseum_out")
		self:StartTimer(function()
			setActive(self.skinTf, false)

			return
		end)
	end

	self.blurFlag = arg_19_1

	return
end

function ZhenhaiMuseumPage:StartTimer(arg_22_1)
	self:RemoveTimer()

	self.timer = Timer.New(arg_22_1, 0.5, 1)

	self.timer:Start()

	return
end

function ZhenhaiMuseumPage:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function ZhenhaiMuseumPage:OnDestroy()
	ZhenhaiMuseumPage.super.OnDestroy(self)
	self:displayWindow(false)
	self:RemoveTimer()

	return
end

function ZhenhaiMuseumPage:GetProgressColor()
	return "#435271", "#5D7B97"
end

return ZhenhaiMuseumPage
