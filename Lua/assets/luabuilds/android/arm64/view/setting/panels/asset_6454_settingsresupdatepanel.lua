local SettingsResUpdatePanel = class("SettingsResUpdatePanel", import(".SettingsBasePanel"))

function SettingsResUpdatePanel:GetUIName()
	return "SettingsResUpdate"
end

function SettingsResUpdatePanel:GetTitle()
	return i18n("Settings_title_resManage")
end

function SettingsResUpdatePanel:GetTitleEn()
	return "  / RESOURCES"
end

function SettingsResUpdatePanel:OnInit()
	self.tpl = self._tf:Find("Tpl")
	self.iconTF = self._tf:Find("Icon")
	self.fullTF = self._tf:Find("options_full")
	self.mainTF = self._tf:Find("options_main")
	self.fullTitleText = self._tf:Find("options_full/Title/Text")
	self.mainTitleText = self._tf:Find("options_main/Title/Text")
	self.specialTitleText = self._tf:Find("options_special/Title/Text")

	setText(self.fullTitleText, i18n("Settings_title_resManage_All"))
	setText(self.mainTitleText, i18n("Settings_title_resManage_Main"))
	setText(self.specialTitleText, i18n("Settings_title_resManage_Sub"))

	self.fullGroupTF = self._tf:Find("options_full/MainGroup")
	self.mainContainerTF = self._tf:Find("options_main/list")
	self.specialContainerTF = self._tf:Find("options_special/list")

	local var_4_0 = not GroupMainHelper.IsVerSameWithServer()

	setActive(self.fullTF, var_4_0)

	if var_4_0 then
		self.mainGroupBtn = SettingsMainGroupBtn.New(self.fullGroupTF)
		GetComponent(self.mainTF, typeof(VerticalLayoutGroup)).padding.top = 0
	else
		GetComponent(self.mainTF, typeof(VerticalLayoutGroup)).padding.top = GetComponent(self.fullTF, typeof(VerticalLayoutGroup)).padding.top
	end

	self.galleryBtn = SettingsGalleryBtn.New({
		isDel = true,
		tpl = self.tpl,
		container = self.specialContainerTF,
		iconSP = getImageSprite(self.iconTF:Find("GALLERY_PIC"))
	})
	self.mangaBtn = SettingsMangaBtn.New({
		isDel = true,
		tpl = self.tpl,
		container = self.specialContainerTF,
		iconSP = getImageSprite(self.iconTF:Find("MANGA"))
	})
	self.dormBtn = SettingsDormBtn.New({
		isDel = true,
		tpl = self.tpl,
		container = self.specialContainerTF,
		iconSP = getImageSprite(self.iconTF:Find("DORM"))
	})
	self.mapBtn = SettingsMapBtn.New({
		isDel = true,
		tpl = self.tpl,
		container = self.specialContainerTF,
		iconSP = getImageSprite(self.iconTF:Find("MAP"))
	})
	self.repairBtn = SettingsResRepairBtn.New({
		isDel = false,
		tpl = self.tpl,
		container = self.specialContainerTF,
		iconSP = getImageSprite(self.iconTF:Find("REPAIR"))
	})
	self.soundBtn = SettingsSoundBtn.New({
		tpl = self.tpl,
		container = self.mainContainerTF,
		iconSP = getImageSprite(self.iconTF:Find("CV"))
	})
	self.live2dBtn = SettingsLive2DBtn.New({
		tpl = self.tpl,
		container = self.mainContainerTF,
		iconSP = getImageSprite(self.iconTF:Find("L2D"))
	})
	self.musicBtn = SettingsMusicBtn.New({
		tpl = self.tpl,
		container = self.mainContainerTF,
		iconSP = getImageSprite(self.iconTF:Find("GALLERY_BGM"))
	})

	if LOCK_ISLAND_DISPLAY then
		setActive(self.mapBtn._tf, false)
	end

	return
end

function SettingsResUpdatePanel:Dispose()
	SettingsResUpdatePanel.super.Dispose(self)

	if self:IsLoaded() then
		self.repairBtn:Dispose()

		self.repairBtn = nil

		self.live2dBtn:Dispose()

		self.live2dBtn = nil

		self.galleryBtn:Dispose()

		self.galleryBtn = nil

		self.soundBtn:Dispose()

		self.soundBtn = nil

		self.musicBtn:Dispose()

		self.musicBtn = nil

		self.mangaBtn:Dispose()

		self.mangaBtn = nil

		self.dormBtn:Dispose()

		self.dormBtn = nil

		self.mapBtn:Dispose()

		self.mapBtn = nil

		if self.mainGroupBtn then
			self.mainGroupBtn:Dispose()

			self.mainGroupBtn = nil
		end
	end

	return
end

return SettingsResUpdatePanel
