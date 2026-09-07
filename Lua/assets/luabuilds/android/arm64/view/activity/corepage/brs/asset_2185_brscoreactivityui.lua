local BRSCoreActivityUI = class("BRSCoreActivityUI", import("view.activity.CorePage.CoreActivityMainScene"))

function BRSCoreActivityUI:getUIName()
	return "BRSCoreActivityUI"
end

function BRSCoreActivityUI:init(...)
	BRSCoreActivityUI.super.init(self, ...)
	setText(self._tf:Find("adapt/top/btn_home/text_tip/Text (Legacy)"), i18n("brs_main_tip"))

	self.huanyingmituzhe_lan = self._tf:Find("adapt/mark/huanyingmituzhe_lan")
	self.huanyingmituzhe_lv = self._tf:Find("adapt/mark/huanyingmituzhe_lv")

	return
end

function BRSCoreActivityUI:selectActivity(arg_3_1)
	BRSCoreActivityUI.super.selectActivity(self, arg_3_1)
	SetActive(self.huanyingmituzhe_lan, arg_3_1.id ~= 5984)
	SetActive(self.huanyingmituzhe_lv, arg_3_1.id == 5984)

	return
end

return BRSCoreActivityUI
