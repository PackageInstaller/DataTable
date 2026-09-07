local YoumiyaStrongholdActPage = class("YoumiyaStrongholdActPage", import("view.activity.CorePage.CoreActivityPage"))

function YoumiyaStrongholdActPage:OnInit()
	onButton(self, self._tf:Find("panel/go_btn"), function()
		self:emit(ActivityMediator.OPEN_LAYER, Context.New({
			mediator = YoumiyaStrongholdMediator,
			viewComponent = YoumiyaStrongholdLayer
		}))

		return
	end, SFX_PANEL)
	setActive(self._tf:Find("panel/go_btn/tip"), YoumiyaStrongholdLayer.ShouldShowTip())

	for iter_1_0 = 1, 3 do
		setText(self._tf:Find("bg/" .. tostring(iter_1_0) .. "/name"), i18n("yumia_base_name_" .. iter_1_0))
	end

	setText(self._tf:Find("panel/go_btn/text"), i18n("yumia_stronghold_1"))

	return
end

return YoumiyaStrongholdActPage
