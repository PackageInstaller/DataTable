local TianqiongMedalAlbumView = class("TianqiongMedalAlbumView", import(".MedalAlbumTemplateView"))

TianqiongMedalAlbumView.GROUP_ID = 50295
TianqiongMedalAlbumView.MEDAL_COUNT = 8
TianqiongMedalAlbumView.HELP_TIPS = "help_tianqiongAlbum"
TianqiongMedalAlbumView.HELP_TIPS = "help_starLightAlbum"
TianqiongMedalAlbumView.ICON_SCALE = 1

function TianqiongMedalAlbumView:getUIName()
	return "MedalAlbumTianqiongPage"
end

function TianqiongMedalAlbumView:FindUI()
	local var_2_0 = self._tf:Find("Top")

	self.bg = self._tf:Find("mask")
	self.backBtn = var_2_0:Find("BackBtn")
	self.helpBtn = var_2_0:Find("InfoBtn")
	self.taskBtn = self._tf:Find("Desk/taskBtn")
	self.prevBtn = self._tf:Find("Desk/prevBtn")
	self.nextBtn = self._tf:Find("Desk/nextBtn")
	self.slots = {}

	for iter_2_0 = 1, self.MEDAL_COUNT do
		self.slots[iter_2_0] = {
			slot = self._tf:Find("Desk/Slot" .. iter_2_0),
			active = self._tf:Find("Desk/Slot" .. iter_2_0 .. "/active"),
			tips = self._tf:Find("Desk/Slot" .. iter_2_0 .. "/reddot"),
			click = self._tf:Find("Desk/Slot" .. iter_2_0 .. "/Click")
		}
	end

	self.medalLock = self._tf:Find("Desk/medal")
	self.trophyLock = self._tf:Find("Desk/trophy")
	self.medalDetailView = MedalDetailPanel.New(self._tf:Find("DetailView"), self)

	self.medalDetailView:SetIconScale(self.ICON_SCALE)

	self.medalTaskView = TianqiongMedalTaskPanel.New(self._tf:Find("TaskView"), self)

	return
end

return TianqiongMedalAlbumView
