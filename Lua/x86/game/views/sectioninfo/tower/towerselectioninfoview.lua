local var_0_0 = class("TowerSelectionInfoView", import("..SectionInfoBaseView"))

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)
	arg_1_0.hideStageDescController_:SetSelectedState("false")
	arg_1_0.hideDropPanelController_:SetSelectedState("false")
	arg_1_0.guildStateController_:SetSelectedState("hide")
	arg_1_0.hideFatigueController_:SetSelectedState("close")
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0.towerId_ = arg_2_0.params_.towerId
	arg_2_0.curId = arg_2_0.params_.curId
	arg_2_0.clickBackFunc_ = arg_2_0.params_.clickBackFunc
	arg_2_0.btnTips_ = arg_2_0.params_.btnTips

	arg_2_0:RefreshData()
	arg_2_0:RefreshUI()

	arg_2_0.stageType_ = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER

	arg_2_0:RefreshTitleDesc()
end

function var_0_0.OnUpdate(arg_3_0)
	if arg_3_0.towerId_ == arg_3_0.params_.towerId then
		return
	end

	arg_3_0.towerId_ = arg_3_0.params_.towerId
	arg_3_0.btnTips_ = arg_3_0.params_.btnTips

	arg_3_0:RefreshData()
	arg_3_0:RefreshUI()
end

function var_0_0.RefreshData(arg_4_0)
	arg_4_0.cfg_ = BattleTowerStageCfg[arg_4_0.towerId_]
	arg_4_0.lock_ = false
	arg_4_0.lockTips_ = ""
	arg_4_0.cost_ = 0
	arg_4_0.dropLibID_ = arg_4_0.cfg_.drop_lib_id
	arg_4_0.isFirstClear_ = arg_4_0.curId and arg_4_0.towerId_ >= arg_4_0.curId
end

function var_0_0.RefreshUI(arg_5_0)
	arg_5_0:RefreshReward()

	arg_5_0.sectionName_.text = GetI18NText(arg_5_0.cfg_.name)
	arg_5_0.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, arg_5_0.cfg_.background_1))
	arg_5_0.storyText_.text = GetI18NText(arg_5_0.cfg_.tips)
	arg_5_0.btnText_.text = arg_5_0.btnTips_
end

function var_0_0.OnClickBtn(arg_6_0)
	local var_6_0 = arg_6_0.towerId_

	if not arg_6_0.curId or var_6_0 <= arg_6_0.curId then
		local var_6_1 = PlayerData:GetPlayerInfo().userLevel
		local var_6_2 = BattleTowerStageCfg[var_6_0].level

		if var_6_2 <= var_6_1 then
			JumpTools.Back()
			arg_6_0:Go("/sectionSelectHero", {
				section = var_6_0,
				sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER
			})
		else
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_6_2))
		end
	else
		arg_6_0.clickBackFunc_()
	end
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
