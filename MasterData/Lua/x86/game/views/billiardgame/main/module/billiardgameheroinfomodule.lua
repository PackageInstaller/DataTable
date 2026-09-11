local BilliardGameHeroInfoModule = class("BilliardGameHeroInfoModule", ReduxView)

function BilliardGameHeroInfoModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function BilliardGameHeroInfoModule:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.tabList_ = {}
end

function BilliardGameHeroInfoModule:AddUIListener()
	return
end

function BilliardGameHeroInfoModule:Refresh(arg_4_1, arg_4_2, arg_4_3)
	self.buffList = arg_4_2
	self.timeList = arg_4_3
	self.nameText_.text = SummerPubHeroCfg[arg_4_1].hero_name
	self.heroDescText_.text = SummerPubPinBallSkillCfg[SummerPubHeroCfg[arg_4_1].skill].skill_desc

	self:InitTabList()
end

local function var_0_1(arg_5_0)
	local var_5_0 = {}

	for iter_5_0 = 0, arg_5_0.Count - 1 do
		table.insert(var_5_0, arg_5_0[iter_5_0])
	end

	return var_5_0
end

function BilliardGameHeroInfoModule:InitTabList()
	local var_6_0 = {}
	local var_6_1 = {}

	if self.buffList and self.timeList then
		var_6_0 = var_0_1(self.buffList)
		var_6_1 = var_0_1(self.timeList)
	end

	local var_6_2 = #var_6_0

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		self.tabList_[iter_6_0] = self.tabList_[iter_6_0] or BilliardGameHeroBuffItem.New((Object.Instantiate(self.buffItemGo_, self.buffTabTrs_)))

		self.tabList_[iter_6_0]:SetData(iter_6_0, iter_6_1, var_6_1[iter_6_0] or -1)
		self.tabList_[iter_6_0]:Show(true)
	end

	for iter_6_2 = var_6_2 + 1, #self.tabList_ do
		self.tabList_[iter_6_2]:Show(false)
	end
end

function BilliardGameHeroInfoModule:OnDataChange()
	self.victoryGoalTxt_.text = string.format("%d/%d", BilliardGameMgr:GetLogicData().monsterKilled, BilliardStageCfg[BilliardGameMgr:GetStageId()].victory_condition[1])
end

function BilliardGameHeroInfoModule:Dispose()
	for iter_8_0, iter_8_1 in ipairs(self.tabList_) do
		iter_8_1:Dispose()
	end

	BilliardGameHeroInfoModule.super.Dispose(self)
end

return BilliardGameHeroInfoModule
