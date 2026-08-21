local var_0_0 = class("SequentialBattleFactoryTeamItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.heroItemList_ = {}

	for iter_1_0 = 1, 3 do
		arg_1_0.heroItemList_[iter_1_0] = SequentialBattleFactoryTeamHero.New(arg_1_0[string.format("heroGo%s_", iter_1_0)], iter_1_0)
	end

	arg_1_0.buffItemList_ = {}
	arg_1_0.bossController_ = ControllerUtil.GetController(arg_1_0.transform_, "boss")
	arg_1_0.buffController_ = ControllerUtil.GetController(arg_1_0.transform_, "affix")
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.activityID_ = arg_2_1
	arg_2_0.stageIndex_ = arg_2_2
	arg_2_0.stageID_ = SequentialBattleChapterCfg[arg_2_0.activityID_].stage_id[arg_2_0.stageIndex_]

	local var_2_0 = ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, arg_2_0.activityID_, arg_2_0.stageIndex_, {
		stageType = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE,
		stageID = arg_2_0.stageID_,
		activityID = arg_2_0.activityID_
	})
	local var_2_1 = ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE_CACHE, arg_2_0.activityID_, arg_2_0.stageIndex_, {
		stageType = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE,
		stageID = arg_2_0.stageID_,
		activityID = arg_2_0.activityID_
	})

	if not arg_2_0.sectionProxy_ then
		arg_2_0.sectionProxy_ = SectionSelectHeroTools.GetProxy({
			stageType = ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE,
			stageID = arg_2_0.stageID_
		}, var_2_0, HeroConst.HERO_DATA_TYPE.DEFAULT)
	else
		arg_2_0.sectionProxy_:Init({
			stageType = ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE,
			stageID = arg_2_0.stageID_
		}, var_2_0, HeroConst.HERO_DATA_TYPE.DEFAULT)
	end

	local var_2_2, var_2_3, var_2_4, var_2_5 = ReserveTools.GetHeroList(var_2_0)
	local var_2_6, var_2_7 = ReserveTools.GetMimirData(var_2_0)
	local var_2_8 = ReserveTools.GetComboSkillID(var_2_0)
	local var_2_9 = ReserveTools.GetCharChipBaseID(var_2_0)

	ReserveTools.SetTeam(var_2_1, var_2_2, var_2_5 or {}, var_2_8, var_2_6, var_2_7, var_2_9)
	SequentialBattleTools.ResetAllEnabledBuff(arg_2_0.activityID_)

	local var_2_10 = ReserveTools.GetHeroList(var_2_0)

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.heroItemList_) do
		iter_2_1:SetData(var_2_0, var_2_1, arg_2_1, arg_2_2, var_2_10[iter_2_0])
	end

	arg_2_0.titleText_.text = GetTips(string.format("TEAM_%s", arg_2_2))

	local var_2_11 = SequentialBattleChapterCfg[arg_2_1]

	if var_2_11.boss_list[arg_2_2] ~= 0 then
		arg_2_0.bossController_:SetSelectedState("true")

		local var_2_12

		for iter_2_2, iter_2_3 in pairs(var_2_11.boss_list[arg_2_2]) do
			if var_2_12 == nil then
				var_2_12 = tostring(iter_2_3)
			else
				var_2_12 = var_2_12 .. tostring(iter_2_3)
			end
		end

		arg_2_0.portraitImage_.sprite = pureGetSpriteWithoutAtlas(string.format("TextureConfig/MardukUI/boss/icon/%s", var_2_12))
	else
		arg_2_0.bossController_:SetSelectedState("false")
	end

	arg_2_0:RefreshBuffItem()
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.heroItemList_) do
		iter_3_1:Dispose()
	end

	arg_3_0.heroItemList_ = nil

	for iter_3_2, iter_3_3 in ipairs(arg_3_0.buffItemList_) do
		iter_3_3:Dispose()
	end

	arg_3_0.buffItemList_ = nil
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.bossBtn_, nil, function()
		local var_5_0 = 0
		local var_5_1 = SequentialBattleChapterCfg[arg_4_0.activityID_].boss_list

		if var_5_1[arg_4_0.stageIndex_] ~= 0 then
			for iter_5_0, iter_5_1 in ipairs(var_5_1) do
				if iter_5_1 ~= 0 then
					var_5_0 = var_5_0 + 1
				end

				if iter_5_0 == arg_4_0.stageIndex_ then
					break
				end
			end
		else
			var_5_0 = 1
		end

		JumpTools.OpenPageByJump("sequentialBattleBossInfo", {
			activityID = arg_4_0.activityID_,
			bossIndex = var_5_0
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.buffBtn_, nil, function()
		local var_6_0 = SequentialBattleChapterCfg[arg_4_0.activityID_].stage_id[arg_4_0.stageIndex_]

		JumpTools.OpenPageByJump("sequentialBattleBuffInfo", {
			buffInfoActivityID = arg_4_0.activityID_,
			stageID = var_6_0
		})
	end)
end

function var_0_0.RefreshBuffItem(arg_7_0)
	local var_7_0 = SequentialBattleTools.GetEnabledBuff(arg_7_0.activityID_, arg_7_0.stageIndex_)

	if #var_7_0 <= 0 then
		arg_7_0.buffController_:SetSelectedState("off")
	else
		arg_7_0.buffController_:SetSelectedState("on")

		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			arg_7_0.buffItemList_[iter_7_0] = arg_7_0.buffItemList_[iter_7_0] or SequentialBattleFactoryTeamBuff.New(arg_7_0.buffItem_, arg_7_0.buffParent_)

			arg_7_0.buffItemList_[iter_7_0]:SetData(SequentialBattleBuffCfg[iter_7_1].affix_id)
		end

		for iter_7_2 = #var_7_0 + 1, #arg_7_0.buffItemList_ do
			arg_7_0.buffItemList_[iter_7_2]:Show(false)
		end
	end
end

return var_0_0
