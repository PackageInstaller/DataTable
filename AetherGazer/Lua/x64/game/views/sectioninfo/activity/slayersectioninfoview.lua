SectionInfoBaseView = import("game.views.sectionInfo.SectionInfoBaseView")

local var_0_0 = class("SlayerSectionInfoView", SectionInfoBaseView)

function var_0_0.InitUI(arg_1_0)
	var_0_0.super.InitUI(arg_1_0)
	SetActive(arg_1_0.tipsPanel_, true)

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "name")

	arg_1_0.controller_:SetSelectedState("slayer")

	if arg_1_0.readyTxt_ then
		arg_1_0.readyTxt_.text = GetTips("BATTLE_READY_1")
	end

	arg_1_0.slayerComs = {}

	ComponentBinder.GetInstance():BindCfgUI(arg_1_0.slayerComs, arg_1_0.slayerPanel_)

	arg_1_0.slayerBuffList = {}

	SetActive(arg_1_0.resourcePanel_, false)
end

function var_0_0.OnClickBtn(arg_2_0)
	local var_2_0 = arg_2_0.stageID_
	local var_2_1 = arg_2_0.params_.region_activity_id
	local var_2_2 = arg_2_0.params_.slayer_activity_id

	arg_2_0:Go("/sectionSelectHero", {
		section = var_2_0,
		sectionType = arg_2_0.stageType_,
		region_activity_id = var_2_1,
		activityID = var_2_2
	})
end

function var_0_0.RefreshData(arg_3_0)
	var_0_0.super.RefreshData(arg_3_0)

	local var_3_0 = BattleSlayerStageCfg[arg_3_0.stageID_]

	arg_3_0.lock_ = PlayerData:GetPlayerInfo().userLevel < var_3_0.level
	arg_3_0.lockTips_ = string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_3_0.level)
	arg_3_0.cost = 0
	arg_3_0.drop_lib_id = 0
	arg_3_0.isFirstClear_ = false
end

function var_0_0.RefreshStageInfo(arg_4_0)
	local var_4_0 = BattleSlayerStageCfg[arg_4_0.stageID_]

	if arg_4_0.oldCfgID_ ~= var_4_0.id then
		arg_4_0.sectionName_.text = GetI18NText(var_4_0.name)
		arg_4_0.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, var_4_0.background_1))
		arg_4_0.slayerComs.m_tips.text = GetI18NText(var_4_0.tips)
		arg_4_0.oldCfgID_ = var_4_0.id
	end

	local var_4_1 = arg_4_0.params_.region_activity_id
	local var_4_2 = arg_4_0.params_.slayer_activity_id
	local var_4_3 = ActivitySlayerCfg[var_4_1]

	arg_4_0.buffData = var_4_3 and var_4_3.buff_desc or {}

	local var_4_4 = #arg_4_0.buffData

	for iter_4_0 = 1, var_4_4 do
		if not arg_4_0.slayerBuffList[iter_4_0] then
			local var_4_5 = Object.Instantiate(arg_4_0.slayerComs.m_buffItem, arg_4_0.slayerComs.m_buffParent)

			arg_4_0.slayerBuffList[iter_4_0] = SlayerSectionItem.New(var_4_5)
		end

		local var_4_6 = arg_4_0.buffData[iter_4_0]

		arg_4_0.slayerBuffList[iter_4_0]:SetData(var_4_6)
		arg_4_0.slayerBuffList[iter_4_0]:SetActive(true)
	end

	for iter_4_1 = var_4_4 + 1, #arg_4_0.slayerBuffList do
		arg_4_0.slayerBuffList[iter_4_1]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_4_0.slayerComs.m_buffParent)

	local var_4_7 = SlayerData:GetPoint(var_4_2, var_4_1)

	arg_4_0.slayerComs.m_maxScore.text = var_4_7
	arg_4_0.slayerComs.m_scrollView.verticalNormalizedPosition = 1
end

function var_0_0.Dispose(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.slayerBuffList) do
		iter_5_1:Dispose()
	end

	arg_5_0.slayerBuffList = {}

	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
