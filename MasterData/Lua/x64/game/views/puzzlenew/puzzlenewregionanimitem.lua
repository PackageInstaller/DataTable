local PuzzleNewRegionAnimItem = class("PuzzleNewRegionAnimItem", ReduxView)

function PuzzleNewRegionAnimItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	SetActive(self.gameObject_, false)

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
end

function PuzzleNewRegionAnimItem:PlayAnim(arg_2_1)
	self.statusController_:SetSelectedIndex(2)
	SetActive(self.gameObject_, true)
	AnimatorTools.PlayAnimationWithCallback(self.animator_, "XH2ndHeroPublicize_regionItem", function()
		SetActive(self.gameObject_, false)

		if arg_2_1 then
			arg_2_1()
		end
	end)
	manager.audio:PlayEffect("minigame_activity_2_1", "minigame_activity_2_1_puzzle_reward", "")
end

return PuzzleNewRegionAnimItem
