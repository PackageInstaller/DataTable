local SequentialBattleFactoryTeamHero = class("SequentialBattleFactoryTeamHero", ReduxView)

function SequentialBattleFactoryTeamHero:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.heroIndex_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
end

function SequentialBattleFactoryTeamHero:SetData(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	self.activityID_ = arg_2_3
	self.stageIndex_ = arg_2_4
	self.heroID_ = arg_2_5
	self.reserveParams_ = arg_2_1
	self.cachedReserveParams_ = arg_2_2

	self:RefreshHero()
end

function SequentialBattleFactoryTeamHero:AddListeners()
	self:AddBtnListener(self.teamButton_, nil, function()
		local var_4_0

		if SequentialBattleData:GetCurrentFinishStageIndex(self.activityID_) >= self.stageIndex_ then
			ShowTips("SEQUENTIAL_BATTLE_CHANLLENGING")

			do return end

			var_4_0 = {}
		end

		var_4_0.section = SequentialBattleChapterCfg[self.activityID_].stage_id[self.stageIndex_]
		var_4_0.sectionType = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE
		var_4_0.activityID = self.activityID_
		var_4_0.reserveParams = self.cachedReserveParams_
		var_4_0.teamLength = #SequentialBattleChapterCfg[self.activityID_].stage_id
		var_4_0.teamID = self.stageIndex_

		self:Go("/sequentialBattleSectionSelectHero", var_4_0)
	end)
end

function SequentialBattleFactoryTeamHero:RefreshHero(arg_5_1)
	if self.heroID_ ~= 0 then
		self.icon_.sprite = HeroTools.GetHeadSprite(self.heroID_)

		self.controller_:SetSelectedState("true")
	else
		self.controller_:SetSelectedState("false")
	end
end

return SequentialBattleFactoryTeamHero
