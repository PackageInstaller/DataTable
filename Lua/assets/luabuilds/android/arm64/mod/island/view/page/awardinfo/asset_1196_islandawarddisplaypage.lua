local IslandAwardDisplayPage = class("IslandAwardDisplayPage", import("view.base.BaseSubView"))

IslandAwardDisplayPage.TYPE_COMMON = 1
IslandAwardDisplayPage.TYPE_SHIP_SKILL = 2
IslandAwardDisplayPage.TYPE_SHIP_BREAK = 3
IslandAwardDisplayPage.TYPE_SIGN_GIFT = 4
IslandAwardDisplayPage.AUTO_COLLECT = 5

function IslandAwardDisplayPage:getUIName()
	return "IslandAwardDisplayConatiner"
end

function IslandAwardDisplayPage:OnLoaded()
	self.windows = {
		[IslandAwardDisplayPage.TYPE_COMMON] = IslandAwardDisplayWindow.New(self._tf),
		[IslandAwardDisplayPage.TYPE_SHIP_SKILL] = IslandAwardDisplay4ShipSkillWindow.New(self._tf),
		[IslandAwardDisplayPage.TYPE_SHIP_BREAK] = IslandAwardDisplay4ShipBreakWindow.New(self._tf),
		[IslandAwardDisplayPage.TYPE_SIGN_GIFT] = IslandAwardDisplay4SignGiftWindow.New(self._tf),
		[IslandAwardDisplayPage.AUTO_COLLECT] = IslandAutoCollectAwardDisplayWindow.New(self._tf)
	}

	return
end

function IslandAwardDisplayPage:OnInit()
	onButton(self, self._tf, function()
		if not self.window then
			return
		end

		if self.playing then
			return
		end

		self.playing = true

		self.window:PlayExitAniamtion(function()
			self.playing = false

			if self.callback then
				self.callback()

				self.callback = nil
			end

			self:Hide()

			return
		end)

		self.window = nil

		return
	end, SFX_PANEL)

	return
end

function IslandAwardDisplayPage:Show(arg_6_1)
	IslandAwardDisplayPage.super.Show(self)
	assert(not self:AnyWindowShowing(), "同时只能存在一个奖励界面")
	self:HideWindows()

	self.callback = arg_6_1.callback

	self.windows[arg_6_1.type or IslandAwardDisplayPage.TYPE_COMMON]:ExecuteAction("Show", arg_6_1)

	self.window = self.windows[arg_6_1.type or IslandAwardDisplayPage.TYPE_COMMON]

	return
end

function IslandAwardDisplayPage:AnyWindowShowing()
	for iter_7_0, iter_7_1 in pairs(self.windows) do
		if iter_7_1:GetLoaded() and iter_7_1:isShowing() then
			return true
		end
	end

	return false
end

function IslandAwardDisplayPage:HideWindows()
	for iter_8_0, iter_8_1 in pairs(self.windows) do
		self:HideWindow(iter_8_1, iter_8_0)
	end

	return
end

function IslandAwardDisplayPage:HideWindow(arg_9_1, arg_9_2)
	if arg_9_1:GetLoaded() and arg_9_1:isShowing() then
		if arg_9_2 == IslandAwardDisplayPage.TYPE_COMMON then
			arg_9_1:Hide()
		else
			arg_9_1:Destroy()
			arg_9_1:Reset()
		end
	end

	return
end

function IslandAwardDisplayPage:Hide()
	IslandAwardDisplayPage.super.Hide(self)
	self:HideWindows()

	self.callback = nil

	return
end

function IslandAwardDisplayPage:OnDestroy()
	if self.windows[IslandAwardDisplayPage.TYPE_COMMON]:GetLoaded() and self.windows[IslandAwardDisplayPage.TYPE_COMMON]:isShowing() then
		self.windows[IslandAwardDisplayPage.TYPE_COMMON]:Destroy()
		window:Reset()
	end

	return
end

return IslandAwardDisplayPage
