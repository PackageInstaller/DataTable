local AnniversaryIslandAwardLayer = class("AnniversaryIslandAwardLayer", import("view.base.BaseUI"))

function AnniversaryIslandAwardLayer:getUIName()
	return "AnniversaryIslandAwardUI"
end

function AnniversaryIslandAwardLayer:init()
	self.window = self._tf:Find("Window")

	setText(self.window:Find("Text"), i18n("expedition_award_tip"))

	self.loader = AutoLoader.New()

	return
end

function AnniversaryIslandAwardLayer:didEnter()
	onButton(self, self.window:Find("Receive"), function()
		self:onBackPressed()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("BG"), function()
		self:onBackPressed()

		return
	end)

	self.awards = _.select(self.contextData.items or {}, function(arg_6_0)
		return arg_6_0.type ~= DROP_TYPE_ICON_FRAME and arg_6_0.type ~= DROP_TYPE_CHAT_FRAME and arg_6_0.type ~= DROP_TYPE_LIVINGAREA_COVER
	end)

	local var_3_0 = UIItemList

	UIItemList.StaticAlign(self.window:Find("Materials"), self.window:Find("Materials"):GetChild(0), #self.awards, function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 ~= var_3_0.EventUpdate then
			return
		end

		local var_7_0 = self.awards[arg_7_1 + 1]

		AnniversaryIslandComposite2023Scene.UpdateActivityDrop(self, arg_7_2:Find("Icon"), self.awards[arg_7_1 + 1])
		onButton(self, arg_7_2:Find("Icon"), function()
			self:emit(AnniversaryIslandAwardLayer.ON_DROP, var_7_0)

			return
		end)
		setText(arg_7_2:Find("Text"), var_7_0.count)

		return
	end)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function AnniversaryIslandAwardLayer:willExit()
	self.loader:Clear()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return AnniversaryIslandAwardLayer
