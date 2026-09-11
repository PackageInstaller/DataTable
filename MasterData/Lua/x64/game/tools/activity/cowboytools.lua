local var_0_0 = {}
local cjson = require("cjson")
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

function var_0_0:LoadCowboyLevel(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = SceneManager.GetSceneByName("X105")

	if var_5_0 and var_5_0.isLoaded == true then
		return
	end

	if self.operation_ then
		return
	end

	self.callback_ = arg_5_1
	self.onTimeChange_ = arg_5_2
	self.onScoreChange_ = arg_5_3
	self.onAttack_ = arg_5_4
	self.operation_ = Asset.LoadLevelAsync("Levels/X105", true)
	self.raycaster_ = manager.ui.mainCamera:AddComponent(typeof(Physics2DRaycaster))

	if self.loadTimer_ then
		self.loadTimer_:Stop()

		self.loadTimer_ = nil
	end

	self.loadTimer_ = FrameTimer.New(handler(self, self.Process), 1, -1)

	self.loadTimer_:Start()
end

function var_0_0:Process()
	if self.operation_:IsDone() then
		if not gameContext:GetOpenPageHandler("cowboyGame") then
			local var_6_0 = SceneManager.GetSceneByName("X105")

			if var_6_0 and var_6_0.isLoaded == true then
				SceneManager.UnLoadSceneAsync("X105")
			end
		end

		if self.loadTimer_ then
			self.loadTimer_:Stop()

			self.loadTimer_ = nil
		end

		self.operation_ = nil

		if self.callback_ then
			self.callback_()
		end

		self.callback_ = nil
	end
end

function var_0_0:InitCowboySence(arg_7_1, arg_7_2)
	self.mainActivityID_ = arg_7_1
	self.activityID_ = arg_7_2

	ComponentBinder.GetInstance():BindCfgUI(self, (self:GetBgGo()))
	self:GameEnter()
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

function var_0_0:GameEnter()
	self.cowboyData_ = {}
	self.cows_ = {}
	self.cowboyGo_ = nil
	self.aniController_ = nil
	self.cowboyState_ = ""
	self.frameTimer_ = nil
	self.totalTime_ = 0
	self.curTime_ = 0
	self.isEnd_ = false
	self.isPausing_ = false
	self.score_ = 0
	self.cowIndex_ = 1
	self.show_ = {}
	self.unshow_ = {}
	self.cowIDList_ = {}
	self.attackTimer_ = nil

	self:GetTempCorners()
	self:AssetData()
	self:DrawCowboy()
	self:Start()
end

function var_0_0:GetTempCorners()
	if self.corners == nil then
		self.corners = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
	end
end

function var_0_0:AssetData()
	self.cowboyData_ = cjson.decode((AssetEx.LoadText("Cowboy/CowboyData_" .. self.mainActivityID_)))

	local var_11_0 = table.indexof(ActivityCfg[self.mainActivityID_].sub_activity_list, self.activityID_)

	self.cows_ = self.cowboyData_.LevelInfos[var_11_0].cows
	self.totalTime_ = self.cowboyData_.LevelInfos[var_11_0].timeLimit
end

function var_0_0:DrawCowboy()
	local var_12_0 = Object.Instantiate(self["cowboy_" .. self.cowboyData_.cowboyId], self.container_.transform)

	var_12_0.transform.localPosition = Vector2(self.cowboyData_.cowboyPosX, -self.cowboyData_.cowboyPosY)
	self.cowboyGo_ = var_12_0
	self.aniController_ = self.cowboyGo_:GetComponent("Animator")

	for iter_12_0 = 0, self.aniController_.runtimeAnimatorController.animationClips.Length - 1 do
		if self.aniController_.runtimeAnimatorController.animationClips[iter_12_0].name == "attack" then
			self.attackTime_ = self.aniController_.runtimeAnimatorController.animationClips[iter_12_0].length

			break
		end
	end

	local var_12_1 = var_12_0:GetComponent("SpriteRenderer").sprite.texture
	local var_12_2 = var_12_0:GetComponent("SpriteRenderer").size

	self.hitLeft_ = var_12_2.x / 2 - self.cowboyData_.hitLeft * (var_12_2.x / var_12_1.width)
	self.hitRight_ = var_12_2.x / 2 - self.cowboyData_.hitRight * (var_12_2.x / var_12_1.width)

	SetActive(self.cowboyGo_, true)
end

function var_0_0:Start()
	self.curTime_ = self.totalTime_
	self.score_ = 0
	self.isEnd_ = false
	self.isPausing_ = false
	self.cowboyState_ = "run"
	self.cowIndex_ = 1
	self.show_ = {}
	self.unshow_ = {}

	manager.audio:Pause("music", false)
	manager.audio:Pause("effect", false)

	self.oriFrame_ = GameLocalData:GetCommonModule("userSetting").frame or PictureQualitySettingCfg[5].frame

	if self.oriFrame_ == 0 then
		SettingAction.ChangePicSetting("frame", 1)
	end

	self.frameTimer_ = self.frameTimer_ or FrameTimer.New(handler(self, self.Update), 1, -1)

	manager.audio:PlayBGM("bgm_activity_1_3_1_minigame_main", "bgm_activity_1_3_1_minigame_main", "bgm_activity_1_3_1_minigame_main.awb")
	self.frameTimer_:Start()
end

function var_0_0:Update()
	if self.isPausing_ then
		return
	end

	self:UpdateSelf()

	if self.isEnd_ then
		self:EndGame()

		return
	end

	local var_14_0 = Time.deltaTime

	self:PlayCowRun()
	self:CheckReCow()
	self:CheckNewCow()
	self:CheckGet()

	self.curTime_ = self.curTime_ - var_14_0

	if self.curTime_ < 0 then
		self.isEnd_ = true
	end
end

function var_0_0:EndGame()
	manager.audio:Pause("music", true)
	self:Pause()

	if ActivityTools.ActivityOpenCheckByMessageBox(self.mainActivityID_, function()
		JumpTools.OpenPageByJump("/cowboy", {
			activityId = self.mainActivityID_
		})
	end) then
		CowboyAction:SendActivityInfo(self.mainActivityID_, self.activityID_, self.score_, function()
			JumpTools.OpenPageByJump("cowboyGameOver", {
				mainActivityID = self.mainActivityID_,
				activityID = self.activityID_,
				score = self.score_
			})
		end)
	end
end

function var_0_0:UpdateSelf()
	if self.curTime_ > 0 then
		if self.onTimeChange_ then
			self.onTimeChange_(tostring(math.ceil(self.curTime_ or 0)))
		end

		if self.onScoreChange_ then
			self.onScoreChange_(self.score_)
		end
	end
end

function var_0_0:PlayCowRun()
	if self.aniController_:GetCurrentAnimatorStateInfo(0):IsName("run") then
		local var_19_0 = self.aniController_:GetCurrentAnimatorClipInfo(0)[0].clip.length
		local var_19_1 = math.round(var_19_0 / (1 / self.aniController_:GetCurrentAnimatorClipInfo(0)[0].clip.frameRate))

		if math.ceil(self.aniController_:GetCurrentAnimatorStateInfo(0).normalizedTime / var_19_0 * var_19_1 % var_19_1) <= 1 then
			if not self.isPlayCowRun_ then
				manager.audio:PlayEffect("minigame_activity_1_3", "minigame_run", "")

				self.isPlayCowRun_ = true
			end
		else
			self.isPlayCowRun_ = false
		end
	end
end

function var_0_0:CheckGet()
	local var_20_2 = -1

	for iter_20_0, iter_20_1 in ipairs(self.show_) do
		local var_20_4 = iter_20_1:GetHitRect()

		if not iter_20_1:GetIsHitOrTaunt() then
			if self.cowboyState_ == "attack" and (iter_20_1.gameObject_.transform.localPosition.x <= self.cowboyGo_.transform.localPosition.x and self.cowboyGo_.transform.localPosition.x - iter_20_1.gameObject_.transform.localPosition.x < self.hitLeft_ + var_20_4.hitRight or self.cowboyGo_.transform.localPosition.x < iter_20_1.gameObject_.transform.localPosition.x and iter_20_1.gameObject_.transform.localPosition.x - self.cowboyGo_.transform.localPosition.x < self.hitRight_ + var_20_4.hitLeft) then
				var_20_2 = math.max(iter_20_1:GetData().index, var_20_2)
			end

			if self.cowboyGo_.transform.localPosition.x < iter_20_1.gameObject_.transform.localPosition.x and iter_20_1.gameObject_.transform.localPosition.x - self.cowboyGo_.transform.localPosition.x > self.hitRight_ + var_20_4.hitLeft and not iter_20_1:GetIsPass() then
				iter_20_1:SetIsPass()
				iter_20_1:SetState("runAway")
			end
		end
	end

	if var_20_2 >= 0 and not self.isHitted_ then
		for iter_20_2, iter_20_3 in ipairs(self.show_) do
			local var_20_5 = iter_20_3:GetData()

			if var_20_2 == var_20_5.index then
				self.isHitted_ = true

				iter_20_3:SetState("fall")
				iter_20_3:SetIsHitOrTaunt()

				self.score_ = self.score_ + ActivityCowboyPointCfg[var_20_5.cowId + 1].point

				if ActivityCowboyPointCfg[var_20_5.cowId + 1].point > 0 then
					manager.audio:PlayEffect("minigame_activity_1_3", "minigame_extra_points", "")
				else
					manager.audio:PlayEffect("minigame_activity_1_3", "minigame_minus_points", "")
				end
			end
		end
	end
end

function var_0_0:CheckReCow()
	for iter_21_0 = #self.show_, 1, -1 do
		if self.show_[iter_21_0].transform_.localPosition.x > var_0_2 / 2 + self.show_[iter_21_0]:GetWidth() then
			self.show_[iter_21_0]:SetStop(true)

			local var_21_5 = self.show_[iter_21_0]:GetData().cowId

			SetActive(self.show_[iter_21_0].gameObject_, false)
			table.remove(self.show_, iter_21_0)

			if not self.unshow_[var_21_5] then
				self.unshow_[var_21_5] = {}

				table.insert(self.cowIDList_, var_21_5)
			end

			if #self.unshow_[var_21_5] > 5 then
				self.show_[iter_21_0]:OnExit()
			else
				table.insert(self.unshow_[var_21_5], self.show_[iter_21_0])
			end
		end
	end
end

function var_0_0:CheckNewCow()
	while self.cowIndex_ <= #self.cows_ and self.cows_[self.cowIndex_].showTime <= self.totalTime_ - self.curTime_ do
		if self.unshow_[self.cows_[self.cowIndex_].cowId] and #self.unshow_[self.cows_[self.cowIndex_].cowId] > 0 then
			table.remove(self.unshow_[self.cows_[self.cowIndex_].cowId], 1)

			local var_22_0 = self.unshow_[self.cows_[self.cowIndex_].cowId][1].gameObject_:GetComponent("SpriteRenderer")

			var_22_0.sortingOrder = self.cows_[self.cowIndex_].index
			self.unshow_[self.cows_[self.cowIndex_].cowId][1].gameObject_.transform.localPosition = Vector2(-var_0_2 / 2 - var_22_0.size.x / 2, self.cowboyData_.deltaY)

			for iter_22_0, iter_22_1 in ipairs(ActivityCowboySpeedCfg[self.activityID_].speed) do
				if self.cows_[self.cowIndex_].cowId + 1 == iter_22_1[1] then
					speed = iter_22_1[2]

					break
				end
			end

			self.unshow_[self.cows_[self.cowIndex_].cowId][1]:SetData(self.cows_[self.cowIndex_], speed, self.cowboyData_.fallSpeed)
			self.unshow_[self.cows_[self.cowIndex_].cowId][1]:SetState("run")
			self.unshow_[self.cows_[self.cowIndex_].cowId][1]:SetStop(false)
			table.insert(self.show_, self.unshow_[self.cows_[self.cowIndex_].cowId][1])
			SetActive(self.unshow_[self.cows_[self.cowIndex_].cowId][1].gameObject_, true)
		else
			local var_22_1 = Object.Instantiate(self["cow_" .. self.cows_[self.cowIndex_].cowId], self.container_.transform)
			local var_22_2 = var_22_1:GetComponent("SpriteRenderer")

			var_22_1.transform.localPosition = Vector2(-var_0_2 / 2 - var_22_2.size.x / 2, self.cowboyData_.deltaY)
			var_22_2.sortingOrder = self.cows_[self.cowIndex_].index

			local var_22_3
			local var_22_4 = QuarryItem.New(var_22_1)

			for iter_22_2, iter_22_3 in ipairs(ActivityCowboySpeedCfg[self.activityID_].speed) do
				if self.cows_[self.cowIndex_].cowId + 1 == iter_22_3[1] then
					var_22_3 = iter_22_3[2]

					break
				end
			end

			var_22_4:SetData(self.cows_[self.cowIndex_], var_22_3, self.cowboyData_.fallSpeed)
			var_22_4:SetState("run")
			var_22_4:SetStop(false)
			table.insert(self.show_, var_22_4)
			SetActive(var_22_1, true)
		end

		self.cowIndex_ = self.cowIndex_ + 1
	end
end

function var_0_0:Attack()
	if self.aniController_ ~= nil then
		if not self.aniController_:GetCurrentAnimatorStateInfo(0):IsName("attack") then
			self.aniController_:Play("attack")
			manager.audio:PlayEffect("minigame_activity_1_3", "minigame_attack", "")

			self.cowboyState_ = "attack"
			self.isHitted_ = false

			if self.attackTimer_ then
				self.attackTimer_:Stop()

				self.attackTimer_ = nil
			end

			local var_23_0 = 0

			self.attackTimer_ = FrameTimer.New(function()
				if var_23_0 > 0 then
					local var_24_0 = self.attackTime_ / self.aniController_:GetCurrentAnimatorStateInfo(0).speed

					TimeTools.StartAfterSeconds(var_24_0, function()
						self.cowboyState_ = "run"
					end, {})
					self.onAttack_(var_24_0)
				end

				var_23_0 = var_23_0 + 1
			end, 1, 2)

			self.attackTimer_:Start()
		end
	end
end

function var_0_0:Pause()
	self.isPausing_ = true

	if self.bgAni_ == nil or self.aniController_ == nil then
		return
	else
		self.bgAni_.enabled = false
		self.aniController_.enabled = false
	end

	for iter_26_0, iter_26_1 in ipairs(self.show_) do
		iter_26_1:Pause()
	end
end

function var_0_0:Continue()
	self.isPausing_ = false

	if self.bgAni_ == nil or self.aniController_ == nil then
		return
	else
		self.bgAni_.enabled = true
		self.aniController_.enabled = true
	end

	for iter_27_0, iter_27_1 in ipairs(self.show_) do
		iter_27_1:Continue()
	end
end

function var_0_0:Restart()
	for iter_28_0, iter_28_1 in ipairs(self.show_) do
		iter_28_1:OnExit()
	end

	for iter_28_2, iter_28_3 in ipairs(self.cowIDList_) do
		if self.unshow_[iter_28_3] then
			for iter_28_4, iter_28_5 in ipairs(self.unshow_[iter_28_3]) do
				iter_28_5:OnExit()
			end
		end
	end

	self.bgAni_.enabled = true
	self.aniController_.enabled = true

	self:Start()
end

function var_0_0:GameOver()
	Object.Destroy(self.cowboyGo_)

	if self.oriFrame_ == 0 then
		SettingAction.ChangePicSetting("frame", 0)
	end

	for iter_29_0, iter_29_1 in ipairs(self.show_ or {}) do
		iter_29_1:OnExit()
	end

	for iter_29_2, iter_29_3 in ipairs(self.cowIDList_ or {}) do
		if self.unshow_[iter_29_3] then
			for iter_29_4, iter_29_5 in ipairs(self.unshow_[iter_29_3]) do
				iter_29_5:OnExit()
			end
		end
	end

	if self.frameTimer_ then
		self.frameTimer_:Stop()

		self.frameTimer_ = nil
	end

	if self.attackTimer_ then
		self.attackTimer_:Stop()

		self.attackTimer_ = nil
	end
end

local var_0_3 = 1

function var_0_0:Hide()
	var_0_3 = 1 - var_0_3

	SetActive(self.furnitureGo_, var_0_3 == 1)
end

function var_0_0:UnLoadCowboyLevel()
	if self.operation_ then
		return
	end

	local var_31_0 = SceneManager.GetSceneByName("X105")

	if var_31_0 and var_31_0.isLoaded == true then
		SceneManager.UnloadSceneAsync("X105")
	end

	Object.Destroy(self.raycaster_)
end

return var_0_0
