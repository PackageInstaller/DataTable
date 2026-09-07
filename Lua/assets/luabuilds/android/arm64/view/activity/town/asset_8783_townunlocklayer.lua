local TownUnlockLayer = class("TownUnlockLayer", import("view.base.BaseUI"))

TownUnlockLayer.TYPE = {
	LEVEL = 2,
	NEW = 1
}

function TownUnlockLayer:getUIName()
	return "TownUnlockUI"
end

function TownUnlockLayer:init()
	self.uiList = UIItemList.New(self._tf:Find("frame/content"), self._tf:Find("frame/content/tpl"))

	self.uiList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			local var_3_0 = self.unlockInfos[arg_3_1 + 1].type

			setImageSprite(arg_3_2:Find("icon"), GetSpriteFromAtlas("ui/townui_atlas", pg.activity_town_work_level[self.unlockInfos[arg_3_1 + 1].id].pic), true)
			setActive(arg_3_2:Find("new"), var_3_0 == TownUnlockLayer.TYPE.NEW)
			setText(arg_3_2:Find("tip/Text"), var_3_0 == TownUnlockLayer.TYPE.NEW and i18n("town_unlcok_new") or i18n("town_unlcok_level"))
		end

		return
	end)

	return
end

function TownUnlockLayer:didEnter()
	onButton(self, self._tf, function()
		self:onBackPressed()

		return
	end, SFX_PANEL)

	self.unlockInfos = {}

	underscore.each(self.contextData.newIds, function(arg_6_0)
		table.insert(self.unlockInfos, {
			type = TownUnlockLayer.TYPE.NEW,
			id = arg_6_0
		})

		return
	end)
	underscore.each(self.contextData.limitIds, function(arg_7_0)
		table.insert(self.unlockInfos, {
			type = TownUnlockLayer.TYPE.LEVEL,
			id = arg_7_0
		})

		return
	end)
	self.uiList:align(#self.unlockInfos)

	return
end

function TownUnlockLayer:willExit()
	if self.contextData.removeFunc then
		self.contextData.removeFunc()

		self.contextData.removeFunc = nil
	end

	return
end

return TownUnlockLayer
