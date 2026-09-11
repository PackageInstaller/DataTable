local ChallengeRogueTeamBagBuffItem = class("ChallengeRogueTeamBagBuffItem", ReduxView)

function ChallengeRogueTeamBagBuffItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.timeController_ = self.controller_:GetController("time")
	self.leftTimesController_ = self.controller_:GetController("leftTimes")
end

function ChallengeRogueTeamBagBuffItem:Dispose()
	ChallengeRogueTeamBagBuffItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ChallengeRogueTeamBagBuffItem:SetData(arg_3_1, arg_3_2)
	self.index_ = arg_3_1
	self.data_ = arg_3_2
	self.cfg_ = RogueTeamItemCfg[arg_3_2.id]
	self.nameText_.text = self.cfg_.name
	self.descText_.text = ChallengeRogueTeamTools.GetItemEffectDesc(arg_3_2.id)
	self.effectData = ChallengeRogueTeamData:GetEffectDataByEffectID(self.data_.effectList[1])

	self.timeController_:SetSelectedState(tostring(self.effectData.triggerCd and self.effectData.triggerCd ~= 0))

	self.timeText_.text = self.effectData.triggerCd

	self.leftTimesController_:SetSelectedState(tostring(self.effectData.leftTime and self.effectData.leftTime ~= 9999))

	self.leftTimesText_.text = self.effectData.leftTime
	self.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_3_2.id))
end

return ChallengeRogueTeamBagBuffItem
