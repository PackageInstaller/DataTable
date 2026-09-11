local PolyhedronTeamInfoView = class("PolyhedronTeamInfoView", ReduxView)

function PolyhedronTeamInfoView:UIName()
	return "Widget/System/PolyhedronBattle/PolyhedronTiprankUI"
end

function PolyhedronTeamInfoView:UIParent()
	return manager.ui.uiPop.transform
end

function PolyhedronTeamInfoView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronTeamInfoView:InitUI()
	self:BindCfgUI()

	self.fightHeroList = LuaList.New(handler(self, self.IndexFightHeroItem), self.m_fightHeroList, PolyhedronTeamInfoSettingHead)
	self.heroList = LuaList.New(handler(self, self.IndexHeroItem), self.m_heroList, PolyhedronTeamInfoSettingHead)
	self.comboController_ = self.m_comboSkillController_:GetController("name")
	self.campController_ = self.m_campAddController_:GetController("name")
end

function PolyhedronTeamInfoView:AddUIListener()
	self:AddBtnListener(self.m_campAddBtn, nil, function()
		local var_6_0, var_6_1 = PolyhedronTools.GetRaceEffect(self.fightHeroArray)

		JumpTools.OpenPageByJump("sectionSelectRaceDescription", {
			raceID = var_6_0,
			sameCamp = var_6_1
		})
	end)
	self:AddBtnListener(self.m_comboSkillBtn, nil, function()
		JumpTools.OpenPageByJump("polyhedronComboSkillSelect", {
			stageID = 0,
			activityID = 0,
			stageType = BattleConst.STAGE_TYPE_NEW.POLYHEDRON,
			heroList = self.fightHeroArray,
			trialList = {},
			comboSkillID = self:GetComboSkillID()
		})
	end)
	self:AddBtnListener(self.m_mask, nil, function()
		self:Back()
	end)
end

function PolyhedronTeamInfoView:OnTop()
	self:RefreshSettingUI()
end

function PolyhedronTeamInfoView:GetComboSkillID()
	return BattleTeamData:GetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, PolyhedronData:GetActivityID())
end

function PolyhedronTeamInfoView:OnEnter()
	self.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.POLYHEDRON)

	self:RefreshSettingUI()
end

function PolyhedronTeamInfoView:RefreshSettingUI()
	self.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()
	self.fightHeroArray = self.polyhedronInfo:GetFightHeroList()
	self.heroArray = {}

	for iter_12_0, iter_12_1 in ipairs((self.polyhedronInfo:GetHeroList())) do
		if not table.indexof(self.fightHeroArray, iter_12_1) then
			table.insert(self.heroArray, iter_12_1)
		end
	end

	self.fightHeroList:StartScroll(3)
	self.heroList:StartScroll(#self.heroArray)
	self.comboController_:SetSelectedIndex(self:GetComboSkillID() ~= 0 and 1 or 0)

	local var_12_0, var_12_1, var_12_2 = PolyhedronTools.GetRaceEffect(self.fightHeroArray)

	self.campController_:SetSelectedIndex(var_12_1 and 1 or 0)
end

function PolyhedronTeamInfoView:IndexFightHeroItem(arg_13_1, arg_13_2)
	arg_13_2:SetFightData(self.polyhedronInfo, self.fightHeroArray[arg_13_1], self.heroViewProxy_)
	arg_13_2:RegistCallBack(function(arg_14_0)
		self:FightHeroClick(arg_14_0)
	end)
end

function PolyhedronTeamInfoView:IndexHeroItem(arg_15_1, arg_15_2)
	arg_15_2:SetData(self.polyhedronInfo, self.heroArray[arg_15_1], self.heroViewProxy_)
	arg_15_2:RegistCallBack(function(arg_16_0)
		self:HeroClick(arg_16_0)
	end)
end

function PolyhedronTeamInfoView:FightHeroClick(arg_17_1)
	if self.polyhedronInfo:GetLeaderHeroId() == arg_17_1 or arg_17_1 == 0 then
		return
	end

	local var_17_0 = clone(self.fightHeroArray)
	local var_17_1 = table.indexof(var_17_0, arg_17_1)

	if var_17_1 then
		table.remove(var_17_0, var_17_1)
		PolyhedronAction.QuerySwitchTeamHero(var_17_0)
	end
end

function PolyhedronTeamInfoView:HeroClick(arg_18_1)
	if #self.fightHeroArray >= 3 then
		ShowTips("POLYHEDRON_TEAM_SET_FULL")

		return
	end

	if self.polyhedronInfo:GetHeroPolyData(arg_18_1):IsDead() then
		ShowTips("POLYHEDRON_TEAM_SET_DEAD")

		return
	end

	local var_18_0 = clone(self.fightHeroArray)

	table.insert(var_18_0, arg_18_1)
	PolyhedronAction.QuerySwitchTeamHero(var_18_0)
end

function PolyhedronTeamInfoView:Dispose()
	if self.fightHeroList then
		self.fightHeroList:Dispose()

		self.fightHeroList = nil
	end

	if self.heroList then
		self.heroList:Dispose()

		self.heroList = nil
	end

	PolyhedronTeamInfoView.super.Dispose(self)

	self.transform_ = nil
	self.gameObject_ = nil

	ComboSkillData:SetNeedRefresh(true)
end

function PolyhedronTeamInfoView:OnPolyhedronSwitchHero()
	self:RefreshSettingUI()
end

return PolyhedronTeamInfoView
