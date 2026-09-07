local SVSalvageResult = class("SVSalvageResult", import("view.base.BaseSubView"))

SVSalvageResult.HideView = "SVSalvageResult.HideView"

function SVSalvageResult:getUIName()
	return "SVSalvageResult"
end

function SVSalvageResult:OnLoaded()
	return
end

function SVSalvageResult:OnInit()
	self.rtPanel = self._tf:Find("window/display_panel")

	setText(self.rtPanel:Find("info/Text"), i18n("world_catsearch_help_1"))
	setText(self.rtPanel:Find("info/items_btn/Text"), i18n("world_catsearch_help_2"))
	onButton(self, self.rtPanel:Find("info/items_btn"), function()
		self:emit(BaseUI.ON_DROP_LIST, {
			item2Row = true,
			itemList = _.map(pg.gameset.world_catsearchdrop_show.description, function(arg_5_0)
				return {
					type = arg_5_0[1],
					id = arg_5_0[2],
					count = arg_5_0[3]
				}
			end),
			content = i18n("world_catsearch_help_6")
		})

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("bg"), function()
		self:Hide()

		return
	end, SFX_CANCEL)

	self.btnBack = self._tf:Find("window/top/btnBack")

	onButton(self, self.btnBack, function()
		self:Hide()

		return
	end, SFX_CANCEL)

	self.btnCanel = self._tf:Find("window/button_container/custom_button_2")

	onButton(self, self.btnCanel, function()
		self:Hide()

		return
	end, SFX_CANCEL)

	self.btnHelp = self.rtPanel:Find("info/help")

	onButton(self, self.btnHelp, function()
		self:Hide()
		self:emit(WorldScene.SceneOp, "OpOpenLayer", Context.New({
			mediator = WorldHelpMediator,
			viewComponent = WorldHelpLayer,
			data = {
				titleId = 3,
				pageId = 10
			}
		}))

		return
	end, SFX_PANEL)

	self.btnConfirm = self._tf:Find("window/button_container/custom_button_1")

	onButton(self, self.btnConfirm, function()
		self:Hide()
		self:emit(WorldScene.SceneOp, "OpReqCatSalvage", self.fleetId)

		return
	end, SFX_CONFIRM)

	return
end

function SVSalvageResult:OnDestroy()
	return
end

function SVSalvageResult:Show()
	setActive(self._tf, true)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function SVSalvageResult:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	setActive(self._tf, false)

	return
end

function SVSalvageResult:Setup(arg_14_1)
	self.fleetId = arg_14_1

	return
end

return SVSalvageResult
