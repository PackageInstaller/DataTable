local Fushun3GameView = class("Fushun3GameView", import("..BaseMiniGameView"))
local var_0_1 = "event:/ui/ddldaoshu2"
local var_0_2 = "fushun_game3_tip"
local var_0_6 = "event:/ui/break_out_full"

function Fushun3GameView:getUIName()
	return "Fushun3GameView"
end

function Fushun3GameView:didEnter()
	self:initEvent()
	self:initData()
	self:initUI()
	self:initGameUI()
	self:initController()
	self:updateMenuUI()
	self:openMenuUI()

	return
end

function Fushun3GameView:initEvent()
	self:bind(Fushun3GameEvent.create_item_call, function(arg_4_0, arg_4_1, arg_4_2)
		if self.itemController then
			self.itemController:createItem(arg_4_1.name, arg_4_1.pos)
		end

		return
	end)
	self:bind(Fushun3GameEvent.create_platform_item_call, function(arg_5_0, arg_5_1, arg_5_2)
		if self.itemController then
			self.itemController:createPlatformItem(arg_5_1.pos, arg_5_1.id)
		end

		return
	end)
	self:bind(Fushun3GameEvent.item_follow_call, function(arg_6_0, arg_6_1, arg_6_2)
		if self.itemController then
			self.itemController:itemFollow(arg_6_1.anchoredPos)
		end

		return
	end)
	self:bind(Fushun3GameEvent.create_monster_call, function(arg_7_0, arg_7_1, arg_7_2)
		if self.monsterController then
			self.monsterController:createMonster(arg_7_1.pos)
		end

		return
	end)
	self:bind(Fushun3GameEvent.player_attack_call, function(arg_8_0, arg_8_1, arg_8_2)
		if self.monsterController then
			self.monsterController:checkMonsterDamage(arg_8_1.collider, arg_8_1.callback, Fushun3GameEvent.attack_damdage_monster_call)
		end

		return
	end)
	self:bind(Fushun3GameEvent.char_damaged_call, function(arg_9_0, arg_9_1, arg_9_2)
		self:updateGameUI()

		if self.charController:getHeart() == 0 then
			self:onGameOver()
		end

		return
	end)
	self:bind(Fushun3GameEvent.check_item_damage, function(arg_10_0, arg_10_1, arg_10_2)
		if self.monsterController then
			self.monsterController:checkMonsterDamage(arg_10_1.collider, arg_10_1.callback, Fushun3GameEvent.shot_damage_monster_call)
		end

		return
	end)
	self:bind(Fushun3GameEvent.check_player_damage, function(arg_11_0, arg_11_1, arg_11_2)
		if self.monsterController then
			self.monsterController:checkPlayerDamage(arg_11_1.tf, arg_11_1.callback)
		end

		return
	end)
	self:bind(Fushun3GameEvent.power_damage_monster_call, function(arg_12_0, arg_12_1, arg_12_2)
		if self.monsterController then
			self.monsterController:damageMonster(arg_12_1.tf, Fushun3GameEvent.power_damage_monster_call)
		end

		return
	end)
	self:bind(Fushun3GameEvent.shot_damage_monster_call, function(arg_13_0, arg_13_1, arg_13_2)
		if self.monsterController then
			self.monsterController:damageMonster(arg_13_1.tf, Fushun3GameEvent.shot_damage_monster_call)
		end

		return
	end)
	self:bind(Fushun3GameEvent.attack_damdage_monster_call, function(arg_14_0, arg_14_1, arg_14_2)
		if self.monsterController then
			self.monsterController:damageMonster(arg_14_1.tf, Fushun3GameEvent.attack_damdage_monster_call)
		end

		return
	end)
	self:bind(Fushun3GameEvent.kick_damage_monster_call, function(arg_15_0, arg_15_1, arg_15_2)
		if self.monsterController then
			self.monsterController:damageMonster(arg_15_1.tf, Fushun3GameEvent.kick_damage_monster_call, arg_15_1.callback)
		end

		return
	end)
	self:bind(Fushun3GameEvent.add_anim_effect_call, function(arg_16_0, arg_16_1, arg_16_2)
		if self.effectController and arg_16_1 then
			self.effectController:addEffectByAnim(arg_16_1.clipName, arg_16_1.targetTf)
		end

		return
	end)
	self:bind(Fushun3GameEvent.add_effect_call, function(arg_17_0, arg_17_1, arg_17_2)
		if self.effectController and arg_17_1 then
			self.effectController:addEffectByName(arg_17_1.effectName, arg_17_1.targetTf)
		end

		return
	end)
	self:bind(Fushun3GameEvent.power_speed_call, function(arg_18_0, arg_18_1, arg_18_2)
		if self.platformController then
			self.platformController:onPlayerPower()
		end

		return
	end)
	self:bind(Fushun3GameEvent.add_monster_score_call, function(arg_19_0, arg_19_1, arg_19_2)
		self.charController:addPower(Fushun3GameConst.monster_score)
		self:addScore(Fushun3GameConst.monster_score)

		return
	end)
	self:bind(Fushun3GameEvent.game_over_call, function(arg_20_0, arg_20_1, arg_20_2)
		self:onGameOver()

		return
	end)
	self:bind(Fushun3GameEvent.day_night_change, function(arg_21_0, arg_21_1, arg_21_2)
		if self.platformController then
			self.platformController:updateDayNight()
		end

		return
	end)

	return
end

function Fushun3GameView:onEventHandle(arg_22_1)
	return
end

function Fushun3GameView:initData()
	Fushun3GameVo.ChangeTimeType((math.random() < 0.5 or nil) and (Fushun3GameConst.day_type or Fushun3GameConst.night_type))

	self.dayTimeFlag = Fushun3GameVo.GetTimeFlag()

	local var_23_0 = Application.targetFrameRate or 60

	if var_23_0 > 60 then
		var_23_0 = 60
	end

	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 1 / var_23_0, -1)

	return
end

function Fushun3GameView:initController()
	self.charTf = findTF(self._tf, "sceneContainer/scene/char")
	self.rectCollider = RectCollider.New(self.charTf, {}, self)

	self.rectCollider:addScript(FuShunMovementScript.New())
	self.rectCollider:addScript(FuShunAttakeScript.New())
	self.rectCollider:addScript(FuShunJumpScript.New())
	self.rectCollider:addScript(FuShunPowerSpeedScript.New())
	self.rectCollider:addScript(FuShunDamageScript.New())

	self.platformController = Fushun3PlatformControll.New(self.sceneTf, findTF(self._tf, "tpls/platformTpls"), findTF(self.sceneTf, "platform/content"), self)
	self.sceneController = Fushun3SceneController.New(self.backSceneTf, self.sceneTf, self.charTf)
	self.charController = Fushun3CharController.New(self.rectCollider, self.charTf, self.rectCollider:getCollisionInfo(), self.powerProgressSlider, self)
	self.itemController = Fushun3ItemController.New(self.sceneTf, self.charTf, findTF(self._tf, "tpls/itemTpls"), self)

	self.itemController:setCallback(function(arg_26_0, arg_26_1)
		self:onControllerCallback(arg_26_0, arg_26_1)

		return
	end)

	self.bgController = Fushun3BgController.New(findTF(self._tf, "tpls/bgTpls"), findTF(self._tf, "tpls/fireTpls"), findTF(self._tf, "tpls/petalTpl"), self.backSceneTf, self)
	self.monsterController = Fushun3MonsterController.New(findTF(self._tf, "tpls/monsterTpls"), findTF(self.sceneTf, "monster"), self.sceneTf, self)
	self.effectController = Fushun3EffectController.New(findTF(self._tf, "tpls/efTpls"), findTF(self.sceneTf, "effect"), self)

	return
end

function Fushun3GameView:initUI()
	self.backSceneTf = findTF(self._tf, "sceneContainer/scene_background")
	self.frontSceneTf = findTF(self._tf, "sceneContainer/scene_front")
	self.sceneTf = findTF(self._tf, "sceneContainer/scene")
	self.clickMask = findTF(self._tf, "clickMask")
	self.countUI = findTF(self._tf, "pop/CountUI")
	self.countAnimator = GetComponent(findTF(self.countUI, "count"), typeof(Animator))
	self.countDft = GetOrAddComponent(findTF(self.countUI, "count"), typeof(DftAniEvent))

	self.countDft:SetTriggerEvent(function()
		return
	end)
	self.countDft:SetEndEvent(function()
		setActive(self.countUI, false)
		self:gameStart()

		return
	end)
	SetActive(self.countUI, false)

	self.leaveUI = findTF(self._tf, "pop/LeaveUI")

	onButton(self, findTF(self.leaveUI, "ad/btnOk"), function()
		self:resumeGame()
		self:onGameOver()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.leaveUI, "ad/btnCancel"), function()
		self:resumeGame()

		return
	end, SFX_CANCEL)
	SetActive(self.leaveUI, false)

	self.pauseUI = findTF(self._tf, "pop/pauseUI")

	onButton(self, findTF(self.pauseUI, "ad/btnOk"), function()
		setActive(self.pauseUI, false)
		self:resumeGame()

		return
	end, SFX_CANCEL)
	SetActive(self.pauseUI, false)

	self.settlementUI = findTF(self._tf, "pop/SettleMentUI")

	onButton(self, findTF(self.settlementUI, "ad/btnOver"), function()
		setActive(self.settlementUI, false)
		self:openMenuUI()

		return
	end, SFX_CANCEL)
	SetActive(self.settlementUI, false)

	self.menuUI = findTF(self._tf, "pop/menuUI")
	self.battleScrollRect = GetComponent(findTF(self.menuUI, "battList"), typeof(ScrollRect))
	self.totalTimes = self:getGameTotalTime()

	scrollTo(self.battleScrollRect, 0, 1 - (self:getGameUsedTimes() - 4 < 0 and 0 or self:getGameUsedTimes() - 4) / (self.totalTimes - 4))
	onButton(self, findTF(self.menuUI, "rightPanelBg/arrowUp"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y + 1 / (self.totalTimes - 4) > 1 or nil) and 1)

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "rightPanelBg/arrowDown"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y - 1 / (self.totalTimes - 4) < 0 or nil) and 0)

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnBack"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnRule"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[var_0_2].tip
		})

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnStart"), function()
		setActive(self.menuUI, false)
		self:readyStart()

		return
	end, SFX_CANCEL)

	local var_27_0 = findTF(self.menuUI, "tplBattleItem")

	self.battleItems = {}
	self.dropItems = {}

	for iter_27_0 = 1, 7 do
		local var_27_1 = tf(instantiate(var_27_0))

		var_27_1.name = "battleItem_" .. iter_27_0

		setParent(var_27_1, findTF(self.menuUI, "battList/Viewport/Content"))
		GetSpriteFromAtlasAsync("ui/minigameui/fushun3gameui_atlas", "battleDesc" .. iter_27_0, function(arg_39_0)
			setImageSprite(findTF(var_27_1, "state_open/buttomDesc"), arg_39_0, true)
			setImageSprite(findTF(var_27_1, "state_clear/buttomDesc"), arg_39_0, true)
			setImageSprite(findTF(var_27_1, "state_current/buttomDesc"), arg_39_0, true)
			setImageSprite(findTF(var_27_1, "state_closed/buttomDesc"), arg_39_0, true)

			return
		end)
		setActive(var_27_1, true)
		table.insert(self.battleItems, var_27_1)
	end

	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	return
end

function Fushun3GameView:initGameUI()
	self.gameUI = findTF(self._tf, "ui/gameUI")
	self.powerProgress = findTF(self.gameUI, "top/powerProgress")
	self.powerProgressSlider = GetComponent(self.powerProgress, typeof(Slider))

	onButton(self, findTF(self.gameUI, "topRight/btnStop"), function()
		self:stopGame()
		setActive(self.pauseUI, true)

		return
	end)
	onButton(self, findTF(self.gameUI, "btnLeave"), function()
		self:stopGame()
		setActive(self.leaveUI, true)

		return
	end)

	self.gameTimeS = findTF(self.gameUI, "top/time/s")
	self.scoreTf = findTF(self.gameUI, "top/score")
	self.hearts = {}

	for iter_40_0 = 1, Fushun3GameConst.heart_num do
		table.insert(self.hearts, findTF(self.gameUI, "top/heart" .. iter_40_0 .. "/full"))
	end

	self.atkDelegate = GetOrAddComponent(findTF(self.gameUI, "btnAtk"), "EventTriggerListener")
	self.atkDelegate.enabled = true

	self.atkDelegate:AddPointDownFunc(function(arg_43_0, arg_43_1)
		if self.charController then
			self.charController:attack()
		end

		return
	end)

	self.jumpDelegate = GetOrAddComponent(findTF(self.gameUI, "btnJump"), "EventTriggerListener")
	self.jumpDelegate.enabled = true

	self.jumpDelegate:AddPointDownFunc(function(arg_44_0, arg_44_1)
		if self.charController then
			self.charController:jump()
		end

		return
	end)
	setText(findTF(self._tf, "pop/LeaveUI/ad/desc/n"), i18n(Fushun3GameConst.mini_game_leave))
	setText(findTF(self._tf, "pop/pauseUI/ad/desc/n"), i18n(Fushun3GameConst.mini_game_pause))

	return
end

function Fushun3GameView:Update()
	self:AddDebugInput()

	return
end

function Fushun3GameView:AddDebugInput()
	if self.gameStop or self.settlementFlag then
		return
	end

	if Application.isEditor then
		-- block empty
	end

	return
end

function Fushun3GameView:updateMenuUI()
	local var_47_0 = self:getGameUsedTimes()
	local var_47_1 = self:getGameTimes()

	for iter_47_0 = 1, #self.battleItems do
		setActive(findTF(self.battleItems[iter_47_0], "bg/n"), not self.dayTimeFlag)
		setActive(findTF(self.battleItems[iter_47_0], "bg/d"), self.dayTimeFlag)
		setActive(findTF(self.battleItems[iter_47_0], "state_open"), false)
		setActive(findTF(self.battleItems[iter_47_0], "state_closed"), false)
		setActive(findTF(self.battleItems[iter_47_0], "state_clear"), false)
		setActive(findTF(self.battleItems[iter_47_0], "state_current"), false)

		if iter_47_0 <= var_47_0 then
			setActive(findTF(self.battleItems[iter_47_0], "state_clear"), true)
		elseif iter_47_0 == var_47_0 + 1 and var_47_1 >= 1 then
			setActive(findTF(self.battleItems[iter_47_0], "state_current"), true)
		elseif var_47_0 < iter_47_0 and iter_47_0 <= var_47_0 + var_47_1 then
			setActive(findTF(self.battleItems[iter_47_0], "state_open"), true)
		else
			setActive(findTF(self.battleItems[iter_47_0], "state_closed"), true)
		end
	end

	self.totalTimes = self:getGameTotalTime()

	local var_47_2 = 1 - (self:getGameUsedTimes() - 3 < 0 and 0 or self:getGameUsedTimes() - 3) / (self.totalTimes - 4)

	if var_47_2 > 1 then
		var_47_2 = 1
	end

	scrollTo(self.battleScrollRect, 0, var_47_2)
	setActive(findTF(self.menuUI, "btnStart/tip"), var_47_1 > 0)
	self:CheckGet()
	self:updateDayNightUI()

	return
end

function Fushun3GameView:CheckGet()
	setActive(findTF(self.menuUI, "got"), false)

	if self:getUltimate() and self:getUltimate() ~= 0 then
		setActive(findTF(self.menuUI, "got"), true)
	end

	if self:getUltimate() == 0 then
		if self:getGameTotalTime() > self:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = self:GetMGHubData().id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(self.menuUI, "got"), true)
	end

	return
end

function Fushun3GameView:openMenuUI()
	setActive(findTF(self._tf, "sceneContainer/scene_front"), false)
	setActive(findTF(self._tf, "sceneContainer/scene_background"), false)
	setActive(findTF(self._tf, "sceneContainer/scene"), false)
	setActive(findTF(self._tf, "bg"), true)
	setActive(self.gameUI, false)
	setActive(self.menuUI, true)
	self:updateMenuUI()

	return
end

function Fushun3GameView:clearUI()
	setActive(self.sceneTf, false)
	setActive(self.settlementUI, false)
	setActive(self.countUI, false)
	setActive(self.menuUI, false)
	setActive(self.gameUI, false)

	return
end

function Fushun3GameView:readyStart()
	setActive(self.countUI, true)
	self.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_1)

	return
end

function Fushun3GameView:gameStart()
	setActive(findTF(self._tf, "sceneContainer/scene_front"), true)
	setActive(findTF(self._tf, "sceneContainer/scene_background"), true)
	setActive(findTF(self._tf, "sceneContainer/scene"), true)
	setActive(self.gameUI, true)
	setActive(findTF(self._tf, "bg"), false)

	self.gameStartFlag = true
	self.scoreNum = 0
	self.playerPosIndex = 2
	self.gameStepTime = 0
	self.gameOverTime = 0
	self.gameTime = Fushun3GameConst.game_time
	self.gameLevelTime = Fushun3GameConst.level_time
	self.rectCollider:getCollisionInfo().config.moveSpeed = Fushun3GameConst.move_speed

	self.rectCollider:start()
	self.platformController:start()
	self.sceneController:start()
	self.charController:start()
	self.itemController:start()
	self.bgController:start()
	self.monsterController:start()
	self.effectController:start()
	self:updateGameUI()
	self:timerStart()

	return
end

function Fushun3GameView:getGameTimes()
	return self:GetMGHubData().count
end

function Fushun3GameView:getGameUsedTimes()
	return self:GetMGHubData().usedtime
end

function Fushun3GameView:getUltimate()
	return self:GetMGHubData().ultimate
end

function Fushun3GameView:getGameTotalTime()
	return (self:GetMGHubData():getConfig("reward_need"))
end

function Fushun3GameView:updateDayNightUI()
	self.dayTimeFlag = Fushun3GameVo.GetTimeFlag()

	setActive(findTF(self._tf, "bg/n"), not self.dayTimeFlag)
	setActive(findTF(self._tf, "bg/d"), self.dayTimeFlag)
	setActive(findTF(self.menuUI, "bg/n"), not self.dayTimeFlag)
	setActive(findTF(self.menuUI, "bg/d"), self.dayTimeFlag)
	setActive(findTF(self.menuUI, "btnBack/n"), not self.dayTimeFlag)
	setActive(findTF(self.menuUI, "btnBack/d"), self.dayTimeFlag)
	setActive(findTF(self.menuUI, "title/n"), not self.dayTimeFlag)
	setActive(findTF(self.menuUI, "title/d"), self.dayTimeFlag)
	setActive(findTF(self.menuUI, "desc/n"), not self.dayTimeFlag)
	setActive(findTF(self.menuUI, "desc/d"), self.dayTimeFlag)
	setActive(findTF(self.menuUI, "got/n"), not self.dayTimeFlag)
	setActive(findTF(self.menuUI, "got/d"), self.dayTimeFlag)
	setActive(findTF(self.menuUI, "btnRule/n"), not self.dayTimeFlag)
	setActive(findTF(self.menuUI, "btnRule/d"), self.dayTimeFlag)
	setActive(findTF(self.menuUI, "rightPanelBg/arrowUp/n"), not self.dayTimeFlag)
	setActive(findTF(self.menuUI, "rightPanelBg/arrowUp/d"), self.dayTimeFlag)
	setActive(findTF(self.menuUI, "rightPanelBg/arrowDown/n"), not self.dayTimeFlag)
	setActive(findTF(self.menuUI, "rightPanelBg/arrowDown/d"), self.dayTimeFlag)

	local var_57_0 = true

	setActive(findTF(self.countUI, "bgCount/n"), not var_57_0)
	setActive(findTF(self.countUI, "bgCount/d"), var_57_0)
	setActive(findTF(self.leaveUI, "ad/img/n"), not var_57_0)
	setActive(findTF(self.leaveUI, "ad/img/d"), var_57_0)
	setActive(findTF(self.leaveUI, "ad/btnOk/n"), not var_57_0)
	setActive(findTF(self.leaveUI, "ad/btnOk/d"), var_57_0)
	setActive(findTF(self.leaveUI, "ad/desc/n"), not var_57_0)
	setActive(findTF(self.leaveUI, "ad/desc/d"), var_57_0)
	setActive(findTF(self.pauseUI, "ad/img/n"), not var_57_0)
	setActive(findTF(self.pauseUI, "ad/img/d"), var_57_0)
	setActive(findTF(self.pauseUI, "ad/btnOk/n"), not var_57_0)
	setActive(findTF(self.pauseUI, "ad/btnOk/d"), var_57_0)
	setActive(findTF(self.pauseUI, "ad/desc/n"), not var_57_0)
	setActive(findTF(self.pauseUI, "ad/desc/d"), var_57_0)
	setActive(findTF(self.settlementUI, "ad/bg/img/n"), not var_57_0)
	setActive(findTF(self.settlementUI, "ad/bg/img/d"), var_57_0)
	setActive(findTF(self.settlementUI, "ad/bg/imgScore/n"), not var_57_0)
	setActive(findTF(self.settlementUI, "ad/bg/imgScore/d"), var_57_0)
	setActive(findTF(self.settlementUI, "ad/bg/imgHigh/n"), not var_57_0)
	setActive(findTF(self.settlementUI, "ad/bg/imgHigh/d"), var_57_0)

	local var_57_1 = var_57_0 and Color.New(1, 0.9686274509803922, 0.9215686274509803, 1) or Color.New(0.8549019607843137, 0.807843137254902, 1, 1)

	setTextColor(findTF(self.settlementUI, "ad/currentText"), var_57_1)
	setTextColor(findTF(self.settlementUI, "ad/highText"), var_57_1)
	setActive(findTF(self.gameUI, "top/powerProgress/content/bg/n"), not var_57_0)
	setActive(findTF(self.gameUI, "top/powerProgress/content/bg/d"), var_57_0)
	setActive(findTF(self.gameUI, "top/powerProgress/full/n"), not var_57_0)
	setActive(findTF(self.gameUI, "top/powerProgress/full/d"), var_57_0)
	setActive(findTF(self.gameUI, "top/split/n"), not var_57_0)
	setActive(findTF(self.gameUI, "top/split/d"), var_57_0)
	setActive(findTF(self.gameUI, "top/scoreImg/n"), not var_57_0)
	setActive(findTF(self.gameUI, "top/scoreImg/d"), var_57_0)
	setTextColor(findTF(self.gameUI, "top/score"), var_57_0 and Color.New(0.9215686274509803, 0.8745098039215686, 0.7725490196078432, 1) or Color.New(0.8, 0.7372549019607844, 0.8392156862745098, 1))
	setActive(findTF(self.gameUI, "topRight/btnStop/n"), not var_57_0)
	setActive(findTF(self.gameUI, "topRight/btnStop/d"), var_57_0)
	setActive(findTF(self.gameUI, "btnLeave/n"), not var_57_0)
	setActive(findTF(self.gameUI, "btnLeave/d"), var_57_0)

	for iter_57_0 = 1, Fushun3GameConst.heart_num do
		local var_57_2 = findTF(self.gameUI, "top/heart" .. iter_57_0 .. "")

		setActive(findTF(var_57_2, "img/n"), not var_57_0)
		setActive(findTF(var_57_2, "img/d"), var_57_0)
		setActive(findTF(var_57_2, "full/n"), not var_57_0)
		setActive(findTF(var_57_2, "full/d"), var_57_0)
	end

	return
end

function Fushun3GameView:onTimer()
	self:gameStep()

	return
end

function Fushun3GameView:gameStep()
	self.gameOverTime = self.gameOverTime + Time.deltaTime
	self.gameTime = self.gameTime - Time.deltaTime

	if self.gameTime < 0 then
		self.gameTime = 0
	end

	self.gameStepTime = self.gameStepTime + Time.deltaTime

	if self.gameLevelTime > 0 then
		self.gameLevelTime = self.gameLevelTime - Time.deltaTime

		if self.gameLevelTime <= 0 then
			self.gameLevelTime = Fushun3GameConst.level_time

			self.platformController:levelUp()
		end
	end

	self.rectCollider:step()
	self.platformController:step()
	self.sceneController:step()
	self.charController:step()
	self.itemController:step()
	self.bgController:step()
	self.monsterController:step()
	self.effectController:step()
	self:updateGameUI()

	if self.gameTime <= 0 then
		self:onGameOver()

		return
	end

	return
end

function Fushun3GameView:timerStart()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function Fushun3GameView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	return
end

function Fushun3GameView:updateGameUI()
	local var_62_0 = self.charController:getHeart()

	for iter_62_0 = 1, #self.hearts do
		if iter_62_0 <= var_62_0 then
			setActive(self.hearts[iter_62_0], true)
		else
			setActive(self.hearts[iter_62_0], false)
		end
	end

	setText(self.scoreTf, self.scoreNum)
	setText(self.gameTimeS, math.ceil(self.gameTime))

	return
end

function Fushun3GameView:addScore(arg_63_1)
	self.scoreNum = self.scoreNum + arg_63_1

	if self.scoreNum < 0 then
		self.scoreNum = 0
	end

	return
end

function Fushun3GameView:onControllerCallback(arg_64_1, arg_64_2)
	if arg_64_1 == Fushun3GameEvent.catch_item_call then
		if arg_64_2.data.type == Fushun3GameConst.item_type_score then
			self:addScore(arg_64_2.data.score)
			self.charController:addPower(arg_64_2.data.score)
		else
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_6)
			self.charController:setBuff(arg_64_2.data)
		end
	end

	return
end

function Fushun3GameView:onGameOver()
	if self.settlementFlag then
		return
	end

	self:timerStop()

	self.settlementFlag = true

	setActive(self.clickMask, true)
	LeanTween.delayedCall(go(self._tf), 1, System.Action(function()
		self.settlementFlag = false
		self.gameStartFlag = false

		setActive(self.clickMask, false)
		self:showSettlement()

		return
	end))
	pg.m02:sendNotification(GAME.MINI_GAME_TIME, {
		id = self:GetMGData().id,
		time = math.ceil(self.gameOverTime)
	})

	return
end

function Fushun3GameView:showSettlement()
	setActive(self.settlementUI, true)
	GetComponent(findTF(self.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_67_0 = self:GetMGData():GetRuntimeData("elements")
	local var_67_1 = self.scoreNum
	local var_67_2

	if var_67_0 and #var_67_0 > 0 then
		var_67_2 = var_67_0[1] or 0
	end

	setActive(findTF(self.settlementUI, "ad/new"), var_67_2 < var_67_1)

	if var_67_2 <= var_67_1 then
		var_67_2 = var_67_1

		self:StoreDataToServer({
			var_67_1
		})
	end

	setText(findTF(self.settlementUI, "ad/highText"), var_67_2)
	setText(findTF(self.settlementUI, "ad/currentText"), var_67_1)

	if self:getGameTimes() and self:getGameTimes() > 0 then
		self.sendSuccessFlag = true

		self:SendSuccess(0)
	end

	return
end

function Fushun3GameView:resumeGame()
	self.gameStop = false

	setActive(self.leaveUI, false)
	self:timerStart()

	return
end

function Fushun3GameView:stopGame()
	self.gameStop = true

	self:timerStop()

	return
end

function Fushun3GameView:onBackPressed()
	if not self.gameStartFlag then
		self:emit(Fushun3GameView.ON_BACK_PRESSED)
	else
		if self.settlementFlag then
			return
		end

		if isActive(self.pauseUI) then
			setActive(self.pauseUI, false)
		end

		self:stopGame()
		setActive(self.leaveUI, true)
	end

	return
end

function Fushun3GameView:willExit()
	if self.charController then
		self.charController:dispose()
	end

	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	if self._tf and LeanTween.isTweening(go(self._tf)) then
		LeanTween.cancel(go(self._tf))
	end

	if self.timer and self.timer.running then
		self.timer:Stop()
	end

	if self.atkDelegate then
		ClearEventTrigger(self.atkDelegate)
	end

	if self.jumpDelegate then
		ClearEventTrigger(self.jumpDelegate)
	end

	Time.timeScale = 1
	self.timer = nil

	self.rectCollider:clear()

	return
end

return Fushun3GameView
