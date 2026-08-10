local var_0_0 = {}
local var_0_1 = require("cjson")
local var_0_2 = 2520

function var_0_0.GetMainUIName(arg_1_0)
	if ActivityConst.VOLUME_III_COWBOY == arg_1_0 then
		return "UI/VolumeIIIUI/VolumeWindAndFarceMainUI"
	else
		return "UI/VolumeIIIUI/VolumeWindAndFarceMainUI"
	end
end

function var_0_0.GetGameHelpKey(arg_2_0)
	if ActivityConst.VOLUME_III_COWBOY == arg_2_0 then
		return "ACTIVITY_COWBOY_TIPS"
	else
		return ""
	end
end

function var_0_0.GetGameUIName(arg_3_0)
	if ActivityConst.VOLUME_III_COWBOY == arg_3_0 then
		return "UI/VolumeIIIUI/VolumeWindAndFarceUI"
	else
		return "UI/VolumeIIIUI/VolumeWindAndFarceUI"
	end
end

function var_0_0.GetInfoUIName(arg_4_0)
	if ActivityConst.VOLUME_III_COWBOY == arg_4_0 then
		return "UI/VolumeIIIUI/VolumeXiuGameruleUI"
	else
		return "UI/VolumeIIIUI/VolumeXiuGameruleUI"
	end
end

function var_0_0.LoadCowboyLevel(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = SceneManager.GetSceneByName("X105")

	if var_5_0 and var_5_0.isLoaded == true then
		return
	end

	if arg_5_0.operation_ then
		return
	end

	arg_5_0.callback_ = arg_5_1
	arg_5_0.onTimeChange_ = arg_5_2
	arg_5_0.onScoreChange_ = arg_5_3
	arg_5_0.onAttack_ = arg_5_4
	arg_5_0.operation_ = Asset.LoadLevelAsync("Levels/X105", true)
	arg_5_0.raycaster_ = manager.ui.mainCamera:AddComponent(typeof(Physics2DRaycaster))

	if arg_5_0.loadTimer_ then
		arg_5_0.loadTimer_:Stop()

		arg_5_0.loadTimer_ = nil
	end

	arg_5_0.loadTimer_ = FrameTimer.New(handler(arg_5_0, arg_5_0.Process), 1, -1)

	arg_5_0.loadTimer_:Start()
end

function var_0_0.Process(arg_6_0)
	if arg_6_0.operation_:IsDone() then
		if not gameContext:GetOpenPageHandler("cowboyGame") then
			local var_6_0 = SceneManager.GetSceneByName("X105")

			if var_6_0 and var_6_0.isLoaded == true then
				SceneManager.UnLoadSceneAsync("X105")
			end
		end

		if arg_6_0.loadTimer_ then
			arg_6_0.loadTimer_:Stop()

			arg_6_0.loadTimer_ = nil
		end

		arg_6_0.operation_ = nil

		if arg_6_0.callback_ then
			arg_6_0.callback_()
		end

		arg_6_0.callback_ = nil
	end
end

function var_0_0.InitCowboySence(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.mainActivityID_ = arg_7_1
	arg_7_0.activityID_ = arg_7_2

	local var_7_0 = arg_7_0:GetBgGo()

	ComponentBinder.GetInstance():BindCfgUI(arg_7_0, var_7_0)
	arg_7_0:GameEnter()
end

function var_0_0.GetBgGo(arg_8_0)
	local var_8_0
	local var_8_1

	if SceneManager.GetSceneByName("X105").rootCount > 0 then
		var_8_0 = SceneManager.GetSceneByName("X105"):GetRootGameObjects()
	end

	if var_8_0 then
		for iter_8_0 = 0, var_8_0.Length - 1 do
			if var_8_0[iter_8_0].name == "bg" then
				var_8_1 = var_8_0[iter_8_0]
			end
		end
	end

	return var_8_1
end

function var_0_0.GameEnter(arg_9_0)
	arg_9_0.cowboyData_ = {}
	arg_9_0.cows_ = {}
	arg_9_0.cowboyGo_ = nil
	arg_9_0.aniController_ = nil
	arg_9_0.cowboyState_ = ""
	arg_9_0.frameTimer_ = nil
	arg_9_0.totalTime_ = 0
	arg_9_0.curTime_ = 0
	arg_9_0.isEnd_ = false
	arg_9_0.isPausing_ = false
	arg_9_0.score_ = 0
	arg_9_0.cowIndex_ = 1
	arg_9_0.show_ = {}
	arg_9_0.unshow_ = {}
	arg_9_0.cowIDList_ = {}
	arg_9_0.attackTimer_ = nil

	arg_9_0:GetTempCorners()
	arg_9_0:AssetData()
	arg_9_0:DrawCowboy()
	arg_9_0:Start()
end

function var_0_0.GetTempCorners(arg_10_0)
	if arg_10_0.corners == nil then
		arg_10_0.corners = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
	end
end

function var_0_0.AssetData(arg_11_0)
	local var_11_0 = AssetEx.LoadText("Cowboy/CowboyData_" .. arg_11_0.mainActivityID_)

	arg_11_0.cowboyData_ = var_0_1.decode(var_11_0)

	local var_11_1 = ActivityCfg[arg_11_0.mainActivityID_].sub_activity_list
	local var_11_2 = table.indexof(var_11_1, arg_11_0.activityID_)

	arg_11_0.cows_ = arg_11_0.cowboyData_.LevelInfos[var_11_2].cows
	arg_11_0.totalTime_ = arg_11_0.cowboyData_.LevelInfos[var_11_2].timeLimit
end

function var_0_0.DrawCowboy(arg_12_0)
	local var_12_0 = Object.Instantiate(arg_12_0["cowboy_" .. arg_12_0.cowboyData_.cowboyId], arg_12_0.container_.transform)

	var_12_0.transform.localPosition = Vector2(arg_12_0.cowboyData_.cowboyPosX, -arg_12_0.cowboyData_.cowboyPosY)
	arg_12_0.cowboyGo_ = var_12_0
	arg_12_0.aniController_ = arg_12_0.cowboyGo_:GetComponent("Animator")

	for iter_12_0 = 0, arg_12_0.aniController_.runtimeAnimatorController.animationClips.Length - 1 do
		local var_12_1 = arg_12_0.aniController_.runtimeAnimatorController.animationClips[iter_12_0]

		if var_12_1.name == "attack" then
			arg_12_0.attackTime_ = var_12_1.length

			break
		end
	end

	local var_12_2 = var_12_0:GetComponent("SpriteRenderer").sprite.texture
	local var_12_3 = var_12_0:GetComponent("SpriteRenderer").size
	local var_12_4 = var_12_3.x / var_12_2.width
	local var_12_5 = var_12_3.y / var_12_2.height

	arg_12_0.hitLeft_ = var_12_3.x / 2 - arg_12_0.cowboyData_.hitLeft * var_12_4
	arg_12_0.hitRight_ = var_12_3.x / 2 - arg_12_0.cowboyData_.hitRight * var_12_4

	SetActive(arg_12_0.cowboyGo_, true)
end

function var_0_0.Start(arg_13_0)
	arg_13_0.curTime_ = arg_13_0.totalTime_
	arg_13_0.score_ = 0
	arg_13_0.isEnd_ = false
	arg_13_0.isPausing_ = false
	arg_13_0.cowboyState_ = "run"
	arg_13_0.cowIndex_ = 1
	arg_13_0.show_ = {}
	arg_13_0.unshow_ = {}

	manager.audio:Pause("music", false)
	manager.audio:Pause("effect", false)

	arg_13_0.oriFrame_ = GameLocalData:GetCommonModule("userSetting").frame or PictureQualitySettingCfg[5].frame

	if arg_13_0.oriFrame_ == 0 then
		SettingAction.ChangePicSetting("frame", 1)
	end

	if not arg_13_0.frameTimer_ then
		arg_13_0.frameTimer_ = FrameTimer.New(handler(arg_13_0, arg_13_0.Update), 1, -1)
	end

	manager.audio:PlayBGM("bgm_activity_1_3_1_minigame_main", "bgm_activity_1_3_1_minigame_main", "bgm_activity_1_3_1_minigame_main.awb")
	arg_13_0.frameTimer_:Start()
end

function var_0_0.Update(arg_14_0)
	if arg_14_0.isPausing_ then
		return
	end

	arg_14_0:UpdateSelf()

	if arg_14_0.isEnd_ then
		arg_14_0:EndGame()

		return
	end

	local var_14_0 = Time.deltaTime

	arg_14_0:PlayCowRun()
	arg_14_0:CheckReCow()
	arg_14_0:CheckNewCow()
	arg_14_0:CheckGet()

	arg_14_0.curTime_ = arg_14_0.curTime_ - var_14_0

	if arg_14_0.curTime_ < 0 then
		arg_14_0.isEnd_ = true
	end
end

function var_0_0.EndGame(arg_15_0)
	manager.audio:Pause("music", true)
	arg_15_0:Pause()

	if ActivityTools.ActivityOpenCheckByMessageBox(arg_15_0.mainActivityID_, function()
		JumpTools.OpenPageByJump("/cowboy", {
			activityId = arg_15_0.mainActivityID_
		})
	end) then
		CowboyAction:SendActivityInfo(arg_15_0.mainActivityID_, arg_15_0.activityID_, arg_15_0.score_, function()
			JumpTools.OpenPageByJump("cowboyGameOver", {
				mainActivityID = arg_15_0.mainActivityID_,
				activityID = arg_15_0.activityID_,
				score = arg_15_0.score_
			})
		end)
	end
end

function var_0_0.UpdateSelf(arg_18_0)
	local var_18_0 = arg_18_0.curTime_ > 0 and arg_18_0.curTime_ or 0

	if arg_18_0.onTimeChange_ then
		arg_18_0.onTimeChange_(tostring(math.ceil(var_18_0)))
	end

	if arg_18_0.onScoreChange_ then
		arg_18_0.onScoreChange_(arg_18_0.score_)
	end
end

function var_0_0.PlayCowRun(arg_19_0)
	if arg_19_0.aniController_:GetCurrentAnimatorStateInfo(0):IsName("run") then
		local var_19_0 = arg_19_0.aniController_:GetCurrentAnimatorStateInfo(0).normalizedTime
		local var_19_1 = arg_19_0.aniController_:GetCurrentAnimatorClipInfo(0)[0].clip.length
		local var_19_2 = arg_19_0.aniController_:GetCurrentAnimatorClipInfo(0)[0].clip.frameRate
		local var_19_3 = math.round(var_19_1 / (1 / var_19_2))

		if math.ceil(var_19_0 / var_19_1 * var_19_3 % var_19_3) <= 1 then
			if not arg_19_0.isPlayCowRun_ then
				manager.audio:PlayEffect("minigame_activity_1_3", "minigame_run", "")

				arg_19_0.isPlayCowRun_ = true
			end
		else
			arg_19_0.isPlayCowRun_ = false
		end
	end
end

function var_0_0.CheckGet(arg_20_0)
	local var_20_0 = arg_20_0.attackTrans_
	local var_20_1
	local var_20_2 = -1
	local var_20_3

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.show_) do
		local var_20_4 = iter_20_1:GetHitRect()

		if not iter_20_1:GetIsHitOrTaunt() then
			local var_20_5 = arg_20_0.cowboyGo_.transform.localPosition.x
			local var_20_6 = iter_20_1.gameObject_.transform.localPosition.x

			if arg_20_0.cowboyState_ == "attack" and (var_20_6 <= var_20_5 and var_20_5 - var_20_6 < arg_20_0.hitLeft_ + var_20_4.hitRight or var_20_5 < var_20_6 and var_20_6 - var_20_5 < arg_20_0.hitRight_ + var_20_4.hitLeft) then
				local var_20_7 = iter_20_1:GetData()

				var_20_2 = math.max(var_20_7.index, var_20_2)
			end

			if var_20_5 < var_20_6 and var_20_6 - var_20_5 > arg_20_0.hitRight_ + var_20_4.hitLeft and not iter_20_1:GetIsPass() then
				iter_20_1:SetIsPass()
				iter_20_1:SetState("runAway")
			end
		end
	end

	if var_20_2 >= 0 and not arg_20_0.isHitted_ then
		for iter_20_2, iter_20_3 in ipairs(arg_20_0.show_) do
			local var_20_8 = iter_20_3:GetData()

			if var_20_2 == var_20_8.index then
				arg_20_0.isHitted_ = true

				iter_20_3:SetState("fall")
				iter_20_3:SetIsHitOrTaunt()

				arg_20_0.score_ = arg_20_0.score_ + ActivityCowboyPointCfg[var_20_8.cowId + 1].point

				if ActivityCowboyPointCfg[var_20_8.cowId + 1].point > 0 then
					manager.audio:PlayEffect("minigame_activity_1_3", "minigame_extra_points", "")
				else
					manager.audio:PlayEffect("minigame_activity_1_3", "minigame_minus_points", "")
				end
			end
		end
	end
end

function var_0_0.CheckReCow(arg_21_0)
	local var_21_0
	local var_21_1
	local var_21_2
	local var_21_3
	local var_21_4

	for iter_21_0 = #arg_21_0.show_, 1, -1 do
		local var_21_5 = arg_21_0.show_[iter_21_0]
		local var_21_6 = var_21_5.transform_.localPosition
		local var_21_7 = var_21_5:GetWidth()

		if var_21_6.x > var_0_2 / 2 + var_21_7 then
			var_21_5:SetStop(true)

			local var_21_8 = var_21_5:GetData().cowId

			SetActive(var_21_5.gameObject_, false)
			table.remove(arg_21_0.show_, iter_21_0)

			if not arg_21_0.unshow_[var_21_8] then
				arg_21_0.unshow_[var_21_8] = {}

				table.insert(arg_21_0.cowIDList_, var_21_8)
			end

			if #arg_21_0.unshow_[var_21_8] > 5 then
				var_21_5:OnExit()
			else
				table.insert(arg_21_0.unshow_[var_21_8], var_21_5)
			end
		end
	end
end

function var_0_0.CheckNewCow(arg_22_0)
	while arg_22_0.cowIndex_ <= #arg_22_0.cows_ and arg_22_0.cows_[arg_22_0.cowIndex_].showTime <= arg_22_0.totalTime_ - arg_22_0.curTime_ do
		local var_22_0 = arg_22_0.cows_[arg_22_0.cowIndex_]

		if arg_22_0.unshow_[var_22_0.cowId] and #arg_22_0.unshow_[var_22_0.cowId] > 0 then
			local var_22_1 = arg_22_0.unshow_[var_22_0.cowId][1]

			table.remove(arg_22_0.unshow_[var_22_0.cowId], 1)

			local var_22_2 = var_22_1.gameObject_
			local var_22_3 = var_22_2:GetComponent("SpriteRenderer")
			local var_22_4 = var_22_3.size

			var_22_3.sortingOrder = var_22_0.index
			var_22_2.transform.localPosition = Vector2(-var_0_2 / 2 - var_22_4.x / 2, arg_22_0.cowboyData_.deltaY)

			local var_22_5 = ActivityCowboySpeedCfg[arg_22_0.activityID_].speed

			for iter_22_0, iter_22_1 in ipairs(var_22_5) do
				if var_22_0.cowId + 1 == iter_22_1[1] then
					speed = iter_22_1[2]

					break
				end
			end

			var_22_1:SetData(var_22_0, speed, arg_22_0.cowboyData_.fallSpeed)
			var_22_1:SetState("run")
			var_22_1:SetStop(false)
			table.insert(arg_22_0.show_, var_22_1)
			SetActive(var_22_2, true)
		else
			local var_22_6 = Object.Instantiate(arg_22_0["cow_" .. var_22_0.cowId], arg_22_0.container_.transform)
			local var_22_7 = var_22_6:GetComponent("SpriteRenderer")
			local var_22_8 = var_22_7.size

			var_22_6.transform.localPosition = Vector2(-var_0_2 / 2 - var_22_8.x / 2, arg_22_0.cowboyData_.deltaY)
			var_22_7.sortingOrder = var_22_0.index

			local var_22_9
			local var_22_10 = QuarryItem.New(var_22_6)
			local var_22_11 = ActivityCowboySpeedCfg[arg_22_0.activityID_].speed

			for iter_22_2, iter_22_3 in ipairs(var_22_11) do
				if var_22_0.cowId + 1 == iter_22_3[1] then
					var_22_9 = iter_22_3[2]

					break
				end
			end

			var_22_10:SetData(var_22_0, var_22_9, arg_22_0.cowboyData_.fallSpeed)
			var_22_10:SetState("run")
			var_22_10:SetStop(false)
			table.insert(arg_22_0.show_, var_22_10)
			SetActive(var_22_6, true)
		end

		arg_22_0.cowIndex_ = arg_22_0.cowIndex_ + 1
	end
end

function var_0_0.Attack(arg_23_0)
	if arg_23_0.aniController_ ~= nil and not arg_23_0.aniController_:GetCurrentAnimatorStateInfo(0):IsName("attack") then
		arg_23_0.aniController_:Play("attack")
		manager.audio:PlayEffect("minigame_activity_1_3", "minigame_attack", "")

		arg_23_0.cowboyState_ = "attack"
		arg_23_0.isHitted_ = false

		if arg_23_0.attackTimer_ then
			arg_23_0.attackTimer_:Stop()

			arg_23_0.attackTimer_ = nil
		end

		local var_23_0 = 0

		arg_23_0.attackTimer_ = FrameTimer.New(function()
			if var_23_0 > 0 then
				local var_24_0 = arg_23_0.aniController_:GetCurrentAnimatorStateInfo(0).speed
				local var_24_1 = arg_23_0.attackTime_ / var_24_0

				TimeTools.StartAfterSeconds(var_24_1, function()
					arg_23_0.cowboyState_ = "run"
				end, {})
				arg_23_0.onAttack_(var_24_1)
			end

			var_23_0 = var_23_0 + 1
		end, 1, 2)

		arg_23_0.attackTimer_:Start()
	end
end

function var_0_0.Pause(arg_26_0)
	arg_26_0.isPausing_ = true

	if arg_26_0.bgAni_ == nil or arg_26_0.aniController_ == nil then
		return
	else
		arg_26_0.bgAni_.enabled = false
		arg_26_0.aniController_.enabled = false
	end

	for iter_26_0, iter_26_1 in ipairs(arg_26_0.show_) do
		iter_26_1:Pause()
	end
end

function var_0_0.Continue(arg_27_0)
	arg_27_0.isPausing_ = false

	if arg_27_0.bgAni_ == nil or arg_27_0.aniController_ == nil then
		return
	else
		arg_27_0.bgAni_.enabled = true
		arg_27_0.aniController_.enabled = true
	end

	for iter_27_0, iter_27_1 in ipairs(arg_27_0.show_) do
		iter_27_1:Continue()
	end
end

function var_0_0.Restart(arg_28_0)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0.show_) do
		iter_28_1:OnExit()
	end

	for iter_28_2, iter_28_3 in ipairs(arg_28_0.cowIDList_) do
		if arg_28_0.unshow_[iter_28_3] then
			for iter_28_4, iter_28_5 in ipairs(arg_28_0.unshow_[iter_28_3]) do
				iter_28_5:OnExit()
			end
		end
	end

	arg_28_0.bgAni_.enabled = true
	arg_28_0.aniController_.enabled = true

	arg_28_0:Start()
end

function var_0_0.GameOver(arg_29_0)
	Object.Destroy(arg_29_0.cowboyGo_)

	if arg_29_0.oriFrame_ == 0 then
		SettingAction.ChangePicSetting("frame", 0)
	end

	for iter_29_0, iter_29_1 in ipairs(arg_29_0.show_ or {}) do
		iter_29_1:OnExit()
	end

	for iter_29_2, iter_29_3 in ipairs(arg_29_0.cowIDList_ or {}) do
		if arg_29_0.unshow_[iter_29_3] then
			for iter_29_4, iter_29_5 in ipairs(arg_29_0.unshow_[iter_29_3]) do
				iter_29_5:OnExit()
			end
		end
	end

	if arg_29_0.frameTimer_ then
		arg_29_0.frameTimer_:Stop()

		arg_29_0.frameTimer_ = nil
	end

	if arg_29_0.attackTimer_ then
		arg_29_0.attackTimer_:Stop()

		arg_29_0.attackTimer_ = nil
	end
end

local var_0_3 = 1

function var_0_0.Hide(arg_30_0)
	var_0_3 = 1 - var_0_3

	SetActive(arg_30_0.furnitureGo_, var_0_3 == 1)
end

function var_0_0.UnLoadCowboyLevel(arg_31_0)
	if arg_31_0.operation_ then
		return
	end

	local var_31_0 = SceneManager.GetSceneByName("X105")

	if var_31_0 and var_31_0.isLoaded == true then
		SceneManager.UnloadSceneAsync("X105")
	end

	Object.Destroy(arg_31_0.raycaster_)
end

return var_0_0
