local cjson = require("cjson")
local GoldMinerGameView = class("GoldMinerGameView", ReduxView)
local var_0_2 = {
	[1045] = {
		idle = "idle",
		pat = "alisa_pat",
		back = "alisa_back",
		throw = "alisa_throw",
		eat = "alisa_eat"
	},
	[1046] = {
		idle = "idle",
		pat = "ciel_pat",
		back = "ciel_back",
		throw = "ciel_throw",
		eat = "ciel_eat"
	}
}
local var_0_3 = {
	get = "minigame_activity_4_2_gold_get",
	back2 = "minigame_activity_4_2_gold_back_loop_action01",
	pat = "minigame_activity_4_2_gold_shoot",
	spring = "minigame_activity_4_2_gold_spring",
	skillLoaded = "minigame_activity_4_2_gold_load",
	catch = "minigame_activity_4_2_gold_catch",
	countDown = "minigame_activity_4_2_gold_countdown",
	back3 = "minigame_activity_4_2_gold_back_loop_action02",
	kill = "minigame_activity_4_2_gold_kill",
	skill = "minigame_activity_4_2_gold_skill",
	back1 = "minigame_activity_4_2_gold_back_loop",
	back4 = "minigame_activity_4_2_gold_back_loop_stop",
	boom = "minigame_activity_4_2_gold_explosion"
}

function GoldMinerGameView:UIName()
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_GoldenMiner/V4_2_GodEaterUI_GoldenMiner_GamePlayUI"
end

function GoldMinerGameView:UIParent()
	return manager.ui.uiMain.transform
end

function GoldMinerGameView:OnCtor()
	return
end

function GoldMinerGameView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GoldMinerGameView:InitUI()
	self:BindCfgUI()

	self.addPointTimer_ = nil
	self.roleSpine = {}
	self.roleSpine[1045] = self.alisaSpineGo_:GetComponent("Spine.Unity.SkeletonGraphic")
	self.roleSpine[1046] = self.cielSpineGo_:GetComponent("Spine.Unity.SkeletonGraphic")
	self.roleController_ = self.transCon_:GetController("role")
	self.pointController_ = self.pointControllerEx_:GetController("type")
	self.starController1_ = self.starControllerEx1_:GetController("state")
	self.starController2_ = self.starControllerEx2_:GetController("state")
	self.starController3_ = self.starControllerEx3_:GetController("state")
	self.skillStateController_ = self.skillControllerEx_:GetController("state")
	self.skillUsingController_ = self.skillControllerEx_:GetController("using")
	self.hook_ = GoldMinerHook.New(self.hookGo_, self)

	self.hook_:RegisterBackFunc(function()
		self:PlayRoleSpine("back")
	end)

	self.boomNum_ = 0
	self.skillNeedPoint_ = 0
	self.skillCurPoint_ = 0
	self.skillUsingSecond_ = 0
	self.timeRedTrigger_ = false
	self.entered_ = false
end

function GoldMinerGameView:AddUIListener()
	self:AddBtnListener(self.hookBtn_, nil, function()
		if self.hook_ and self.hook_:StartHooking() then
			self.useHookNum_ = self.useHookNum_ + 1

			self:PlayRoleSpine("pat")
			self:PlayAudio("pat")
		end
	end)
	self:AddBtnListener(self.boomBtn_, nil, function()
		if self.hook_ and self.hook_:TryToBoom() then
			self.useBoomNum_ = self.useBoomNum_ + 1

			self:PlayRoleSpine("throw")
			self:PlayAudio("boom")
		end
	end)
	self:AddBtnListener(self.skillBtn_, nil, function()
		if self.skillUsingSecond_ > 0 then
			return
		end

		if self.skillCurPoint_ >= self.skillNeedPoint_ then
			self:PlayAudio("skill")

			self.isPlayLoadedEffct_ = false
			self.skillCurPoint_ = 0
			self.skillUsingSecond_ = self.heroCfg_.last_time

			self.hook_:UseSkill(self.heroID_)

			if self.heroID_ == 1045 then
				SetActive(self.addPointSkillEffectGo_, true)
			elseif self.heroID_ == 1046 then
				SetActive(self.addSpeedSkillHookEffectGo_, true)
				SetActive(self.addSpeedSkillEffectGo_, true)
			end

			self:RefreshSkillInfo()

			self.useSkillNum_ = self.useSkillNum_ + 1
		else
			ShowTips(GetTips("GOLDMINER_SKILL_CHARGE"))
		end
	end)
end

function GoldMinerGameView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})

	local var_11_0 = GameSetting.godeater_goldminer_game_des.value

	manager.windowBar:RegistBackCallBack(function()
		GoldMinerManager.GetInstance():Pause()
		manager.audio:Pause("effect", true)
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GODEATER_GOLDMINER_QUIT"),
			OkCallback = function()
				manager.audio:Pause("effect", false)
				GoldMinerManager.GetInstance():SendMessageToSDK(self.subActivityID_, self.heroID_, self.useHookNum_, self.useBoomNum_, self.useSkillNum_)
				self:Back(2)
			end,
			CancelCallback = function()
				manager.audio:Pause("effect", false)
				GoldMinerManager.GetInstance():ReStart()
			end
		})
	end)
	manager.windowBar:RegistInfoCallBack(function()
		GoldMinerManager.GetInstance():Pause()
		manager.audio:Pause("effect", true)
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_11_0
		})
	end)
end

function GoldMinerGameView:OnEnter()
	self.entered_ = false
	self.subActivityID_ = self.params_.subActivityID
	self.heroID_ = self.params_.heroID
	self.heroCfg_ = ActivityGodEaterGoldminerHeroCfg[self.heroID_]
	self.skillNeedPoint_ = self.heroCfg_.skill_charge
	self.useBoomNum_ = 0
	self.useHookNum_ = 0
	self.boomNum_ = self.heroCfg_.boom or 0
	self.useSkillNum_ = 0
	self.lastPlayAudio_ = nil

	self:RefreshView()
	self:CreatStage()
	self:RefreshBoomNum(self.boomNum_)
	self:UpdateScore(0)
	self:RefreshSkillInfo()
	self.timeAni_:Play("normal")

	self.oriFrame_ = GameLocalData:GetCommonModule("userSetting").frame or PictureQualitySettingCfg[5].frame

	if self.oriFrame_ ~= 1 then
		SettingAction.ChangePicSetting("frame", 1)
	end

	self:PlayEnterAni()
end

function GoldMinerGameView:RefreshView()
	self.cfg_ = ActivityGodEaterGoldminerStageCfg[self.subActivityID_]
	self.needPointText1_.text = self.cfg_.score[1]
	self.needPointText2_.text = self.cfg_.score[2]
	self.needPointText3_.text = self.cfg_.score[3]
	self.timeText_.text = self.cfg_.time
	self.skillImage_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/V4_2_GodEaterUI/V4_2_GodEaterUI_GoldenMiner/" .. self.heroID_ .. "_goldminer_skill")

	self.roleController_:SetSelectedState(self.heroID_)

	self.selectedSpine_ = self.roleSpine[self.heroID_]
	self.selectedSpine_.startingLoop = true
	self.selectedSpine_.AnimationState.Complete = self.selectedSpine_.AnimationState.Complete + function()
		self.isIdle_ = true

		self.selectedSpine_.AnimationState:SetAnimation(0, var_0_2[self.heroID_].idle, true)
	end
end

function GoldMinerGameView:CreatStage()
	self.levelData_ = cjson.decode((AssetEx.LoadText("GoldMinerLevelData/" .. self.subActivityID_ .. ".json")))
	self.levelId_ = self.levelData_.levelId

	GoldMinerManager.GetInstance():Init(self, self.container_, self.hook_)

	for iter_19_0, iter_19_1 in ipairs(self.levelData_.fishes) do
		local var_19_0 = Object.Instantiate(Asset.Load("UI/Fishing/Game/Fishes/" .. iter_19_1.fishId), self.container_)

		var_19_0.transform.localPosition = Vector2(iter_19_1.posX + var_19_0.transform.rect.width / 2, -iter_19_1.posY - var_19_0.transform.rect.height / 2)
		var_19_0.transform.localScale = Vector3.New(iter_19_1.scaleX / 1000, iter_19_1.scaleY / 1000, 1)

		local var_19_1 = GoldMinerThingItem.New(var_19_0)

		var_19_1:SetData(iter_19_1, iter_19_0)
		GoldMinerManager.GetInstance():AddThing(var_19_1)

		if iter_19_1.moveable == 1 then
			local var_19_2 = Object.Instantiate(Asset.Load("UI/Fishing/Game/Fishes/platform"), self.container_)
			local var_19_3 = var_19_2.transform:Find("platContain")
			local var_19_4 = var_19_3:Find("plat")

			var_19_3.sizeDelta = Vector2(iter_19_1.radius * 2 - 400, 76)

			for iter_19_2 = 1, (iter_19_1.radius * 2 - 400) / 200 do
				SetActive(Object.Instantiate(var_19_4, var_19_3), true)
			end

			var_19_2.transform.localPosition = Vector2(iter_19_1.posX + var_19_0.transform.rect.width / 2 - 100, -iter_19_1.posY - var_19_0.transform.rect.height / 2 - (iter_19_1.fishId == 10 and 70 or 120))

			GoldMinerManager.GetInstance():AddNoDataGo(var_19_2)
		end
	end

	for iter_19_3, iter_19_4 in ipairs(self.levelData_.thiefs) do
		local var_19_5 = Object.Instantiate(Asset.Load("Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_GoldenMiner/thief"), self.container_)

		var_19_5.transform.pivot = Vector2(0.813, 0.1)
		var_19_5.transform.localPosition = Vector2(iter_19_4.posX + var_19_5.transform.rect.width * 0.813, -iter_19_4.posY - var_19_5.transform.rect.height * 0.9)
		var_19_5.transform.localScale = Vector3.New(iter_19_4.scaleX / 1000, iter_19_4.scaleY / 1000, 0)

		local var_19_6 = GoldMinerThief.New(var_19_5)

		var_19_6:SetData(iter_19_4)
		GoldMinerManager.GetInstance():AddThief(var_19_6)
	end
end

function GoldMinerGameView:PlayEnterAni()
	self.guideTimer_ = Timer.New(function()
		if manager.guide:IsPlaying() then
			return
		end

		self:PlayAudio("countDown")
		SetActive(self.enterGo_, true)

		self.enterTimer_ = Timer.New(function()
			SetActive(self.enterGo_, false)
			self:UpdateBar()
			GoldMinerManager.GetInstance():StartGame(self.cfg_.time)

			self.entered_ = true

			self:StopTimer()
		end, 3.8, 1)

		self.enterTimer_:Start()
		self.guideTimer_:Stop()

		self.guideTimer_ = nil
	end, 0.33, -1)

	self.guideTimer_:Start()
end

function GoldMinerGameView:PlayRoleSpine(arg_23_1, arg_23_2)
	if self.isIdle_ == false then
		return
	end

	self.selectedSpine_.timeScale = arg_23_2 or 1

	self.selectedSpine_.AnimationState:SetAnimation(0, var_0_2[self.heroID_][arg_23_1], false)

	self.isIdle_ = false
end

function GoldMinerGameView:StopTimer()
	if self.enterTimer_ then
		self.enterTimer_:Stop()

		self.enterTimer_ = nil
	end

	if self.guideTimer_ then
		self.guideTimer_:Stop()

		self.guideTimer_ = nil
	end
end

function GoldMinerGameView:Update(arg_25_1, arg_25_2)
	if arg_25_2 < 0 then
		arg_25_2 = 0
	end

	self.timeText_.text = tostring(math.floor(arg_25_2))

	if self.timeRedTrigger_ == false and math.floor(arg_25_2) < 10 then
		self.timeRedTrigger_ = true

		self.timeAni_:Play("red")
	end

	if self.skillUsingSecond_ > 0 then
		self.skillUsingSecond_ = self.skillUsingSecond_ - arg_25_1

		if self.skillUsingSecond_ < 0 then
			self.skillUsingSecond_ = 0
		end

		local var_25_0 = math.floor(self.skillUsingSecond_)

		self.skillUsingTimeText_.text = tostring(var_25_0)
		self.skillUsingFillImage_.fillAmount = var_25_0 / self.heroCfg_.last_time

		if self.skillUsingSecond_ == 0 then
			self:RefreshSkillInfo()
			self.hook_:ClearSkill()
			SetActive(self.addPointSkillEffectGo_, false)
			SetActive(self.addSpeedSkillEffectGo_, false)
			SetActive(self.addSpeedSkillHookEffectGo_, false)
		end
	end

	if GoldMinerManager.GetInstance():GetIsEnd() then
		if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_GOLDMINER) then
			GoldMinerManager.GetInstance():SendMessageToSDK(self.subActivityID_, self.heroID_, self.useHookNum_, self.useBoomNum_, self.useSkillNum_)

			local var_25_1 = GoldMinerManager.GetInstance():GetScore()
			local var_25_2 = 0

			for iter_25_0, iter_25_1 in pairs(ActivityGodEaterGoldminerStageCfg[self.subActivityID_].score) do
				if iter_25_1 <= var_25_1 then
					var_25_2 = iter_25_0
				end
			end

			GodEaterAction.GoldMinerFinishStage(ActivityConst.ACTIVITY_GOLDMINER, self.subActivityID_, var_25_2, GoldMinerManager.GetInstance():GetPropList(), function(arg_26_0, arg_26_1)
				GodEaterData:SetStageStar(arg_26_1.stage_id, var_25_2)
				JumpTools.OpenPageByJump("/goldMinerGameEndView", {
					stageID = arg_26_1.stage_id,
					star = var_25_2,
					reward_list = arg_26_0.reward_list
				})
			end)
		else
			ShowTips("TIME_OVER")
			JumpTools.Back()
		end
	end
end

function GoldMinerGameView:RefreshSkillInfo()
	if self.skillCurPoint_ >= self.skillNeedPoint_ then
		self.skillPointFillImage_.fillAmount = 1

		self.skillStateController_:SetSelectedState("ready")

		if not self.isPlayLoadedEffct_ then
			self:PlayAudio("skillLoaded")

			self.isPlayLoadedEffct_ = true
		end
	else
		self.skillPointFillImage_.fillAmount = self.skillCurPoint_ / self.skillNeedPoint_

		self.skillStateController_:SetSelectedState("charge")
	end

	if self.skillUsingSecond_ > 0 then
		self.skillUsingController_:SetSelectedState("true")
	else
		self.skillUsingController_:SetSelectedState("false")
	end
end

function GoldMinerGameView:SubBoom(arg_28_1)
	self.boomNum_ = self.boomNum_ + arg_28_1

	self:RefreshBoomNum(self.boomNum_)
end

function GoldMinerGameView:RefreshBoomNum(arg_29_1)
	if arg_29_1 > 0 then
		SetActive(self.boomGo_, true)

		self.boomNumText_.text = arg_29_1
	else
		SetActive(self.boomGo_, false)
	end
end

function GoldMinerGameView:UpdateScore(arg_30_1, arg_30_2)
	self.pointText_.text = arg_30_1

	local var_30_0 = false

	for iter_30_0 = 1, 3 do
		if self.cfg_.score[iter_30_0] <= arg_30_1 then
			self["starController" .. iter_30_0 .. "_"]:SetSelectedState("light")
		else
			self["starController" .. iter_30_0 .. "_"]:SetSelectedState("grey")

			if var_30_0 == false then
				var_30_0 = true
				self.fillImage_.fillAmount = iter_30_0 > 1 and (iter_30_0 - 1) * 0.3 + (arg_30_1 - self.cfg_.score[iter_30_0 - 1]) / (self.cfg_.score[iter_30_0] - self.cfg_.score[iter_30_0 - 1]) * 0.3 or (iter_30_0 - 1) * 0.3 + arg_30_1 / self.cfg_.score[iter_30_0] * 0.3
			end
		end
	end

	if var_30_0 == false then
		self.fillImage_.fillAmount = arg_30_1 >= self.cfg_.score[3] and 1 or 0.6 + (arg_30_1 - self.cfg_.score[2]) / (self.cfg_.score[3] - self.cfg_.score[2]) * 0.3
	end

	if arg_30_2 and arg_30_2 ~= 0 then
		self:AddPointWithTimer(arg_30_2)

		if arg_30_2 > 0 then
			self:PlayAudio("get")

			self.skillCurPoint_ = self.skillCurPoint_ + arg_30_2

			self:RefreshSkillInfo()
		end
	end
end

function GoldMinerGameView:OnExit()
	GoldMinerManager.GetInstance():Dispose()
	manager.windowBar:HideBar()
	manager.audio:StopEffect()
	self:StopTimer()

	if self.oriFrame_ and self.oriFrame_ ~= 1 then
		SettingAction.ChangePicSetting("frame", self.oriFrame_)
	end
end

function GoldMinerGameView:OnTop()
	GoldMinerManager.GetInstance():ReStart()
	manager.audio:Pause("effect", false)

	if self.entered_ then
		self:UpdateBar()
	end
end

function GoldMinerGameView:OnBehind()
	GoldMinerManager.GetInstance():Pause()
end

function GoldMinerGameView:Cacheable()
	return false
end

function GoldMinerGameView:AddPointWithTimer(arg_35_1)
	if arg_35_1 > 0 then
		self.viewAni_:Play("Trail")
	else
		self.viewAni_:Play("Sub")
	end

	self.viewAni_:Update(0)

	if arg_35_1 > 0 then
		self.pointController_:SetSelectedState("plus")

		self.addPointText_.text = "+" .. arg_35_1
	else
		self.pointController_:SetSelectedState("reduce")

		self.subPointText_.text = "-" .. arg_35_1
	end
end

function GoldMinerGameView:PlayAudio(arg_36_1)
	if self.lastPlayAudio_ == var_0_3[arg_36_1] then
		return
	end

	self.lastPlayAudio_ = var_0_3[arg_36_1]

	manager.audio:PlayEffect("minigame_activity_4_2", self.lastPlayAudio_, "")
end

function GoldMinerGameView:Dispose()
	self:StopTimer()
	GoldMinerManager.GetInstance():Dispose()
	GoldMinerGameView.super.Dispose(self)
end

return GoldMinerGameView
