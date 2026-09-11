local ChallengeRogueTeamBagBuffView = class("ChallengeRogueTeamBagBuffView", ReduxView)

function ChallengeRogueTeamBagBuffView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ChallengeRogueTeamBagBuffView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.buffList_ = LuaList.New(handler(self, self.IndexItem), self.buffUIList_, ChallengeRogueTeamBagBuffItem)
	self.progressBar_ = self.sliderBarGo_:GetComponent("SplineProgressBar")
	self.animator_.enabled = false
end

function ChallengeRogueTeamBagBuffView:RefreshUI()
	local var_3_0 = ChallengeRogueTeamData:UIGetMechanismValue()
	local var_3_1 = ChallengeRogueTeamTools.GetMaxMechanismValue()

	if var_3_1 < var_3_0 then
		var_3_0 = var_3_1
	end

	local var_3_2 = var_3_0 / var_3_1

	self.progressBar_:SetValue(var_3_0 / var_3_1)
	self:PlayEffectAnimator(var_3_2)

	self.buffDescText_.text = GetTips("CHALLENGE_ROGUE_TEAM_BUFF_DESC_" .. ChallengeRogueTeamData:GetCacheTemplateID())
	self.progressValueText_.text = var_3_0 .. "/" .. var_3_1
	self.buffDataList_ = ChallengeRogueTeamData:EffectItemGetDataList(ChallengeRogueTeamConst.ITEM_TYPE.MECHANISM)

	self.buffList_:StartScroll(#self.buffDataList_)
end

function ChallengeRogueTeamBagBuffView:PlayEffectAnimator(arg_4_1)
	arg_4_1 = (GameSetting.rogue_team_mechanism_offset_value.value[1] + (100 - GameSetting.rogue_team_mechanism_offset_value.value[1]) * arg_4_1) / 100

	self.animator_:Play("Schedule", 0, arg_4_1)
	self.animator_:Update(arg_4_1)
end

function ChallengeRogueTeamBagBuffView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1, self.buffDataList_[arg_5_1])
end

function ChallengeRogueTeamBagBuffView:Dispose()
	self.progressBar_ = nil

	ChallengeRogueTeamBagBuffView.super.Dispose(self)

	if self.buffList_ then
		self.buffList_:Dispose()

		self.buffList_ = nil
	end
end

function ChallengeRogueTeamBagBuffView:AddListeners()
	return
end

return ChallengeRogueTeamBagBuffView
