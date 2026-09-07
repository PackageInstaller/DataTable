local MassenaMedalAlbumView = class("MassenaMedalAlbumView", import(".MedalAlbumTemplateView"))

MassenaMedalAlbumView.GROUP_ID = 50087
MassenaMedalAlbumView.MEDAL_COUNT = 8
MassenaMedalAlbumView.HELP_TIPS = "help_starLightAlbum"
MassenaMedalAlbumView.TASK_CLOSE_ANIM = "Anim_MedalAlbumMassenaPage_TaskView_Out"
MassenaMedalAlbumView.TASK_CLOSE_ANIM_Time = 0.12
MassenaMedalAlbumView.TASK_ANIM = "Anim_MedalAlbumMassenaPage_TaskView_TaskTpl_In"
MassenaMedalAlbumView.TASK_ENTER_ANIM_Time = 0.27
MassenaMedalAlbumView.TASK_Time = 0.08
MassenaMedalAlbumView.DETAIL_CLOSE_ANIM = "Anim_MedalAlbumMassenaPage_DetailView_Out"
MassenaMedalAlbumView.DETAIL_CLOSE_ANIM_Time = 0.1

function MassenaMedalAlbumView:getUIName()
	return "MedalAlbumMassenaPage"
end

function MassenaMedalAlbumView:didEnter()
	MassenaMedalAlbumView.super.didEnter(self)
	onButton(self, self.backBtn, function()
		quickPlayAnimation(self._tf, "Anim_MedalAlbumMassenaPage_Out")
		onDelayTick(function()
			self:closeView()

			return
		end, 0.1)

		return
	end, SFX_CANCEL)
	onButton(self, self.bg, function()
		quickPlayAnimation(self._tf, "Anim_MedalAlbumMassenaPage_Out")
		onDelayTick(function()
			self:closeView()

			return
		end, 0.1)

		return
	end, SFX_PANEL)

	return
end

return MassenaMedalAlbumView
