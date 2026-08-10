local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("NewHeroTeamInfoPolyhedronView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Polyhedron/HeroPolyhedronTeamInfoUI"
end

function var_0_1.Init(arg_2_0)
	local var_2_0 = arg_2_0.gameObject_

	arg_2_0:InitProxy()

	arg_2_0.gameObject_ = arg_2_0.realGo_
	arg_2_0.transform_ = arg_2_0.realGo_.transform

	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.gameObject_ = var_2_0
	arg_2_0.transform_ = var_2_0.transform
	arg_2_0.autoClearFilter_ = false
end

function var_0_1.InitProxy(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_1.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_infoBtn, nil, function()
		PolyhedronData:SetCacheSelectHero(arg_4_0.selectHeroData_.id)
		arg_4_0:Go("/polyhedronHero", {
			isEnter = true,
			type = HeroConst.HERO_DATA_TYPE.POLYHEDRON,
			hid = arg_4_0.selectHeroData_.id,
			tempHeroList = PolyhedronData:GetHeroIDList()
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_okBtn, nil, function()
		if not arg_4_0.selectHeroData_ then
			return
		end

		PolyhedronData:SetCacheSelectHero(arg_4_0.selectHeroData_.id)
		JumpTools.OpenPageByJump("/polyhedronBeacon", {})
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_backBtn, nil, function()
		arg_4_0:Back()
	end)
end

function var_0_1.ReserveCameraEnter(arg_8_0)
	SectionSelectHeroScene.GetInstance():SetALlStateGoActive(false)
	manager.loadScene:SetSceneActive(SceneConst.SCENE_NAME.hero, true)
end

function var_0_1.HeadRenderer(arg_9_0, arg_9_1, arg_9_2)
	var_0_1.super.HeadRenderer(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:SetLocking(false)

	local var_9_0 = arg_9_0.heroDataList_[arg_9_1].id
	local var_9_1 = PolyhedronHeroCfg[var_9_0].standard_id
	local var_9_2 = HeroStandardSystemCfg[var_9_1]

	arg_9_2.levelText_.text = var_9_2.hero_lv
end

function var_0_1.UpdateHeroView(arg_10_0)
	local var_10_0 = arg_10_0.selectHeroData_.id
	local var_10_1 = HeroCfg[var_10_0]

	arg_10_0.m_heroName.text = GetI18NText(var_10_1.name)
	arg_10_0.m_heroSuffix.text = GetI18NText(var_10_1.suffix)

	local var_10_2 = PolyhedronHeroCfg[var_10_0].standard_id
	local var_10_3 = PolyhedronData:GetHeroBattleUsingSkinInfo(var_10_0).id

	arg_10_0.fightPowerText_.text = arg_10_0.heroViewProxy_:GetBattlePower(var_10_0)

	arg_10_0:LoadHeroModel(var_10_3)
	arg_10_0:ProcessCamera(var_10_3)
end

function var_0_1.IsInTeam(arg_11_0, arg_11_1, arg_11_2)
	return false, false, -1
end

function var_0_1.GetHeroTeam(arg_12_0)
	arg_12_0.heroTeam_ = arg_12_0.params_.heroTeam
	arg_12_0.lockStateList_ = {}
	arg_12_0.lockHeroList_ = {}
	arg_12_0.heroTrialList_ = {
		0
	}
end

function var_0_1.GetDefaultHeroData(arg_13_0)
	local var_13_0 = PolyhedronData:GetCacheSelectHero()

	if var_13_0 ~= 0 then
		return {
			trialID = 0,
			id = var_13_0,
			type = arg_13_0.heroDataType_,
			heroViewProxy = arg_13_0:GetHeroViewProxy(arg_13_0.heroDataType_)
		}
	end

	local var_13_1 = arg_13_0.heroTeam_[arg_13_0.params_.selectHeroPos] or 0

	if var_13_1 == 0 then
		for iter_13_0, iter_13_1 in pairs(arg_13_0.heroDataList_) do
			local var_13_2 = iter_13_1.id

			if not arg_13_0:IsInTeam(var_13_2) and not table.keyof(arg_13_0.lockHeroList_, var_13_2) then
				return {
					trialID = 0,
					id = var_13_2,
					type = arg_13_0.heroDataType_,
					heroViewProxy = arg_13_0:GetHeroViewProxy(arg_13_0.heroDataType_)
				}
			end
		end
	end

	if var_13_1 == 0 then
		for iter_13_2, iter_13_3 in pairs(arg_13_0.heroDataList_) do
			return {
				trialID = 0,
				id = iter_13_3.id,
				type = arg_13_0.heroDataType_,
				heroViewProxy = arg_13_0:GetHeroViewProxy(arg_13_0.heroDataType_)
			}
		end
	end

	return {
		trialID = 0,
		id = var_13_1,
		type = arg_13_0.heroDataType_,
		heroViewProxy = arg_13_0:GetHeroViewProxy(arg_13_0.heroDataType_)
	}
end

function var_0_1.GetHeroList(arg_14_0)
	return PolyhedronData:GetUnlockHeroList()
end

return var_0_1
