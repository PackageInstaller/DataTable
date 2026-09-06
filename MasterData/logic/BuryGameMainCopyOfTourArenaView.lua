-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/copy/bury/BuryGameMainCopyOfTourArenaView.lua

module("logic.extensions.tourarena.view.copy.bury.BuryGameMainCopyOfTourArenaView", package.seeall)

local BuryGameMainCopyOfTourArenaView = class("BuryGameMainCopyOfTourArenaView", ViewComponent)
local rightScorePer, wrongScorePer

function BuryGameMainCopyOfTourArenaView:unbindEvents()
	BuryGameMainCopyOfTourArenaView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function BuryGameMainCopyOfTourArenaView:bindEvents()
	BuryGameMainCopyOfTourArenaView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function BuryGameMainCopyOfTourArenaView:onExit()
	BuryGameMainCopyOfTourArenaView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.BuryPitSuccess, self._onBuryPitSuccess, self)
	GlobalDispatcher:removeListener(GlobalNotify.BuryResumeGame, self._onEggFinish, self)
	removetimer(self._onTicking, self)

	for _, v in pairs(self._buryPits) do
		v:onDestroy()
	end

	for _, v in ipairs(self._freePits) do
		v:onDestroy()
	end

	if self._buryBao then
		self._buryBao:onDestroy()
	end

	self._buryPits = nil
	self._freePits = nil
	self._buryBao = nil
end

function BuryGameMainCopyOfTourArenaView:buildUI()
	BuryGameMainCopyOfTourArenaView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtCountDown = self:getTxt("countdown/txtTime")
	self._txtCombo = self:getGo("combo/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self._txtScore = self:getTxt("score/txtIntegral")
	self._pitGo = self:getGo("pit")

	self._pitGo:SetActive(false)

	self._holes = {}

	for i = 1, 9 do
		table.insert(self._holes, self:getGo("holes/hole_" .. i))
	end

	self._txtRule = self:getTxt("rule/txtRule")

	UIEffectManager.instance:stopEffect(self._hitEffect)

	self._closebg = self:getGo("closebg")
	self._txtTitleGo = self:getGo("txtTitle")

	GameUtil.SetActive(self._closeButton.gameObject, false)
	GameUtil.SetActive(self._closebg, false)
	GameUtil.SetActive(self._txtTitleGo, false)
end

function BuryGameMainCopyOfTourArenaView:onEnter()
	BuryGameMainCopyOfTourArenaView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._finishCallBack = params[2]

	GlobalDispatcher:addListener(GlobalNotify.BuryPitSuccess, self._onBuryPitSuccess, self)
	GlobalDispatcher:addListener(GlobalNotify.BuryResumeGame, self._onEggFinish, self)

	self._dataReady = false
	self._countDownReady = false

	self:_initGame()
end

function BuryGameMainCopyOfTourArenaView:_onEggFinish(prizeNum)
	self._gainedPrizeNum = prizeNum

	local addScore = prizeNum * self._eggScoreK
	local color = "20b376"
	local maxScore = checknumber(BuryGameConfig.instance:getConstantValue("MAX_SCORE"))

	self._curScore = Mathf.Clamp(self._curScore + addScore, 0, maxScore)

	local tips = string.format("获得彩蛋积分<color=#%s>%+d</color>！", color, addScore)

	FloatWordMgr.instance:show(tips)
	self:_updateUI()
	UIStateManager.instance:open(ViewName.BuryCountDownView, "游戏即将开始", 3, self._resumeGame, self)
end

function BuryGameMainCopyOfTourArenaView:onEnterFinished()
	BuryGameMainCopyOfTourArenaView.super.onEnterFinished(self)

	local key = self._viewPresentor.viewName .. "firstRule" .. self._activityId
	local isFirst = GameUtil.getUserData(key)

	if not isFirst then
		UIStateManager.instance:push(ViewName.BuryGameRuleView, function()
			self:_openStartMask()
		end)
		GameUtil.saveUserData(key, true)
	else
		self:_openStartMask()
	end
end

function BuryGameMainCopyOfTourArenaView:_openStartMask()
	UIStateManager.instance:open(ViewName.SuppressGameStartMask, self._startCountDown, self)
end

function BuryGameMainCopyOfTourArenaView:_onTicking()
	if self._isPausing or not self._isInGame then
		return
	end

	local deltaTime = UnityEngine.Time.deltaTime

	self._tickedTime = self._tickedTime + deltaTime

	local remainingTime = math.max(0, self._duration - self._tickedTime)

	self._txtCountDown.text = math.ceil(remainingTime)

	if remainingTime <= 0 then
		self._isInGame = false

		removetimer(self._onTicking, self)
		self:_endGame()

		return
	end

	local newCfg = BuryGameConfig.instance:getGamePlanCfg(self._gamePlanId, self._tickedTime)

	if newCfg ~= self._gamePlanCfg then
		self._lastTime = not self._gamePlanCfg and newCfg.time or newCfg.time - self._gamePlanCfg.time
		self._gamePlanCfg = newCfg

		self:_insertPitsToQueue()
	end

	local data = self._queue[1]

	if data and self._tickedTime >= data.bornTime then
		table.remove(self._queue, 1)
		self:_createPit(data)
	end

	for k, v in pairs(self._buryPits) do
		v:onTicking(deltaTime)

		if v:isDead() then
			self:_removePit(k)
		end
	end

	if self._buryBao and not self._buryBao:isDead() then
		self._buryBao:onTicking(deltaTime)
	end
end

function BuryGameMainCopyOfTourArenaView:_removePit(posId)
	local pit = self._buryPits[posId]

	self._buryPits[posId] = nil

	table.insert(self._freePits, pit)
end

function BuryGameMainCopyOfTourArenaView:_onBuryPitSuccess(pitType, x, y, z, x1, y1, z1)
	print("_onBuryPitSuccess")

	self._buryedDict[pitType] = checknumber(self._buryedDict[pitType]) + 1

	local color, addScore

	if pitType == 1 then
		addScore = rightScorePer
		self._comboNum = self._comboNum + 1
		color = "20b376"
	else
		addScore = -wrongScorePer
		self._comboNum = 0
		color = "eb4642"
	end

	local maxScore = checknumber(BuryGameConfig.instance:getConstantValue("MAX_SCORE"))

	self._curScore = Mathf.Clamp(self._curScore + addScore, 0, maxScore)

	self:_checkEgg()

	local tips = string.format("积分<color=#%s>%+d</color>", color, addScore)

	FloatWordMgr.instance:show(tips)
	self:_updateUI()

	if self._buryBao and not self._buryBao:isDead() then
		-- block empty
	else
		self._buryBao = self._buryBao or ItemBuryBao.New(self:getGo("burybao"), self)

		self._buryBao:startBury(x, y, z)
	end

	local url = "fx_ui_yirenzhixia/mairenxiaoyouxi/fx_mairen_hit.prefab"

	self._hitEffect = UIEffectManager.instance:playEffect(self, url, self.mainGO, 0, 0, false, nil, nil, function(o, eff)
		eff:setParent(self.mainGO.transform)
		eff:setScale(90)
		eff:setPos(x1, y1, z1)
	end)
end

function BuryGameMainCopyOfTourArenaView:_updateUI()
	self._txtCombo:SetText(self._comboNum)

	self._txtScore.text = self._curScore
end

function BuryGameMainCopyOfTourArenaView:_createPit(data)
	local posId = self:_findFreePosId()

	if posId then
		local hole = self._holes[posId]
		local pit = self:_findFreePit()

		if not pit then
			local go = goutil.clone(self._pitGo)

			pit = ItemBuryPit.New(go, self)
		end

		local pitGo = pit:getMainGo()

		goutil.addChildToParent(pitGo, hole.transform)
		Framework.TransformUtil.SetLocalPos(pitGo.transform, 0, 0, 0)
		Framework.TransformUtil.SetLocalScale(pitGo.transform, 1, 1, 1)

		self._buryPits[posId] = pit

		pitGo:SetActive(true)
		pit:init(posId, data)
	end
end

function BuryGameMainCopyOfTourArenaView:_findFreePit()
	local pit = self._freePits[1]

	if pit then
		table.remove(self._freePits, 1)

		return pit
	end
end

function BuryGameMainCopyOfTourArenaView:_findFreePosId()
	local t = {}

	for k, v in pairs(self._buryPits) do
		local posId = checknumber(k)

		t[posId] = true
	end

	local list = {}

	for i = 1, 9 do
		if not t[i] then
			table.insert(list, i)
		end
	end

	GameUtil.permuteArray(list)

	return list[2]
end

function BuryGameMainCopyOfTourArenaView:_insertPitsToQueue()
	self._queue = {}

	local gamePlanCfg = self._gamePlanCfg
	local startTime = gamePlanCfg.time - self._lastTime
	local num = self:_randomGetNum(gamePlanCfg.numberWeights)

	for i = 1, num do
		local data = {
			bornTime = (i + math.random() - 1) / num * self._lastTime + startTime,
			pitType = self:_randomGetNum(gamePlanCfg.directionWeights),
			duration = gamePlanCfg.velocityRatio
		}

		print("bornTime = " .. data.bornTime .. " i = " .. i .. "num = " .. num .. "self._lastTime = " .. self._lastTime)
		table.insert(self._queue, 1 + #self._queue, data)
	end
end

function BuryGameMainCopyOfTourArenaView:_randomGetNum(weights)
	local array = string.split(weights, "#")
	local maxWeight = 0

	for _, v in ipairs(array) do
		local num, weight = unpack(string.splitToNumber(v, ":"))

		maxWeight = maxWeight + weight
	end

	local random = math.random(1, maxWeight)
	local totalWeight = 0

	for _, v in ipairs(array) do
		local num, weight = unpack(string.splitToNumber(v, ":"))

		totalWeight = totalWeight + weight

		if random <= totalWeight then
			return num
		end
	end
end

function BuryGameMainCopyOfTourArenaView:_startCountDown()
	self._dataReady = true
	self._countDownReady = true

	self:_realStartGame()
end

function BuryGameMainCopyOfTourArenaView:_initGame()
	self._duration = checknumber(BuryGameConfig.instance:getConstantValue("t4"))
	self._tickedTime = 0
	self._comboNum = 0
	self._curScore = 0
	self._gainedPrizeNum = 0
	self._eggScoreK = 5
	self._buryedDict = {}
	self._txtCountDown.text = self._duration

	self:_updateUI()

	local cfg = BuryGameConfig.instance:getCfgById(self._activityId)

	self._gamePlanId = cfg.gamePlanId
	self._eggPlanId = cfg.eggPlanId
	self._buryPits = {}
	self._queue = {}
	self._freePits = {}
	rightScorePer = checknumber(BuryGameConfig.instance:getConstantValue("t2"))
	wrongScorePer = checknumber(BuryGameConfig.instance:getConstantValue("t3"))
	self._checkedId = 0
	self._egged = false
	self._isPausing = false

	local ruleCfg = RulesConfig.instance:getRuleCo("burygamegate2")

	self._txtRule.text = string.format(ruleCfg.rules, rightScorePer, wrongScorePer)
	self._isInGame = true
end

function BuryGameMainCopyOfTourArenaView:_startGameRes()
	self._dataReady = true

	if self._countDownReady then
		self:_realStartGame()
	end
end

function BuryGameMainCopyOfTourArenaView:_startGame()
	self._countDownReady = true

	if self._dataReady then
		self:_realStartGame()
	end
end

function BuryGameMainCopyOfTourArenaView:_realStartGame()
	settimer(0, self._onTicking, self)
	self:_onTicking()
end

function BuryGameMainCopyOfTourArenaView:_endGame()
	self._isInGame = false

	removetimer(self._onTicking, self)

	local isPass = true

	self:_doFinfishCallBack(isPass, self._curScore)
	self:_onEndGameRes()
end

function BuryGameMainCopyOfTourArenaView:_doFinfishCallBack(isPass, score)
	local info = {}

	info.isPass = isPass
	info.gameScore = score

	GameUtil.callBack(self._finishCallBack, info)
end

function BuryGameMainCopyOfTourArenaView:_onClickClose()
	if not self._dataReady or not self._countDownReady then
		return
	end

	self:_pauseGame()

	local rightNum, wrongNum = self:_calcuRightNum()
	local dict = {
		contentFmt = "获得<color=#eb4642>%d</color>积分！",
		tip = "你确定要退出游戏吗？",
		title = "提示",
		rightNum = rightNum,
		wrongNum = wrongNum,
		score = self._curScore,
		sureHandler = self._endGame,
		handlerObj = self,
		cancelHandler = self._resumeGame
	}

	UIStateManager.instance:push(ViewName.BuryGamePopView, dict)
end

function BuryGameMainCopyOfTourArenaView:_calcuRightNum()
	local rightNum = 0
	local wrongNum = 0

	for k, v in pairs(self._buryedDict) do
		if k == GameEnum.BuryPitEnum.DEAD then
			rightNum = rightNum + v
		elseif k == GameEnum.BuryPitEnum.DUCK or k == GameEnum.BuryPitEnum.CHICK then
			wrongNum = wrongNum + v
		end
	end

	return rightNum, wrongNum
end

function BuryGameMainCopyOfTourArenaView:_pauseGame()
	FloatWordMgr.instance:show("游戏暂停")

	self._isPausing = true

	for _, v in pairs(self._buryPits) do
		v:onPause()
	end

	if self._buryBao then
		self._buryBao:onPause()
	end
end

function BuryGameMainCopyOfTourArenaView:_resumeGame()
	FloatWordMgr.instance:show("游戏恢复~")

	self._isPausing = false

	for _, v in pairs(self._buryPits) do
		v:onResume()
	end

	if self._buryBao then
		self._buryBao:onResume()
	end
end

function BuryGameMainCopyOfTourArenaView:_checkEgg()
	if self._egged then
		return
	end

	local cfgs = BuryGameConfig.instance:getEggPlanCfgs(self._eggPlanId)
	local idx = self._checkedId + 1
	local cfg = cfgs[idx]

	if cfg.score <= self._curScore then
		self._checkedId = self._checkedId + 1

		print("check egg id = " .. self._checkedId)

		if math.random() <= cfg.weight / 100 then
			self._egged = true

			self:_openEggView()
		end
	end
end

function BuryGameMainCopyOfTourArenaView:_openEggView()
	self:_pauseGame()
	UIStateManager.instance:push(ViewName.CopyBuryGameEggView)

	self._tickEggCount = 0
end

function BuryGameMainCopyOfTourArenaView:_onEndGameRes(status)
	self:close()
end

return BuryGameMainCopyOfTourArenaView
