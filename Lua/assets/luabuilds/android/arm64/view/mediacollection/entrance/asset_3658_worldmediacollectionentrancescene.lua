local WorldMediaCollectionEntranceScene = class("WorldMediaCollectionEntranceScene", import("view.base.BaseUI"))

function WorldMediaCollectionEntranceScene:getUIName()
	return "WorldMediaCollectionEntranceUI"
end

function WorldMediaCollectionEntranceScene:init()
	self.recallBtn = self._tf:Find("Main/recall")
	self.recallBtn2 = self._tf:Find("Main/recall2")
	self.cryptolaliaBtn = self._tf:Find("Main/cryptolalia")
	self.archiveBtn = self._tf:Find("Main/archive")
	self.archiveLockTF = self.archiveBtn:Find("lock")
	self.recordBtn = self._tf:Find("Main/record")
	self.albumBtn = self._tf:Find("Main/album")

	setActive(self.albumBtn, not LOCK_ALBUM)

	local var_2_0 = self._tf:Find("Main/empty")

	SetCompomentEnabled(var_2_0, "Image", LOCK_ALBUM)
	setActive(var_2_0:Find("Image"), not LOCK_ALBUM)
	setActive(var_2_0:Find("Image1"), LOCK_ALBUM)

	self.optionBtn = self._tf:Find("Top/blur_panel/adapt/top/option")
	self.backBtn = self._tf:Find("Top/blur_panel/adapt/top/back_btn")

	setText(self._tf:Find("Main/empty/label"), i18n("cryptolalia_unopen"))
	setText(self._tf:Find("Main/empty1/label"), i18n("cryptolalia_unopen"))

	return
end

function WorldMediaCollectionEntranceScene:didEnter()
	onButton(self, self.optionBtn, function()
		self:emit(WorldMediaCollectionEntranceScene.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self.backBtn, function()
		self:emit(WorldMediaCollectionEntranceScene.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(self, self.recallBtn, function()
		self:emit(WorldMediaCollectionEntranceMediator.OPEN_RECALL)

		return
	end, SFX_PANEL)
	onButton(self, self.recallBtn2, function()
		self:emit(WorldMediaCollectionEntranceMediator.OPEN_NEWRECALL)

		return
	end, SFX_PANEL)
	onButton(self, self.cryptolaliaBtn, function()
		if LOCK_CRYPTOLALIA then
			pg.TipsMgr.GetInstance():ShowTips(i18n("word_comingSoon"))
		else
			self:emit(WorldMediaCollectionEntranceMediator.OPEN_CRYPTOLALIA)
		end

		return
	end, SFX_PANEL)

	local var_3_0 = pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "WorldMediator")

	setActive(self.archiveLockTF, not var_3_0)
	onButton(self, self.archiveBtn, function()
		if not var_3_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("no_open_system_tip", pg.open_systems_limited[19].name, pg.open_systems_limited[19].level))

			return
		end

		self:emit(WorldMediaCollectionEntranceMediator.OPEN_ARCHIVE)

		return
	end, SFX_PANEL)
	onButton(self, self.recordBtn, function()
		self:emit(WorldMediaCollectionEntranceMediator.OPEN_RECORD)

		return
	end, SFX_PANEL)
	onButton(self, self.albumBtn, function()
		self:emit(WorldMediaCollectionEntranceMediator.OPEN_ALBUM)

		return
	end, SFX_PANEL)

	return
end

function WorldMediaCollectionEntranceScene:willExit()
	return
end

return WorldMediaCollectionEntranceScene
