-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AoQiAttackForceGameView.lua

module("logic.extensions.aoqiattackforce.view.AoQiAttackForceGameView", package.seeall)

local AoQiAttackForceGameView = class("AoQiAttackForceGameView", ViewComponent)
local STATE_RUNING = "STATE_RUNING"
local STATE_PAUSE = "STATE_PAUSE"
local STATE_GAME_END = "STATE_GAME_END"
local flashSpeed = 1
local minAlpha = 0.5
local maxAlpha = 1
local elapsedTime = 0
local totalFlashDuration = 2

function AoQiAttackForceGameView:ctor()
	AoQiAttackForceGameView.super.ctor(self)
end

function AoQiAttackForceGameView:unbindEvents()
	AoQiAttackForceGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSwitchRate)
end

function AoQiAttackForceGameView:bindEvents()
	AoQiAttackForceGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSwitchRate, self._onClickSwitchRate, self)
end

function AoQiAttackForceGameView:buildUI()
	AoQiAttackForceGameView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._mainPlayerLayer = self:getGo("gameCon/mainPlayer")
	self._monsterLayer = self:getGo("gameCon/monsterLayer")
	self._bulletLayer = self:getGo("gameCon/bulletLayer")
	self._btmContainer = self:getGo("btmContainer/con")
	self._goMonster = self:getGo("monsterCon")
	self._goBullet = self:getGo("bulletCon")
	self._goWeapon = self:getGo("weaponCon")

	goutil.setActive(self._goMonster, false)
	goutil.setActive(self._goBullet, false)
	goutil.setActive(self._goWeapon, false)

	self._sliderShield = self:getSlider("sliderShield")
	self._sliderHp = self:getSlider("sliderHp")
	self._txtCurHp = self:getTxt("curHp/txt")
	self._txtCurShield = self:getTxt("curShield/txt")
	self._curWave = self:getGo("curWave")
	self._txtCurWave = self:getTxt("curWave/txt")
	self._btnSwitchRate = self:getGo("btnSwitchRate")
	self._txtCurRate = self:getTxt("btnSwitchRate/txtCurRate")
	self._flyitem = self:getGo("flyitem")
	self._flyitem2 = self:getGo("flyitem2")
	self._flyitem3 = self:getGo("flyitem3")
	self._flyitem4 = self:getGo("flyitem4")
	self._flyitem5 = self:getGo("flyitem5")
	self._textCon = self:getGo("textCon")
	self._warningtips = self:getGo("warningtips")

	GameUtil.SetActive(self._warningtips, false)

	self._warningCg = self._warningtips:GetComponent("CanvasGroup")
	self._tableview = self:getGo("btmContainer/tableview")
	self._tablecell = self:getGo("btmContainer/tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:setCenterMode(true)

	self._curScore = self:getGo("curScore")

	GameUtil.SetActive(self._curScore, false)

	self._txtCurScore = self:getTxt("curScore/txt")

	self:_initFSM()
	self:_initPool()
end

function AoQiAttackForceGameView:onExit()
	AoQiAttackForceGameView.super.onExit(self)
	removetimer(self._onGameGc, self)
	self._stateMachine:stopTimer()

	for unit, con in pairs(self._curBulletConMap) do
		self:_removeUnit(unit)
	end

	for unit, con in pairs(self._curMonsterConMap) do
		self:_removeUnit(unit)
	end

	for unit, con in pairs(self._curWeaponConMap) do
		self:_removeUnit(unit)
	end

	self._bulletPool:clear()

	for k, v in pairs(self._bulletConPool) do
		v:clear()
	end

	self._monsterPool:clear()
	self._weaponPool:clear()
	self:_removeUnit(AoQiAttackForceGameController.instance:getPlayerUnit())
	self._scrollList:dispose()
	AQAFSimpleFloatTipsMgr.instance:clearAll()
	self:_stopFlashing()
end

function AoQiAttackForceGameView:onEnter()
	AoQiAttackForceGameView.super.onEnter(self)

	self._cellMap = {}

	self.addGEvent(self, GlobalNotify.AQAFGameCreateUnit, self._createUnit, self)
	self.addGEvent(self, GlobalNotify.AQAFGameRemoveUnit, self._removeUnit, self)
	self.addGEvent(self, GlobalNotify.AQAFPlayerGameInfoUpdate, self._updatePlayerInfo, self)
	self.addGEvent(self, GlobalNotify.AQAFShowAlertTxt, self._onShowAlertTips, self)
	goutil.clearChildren(self._mainPlayerLayer)
	goutil.clearChildren(self._monsterLayer)
	goutil.clearChildren(self._bulletLayer)
	self:_initGameData()
	self._stateMachine:startTimer()
	self._stateMachine:gotoState(STATE_RUNING)
	AQAFSimpleFloatTipsMgr.instance:addItemType(AQAFSimpleFloatTipsMgr.TYPE_SIMPLE, self._flyitem, AQAFFloatItem, 100)
	AQAFSimpleFloatTipsMgr.instance:addItemType(AQAFSimpleFloatTipsMgr.TYPE_TEXT, self._flyitem2, FloatWordItem, 100)
	AQAFSimpleFloatTipsMgr.instance:addItemType(AQAFSimpleFloatTipsMgr.TYPE_MAGIC_TEXT, self._flyitem3, AQAFFloatItem, 100)
	AQAFSimpleFloatTipsMgr.instance:addItemType(AQAFSimpleFloatTipsMgr.TYPE_PHYSICS_TEXT, self._flyitem4, AQAFFloatItem, 100)
	AQAFSimpleFloatTipsMgr.instance:addItemType(AQAFSimpleFloatTipsMgr.TYPE_SPLIT_TEXT, self._flyitem5, AQAFFloatTextItem, 100)
	self:_onClickSwitchRate()
	settimer(300, self._onGameGc, self, true)
end

function AoQiAttackForceGameView:_onGameGc()
	ResGcMgr.instance:gc()
end

function AoQiAttackForceGameView:_updateCell(view, cell, data, tag)
	local slider = Framework.SliderAdapter.GetFrom(cell.gameObject, "sliderBg")
	local blood = goutil.findChild(cell, "sliderBg/blood")
	local icon = goutil.findChild(cell, "icon")

	GameUtil.setUIImageSpriteIdx(blood, data.curStarLv - 1)

	local iconPath = AoQiAttackForceConfig.instance:getEquipmentInGameIconPath(data.cfg.equipmentId)

	uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, iconPath, function()
		local img = icon.gameObject:GetComponent(goutil.Type_UIImage)

		img:SetNativeSize()

		img.raycastTarget = false

		local width = GameUtil.getWidth(icon)
		local height = GameUtil.getHeight(icon)
		local scale = checknumber(84 / math.max(width, height))

		GameUtil.setLocalScale(icon, scale, scale, scale)
		GameUtil.setLocalRotation(icon, 0, 0, -30)
	end)
	slider:SetValue(data:getCDPercentage())

	self._cellMap[cell] = slider
end

function AoQiAttackForceGameView:_clearCell(cell)
	return
end

function AoQiAttackForceGameView:_startFlashing()
	elapsedTime = 0

	GameUtil.SetActive(self._warningtips, true)

	self._warningCg.alpha = minAlpha

	settimer(0, self._updateFlashing, self)
end

function AoQiAttackForceGameView:_stopFlashing()
	GameUtil.SetActive(self._warningtips, false)
	removetimer(self._updateFlashing, self)
end

function AoQiAttackForceGameView:_updateFlashing()
	self._warningCg.alpha = Mathf.PingPong(Time.time * flashSpeed, maxAlpha - minAlpha) + minAlpha
	elapsedTime = elapsedTime + Time.deltaTime

	if elapsedTime > totalFlashDuration then
		self:_stopFlashing()
	end
end

function AoQiAttackForceGameView:_onShowAlertTips(content, x, y, type)
	if type == nil then
		AQAFSimpleFloatTipsMgr.instance:flyText(AQAFSimpleFloatTipsMgr.TYPE_SIMPLE, content, self._textCon, x + math.random(-40, 40), y)
	else
		AQAFSimpleFloatTipsMgr.instance:flyText(type, content, self._textCon, x + math.random(-40, 40), y)
	end
end

function AoQiAttackForceGameView:_initFSM()
	self._stateMachine = SimpleFSM.New()

	self._stateMachine:addState(STATE_RUNING, nil, nil, GameUtil.handler(self._onRunning, self))
	self._stateMachine:addState(STATE_PAUSE, GameUtil.handler(self._onEnterPause, self), nil, nil)
	self._stateMachine:addState(STATE_GAME_END, GameUtil.handler(self._initGameEnd, self))

	local linkedList = {
		[STATE_RUNING] = {
			STATE_PAUSE,
			STATE_GAME_END
		},
		[STATE_PAUSE] = {
			STATE_RUNING,
			STATE_GAME_END
		}
	}

	self._stateMachine:addLinkByLinkedList(linkedList)
end

function AoQiAttackForceGameView:_initGameData()
	AoQiAttackForceGameController.instance:initGameData()

	if AoQiAttackForceModel.instance:getIsEndlessState() then
		goutil.setActive(self._curWave, false)
		goutil.setActive(self._curScore, true)
	else
		local curClgCfg = AoQiAttackForceModel.instance:getCurClgCfg()
		local totalWaveNum = 0

		totalWaveNum = AoQiAttackForceModel.instance:getIsHeroState() and AoQiAttackForceConfig.instance:getHeroChallengeWaveTotalNums(curClgCfg.activityId) or AoQiAttackForceConfig.instance:getChallengeWaveTotalNums(curClgCfg.activityId, curClgCfg.challengeId)

		local curWaveId = AoQiAttackForceModel.instance:getCurWaveId()

		self._txtCurWave.text = string.format("%s/%s", curWaveId, totalWaveNum)

		goutil.setActive(self._curWave, true)
		goutil.setActive(self._curScore, false)
	end

	self:_updatePlayerInfo()

	local list = AoQiAttackForceGameController.instance:getWeaponList()

	self._scrollList:reloadData(list)

	self._txtCurRate.text = string.format("X<size=26>%s</size>", AoQiAttackForceGameController.instance:getTimeScale())
end

function AoQiAttackForceGameView:_updatePlayerInfo()
	local playerUnit = AoQiAttackForceGameController.instance:getPlayerUnit()
	local curHP = playerUnit:getCurHp()
	local curShield = playerUnit:getCurShield()
	local curHpMax = playerUnit:getCurMaxHP()

	self._txtCurHp.text = math.round(curHP)
	self._txtCurShield.text = math.round(curShield)

	self._sliderShield:SetValue(curShield / curHpMax)
	self._sliderHp:SetValue(curHP / curHpMax)
end

function AoQiAttackForceGameView:_onEnterPause()
	if AoQiAttackForceModel.instance:getIsHeroState() then
		local actCfg = AoQiAttackForceModel.instance:getCurActCfg()
		local matType, matId, _ = MaterialMgr.getMatParams(actCfg.heroPrizeKey)
		local matName = MaterialMgr.getMaterialsName(matType, matId)
		local curWave = AoQiAttackForceModel.instance:getCurWaveId() - 1
		local waveCfg = AoQiAttackForceConfig.instance:getHeroChallengeWaveClg(actCfg.activityId, curWave)
		local content = langPara("是否返回主界面？该操作将立即结算当前奖励,当前可领取%s波次奖励，获得【%s】×%s", curWave, matName, (waveCfg or nil) and waveCfg.prize)

		TipsFacade.instance:openPopupWindow("提示", content, function()
			AoQiAttackForceController.instance:endHeroClg(false)
		end, function()
			self._stateMachine:gotoState(STATE_RUNING)
		end)
	else
		TipsFacade.instance:openPopupWindow("提示", "是否返回主界面？该操作将立即结算当前奖励，无法返还体力！", function()
			if AoQiAttackForceModel.instance:getIsEndlessState() then
				AoQiAttackForceController.instance:endFinalClg()
			else
				AoQiAttackForceController.instance:endClg(false)
			end
		end, function()
			self._stateMachine:gotoState(STATE_RUNING)
		end)
	end
end

function AoQiAttackForceGameView:_onRunning()
	local isFinish, isWin = AoQiAttackForceGameController.instance:getGameResult()

	if isFinish then
		self._stateMachine:gotoState(STATE_GAME_END)

		return
	end

	AoQiAttackForceGameController.instance:onUpdate()

	if self._mainPlayerCon then
		self._mainPlayerCon:lateUpdate()
	end

	for _, con in pairs(self._curBulletConMap) do
		con:lateUpdate()
	end

	for _, con in pairs(self._curMonsterConMap) do
		con:lateUpdate()
	end

	for _, con in pairs(self._curWeaponConMap) do
		con:lateUpdate()
	end

	AoQiAttackForceGameController.instance:onLateUpdate()
	self:_refreshAllCell()

	self._txtCurScore.text = AoQiAttackForceModel.instance:getCurKillScore()
end

function AoQiAttackForceGameView:_refreshAllCell()
	local list = self._scrollList:getData()

	for cell, slider in pairs(self._cellMap) do
		local idx = cell.data

		if list then
			local data = list[idx]

			if data then
				slider:SetValue(data:getCDPercentage())
			end
		end
	end
end

function AoQiAttackForceGameView:_initGameEnd()
	local playerUnit = AoQiAttackForceGameController.instance:getPlayerUnit()

	AoQiAttackForceModel.instance:calculateAndSaveMaxHP(playerUnit:getCurHp(), playerUnit:getCurMaxHP())

	local isFinish, isWin = AoQiAttackForceGameController.instance:getGameResult()

	AoQiAttackForceController.instance:onEndFight(isWin)
end

function AoQiAttackForceGameView:_initPool()
	local function createFuncA()
		local go = goutil.cloneAndSetParent(self._goMonster, self._monsterLayer.transform)

		return (AQAFMonsterCon.New(go, self))
	end

	local function disposeFuncA(obj)
		obj:destroy()
	end

	local function resetFuncA(obj)
		obj:die()
	end

	self._monsterPool = ObjectPool.New(15, createFuncA, disposeFuncA, resetFuncA)

	local function createFuncB()
		local go = goutil.cloneAndSetParent(self._goBullet, self._bulletLayer.transform)

		return (AQAFBulletCon.New(go, self))
	end

	local function disposeFuncB(obj)
		obj:destroy()
	end

	local function resetFuncB(obj)
		obj:die()
	end

	self._bulletPool = ObjectPool.New(115, createFuncB, disposeFuncB, resetFuncB)

	local function createFuncC()
		local go = goutil.cloneAndSetParent(self._goBullet, self._bulletLayer.transform)

		return (AQAFWeaponCon.New(go, self))
	end

	local function disposeFuncC(obj)
		obj:destroy()
	end

	local function resetFuncC(obj)
		obj:die()
	end

	self._weaponPool = ObjectPool.New(15, createFuncC, disposeFuncC, resetFuncC)
	self._curMonsterConMap = {}
	self._curBulletConMap = {}
	self._curWeaponConMap = {}
	self._bulletConPool = {}
end

function AoQiAttackForceGameView:_createUnit(unit)
	local tag = unit:getTag()

	if tag == AQAFGameEnum.UnitTag.MainPlayer then
		self:_createMainPlayer(unit)
	elseif tag == AQAFGameEnum.UnitTag.Monster then
		self:_createMonster(unit)
	elseif tag == AQAFGameEnum.UnitTag.Bullet then
		self:_createBullet(unit)
	elseif tag == AQAFGameEnum.UnitTag.Weapon then
		-- block empty
	end
end

function AoQiAttackForceGameView:_removeUnit(unit)
	local tag = unit:getTag()

	if tag == AQAFGameEnum.UnitTag.MainPlayer then
		self:_removeMainPlayer(unit)
	elseif tag == AQAFGameEnum.UnitTag.Monster then
		self:_removeMonster(unit)
	elseif tag == AQAFGameEnum.UnitTag.Bullet then
		self:_removeBullet(unit)
	elseif tag == AQAFGameEnum.UnitTag.Weapon then
		-- block empty
	end
end

function AoQiAttackForceGameView:_createMainPlayer(unit)
	local go = goutil.cloneAndSetParent(self._goMonster, self._mainPlayerLayer.transform)

	self._mainPlayerCon = AQAFPlayerCon.New(go, self)

	unit:updatePosition(-530, 0)
	self._mainPlayerCon:setUnit(unit)
end

function AoQiAttackForceGameView:_removeMainPlayer(unit)
	self._mainPlayerCon:destroy()

	self._mainPlayerCon = nil
end

function AoQiAttackForceGameView:_createMonster(unit)
	self._curMonsterConMap = self._curMonsterConMap or {}

	local con = self._monsterPool:fetchObject()

	con:setUnit(unit)

	self._curMonsterConMap[unit] = con

	if unit:isBoss() then
		self:_startFlashing()
	end
end

function AoQiAttackForceGameView:_removeMonster(unit)
	self._curMonsterConMap = self._curMonsterConMap or {}

	local con = self._curMonsterConMap[unit]

	if con then
		con:die(function()
			self._monsterPool:returnObject(con)
		end, self)
	end

	self._curMonsterConMap[unit] = nil
end

function AoQiAttackForceGameView:_getBulletPool(unit)
	local cfg = unit._bulletCfg

	if self._bulletConPool[cfg.resPath] == nil then
		local function createFuncB()
			local go = goutil.cloneAndSetParent(self._goBullet, self._bulletLayer.transform)

			return (AQAFBulletCon.New(go, self))
		end

		local function disposeFuncB(obj)
			obj:destroy()
		end

		local function resetFuncB(obj)
			obj:die()
		end

		self._bulletConPool[cfg.resPath] = ObjectPool.New(30, createFuncB, disposeFuncB, resetFuncB)
	end

	return self._bulletConPool[cfg.resPath]
end

function AoQiAttackForceGameView:_createBullet(unit)
	self._curBulletConMap = self._curBulletConMap or {}

	local con = self:_getBulletPool(unit):fetchObject()

	con:setUnit(unit)

	self._curBulletConMap[unit] = con
end

function AoQiAttackForceGameView:_removeBullet(unit)
	self._curBulletConMap = self._curBulletConMap or {}

	local con = self._curBulletConMap[unit]

	if con then
		self:_getBulletPool(unit):returnObject(con)
	end

	self._curBulletConMap[unit] = nil
end

function AoQiAttackForceGameView:_createWeapon(unit)
	self._curWeaponConMap = self._curWeaponConMap or {}

	local con = self._weaponPool:fetchObject()

	con:setUnit(unit)

	self._curWeaponConMap[unit] = con
end

function AoQiAttackForceGameView:_removeWeapon(unit)
	self._curWeaponConMap = self._curWeaponConMap or {}

	local con = self._curWeaponConMap[unit]

	if con then
		self._weaponPool:returnObject(con)
	end

	self._curWeaponConMap[unit] = nil
end

function AoQiAttackForceGameView:_onClickClose()
	self._stateMachine:gotoState(STATE_PAUSE)
end

function AoQiAttackForceGameView:_onClickSwitchRate()
	local curRate = AoQiAttackForceGameController.instance:getTimeScale()
	local showRate = curRate

	if curRate == 1 then
		curRate = 3
		showRate = 4
	else
		curRate = 1
		showRate = 1
	end

	AoQiAttackForceGameController.instance:setTimeScale(curRate)

	self._txtCurRate.text = string.format("X<size=26>%s</size>", showRate)
end

return AoQiAttackForceGameView
