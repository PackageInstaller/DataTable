local NianBeastBossView = class("NianBeastBossView", ReduxView)

function NianBeastBossView:UIName()
	return "UI/EmptyDream/WorldBoss/EDream_WorldBoss"
end

function NianBeastBossView:UIParent()
	return manager.ui.uiMain.transform
end

function NianBeastBossView:Init()
	self:InitUI()
	self:AddUIListener()
end

function NianBeastBossView:InitUI()
	self:BindCfgUI()

	self.rewardItems = {}
	self.commonItem = CommonItem.New(self.m_coinItem)
end

function NianBeastBossView:AddUIListener()
	self:AddBtnListener(self.m_startBtn, nil, function()
		self:Go("/sectionSelectHero", {
			section = ActivityWorldBossData:GetStageId(self.activity_id),
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_WORLD_BOSS,
			activityID = self.activity_id
		})
	end)
	self:AddBtnListener(self.m_shopBtn, nil, function()
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
	self:AddBtnListener(self.m_skillBtn, nil, function()
		JumpTools.OpenPageByJump("ActivityWorldBossSkill", {
			bossID = ActivityWorldBossCfg[self.activity_id].boss_id[1]
		})
	end)
	self:AddBtnListener(self.m_itemBtn, nil, function()
		self.activity_id = ActivityConst.NIEN_WORLD_BOSS

		ShowPopItem(POP_SOURCE_ITEM, {
			ActivityWorldBossCfg[self.activity_id].coin_id,
			1
		})
	end)
end

function NianBeastBossView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_SPRING_FESTIVAL_MONSTER_DESCRIPE")
end

function NianBeastBossView:OnEnter()
	manager.ui:SetMainCamera("activityWorldBoss")

	self.activity_id = ActivityConst.NIEN_WORLD_BOSS

	ActivityWorldBossAction.QueryBossData(self.activity_id)
	self:RefreshUI()

	if ActivityWorldBossCfg[self.activity_id].pre_story_id and not manager.story:IsStoryPlayed(ActivityWorldBossCfg[self.activity_id].pre_story_id) then
		manager.story:StartStoryById(ActivityWorldBossCfg[self.activity_id].pre_story_id, function(arg_12_0)
			return
		end)
	end

	self:RefrenTime()

	self.timer = Timer.New(function()
		self:RefrenTime()
	end, 1, -1)

	self.timer:Start()
end

function NianBeastBossView:OnExit()
	manager.windowBar:HideBar()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function NianBeastBossView:RefrenTime()
	local var_15_0 = ActivityData:GetActivityData(self.activity_id)

	self.m_timeLab.text = var_15_0 and var_15_0:IsActivitying() and manager.time:GetLostTimeStr(var_15_0.stopTime) or GetTips("TIME_OVER")
end

function NianBeastBossView:RefreshUI()
	local var_16_0 = ActivityWorldBossCfg[self.activity_id]
	local var_16_1 = ActivityWorldBossData:GetLeftHealthPoint(self.activity_id)

	self.m_healthSlider.value = var_16_1 / 1000
	self.m_bossName.text = GetMonsterName({
		ActivityWorldBossCfg[self.activity_id].boss_id[1]
	}) .. " " .. math.ceil(var_16_1 / 10) .. "%"

	for iter_16_0 = 1, #ActivityWorldBossCfg[self.activity_id].health_reward_list do
		self.rewardItems[iter_16_0] = self.rewardItems[iter_16_0] or NiewWorldBossRewardItem.New(Object.Instantiate(self.m_rewardItem, self.m_rewardContent), self.m_rewardContent.rect.width)

		self.rewardItems[iter_16_0]:SetData(self.activity_id, iter_16_0)
		self.rewardItems[iter_16_0]:SetActive(true)
	end

	for iter_16_1 = #ActivityWorldBossCfg[self.activity_id].health_reward_list + 1, #self.rewardItems do
		self.rewardItems[iter_16_1]:SetActive(false)
	end

	self.commonItem:RefreshData({
		number = 1,
		id = ActivityWorldBossCfg[self.activity_id].coin_id
	})
	self.commonItem:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_16_0.coin_id)
	end)

	self.m_coinMax.text = "/" .. ActivityWorldBossData:GetMaxCoinNum(self.activity_id)
	self.m_coinCount.text = ActivityWorldBossData:GetCointCount(self.activity_id)

	local var_16_2 = ActivityWorldBossData:GetAffix(self.activity_id)

	if var_16_2 then
		SetActive(self.m_affixImg.gameObject, true)

		self.m_affixDes.text = GetI18NText(getAffixDesc(var_16_2))
		self.m_affixImg.sprite = getAffixSprite(var_16_2)
	else
		self.m_affixDes.text = ""

		SetActive(self.m_affixImg.gameObject, false)
	end
end

function NianBeastBossView:Dispose()
	for iter_18_0, iter_18_1 in ipairs(self.rewardItems) do
		iter_18_1:Dispose()
	end

	self.rewardItems = {}

	self.commonItem:Dispose()
	NianBeastBossView.super.Dispose(self)
end

function NianBeastBossView:OnActivityWorldBossUpdate()
	self:RefreshUI()
end

return NianBeastBossView
