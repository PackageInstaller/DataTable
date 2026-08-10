local var_0_0 = class("PolyhedronTeamInfoSettingView", ReduxView)

function var_0_0.SetActive(arg_1_0, arg_1_1)
	if arg_1_0.gameObject_ then
		SetActive(arg_1_0.gameObject_, arg_1_1)
	end
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.hander_ = arg_2_1
	arg_2_0.transform_ = arg_2_2.transform
	arg_2_0.gameObject_ = arg_2_2
	arg_2_0.stageData = arg_2_3

	manager.notify:RegistListener(COMBO_SKILL_SELECT, arg_2_0.handler_)
	arg_2_0:Init()
	arg_2_0:RefreshSettingUI()
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.fightHeroList = LuaList.New(handler(arg_4_0, arg_4_0.IndexFightHeroItem), arg_4_0.m_fightHeroList, PolyhedronTeamInfoSettingHead)
	arg_4_0.heroList = LuaList.New(handler(arg_4_0, arg_4_0.IndexHeroItem), arg_4_0.m_heroList, PolyhedronTeamInfoSettingHead)
	arg_4_0.comboController_ = arg_4_0.m_comboSkillController_:GetController("name")
	arg_4_0.campController_ = arg_4_0.m_campAddController_:GetController("name")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_campAddBtn, nil, function()
		local var_6_0, var_6_1 = PolyhedronTools.GetRaceEffect(arg_5_0.fightHeroArray)

		JumpTools.OpenPageByJump("sectionSelectRaceDescription", {
			raceID = var_6_0,
			sameCamp = var_6_1
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_comboSkillBtn, nil, function()
		local var_7_0 = arg_5_0:GetComboSkillID()

		JumpTools.OpenPageByJump("polyhedronComboSkillSelect", {
			stageID = 0,
			stageType = BattleConst.STAGE_TYPE_NEW.POLYHEDRON,
			activityID = PolyhedronData:GetActivityID(),
			heroList = arg_5_0.fightHeroArray,
			trialList = {},
			comboSkillID = var_7_0
		})
	end)
end

function var_0_0.GetComboSkillID(arg_8_0)
	return BattleTeamData:GetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, PolyhedronData:GetActivityID())
end

function var_0_0.RefreshSettingUI(arg_9_0)
	arg_9_0.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.POLYHEDRON)
	arg_9_0.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()
	arg_9_0.fightHeroArray = arg_9_0.polyhedronInfo:GetFightHeroList()
	arg_9_0.heroArray = {}

	local var_9_0 = arg_9_0.polyhedronInfo:GetHeroList()

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if not table.indexof(arg_9_0.fightHeroArray, iter_9_1) then
			table.insert(arg_9_0.heroArray, iter_9_1)
		end
	end

	arg_9_0.fightHeroList:StartScroll(3)
	arg_9_0.heroList:StartScroll(#arg_9_0.heroArray)

	local var_9_1 = arg_9_0:GetComboSkillID()

	arg_9_0.comboController_:SetSelectedIndex(var_9_1 ~= 0 and 1 or 0)

	local var_9_2, var_9_3, var_9_4 = PolyhedronTools.GetRaceEffect(arg_9_0.fightHeroArray)

	arg_9_0.campController_:SetSelectedIndex(var_9_3 and 1 or 0)
end

function var_0_0.IndexFightHeroItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.fightHeroArray[arg_10_1]

	arg_10_2:SetFightData(arg_10_0.polyhedronInfo, var_10_0, arg_10_0.heroViewProxy_)
	arg_10_2:RegistCallBack(function(arg_11_0)
		arg_10_0:FightHeroClick(arg_11_0)
	end)
end

function var_0_0.IndexHeroItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.heroArray[arg_12_1]

	arg_12_2:SetData(arg_12_0.polyhedronInfo, var_12_0, arg_12_0.heroViewProxy_)
	arg_12_2:RegistCallBack(function(arg_13_0)
		arg_12_0:HeroClick(arg_13_0)
	end)
end

function var_0_0.FightHeroClick(arg_14_0, arg_14_1)
	if arg_14_0.polyhedronInfo:GetLeaderHeroId() == arg_14_1 or arg_14_1 == 0 then
		return
	end

	local var_14_0 = clone(arg_14_0.fightHeroArray)
	local var_14_1 = table.indexof(var_14_0, arg_14_1)

	if var_14_1 then
		table.remove(var_14_0, var_14_1)
		PolyhedronAction.QuerySwitchTeamHero(var_14_0)
	end
end

function var_0_0.HeroClick(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.polyhedronInfo:GetHeroPolyData(arg_15_1)

	if #arg_15_0.fightHeroArray >= 3 then
		ShowTips("POLYHEDRON_TEAM_SET_FULL")

		return
	end

	if var_15_0:IsDead() then
		ShowTips("POLYHEDRON_TEAM_SET_DEAD")

		return
	end

	local var_15_1 = clone(arg_15_0.fightHeroArray)

	table.insert(var_15_1, arg_15_1)
	PolyhedronAction.QuerySwitchTeamHero(var_15_1)
end

function var_0_0.Dispose(arg_16_0)
	var_0_0.super.Dispose(arg_16_0)

	arg_16_0.transform_ = nil
	arg_16_0.gameObject_ = nil

	ComboSkillData:SetNeedRefresh(true)

	if arg_16_0.fightHeroList then
		arg_16_0.fightHeroList:Dispose()

		arg_16_0.fightHeroList = nil
	end

	if arg_16_0.heroList then
		arg_16_0.heroList:Dispose()

		arg_16_0.heroList = nil
	end

	manager.notify:RemoveListener(COMBO_SKILL_SELECT, arg_16_0.handler_)

	arg_16_0.handler_ = nil
end

function var_0_0.OnPolyhedronSwitchHero(arg_17_0)
	arg_17_0:RefreshSettingUI()
end

return var_0_0
