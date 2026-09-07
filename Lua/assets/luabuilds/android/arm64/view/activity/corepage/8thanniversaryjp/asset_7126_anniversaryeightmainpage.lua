local AnniversaryEightMainPage = class("AnniversaryEightMainPage", import("view.activity.CorePage.CoreActivityPage"))

function AnniversaryEightMainPage:OnInit()
	return
end

function AnniversaryEightMainPage:OnDataSetting()
	return
end

function AnniversaryEightMainPage:OnFirstFlush()
	onButton(self, findTF(self._tf, "AD/btn_act"), function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CITY_REBUILD_MAP)

		return
	end, SFX_PANEL)
	onButton(self, findTF(self._tf, "AD/btn_hotspring"), function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.EIGHTH_HOTSPRING)

		return
	end, SFX_PANEL)
	setText(findTF(self._tf, "AD/desc"), i18n("anniversary_eight_main_page_desc"))

	if CityRebuildBookLayer.ShouldShowTip() or CityRebuildTasksLayer.ShouldShowTip() then
		setActive(findTF(self._tf, "AD/btn_act/red"), true)
	else
		setActive(findTF(self._tf, "AD/btn_act/red"), false)
	end

	return
end

function AnniversaryEightMainPage:OnUpdateFlush()
	return
end

return AnniversaryEightMainPage
