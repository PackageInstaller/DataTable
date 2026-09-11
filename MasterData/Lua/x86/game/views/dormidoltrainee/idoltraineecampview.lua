local IdolTraineeCampView = class("IdolTraineeCampView", ReduxView)

function IdolTraineeCampView:UIName()
	return "Widget/BackHouseUI/IdolTrainee/IdolTraineeCampView"
end

function IdolTraineeCampView:UIParent()
	return manager.ui.uiMain.transform
end

function IdolTraineeCampView:Init()
	self:InitUI()
	self:AddUIListener()
end

function IdolTraineeCampView:InitUI()
	self:BindCfgUI()

	self.quickView = BackHomeQuickJumpView.New(self.quickJumpSubView_)
end

function IdolTraineeCampView:AddUIListener()
	self:AddBtnListenerScale(self.navigationBtn_, nil, function()
		JumpTools.OpenPageByJump("dormNavigation", {
			isMain = false
		})
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("idolTraineeQuest")
	end)
	self:AddBtnListener(self.changeHeroBtn_, nil, function()
		JumpTools.OpenPageByJump("/idolTraineeDepolyChara")
	end)
	self:AddBtnListener(self.heroPropBtn_, nil, function()
		JumpTools.OpenPageByJump("/idolTraineeTrain")
	end)
	self:AddBtnListener(self.danceDIYBtn_, nil, DIYBridge.EnterDIY)
	self:AddBtnListener(self.pvpBtn_, nil, function()
		JumpTools.OpenPageByJump("/idolTraineeEnterBattleView", {
			pvpBattle = true
		})
	end)
	self:AddBtnListener(self.challengeBtn_, nil, function()
		JumpTools.OpenPageByJump("/idolTraineeChapterMain")
	end)
	self.quickView:AddClickCallBack(function()
		manager.windowBar:HideBar()
	end)
	self.quickView:CloseCallBack(function()
		self:RefreshBar()
	end)
end

local var_0_1 = {
	"CamShootAtPos1",
	"CamShootAtPos2",
	"CamShootAtPos3",
	"CamShootAtPos4",
	"CamShootAtPos5"
}

function IdolTraineeCampView:RestoreVCam()
	for iter_14_0, iter_14_1 in ipairs(var_0_1) do
		IdolTraineeCampBridge.SetVCamActive(iter_14_1, false)
	end

	if IdolTraineeCampBridge.cinemachineBrain.IsBlending then
		self:StartWaitCamBlend()
	end
end

function IdolTraineeCampView:RegisterEvents()
	self:RegistEventListener(DORM_CLICK_ENTITY, function(arg_16_0)
		manager.windowBar:HideBar()

		local var_16_0 = IdolTraineeCampBridge.GetPosByCharacter(arg_16_0)

		IdolTraineeCampBridge.SetVCamActive(var_0_1[var_16_0], true)
		self:StartWaitCamBlend(function()
			JumpTools.OpenPageByJump("/heroInteractView", {
				heroEID = arg_16_0,
				camPos = var_0_1[var_16_0]
			})
		end)
		DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.InteractCam)
	end)
end

function IdolTraineeCampView:StartWaitCamBlend(arg_18_1)
	self:StopWaitCamBlend()
	SetActive(self.gameObject_, false)

	self.timer = Timer.New(function()
		if not IdolTraineeCampBridge.cinemachineBrain.IsBlending then
			self:StopWaitCamBlend()
			SetActive(self.gameObject_, true)

			if arg_18_1 then
				arg_18_1()
			end
		end
	end, 0.34, -1)

	self.timer:Start()
end

function IdolTraineeCampView:StopWaitCamBlend()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function IdolTraineeCampView:OnEnter()
	self:RegisterEvents()
	self.quickView:OnEnter()
	self.quickView:ShowView(false)
	self:RestoreVCam()
	manager.redPoint:bindUIandKey(self.challengeBtn_.transform, RedPointConst.IDOL_TRAINEE_CHAPTER_TASK)
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.IDOL_TRAINEE_DAY_AND_WEEK_TASK)
	manager.redPoint:bindUIandKey(self.navigationBtn_.transform, RedPointConst.DORM_NAVI)
	BackHomeCricketBattleData:InvokeDanceBackCB()
	DormRedPointTools:RefreshIlluDanceNew()
end

function IdolTraineeCampView:OnTop()
	self:RefreshBar()
end

function IdolTraineeCampView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	end)

	if #GameSetting.idol_dance_info_describe.value > 0 then
		manager.windowBar:SetGameHelpKey({
			view = "/gameHelpPro",
			type = "jump",
			params = {
				hideHomeBtn = 1,
				isPrefab = true,
				pages = GameSetting.idol_dance_info_describe.value
			}
		})
	end
end

function IdolTraineeCampView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
	self:StopWaitCamBlend()
	self.quickView:OnExit()
	manager.redPoint:unbindUIandKey(self.challengeBtn_.transform, RedPointConst.IDOL_TRAINEE_CHAPTER_TASK)
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, RedPointConst.IDOL_TRAINEE_DAY_AND_WEEK_TASK)
	manager.redPoint:unbindUIandKey(self.navigationBtn_.transform, RedPointConst.DORM_ILLU)
end

function IdolTraineeCampView:Dispose()
	self.quickView:Dispose()
	self:StopWaitCamBlend()
	IdolTraineeCampView.super.Dispose(self)
end

return IdolTraineeCampView
