local var_0_0 = class("BilliardGameHeroInfoModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.tabList_ = {}
end

function var_0_0.AddUIListener(arg_3_0)
	return
end

function var_0_0.Refresh(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.buffList = arg_4_2
	arg_4_0.timeList = arg_4_3

	local var_4_0 = SummerPubHeroCfg[arg_4_1]

	arg_4_0.nameText_.text = var_4_0.hero_name

	local var_4_1 = var_4_0.skill
	local var_4_2 = SummerPubPinBallSkillCfg[var_4_1]

	arg_4_0.heroDescText_.text = var_4_2.skill_desc

	arg_4_0:InitTabList()
end

local function var_0_1(arg_5_0)
	local var_5_0 = {}

	for iter_5_0 = 0, arg_5_0.Count - 1 do
		table.insert(var_5_0, arg_5_0[iter_5_0])
	end

	return var_5_0
end

function var_0_0.InitTabList(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = {}

	if arg_6_0.buffList and arg_6_0.timeList then
		var_6_0 = var_0_1(arg_6_0.buffList)
		var_6_1 = var_0_1(arg_6_0.timeList)
	end

	local var_6_2 = #var_6_0

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if not arg_6_0.tabList_[iter_6_0] then
			local var_6_3 = Object.Instantiate(arg_6_0.buffItemGo_, arg_6_0.buffTabTrs_)

			arg_6_0.tabList_[iter_6_0] = BilliardGameHeroBuffItem.New(var_6_3)
		end

		local var_6_4 = var_6_1[iter_6_0] or -1

		arg_6_0.tabList_[iter_6_0]:SetData(iter_6_0, iter_6_1, var_6_4)
		arg_6_0.tabList_[iter_6_0]:Show(true)
	end

	for iter_6_2 = var_6_2 + 1, #arg_6_0.tabList_ do
		arg_6_0.tabList_[iter_6_2]:Show(false)
	end
end

function var_0_0.OnDataChange(arg_7_0)
	local var_7_0 = BilliardGameMgr:GetStageId()
	local var_7_1 = BilliardStageCfg[var_7_0]
	local var_7_2 = BilliardGameMgr:GetLogicData().monsterKilled

	arg_7_0.victoryGoalTxt_.text = string.format("%d/%d", var_7_2, var_7_1.victory_condition[1])
end

function var_0_0.Dispose(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.tabList_) do
		iter_8_1:Dispose()
	end

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
