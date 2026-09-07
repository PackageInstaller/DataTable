local MallSiteBox = class("MallSiteBox", import("view.base.BaseSubView"))

function MallSiteBox:getUIName()
	return "MallSiteBox"
end

function MallSiteBox:OnLoaded()
	return
end

function MallSiteBox:OnInit()
	onButton(self, self.uiCloseBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function MallSiteBox:Show(arg_5_1)
	MallSiteBox.super.Show(self)
	setText(self.uiNameText, pg.activity_mall_story[arg_5_1].name)
	setText(self.uiDescText, pg.activity_mall_story[arg_5_1].desc)
	setImageSprite(self.uiIconImage, LoadSprite("ui/mallstorylineui_atlas", pg.activity_mall_story[arg_5_1].icon .. "_l"), true)

	return
end

function MallSiteBox:OnDestroy()
	return
end

return MallSiteBox
