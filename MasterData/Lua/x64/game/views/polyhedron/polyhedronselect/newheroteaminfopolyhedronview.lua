local NewHeroTeamInfoPolyhedronView = class("NewHeroTeamInfoPolyhedronView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function NewHeroTeamInfoPolyhedronView:UIName()
	return "Widget/System/Polyhedron/HeroPolyhedronTeamInfoUI"
end

function NewHeroTeamInfoPolyhedronView:Init()
	self:InitProxy()

	self.gameObject_ = self.realGo_
	self.transform_ = self.realGo_.transform

	self:InitUI()
	self:AddUIListener()

	self.gameObject_ = self.gameObject_
	self.transform_ = self.gameObject_.transform
	self.autoClearFilter_ = false
end

function NewHeroTeamInfoPolyhedronView:InitProxy()
	self:BindCfgUI()
end

function NewHeroTeamInfoPolyhedronView:AddUIListener()
	self:AddBtnListener(self.m_infoBtn, nil, function()
		PolyhedronData:SetCacheSelectHero(self.selectHeroData_.id)
		self:Go("/polyhedronHero", {
			isEnter = true,
			type = HeroConst.HERO_DATA_TYPE.POLYHEDRON,
			hid = self.selectHeroData_.id,
			tempHeroList = PolyhedronData:GetHeroIDList()
		})
	end)
	self:AddBtnListener(self.m_okBtn, nil, function()
		if not self.selectHeroData_ then
			return
		end

		PolyhedronData:SetCacheSelectHero(self.selectHeroData_.id)
		JumpTools.OpenPageByJump("/polyhedronBeacon", {})
	end)
	self:AddBtnListener(self.m_backBtn, nil, function()
		self:Back()
	end)
end

function NewHeroTeamInfoPolyhedronView:ReserveCameraEnter()
	SectionSelectHeroScene.GetInstance():SetALlStateGoActive(false)
	manager.loadScene:SetSceneActive(SceneConst.SCENE_NAME.hero, true)
end

function NewHeroTeamInfoPolyhedronView:HeadRenderer(arg_9_1, arg_9_2)
	NewHeroTeamInfoPolyhedronView.super.HeadRenderer(self, arg_9_1, arg_9_2)
	arg_9_2:SetLocking(false)

	arg_9_2.levelText_.text = HeroStandardSystemCfg[PolyhedronHeroCfg[self.heroDataList_[arg_9_1].id].standard_id].hero_lv
end

function NewHeroTeamInfoPolyhedronView:UpdateHeroView()
	self.m_heroName.text = GetI18NText(HeroCfg[self.selectHeroData_.id].name)
	self.m_heroSuffix.text = GetI18NText(HeroCfg[self.selectHeroData_.id].suffix)

	local var_10_1 = PolyhedronData:GetHeroBattleUsingSkinInfo(self.selectHeroData_.id).id

	self.fightPowerText_.text = self.heroViewProxy_:GetBattlePower(self.selectHeroData_.id)

	self:LoadHeroModel(var_10_1)
	self:ProcessCamera(var_10_1)
end

function NewHeroTeamInfoPolyhedronView:IsInTeam(arg_11_1, arg_11_2)
	return false, false, -1
end

function NewHeroTeamInfoPolyhedronView:GetHeroTeam()
	self.heroTeam_ = self.params_.heroTeam
	self.lockStateList_ = {}
	self.lockHeroList_ = {}
	self.heroTrialList_ = {
		0
	}
end

function NewHeroTeamInfoPolyhedronView:GetDefaultHeroData()
	local var_13_0 = PolyhedronData:GetCacheSelectHero()

	if var_13_0 ~= 0 then
		return {
			trialID = 0,
			id = var_13_0,
			type = self.heroDataType_,
			heroViewProxy = self:GetHeroViewProxy(self.heroDataType_)
		}
	end

	local var_13_1 = self.heroTeam_[self.params_.selectHeroPos] or 0

	if var_13_1 == 0 then
		for iter_13_0, iter_13_1 in pairs(self.heroDataList_) do
			if not self:IsInTeam(iter_13_1.id) and not table.keyof(self.lockHeroList_, iter_13_1.id) then
				return {
					trialID = 0,
					id = iter_13_1.id,
					type = self.heroDataType_,
					heroViewProxy = self:GetHeroViewProxy(self.heroDataType_)
				}
			end
		end
	end

	if var_13_1 == 0 then
		for iter_13_2, iter_13_3 in pairs(self.heroDataList_) do
			return {
				trialID = 0,
				id = iter_13_3.id,
				type = self.heroDataType_,
				heroViewProxy = self:GetHeroViewProxy(self.heroDataType_)
			}
		end
	end

	return {
		trialID = 0,
		id = var_13_1,
		type = self.heroDataType_,
		heroViewProxy = self:GetHeroViewProxy(self.heroDataType_)
	}
end

function NewHeroTeamInfoPolyhedronView:GetHeroList()
	return PolyhedronData:GetUnlockHeroList()
end

return NewHeroTeamInfoPolyhedronView
