local NieRAutomataCoreActivityUI = class("NieRAutomataCoreActivityUI", import("view.activity.CorePage.CoreAdaptActivityMainScene"))

function NieRAutomataCoreActivityUI:getUIName()
	return "NieRAutomataCoreActivityUI"
end

NieRAutomataCoreActivityUI.optionsPath = {
	"adapt/TopPage/top/btn_home"
}

function NieRAutomataCoreActivityUI:CustomInit()
	self.resTime = self._tf:Find("adapt/TopPage/top/time/Text")

	setActive(self.upper, true)
	onButton(self, self._tf:Find("adapt/shopbtn"), function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

		return
	end, SFX_PANEL)

	return
end

function NieRAutomataCoreActivityUI:GetButtonNameText(arg_4_1)
	return i18n((arg_4_1:getConfig("title_res_tag")))
end

function NieRAutomataCoreActivityUI:OnClickBtn(arg_5_1, arg_5_2)
	self:refreshTime((getProxy(ActivityProxy):getActivityById(arg_5_2)))

	return
end

function NieRAutomataCoreActivityUI:refreshTime(arg_6_1)
	local var_6_0 = arg_6_1.stopTime - pg.TimeMgr.GetInstance():GetServerTime()

	setText(self.resTime, i18n("nier_core_countdown", math.floor(var_6_0 / 0), math.floor(var_6_0 % 0 / 16)))

	return
end

function NieRAutomataCoreActivityUI:UpdateAdapt()
	NieRAutomataCoreActivityUI.super.UpdateAdapt(self)

	return
end

return NieRAutomataCoreActivityUI
