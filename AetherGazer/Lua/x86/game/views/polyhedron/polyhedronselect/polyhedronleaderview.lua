local var_0_0 = class("PolyhedronLeaderView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Polyhedron/PolyhedronLeaderUI"
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

	arg_4_0.leaderController = ControllerUtil.GetController(arg_4_0.transform_, "leader")
	arg_4_0.nextController = ControllerUtil.GetController(arg_4_0.transform_, "next")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_btn, nil, function()
		local var_6_0

		if arg_5_0.leader ~= 0 then
			var_6_0 = {
				arg_5_0.leader
			}
		else
			var_6_0 = {}
		end

		gameContext:Go("/heroTeamInfoPolyhedron", {
			selectHeroPos = 1,
			heroTeam = var_6_0,
			type = HeroConst.HERO_DATA_TYPE.POLYHEDRON
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_nextBtn, nil, function()
		if arg_5_0.leader == 0 then
			return
		end

		JumpTools.OpenPageByJump("/polyhedronBeacon", {})
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_backBtn, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.leader = PolyhedronData:GetCacheSelectHero()

	if arg_10_0.leader == 0 then
		arg_10_0.leaderController:SetSelectedIndex(0)
		arg_10_0.nextController:SetSelectedIndex(0)
	else
		arg_10_0.leaderController:SetSelectedIndex(1)
		arg_10_0.nextController:SetSelectedIndex(1)

		local var_10_0 = HeroCfg[arg_10_0.leader]
		local var_10_1 = PolyhedronData:GetHeroUsingSkinInfo(arg_10_0.leader).id

		arg_10_0.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. var_10_1)
		arg_10_0.m_name.text = GetI18NText(var_10_0.name)
	end
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
