local var_0_0 = class("AffixSelectDetailView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/DarkFlameUI/DFQualsDrilUI/DFQualsDrillDetailsUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.bossIndexController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "bossIndex")
	arg_5_0.items_ = {}
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.checkBtn_, nil, function()
		JumpTools.OpenPageByJump("affixSelectBossInfo", {
			bossIDList = arg_6_0.cfg_.boss_id,
			index = arg_6_0.params_.index
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.challengeBtn_, nil, function()
		gameContext:Go("/sectionSelectHero", {
			section = arg_6_0.cfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.AFFIX_SELECT,
			activityID = arg_6_0.params_.activityId
		})
	end)
end

function var_0_0.AddEventListeners(arg_9_0)
	return
end

function var_0_0.OnTop(arg_10_0)
	arg_10_0:UpdateBar()
end

function var_0_0.OnBehind(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0:AddEventListeners()

	arg_13_0.affixDic_ = {}
	arg_13_0.cfg_ = ActivityAffixSelectCfg[arg_13_0.params_.activityId]
	arg_13_0.affixIdList_ = arg_13_0.cfg_.pool
	arg_13_0.data_ = ActivityAffixSelectData:GetSubActivityData(arg_13_0.params_.activityId)
	arg_13_0.selectedAffixList_ = arg_13_0.data_.affixList

	arg_13_0:UpdateAffixDic()
	arg_13_0:UpdateView()
	arg_13_0:UpdateGainScore()

	local var_13_0 = getData("affixSelect", "scrollPos" .. arg_13_0.params_.activityId)

	if var_13_0 then
		arg_13_0.itemScrollRect_.verticalNormalizedPosition = var_13_0
	else
		arg_13_0.itemScrollRect_.verticalNormalizedPosition = 1
	end
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0:RemoveAllEventListener()
	ActivityAffixSelectAction.SetAffixList(arg_14_0.params_.activityId, arg_14_0.selectedAffixList_)
	saveData("affixSelect", "scrollPos" .. arg_14_0.params_.activityId, arg_14_0.itemScrollRect_.verticalNormalizedPosition)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateView(arg_15_0)
	arg_15_0.bossIndexController_:SetSelectedState(tostring(arg_15_0.params_.index))

	local var_15_0 = arg_15_0.cfg_.boss_id[1]

	arg_15_0.bossIcon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. var_15_0)
	arg_15_0.highestScoreLabel_.text = arg_15_0.data_.point

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.affixIdList_) do
		if not arg_15_0.items_[iter_15_0] then
			local var_15_1 = Object.Instantiate(arg_15_0.itemPrefab_, arg_15_0.itemContainer_)

			arg_15_0.items_[iter_15_0] = AffixSelectAffixItemView.New(var_15_1, handler(arg_15_0, arg_15_0.OnItemSelect))
		end

		local var_15_2 = table.indexof(arg_15_0.selectedAffixList_, iter_15_1)
		local var_15_3 = false

		if var_15_2 then
			var_15_3 = true
		end

		arg_15_0.items_[iter_15_0]:SetData(iter_15_0, iter_15_1, var_15_3)
	end

	while #arg_15_0.items_ > #arg_15_0.affixIdList_ do
		arg_15_0.items_[#arg_15_0.items_]:Dispose()

		arg_15_0.items_[#arg_15_0.items_] = nil
	end

	arg_15_0.enemyAffixLabel_.text = GetI18NText(getAffixDesc(arg_15_0.cfg_.boss_affix))
	arg_15_0.enemyAffixIcon_.sprite = getAffixSprite(arg_15_0.cfg_.boss_affix)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_0.itemContainer_)
end

function var_0_0.OnItemSelect(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = table.indexof(arg_16_0.selectedAffixList_, arg_16_1)

	if arg_16_2 then
		local var_16_1 = ActivityAffixPoolCfg[arg_16_1].affix[1]
		local var_16_2

		if arg_16_0.affixDic_[var_16_1] ~= nil then
			var_16_2 = arg_16_0.affixDic_[var_16_1]
		end

		arg_16_0.affixDic_[var_16_1] = arg_16_1

		if not var_16_0 then
			table.insert(arg_16_0.selectedAffixList_, arg_16_1)
		end

		if var_16_2 ~= nil then
			local var_16_3 = table.indexof(arg_16_0.selectedAffixList_, var_16_2)

			if var_16_3 then
				table.remove(arg_16_0.selectedAffixList_, var_16_3)
			end
		end
	else
		local var_16_4 = ActivityAffixPoolCfg[arg_16_1].affix[1]

		arg_16_0.affixDic_[var_16_4] = nil

		if var_16_0 then
			table.remove(arg_16_0.selectedAffixList_, var_16_0)
		end
	end

	arg_16_0:UpdateSelect()
	arg_16_0:UpdateGainScore()
end

function var_0_0.UpdateAffixDic(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.selectedAffixList_) do
		local var_17_0 = ActivityAffixPoolCfg[iter_17_1].affix[1]

		arg_17_0.affixDic_[var_17_0] = iter_17_1
	end
end

function var_0_0.UpdateSelect(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.items_) do
		local var_18_0 = arg_18_0.affixIdList_[iter_18_0]
		local var_18_1 = table.indexof(arg_18_0.selectedAffixList_, var_18_0)
		local var_18_2 = false

		if var_18_1 then
			var_18_2 = true
		end

		iter_18_1:SetSelect(var_18_2)
	end
end

function var_0_0.UpdateGainScore(arg_19_0)
	local var_19_0 = arg_19_0.cfg_.base_point

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.selectedAffixList_) do
		var_19_0 = var_19_0 + ActivityAffixPoolCfg[iter_19_1].point
	end

	arg_19_0.scoreLabel_.text = var_19_0
end

function var_0_0.OnMainHomeViewTop(arg_20_0)
	return
end

function var_0_0.Dispose(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0.items_) do
		iter_21_1:Dispose()
	end

	arg_21_0.items_ = {}

	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
