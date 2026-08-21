local var_0_0 = class("TeachSectionInfoView", SectionInfoBaseView)

function var_0_0.UpdateBar(arg_1_0)
	arg_1_0.stageID_ = arg_1_0.params_.section
	arg_1_0.stageType_ = arg_1_0.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
end

function var_0_0.OnUpdate(arg_2_0)
	if arg_2_0.stageID_ == arg_2_0.params_.section then
		return
	end

	arg_2_0.stageID_ = arg_2_0.params_.section
	arg_2_0.stageType_ = arg_2_0.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED

	arg_2_0:RefreshData()
	arg_2_0:RefreshUI()
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.battleBtn_, nil, function()
		arg_3_0:OnClickBtn()
	end)
	arg_3_0:AddBtnListener(arg_3_0.buttonWeb_, nil, function()
		local var_5_0 = arg_3_0.stageID_
		local var_5_1 = TeachStageExInfoCfg[var_5_0]

		if not SDKTools.IsSDK() then
			OperationAction.OpenNormalUrl(var_5_1.video_url)
		else
			LuaForUtil.OpenWebView(var_5_1.video_url, true, function()
				manager.audio:PauseAll(true)
				print("--->> open webView")
			end, function()
				print("====>>> close webView")
				manager.audio:PauseAll(false)
			end)
		end

		SDKTools.SendMessageToSDK("lecture_video", {
			channel_type = 2,
			videro_channel = arg_3_0.stageID_
		})
	end)
end

function var_0_0.RefreshUI(arg_8_0)
	var_0_0.super.RefreshUI(arg_8_0)
	arg_8_0:RefreshVideoUI()
	arg_8_0.hideFatigueController_:SetSelectedState("close")
end

function var_0_0.RefreshData(arg_9_0)
	local var_9_0 = arg_9_0.stageID_
	local var_9_1

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING == arg_9_0.stageType_ then
		var_9_1 = BattleBaseTeachStageCfg[var_9_0]
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING == arg_9_0.stageType_ then
		var_9_1 = BattleHeroTeachStageCfg[var_9_0]
	end

	arg_9_0.stageCfg_ = var_9_1
	arg_9_0.lock_ = false
	arg_9_0.lockTips_ = ""
	arg_9_0.cost_ = 0
	arg_9_0.isFirstClear_ = (BattleTeachData:GetStageData()[arg_9_0.stageID_] or 0) <= 0
	arg_9_0.dropLibID_ = arg_9_0.stageCfg_ and arg_9_0.stageCfg_.drop_lib_id or 0

	local var_9_2 = getChapterAndSectionID(var_9_0)

	BattleFieldData:SetCacheStage(var_9_2, var_9_0)
	arg_9_0.hideStageDescController_:SetSelectedState("false")
end

function var_0_0.RefreshVideoUI(arg_10_0)
	local var_10_0 = arg_10_0.stageID_
	local var_10_1 = TeachStageExInfoCfg[var_10_0]

	if SDKTools.GetIsOverSea() then
		arg_10_0.btnWebController_:SetSelectedState("notshow")
	elseif var_10_1 and var_10_1.video_url ~= "" and true or false then
		arg_10_0.btnWebController_:SetSelectedState("show")
	else
		arg_10_0.btnWebController_:SetSelectedState("notshow")
	end
end

function var_0_0.RefreshStageInfo(arg_11_0)
	local var_11_0 = BattleStageTools.GetStageCfg(arg_11_0.stageType_, arg_11_0.stageID_)

	if arg_11_0.oldCfgID_ ~= var_11_0.id then
		local var_11_1, var_11_2 = BattleStageTools.GetChapterSectionIndex(arg_11_0.stageType_, arg_11_0.stageID_)

		arg_11_0.sectionText_.text = string.format("%s-%s", GetI18NText(var_11_1), GetI18NText(var_11_2))
		arg_11_0.sectionName_.text = GetI18NText(var_11_0.name)
		arg_11_0.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, var_11_0.background_1))
		arg_11_0.oldCfgID_ = var_11_0.id
		arg_11_0.storyText_.text = GetI18NText(var_11_0.tips)
	end
end

function var_0_0.OnClickBtn(arg_12_0)
	local var_12_0 = arg_12_0.stageID_

	arg_12_0:Go("/sectionSelectHero", {
		section = var_12_0,
		sectionType = arg_12_0.stageType_
	})
end

return var_0_0
