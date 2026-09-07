local RyzaAtelierCompositeRePage = class("RyzaAtelierCompositeRePage", import("view.activity.CorePage.CoreActivityPage"))

function RyzaAtelierCompositeRePage:OnInit()
	onButton(self, self._tf:Find("adapt/helpBtn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("ryza_composite_help_tip")
		})

		return
	end)
	onButton(self, self._tf:Find("adapt/storeBtn"), function()
		local var_3_0 = {
			mediator = AtelierStoreBaseMediator,
			viewComponent = AtelierStoreBaseScene
		}
		local var_3_1 = {}

		var_3_1.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK)
		var_3_0.data = var_3_1

		addSubLayer(Context.New(var_3_0), (getProxy(ContextProxy):getCurrentContext():getContextByMediator(CoreActivityMainMediator)))

		return
	end)
	onButton(self, self._tf:Find("adapt/atelierBtn"), function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.ATELIER_COMPOSITE, {
			activityID = 50043,
			versionIndex = 1
		})

		return
	end)

	return
end

return RyzaAtelierCompositeRePage
