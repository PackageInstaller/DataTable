ChapterPlot19MapBaseLocation = import(".ChapterPlot19MapBaseLocation")

local var_0_0 = class("ChapterPlot19MapClue", ChapterPlot19MapBaseLocation)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.controller_ = arg_1_0.controllerEx_:GetController("clue")
	arg_1_0.onOpenClueInfoHandler_ = handler(arg_1_0, arg_1_0.OnOpenClueInfo)

	manager.notify:RegistListener(CHAPTER_GET_CLUE, arg_1_0.onOpenClueInfoHandler_)
end

function var_0_0.Dispose(arg_2_0)
	manager.notify:RemoveListener(CHAPTER_GET_CLUE, arg_2_0.onOpenClueInfoHandler_)

	arg_2_0.onOpenClueInfoHandler_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		if not ChapterTools.IsEnableLocation(arg_3_0.locationID_) then
			return
		end

		local var_4_0 = ChapterLocationCfg[arg_3_0.locationID_]

		if var_4_0.need_scan == 0 then
			BattleStageAction.ReadLoacationClue(arg_3_0.mapID_, arg_3_0.locationID_, var_4_0.clue[1])

			local var_4_1 = var_4_0.clue[1]

			JumpTools.OpenPageByJump("stageArchive", {
				isClue = true,
				archiveID = var_4_1
			})
		elseif var_4_0.type == BattleConst.LOCATION_TYPE.CLUE then
			if ChapterTools.IsReadClue(arg_3_0.mapID_, arg_3_0.locationID_) then
				local var_4_2 = BattleStageData:GetMapLocationData(arg_3_0.mapID_)[arg_3_0.locationID_] or var_4_0.clue[1]

				JumpTools.OpenPageByJump("stageArchive", {
					isClue = true,
					archiveID = var_4_2
				})

				return
			end

			BattleStageAction.GetClueLocation(arg_3_0.locationID_)
		elseif var_4_0.type == BattleConst.LOCATION_TYPE.BATTLE_CLUE then
			ChapterTools.DoReadyBattle(ChapterCfg[arg_3_0.chapterID_].type, var_4_0.sub_stage_list[1])
		end
	end)
end

function var_0_0.UpdateLocation(arg_5_0)
	var_0_0.super.UpdateLocation(arg_5_0)

	local var_5_0 = ChapterLocationCfg[arg_5_0.locationID_]

	if ChapterTools.IsReadClue(arg_5_0.mapID_, arg_5_0.locationID_) then
		arg_5_0.controller_:SetSelectedState("state2")
	elseif var_5_0.type == BattleConst.LOCATION_TYPE.CLUE then
		arg_5_0.controller_:SetSelectedState("state0")
	else
		arg_5_0.controller_:SetSelectedState("state1")
	end
end

function var_0_0.OnOpenClueInfo(arg_6_0, arg_6_1)
	if arg_6_1 ~= arg_6_0.locationID_ then
		return
	end

	arg_6_0:UpdateLocation()

	local var_6_0 = BattleStageData:GetMapLocationData(arg_6_0.mapID_)[arg_6_0.locationID_]

	JumpTools.OpenPageByJump("stageArchive", {
		archiveID = var_6_0
	})
end

function var_0_0.Show(arg_7_0, arg_7_1)
	var_0_0.super.Show(arg_7_0, arg_7_1)

	if arg_7_1 and arg_7_0.needRefreshAnimaor_ then
		arg_7_0.animator_:Play("verClue", -1, 0)
	end

	arg_7_0.needRefreshAnimaor_ = false
end

return var_0_0
