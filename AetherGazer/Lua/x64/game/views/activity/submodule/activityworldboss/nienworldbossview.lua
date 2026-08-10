local var_0_0 = class("NianBeastBossView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/WorldBoss/EDream_WorldBoss"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.rewardItems = {}
	arg_4_0.commonItem = CommonItem.New(arg_4_0.m_coinItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_startBtn, nil, function()
		local var_6_0 = ActivityWorldBossData:GetStageId(arg_5_0.activity_id)

		arg_5_0:Go("/sectionSelectHero", {
			section = var_6_0,
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_WORLD_BOSS,
			activityID = arg_5_0.activity_id
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_shopBtn, nil, function()
		local var_7_0 = {
			32
		}
		local var_7_1, var_7_2 = ShopTools.IsShopOpen(var_7_0[1])

		if var_7_1 then
			JumpTools.GoToSystem("/shop", {
				shopId = var_7_0[1],
				showShops = var_7_0
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_7_2 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_7_2 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_skillBtn, nil, function()
		local var_8_0 = ActivityWorldBossCfg[arg_5_0.activity_id]

		JumpTools.OpenPageByJump("ActivityWorldBossSkill", {
			bossID = var_8_0.boss_id[1]
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_itemBtn, nil, function()
		arg_5_0.activity_id = ActivityConst.NIEN_WORLD_BOSS

		local var_9_0 = ActivityWorldBossCfg[arg_5_0.activity_id]

		ShowPopItem(POP_SOURCE_ITEM, {
			var_9_0.coin_id,
			1
		})
	end)
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_SPRING_FESTIVAL_MONSTER_DESCRIPE")
end

function var_0_0.OnEnter(arg_11_0)
	manager.ui:SetMainCamera("activityWorldBoss")

	arg_11_0.activity_id = ActivityConst.NIEN_WORLD_BOSS

	local var_11_0 = ActivityWorldBossCfg[arg_11_0.activity_id]

	ActivityWorldBossAction.QueryBossData(arg_11_0.activity_id)
	arg_11_0:RefreshUI()

	local var_11_1 = var_11_0.pre_story_id

	if var_11_1 and not manager.story:IsStoryPlayed(var_11_1) then
		manager.story:StartStoryById(var_11_1, function(arg_12_0)
			return
		end)
	end

	arg_11_0:RefrenTime()

	arg_11_0.timer = Timer.New(function()
		arg_11_0:RefrenTime()
	end, 1, -1)

	arg_11_0.timer:Start()
end

function var_0_0.OnExit(arg_14_0)
	manager.windowBar:HideBar()

	if arg_14_0.timer then
		arg_14_0.timer:Stop()

		arg_14_0.timer = nil
	end
end

function var_0_0.RefrenTime(arg_15_0)
	local var_15_0 = ActivityData:GetActivityData(arg_15_0.activity_id)

	if var_15_0 and var_15_0:IsActivitying() then
		arg_15_0.m_timeLab.text = manager.time:GetLostTimeStr(var_15_0.stopTime)
	else
		arg_15_0.m_timeLab.text = GetTips("TIME_OVER")
	end
end

function var_0_0.RefreshUI(arg_16_0)
	local var_16_0 = ActivityWorldBossCfg[arg_16_0.activity_id]
	local var_16_1 = ActivityWorldBossData:GetLeftHealthPoint(arg_16_0.activity_id)

	arg_16_0.m_healthSlider.value = var_16_1 / 1000

	local var_16_2 = var_16_0.boss_id[1]

	arg_16_0.m_bossName.text = GetMonsterName({
		var_16_2
	}) .. " " .. math.ceil(var_16_1 / 10) .. "%"

	local var_16_3 = #var_16_0.health_reward_list
	local var_16_4 = arg_16_0.m_rewardContent.rect.width

	for iter_16_0 = 1, var_16_3 do
		if not arg_16_0.rewardItems[iter_16_0] then
			local var_16_5 = Object.Instantiate(arg_16_0.m_rewardItem, arg_16_0.m_rewardContent)

			arg_16_0.rewardItems[iter_16_0] = NiewWorldBossRewardItem.New(var_16_5, var_16_4)
		end

		arg_16_0.rewardItems[iter_16_0]:SetData(arg_16_0.activity_id, iter_16_0)
		arg_16_0.rewardItems[iter_16_0]:SetActive(true)
	end

	for iter_16_1 = var_16_3 + 1, #arg_16_0.rewardItems do
		arg_16_0.rewardItems[iter_16_1]:SetActive(false)
	end

	arg_16_0.commonItem:RefreshData({
		number = 1,
		id = var_16_0.coin_id
	})
	arg_16_0.commonItem:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_16_0.coin_id)
	end)

	local var_16_6 = ActivityWorldBossData:GetMaxCoinNum(arg_16_0.activity_id)
	local var_16_7 = ActivityWorldBossData:GetCointCount(arg_16_0.activity_id)

	arg_16_0.m_coinMax.text = "/" .. var_16_6
	arg_16_0.m_coinCount.text = var_16_7

	local var_16_8 = ActivityWorldBossData:GetAffix(arg_16_0.activity_id)

	if var_16_8 then
		SetActive(arg_16_0.m_affixImg.gameObject, true)

		arg_16_0.m_affixDes.text = GetI18NText(getAffixDesc(var_16_8))
		arg_16_0.m_affixImg.sprite = getAffixSprite(var_16_8)
	else
		arg_16_0.m_affixDes.text = ""

		SetActive(arg_16_0.m_affixImg.gameObject, false)
	end
end

function var_0_0.Dispose(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.rewardItems) do
		iter_18_1:Dispose()
	end

	arg_18_0.rewardItems = {}

	arg_18_0.commonItem:Dispose()
	var_0_0.super.Dispose(arg_18_0)
end

function var_0_0.OnActivityWorldBossUpdate(arg_19_0)
	arg_19_0:RefreshUI()
end

return var_0_0
