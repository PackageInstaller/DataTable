local ShadowCityMedalDetailPanel = class("ShadowCityMedalDetailPanel", import("view.mediaCollection.album.MedalDetailPanel"))

function ShadowCityMedalDetailPanel:InitUI()
	ShadowCityMedalDetailPanel.super.InitUI(self)

	self._stateBg = findTF(self._tf, "state_bg")
	self._progressText = findTF(self._tf, "progress/unlock/label")
	self._progressLockText = findTF(self._tf, "progress/lock/label")

	setText(self._progressLockText, i18n("word_lock"))

	return
end

function ShadowCityMedalDetailPanel:UpdateMedal()
	ShadowCityMedalDetailPanel.super.UpdateMedal(self)
	SetActive(self._stateBg, self._medalGroup:GetMedalGroupState() ~= ActivityMedalGroup.STATE_ACTIVE)

	local var_2_0 = findTF(self._tf, "progress/unlock")

	if var_2_0 then
		SetActive(var_2_0, self._medal.timeStamp)
	end

	return
end

return ShadowCityMedalDetailPanel
