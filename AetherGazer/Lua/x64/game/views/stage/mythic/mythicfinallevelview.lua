local var_0_0 = class("MythicFinalLevelView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_Mythic/MythicChooseDifficlutPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.controller_ = arg_3_0.controllerEx_:GetController("status")

	arg_3_0:AddUIListeners()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:RefreshUI()
	manager.windowBar:HideBar()
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.nextbtn_, nil, function()
		MythicData:SubLevel(1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.exnextbtn_, nil, function()
		MythicData:SetCurHotLevelIdMax()
	end)
	arg_5_0:AddBtnListener(arg_5_0.frontbtn_, nil, function()
		MythicData:SubLevel(-1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.exfrontbtn_, nil, function()
		MythicAction:SelectLevel(1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.battlebtn_, nil, function()
		local var_10_0 = MythicData:GetCurLevelIdList()

		if #var_10_0 > 1 then
			gameContext:Go("/mythicFinalTeamView")
		else
			arg_5_0:Go("/sectionSelectHero", {
				section = var_10_0[1],
				sectionType = BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL
			})
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.backbtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnMythicFinalHotItemClick(arg_12_0)
	arg_12_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_13_0)
	arg_13_0.curleveltext_.text = MythicData:GetCurHotLevelId()
	arg_13_0.leveltext_.text = string.format("<color=#FF9500>%s</color>/%s", MythicData:GetLevelMax(), #MythicFinalCfg.all)

	local var_13_0 = MythicFinalCfg[MythicData:GetCurHotLevelId()]

	arg_13_0.teamtext_.text = var_13_0.team_num

	local var_13_1 = MythicData:GetCurLevelIdList()
	local var_13_2 = BattleMythicFinalCfg[var_13_1[1]]

	arg_13_0.nametext_.text = var_13_2.name
	arg_13_0.destext_.text = var_13_2.tips
	arg_13_0.bgimage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, var_13_2.background_1))

	arg_13_0.controller_:SetSelectedState(MythicData:GetLevelStatus())
end

function var_0_0.Dispose(arg_14_0)
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
