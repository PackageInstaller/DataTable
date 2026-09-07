local DreamTourMedalDetailPanel = class("DreamTourMedalDetailPanel", import("view.mediaCollection.album.MedalDetailPanel"))

function DreamTourMedalDetailPanel:InitUI()
	DreamTourMedalDetailPanel.super.InitUI(self)

	self._stateBg = findTF(self._tf, "state_bg")
	self._progressLockText = findTF(self._tf, "progress/lock/label")

	setText(self._progressLockText, i18n("word_lock"))

	return
end

function DreamTourMedalDetailPanel:UpdateMedal()
	DreamTourMedalDetailPanel.super.UpdateMedal(self)
	SetActive(self._stateBg, self._medalGroup:GetMedalGroupState() ~= ActivityMedalGroup.STATE_ACTIVE)

	return
end

return DreamTourMedalDetailPanel
