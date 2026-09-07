local Mv1PtPage = class("Mv1PtPage", import(".TemplatePage.SkinTemplatePage"))
local var_0_1 = 3
local var_0_2

function Mv1PtPage:OnInit()
	Mv1PtPage.super.OnInit(self)

	return
end

function Mv1PtPage:initMv()
	self.showItemNum = var_0_1
	self.mvTf = findTF(self._tf, "AD/mvPage")

	setActive(self.mvTf, false)

	self.mvContent = findTF(self._tf, "AD/mvPage/movie/view/content")
	self.movieWord = findTF(self._tf, "AD/mvPage/movie/movieWord")
	self.descClose = findTF(self._tf, "AD/mvPage/descClose")

	setText(self.descClose, i18n("island_act_tips1"))

	self.mvIndex = 1

	self:pageUpdate()

	self.mvBottom = findTF(self.mvTf, "bottom")
	self.btnPlay = findTF(self.mvTf, "movie/btnPlay")
	self.btnStop = findTF(self.mvTf, "movie/btnStop")
	self.btnRepeat = findTF(self.mvTf, "movie/btnRepeat")

	onButton(self, self.btnPlay, function()
		if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 1 then
			return
		end

		var_0_2 = Time.realtimeSinceStartup

		if self.mvManaCpkUI and not self.mvCompleteFlag then
			print("恢复播放")
			self.mvManaCpkUI:Pause(false)
			self:onPlayerStart()
		end

		return
	end)
	onButton(self, self.btnStop, function()
		if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 1 then
			return
		end

		var_0_2 = Time.realtimeSinceStartup

		if self.mvManaCpkUI and not self.mvCompleteFlag then
			print("暂停播放")
			self.mvManaCpkUI:Pause(true)
			self:onPlayerStop()
		end

		return
	end)
	onButton(self, self.btnRepeat, function()
		if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 1 then
			return
		end

		var_0_2 = Time.realtimeSinceStartup

		if self.mvManaCpkUI and self.mvCompleteFlag then
			print("重新播放")
			self:loadMv()
		end

		return
	end)
	onButton(self, self.mvBottom, function()
		if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 1 then
			return
		end

		var_0_2 = Time.realtimeSinceStartup

		if self.isLoading then
			return
		end

		if self.playHandle then
			self.playHandle()

			self.playHandle = nil
		end

		self:displayWindow(false)
		self:clearMovie()

		return
	end)
	onButton(self, findTF(self.mvTf, "left"), function()
		if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 1 then
			return
		end

		var_0_2 = Time.realtimeSinceStartup

		if self.mvIndex > 1 and not self.isLoading then
			self.mvIndex = self.mvIndex - 1

			self:pageChange()
		end

		return
	end)
	onButton(self, findTF(self.mvTf, "right"), function()
		if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 1 then
			return
		end

		var_0_2 = Time.realtimeSinceStartup

		if self.mvIndex < self.showItemNum and not self.isLoading then
			self.mvIndex = self.mvIndex + 1

			self:pageChange()
		end

		return
	end)
	onButton(self, findTF(self._tf, "AD/chapter"), function()
		self:displayWindow(true)

		return
	end, SFX_PANEL)
	onButton(self, findTF(self._tf, "AD/left"), function()
		if self.mvIndex > 1 and not self.isLoading then
			self.mvIndex = self.mvIndex - 1

			self:pageUpdate()
		end

		return
	end)
	onButton(self, findTF(self._tf, "AD/right"), function()
		if self.mvIndex < self.showItemNum and not self.isLoading then
			self.mvIndex = self.mvIndex + 1

			self:pageUpdate()
		end

		return
	end)

	for iter_2_0 = 1, var_0_1 do
		local var_2_0 = iter_2_0

		onButton(self, findTF(self.mvTf, "page/" .. iter_2_0), function()
			if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 1 then
				return
			end

			var_0_2 = Time.realtimeSinceStartup

			if self.nday < 6 then
				return
			end

			if self.mvIndex ~= var_2_0 and not self.isLoading then
				self.mvIndex = var_2_0

				self:pageUpdate()
			end

			return
		end)
		setActive(findTF(self.mvTf, "page/" .. iter_2_0), iter_2_0 <= self.showItemNum)
	end

	setActive(self.mvTf, false)

	return
end

function Mv1PtPage:UpdateTask(arg_13_1, arg_13_2)
	local var_13_0 = arg_13_2:Find("itemMask/item")
	local var_13_1 = self.taskProxy:getTaskById(self.taskGroup[self.nday][arg_13_1 + 1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][arg_13_1 + 1])

	assert(var_13_1, "without this task by id: " .. self.taskGroup[self.nday][arg_13_1 + 1])

	local var_13_2 = var_13_1:getConfig("award_display")[1]
	local var_13_3 = {
		type = var_13_2[1],
		id = var_13_2[2],
		count = var_13_2[3]
	}

	updateDrop(var_13_0, var_13_3)
	onButton(self, var_13_0, function()
		self:emit(BaseUI.ON_DROP, var_13_3)

		return
	end, SFX_PANEL)

	local var_13_4 = var_13_1:getProgress()
	local var_13_5 = var_13_1:getConfig("target_num")

	setText(arg_13_2:Find("description"), var_13_1:getConfig("desc"))

	local var_13_6, var_13_7 = self:GetProgressColor()

	setText(arg_13_2:Find("progressText"), (var_13_6 and setColorStr(var_13_4, var_13_6) or var_13_4) .. (var_13_7 and setColorStr("/" .. var_13_5, var_13_7) or "/" .. var_13_5))
	setSlider(arg_13_2:Find("progress"), 0, var_13_5, var_13_4)

	local var_13_9 = arg_13_2:Find("go_btn")
	local var_13_10 = arg_13_2:Find("get_btn")
	local var_13_11 = arg_13_2:Find("got_btn")
	local var_13_12 = var_13_1:getTaskStatus()

	setActive(var_13_9, var_13_12 == 0)
	setActive(var_13_10, var_13_12 == 1)
	setActive(var_13_11, var_13_12 == 2)
	onButton(self, var_13_9, function()
		self:emit(ActivityMediator.ON_TASK_GO, var_13_1)

		return
	end, SFX_PANEL)
	onButton(self, var_13_10, function()
		self:emit(ActivityMediator.ON_TASK_SUBMIT, var_13_1)

		return
	end, SFX_PANEL)

	local var_13_13 = self.taskProxy:getTaskById(self.taskGroup[self.nday][arg_13_1 + 1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][arg_13_1 + 1])

	onButton(self, arg_13_2:Find("get_btn"), function()
		if self.nday <= var_0_1 then
			self.mvIndex = self.nday

			self:emit(ActivityMediator.ON_TASK_SUBMIT, var_13_13)
		else
			local var_17_0 = self.activity:getConfig("config_client").story

			if checkExist(var_17_0, {
				self.nday
			}, {
				1
			}) then
				pg.NewStoryMgr.GetInstance():Play(var_17_0[self.nday][1], function()
					self:emit(ActivityMediator.ON_TASK_SUBMIT, var_13_13)

					return
				end)
			else
				self:emit(ActivityMediator.ON_TASK_SUBMIT, var_13_13)
			end
		end

		return
	end, SFX_PANEL)
	onButton(self, arg_13_2:Find("got_btn"), function()
		self:displayWindow(true)

		return
	end, SFX_PANEL)

	return
end

function Mv1PtPage:pageChange()
	self:pageUpdate()
	self:loadMv()

	return
end

function Mv1PtPage:pageUpdate()
	for iter_21_0 = 1, var_0_1 do
		setActive(findTF(self.mvTf, "page/" .. iter_21_0 .. "/selected"), self.mvIndex == iter_21_0)
	end

	for iter_21_1 = 1, var_0_1 do
		setActive(findTF(self._tf, "AD/page/" .. iter_21_1 .. "/selected"), self.mvIndex == iter_21_1)
	end

	for iter_21_2 = 1, var_0_1 do
		setActive(findTF(self._tf, "AD/chapter/" .. iter_21_2), self.mvIndex == iter_21_2)
	end

	setActive(findTF(self._tf, "AD/right"), self.mvIndex ~= self.showItemNum)
	setActive(findTF(self._tf, "AD/left"), self.mvIndex ~= 1)

	return
end

function Mv1PtPage:OnFirstFlush()
	Mv1PtPage.super.OnFirstFlush(self)

	self.mvIndex = self.activity.data3 > var_0_1 and 1 or self.activity.data3

	self:initMv()

	return
end

function Mv1PtPage:OnUpdateFlush()
	self.nday = self.activity.data3

	if self.dayTF then
		setText(self.dayTF, tostring(self.nday))
	end

	self.uilist:align(#self.taskGroup[self.nday])

	return
end

function Mv1PtPage:updateMvUI()
	self.showItemNum = var_0_1

	if self.playHandle then
		setActive(findTF(self.mvTf, "left"), false)
		setActive(findTF(self.mvTf, "right"), false)
	else
		setActive(findTF(self.mvTf, "left"), self.showItemNum > 1)
		setActive(findTF(self.mvTf, "right"), self.showItemNum > 1)
	end

	for iter_24_0 = 1, var_0_1 do
		setActive(findTF(self.mvTf, "page/" .. iter_24_0 .. "/selected"), self.mvIndex == iter_24_0)
		setActive(findTF(self.mvTf, "page/" .. iter_24_0), iter_24_0 <= self.showItemNum)
	end

	return
end

function Mv1PtPage:displayWindow(arg_25_1)
	if not arg_25_1 and not self.blurFlag then
		return
	end

	if self.isLoading then
		return
	end

	if self.blurFlag == arg_25_1 then
		return
	end

	if arg_25_1 then
		setActive(self.mvTf, true)
		setSizeDelta(findTF(self.mvTf, "bottom"), Vector2(Screen.width, Screen.height))
		pg.UIMgr.GetInstance():BlurPanel(self.mvTf, {
			staticBlur = true
		})
		self:updateMvUI()
		self:loadMv()
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(self.mvTf)
		setActive(self.mvTf, false)
	end

	self.blurFlag = arg_25_1

	return
end

function Mv1PtPage:OnDestroy()
	Mv1PtPage.super.OnDestroy(self)

	self.isLoading = false

	self:displayWindow(false)
	self:clearMovie()

	return
end

function Mv1PtPage:clearMovie()
	if self.mvGo then
		self.mvManaCpkUI:SetPlayEndHandler(nil)
		self.mvManaCpkUI:StopCpk()
		destroy(self.mvGo)

		self.mvManaCpkUI = nil
		self.mvGo = nil
		self.mvName = nil
	end

	return
end

function Mv1PtPage:GetProgressColor()
	return "#FF6868", "#604D49"
end

function Mv1PtPage:loadMv()
	self:clearMovie()

	if self.isLoading then
		return
	end

	local var_29_0 = "psplive_" .. self.mvIndex

	self.isLoading = true

	PoolMgr.GetInstance():GetUI(var_29_0, true, function(arg_30_0)
		self.mvGo = arg_30_0
		self.mvName = var_29_0
		self.mvManaCpkUI = GetComponent(findTF(self.mvGo, "video/cpk"), typeof(CriManaCpkUI))

		self.mvManaCpkUI:SetPlayEndHandler(System.Action(function()
			self:mvComplete()

			if self.playHandle then
				self.playHandle()

				self.playHandle = nil
			end

			return
		end))
		setActive(self.btnPlay, false)
		setActive(self.btnStop, true)
		setActive(self.btnRepeat, false)

		if self.isLoading == false then
			self:clearMovie()
		else
			self.isLoading = false

			setParent(self.mvGo, self.mvContent)
			setActive(self.mvGo, true)
		end

		self.mvCompleteFlag = false

		self.mvManaCpkUI:PlayCpk()

		return
	end)

	return
end

function Mv1PtPage:mvComplete()
	print("播放完成")

	self.mvCompleteFlag = true

	self:onPlayerEnd()

	if self.mvIndex == self.nday then
		-- block empty
	end

	return
end

function Mv1PtPage:onPlayerEnd()
	setActive(self.btnPlay, false)
	setActive(self.btnStop, false)
	setActive(self.btnRepeat, true)

	return
end

function Mv1PtPage:onPlayerStop()
	setActive(self.btnPlay, true)
	setActive(self.btnStop, false)
	setActive(self.btnRepeat, false)

	return
end

function Mv1PtPage:onPlayerStart()
	setActive(self.btnPlay, false)
	setActive(self.btnStop, true)
	setActive(self.btnRepeat, false)

	return
end

return Mv1PtPage
