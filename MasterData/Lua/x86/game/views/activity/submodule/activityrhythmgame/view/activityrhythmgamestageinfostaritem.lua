local ActivityRhythmGameStageInfoStarItem = class("ActivityRhythmGameStageInfoStarItem", ReduxView)

function ActivityRhythmGameStageInfoStarItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.controllerStar_ = self.ndnum01Controllerexcollection_:GetController("star")
end

function ActivityRhythmGameStageInfoStarItem:Refresh(arg_2_1, arg_2_2)
	if arg_2_1 then
		self.controllerStar_:SetSelectedIndex(1)
	else
		self.controllerStar_:SetSelectedIndex(0)
	end

	if arg_2_2 then
		self.textmeettermsText_.text = BattleInstance.GetStarMissionText(arg_2_2[1], arg_2_2[2], arg_2_2[3])

		SetActive(self.gameObject_, true)
	else
		SetActive(self.gameObject_, false)
	end
end

return ActivityRhythmGameStageInfoStarItem
