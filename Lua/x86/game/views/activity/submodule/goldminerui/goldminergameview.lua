local var_0_0 = require("cjson")
local var_0_1 = class("GoldMinerGameView", ReduxView)
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

function var_0_1.UIName(arg_1_0)
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_GoldenMiner/V4_2_GodEaterUI_GoldenMiner_GamePlayUI"
end

function var_0_1.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_1.OnCtor(arg_3_0)
	return
end

function var_0_1.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_1.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.addPointTimer_ = nil
	arg_5_0.roleSpine = {}
	arg_5_0.roleSpine[1045] = arg_5_0.alisaSpineGo_:GetComponent("Spine.Unity.SkeletonGraphic")
	arg_5_0.roleSpine[1046] = arg_5_0.cielSpineGo_:GetComponent("Spine.Unity.SkeletonGraphic")
	arg_5_0.roleController_ = arg_5_0.transCon_:GetController("role")
	arg_5_0.pointController_ = arg_5_0.pointControllerEx_:GetController("type")
	arg_5_0.starController1_ = arg_5_0.starControllerEx1_:GetController("state")
	arg_5_0.starController2_ = arg_5_0.starControllerEx2_:GetController("state")
	arg_5_0.starController3_ = arg_5_0.starControllerEx3_:GetController("state")
	arg_5_0.skillStateController_ = arg_5_0.skillControllerEx_:GetController("state")
	arg_5_0.skillUsingController_ = arg_5_0.skillControllerEx_:GetController("using")
	arg_5_0.hook_ = GoldMinerHook.New(arg_5_0.hookGo_, arg_5_0)

	arg_5_0.hook_:RegisterBackFunc(function()
		arg_5_0:PlayRoleSpine("back")
	end)

	arg_5_0.boomNum_ = 0
	arg_5_0.skillNeedPoint_ = 0
	arg_5_0.skillCurPoint_ = 0
	arg_5_0.skillUsingSecond_ = 0
	arg_5_0.timeRedTrigger_ = false
	arg_5_0.entered_ = false
end

function var_0_1.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.hookBtn_, nil, function()
		if arg_7_0.hook_ and arg_7_0.hook_:StartHooking() then
			arg_7_0.useHookNum_ = arg_7_0.useHookNum_ + 1

			arg_7_0:PlayRoleSpine("pat")
			arg_7_0:PlayAudio("pat")
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.boomBtn_, nil, function()
		if arg_7_0.hook_ and arg_7_0.hook_:TryToBoom() then
			arg_7_0.useBoomNum_ = arg_7_0.useBoomNum_ + 1

			arg_7_0:PlayRoleSpine("throw")
			arg_7_0:PlayAudio("boom")
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.skillBtn_, nil, function()
		if arg_7_0.skillUsingSecond_ > 0 then
			return
		end

		if arg_7_0.skillCurPoint_ >= arg_7_0.skillNeedPoint_ then
			arg_7_0:PlayAudio("skill")

			arg_7_0.isPlayLoadedEffct_ = false
			arg_7_0.skillCurPoint_ = 0
			arg_7_0.skillUsingSecond_ = arg_7_0.heroCfg_.last_time

			arg_7_0.hook_:UseSkill(arg_7_0.heroID_)

			if arg_7_0.heroID_ == 1045 then
				SetActive(arg_7_0.addPointSkillEffectGo_, true)
			elseif arg_7_0.heroID_ == 1046 then
				SetActive(arg_7_0.addSpeedSkillHookEffectGo_, true)
				SetActive(arg_7_0.addSpeedSkillEffectGo_, true)
			end

			arg_7_0:RefreshSkillInfo()

			arg_7_0.useSkillNum_ = arg_7_0.useSkillNum_ + 1
		else
			ShowTips(GetTips("GOLDMINER_SKILL_CHARGE"))
		end
	end)
end

function var_0_1.UpdateBar(arg_11_0)
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
				GoldMinerManager.GetInstance():SendMessageToSDK(arg_11_0.subActivityID_, arg_11_0.heroID_, arg_11_0.useHookNum_, arg_11_0.useBoomNum_, arg_11_0.useSkillNum_)
				arg_11_0:Back(2)
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

function var_0_1.OnEnter(arg_16_0)
	arg_16_0.entered_ = false
	arg_16_0.subActivityID_ = arg_16_0.params_.subActivityID
	arg_16_0.heroID_ = arg_16_0.params_.heroID
	arg_16_0.heroCfg_ = ActivityGodEaterGoldminerHeroCfg[arg_16_0.heroID_]
	arg_16_0.skillNeedPoint_ = arg_16_0.heroCfg_.skill_charge
	arg_16_0.useBoomNum_ = 0
	arg_16_0.useHookNum_ = 0
	arg_16_0.boomNum_ = arg_16_0.heroCfg_.boom or 0
	arg_16_0.useSkillNum_ = 0
	arg_16_0.lastPlayAudio_ = nil

	arg_16_0:RefreshView()
	arg_16_0:CreatStage()
	arg_16_0:RefreshBoomNum(arg_16_0.boomNum_)
	arg_16_0:UpdateScore(0)
	arg_16_0:RefreshSkillInfo()
	arg_16_0.timeAni_:Play("normal")

	arg_16_0.oriFrame_ = GameLocalData:GetCommonModule("userSetting").frame or PictureQualitySettingCfg[5].frame

	if arg_16_0.oriFrame_ ~= 1 then
		SettingAction.ChangePicSetting("frame", 1)
	end

	arg_16_0:PlayEnterAni()
end

function var_0_1.RefreshView(arg_17_0)
	arg_17_0.cfg_ = ActivityGodEaterGoldminerStageCfg[arg_17_0.subActivityID_]
	arg_17_0.needPointText1_.text = arg_17_0.cfg_.score[1]
	arg_17_0.needPointText2_.text = arg_17_0.cfg_.score[2]
	arg_17_0.needPointText3_.text = arg_17_0.cfg_.score[3]
	arg_17_0.timeText_.text = arg_17_0.cfg_.time
	arg_17_0.skillImage_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/V4_2_GodEaterUI/V4_2_GodEaterUI_GoldenMiner/" .. arg_17_0.heroID_ .. "_goldminer_skill")

	arg_17_0.roleController_:SetSelectedState(arg_17_0.heroID_)

	arg_17_0.selectedSpine_ = arg_17_0.roleSpine[arg_17_0.heroID_]
	arg_17_0.selectedSpine_.startingLoop = true
	arg_17_0.selectedSpine_.AnimationState.Complete = arg_17_0.selectedSpine_.AnimationState.Complete + function()
		arg_17_0.isIdle_ = true

		arg_17_0.selectedSpine_.AnimationState:SetAnimation(0, var_0_2[arg_17_0.heroID_].idle, true)
	end
end

function var_0_1.CreatStage(arg_19_0)
	local var_19_0 = AssetEx.LoadText("GoldMinerLevelData/" .. arg_19_0.subActivityID_ .. ".json")

	arg_19_0.levelData_ = var_0_0.decode(var_19_0)
	arg_19_0.levelId_ = arg_19_0.levelData_.levelId

	local var_19_1 = arg_19_0.levelData_.fishes
	local var_19_2 = arg_19_0.levelData_.thiefs

	GoldMinerManager.GetInstance():Init(arg_19_0, arg_19_0.container_, arg_19_0.hook_)

	for iter_19_0, iter_19_1 in ipairs(var_19_1) do
		local var_19_3 = Asset.Load("UI/Fishing/Game/Fishes/" .. iter_19_1.fishId)
		local var_19_4 = Object.Instantiate(var_19_3, arg_19_0.container_)

		var_19_4.transform.localPosition = Vector2(iter_19_1.posX + var_19_4.transform.rect.width / 2, -iter_19_1.posY - var_19_4.transform.rect.height / 2)
		var_19_4.transform.localScale = Vector3.New(iter_19_1.scaleX / 1000, iter_19_1.scaleY / 1000, 1)

		local var_19_5 = GoldMinerThingItem.New(var_19_4)

		var_19_5:SetData(iter_19_1, iter_19_0)
		GoldMinerManager.GetInstance():AddThing(var_19_5)

		if iter_19_1.moveable == 1 then
			local var_19_6 = Asset.Load("UI/Fishing/Game/Fishes/platform")
			local var_19_7 = Object.Instantiate(var_19_6, arg_19_0.container_)
			local var_19_8 = var_19_7.transform:Find("platContain")
			local var_19_9 = var_19_8:Find("plat")

			var_19_8.sizeDelta = Vector2(iter_19_1.radius * 2 - 400, 76)

			local var_19_10 = (iter_19_1.radius * 2 - 400) / 200

			for iter_19_2 = 1, var_19_10 do
				local var_19_11 = Object.Instantiate(var_19_9, var_19_8)

				SetActive(var_19_11, true)
			end

			local var_19_12 = iter_19_1.fishId == 10 and 70 or 120

			var_19_7.transform.localPosition = Vector2(iter_19_1.posX + var_19_4.transform.rect.width / 2 - 100, -iter_19_1.posY - var_19_4.transform.rect.height / 2 - var_19_12)

			GoldMinerManager.GetInstance():AddNoDataGo(var_19_7)
		end
	end

	for iter_19_3, iter_19_4 in ipairs(var_19_2) do
		local var_19_13 = Asset.Load("Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_GoldenMiner/thief")
		local var_19_14 = Object.Instantiate(var_19_13, arg_19_0.container_)

		var_19_14.transform.pivot = Vector2(0.813, 0.1)
		var_19_14.transform.localPosition = Vector2(iter_19_4.posX + var_19_14.transform.rect.width * 0.813, -iter_19_4.posY - var_19_14.transform.rect.height * 0.9)
		var_19_14.transform.localScale = Vector3.New(iter_19_4.scaleX / 1000, iter_19_4.scaleY / 1000, 0)

		local var_19_15 = GoldMinerThief.New(var_19_14)

		var_19_15:SetData(iter_19_4)
		GoldMinerManager.GetInstance():AddThief(var_19_15)
	end
end

function var_0_1.PlayEnterAni(arg_20_0)
	arg_20_0.guideTimer_ = Timer.New(function()
		if manager.guide:IsPlaying() then
			return
		end

		arg_20_0:PlayAudio("countDown")
		SetActive(arg_20_0.enterGo_, true)

		arg_20_0.enterTimer_ = Timer.New(function()
			SetActive(arg_20_0.enterGo_, false)
			arg_20_0:UpdateBar()
			GoldMinerManager.GetInstance():StartGame(arg_20_0.cfg_.time)

			arg_20_0.entered_ = true

			arg_20_0:StopTimer()
		end, 3.8, 1)

		arg_20_0.enterTimer_:Start()
		arg_20_0.guideTimer_:Stop()

		arg_20_0.guideTimer_ = nil
	end, 0.33, -1)

	arg_20_0.guideTimer_:Start()
end

function var_0_1.PlayRoleSpine(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0.isIdle_ == false then
		return
	end

	arg_23_0.selectedSpine_.timeScale = arg_23_2 or 1

	arg_23_0.selectedSpine_.AnimationState:SetAnimation(0, var_0_2[arg_23_0.heroID_][arg_23_1], false)

	arg_23_0.isIdle_ = false
end

function var_0_1.StopTimer(arg_24_0)
	if arg_24_0.enterTimer_ then
		arg_24_0.enterTimer_:Stop()

		arg_24_0.enterTimer_ = nil
	end

	if arg_24_0.guideTimer_ then
		arg_24_0.guideTimer_:Stop()

		arg_24_0.guideTimer_ = nil
	end
end

function var_0_1.Update(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_2 < 0 then
		arg_25_2 = 0
	end

	arg_25_0.timeText_.text = tostring(math.floor(arg_25_2))

	if arg_25_0.timeRedTrigger_ == false and math.floor(arg_25_2) < 10 then
		arg_25_0.timeRedTrigger_ = true

		arg_25_0.timeAni_:Play("red")
	end

	if arg_25_0.skillUsingSecond_ > 0 then
		arg_25_0.skillUsingSecond_ = arg_25_0.skillUsingSecond_ - arg_25_1

		if arg_25_0.skillUsingSecond_ < 0 then
			arg_25_0.skillUsingSecond_ = 0
		end

		local var_25_0 = math.floor(arg_25_0.skillUsingSecond_)

		arg_25_0.skillUsingTimeText_.text = tostring(var_25_0)
		arg_25_0.skillUsingFillImage_.fillAmount = var_25_0 / arg_25_0.heroCfg_.last_time

		if arg_25_0.skillUsingSecond_ == 0 then
			arg_25_0:RefreshSkillInfo()
			arg_25_0.hook_:ClearSkill()
			SetActive(arg_25_0.addPointSkillEffectGo_, false)
			SetActive(arg_25_0.addSpeedSkillEffectGo_, false)
			SetActive(arg_25_0.addSpeedSkillHookEffectGo_, false)
		end
	end

	if GoldMinerManager.GetInstance():GetIsEnd() then
		if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_GOLDMINER) then
			GoldMinerManager.GetInstance():SendMessageToSDK(arg_25_0.subActivityID_, arg_25_0.heroID_, arg_25_0.useHookNum_, arg_25_0.useBoomNum_, arg_25_0.useSkillNum_)

			local var_25_1 = ActivityGodEaterGoldminerStageCfg[arg_25_0.subActivityID_]
			local var_25_2 = GoldMinerManager.GetInstance():GetScore()
			local var_25_3 = 0

			for iter_25_0, iter_25_1 in pairs(var_25_1.score) do
				if iter_25_1 <= var_25_2 then
					var_25_3 = iter_25_0
				end
			end

			local var_25_4 = GoldMinerManager.GetInstance():GetPropList()

			GodEaterAction.GoldMinerFinishStage(ActivityConst.ACTIVITY_GOLDMINER, arg_25_0.subActivityID_, var_25_3, var_25_4, function(arg_26_0, arg_26_1)
				GodEaterData:SetStageStar(arg_26_1.stage_id, var_25_3)
				JumpTools.OpenPageByJump("/goldMinerGameEndView", {
					stageID = arg_26_1.stage_id,
					star = var_25_3,
					reward_list = arg_26_0.reward_list
				})
			end)
		else
			ShowTips("TIME_OVER")
			JumpTools.Back()
		end
	end
end

function var_0_1.RefreshSkillInfo(arg_27_0)
	if arg_27_0.skillCurPoint_ >= arg_27_0.skillNeedPoint_ then
		arg_27_0.skillPointFillImage_.fillAmount = 1

		arg_27_0.skillStateController_:SetSelectedState("ready")

		if not arg_27_0.isPlayLoadedEffct_ then
			arg_27_0:PlayAudio("skillLoaded")

			arg_27_0.isPlayLoadedEffct_ = true
		end
	else
		arg_27_0.skillPointFillImage_.fillAmount = arg_27_0.skillCurPoint_ / arg_27_0.skillNeedPoint_

		arg_27_0.skillStateController_:SetSelectedState("charge")
	end

	if arg_27_0.skillUsingSecond_ > 0 then
		arg_27_0.skillUsingController_:SetSelectedState("true")
	else
		arg_27_0.skillUsingController_:SetSelectedState("false")
	end
end

function var_0_1.SubBoom(arg_28_0, arg_28_1)
	arg_28_0.boomNum_ = arg_28_0.boomNum_ + arg_28_1

	arg_28_0:RefreshBoomNum(arg_28_0.boomNum_)
end

function var_0_1.RefreshBoomNum(arg_29_0, arg_29_1)
	if arg_29_1 > 0 then
		SetActive(arg_29_0.boomGo_, true)

		arg_29_0.boomNumText_.text = arg_29_1
	else
		SetActive(arg_29_0.boomGo_, false)
	end
end

function var_0_1.UpdateScore(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0.pointText_.text = arg_30_1

	local var_30_0 = false

	for iter_30_0 = 1, 3 do
		local var_30_1 = arg_30_0.cfg_.score[iter_30_0]

		if var_30_1 <= arg_30_1 then
			arg_30_0["starController" .. iter_30_0 .. "_"]:SetSelectedState("light")
		else
			arg_30_0["starController" .. iter_30_0 .. "_"]:SetSelectedState("grey")

			if var_30_0 == false then
				var_30_0 = true

				local var_30_2

				if iter_30_0 > 1 then
					local var_30_3 = var_30_1 - arg_30_0.cfg_.score[iter_30_0 - 1]

					arg_30_0.fillImage_.fillAmount = (iter_30_0 - 1) * 0.3 + (arg_30_1 - arg_30_0.cfg_.score[iter_30_0 - 1]) / var_30_3 * 0.3
				else
					local var_30_4 = var_30_1

					arg_30_0.fillImage_.fillAmount = (iter_30_0 - 1) * 0.3 + arg_30_1 / var_30_4 * 0.3
				end
			end
		end
	end

	if var_30_0 == false then
		if arg_30_1 >= arg_30_0.cfg_.score[3] then
			arg_30_0.fillImage_.fillAmount = 1
		else
			local var_30_5
			local var_30_6 = arg_30_0.cfg_.score[3] - arg_30_0.cfg_.score[2]

			arg_30_0.fillImage_.fillAmount = 0.6 + (arg_30_1 - arg_30_0.cfg_.score[2]) / var_30_6 * 0.3
		end
	end

	if arg_30_2 and arg_30_2 ~= 0 then
		arg_30_0:AddPointWithTimer(arg_30_2)

		if arg_30_2 > 0 then
			arg_30_0:PlayAudio("get")

			arg_30_0.skillCurPoint_ = arg_30_0.skillCurPoint_ + arg_30_2

			arg_30_0:RefreshSkillInfo()
		end
	end
end

function var_0_1.OnExit(arg_31_0)
	GoldMinerManager.GetInstance():Dispose()
	manager.windowBar:HideBar()
	manager.audio:StopEffect()
	arg_31_0:StopTimer()

	if arg_31_0.oriFrame_ and arg_31_0.oriFrame_ ~= 1 then
		SettingAction.ChangePicSetting("frame", arg_31_0.oriFrame_)
	end
end

function var_0_1.OnTop(arg_32_0)
	GoldMinerManager.GetInstance():ReStart()
	manager.audio:Pause("effect", false)

	if arg_32_0.entered_ then
		arg_32_0:UpdateBar()
	end
end

function var_0_1.OnBehind(arg_33_0)
	GoldMinerManager.GetInstance():Pause()
end

function var_0_1.Cacheable(arg_34_0)
	return false
end

function var_0_1.AddPointWithTimer(arg_35_0, arg_35_1)
	if arg_35_1 > 0 then
		arg_35_0.viewAni_:Play("Trail")
	else
		arg_35_0.viewAni_:Play("Sub")
	end

	arg_35_0.viewAni_:Update(0)

	if arg_35_1 > 0 then
		arg_35_0.pointController_:SetSelectedState("plus")

		arg_35_0.addPointText_.text = "+" .. arg_35_1
	else
		arg_35_0.pointController_:SetSelectedState("reduce")

		arg_35_0.subPointText_.text = "-" .. arg_35_1
	end
end

function var_0_1.PlayAudio(arg_36_0, arg_36_1)
	if arg_36_0.lastPlayAudio_ == var_0_3[arg_36_1] then
		return
	end

	arg_36_0.lastPlayAudio_ = var_0_3[arg_36_1]

	manager.audio:PlayEffect("minigame_activity_4_2", arg_36_0.lastPlayAudio_, "")
end

function var_0_1.Dispose(arg_37_0)
	arg_37_0:StopTimer()
	GoldMinerManager.GetInstance():Dispose()
	var_0_1.super.Dispose(arg_37_0)
end

return var_0_1
