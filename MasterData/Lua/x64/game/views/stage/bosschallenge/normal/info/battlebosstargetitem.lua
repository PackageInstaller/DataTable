local BattleBossTargetItem = class("BattleBossTargetItem", SectionTargetItem)

function BattleBossTargetItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
end

function BattleBossTargetItem:Refresh(arg_2_1, arg_2_2)
	if arg_2_1 then
		SetActive(self.activeImage_, true)

		self.targetText_.color = Color(0.8392158, 0.8627452, 0.882353)
	else
		SetActive(self.activeImage_, false)

		self.targetText_.color = Color(0.63, 0.63, 0.63)
	end

	self.starCfg = arg_2_2

	if self.starCfg then
		self.targetText_.text = BattleInstance.GetStarMissionText(self.starCfg[1], self.starCfg[2], self.starCfg[3])

		SetActive(self.gameObject_, true)
	else
		SetActive(self.gameObject_, false)
	end
end

return BattleBossTargetItem
