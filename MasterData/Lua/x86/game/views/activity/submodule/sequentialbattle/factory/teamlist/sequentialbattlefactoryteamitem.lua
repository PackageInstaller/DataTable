local SequentialBattleFactoryTeamItem = class("SequentialBattleFactoryTeamItem", ReduxView)

function SequentialBattleFactoryTeamItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.heroItemList_ = {}

	for iter_1_0 = 1, 3 do
		self.heroItemList_[iter_1_0] = SequentialBattleFactoryTeamHero.New(self[string.format("heroGo%s_", iter_1_0)], iter_1_0)
	end

	self.buffItemList_ = {}
	self.bossController_ = ControllerUtil.GetController(self.transform_, "boss")
	self.buffController_ = ControllerUtil.GetController(self.transform_, "affix")
end

function SequentialBattleFactoryTeamItem:SetData(arg_2_1, arg_2_2)
	self.activityID_ = arg_2_1
	self.stageIndex_ = arg_2_2
	self.stageID_ = SequentialBattleChapterCfg[self.activityID_].stage_id[self.stageIndex_]

	local var_2_0 = ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, self.activityID_, self.stageIndex_, {
		stageType = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE,
		stageID = self.stageID_,
		activityID = self.activityID_
	})
	local var_2_1 = ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE_CACHE, self.activityID_, self.stageIndex_, {
		stageType = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE,
		stageID = self.stageID_,
		activityID = self.activityID_
	})

	if not self.sectionProxy_ then
		self.sectionProxy_ = SectionSelectHeroTools.GetProxy({
			stageType = ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE,
			stageID = self.stageID_
		}, var_2_0, HeroConst.HERO_DATA_TYPE.DEFAULT)
	else
		self.sectionProxy_:Init({
			stageType = ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE,
			stageID = self.stageID_
		}, var_2_0, HeroConst.HERO_DATA_TYPE.DEFAULT)
	end

	local var_2_2, var_2_3, var_2_4, var_2_5 = ReserveTools.GetHeroList(var_2_0)
	local var_2_6, var_2_7 = ReserveTools.GetMimirData(var_2_0)

	ReserveTools.SetTeam(var_2_1, var_2_2, var_2_5 or {}, ReserveTools.GetComboSkillID(var_2_0), var_2_6, var_2_7, (ReserveTools.GetCharChipBaseID(var_2_0)))
	SequentialBattleTools.ResetAllEnabledBuff(self.activityID_)

	local var_2_8 = ReserveTools.GetHeroList(var_2_0)

	for iter_2_0, iter_2_1 in ipairs(self.heroItemList_) do
		iter_2_1:SetData(var_2_0, var_2_1, arg_2_1, arg_2_2, var_2_8[iter_2_0])
	end

	self.titleText_.text = GetTips(string.format("TEAM_%s", arg_2_2))

	if SequentialBattleChapterCfg[arg_2_1].boss_list[arg_2_2] ~= 0 then
		self.bossController_:SetSelectedState("true")

		local var_2_9

		for iter_2_2, iter_2_3 in pairs(SequentialBattleChapterCfg[arg_2_1].boss_list[arg_2_2]) do
			var_2_9 = var_2_9 == nil and tostring(iter_2_3) or var_2_9 .. tostring(iter_2_3)
		end

		self.portraitImage_.sprite = pureGetSpriteWithoutAtlas(string.format("TextureConfig/MardukUI/boss/icon/%s", var_2_9))
	else
		self.bossController_:SetSelectedState("false")
	end

	self:RefreshBuffItem()
end

function SequentialBattleFactoryTeamItem:Dispose()
	SequentialBattleFactoryTeamItem.super.Dispose(self)

	for iter_3_0, iter_3_1 in ipairs(self.heroItemList_) do
		iter_3_1:Dispose()
	end

	self.heroItemList_ = nil

	for iter_3_2, iter_3_3 in ipairs(self.buffItemList_) do
		iter_3_3:Dispose()
	end

	self.buffItemList_ = nil
end

function SequentialBattleFactoryTeamItem:AddListeners()
	self:AddBtnListener(self.bossBtn_, nil, function()
		local var_5_0 = 0

		if SequentialBattleChapterCfg[self.activityID_].boss_list[self.stageIndex_] ~= 0 then
			for iter_5_0, iter_5_1 in ipairs(SequentialBattleChapterCfg[self.activityID_].boss_list) do
				if iter_5_1 ~= 0 then
					var_5_0 = var_5_0 + 1
				end

				if iter_5_0 == self.stageIndex_ then
					break
				end
			end
		else
			var_5_0 = 1
		end

		JumpTools.OpenPageByJump("sequentialBattleBossInfo", {
			activityID = self.activityID_,
			bossIndex = var_5_0
		})
	end)
	self:AddBtnListener(self.buffBtn_, nil, function()
		JumpTools.OpenPageByJump("sequentialBattleBuffInfo", {
			buffInfoActivityID = self.activityID_,
			stageID = SequentialBattleChapterCfg[self.activityID_].stage_id[self.stageIndex_]
		})
	end)
end

function SequentialBattleFactoryTeamItem:RefreshBuffItem()
	local var_7_0 = SequentialBattleTools.GetEnabledBuff(self.activityID_, self.stageIndex_)

	if #var_7_0 <= 0 then
		self.buffController_:SetSelectedState("off")
	else
		self.buffController_:SetSelectedState("on")

		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			self.buffItemList_[iter_7_0] = self.buffItemList_[iter_7_0] or SequentialBattleFactoryTeamBuff.New(self.buffItem_, self.buffParent_)

			self.buffItemList_[iter_7_0]:SetData(SequentialBattleBuffCfg[iter_7_1].affix_id)
		end

		for iter_7_2 = #var_7_0 + 1, #self.buffItemList_ do
			self.buffItemList_[iter_7_2]:Show(false)
		end
	end
end

return SequentialBattleFactoryTeamItem
