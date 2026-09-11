local GuelGameView = class("GuelGameView", ReduxView)

function GuelGameView:UIName()
	return "Widget/System/Main_T0SceneGame/102003/102003_Match3GameUI"
end

function GuelGameView:UIParent()
	return manager.ui.uiMain.transform
end

function GuelGameView:Init()
	self:InitUI()

	self.tilePool = {}
	self.tileList = {}
	self.tween = {}
	self.curTimeline = {}
end

function GuelGameView:InitUI()
	self:BindCfgUI()

	self.countDownController = self.match3gameuiControllerexcollection_:GetController("countDown")
	self.mockingController = self.match3gameuiControllerexcollection_:GetController("mocking")
	self.skillController = self.match3gameuiControllerexcollection_:GetController("ultimateSkill")
	self.resultController = self.match3gameuiControllerexcollection_:GetController("result")
	self.selfRoleController = self.match3gameuiControllerexcollection_:GetController("selfRole")
	self.enemyTauntSpine = self.spineTauntGo_.transform:GetComponent("Spine.Unity.SkeletonGraphic")
	self.selfSkillIconController = self.selfSkillController_:GetController("skill")
	self.selfSkillStateController = self.selfSkillController_:GetController("state")
	self.enemySkillIconController = self.enemySkillController_:GetController("skill")
	self.enemySkillStateController = self.enemySkillController_:GetController("state")
	self.enterAniControlller = self.match3gameuiControllerexcollection_:GetController("fullScreen")
	self.cutsceneSubView = TZeroGameChangeView.BaseView.New(self.cutsceneSubView_)

	self:AddListeners()
end

function GuelGameView:InitSpine(arg_5_1)
	if arg_5_1 then
		arg_5_1.AnimationState:ClearTracks()
		arg_5_1:Initialize(true)
		arg_5_1:Update(0)
	end
end

function GuelGameView:ResetSpine()
	self:InitSpine(self.selfSpineFx)
	self:InitSpine(self.enemySpineFx)
end

function GuelGameView:SetSpineParent(arg_7_1, arg_7_2)
	local var_7_0 = {
		"spine1Go_",
		"spine2Go_"
	}
	local var_7_1 = {
		"fxSpine1Go_",
		"fxSpine2Go_"
	}
	local var_7_2 = {
		"rolepos1Go_",
		"rolepos2Go_"
	}
	local var_7_3 = {
		"fxPos1Go_",
		"fxPos2Go_"
	}
	local var_7_4

	if var_7_0[arg_7_1] then
		var_7_4 = var_7_0[arg_7_1] or var_7_0[1]

		local var_7_5

		if var_7_1[arg_7_1] then
			var_7_5 = var_7_1[arg_7_1] or var_7_1[1]

			local var_7_6

			if var_7_2[arg_7_2] then
				var_7_6 = var_7_2[arg_7_2] or var_7_2[1]

				local var_7_7

				if var_7_3[arg_7_2] then
					var_7_7 = var_7_3[arg_7_2] or var_7_3[1]
				end
			end
		end
	end

	self[var_7_4].transform:SetParent(self[var_7_6].transform)

	self[var_7_4].transform.localPosition = Vector3(0, 0, 0)
	self[var_7_4].transform.localScale = Vector3(arg_7_2 == 1 and 1 or -1, 1, 1)

	self[var_7_5].transform:SetParent(self[var_7_7].transform)

	self[var_7_5].transform.localPosition = Vector3(0, 0, 0)
	self[var_7_5].transform.localScale = Vector3(arg_7_2 == 1 and 1 or -1, 1, 1)

	if arg_7_2 == 1 then
		self.selfSpine = self[var_7_4].transform:GetComponent("Spine.Unity.SkeletonGraphic")
		self.selfSpineFx = self[var_7_5].transform:GetComponent("Spine.Unity.SkeletonGraphic")

		self:InitSpine(self.selfSpineFx)

		self.selfHitAni = self[var_7_4].transform:GetComponent("Animator")

		if var_7_4 == "spine1Go_" then
			self.selfSpineName = "kali_"
			self.enemySpineName = "parvati_"
			self.selfRoleName_.text = HeroCfg[1056].suffix
			self.enemyRoleName_.text = HeroCfg[1089].suffix

			self.selfRoleController:SetSelectedState("kali")
			self.selfSkillIconController:SetSelectedState("1156")
			self.enemySkillIconController:SetSelectedState("1089")
		else
			self.selfSpineName = "parvati_"
			self.enemySpineName = "kali_"
			self.selfRoleName_.text = HeroCfg[1089].suffix
			self.enemyRoleName_.text = HeroCfg[1056].suffix

			self.selfRoleController:SetSelectedState("parvati")
			self.selfSkillIconController:SetSelectedState("1089")
			self.enemySkillIconController:SetSelectedState("1156")
		end
	else
		self.enemySpine = self[var_7_4].transform:GetComponent("Spine.Unity.SkeletonGraphic")
		self.enemySpineFx = self[var_7_5].transform:GetComponent("Spine.Unity.SkeletonGraphic")

		self:InitSpine(self.enemySpineFx)

		self.enemyHitAni = self[var_7_4].transform:GetComponent("Animator")
	end
end

function GuelGameView:AddListeners()
	self:AddBtnListener(self.skillBtn1_, nil, function()
		if self.gameManager.canClickSkill and self.gameManager.gameData.globalState == GueGameConst.GameState.playing and self.gameManager.gameData.playerState == GueGameConst.GameState.playing then
			self.gameManager:DOSkill(1)
		end
	end)
end

function GuelGameView:ChangeBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self.gameManager:PauseGame(true)
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_BLOOD_CARD_GAME_GIVE_UP_CONFIRMATION"),
			OkCallback = function()
				GuelGameManager.GetInstance():RecordLog(GuelGameManager.GameResult.Canceled)
				GuelGameAcion.ExitGame()
				manager.posterGirl:SetStateCanChange(true)
				JumpTools.Back(2)
			end,
			CancelCallback = function()
				self.gameManager:PauseGame(false)
			end
		})
	end)
	manager.windowBar:RegistInfoCallBack(function()
		self.gameManager:PauseGame(true)
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = GameSetting.brahma_t0_desc3.value,
			exitCallback = function()
				self.gameManager:PauseGame(false)
			end
		})
	end)
end

function GuelGameView:ShowReult(arg_16_1)
	local var_16_0 = {
		"win",
		"lose",
		"none"
	}

	if arg_16_1 == 1 then
		self:ShowAnimation(true, 7)
		self:ShowAnimation(false, 6)
	elseif arg_16_1 == 2 then
		self:ShowAnimation(true, 6)
		self:ShowAnimation(false, 7)
	end

	self.resultController:SetSelectedState(var_16_0[arg_16_1] or "none")
end

function GuelGameView:OnTop()
	self:ChangeBar()
end

function GuelGameView:OnEnter()
	self:StopPlayable()
	self:StopTime()

	self.chooseIndex = self.params_.chooseIndex or 1

	self:SetSpineParent(1, self.chooseIndex)
	self:SetSpineParent(2, self.chooseIndex == 1 and 2 or 1)

	self.gameManager = GuelGameManager.GetInstance()

	self.gameManager:InitData(self, self.chooseIndex)

	self.effectNum = 0

	self:StartIdle()
	self:ShowReult(3)
	self.gameManager:UpdateTime()
	self.gameManager:UpdateBattleInfo()

	self.timer = Timer.New(function()
		if manager.guide:IsPlaying() then
			return
		end

		if self.gameManager.gameData.globalState == GueGameConst.GameState.pause then
			return
		end

		self:StartEffect()

		self.gameManager.gameData.startingAni = true

		if self.timer then
			self.timer:Stop()

			self.timer = nil
		end
	end, 1, -1)

	self.timer:Start()

	self.startTimer = Timer.New(function()
		if manager.guide:IsPlaying() then
			return
		end

		if self.gameManager.gameData.globalState == GueGameConst.GameState.pause then
			return
		end

		self.gameManager.gameData.startingAni = false

		self.gameManager:StartGame()

		if self.startTimer then
			self.startTimer:Stop()

			self.startTimer = nil
		end
	end, 4, -1)

	self.startTimer:Start()
	self.enterAniControlller:SetSelectedState("false")

	function self.cutsceneSubView.onScreenFullyBlockedCallback()
		self.enterAniControlller:SetSelectedState("false")
	end

	function self.cutsceneSubView.onFinishCallback()
		self:ChangeBar()
		self.cutsceneSubView.gameObject_:SetActive(false)
	end

	self.destoryTimerList = {}
end

function GuelGameView:StopTime()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if self.startTimer then
		self.startTimer:Stop()

		self.startTimer = nil
	end

	if self.destoryTimerList then
		for iter_23_0, iter_23_1 in ipairs(self.destoryTimerList) do
			if iter_23_1 then
				iter_23_1:Stop()

				iter_23_1 = nil
			end
		end

		self.destoryTimerList = {}
	end
end

function GuelGameView:PauseTimer(arg_24_1)
	if self.countDownAni_ then
		self.countDownAni_.speed = arg_24_1 and 0 or 1
	end

	if self.selfHitAni then
		self.selfHitAni.speed = arg_24_1 and 0 or 1
	end

	if self.enemyHitAni then
		self.enemyHitAni.speed = arg_24_1 and 0 or 1
	end

	if self.selfUltimateAni_ then
		self.selfUltimateAni_.speed = arg_24_1 and 0 or 1
	end

	if self.enemyUltimateAni_ then
		self.enemyUltimateAni_.speed = arg_24_1 and 0 or 1
	end

	if self.startTimer then
		self.startTimer.running = not arg_24_1
	end

	if self.selfTimer_ then
		self.selfTimer_.running = not arg_24_1
	end

	if self.enemyTimer_ then
		self.enemyTimer_.running = not arg_24_1
	end

	if self.time then
		self.time.running = not arg_24_1
	end

	for iter_24_0, iter_24_1 in ipairs(self.destoryTimerList) do
		if iter_24_1 then
			iter_24_1.running = not arg_24_1
		end
	end

	if self.selfSpine then
		self.selfSpine.AnimationState.TimeScale = arg_24_1 and 0 or 1
	end

	if self.enemySpine then
		self.enemySpine.AnimationState.TimeScale = arg_24_1 and 0 or 1
	end

	if self.enemyTauntSpine then
		self.enemyTauntSpine.AnimationState.TimeScale = arg_24_1 and 0 or 1
	end

	if self.enemyTauntSpine then
		self.selfSpineFx.AnimationState.TimeScale = arg_24_1 and 0 or 1
	end

	if self.enemyTauntSpine then
		self.enemySpineFx.AnimationState.TimeScale = arg_24_1 and 0 or 1
	end
end

function GuelGameView:StartEffect()
	self.countDownAni_:Play("default", -1, 0)

	self.countDownAni_.speed = 1

	self.countDownAni_:Update(0)
	manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_sanxiao_start", "")
	SetActive(self.spineTauntGo_, false)
end

function GuelGameView:OnExit()
	GuelGameView.super.OnExit(self)

	for iter_26_0, iter_26_1 in ipairs(self.tileList[1]) do
		if iter_26_1 then
			iter_26_1:Dispose()
			self:DestroyTileObj(iter_26_1.gameObject_, true)
		end
	end

	for iter_26_2, iter_26_3 in ipairs(self.tileList[2]) do
		if iter_26_3 then
			iter_26_3:Dispose()
			self:DestroyTileObj(iter_26_3.gameObject_, true)
		end
	end

	self.tileList[2] = {}
	self.tileList[1] = {}

	self:StopTime()
	self:StopIdleTimer()
	self:StopPlayable()
	self.gameManager:PauseGame(false, true)
	self.cutsceneSubView:OnExit()
	self.gameManager:Dispose()
	self:StopAnimator()
	manager.notify:Invoke(HOME_BTN_VISIBE, true)
end

function GuelGameView:CreateOrGetTileItem(arg_27_1, arg_27_2)
	local var_27_0 = #self.tilePool > 0 and table.remove(self.tilePool) or GameObject.Instantiate(self.coloritemGo_1, arg_27_1.transform)

	SetActive(var_27_0, true)
	var_27_0.transform:SetParent(arg_27_1.transform)

	var_27_0.transform.localScale = Vector3.New(1, 1, 1)

	return var_27_0
end

function GuelGameView:StopAnimator()
	self.selfHitAni:Play("spine_hit_normal", -1, 0)
	self.enemyHitAni:Play("spine_hit_normal", -1, 0)
	SetActive(self.selfUltimateAni_, true)
	SetActive(self.enemyUltimateAni_, true)
	self.selfUltimateAni_:Play("ultimateSkill00", -1, 0)
	self.selfUltimateAni_:Update(0)
	self.enemyUltimateAni_:Play("ultimateSkill00", -1, 0)
	self.enemyUltimateAni_:Update(0)
	SetActive(self.selfUltimateAni_, false)
	SetActive(self.enemyUltimateAni_, false)
end

function GuelGameView:ProcessTileList(arg_29_1, arg_29_2, arg_29_3)
	self.tileList[arg_29_2] = self.tileList[arg_29_2] or {}

	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		local var_29_0 = self.tileList[arg_29_2][iter_29_1.index] or GuelGameTileItem.New(self:CreateOrGetTileItem(arg_29_3, iter_29_1.index))

		var_29_0:SetData(iter_29_1)

		var_29_0.gameObject_.name = "item" .. iter_29_1.index
		iter_29_1.canclick = arg_29_2 == 1

		var_29_0:SetPosition((iter_29_1.index - 1) * 130)

		self.tileList[arg_29_2][iter_29_1.index] = var_29_0
	end
end

function GuelGameView:ShowTileList(arg_30_1, arg_30_2)
	self:ProcessTileList(arg_30_1, 1, self.coloritemgroup1Go_)
	self:ProcessTileList(arg_30_2, 2, self.coloritemgroup2Go_)
end

function GuelGameView:ShowHitAni(arg_31_1)
	local var_31_0

	if arg_31_1 then
		var_31_0 = self.selfHitAni or self.enemyHitAni
	end

	if not var_31_0:GetCurrentAnimatorStateInfo(0):IsName("spine_hit") then
		var_31_0:Play("spine_hit", 0, 0)
	end
end

function GuelGameView:ShowTileListWithAnimation(arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = {
		{
			listIndex = 1,
			dataList = arg_32_1,
			parent = self.coloritemgroup1Go_
		},
		{
			listIndex = 2,
			dataList = arg_32_2,
			parent = self.coloritemgroup2Go_
		}
	}

	for iter_32_0, iter_32_1 in ipairs(var_32_0) do
		-- block empty
	end

	local var_32_2 = var_32_0[arg_32_3 or 1]
	local var_32_3

	if self.tileList[var_32_0[arg_32_3 or 1].listIndex] then
		var_32_3 = #self.tileList[var_32_2.listIndex] or 0
	end

	local var_32_4 = self.tileList[var_32_2.listIndex][var_32_3]:GetPositionX()

	for iter_32_2, iter_32_3 in ipairs(var_32_2.dataList) do
		self.tileList[var_32_2.listIndex] = self.tileList[var_32_2.listIndex] or {}

		local var_32_5 = self.tileList[var_32_2.listIndex][iter_32_3.index]

		if not self.tileList[var_32_2.listIndex][iter_32_3.index] then
			local var_32_6 = self:CreateOrGetTileItem(var_32_2.parent)

			var_32_6.transform:SetSiblingIndex(iter_32_3.index - 1)

			var_32_5 = GuelGameTileItem.New(var_32_6)

			var_32_5:SetPosition(var_32_4 + 116 * (iter_32_3.index - var_32_3))
		end

		var_32_5:SetData(iter_32_3)

		var_32_5.gameObject_.name = "item" .. iter_32_3.index
		iter_32_3.canclick = var_32_2.listIndex == 1

		local var_32_7 = LeanTween.value(var_32_5:GetPositionX(), (iter_32_3.index - 1) * 130, 0.3)

		var_32_7:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
			var_32_5:SetPosition(arg_33_0, 0)
		end)):setOnComplete(LuaHelper.VoidAction(function()
			if var_32_7 then
				var_32_7:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
				LeanTween.cancel(var_32_7.id)
			end
		end)):setEase(LeanTweenType.easeOutQuad)
		table.insert(self.tween, var_32_7)

		self.tileList[var_32_2.listIndex][iter_32_3.index] = var_32_5
	end
end

function GuelGameView:DestroyTile(arg_35_1, arg_35_2)
	local var_35_0 = table.remove((arg_35_1 or nil) and (self.tileList[1] or self.tileList[2]), arg_35_2)

	if not var_35_0 then
		return
	end

	local var_35_1 = var_35_0.gameObject_

	var_35_0:ShowEffect(true)
	self:DestroyTileObj(var_35_1)
end

function GuelGameView:DestroyTileObj(arg_36_1, arg_36_2)
	if isNil(arg_36_1) or not arg_36_1 then
		return
	end

	if arg_36_2 then
		arg_36_1.transform:SetParent(self.poolTrs_)

		arg_36_1.transform.localScale = Vector3.New(1, 1, 1)

		SetActive(arg_36_1, false)
		table.insert(self.tilePool, arg_36_1)
		table.remove(self.destoryTimerList, time)
	else
		local var_36_0 = Timer.New(function()
			arg_36_1.transform:SetParent(self.poolTrs_)

			arg_36_1.transform.localScale = Vector3.New(1, 1, 1)

			SetActive(arg_36_1, false)
			table.insert(self.tilePool, arg_36_1)
		end, 0.23, 1)

		var_36_0:Start()
		table.insert(self.destoryTimerList, var_36_0)
	end
end

function GuelGameView:RemoveTween()
	for iter_38_0, iter_38_1 in ipairs(self.tween) do
		if iter_38_1 then
			iter_38_1:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
			LeanTween.cancel(iter_38_1.id)
		end
	end

	self.tween = {}
end

function GuelGameView:Dispose()
	GuelGameView.super.Dispose(self)
	AnimatorTools.Stop()

	self.tilePool = nil

	self:RemoveTween()
	self:StopTime()
	self.cutsceneSubView:Dispose()
end

function GuelGameView:StartIdle()
	self:ShowAnimation(true, 1)
	self:ShowAnimation(false, 1)
	self:SetIdleTimer()
end

local var_0_1 = {
	"charge_mild",
	"charge_hold",
	"charge_start",
	"charge_pro",
	"ult"
}

function GuelGameView:ShowAnimation(arg_41_1, arg_41_2)
	local var_41_0

	if arg_41_1 then
		var_41_0 = self.selfSpineName or self.enemySpineName

		local var_41_1

		if arg_41_1 then
			var_41_1 = self.selfSpine or self.enemySpine

			local var_41_2

			if arg_41_1 then
				var_41_2 = self.selfSpineFx or self.enemySpineFx
			end
		end
	end

	local var_41_3 = ({
		"idle",
		"charge_mild",
		"charge_hold",
		"taunt",
		"ult",
		"fail",
		"victory",
		"charge_pro",
		"charge_start"
	})[arg_41_2]
	local var_41_4

	if var_41_0 == "kali_" then
		if var_41_3 == "charge_mild" then
			var_41_4 = "ui_scene_102003_sanxiao_1156_attack01"
		elseif var_41_3 == "charge_pro" then
			var_41_4 = "ui_scene_102003_sanxiao_1156_attack02"
		elseif var_41_3 == "ult" then
			var_41_4 = "ui_scene_102003_sanxiao_1156_attack03"
		elseif var_41_3 == "charge_hold" then
			var_41_4 = "ui_scene_102003_sanxiao_1156_attack_loop"
		end
	elseif var_41_0 == "parvati_" then
		if var_41_3 == "charge_mild" then
			var_41_4 = "ui_scene_102003_sanxiao_1089_attack01"
		elseif var_41_3 == "charge_pro" then
			var_41_4 = "ui_scene_102003_sanxiao_1089_attack02"
		elseif var_41_3 == "ult" then
			var_41_4 = "ui_scene_102003_sanxiao_1089_attack03"
		elseif var_41_3 == "charge_hold" then
			var_41_4 = "ui_scene_102003_sanxiao_1089_attack_loop"
		end
	end

	if var_41_3 == "victory" then
		var_41_4 = "ui_scene_102003_sanxiao_win"
	elseif var_41_3 == "fail" then
		var_41_4 = "ui_scene_102003_sanxiao_lose"
	end

	local var_41_5 = var_41_1.AnimationState:GetCurrent(0)

	if var_41_5 then
		Debug.Log("当前动画：" .. var_41_5.Animation.Name .. " 要播放的动画：" .. var_41_0 .. var_41_3)

		if var_41_5.Animation.Name == var_41_0 .. var_41_3 and var_41_5.Animation.Name ~= var_41_0 .. "charge_hold" or var_41_5.Animation.Name == var_41_0 .. "charge_hold" and var_41_3 == "charge_start" then
			return
		end
	end

	if var_41_4 then
		manager.audio:PlayEffect("ui_scene_102003", var_41_4, "")
	end

	local var_41_6 = var_41_1.AnimationState:SetAnimation(0, var_41_0 .. var_41_3, false)

	if table.indexof(var_0_1, var_41_3) then
		var_41_2.AnimationState:SetAnimation(0, var_41_0 .. var_41_3, false)
	else
		self:InitSpine(var_41_2)
	end
end

function GuelGameView:ShowCry()
	SetActive(self.spineTauntGo_, true)
	SetActive(self.maskGo_, true)
	self.enemyTauntSpine.AnimationState:SetAnimation(0, "ultimate", false)
	manager.audio:PlayEffect("vo_sys_102003", "v_s_102003_tv_game_102", true)

	self.time = TimeTools.StartAfterSeconds(3, function()
		SetActive(self.spineTauntGo_, false)
		SetActive(self.maskGo_, false)
	end, {})
end

function GuelGameView:ShowTaunt()
	SetActive(self.spineTauntGo_, true)
	SetActive(self.maskGo_, true)
	self.enemyTauntSpine.AnimationState:SetAnimation(0, "laugh", false)
	manager.audio:PlayEffect("vo_sys_102003", "v_s_102003_tv_game_103", true)

	self.time = TimeTools.StartAfterSeconds(3, function()
		SetActive(self.spineTauntGo_, false)
		SetActive(self.maskGo_, false)
	end, {})
end

function GuelGameView:ShowSelfUltimate()
	SetActive(self.maskGo_, true)

	if self.chooseIndex == 2 then
		SetActive(self.enemyUltimateAni_.transform.gameObject, true)
		self.enemyUltimateAni_:Play("ultimateSkill04", 0, 0)
		self.enemyUltimateAni_:Update(0)
	else
		SetActive(self.selfUltimateAni_.transform.gameObject, true)
		self.selfUltimateAni_:Play("ultimateSkill01", 0, 0)
		self.selfUltimateAni_:Update(0)
	end

	self.time = TimeTools.StartAfterSeconds(1.2, function()
		SetActive(self.maskGo_, false)
		self:ShowAnimation(true, 5)
	end, {})
end

function GuelGameView:ShowEnemyUltimate()
	SetActive(self.maskGo_, true)

	if self.chooseIndex == 2 then
		SetActive(self.selfUltimateAni_.transform.gameObject, true)
		self.selfUltimateAni_:Play("ultimateSkill03", 0, 0)
		self.selfUltimateAni_:Update(0)
	else
		SetActive(self.enemyUltimateAni_.transform.gameObject, true)
		self.enemyUltimateAni_:Play("ultimateSkill02", 0, 0)
		self.enemyUltimateAni_:Update(0)
	end

	self.time = TimeTools.StartAfterSeconds(1.2, function()
		SetActive(self.maskGo_, false)
		self:ShowAnimation(false, 5)
	end, {})
end

function GuelGameView:StopIdleTimer()
	if self.selfTimer_ then
		self.selfTimer_:Stop()

		self.selfTimer_ = nil
	end

	if self.enemyTimer_ then
		self.enemyTimer_:Stop()

		self.enemyTimer_ = nil
	end
end

function GuelGameView:GetSpineName(arg_51_1)
	local var_51_0

	if arg_51_1 then
		var_51_0 = self.selfSpine or self.enemySpine

		local var_51_1

		if arg_51_1 then
			var_51_1 = self.selfSpineName or self.enemySpineName
		end
	end

	local var_51_2 = var_51_0.AnimationState:GetCurrent(0)

	if var_51_2 then
		return string.match(var_51_2.Animation.Name, "^" .. var_51_1 .. "(.+)$") or ""
	end

	return ""
end

function GuelGameView:SetIdleTimer()
	local function var_52_0(arg_53_0, arg_53_1, arg_53_2)
		local var_53_0 = arg_53_0.AnimationState:GetCurrent(0)

		if not var_53_0 then
			return false
		end

		local var_53_1 = string.match(var_53_0.Animation.Name, "^" .. arg_53_2 .. "(.+)$")

		var_53_1 = var_53_1 or ""

		if var_53_1 ~= "idle" and var_53_0.IsComplete then
			if var_53_1 ~= "charge_hold" then
				self:InitSpine(arg_53_1)
			end

			if var_53_1 == "victory" or var_53_1 == "fail" then
				return false
			end

			if var_53_1 == "charge_hold" then
				self:ShowAnimation(arg_53_0 == self.selfSpine, 3)

				return true
			end

			if var_53_1 == "charge_start" then
				arg_53_0.AnimationState:SetAnimation(0, arg_53_2 .. "charge_hold", false)
				self:ShowAnimation(arg_53_0 == self.selfSpine, 3)

				return true
			end

			arg_53_0.AnimationState:SetAnimation(0, arg_53_2 .. "idle", true)

			return true
		end

		return false
	end

	self:StopIdleTimer()

	self.selfTimer_ = FrameTimer.New(function()
		var_52_0(self.selfSpine, self.selfSpineFx, self.selfSpineName)
	end, 0.33, -1)
	self.enemyTimer_ = FrameTimer.New(function()
		var_52_0(self.enemySpine, self.enemySpineFx, self.enemySpineName)
	end, 0.33, -1)

	self.selfSpine.AnimationState:SetAnimation(0, self.selfSpineName .. "idle", true)
	self.enemySpine.AnimationState:SetAnimation(0, self.enemySpineName .. "idle", true)
	self.selfTimer_:Start()
	self.enemyTimer_:Start()
end

function GuelGameView:StopPlayable()
	SetActive(self.spineTauntGo_, false)
	SetActive(self.maskGo_, false)
	SetActive(self.selfUltimateAni_.transform.gameObject, false)
	SetActive(self.enemyUltimateAni_.transform.gameObject, false)

	if self.time then
		self.time:Stop()

		self.time = nil
	end
end

local Include = import("manager.posterGirl.tgame.GuelGame.States.Include")

function GuelGameView:GetPlayBackwardsAnimator()
	return self.cutsceneSubView:GetPlayBackwardsAnimator(function()
		self.enterAniControlller:SetSelectedState("true")

		if manager.posterGirl.actor then
			local var_58_0 = manager.posterGirl.actor:GetCurrentState()

			if var_58_0.gameInst and not var_58_0.gameInst.exit then
				var_58_0.gameInst:GoToState(Include.ExitState)
			end
		end
	end, function()
		self:StopTime()
		self:StopIdleTimer()
		self:StopPlayable()
		self.gameManager:PauseGame(false, true)
		manager.audio:Stop("effect", true)
		manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_game_in", "")
	end)
end

return GuelGameView
