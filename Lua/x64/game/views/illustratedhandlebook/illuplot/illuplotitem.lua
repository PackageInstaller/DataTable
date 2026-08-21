local var_0_0 = class("IlluPlotItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.iconImg_.cacheLimit = 3
	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "conName")
	arg_3_0.lockController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "lock")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.info_ = arg_4_1
	arg_4_0.selType_ = arg_4_2

	table.sort(arg_4_0.info_.storyList)

	local var_4_0 = 0

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.info_.storyList) do
		if IllustratedData:GetPlotInfo()[iter_4_1] then
			var_4_0 = var_4_0 + 1
		elseif iter_4_1 == 101110501 and IllustratedData:GetPlotInfo()[101110401] then
			var_4_0 = var_4_0 + 1
		end
	end

	arg_4_0.unlockNum_ = var_4_0

	if var_4_0 == 0 then
		arg_4_0.controller_:SetSelectedState("0")
	else
		arg_4_0.controller_:SetSelectedState("1")

		if arg_4_2 == 1 then
			local var_4_1 = ChapterCfg[arg_4_1.chapterID]

			arg_4_0.nameText_.text = GetI18NText(ChapterClientCfg[var_4_1.clientID].name)

			local var_4_2 = arg_4_1.all
			local var_4_3 = var_4_0

			arg_4_0.reveiveText_.text = var_4_3 .. "/" .. var_4_2

			local var_4_4 = SpritePathCfg.CollectPlotSmall.path .. ChapterClientCfg[arg_4_1.chapterID].chapter_paint

			arg_4_0.iconImg_.spriteAsync = var_4_4

			local var_4_5 = arg_4_0.info_.chapterID

			if var_4_5 and ChapterClientCfg[var_4_5] then
				local var_4_6 = ChapterClientCfg[var_4_5].asset_pend_key

				if not manager.assetPend:CheckAssetPend(var_4_6) then
					arg_4_0.lockController_:SetSelectedState("assetpend")
				else
					arg_4_0.lockController_:SetSelectedState("false")
				end
			else
				arg_4_0.lockController_:SetSelectedState("false")
			end
		elseif arg_4_2 == 2 then
			local var_4_7 = CollectStoryCfg.get_id_list_by_activity[arg_4_1.chapterID][1]
			local var_4_8 = CollectStoryCfg[var_4_7].picture
			local var_4_9 = ActivityCfg[arg_4_1.chapterID].remark

			arg_4_0.nameText_.text = GetI18NText(var_4_9)

			local var_4_10 = arg_4_1.all

			arg_4_0.reveiveText_.text = var_4_0 .. "/" .. var_4_10

			local var_4_11 = SpritePathCfg.CollectPlotSmall.path .. var_4_8

			arg_4_0.iconImg_.spriteAsync = var_4_11

			arg_4_0.lockController_:SetSelectedState("false")
		elseif arg_4_2 == 3 then
			local var_4_12 = arg_4_0.info_.storyList[1]

			arg_4_0.nameText_.text = GetI18NText(StoryCfg[var_4_12].name)
			arg_4_0.reveiveText_.text = var_4_0 .. "/" .. arg_4_1.all

			local var_4_13 = SpritePathCfg.CollectPlotSmall.path .. CollectStoryCfg[var_4_12].picture

			arg_4_0.iconImg_.spriteAsync = var_4_13

			arg_4_0.lockController_:SetSelectedState("false")
		end
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.itemBtn_, nil, function()
		if arg_5_0.selType_ == 1 then
			local var_6_0 = arg_5_0.info_.chapterID

			if var_6_0 and ChapterClientCfg[var_6_0] then
				local var_6_1 = ChapterClientCfg[var_6_0].asset_pend_key

				if not manager.assetPend:CheckAssetPend(var_6_1) then
					manager.assetPend:ShowAssetPendMessageBox(var_6_1)

					return
				end
			end
		end

		if arg_5_0.unlockNum_ > 0 then
			JumpTools.OpenPageByJump("/illuPlotDetail", {
				storyList = arg_5_0.info_.storyList,
				chapterID = arg_5_0.info_.chapterID,
				selType = arg_5_0.selType_
			})
		elseif arg_5_0.selType_ == 1 then
			local var_6_2 = arg_5_0.info_.storyList[1]
			local var_6_3 = getStageViaStoryID(var_6_2)
			local var_6_4 = getChapterDifficulty(var_6_3)
			local var_6_5 = getChapterClientCfgByStageID(var_6_3).toggle
			local var_6_6, var_6_7 = BattleStageTools.GetChapterSectionIndex(var_6_5, var_6_3)
			local var_6_8 = string.format(GetTips("MISSION_PROGRESS_UNLOCK"), var_6_4, GetI18NText(var_6_6), GetI18NText(var_6_7))

			ShowTips(var_6_8)
		end
	end)
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
