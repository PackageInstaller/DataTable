local MainVoteEntranceBtnMellowAdapt = class("MainVoteEntranceBtnMellowAdapt", import(".MainCommonSpActBtnAdapt"))

function MainVoteEntranceBtnMellowAdapt:GetContainer()
	return self.root:Find("right")
end

function MainVoteEntranceBtnMellowAdapt:OnInit()
	setAnchoredPosition(self._tf, {
		x = 208,
		y = 209
	})

	return
end

function MainVoteEntranceBtnMellowAdapt:InShowTime()
	return false
end

return MainVoteEntranceBtnMellowAdapt
