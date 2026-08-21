local var_0_0 = class("GuelGameSeclectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Main_T0SceneGame/102003/102003_Match3SeclectUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()

	arg_4_0.selectItem = {}
	arg_4_0.selectIndex = 1
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
	arg_5_0:AddListeners()

	arg_5_0.selControlller = arg_5_0.match3seclectuiControllerexcollection_:GetController("selState")
	arg_5_0.enterControlller = arg_5_0.match3seclectuiControllerexcollection_:GetController("state")
	arg_5_0.enterAniControlller = arg_5_0.match3seclectuiControllerexcollection_:GetController("ani")
	arg_5_0.cutsceneSubView = TZeroGameChangeView.BaseView.New(arg_5_0.cutsceneSubView_)
end

function var_0_0.SetSpineParent(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {
		"spine1Go_",
		"spine2Go_"
	}
	local var_6_1 = {
		"rolepos1Go_",
		"rolepos2Go_"
	}
	local var_6_2 = var_6_0[arg_6_1] and var_6_0[arg_6_1] or var_6_0[1]
	local var_6_3 = var_6_1[arg_6_2] and var_6_1[arg_6_2] or var_6_1[1]

	arg_6_0[var_6_2].transform:SetParent(arg_6_0[var_6_3].transform)

	arg_6_0[var_6_2].transform.localPosition = Vector3(0, 0, 0)
	arg_6_0[var_6_2].transform.localScale = Vector3(arg_6_2 == 1 and 1 or -1, 1, 1)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.btnconfirmBtn_, nil, function()
		if arg_7_0.confirm then
			return
		end

		arg_7_0:StopTime()
		arg_7_0:PlayVoice(true)

		for iter_8_0 = 1, 2 do
			arg_7_0.selectItem[iter_8_0]:UpdateSelect(false)
		end

		arg_7_0.confirm = true
		arg_7_0.timer3 = TimeTools.StartAfterSeconds(0.2, function()
			if arg_7_0.selectIndex == 1 then
				arg_7_0.selfSelectAni_:Play("select_role", 0, 0)
			else
				arg_7_0.enemySelectAni_:Play("select_role", 0, 0)
			end

			manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_sanxiao_choose02", "")
		end, {})
		arg_7_0.timer1 = TimeTools.StartAfterSeconds(3, function()
			arg_7_0:UpdateOtherItem()
			arg_7_0.selControlller:SetSelectedState("over")
			arg_7_0.enemyNameAni_:Play("NameChange02", 0, 0)
			manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_sanxiao_choose01", "")

			for iter_10_0 = 1, 2 do
				arg_7_0.selectItem[iter_10_0]:UpdateSelect(arg_7_0.selectIndex ~= iter_10_0)
			end

			if arg_7_0.selectIndex == 1 then
				arg_7_0.enemyCharName_.text = HeroCfg[1089].suffix
			else
				arg_7_0.enemyCharName_.text = HeroCfg[1156].suffix
			end

			arg_7_0:PlayVoice(false)

			arg_7_0.timer4 = TimeTools.StartAfterSeconds(1, function()
				if arg_7_0.selectIndex == 1 then
					arg_7_0.enemySelectAni_:Play("select_role", 0, 0)
				else
					arg_7_0.selfSelectAni_:Play("select_role", 0, 0)
				end

				manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_sanxiao_choose02", "")

				for iter_11_0 = 1, 2 do
					arg_7_0.selectItem[iter_11_0]:UpdateSelect(false)
				end
			end, {})
		end, {})
		arg_7_0.timer2 = TimeTools.StartAfterSeconds(6, function()
			arg_7_0.confirm = false

			arg_7_0:GotoNext(arg_7_0.selectIndex)
		end, {})
	end)
	arg_7_0:AddBtnListener(arg_7_0.continuemaskBtn_, nil, function()
		arg_7_0.enterControlller:SetSelectedState("select")
		manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_sanxiao_in", "")
		arg_7_0.panelAni_:Play("enter", -1, 0)
		arg_7_0.panelAni_:Update(0)
		arg_7_0:UpdateSelect()
		manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_sanxiao_choose01", "")
	end)
end

local var_0_1 = {
	2011,
	1021
}

function var_0_0.PlayVoice(arg_14_0, arg_14_1)
	local var_14_0 = var_0_1[math.random(1, 2)]
	local var_14_1 = arg_14_0:GetHeroIdForPlayVoice(var_14_0, arg_14_1)

	HeroTools.PlayVoice(var_14_1, HeroVoiceCfg[var_14_0].file, HeroVoiceCfg[var_14_0].type)
end

function var_0_0.GetHeroIdForPlayVoice(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0

	return arg_15_0.selectIndex == 1 and (arg_15_2 and 1156 or 1089) or arg_15_2 and 1089 or 1156
end

function var_0_0.GotoNext(arg_16_0, arg_16_1)
	JumpTools.OpenPageByJump("GuelGameView", {
		chooseIndex = arg_16_1
	})
end

function var_0_0.ChangeBar(arg_17_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if arg_17_0.confirm then
			return
		end

		arg_17_0:Back()
	end)
end

function var_0_0.OnTop(arg_19_0)
	if arg_19_0.cutsceneSubView:IsDuringCutscene() then
		manager.windowBar:HideBar()
	else
		arg_19_0:ChangeBar()
	end
end

function var_0_0.OnEnter(arg_20_0)
	arg_20_0.confirm = false

	manager.windowBar:HideBar()
	arg_20_0.selControlller:SetSelectedState("in")
	arg_20_0.enterControlller:SetSelectedState("entrance")

	for iter_20_0 = 1, 2 do
		if not arg_20_0.selectItem[iter_20_0] then
			arg_20_0.selectItem[iter_20_0] = GuelGameSeclectItem.New(arg_20_0[string.format("character0%sGo_", iter_20_0)], arg_20_0)

			arg_20_0.selectItem[iter_20_0]:SetClickCallback(function()
				if arg_20_0.confirm then
					return
				end

				if arg_20_0.selectIndex ~= iter_20_0 then
					arg_20_0.selectIndex = iter_20_0

					arg_20_0:UpdateSelect()
					manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_sanxiao_choose01", "")
				end
			end)
		end

		arg_20_0.selectItem[iter_20_0]:UpdateSelect(false)
	end

	arg_20_0:ResetItem()

	function arg_20_0.cutsceneSubView.onScreenFullyBlockedCallback()
		arg_20_0.enterAniControlller:SetSelectedState("false")
		arg_20_0.panelAni_:Play("102003_Match3SeclectUI", -1, 0)
		arg_20_0.panelAni_:Update(0)
	end

	function arg_20_0.cutsceneSubView.onFinishCallback()
		arg_20_0:ChangeBar()
		arg_20_0.cutsceneSubView.gameObject_:SetActive(false)
	end

	arg_20_0.enterAniControlller:SetSelectedState("true")
	arg_20_0.cutsceneSubView:OnEnter()
end

function var_0_0.UpdateSelect(arg_24_0)
	arg_24_0.ani_panelAni_:Play("Match3SeclectUI_RoleChange", 0, 0)

	for iter_24_0 = 1, 2 do
		if not arg_24_0.selectItem[iter_24_0] then
			arg_24_0.selectItem[iter_24_0] = GuelGameSeclectItem.New(arg_24_0[string.format("character0%sGo_", iter_24_0)])
		end

		arg_24_0.selectItem[iter_24_0]:UpdateSelect(arg_24_0.selectIndex == iter_24_0)
	end

	arg_24_0.selfNameAni_:Play("NameChange01", 0, 0)

	if arg_24_0.selectIndex == 1 then
		arg_24_0.selfCharName_.text = HeroCfg[1156].suffix
	else
		arg_24_0.selfCharName_.text = HeroCfg[1089].suffix
	end

	arg_24_0.enemyCharName_.text = "???"

	local var_24_0 = arg_24_0.selectIndex == 1 and 2 or 1

	arg_24_0:SetSpineParent(1, var_24_0)
	arg_24_0:SetSpineParent(2, arg_24_0.selectIndex)
	arg_24_0:UpdateSelfItem()
end

function var_0_0.UpdateOtherItem(arg_25_0)
	local var_25_0 = arg_25_0.selectIndex == 1 and 2 or 1

	arg_25_0.selectItem[var_25_0]:UpdateCamp(3)
end

function var_0_0.UpdateSelfItem(arg_26_0)
	local var_26_0 = arg_26_0.selectIndex == 1 and 2 or 1

	arg_26_0.selectItem[var_26_0]:UpdateCamp(1)
	arg_26_0.selectItem[arg_26_0.selectIndex]:UpdateCamp(2)
end

function var_0_0.ResetItem(arg_27_0)
	for iter_27_0 = 1, 2 do
		arg_27_0.selectItem[iter_27_0]:UpdateCamp(0)
	end
end

function var_0_0.OnBehind(arg_28_0)
	return
end

function var_0_0.OnExit(arg_29_0)
	var_0_0.super.OnExit(arg_29_0)
	arg_29_0.cutsceneSubView:OnExit()
end

function var_0_0.StopTime(arg_30_0)
	if arg_30_0.timer1 then
		arg_30_0.timer1:Stop()

		arg_30_0.timer1 = nil
	end

	if arg_30_0.timer2 then
		arg_30_0.timer2:Stop()

		arg_30_0.timer2 = nil
	end

	if arg_30_0.timer3 then
		arg_30_0.timer3:Stop()

		arg_30_0.timer3 = nil
	end

	if arg_30_0.timer4 then
		arg_30_0.timer4:Stop()

		arg_30_0.timer4 = nil
	end
end

function var_0_0.Dispose(arg_31_0)
	arg_31_0.cutsceneSubView:Dispose()
	var_0_0.super.Dispose(arg_31_0)

	for iter_31_0, iter_31_1 in ipairs(arg_31_0.selectItem) do
		if iter_31_1 and iter_31_1.Dispose then
			iter_31_1:Dispose()
		end
	end

	arg_31_0:StopTime()

	arg_31_0.selectItem = nil
end

local var_0_2 = import("manager.posterGirl.tgame.GuelGame.States.Include")

function var_0_0.GetPlayBackwardsAnimator(arg_32_0)
	return arg_32_0.cutsceneSubView:GetPlayBackwardsAnimator(function()
		arg_32_0.enterAniControlller:SetSelectedState("true")

		local var_33_0 = manager.posterGirl.actor

		if var_33_0 then
			local var_33_1 = var_33_0:GetCurrentState()

			if var_33_1.gameInst and not var_33_1.gameInst.exit then
				var_33_1.gameInst:GoToState(var_0_2.ExitState)
			end
		end
	end)
end

return var_0_0
