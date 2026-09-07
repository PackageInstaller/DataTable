local DALCoreActivityUI = class("DALCoreActivityUI", import("view.activity.CorePage.SailingShip3.SailingShip3CoreActivityUI"))

DALCoreActivityUI.finishtime = 50245

function DALCoreActivityUI:getUIName()
	return "DALCoreActivityUI"
end

function DALCoreActivityUI:loadingQueue()
	return
end

function DALCoreActivityUI:init(...)
	DALCoreActivityUI.super.init(self, ...)
	self:OnSetTime()

	return
end

function DALCoreActivityUI:didEnter()
	DALCoreActivityUI.super.didEnter(self)

	if not self.contextData.activeScenario then
		self._tf:GetComponent(typeof(Animation)).enabled = true
	end

	onButton(self, self.btnBack, function()
		if self.pageDic[self.activity.id]:IsShowingPopWindow() then
			self.pageDic[self.activity.id]:ClosePopWindow()
		else
			self:emit(DALCoreActivityUI.ON_BACK)
		end

		return
	end, SOUND_BACK)

	return
end

function DALCoreActivityUI:ONToggleName(arg_6_1, arg_6_2)
	setText(arg_6_1:Find("on/name"), i18n("dal_main_sheet" .. arg_6_2:getConfig("is_show")))
	setText(arg_6_1:Find("off/name"), i18n("dal_main_sheet" .. arg_6_2:getConfig("is_show")))
	setText(arg_6_1:Find("on/name_1"), i18n("dal_main_sheet" .. arg_6_2:getConfig("is_show") .. "_en"))
	setText(arg_6_1:Find("off/name_1"), i18n("dal_main_sheet" .. arg_6_2:getConfig("is_show") .. "_en"))

	return
end

function DALCoreActivityUI:selectActivity(arg_7_1)
	DALCoreActivityUI.super.selectActivity(self, arg_7_1)
	SetActive(self._tf:Find("adapt/Main"), arg_7_1.id == 50241)
	SetActive(self._tf:Find("adapt/tab_bg"), arg_7_1.id ~= 50253)
	SetActive(self._tf:Find("adapt/Favorability_tan_bg"), arg_7_1.id == 50253)

	return
end

function DALCoreActivityUI:OnplayAnimation(arg_8_1)
	return
end

function DALCoreActivityUI:OnSetTime()
	setText(self._tf:Find("adapt/top/btn_home/text_tip/timetext"), i18n("activity_remain_time"))
	setText(self._tf:Find("adapt/top/btn_home/text_tip/time"), math.floor((getProxy(ActivityProxy):getActivityById(self.finishtime).stopTime - pg.TimeMgr.GetInstance():GetServerTime()) / 0) .. i18n("word_date"))

	return
end

return DALCoreActivityUI
