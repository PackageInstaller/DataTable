local var_0_0 = class("IdolTraineeCampView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/IdolTrainee/IdolTraineeCampView"
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

	arg_4_0.quickView = BackHomeQuickJumpView.New(arg_4_0.quickJumpSubView_)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListenerScale(arg_5_0.navigationBtn_, nil, function()
		JumpTools.OpenPageByJump("dormNavigation", {
			isMain = false
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("idolTraineeQuest")
	end)
	arg_5_0:AddBtnListener(arg_5_0.changeHeroBtn_, nil, function()
		JumpTools.OpenPageByJump("/idolTraineeDepolyChara")
	end)
	arg_5_0:AddBtnListener(arg_5_0.heroPropBtn_, nil, function()
		JumpTools.OpenPageByJump("/idolTraineeTrain")
	end)
	arg_5_0:AddBtnListener(arg_5_0.danceDIYBtn_, nil, DIYBridge.EnterDIY)
	arg_5_0:AddBtnListener(arg_5_0.pvpBtn_, nil, function()
		JumpTools.OpenPageByJump("/idolTraineeEnterBattleView", {
			pvpBattle = true
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.challengeBtn_, nil, function()
		JumpTools.OpenPageByJump("/idolTraineeChapterMain")
	end)
	arg_5_0.quickView:AddClickCallBack(function()
		manager.windowBar:HideBar()
	end)
	arg_5_0.quickView:CloseCallBack(function()
		arg_5_0:RefreshBar()
	end)
end

local var_0_1 = {
	"CamShootAtPos1",
	"CamShootAtPos2",
	"CamShootAtPos3",
	"CamShootAtPos4",
	"CamShootAtPos5"
}

function var_0_0.RestoreVCam(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(var_0_1) do
		IdolTraineeCampBridge.SetVCamActive(iter_14_1, false)
	end

	if IdolTraineeCampBridge.cinemachineBrain.IsBlending then
		arg_14_0:StartWaitCamBlend()
	end
end

function var_0_0.RegisterEvents(arg_15_0)
	arg_15_0:RegistEventListener(DORM_CLICK_ENTITY, function(arg_16_0)
		manager.windowBar:HideBar()

		local var_16_0 = IdolTraineeCampBridge.GetPosByCharacter(arg_16_0)

		IdolTraineeCampBridge.SetVCamActive(var_0_1[var_16_0], true)
		arg_15_0:StartWaitCamBlend(function()
			JumpTools.OpenPageByJump("/heroInteractView", {
				heroEID = arg_16_0,
				camPos = var_0_1[var_16_0]
			})
		end)
		DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.InteractCam)
	end)
end

function var_0_0.StartWaitCamBlend(arg_18_0, arg_18_1)
	arg_18_0:StopWaitCamBlend()
	SetActive(arg_18_0.gameObject_, false)

	arg_18_0.timer = Timer.New(function()
		if not IdolTraineeCampBridge.cinemachineBrain.IsBlending then
			arg_18_0:StopWaitCamBlend()
			SetActive(arg_18_0.gameObject_, true)

			if arg_18_1 then
				arg_18_1()
			end
		end
	end, 0.34, -1)

	arg_18_0.timer:Start()
end

function var_0_0.StopWaitCamBlend(arg_20_0)
	if arg_20_0.timer then
		arg_20_0.timer:Stop()

		arg_20_0.timer = nil
	end
end

function var_0_0.OnEnter(arg_21_0)
	arg_21_0:RegisterEvents()
	arg_21_0.quickView:OnEnter()
	arg_21_0.quickView:ShowView(false)
	arg_21_0:RestoreVCam()
	manager.redPoint:bindUIandKey(arg_21_0.challengeBtn_.transform, RedPointConst.IDOL_TRAINEE_CHAPTER_TASK)
	manager.redPoint:bindUIandKey(arg_21_0.taskBtn_.transform, RedPointConst.IDOL_TRAINEE_DAY_AND_WEEK_TASK)
	manager.redPoint:bindUIandKey(arg_21_0.navigationBtn_.transform, RedPointConst.DORM_NAVI)
	BackHomeCricketBattleData:InvokeDanceBackCB()
	DormRedPointTools:RefreshIlluDanceNew()
end

function var_0_0.OnTop(arg_22_0)
	arg_22_0:RefreshBar()
end

function var_0_0.RefreshBar(arg_23_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	end)

	local var_23_0 = GameSetting.idol_dance_info_describe.value

	if #var_23_0 > 0 then
		manager.windowBar:SetGameHelpKey({
			view = "/gameHelpPro",
			type = "jump",
			params = {
				hideHomeBtn = 1,
				isPrefab = true,
				pages = var_23_0
			}
		})
	end
end

function var_0_0.OnExit(arg_25_0)
	manager.windowBar:HideBar()
	arg_25_0:RemoveAllEventListener()
	arg_25_0:StopWaitCamBlend()
	arg_25_0.quickView:OnExit()
	manager.redPoint:unbindUIandKey(arg_25_0.challengeBtn_.transform, RedPointConst.IDOL_TRAINEE_CHAPTER_TASK)
	manager.redPoint:unbindUIandKey(arg_25_0.taskBtn_.transform, RedPointConst.IDOL_TRAINEE_DAY_AND_WEEK_TASK)
	manager.redPoint:unbindUIandKey(arg_25_0.navigationBtn_.transform, RedPointConst.DORM_ILLU)
end

function var_0_0.Dispose(arg_26_0)
	arg_26_0.quickView:Dispose()
	arg_26_0:StopWaitCamBlend()
	var_0_0.super.Dispose(arg_26_0)
end

return var_0_0
