local ReversePacmanItemPopScene = class("ReversePacmanItemPopScene", import("view.base.BaseUI"))

function ReversePacmanItemPopScene:getUIName()
	return "ReversePacmanItemPopUI"
end

function ReversePacmanItemPopScene:init()
	onButton(self, self.uiBgBtn, function()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, self.uiCloseBtn, function()
		self:closeView()

		return
	end, SOUND_BACK)
	setText(self.uiOwnerTitleText, i18n("collect_page_got"))

	self.goItemList = {}

	return
end

function ReversePacmanItemPopScene:didEnter()
	self:BlurPanel(self._tf)

	local var_5_0 = Drop.New({
		type = self.contextData.dropType,
		id = self.contextData.dropID
	})

	updateDrop(self.uiItem, var_5_0)
	setText(self.uiNameText, var_5_0.cfg.name)
	setText(self.uiDescText, var_5_0.desc)
	setText(self.uiCntText, string.format("%s/%s", self.contextData.count, pg.activity_limit_item_guide[self.contextData.limitItemGuideID].count))

	for iter_5_0, iter_5_1 in ipairs(pg.activity_limit_item_guide[self.contextData.limitItemGuideID].link_params) do
		self.goItemList[iter_5_0] = self.goItemList[iter_5_0] or ReversePacmanItemPopItem.New(Object.Instantiate(self.uiGoItem, self.uiGoParent), self)

		self.goItemList[iter_5_0]:didEnter(iter_5_1)
	end

	for iter_5_2 = #pg.activity_limit_item_guide[self.contextData.limitItemGuideID].link_params + 1, #self.goItemList do
		self.goItemList[iter_5_2]:Show(false)
	end

	return
end

function ReversePacmanItemPopScene:willExit()
	self:UnOverlayPanel(self._tf)

	for iter_6_0, iter_6_1 in ipairs(self.goItemList) do
		iter_6_1:willExit()
	end

	self.goItemList = nil

	return
end

return ReversePacmanItemPopScene
