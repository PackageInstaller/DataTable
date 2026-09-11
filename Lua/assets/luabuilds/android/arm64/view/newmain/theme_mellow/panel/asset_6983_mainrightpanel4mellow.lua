local MainRightPanel4Mellow = class("MainRightPanel4Mellow", import("...base.MainBasePanel"))

function MainRightPanel4Mellow:GetBtns()
	return {
		MainMemoryBtn.New(findTF(self._tf, "2/menor"), self.event),
		MainCollectionBtn.New(findTF(self._tf, "2/collection"), self.event),
		MainRankBtn4Mellow.New(findTF(self._tf, "2/rank"), self.event),
		MainFriendBtn.New(findTF(self._tf, "2/friend"), self.event),
		MainFormationBtn.New(findTF(self._tf, "1/formation"), self.event),
		MainBattleBtn.New(findTF(self._tf, "1/battle"), self.event)
	}
end

function MainRightPanel4Mellow:GetDirection()
	return Vector2(1, 0)
end

function MainRightPanel4Mellow:SetEffectVisible(arg_3_1)
	setActive(findTF(self._tf, "1/battle/FX"), arg_3_1)

	return
end

function MainRightPanel4Mellow:ShowOrHideBtnEffect(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(self.btns) do
		iter_4_1:ShowOrHideBtnEffect(arg_4_1)
	end

	return
end

return MainRightPanel4Mellow
