local var_0_0 = class("IdolTraineeStageInfoPage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.ememyItem = {}

	arg_2_0:BindCfgUI(arg_2_0.changeCharaGo_, arg_2_0.ememyItem)
	arg_2_0:AddUIListener()

	arg_2_0.raceUIList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexRaceItem), arg_2_0.advanceRace_, EnterBattleRaceListItem)
	arg_2_0.styleUIList = IdolStyleTagItemList.New(arg_2_0.gameObject_)
	arg_2_0.stateController = arg_2_0.controller:GetController("state")
	arg_2_0.raceEmptyController = arg_2_0.controller:GetController("raceEmpty")
	arg_2_0.styleEmptyController = arg_2_0.controller:GetController("styleEmpty")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.headbtn, nil, function()
		JumpTools.OpenPageByJump("idolTraineeBattleComparePop", {
			userID = arg_3_0.curUserID_,
			friendType = arg_3_0.friendType
		})
	end)
end

function var_0_0.IndexRaceItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.raceData_[arg_5_1])
end

function var_0_0.IndexEnemyItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_0.enemyData[arg_6_1])
end

function var_0_0.ShowPage(arg_7_0, arg_7_1)
	return
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:RefreshUI()
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.pvpBattle_ = arg_10_0.params_.pvpBattle
	arg_10_0.stageID_ = arg_10_0.params_.stageID

	local var_10_0

	if arg_10_0.pvpBattle_ then
		arg_10_0.stageID_ = IdolTraineeData:GetCurPVPStage()
		var_10_0 = IdolTraineePvpBattleCfg[arg_10_0.stageID_]

		arg_10_0.stateController:SetSelectedState("pvp")
	elseif arg_10_0.params_.idolCompetition then
		arg_10_0.stageID_ = arg_10_0.params_.stageID
		var_10_0 = IdolTraineePvpBattleCfg[arg_10_0.stageID_]

		arg_10_0.stateController:SetSelectedState("pvp")
	else
		var_10_0 = IdolTraineePveBattleCfg[arg_10_0.stageID_]

		arg_10_0.stateController:SetSelectedState("pve")

		arg_10_0.friendType = IdolTraineeConst.friendType.npc
		arg_10_0.ememyItem.headIcon_.sprite = DormHeroTools.GetBackHomeHeadSprite(var_10_0.npc_id)
	end

	if var_10_0 then
		local var_10_1 = IdolStageSceneCfg[var_10_0.scene_id].stage_picture

		arg_10_0.scene_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.IdolStageIcon.path .. var_10_1)
		arg_10_0.bgmName_.text = IdolStageMusicCfg[var_10_0.bgm].music_name
		arg_10_0.descText_.text = var_10_0.stage_desc
		arg_10_0.raceData_ = var_10_0.race_id_list
		arg_10_0.styleData_ = {}

		for iter_10_0, iter_10_1 in ipairs(var_10_0.peculiarity_rate) do
			if iter_10_1 > 100 then
				table.insert(arg_10_0.styleData_, iter_10_0)
			end
		end

		arg_10_0.raceUIList_:StartScroll(#arg_10_0.raceData_)
		arg_10_0.styleUIList:SetData(arg_10_0.styleData_)
		arg_10_0.raceEmptyController:SetSelectedState(#arg_10_0.raceData_ == 0 and "true" or "false")
		arg_10_0.styleEmptyController:SetSelectedState(#arg_10_0.styleData_ == 0 and "true" or "false")
	end
end

function var_0_0.OnIdolPvpStageUpdateFromServer(arg_11_0)
	arg_11_0:RefreshUI()
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.raceUIList_ then
		arg_12_0.raceUIList_:Dispose()

		arg_12_0.raceUIList_ = nil
	end

	if arg_12_0.styleUIList then
		arg_12_0.styleUIList:Dispose()

		arg_12_0.styleUIList = nil
	end

	arg_12_0.gameObject_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
