local MakeTeaPtPage = class("MakeTeaPtPage", import(".TemplatePage.SkinTemplatePage"))
local var_0_1 = 5
local var_0_2 = {
	"caizhai",
	"tanfang",
	"shaqing",
	"huichao",
	"huiguo",
	"yincha"
}
local var_0_4

function MakeTeaPtPage:OnInit()
	MakeTeaPtPage.super.OnInit(self)

	return
end

function MakeTeaPtPage:initMv()
	if self.activity.data3 < var_0_1 then
		self.showItemNum = self.activity.data3 or var_0_1
	end

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
		if var_0_4 and Time.realtimeSinceStartup - var_0_4 < 1 then
			return
		end

		var_0_4 = Time.realtimeSinceStartup

		if self.mvManaCpkUI and not self.mvCompleteFlag then
			print("恢复播放")
			self.mvManaCpkUI:Pause(false)
			self:onPlayerStart()
		end

		return
	end)
	onButton(self, self.btnStop, function()
		if var_0_4 and Time.realtimeSinceStartup - var_0_4 < 1 then
			return
		end

		var_0_4 = Time.realtimeSinceStartup

		if self.mvManaCpkUI and not self.mvCompleteFlag then
			print("暂停播放")
			self.mvManaCpkUI:Pause(true)
			self:onPlayerStop()
		end

		return
	end)
	onButton(self, self.btnRepeat, function()
		if var_0_4 and Time.realtimeSinceStartup - var_0_4 < 1 then
			return
		end

		var_0_4 = Time.realtimeSinceStartup

		if self.mvManaCpkUI and self.mvCompleteFlag then
			print("重新播放")
			self:loadMv()
		end

		return
	end)
	onButton(self, self.mvBottom, function()
		if var_0_4 and Time.realtimeSinceStartup - var_0_4 < 1 then
			return
		end

		var_0_4 = Time.realtimeSinceStartup

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
		if var_0_4 and Time.realtimeSinceStartup - var_0_4 < 1 then
			return
		end

		var_0_4 = Time.realtimeSinceStartup

		if self.mvIndex > 1 and not self.isLoading then
			self.mvIndex = self.mvIndex - 1

			self:pageChange()
		end

		return
	end)
	onButton(self, findTF(self.mvTf, "right"), function()
		if var_0_4 and Time.realtimeSinceStartup - var_0_4 < 1 then
			return
		end

		var_0_4 = Time.realtimeSinceStartup

		if self.mvIndex < self.showItemNum and not self.isLoading then
			self.mvIndex = self.mvIndex + 1

			self:pageChange()
		end

		return
	end)

	for iter_2_0 = 1, var_0_1 do
		local var_2_0 = iter_2_0

		onButton(self, findTF(self.mvTf, "page/" .. iter_2_0), function()
			if var_0_4 and Time.realtimeSinceStartup - var_0_4 < 1 then
				return
			end

			var_0_4 = Time.realtimeSinceStartup

			if self.nday < 6 then
				return
			end

			if self.mvIndex ~= var_2_0 and not self.isLoading then
				self.mvIndex = var_2_0

				self:pageChange()
			end

			return
		end)
		setActive(findTF(self.mvTf, "page/" .. iter_2_0), iter_2_0 <= self.showItemNum)
	end

	setActive(self.mvTf, false)

	return
end

function MakeTeaPtPage:UpdateTask(arg_10_1, arg_10_2)
	MakeTeaPtPage.super.UpdateTask(self, arg_10_1, arg_10_2)

	local var_10_0 = self.taskProxy:getTaskById(self.taskGroup[self.nday][arg_10_1 + 1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][arg_10_1 + 1])

	onButton(self, arg_10_2:Find("get_btn"), function()
		if self.nday <= var_0_1 then
			self.mvIndex = self.nday

			function self.playHandle()
				self:emit(ActivityMediator.ON_TASK_SUBMIT, var_10_0)

				return
			end

			self:displayWindow(true)
		else
			local var_11_0 = self.activity:getConfig("config_client").story

			if checkExist(var_11_0, {
				self.nday
			}, {
				1
			}) then
				pg.NewStoryMgr.GetInstance():Play(var_11_0[self.nday][1], function()
					self:emit(ActivityMediator.ON_TASK_SUBMIT, var_10_0)

					return
				end)
			else
				self:emit(ActivityMediator.ON_TASK_SUBMIT, var_10_0)
			end
		end

		return
	end, SFX_PANEL)
	onButton(self, arg_10_2:Find("got_btn"), function()
		self:displayWindow(true)

		return
	end, SFX_PANEL)

	return
end

function MakeTeaPtPage:pageChange()
	self:pageUpdate()
	self:loadMv()

	return
end

function MakeTeaPtPage:pageUpdate()
	for iter_16_0 = 1, var_0_1 do
		setActive(findTF(self.mvTf, "page/" .. iter_16_0 .. "/selected"), self.mvIndex == iter_16_0)
	end

	for iter_16_1 = 1, #var_0_2 do
		setActive(findTF(self.mvTf, "title_word/" .. iter_16_1), iter_16_1 == self.mvIndex)
	end

	return
end

function MakeTeaPtPage:OnFirstFlush()
	MakeTeaPtPage.super.OnFirstFlush(self)

	self.mvIndex = self.activity.data3 > var_0_1 and 1 or self.activity.data3

	self:initMv()

	return
end

function MakeTeaPtPage:OnUpdateFlush()
	self.nday = self.activity.data3

	if self.dayTF then
		setText(self.dayTF, tostring(self.nday))
	end

	self.uilist:align(#self.taskGroup[self.nday])

	for iter_18_0 = 1, #var_0_2 do
		setActive(findTF(self._tf, "AD/word/" .. iter_18_0), iter_18_0 == self.nday)
	end

	return
end

function MakeTeaPtPage:updateMvUI()
	if self.activity.data3 < var_0_1 then
		self.showItemNum = self.activity.data3 or var_0_1
	end

	if self.playHandle then
		setActive(findTF(self.mvTf, "left"), false)
		setActive(findTF(self.mvTf, "right"), false)
	else
		setActive(findTF(self.mvTf, "left"), self.showItemNum > 1)
		setActive(findTF(self.mvTf, "right"), self.showItemNum > 1)
	end

	for iter_19_0 = 1, var_0_1 do
		setActive(findTF(self.mvTf, "page/" .. iter_19_0 .. "/selected"), self.mvIndex == iter_19_0)
		setActive(findTF(self.mvTf, "page/" .. iter_19_0), iter_19_0 <= self.showItemNum)
		setActive(findTF(self.mvTf, "title_word/" .. iter_19_0), iter_19_0 == self.mvIndex)
	end

	return
end

function MakeTeaPtPage:displayWindow(arg_20_1)
	if not arg_20_1 and not self.blurFlag then
		return
	end

	if self.isLoading then
		return
	end

	if self.blurFlag == arg_20_1 then
		return
	end

	if arg_20_1 then
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

	self.blurFlag = arg_20_1

	return
end

function MakeTeaPtPage:OnDestroy()
	MakeTeaPtPage.super.OnDestroy(self)

	self.isLoading = false

	self:displayWindow(false)
	self:clearMovie()

	return
end

function MakeTeaPtPage:clearMovie()
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

function MakeTeaPtPage:GetProgressColor()
	return "#57896D", "#A1AAA1"
end

function MakeTeaPtPage:loadMv()
	self:clearMovie()

	if self.isLoading then
		return
	end

	local var_24_0 = "paocha" .. self.mvIndex

	self.isLoading = true

	PoolMgr.GetInstance():GetUI(var_24_0, true, function(arg_25_0)
		self.mvGo = arg_25_0
		self.mvName = var_24_0
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
		setText(self.movieWord, i18n("mktea_" .. self.mvIndex))

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

function MakeTeaPtPage:mvComplete()
	print("播放完成")

	self.mvCompleteFlag = true

	self:onPlayerEnd()

	if self.mvIndex == self.nday then
		-- block empty
	end

	return
end

function MakeTeaPtPage:onPlayerEnd()
	setActive(self.btnPlay, false)
	setActive(self.btnStop, false)
	setActive(self.btnRepeat, true)

	return
end

function MakeTeaPtPage:onPlayerStop()
	setActive(self.btnPlay, true)
	setActive(self.btnStop, false)
	setActive(self.btnRepeat, false)

	return
end

function MakeTeaPtPage:onPlayerStart()
	setActive(self.btnPlay, false)
	setActive(self.btnStop, true)
	setActive(self.btnRepeat, false)

	return
end

return MakeTeaPtPage
