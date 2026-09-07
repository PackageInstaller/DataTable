local FushunAdventureGame = class("FushunAdventureGame")
local var_0_1 = false
local var_0_2 = 0
local var_0_4 = 2
local var_0_5 = 3
local var_0_6 = 4

function FushunAdventureGame:Ctor(arg_1_1, arg_1_2, arg_1_3)
	pg.DelegateInfo.New(self)

	self.state = var_0_2
	self._go = arg_1_1
	self.gameData = arg_1_2

	local var_1_0 = (arg_1_3:GetRuntimeData("elements") or {})[1]

	if not (arg_1_3:GetRuntimeData("elements") or {})[1] then
		self.highestScore = 0
	end

	self:Init()

	return
end

function FushunAdventureGame:SetOnShowResult(arg_2_1)
	self.OnShowResult = arg_2_1

	return
end

function FushunAdventureGame:SetOnLevelUpdate(arg_3_1)
	self.OnLevelUpdate = arg_3_1

	return
end

function FushunAdventureGame:setRoomTip(arg_4_1)
	self.helpTip = arg_4_1

	return
end

function FushunAdventureGame:setRoomId(arg_5_1)
	self.roomId = arg_5_1

	return
end

function FushunAdventureGame:Init()
	if self.state ~= var_0_2 then
		return
	end

	self.state = var_0_4

	self:InitMainUI()

	self.helpTip = pg.gametip.fushun_adventure_help.tip

	return
end

function FushunAdventureGame:loadPrefab(arg_7_1, arg_7_2)
	ResourceMgr.Inst:getAssetAsync(arg_7_1, "", function(arg_8_0)
		arg_7_2(instantiate(arg_8_0))

		return
	end, true, true)

	return
end

function FushunAdventureGame:InitMainUI()
	onButton(self, findTF(self._go, "btn_help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = self.helpTip
		})

		return
	end, SFX_PANEL)
	onButton(self, findTF(self._go, "btn_start"), function()
		pg.BgmMgr.GetInstance():StopPlay()
		self:StartGame()

		return
	end, SFX_PANEL)

	self.levelList = UIItemList.New(findTF(self._go, "levels/scrollrect/content"), findTF(self._go, "levels/scrollrect/content/level"))
	self.arrUp = findTF(self._go, "levels/arr_up")
	self.arrDown = findTF(self._go, "levels/arr_bottom")

	onScroll(self, findTF(self._go, "levels/scrollrect"), function(arg_12_0)
		setActive(self.arrUp, arg_12_0.y < 1)
		setActive(self.arrDown, arg_12_0.y > 0)

		return
	end)
	self:RefreshLevels()

	return
end

function FushunAdventureGame:RefreshLevels()
	local var_13_0

	self.levelList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			arg_14_2:Find("Text"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/minigameui/FushunAdventureGame_atlas", "level_" .. arg_14_1 + 1)

			local var_14_0 = arg_14_1 >= self.gameData.usedtime + (self.gameData.count > 0 and 1 or 0)

			setActive(arg_14_2:Find("lock"), arg_14_1 >= self.gameData.usedtime + (self.gameData.count > 0 and 1 or 0))

			local var_14_1 = arg_14_1 < self.gameData.usedtime

			setActive(arg_14_2:Find("cleared"), arg_14_1 < self.gameData.usedtime)
			setActive(arg_14_2:Find("Text"), not var_14_0)

			if not var_14_1 and not var_13_0 then
				var_13_0 = arg_14_1
			end

			arg_14_2:GetComponent(typeof(Image)).enabled = not var_14_0
		end

		return
	end)
	self.levelList:align(FushunAdventureGameConst.LEVEL_CNT)
	setActive(findTF(self._go, "tip/got"), self.gameData.ultimate ~= 0)

	if nil then
		setAnchoredPosition(self.levelList.container, {
			y = self.levelList.container.anchoredPosition.y + nil * (self.levelList.item.rect.height + 50)
		})
	end

	if self.OnLevelUpdate then
		self.OnLevelUpdate()
	end

	return
end

function FushunAdventureGame:InitGameUI()
	self.btnA = findTF(self.gameUI, "UI/A")
	self.btnB = findTF(self.gameUI, "UI/B")
	self.btnAEffect = self.btnA:Find("effect")
	self.btnBEffect = self.btnB:Find("effect")
	self.btnAExEffect = self.btnA:Find("effect_ex")
	self.btnBExEffect = self.btnB:Find("effect_ex")

	local var_15_0 = {}

	var_15_0[1] = findTF(self.gameUI, "UI/keys/1"):GetComponent(typeof(Image))
	var_15_0[2] = findTF(self.gameUI, "UI/keys/2"):GetComponent(typeof(Image))
	var_15_0[3] = findTF(self.gameUI, "UI/keys/3"):GetComponent(typeof(Image))
	self.keys = var_15_0
	self.btnSprites = {
		self.keys[1].sprite,
		self.btnA:GetComponent(typeof(Image)).sprite,
		self.btnB:GetComponent(typeof(Image)).sprite
	}
	self.hearts = {
		findTF(self.gameUI, "UI/heart_score/hearts/1/mark"),
		findTF(self.gameUI, "UI/heart_score/hearts/2/mark"),
		findTF(self.gameUI, "UI/heart_score/hearts/3/mark")
	}
	self.numbers = {
		findTF(self.gameUI, "UI/countdown_panel/timer/3"),
		findTF(self.gameUI, "UI/countdown_panel/timer/2"),
		findTF(self.gameUI, "UI/countdown_panel/timer/1")
	}
	self.scoreTxt = findTF(self.gameUI, "UI/heart_score/score/Text"):GetComponent(typeof(Text))
	self.energyBar = findTF(self.gameUI, "UI/ex/bar"):GetComponent(typeof(Image))
	self.energyIcon = findTF(self.gameUI, "UI/ex/icon")
	self.energyLight = findTF(self.gameUI, "UI/ex/light")
	self.exTipPanel = findTF(self.gameUI, "UI/ex_tip_panel")
	self.comboTxt = findTF(self.gameUI, "UI/combo/Text"):GetComponent(typeof(Text))
	self.countdownPanel = findTF(self.gameUI, "UI/countdown_panel")
	self.resultPanel = findTF(self.gameUI, "UI/result_panel")
	self.resultCloseBtn = findTF(self.resultPanel, "frame/close")
	self.resultHighestScoreTxt = findTF(self.resultPanel, "frame/highest/Text"):GetComponent(typeof(Text))
	self.resultScoreTxt = findTF(self.resultPanel, "frame/score/Text"):GetComponent(typeof(Text))
	self.msgboxPanel = findTF(self.gameUI, "UI/msg_panel")
	self.exitMsgboxWindow = findTF(self.msgboxPanel, "frame/exit_mode")
	self.pauseMsgboxWindow = findTF(self.msgboxPanel, "frame/pause_mode")
	self.helpWindow = findTF(self.gameUI, "UI/help")
	self.lightTF = findTF(self.gameUI, "game/range")
	self.lightMark = self.lightTF:Find("Image")
	self.pauseBtn = findTF(self.gameUI, "UI/pause")
	self.exitBtn = findTF(self.gameUI, "UI/back")
	self.energyBar.fillAmount = 0

	return
end

function FushunAdventureGame:EnterAnimation(arg_16_1)
	setActive(self.countdownPanel, true)

	local function var_16_0(arg_17_0)
		for iter_17_0, iter_17_1 in ipairs(self.numbers) do
			setActive(iter_17_1, iter_17_0 == arg_17_0)
		end

		return
	end

	local var_16_1 = 1

	self.countdownTimer = Timer.New(function()
		var_16_1 = var_16_1 + 1

		if var_16_1 > 3 then
			setActive(self.countdownPanel, false)
			arg_16_1()
		else
			var_16_0(var_16_1)
		end

		return
	end, 1, 3)

	var_16_0(1)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(FushunAdventureGameConst.COUNT_DOWN_VOICE)
	self.countdownTimer:Start()

	return
end

function FushunAdventureGame:ShowHelpWindow(arg_19_1)
	setActive(self.helpWindow, true)
	onButton(self, self.helpWindow, function()
		setActive(self.helpWindow, false)
		PlayerPrefs.SetInt("FushunAdventureGame" .. getProxy(PlayerProxy):getRawData().id, 1)
		arg_19_1()

		return
	end, SFX_PANEL)

	return
end

function FushunAdventureGame:DisplayKey()
	local function var_21_0(arg_22_0, arg_22_1)
		local var_22_0

		if not arg_22_1 or arg_22_1 == "" then
			var_22_0 = self.btnSprites[1]
		elseif arg_22_1 == "A" then
			var_22_0 = self.btnSprites[2]
		elseif arg_22_1 == "B" then
			var_22_0 = self.btnSprites[3]
		end

		if arg_22_0.sprite ~= var_22_0 then
			arg_22_0.sprite = var_22_0
		end

		return
	end

	for iter_21_0, iter_21_1 in ipairs(self.keys) do
		var_21_0(iter_21_1, string.sub(self.key, iter_21_0, iter_21_0) or "")
	end

	return
end

function FushunAdventureGame:DisplayeHearts(arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(self.hearts) do
		setActive(iter_23_1, iter_23_0 <= arg_23_1)
	end

	return
end

function FushunAdventureGame:DisplayScore()
	self.scoreTxt.text = self.score

	return
end

function FushunAdventureGame:DisplayeEnergy(arg_25_1, arg_25_2)
	local var_25_0 = math.min(1, arg_25_1 / arg_25_2)

	self.energyBar.fillAmount = var_25_0

	setAnchoredPosition(self.energyIcon, {
		x = math.max(0, self.energyIcon.parent.rect.width * var_25_0 - self.energyIcon.rect.width)
	})

	local var_25_1 = 0

	if var_25_0 >= 1 then
		var_25_1 = tf(self.energyBar.gameObject).rect.width
	elseif self.energyIcon.parent.rect.width * var_25_0 > 0 then
		var_25_1 = self.energyIcon.parent.rect.width * var_25_0
	end

	setActive(self.energyLight, var_25_0 >= 0.01)

	self.energyLight.sizeDelta = Vector2(var_25_1, self.energyLight.sizeDelta.y)

	return
end

function FushunAdventureGame:SetGameStateCallback(arg_26_1, arg_26_2)
	self._startCallback = arg_26_1
	self._endCallback = arg_26_2

	return
end

function FushunAdventureGame:StartGame()
	if self.state ~= var_0_4 then
		return
	end

	if self._startCallback then
		self._startCallback()
	end

	self.enemys = {}
	self.hitList = {}
	self.missFlags = {}
	self.score = 0
	self.combo = 0
	self.pause = false
	self.schedule = FushunSchedule.New()
	self.specailSchedule = FushunSchedule.New()

	self:LoadScene(function()
		self:EnterGame()
		pg.BgmMgr.GetInstance():Push(self.__cname, FushunAdventureGameConst.GAME_BGM_NAME)

		return
	end)

	self.state = var_0_5

	return
end

function FushunAdventureGame:LoadScene(arg_29_1)
	seriesAsync({
		function(arg_30_0)
			if self.gameUI then
				setActive(self.gameUI, true)
				arg_30_0()
			else
				self:loadPrefab("ui/FushunAdventureGame", function(arg_31_0)
					self.gameUI = arg_31_0

					arg_31_0.transform:SetParent(self._go.transform, false)
					self:InitGameUI()
					arg_30_0()

					return
				end)
			end

			return
		end,
		function(arg_32_0)
			self:DisplayeHearts(3)
			self:DisplayScore()
			self:DisplayeEnergy(0, 1)

			if PlayerPrefs.GetInt("FushunAdventureGame" .. getProxy(PlayerProxy):getRawData().id, 0) <= 0 then
				self:ShowHelpWindow(arg_32_0)
			else
				arg_32_0()
			end

			return
		end,
		function(arg_33_0)
			parallelAsync({
				function(arg_34_0)
					self:EnterAnimation(arg_34_0)

					return
				end,
				function(arg_35_0)
					self:loadPrefab("ui/fa_fushun", function(arg_36_0)
						self.fushun = FushunChar.New(arg_36_0)

						self.fushun:SetPosition(FushunAdventureGameConst.FUSHUN_INIT_POSITION)
						arg_36_0.transform:SetParent(self.gameUI.transform:Find("game"), false)
						arg_35_0()

						return
					end)

					return
				end
			}, arg_33_0)

			return
		end
	}, arg_29_1)

	return
end

function FushunAdventureGame:EnterGame()
	self.handle = self.handle or UpdateBeat:CreateListener(self.UpdateGame, self)

	UpdateBeat:AddListener(self.handle)

	self.lightTF.sizeDelta = Vector2(FushunAdventureGameConst.FUSHUN_ATTACK_RANGE, self.lightTF.sizeDelta.y)
	self.lightTF.localPosition = Vector2(FushunAdventureGameConst.FUSHUN_ATTACK_DISTANCE + self.fushun:GetPosition().x, self.lightTF.localPosition.y)

	self:SpawnEnemys()
	self:RegisterEventListener()

	self.key = ""

	self.fushun:SetOnAnimEnd(function()
		self.key = ""

		self:DisplayKey()

		return
	end)

	return
end

function FushunAdventureGame:UpdateGame()
	if self.state == var_0_6 then
		self:ExitGame(true)

		return
	end

	if not self.pause then
		self.spawner:Update()
		self:AddDebugInput()

		if self.fushun:IsDeath() then
			self.fushun:Die()

			self.state = var_0_6

			return
		elseif self.fushun:ShouldInvincible() then
			self:EnterInvincibleMode()
		elseif self.fushun:ShouldVincible() then
			self:ExitInvincibleMode()
		end

		local var_39_0 = false

		for iter_39_0 = #self.enemys, 1, -1 do
			if self.enemys[iter_39_0]:IsFreeze() then
				-- block empty
			elseif self:CheckEnemyDeath(iter_39_0) then
				-- block empty
			else
				self.enemys[iter_39_0]:Move()
				self:CheckCollision(self.fushun, self.enemys[iter_39_0])

				if self:CheckAttackRange(self.enemys[iter_39_0]) then
					var_39_0 = true
				end
			end
		end

		self:RangeLightDisplay(var_39_0)
		self:DisplayeEnergy(self.fushun:GetEnergy(), self.fushun:GetEnergyTarget())
		self.specailSchedule:Update()
	else
		for iter_39_1 = #self.enemys, 1, -1 do
			self:CheckEnemyDeath(iter_39_1)
		end
	end

	self.schedule:Update()

	return
end

function FushunAdventureGame:RangeLightDisplay(arg_40_1)
	setActive(self.lightMark, arg_40_1)

	return
end

function FushunAdventureGame:CheckAttackRange(arg_41_1)
	return arg_41_1:GetPosition().x <= self.fushun:GetAttackPosition().x
end

function FushunAdventureGame:CheckEnemyDeath(arg_42_1)
	local var_42_0 = false

	if self.enemys[arg_42_1]:IsDeath() then
		if self.hitList[self.enemys[arg_42_1].index] and not self.enemys[arg_42_1]:IsEscape() then
			self:AddScore(self.enemys[arg_42_1]:GetScore())
			self:AddEnergy(self.enemys[arg_42_1]:GetEnergyScore())
		end

		self.enemys[arg_42_1]:Vanish()
		table.remove(self.enemys, arg_42_1)

		var_42_0 = true
	end

	return var_42_0
end

function FushunAdventureGame:EnterInvincibleMode()
	local var_43_0 = FushunAdventureGameConst.EX_TIME

	self.fushun:Invincible()
	setActive(self.exTipPanel, true)

	self.pause = true

	blinkAni(self.energyBar.gameObject, 0.5, -1)
	self.schedule:AddSchedule(FushunAdventureGameConst.EX_TIP_TIME, 1, function()
		setActive(self.exTipPanel, false)
		self.spawner:CarzyMode()

		self.pause = false

		self.fushun:StartAction("EX")
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(FushunAdventureGameConst.ENTER_EX_VOICE)

		local var_44_0 = self.fushun:GetEnergyTarget() / var_43_0

		self.specailSchedule:AddSchedule(1, var_43_0, function()
			self.fushun:ReduceEnergy(var_44_0)

			return
		end)

		return
	end)
	setActive(self.btnAExEffect, true)
	setActive(self.btnBExEffect, true)

	self.key = ""

	self:DisplayKey()

	return
end

function FushunAdventureGame:ExitInvincibleMode()
	self.fushun:Vincible()

	self.energyBar.color = Color.New(1, 1, 1, 1)

	LeanTween.cancel(self.energyBar.gameObject)

	for iter_46_0, iter_46_1 in ipairs(self.enemys) do
		self.hitList[iter_46_1.index] = nil

		iter_46_1:Die()
	end

	self.spawner:NormalMode()
	setActive(self.btnAExEffect, false)
	setActive(self.btnBExEffect, false)

	return
end

function FushunAdventureGame:CheckCollision(arg_47_1, arg_47_2)
	if FushunAdventureGame.IsCollision(arg_47_2.effectCollider2D, arg_47_1.collider2D) then
		arg_47_1:Hurt()
		arg_47_2:OnHit()
		self:DisplayeHearts(self.fushun:GetHp())
		self:AddCombo(-self.combo)
	elseif self.fushun:InvincibleState() and not arg_47_2:IsDeath() and arg_47_2:GetPosition().x <= arg_47_1:GetAttackPosition().x then
		arg_47_2:Hurt(1)

		self.hitList[arg_47_2.index] = true

		self:AddHitEffect(arg_47_2)
	elseif FushunAdventureGame.IsNearby(arg_47_1:GetPosition(), arg_47_2:GetAttackPosition()) then
		arg_47_2:Attack()
	end

	return
end

function FushunAdventureGame:AddHitEffect(arg_48_1)
	local var_48_0 = Vector3(self.gameUI.transform:InverseTransformPoint((arg_48_1.collider2D.bounds:GetMin())).x, self.gameUI.transform:InverseTransformPoint(self.fushun.effectCollider2D.bounds.center).y, 0)

	self:loadPrefab("ui/fa_attack_effect", function(arg_49_0)
		arg_49_0.transform:SetParent(self.gameUI.transform, false)

		arg_49_0.transform.localPosition = var_48_0

		local var_49_0 = arg_49_0:GetComponent(typeof(DftAniEvent))

		var_49_0:SetEndEvent(function()
			var_49_0:SetEndEvent(nil)

			if arg_49_0 then
				Destroy(arg_49_0)
			end

			return
		end)

		return
	end)
	self:ShakeScreen(self.gameUI)

	return
end

function FushunAdventureGame:ShakeScreen(arg_51_1)
	if LeanTween.isTweening(arg_51_1) then
		LeanTween.cancel(arg_51_1)
	end

	LeanTween.rotateAroundLocal(arg_51_1, Vector3(0, 0, 1), FushunAdventureGameConst.SHAKE_RANGE, FushunAdventureGameConst.SHAKE_TIME):setLoopPingPong(FushunAdventureGameConst.SHAKE_LOOP_CNT):setFrom(-1 * FushunAdventureGameConst.SHAKE_RANGE):setOnComplete(System.Action(function()
		arg_51_1.transform.localEulerAngles = Vector3(0, 0, 0)

		return
	end))

	return
end

function FushunAdventureGame:SpawnEnemys()
	local var_53_0 = {
		FushunBeastChar,
		FushunEliteBeastChar,
		FushunEliteBeastChar
	}

	local function var_53_1(arg_54_0)
		local var_54_0

		for iter_54_0, iter_54_1 in ipairs(FushunAdventureGameConst.SPEED_ADDITION) do
			if iter_54_1[1][1] <= arg_54_0 and arg_54_0 <= iter_54_1[1][2] then
				var_54_0 = iter_54_1

				break
			end
		end

		var_54_0 = var_54_0 or FushunAdventureGameConst.SPEED_ADDITION[#FushunAdventureGameConst.SPEED_ADDITION]

		return var_54_0[2]
	end

	self.spawner = FuShunEnemySpawner.New(self.gameUI.transform:Find("game").transform, function(arg_55_0)
		local var_55_0 = var_53_0[arg_55_0.config.id].New(arg_55_0.go, arg_55_0.index, arg_55_0.config)
		local var_55_1 = arg_55_0.speed + var_53_1(self.score)

		FushunAdventureGame.LOG("  顺序 :", arg_55_0.index, " id :", arg_55_0.config.id, " speed :", var_55_1)
		var_55_0:SetSpeed(var_55_1)
		var_55_0:SetPosition(FushunAdventureGameConst.ENEMY_SPAWN_POSITION)
		table.insert(self.enemys, var_55_0)

		return
	end)

	self.spawner:NormalMode()

	return
end

function FushunAdventureGame:AddScore(arg_56_1)
	self:AddCombo(1)

	self.score = self.score + arg_56_1 + ((self.combo >= FushunAdventureGameConst.COMBO_SCORE_TARGET or nil) and (FushunAdventureGameConst.COMBO_EXTRA_SCORE or 0))

	self:DisplayScore()
	self.spawner:UpdateScore(self.score)

	return
end

function FushunAdventureGame:AddEnergy(arg_57_1)
	self.fushun:AddEnergy(arg_57_1)

	return
end

function FushunAdventureGame:AddCombo(arg_58_1)
	if arg_58_1 > 0 then
		self:loadPrefab("UI/fushun_combo", function(arg_59_0)
			arg_59_0.transform:SetParent(self.gameUI.transform:Find("UI"), false)

			local var_59_0

			var_59_0 = Timer.New(function()
				if arg_59_0 then
					Destroy(arg_59_0)
				end

				if var_59_0 then
					var_59_0:Stop()

					var_59_0 = nil
				end

				return
			end, 1, 1)

			;(nil):Start()

			return
		end)
	end

	self.combo = self.combo + arg_58_1
	self.comboTxt.text = self.combo

	setActive(self.comboTxt.gameObject.transform.parent, self.combo > 0)

	return
end

function FushunAdventureGame:Action(arg_61_1)
	if self.fushun:InvincibleState() then
		self:AddScore(FushunAdventureGameConst.EX_CLICK_SCORE)
	else
		self:OnFushunAttack(arg_61_1)
	end

	return
end

function FushunAdventureGame:OnFushunAttack(arg_62_1)
	if #self.key == 3 or self.fushun:IsMissState() or self.fushun:IsDamageState() then
		return
	end

	self.key = self.key .. arg_62_1

	self:DisplayKey()

	local var_62_0 = {}

	for iter_62_0, iter_62_1 in ipairs(self.enemys) do
		if not iter_62_1:WillDeath() and iter_62_1:GetPosition().x <= self.fushun:GetAttackPosition().x then
			table.insert(var_62_0, iter_62_0)
		end
	end

	self.fushun:TriggerAction(self.key, function()
		if #var_62_0 == 0 then
			self.fushun:Miss()
		end

		self.key = ""

		self:DisplayKey()

		return
	end)

	if #var_62_0 > 0 then
		for iter_62_2, iter_62_3 in ipairs(var_62_0) do
			self.enemys[iter_62_3]:Hurt(1)

			self.hitList[self.enemys[iter_62_3].index] = true

			self:AddHitEffect(self.enemys[iter_62_3])
		end
	end

	return
end

function FushunAdventureGame:PauseGame()
	self.pause = true

	return
end

function FushunAdventureGame:ResumeGame()
	self.pause = false

	return
end

function FushunAdventureGame:ExitGame(arg_66_1)
	local function var_66_0()
		self:ClearGameScene()

		return
	end

	if self.btnA then
		ClearEventTrigger(self.btnA:GetComponent("EventTriggerListener"))
	end

	if self.btnB then
		ClearEventTrigger(self.btnB:GetComponent("EventTriggerListener"))
	end

	if self.handle then
		UpdateBeat:RemoveListener(self.handle)

		self.handle = nil
	end

	if self.schedule then
		self.schedule:Dispose()

		self.schedule = nil
	end

	if self.specailSchedule then
		self.specailSchedule:Dispose()

		self.specailSchedule = nil
	end

	if arg_66_1 then
		if self.OnShowResult then
			self.OnShowResult(self.score)
		end

		self:ShowResultWindow(function()
			var_66_0()

			return
		end)
	else
		var_66_0()
	end

	return
end

function FushunAdventureGame:ClearGameScene()
	if self.fushun then
		self.fushun:Destory()

		self.fushun = nil
	end

	if self.spawner then
		self.spawner:Dispose()

		self.spawner = nil
	end

	if self.enemys then
		for iter_69_0, iter_69_1 in ipairs(self.enemys) do
			iter_69_1:Dispose()
		end

		self.enemys = nil
	end

	self.state = var_0_4

	if self.gameUI then
		self:HideExitMsgbox()
		self:HideResultWindow()
		self:HidePauseMsgbox()
		setActive(self.gameUI, false)
		pg.BgmMgr.GetInstance():Push(self.__cname, FushunAdventureGameConst.BGM_NAME)
	end

	if self._endCallback then
		self._endCallback()
	end

	return
end

function FushunAdventureGame:IsStarting()
	return self.state == var_0_5
end

function FushunAdventureGame:Dispose()
	if self.countdownTimer then
		self.countdownTimer:Stop()

		self.countdownTimer = nil
	end

	self._startCallback = nil
	self._endCallback = nil

	self:ExitGame()
	pg.DelegateInfo.Dispose(self)

	if self.gameUI then
		Destroy(self.gameUI)

		self.gameUI = nil
	end

	self._go = nil
	self.btnSprites = nil
	self.state = var_0_2
	self.OnShowResult = nil
	self.OnLevelUpdate = nil

	return
end

function FushunAdventureGame:AddDebugInput()
	if IsUnityEditor then
		if Input.GetKeyDown(KeyCode.A) then
			self:OnShowBtnEffect("A", true)
		end

		if Input.GetKeyUp(KeyCode.A) then
			self:Action("A")
			self:OnShowBtnEffect("A", false)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(FushunAdventureGameConst.A_BTN_VOICE)
		end

		if Input.GetKeyDown(KeyCode.S) then
			self:OnShowBtnEffect("B", true)
		end

		if Input.GetKeyUp(KeyCode.S) then
			self:Action("B")
			self:OnShowBtnEffect("B", false)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(FushunAdventureGameConst.B_BTN_VOICE)
		end
	end

	return
end

function FushunAdventureGame:RegisterEventListener()
	local var_73_0 = self.btnA:GetComponent("EventTriggerListener")

	var_73_0:AddPointDownFunc(function()
		self:OnShowBtnEffect("A", true)

		return
	end)
	var_73_0:AddPointExitFunc(function()
		self:OnShowBtnEffect("A", false)

		return
	end)
	var_73_0:AddPointUpFunc(function()
		if self.pause then
			return
		end

		self:Action("A")
		self:OnShowBtnEffect("A", false)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(FushunAdventureGameConst.A_BTN_VOICE)

		return
	end)

	local var_73_1 = self.btnB:GetComponent("EventTriggerListener")

	var_73_1:AddPointDownFunc(function()
		self:OnShowBtnEffect("B", true)

		return
	end)
	var_73_1:AddPointExitFunc(function()
		self:OnShowBtnEffect("B", false)

		return
	end)
	var_73_1:AddPointUpFunc(function()
		if self.pause then
			return
		end

		self:Action("B")
		self:OnShowBtnEffect("B", false)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(FushunAdventureGameConst.B_BTN_VOICE)

		return
	end)
	onButton(self, self.pauseBtn, function()
		self:ShowPauseMsgbox()

		return
	end, SFX_PANEL)
	onButton(self, self.exitBtn, function()
		self:ShowExitMsgbox()

		return
	end, SFX_PANEL)

	return
end

function FushunAdventureGame:OnShowBtnEffect(arg_82_1, arg_82_2)
	setActive(self["btn" .. arg_82_1 .. "Effect"], arg_82_2)

	return
end

function FushunAdventureGame:ShowResultWindow(arg_83_1)
	setActive(self.resultPanel, true)
	onButton(self, self.resultCloseBtn, function()
		self:HideResultWindow()

		if arg_83_1 then
			arg_83_1()
		end

		return
	end, SFX_PANEL)

	if self.roomId then
		self.highestScore = getProxy(GameRoomProxy):getRoomScore(self.roomId)
	end

	self.resultHighestScoreTxt.text = self.highestScore
	self.resultScoreTxt.text = self.score

	if self.score > self.highestScore then
		self.highestScore = self.score
	end

	return
end

function FushunAdventureGame:HideResultWindow()
	setActive(self.resultPanel, false)

	return
end

function FushunAdventureGame:ShowPauseMsgbox()
	self:PauseGame()
	setActive(self.msgboxPanel, true)
	setActive(self.pauseMsgboxWindow, true)
	setActive(self.exitMsgboxWindow, false)
	onButton(self, self.pauseMsgboxWindow:Find("continue_btn"), function()
		self:ResumeGame()
		self:HidePauseMsgbox()

		return
	end, SFX_PANEL)

	return
end

function FushunAdventureGame:HidePauseMsgbox()
	setActive(self.msgboxPanel, false)
	setActive(self.pauseMsgboxWindow, false)

	return
end

function FushunAdventureGame:ShowExitMsgbox()
	self:PauseGame()
	setActive(self.msgboxPanel, true)
	setActive(self.pauseMsgboxWindow, false)
	setActive(self.exitMsgboxWindow, true)
	onButton(self, self.exitMsgboxWindow:Find("cancel_btn"), function()
		self:ResumeGame()
		self:HideExitMsgbox()

		return
	end, SFX_PANEL)
	onButton(self, self.exitMsgboxWindow:Find("confirm_btn"), function()
		self:HideExitMsgbox()

		if self.OnShowResult then
			self.OnShowResult(self.score)
		end

		self:ExitGame()

		return
	end, SFX_PANEL)

	return
end

function FushunAdventureGame:HideExitMsgbox()
	setActive(self.msgboxPanel, false)
	setActive(self.exitMsgboxWindow, false)

	return
end

function FushunAdventureGame:IsCollision(arg_93_1)
	return self.enabled and arg_93_1.enabled and self.gameObject.activeSelf and self.bounds:Intersects(arg_93_1.bounds)
end

function FushunAdventureGame:IsNearby(arg_94_1)
	return arg_94_1.x - self.x <= 0
end

function FushunAdventureGame.LOG(...)
	if var_0_1 then
		print(...)
	end

	return
end

return FushunAdventureGame
