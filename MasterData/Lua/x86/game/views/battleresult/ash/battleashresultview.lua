local BattleAshResultView = class("BattleAshResultView", ReduxView)

function BattleAshResultView:UIName()
	return "Widget/System/Activity_EkChuah/EkChuah_BattleUI/EkChuah_BattleWinUI"
end

function BattleAshResultView:UIParent()
	return manager.ui.uiMain.transform
end

function BattleAshResultView:Init()
	self:InitUI()
	self:AddListener()
end

function BattleAshResultView:InitUI()
	self:BindCfgUI()

	self.rewardList = LuaList.New(handler(self, self.IndexItem), self.rewardList_, CommonItemView)
	self.unlockController = self.unlockState_:GetController("state")
	self.emptyController = self.unlockState_:GetController("empty")
end

function BattleAshResultView:AddListener()
	self:AddBtnListener(self.nextBtn_, nil, function()
		self:OnNextStageClick()
	end)
	self:AddBtnListener(self.confirmBtn_, nil, function()
		self:OnConfirmClick()
	end)
end

function BattleAshResultView:IndexItem(arg_8_1, arg_8_2)
	local var_8_0 = clone(ItemTemplateData)

	var_8_0.id = self.rewardDatas[arg_8_1].id
	var_8_0.number = self.rewardDatas[arg_8_1].num

	if ItemCfg[self.rewardDatas[arg_8_1].id] and ItemConst.ITEM_TYPE.EQUIP == ItemCfg[self.rewardDatas[arg_8_1].id].type then
		if EquipCfg[self.rewardDatas[arg_8_1].id] then
			var_8_0.race = EquipCfg[self.rewardDatas[arg_8_1].id].race or 0
		end
	end

	function var_8_0:clickFun()
		ShowPopItemOnly(POP_OTHER_ITEM, {
			self.id,
			self.number
		})
	end

	arg_8_2:SetData(var_8_0)
end

function BattleAshResultView:OnEnter()
	self.stageData = self.params_.stageData
	self.stageId = self.stageData:GetStageId()
	self.stageType = self.stageData:GetType()
	self.isMultiple = self.params_.multiple ~= nil
	self.score = self.params_.score

	BattleInstance.hideBattlePanel()
	self:CheckUnlock()

	self.scroreTxt_.text = self.score
	self.scoreTitleTxt_.text = self.score
	self.timeTxt_.text = self:GetBattleTime()
	self.goalTxt_.text = AshShootStageCfg[AshSystemAction:GetLastBattleData().stageId].victory_goal_desc

	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(self.params_.rewardList) do
		table.insert(var_10_0, iter_10_1)
	end

	self.rewardDatas = sortReward((mergeReward((formatRewardCfgList(var_10_0)))))

	self.rewardList:StartScroll(#self.rewardDatas)
	self.emptyController:SetSelectedIndex(#self.rewardDatas == 0 and 1 or 0)

	local var_10_1 = AshSystemAction:GetLastBattleData().stageId

	if AshSystemData:FindNextSection(var_10_1) then
		SetActive(self.nextBtn_.gameObject, true)
	else
		SetActive(self.nextBtn_.gameObject, false)
	end

	local var_10_2 = 0

	for iter_10_2, iter_10_3 in ipairs(AshShootStageCfg.all) do
		if AshShootStageCfg[iter_10_3].stage_group == 4 then
			var_10_2 = iter_10_3

			break
		end
	end

	if var_10_1 ~= var_10_2 then
		SetActive(self.targetGo_, true)
	else
		SetActive(self.targetGo_, false)
	end
end

function BattleAshResultView:CheckUnlock()
	SetActive(self.unlockObj_, false)

	local var_11_0 = AshSystemData:GetHomologyRate()
	local var_11_1 = AshSystemData:GetCacheHomology()

	for iter_11_0, iter_11_1 in ipairs(AshShootUnlockItemCfg.all) do
		if var_11_1 < AshShootUnlockItemCfg[iter_11_1].unlock_num and AshShootUnlockItemCfg[iter_11_1].unlock_num <= var_11_0 then
			if AshShootUnlockItemCfg[iter_11_1].type == 1 then
				SetActive(self.unlockObj_, true)
				self.unlockController:SetSelectedState("state0")

				self.weaponName_.text = GetI18NText(AshShootWeaponCfg[AshShootUnlockItemCfg[iter_11_1].correlation_id].name)
				self.weaponIcon_.sprite = pureGetSpriteWithoutAtlas(AshShootWeaponCfg[AshShootUnlockItemCfg[iter_11_1].correlation_id].icon)

				break
			end

			if AshShootUnlockItemCfg[iter_11_1].type == 2 then
				SetActive(self.unlockObj_, true)

				if AshShootEffectCfg[AshShootUnlockItemCfg[iter_11_1].correlation_id].type == 2 then
					self.unlockController:SetSelectedState("state1")

					self.skillIcon_.sprite = pureGetSpriteWithoutAtlas(AshShootEffectCfg[AshShootUnlockItemCfg[iter_11_1].correlation_id].icon)
					self.skillName_.text = GetI18NText(AshShootEffectCfg[AshShootUnlockItemCfg[iter_11_1].correlation_id].name)

					break
				end

				self.unlockController:SetSelectedState("state2")

				self.itemIcon_.sprite = pureGetSpriteWithoutAtlas(AshShootEffectCfg[AshShootUnlockItemCfg[iter_11_1].correlation_id].icon)
				self.itemName_.text = GetI18NText(AshShootEffectCfg[AshShootUnlockItemCfg[iter_11_1].correlation_id].name)
			end

			break
		end
	end
end

function BattleAshResultView:GetBattleTime()
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function BattleAshResultView:OnConfirmClick()
	BattleInstance.QuitBattle(self.stageData)
end

function BattleAshResultView:OnNextStageClick()
	local var_14_0 = AshSystemAction:GetLastBattleData()
	local var_14_1 = AshSystemData:FindNextSection(var_14_0.stageId)

	if var_14_1 then
		local var_14_2 = {}
		local var_14_3 = {}

		for iter_14_0, iter_14_1 in ipairs((AshSystemData:GetPropList())) do
			if iter_14_1.unlockRate <= AshSystemData:GetHomologyRate() then
				table.insert(var_14_2, iter_14_1)
			end
		end

		for iter_14_2, iter_14_3 in ipairs((AshSystemData:GetWeaponList())) do
			if iter_14_3.unlockRate <= AshSystemData:GetHomologyRate() then
				table.insert(var_14_3, iter_14_3)
			end
		end

		local var_14_4 = {}

		if #var_14_0.skill == 0 then
			for iter_14_4, iter_14_5 in ipairs((AshSystemData:GetSkillList())) do
				if iter_14_5.unlockRate <= AshSystemData:GetHomologyRate() then
					table.insert(var_14_4, iter_14_5.id)

					break
				end
			end
		else
			var_14_4 = var_14_0.skill
		end

		AshSystemAction:LaunchBattle(var_14_1, var_14_4, var_14_2, var_14_3, false)
	else
		BattleInstance.QuitBattle(self.stageData)
	end
end

function BattleAshResultView:Dispose()
	self.rewardList:Dispose()

	self.rewardList = nil

	self.super.Dispose(self)
end

return BattleAshResultView
