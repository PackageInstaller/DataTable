local ALYAtelierCompositeRePage = class("ALYAtelierCompositeRePage", import("view.activity.CorePage.CoreActivityPage"))

function ALYAtelierCompositeRePage:OnInit()
	setText(self._tf:Find("bg/goBtn/Text"), i18n("yumia_atelier_tip24"))
	onButton(self, self._tf:Find("bg/goBtn"), function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.ATELIER_COMPOSITE, {
			activityID = 50043,
			versionIndex = 2
		})

		return
	end)

	return
end

return ALYAtelierCompositeRePage
