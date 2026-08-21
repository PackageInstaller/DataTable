local var_0_0 = class("PolyhedronTeamInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/PolyhedronBattle/PolyhedronTiprankUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
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
			activityID = 0,
			stageType = BattleConst.STAGE_TYPE_NEW.POLYHEDRON,
			heroList = arg_5_0.fightHeroArray,
			trialList = {},
			comboSkillID = var_7_0
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_mask, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0:RefreshSettingUI()
end

function var_0_0.GetComboSkillID(arg_10_0)
	return BattleTeamData:GetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, PolyhedronData:GetActivityID())
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.POLYHEDRON)

	arg_11_0:RefreshSettingUI()
end

function var_0_0.RefreshSettingUI(arg_12_0)
	arg_12_0.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()
	arg_12_0.fightHeroArray = arg_12_0.polyhedronInfo:GetFightHeroList()
	arg_12_0.heroArray = {}

	local var_12_0 = arg_12_0.polyhedronInfo:GetHeroList()

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if not table.indexof(arg_12_0.fightHeroArray, iter_12_1) then
			table.insert(arg_12_0.heroArray, iter_12_1)
		end
	end

	arg_12_0.fightHeroList:StartScroll(3)
	arg_12_0.heroList:StartScroll(#arg_12_0.heroArray)

	local var_12_1 = arg_12_0:GetComboSkillID()

	arg_12_0.comboController_:SetSelectedIndex(var_12_1 ~= 0 and 1 or 0)

	local var_12_2, var_12_3, var_12_4 = PolyhedronTools.GetRaceEffect(arg_12_0.fightHeroArray)

	arg_12_0.campController_:SetSelectedIndex(var_12_3 and 1 or 0)
end

function var_0_0.IndexFightHeroItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.fightHeroArray[arg_13_1]

	arg_13_2:SetFightData(arg_13_0.polyhedronInfo, var_13_0, arg_13_0.heroViewProxy_)
	arg_13_2:RegistCallBack(function(arg_14_0)
		arg_13_0:FightHeroClick(arg_14_0)
	end)
end

function var_0_0.IndexHeroItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.heroArray[arg_15_1]

	arg_15_2:SetData(arg_15_0.polyhedronInfo, var_15_0, arg_15_0.heroViewProxy_)
	arg_15_2:RegistCallBack(function(arg_16_0)
		arg_15_0:HeroClick(arg_16_0)
	end)
end

function var_0_0.FightHeroClick(arg_17_0, arg_17_1)
	if arg_17_0.polyhedronInfo:GetLeaderHeroId() == arg_17_1 or arg_17_1 == 0 then
		return
	end

	local var_17_0 = clone(arg_17_0.fightHeroArray)
	local var_17_1 = table.indexof(var_17_0, arg_17_1)

	if var_17_1 then
		table.remove(var_17_0, var_17_1)
		PolyhedronAction.QuerySwitchTeamHero(var_17_0)
	end
end

function var_0_0.HeroClick(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.polyhedronInfo:GetHeroPolyData(arg_18_1)

	if #arg_18_0.fightHeroArray >= 3 then
		ShowTips("POLYHEDRON_TEAM_SET_FULL")

		return
	end

	if var_18_0:IsDead() then
		ShowTips("POLYHEDRON_TEAM_SET_DEAD")

		return
	end

	local var_18_1 = clone(arg_18_0.fightHeroArray)

	table.insert(var_18_1, arg_18_1)
	PolyhedronAction.QuerySwitchTeamHero(var_18_1)
end

function var_0_0.Dispose(arg_19_0)
	if arg_19_0.fightHeroList then
		arg_19_0.fightHeroList:Dispose()

		arg_19_0.fightHeroList = nil
	end

	if arg_19_0.heroList then
		arg_19_0.heroList:Dispose()

		arg_19_0.heroList = nil
	end

	var_0_0.super.Dispose(arg_19_0)

	arg_19_0.transform_ = nil
	arg_19_0.gameObject_ = nil

	ComboSkillData:SetNeedRefresh(true)
end

function var_0_0.OnPolyhedronSwitchHero(arg_20_0)
	arg_20_0:RefreshSettingUI()
end

return var_0_0
