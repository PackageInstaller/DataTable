local var_0_0 = class("BattleAshResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_EkChuah/EkChuah_BattleUI/EkChuah_BattleWinUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.rewardList = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.rewardList_, CommonItemView)
	arg_4_0.unlockController = arg_4_0.unlockState_:GetController("state")
	arg_4_0.emptyController = arg_4_0.unlockState_:GetController("empty")
end

function var_0_0.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.nextBtn_, nil, function()
		arg_5_0:OnNextStageClick()
	end)
	arg_5_0:AddBtnListener(arg_5_0.confirmBtn_, nil, function()
		arg_5_0:OnConfirmClick()
	end)
end

function var_0_0.IndexItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.rewardDatas[arg_8_1]
	local var_8_1 = clone(ItemTemplateData)

	var_8_1.id = var_8_0.id
	var_8_1.number = var_8_0.num

	if ItemCfg[var_8_0.id] and ItemConst.ITEM_TYPE.EQUIP == ItemCfg[var_8_0.id].type then
		var_8_1.race = EquipCfg[var_8_0.id] and EquipCfg[var_8_0.id].race or 0
	end

	function var_8_1.clickFun(arg_9_0)
		ShowPopItemOnly(POP_OTHER_ITEM, {
			arg_9_0.id,
			arg_9_0.number
		})
	end

	arg_8_2:SetData(var_8_1)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.stageData = arg_10_0.params_.stageData
	arg_10_0.stageId = arg_10_0.stageData:GetStageId()
	arg_10_0.stageType = arg_10_0.stageData:GetType()
	arg_10_0.isMultiple = arg_10_0.params_.multiple ~= nil
	arg_10_0.score = arg_10_0.params_.score

	BattleInstance.hideBattlePanel()
	arg_10_0:CheckUnlock()

	arg_10_0.scroreTxt_.text = arg_10_0.score
	arg_10_0.scoreTitleTxt_.text = arg_10_0.score
	arg_10_0.timeTxt_.text = arg_10_0:GetBattleTime()

	local var_10_0 = AshSystemAction:GetLastBattleData()
	local var_10_1 = AshShootStageCfg[var_10_0.stageId]

	arg_10_0.goalTxt_.text = var_10_1.victory_goal_desc

	local var_10_2 = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0.params_.rewardList) do
		table.insert(var_10_2, iter_10_1)
	end

	local var_10_3 = formatRewardCfgList(var_10_2)
	local var_10_4 = mergeReward(var_10_3)

	arg_10_0.rewardDatas = sortReward(var_10_4)

	arg_10_0.rewardList:StartScroll(#arg_10_0.rewardDatas)
	arg_10_0.emptyController:SetSelectedIndex(#arg_10_0.rewardDatas == 0 and 1 or 0)

	local var_10_5 = AshSystemAction:GetLastBattleData().stageId

	if AshSystemData:FindNextSection(var_10_5) then
		SetActive(arg_10_0.nextBtn_.gameObject, true)
	else
		SetActive(arg_10_0.nextBtn_.gameObject, false)
	end

	local var_10_6 = 0

	for iter_10_2, iter_10_3 in ipairs(AshShootStageCfg.all) do
		if AshShootStageCfg[iter_10_3].stage_group == 4 then
			var_10_6 = iter_10_3

			break
		end
	end

	if var_10_5 ~= var_10_6 then
		SetActive(arg_10_0.targetGo_, true)
	else
		SetActive(arg_10_0.targetGo_, false)
	end
end

function var_0_0.CheckUnlock(arg_11_0)
	SetActive(arg_11_0.unlockObj_, false)

	local var_11_0 = AshSystemData:GetHomologyRate()
	local var_11_1 = AshSystemData:GetCacheHomology()

	for iter_11_0, iter_11_1 in ipairs(AshShootUnlockItemCfg.all) do
		local var_11_2 = AshShootUnlockItemCfg[iter_11_1]
		local var_11_3 = var_11_2.unlock_num

		if var_11_1 < var_11_3 and var_11_3 <= var_11_0 then
			if var_11_2.type == 1 then
				SetActive(arg_11_0.unlockObj_, true)

				local var_11_4 = AshShootWeaponCfg[var_11_2.correlation_id]

				arg_11_0.unlockController:SetSelectedState("state0")

				arg_11_0.weaponName_.text = GetI18NText(var_11_4.name)
				arg_11_0.weaponIcon_.sprite = pureGetSpriteWithoutAtlas(var_11_4.icon)

				break
			end

			if var_11_2.type == 2 then
				SetActive(arg_11_0.unlockObj_, true)

				local var_11_5 = AshShootEffectCfg[var_11_2.correlation_id]

				if var_11_5.type == 2 then
					arg_11_0.unlockController:SetSelectedState("state1")

					arg_11_0.skillIcon_.sprite = pureGetSpriteWithoutAtlas(var_11_5.icon)
					arg_11_0.skillName_.text = GetI18NText(var_11_5.name)

					break
				end

				arg_11_0.unlockController:SetSelectedState("state2")

				arg_11_0.itemIcon_.sprite = pureGetSpriteWithoutAtlas(var_11_5.icon)
				arg_11_0.itemName_.text = GetI18NText(var_11_5.name)
			end

			break
		end
	end
end

function var_0_0.GetBattleTime(arg_12_0)
	local var_12_0 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime

	return manager.time:DescCdTime2(var_12_0)
end

function var_0_0.OnConfirmClick(arg_13_0)
	BattleInstance.QuitBattle(arg_13_0.stageData)
end

function var_0_0.OnNextStageClick(arg_14_0)
	local var_14_0 = AshSystemAction:GetLastBattleData()
	local var_14_1 = var_14_0.stageId
	local var_14_2 = AshSystemData:FindNextSection(var_14_1)

	if var_14_2 then
		local var_14_3 = {}
		local var_14_4 = {}
		local var_14_5 = AshSystemData:GetPropList()

		for iter_14_0, iter_14_1 in ipairs(var_14_5) do
			if iter_14_1.unlockRate <= AshSystemData:GetHomologyRate() then
				table.insert(var_14_3, iter_14_1)
			end
		end

		local var_14_6 = AshSystemData:GetWeaponList()

		for iter_14_2, iter_14_3 in ipairs(var_14_6) do
			if iter_14_3.unlockRate <= AshSystemData:GetHomologyRate() then
				table.insert(var_14_4, iter_14_3)
			end
		end

		local var_14_7 = {}

		if #var_14_0.skill == 0 then
			local var_14_8 = AshSystemData:GetSkillList()

			for iter_14_4, iter_14_5 in ipairs(var_14_8) do
				if iter_14_5.unlockRate <= AshSystemData:GetHomologyRate() then
					table.insert(var_14_7, iter_14_5.id)

					break
				end
			end
		else
			var_14_7 = var_14_0.skill
		end

		AshSystemAction:LaunchBattle(var_14_2, var_14_7, var_14_3, var_14_4, false)
	else
		BattleInstance.QuitBattle(arg_14_0.stageData)
	end
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.rewardList:Dispose()

	arg_15_0.rewardList = nil

	arg_15_0.super.Dispose(arg_15_0)
end

return var_0_0
