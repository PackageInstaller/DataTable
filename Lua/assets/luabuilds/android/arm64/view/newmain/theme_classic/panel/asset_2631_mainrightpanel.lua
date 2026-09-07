local MainRightPanel = class("MainRightPanel", import("...base.MainConcealablePanel"))

function MainRightPanel:GetBtns()
	return {
		MainMemoryBtn.New(findTF(self._tf, "memoryButton"), self.event),
		MainCollectionBtn.New(findTF(self._tf, "collectionButton"), self.event),
		MainRankBtn.New(findTF(self._tf, "rankButton"), self.event),
		MainFriendBtn.New(findTF(self._tf, "friendButton"), self.event),
		MainMailBtn.New(findTF(self._tf, "mailButton"), self.event),
		MainNoticeBtn.New(findTF(self._tf, "noticeButton"), self.event),
		MainSettingsBtn.New(findTF(self._tf, "settingButton"), self.event),
		MainFormationBtn.New(findTF(self._tf, "formationButton"), self.event),
		MainBattleBtn.New(findTF(self._tf, "combatBtn"), self.event)
	}
end

function MainRightPanel:GetDirection()
	return Vector2(1, 0)
end

return MainRightPanel
