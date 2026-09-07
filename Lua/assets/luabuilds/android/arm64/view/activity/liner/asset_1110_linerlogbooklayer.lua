local LinerLogBookLayer = class("LinerLogBookLayer", import("view.base.BaseUI"))

LinerLogBookLayer.PAGE_SCHEDULE = 1
LinerLogBookLayer.PAGE_ROOM = 2
LinerLogBookLayer.PAGE_EVENT = 3

local var_0_1 = {
	"liner_log_schedule_title",
	"liner_log_room_title",
	"liner_log_event_title"
}
local var_0_2 = LinerLogBookLayer.PAGE_SCHEDULE

function LinerLogBookLayer:getUIName()
	return "LinerLogBookUI"
end

function LinerLogBookLayer:init()
	self.anim = self._tf:GetComponent(typeof(Animation))
	self.animEvent = self._tf:GetComponent(typeof(DftAniEvent))

	self.animEvent:SetEndEvent(function()
		self:emit(LinerLogBookLayer.ON_CLOSE)

		return
	end)

	self.togglesTF = self._tf:Find("frame/toggles")

	local var_2_0 = self._tf:Find("frame/pages")

	self.schedulePage = LinerLogSchedulePage.New(var_2_0, self)
	self.roomPage = LinerLogRoomPage.New(var_2_0, self)
	self.eventPage = LinerLogEventPage.New(var_2_0, self)
	self.pages = {
		[LinerLogBookLayer.PAGE_SCHEDULE] = self.schedulePage,
		[LinerLogBookLayer.PAGE_ROOM] = self.roomPage,
		[LinerLogBookLayer.PAGE_EVENT] = self.eventPage
	}
	self.reasoningPage = LinerReasoningPage.New(self._tf:Find("pages"), self)

	return
end

function LinerLogBookLayer:didEnter()
	onButton(self, self._tf:Find("frame/close"), function()
		self:onBackPressed()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("mask"), function()
		self:onBackPressed()

		return
	end, SFX_PANEL)
	eachChild(self.togglesTF, function(arg_7_0)
		setText(arg_7_0:Find("Text"), i18n(var_0_1[tonumber(arg_7_0.name)]))
		onButton(self, arg_7_0, function()
			local var_8_0 = tonumber(arg_7_0.name)

			if var_8_0 == LinerLogBookLayer.PAGE_EVENT and not LinerLogEventPage.IsUnlcok() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("liner_event_lock"))
			else
				if self.curPageIdx and self.curPageIdx == var_8_0 then
					return
				end

				self.curPageIdx = var_8_0

				self:SwitchPage()
				arg_7_0:SetAsLastSibling()
				self:UpdateToggles()
			end

			return
		end)

		return
	end)
	triggerButton(self._tf:Find(tostring(self.contextData.page or var_0_2), self.togglesTF), true)
	self:UpdateTips()

	return
end

function LinerLogBookLayer:UpdateToggles()
	setActive(self.togglesTF:Find("3/lock"), not LinerLogEventPage.IsUnlcok())
	eachChild(self.togglesTF, function(arg_10_0)
		setActive(arg_10_0:Find("selected"), tonumber(arg_10_0.name) == self.curPageIdx)

		return
	end)

	return
end

function LinerLogBookLayer:SwitchPage()
	for iter_11_0, iter_11_1 in pairs(self.pages) do
		if iter_11_0 == self.curPageIdx then
			iter_11_1:ExecuteAction("FlushPage")

			self.curPage = iter_11_1
		else
			iter_11_1:ExecuteAction("Hide")
		end
	end

	return
end

function LinerLogBookLayer:UpdateView()
	for iter_12_0, iter_12_1 in pairs(self.pages) do
		iter_12_1:ExecuteAction("UpdateActivity")
	end

	self.curPage:ExecuteAction("FlushPage")
	self:UpdateTips()

	return
end

function LinerLogBookLayer:UpdateTips()
	eachChild(self.togglesTF, function(arg_14_0)
		setActive(arg_14_0:Find("tip"), self.pages[tonumber(arg_14_0.name)].IsTip())

		return
	end)

	return
end

function LinerLogBookLayer:OnStartReasoning(arg_15_1, arg_15_2)
	self.reasoningPage:ExecuteAction("ShowOptions", arg_15_1, arg_15_2)

	return
end

function LinerLogBookLayer:onBackPressed()
	self.anim:Play("anim_liner_logbook_out")

	return
end

function LinerLogBookLayer:willExit()
	self.animEvent:SetEndEvent(nil)

	for iter_17_0, iter_17_1 in pairs(self.pages) do
		iter_17_1:Destroy()

		iter_17_1 = nil
	end

	self.reasoningPage:Destroy()

	self.reasoningPage = nil

	if self.contextData.onExit then
		self.contextData.onExit()

		self.contextData.onExit = nil
	end

	return
end

function LinerLogBookLayer.IsTip()
	return LinerLogSchedulePage.IsTip() or LinerLogRoomPage.IsTip() or LinerLogEventPage.IsTip()
end

return LinerLogBookLayer
