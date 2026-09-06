-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoQiHeroBattleView.lua

module("logic.extensions.aoqihero.view.AoQiHeroBattleView", package.seeall)

local AoQiHeroBattleView = class("AoQiHeroBattleView", ViewComponent)
local STATE_GAME_RUNING = 1
local STATE_BIG_ROUND_START = 2
local STATE_MY_TEAM_START = 4
local STATE_CAN_OPERATE = 5
local STATE_OPERATING = 6
local STATE_MY_TEAM_ROUND = 7
local STATE_ENEMY_TEAM_START = 9
local STATE_ENEMY_READY = 10
local STATE_ENEMY_ROUND = 11
local STATE_BIG_ROUND_END = 13
local STATE_BLOCK = 14
local STATE_GAME_END = 15
local ROUND_TIPS_SHOW_TIME = 1
local FLY_EFFECT_SHOW_TIME = 85
local MOVE_TIME = 0.35
local superActiveEffName = "20250403/aqyst/fx_aqyst_chaoshaanniu.prefab"
local GAME_SPEED_NORMAL = 1
local GAME_SPEED_ADD = 2

function AoQiHeroBattleView:ctor()
	AoQiHeroBattleView.super.ctor(self)

	self._updateHuds = {}
	self._demageTextPools = {}
end

function AoQiHeroBattleView:unbindEvents()
	AoQiHeroBattleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSuper)
	GameUtil.rmClickHandler(self._btnEndRound)
	GameUtil.rmClickHandler(self._btnSpeedUp)
end

function AoQiHeroBattleView:bindEvents()
	AoQiHeroBattleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
	GameUtil.addClickHandler(self._btnSuper, self._onClickSuper, self)
	GameUtil.addClickHandler(self._btnEndRound, self._onClickEndRound, self)
	GameUtil.addClickHandler(self._btnSpeedUp, self._onClickSpeedUp, self)
end

function AoQiHeroBattleView:buildUI()
	AoQiHeroBattleView.super.buildUI(self)
	self:initFSM()

	self._freeContainer = self:getGo("freeContainer")
	self._cellContain = self:getGo("cellContain")
	self._gridCell = self:getGo("cell")
	self._enemyContain = self:getGo("enemyContain")
	self._enemyCell = self:getGo("enemyCell")
	self._petContain = self:getGo("petContain")
	self._petCell = self:getGo("petContain/petCell")
	self._myHpGo = self:getGo("myHp")
	self._txtHp = self:getTxt("myHp/txt")
	self._sliderHp = Framework.SliderAdapter.GetFrom(self._myHpGo, "slider")
	self._petTableView = self:getGo("petTableview")
	self._petTableList = ScrollerList.create(self._petTableView, self._petCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._startRoundTips = self:getGo("startRoundTips")
	self._imgRound = self:getGo("startRoundTips/imgRound")
	self._imgChangeStartRountTips = self._imgRound:GetComponent(ComponentType.UIImageSpriteChange)
	self._txtRoundTips = self:getTxt("startRoundTips/txt")
	self._btnClose = self:getGo("btnClose")
	self._damagesText = self:getGo("damagesText")
	self._damageContain = self:getGo("damageContain")
	self._damageTextCell = self:getGo("damageTextCell")
	self._tower = self:getGo("tower")
	self._btnSuper = self:getGo("btnSuper")
	self._myEnergyGo = self:getGo("myEngry")
	self._txtEnergy = self:getTxt("myEngry/txt")
	self._sliderEnergy = Framework.SliderAdapter.GetFrom(self._myEnergyGo, "slider")
	self._btnEndRound = self:getGo("btnEndRound")
	self._txtRound = self:getTxt("roundInfo/bigRound/txtRound")
	self._txtMinRound = self:getTxt("roundInfo/minRound/txtMinRound")
	self._txtTime = self:getTxt("roundInfo/timeInfo/txtTime")
	self._timeInfo = self:getGo("roundInfo/timeInfo")
	self._txtStageName = self:getTxt("stageInfo/txtStageName")
	self._closeSuper = self:getGo("btnSuper/closeSuper")
	self._txtSuper = self:getTxt("btnSuper/txtSuper")
	self._effectSuperBtnGo = self:getGo("btnSuper/effectSuperBtn")
	self._skillPetCell = self:getGo("petContain/skillPetCell")
	self._skillPetCellCon = self:getGo("petContain/skillPetCell/select/petCon")
	self._skillEnemyCell = self:getGo("petContain/skillEnemyCell")
	self._skillEnemyCellCon = self:getGo("petContain/skillEnemyCell/petInfo/petCon")
	self._skillEnemyCellInfo = self:getGo("petContain/skillEnemyCell/petInfo")
	self._petEffectGo = self:getGo("petContain/skillEnemyCell/petEffectGo")
	self._flyEffectCell = self:getGo("flyEffectCell")
	self._effectContain = self:getGo("effectContain")
	self._superMaskGo = self:getGo("petContain/superMask")
	self._timeOutEffectCon = self:getGo("timeOutEffectCon")
	self._towerBuffTableView = self:getGo("towerBuffTableView")
	self._buffTableCell = self:getGo("buffTableCell")
	self._towerBuffTableList = ScrollerList.create(self._towerBuffTableView, self._buffTableCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._btnTip = self:getGo("btnTip")
	self._btnSpeedUp = self:getGo("btnSpeedUp")
	self._imgSpeedBg = self:getGo("btnSpeedUp/imgBg")
	self._speedChange = self._imgSpeedBg:GetComponent(ComponentType.UIImageSpriteChange)
end

function AoQiHeroBattleView:destroyUI()
	AoQiHeroBattleView.super.destroyUI(self)
	self:_disposeMap()
end

function AoQiHeroBattleView:onExit()
	AoQiHeroBattleView.super.onExit(self)
	self._stateMachine:stopTimer()
	removetimer(self._updateHud, self)

	for i, v in ipairs(self._updateHuds) do
		goutil.destroy(i)
	end

	self._updateHuds = {}

	if self._effectSuperBtn then
		UIEffectManager.instance:stopEffect(self._effectSuperBtn)

		self._effectSuperBtn = nil
	end

	self:_clearMap()

	for i, v in ipairs(self._demageTextPools) do
		v:clear()
	end

	for i, v in ipairs(self._petEffect) do
		UIEffectManager.instance:stopEffect(v)
	end

	table.clear(self._petEffect)

	self._showPetGo = nil

	MaterialMgr.resetAll(self._skillPetCellCon)
	MaterialMgr.resetAll(self._skillEnemyCellCon)

	for i, v in pairs(self._petBuffTableDir) do
		v:dispose()
	end

	if self._speedBtnTween then
		UnityTweens.TweenRotate.StopTween(self._imgSpeedBg)
		GameUtil.setLocalRotation(self._imgSpeedBg, 0, 0, 0)

		self._speedBtnTween = nil
	end

	self._petBuffTableDir = nil
end

function AoQiHeroBattleView:onEnter()
	AoQiHeroBattleView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AoQiHeroBattleStartRes, self._PM_AoQiHeroBattleStartRes, self)
	self.addGEvent(self, GlobalNotify.PM_AoQiHeroSyncBattleRes, self._PM_AoQiHeroSyncBattleRes, self)
	self._stateMachine:startTimer()

	local param = self:getOpenParam()

	self._activityId = param[1]
	self._stageId = param[2]

	local stageCfg = AoQiHeroConfig.instance:getNormalStageCfg(self._activityId, self._stageId)

	self._creepsMasterId = stageCfg.creepsMasterId
	self._petEffect = {}
	self._petBuffTableDir = {}

	self._stateMachine:gotoState(STATE_GAME_RUNING)
	GameUtil.SetActive(self._gridCell, false)
	GameUtil.SetActive(self._enemyCell, false)
	GameUtil.SetActive(self._damagesText, false)
	GameUtil.SetActive(self._damageTextCell, false)
end

function AoQiHeroBattleView:initMgr()
	AoQiHeroBuffMgr.instance:initData(self._activityId)
	AoQiHeroBattleModel.instance:initMapData(self._activityId, self._creepsMasterId)
	AoQiHeroEntityMgr.instance:initData(self._activityId, self._creepsMasterId)
	AoQiHeroRoundMgr.instance:initData(self._activityId)
	AoQiHeroSkillMgr.instance:initData(self._activityId)
	AoQiHeroBattleModel.instance:initMapSet()

	local teamCfg = AoQiHeroConfig.instance:getTeamCfg(self._activityId, self._creepsMasterId)

	self._roundTime = teamCfg.roundTime
	self._maxRoundLimit = teamCfg.roundLimit
end

function AoQiHeroBattleView:initFSM()
	self._stateMachine = SimpleFSM.New()

	self._stateMachine:addState(STATE_GAME_RUNING, GameUtil.handler(self._initGameRuning, self))
	self._stateMachine:addState(STATE_BIG_ROUND_START, GameUtil.handler(self._initBigRoundStart, self), GameUtil.handler(self._exitBigRoundStart, self), GameUtil.handler(self._updateBigRoundStartShow, self))
	self._stateMachine:addState(STATE_MY_TEAM_START, GameUtil.handler(self._initMyTeamStart, self))
	self._stateMachine:addState(STATE_CAN_OPERATE, GameUtil.handler(self._initCanOpreate, self), GameUtil.handler(self._exitCanOpreate, self), GameUtil.handler(self._updateCanOpreate, self))
	self._stateMachine:addState(STATE_OPERATING, GameUtil.handler(self._initOpreating, self), GameUtil.handler(self._exitOpreating, self), GameUtil.handler(self._updateOpreating, self))
	self._stateMachine:addState(STATE_MY_TEAM_ROUND, GameUtil.handler(self._initMyTeamRound, self), GameUtil.handler(self._exitMyTeamRound, self), GameUtil.handler(self._updateMyTeamRound, self))
	self._stateMachine:addState(STATE_ENEMY_TEAM_START, GameUtil.handler(self._initEnemyTeamStart, self))
	self._stateMachine:addState(STATE_ENEMY_READY, GameUtil.handler(self._initEnemyReady, self))
	self._stateMachine:addState(STATE_ENEMY_ROUND, GameUtil.handler(self._initEnemyRound, self), GameUtil.handler(self._exitEnemyRound, self), GameUtil.handler(self._updateEnemyTeamRound, self))
	self._stateMachine:addState(STATE_BIG_ROUND_END, GameUtil.handler(self._initBigRoundEnd, self), GameUtil.handler(self._exitBigRoundEnd, self), GameUtil.handler(self._updateBigRoundEndShow, self))
	self._stateMachine:addState(STATE_BLOCK, GameUtil.handler(self._initBlock, self))
	self._stateMachine:addState(STATE_GAME_END, GameUtil.handler(self._initGameEnd, self))

	local linkedList = {
		[STATE_GAME_RUNING] = {
			STATE_BIG_ROUND_START
		},
		[STATE_BIG_ROUND_START] = {
			STATE_MY_TEAM_START,
			STATE_BLOCK
		},
		[STATE_MY_TEAM_START] = {
			STATE_CAN_OPERATE
		},
		[STATE_CAN_OPERATE] = {
			STATE_OPERATING,
			STATE_MY_TEAM_ROUND,
			STATE_BLOCK,
			STATE_ENEMY_TEAM_START
		},
		[STATE_OPERATING] = {
			STATE_CAN_OPERATE,
			STATE_MY_TEAM_ROUND
		},
		[STATE_MY_TEAM_ROUND] = {
			STATE_BLOCK,
			STATE_CAN_OPERATE,
			STATE_ENEMY_TEAM_START
		},
		[STATE_ENEMY_TEAM_START] = {
			STATE_ENEMY_READY
		},
		[STATE_ENEMY_READY] = {
			STATE_ENEMY_ROUND
		},
		[STATE_ENEMY_ROUND] = {
			STATE_ENEMY_READY,
			STATE_BLOCK,
			STATE_BIG_ROUND_END
		},
		[STATE_BIG_ROUND_END] = {
			STATE_BLOCK
		},
		[STATE_BLOCK] = {
			STATE_BIG_ROUND_START,
			STATE_GAME_END
		},
		[STATE_GAME_END] = {
			STATE_GAME_RUNING
		}
	}

	self._stateMachine:addLinkByLinkedList(linkedList)
end

function AoQiHeroBattleView:_initGameRuning()
	self:initMgr()
	self:initView()

	self._winner = nil
	self._isMidLeave = nil

	AoQiHeroController.instance:sendPM_AoQiHeroBattleStartReq()
end

function AoQiHeroBattleView:initView()
	self._cellSizeHalf = {
		x = 47.5,
		y = 47.5
	}
	self._isUseSuper = false

	for i, v in ipairs(self._petEffect) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._imgChangeStartRountTips:SetState(1)
	table.clear(self._petEffect)
	GameUtil.SetActive(self._skillEnemyCell, false)
	GameUtil.SetActive(self._skillPetCell, false)
	GameUtil.SetActive(self._superMaskGo, false)
	self:_setMapData()
	self:_genarateMap()
	self:_genarateEntity()
	self:_updateTowerInfo()
	self:_updatePetInfo()
	removetimer(self._updateHud, self)
	settimer(0.02, self._updateHud, self, true)

	if self._txtStageName then
		local teamCfg = AoQiHeroConfig.instance:getTeamCfg(self._activityId, self._creepsMasterId)

		self._txtStageName.text = teamCfg.name
	end

	self._gameSpeed = GAME_SPEED_ADD
	self._txtRoundTips.text = ""
	self._txtTime.text = ""
	self._txtMinRound.text = lang("我的回合")

	GameUtil.SetActive(self._txtMinRound, true)
	GameUtil.SetActive(self._timeInfo, false)

	local timeOutEffect = "fx_ui_zhanqianzhunbei/fx_ui_zhanqianzhunbei_shanshuo.prefab"

	self:playViewEffect(timeOutEffect, self._timeOutEffectCon, nil, true)
	GameUtil.SetActive(self._timeOutEffectCon, false)
	GameUtil.setLocalRotation(self._imgSpeedBg, 0, 0, 0)
end

function AoQiHeroBattleView:_setMapData()
	local mapSize = AoQiHeroBattleModel.instance:getMapSize()

	self._mapRow = mapSize.x
	self._mapCol = mapSize.y

	local gridIndex = 1

	self._mapData = {}

	for i = 1, self._mapRow do
		self._mapData[i] = {}

		for j = 1, self._mapCol do
			self._mapData[i][j] = gridIndex
			gridIndex = gridIndex + 1
		end
	end
end

function AoQiHeroBattleView:getCellSizeHalf()
	return self._cellSizeHalf
end

function AoQiHeroBattleView:_genarateMap()
	self:_clearMap()

	self._mapObject = {}

	local cellSizeHalf = self:getCellSizeHalf()
	local posX, poxY = 0, 0
	local step = {
		x = cellSizeHalf.x * 2,
		y = -cellSizeHalf.y * 2
	}

	for row = 1, self._mapRow do
		for col = 1, self._mapCol do
			local info = AoQiHeroBattleModel.instance:getInfo(row, col)
			local obj = self:_genarateGridCell(info)

			self._mapObject[row] = self._mapObject[row] or {}
			self._mapObject[row][col] = obj

			GameUtil.setAnchoredPos(obj, -cellSizeHalf.x * self._mapCol + step.x * (col - 1), cellSizeHalf.y * self._mapRow + step.y * (row - 1))
			self:setGridBlock(obj, checknumber(info) == AoQiHeroConst.MapBlockIndex)
		end
	end

	local cellContainerPos = GameUtil.getAnchoredPos(self._cellContain)
	local petContainerPos = GameUtil.getAnchoredPos(self._petContain)

	self._mapToPetOffset = petContainerPos - cellContainerPos

	GameUtil.setAnchoredPos(self._enemyContain, cellContainerPos.x, cellContainerPos.y)
	GameUtil.setAnchoredPos(self._damageContain, cellContainerPos.x, cellContainerPos.y)
end

function AoQiHeroBattleView:_genarateEntity()
	local defenceTeamMo = AoQiHeroEntityMgr.instance:getTeamMo(AoQiHeroConst.DefenceTeam)

	self._mapEnemyObject = {}

	for i, v in pairs(defenceTeamMo.pos) do
		local enemyInfo = AoQiHeroEntityMgr.instance:getPet(v)
		local obj = self:_genarateEnemyCell(enemyInfo)

		self._mapEnemyObject[v] = obj

		local posX, posY = AoQiHeroBattleModel.instance:grid2XY(enemyInfo.pos)
		local targetGridCellObj = self._mapObject[posX][posY]
		local cellPos = GameUtil.getAnchoredPos(targetGridCellObj)
		local cellSizeHalf = self:getCellSizeHalf()
		local sizeX, sizeY = obj:getSize()

		GameUtil.setAnchoredPos(obj:getGo(), cellPos.x + cellSizeHalf.x * (sizeY - 1), cellPos.y - cellSizeHalf.y * (sizeX - 1))
	end
end

function AoQiHeroBattleView:_disposeFunc(obj)
	local enemyCell = Framework.LuaComponentContainer.Get(obj.gameObject, AoQiHeroEnemyCell)

	if enemyCell then
		enemyCell:_onDestory()
	end
end

function AoQiHeroBattleView:_resetFunc(obj)
	if self._petEffect[obj] then
		UIEffectManager.instance:stopEffect(self._petEffect[obj])

		self._petEffect[obj] = nil
	end

	goutil.addChildToParent(obj.gameObject, self._freeContainer.gameObject.transform)
	GameUtil.SetActive(obj.gameObject, false)
end

function AoQiHeroBattleView:_genarateGridCell(cellInfo)
	if not self._cellPools then
		local function resetFunc(obj)
			self:_resetFunc(obj)
		end

		local function disposeFunc(obj)
			self:_disposeFunc(obj)
		end

		local function createFunc()
			return (goutil.cloneAndSetParent(self._gridCell, self._cellContain.gameObject.transform))
		end

		self._cellPools = ObjectPool.New(5, createFunc, disposeFunc, resetFunc)
	end

	local cellObj = self._cellPools:fetchObject()

	goutil.addChildToParent(cellObj.gameObject, self._cellContain.gameObject.transform)
	GameUtil.SetActive(cellObj.gameObject, true)
	self:_updateGridCell(cellObj, cellInfo)

	return cellObj
end

function AoQiHeroBattleView:_updateGridCell(cell, data)
	local go = cell.gameObject
	local imgChange = goutil.findChildComponent(go, "img", ComponentType.UIImageSpriteChange)

	imgChange:SetState(math.random(0, 7))
end

function AoQiHeroBattleView:_clearGridCell(cell, data)
	return
end

function AoQiHeroBattleView:_clearMap()
	for row, v in ipairs(self._mapObject or {}) do
		for col, obj in ipairs(v) do
			self._cellPools:returnObject(obj)
		end
	end

	self._mapObject = nil

	if self._mapEnemyObject then
		for i, v in pairs(self._mapEnemyObject) do
			self._enemyCellPools:returnObject(v:getGo())
		end
	end

	self._mapEnemyObject = nil
end

function AoQiHeroBattleView:_disposeMap()
	self:_clearMap()
	self._cellPools:clear()
	self._enemyCellPools:clear()

	if self._effectCellPools then
		self._effectCellPools:clear()
	end
end

function AoQiHeroBattleView:_genarateEnemyCell(cellInfo)
	if not self._enemyCellPools then
		local function resetFunc(obj)
			self:_resetFunc(obj)
		end

		local function disposeFunc(obj)
			self:_disposeFunc(obj)
		end

		local function createFunc()
			local cellObj = goutil.cloneAndSetParent(self._enemyCell, self._enemyContain.gameObject.transform)
			local enemyCell = Framework.LuaComponentContainer.Add(cellObj.gameObject, AoQiHeroEnemyCell)

			return cellObj
		end

		self._enemyCellPools = ObjectPool.New(5, createFunc, disposeFunc, resetFunc)
	end

	local cellObj = self._enemyCellPools:fetchObject()
	local enemyCell = Framework.LuaComponentContainer.Get(cellObj.gameObject, AoQiHeroEnemyCell)

	goutil.addChildToParent(cellObj.gameObject, self._enemyContain.gameObject.transform)
	GameUtil.SetActive(cellObj.gameObject, true)
	enemyCell:initCell(cellInfo, self)

	return enemyCell
end

function AoQiHeroBattleView:_updateTowerInfo()
	local towerPet = AoQiHeroEntityMgr.instance:getPet(AoQiHeroConst.TowerEntityId)
	local curHp, maxHp = checkint(towerPet.curHp), checkint(towerPet:getMaxHp())

	self._sliderHp:SetValue(curHp / maxHp)

	self._txtHp.text = langPara("%d", curHp)

	local list = {}
	local buffMap = {}

	for i, v in ipairs(towerPet.buffList) do
		local buffMo = AoQiHeroBuffMgr.instance:getBuff(v)

		if not buffMap[buffMo.configId] then
			buffMap[buffMo.configId] = true

			if not string.nilorempty(buffMo.buffCfg.buffIcon) then
				table.insert(list, buffMo.configId)
			end
		end
	end

	self._towerBuffTableList:reloadData(list)
end

function AoQiHeroBattleView:_changeTowerNum(num)
	local towerPet = AoQiHeroEntityMgr.instance:getPet(AoQiHeroConst.TowerEntityId)
	local curHp, maxHp = checkint(self._txtHp.text), checkint(towerPet:getMaxHp())

	curHp = curHp + num
	curHp = math.max(curHp, 0)
	curHp = math.min(curHp, maxHp)

	self._sliderHp:SetValue(curHp / maxHp)

	self._txtHp.text = langPara("%d", curHp)
end

function AoQiHeroBattleView:_updatePetInfo()
	local curEnergy, maxEnergy = AoQiHeroSkillMgr.instance:getMyTeamEnergy(), AoQiHeroSkillMgr.instance:getMaxEnergy()

	if self._effectSuperBtn then
		UIEffectManager.instance:stopEffect(self._effectSuperBtn)

		self._effectSuperBtn = nil
	end

	if curEnergy < maxEnergy then
		-- block empty
	else
		self._effectSuperBtn = UIEffectManager.instance:playEffect(self, superActiveEffName, nil, 0, 0, true)

		self._effectSuperBtn:setParent(self._effectSuperBtnGo.transform)
		self._effectSuperBtn:setScale(1)
		self._effectSuperBtn:setLocalPos(0, 0, 0)
	end

	GameUtil.SetActive(self._closeSuper, self._isUseSuper)

	self._txtSuper.text = self._isUseSuper == true and lang("取消") or lang("超杀")

	self._sliderEnergy:SetValue(curEnergy / maxEnergy)

	self._txtEnergy.text = langPara("%d/%d", curEnergy, maxEnergy)
	self._showPetGo = {}

	local petTeamInfo = AoQiHeroEntityMgr.instance:getTeamMo(AoQiHeroConst.AttackTeam)

	self._petTableList:reloadData(petTeamInfo.pos)
end

function AoQiHeroBattleView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject
	local drag = Framework.UIDragTrigger.Get(go)
	local petMo = AoQiHeroEntityMgr.instance:getPet(data)
	local petIcon = goutil.findChild(go, "petCon/con")
	local selectGo = goutil.findChild(go, "select")
	local petIconSelect = goutil.findChild(go, "select/petCon")
	local superBg = goutil.findChild(go, "superBg")
	local superEffect = goutil.findChild(go, "superEffect")
	local buffTableView = goutil.findChild(go, "buffTableView")
	local typeChange = goutil.findChildComponent(go, "type", "UIImageSpriteChange")
	local txtLv = goutil.findChildTextComponent(go, "txtLv")
	local imgRange = goutil.findChild(go, "imgRange")
	local imgBuffDazed = goutil.findChild(go, "imgBuffDazed")

	go.name = "pet_" .. petMo.id

	local pointerDown = PointerDownHandler.Get(go):AddLuaHandler(function(obj, eventData)
		self:onPointDown(obj, eventData)
	end)

	drag:AddDragListener(self._onDrag, self)
	drag:AddBeginDragListener(function(eventData)
		self:_onDragBegin(go, eventData)
	end, self)
	drag:AddEndDragListener(self._onDragEnd, self)

	local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, petMo.configId)

	uGuiUtil.clearImage(petIcon)

	local showRaceId = petCfg.faceIds
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(showRaceId))

	if not modelCo then
		printError("t_model id not exist:" .. showRaceId)

		return
	end

	uGuiUtil.setSpriteToImage(petIcon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	if self._selectPet then
		local isSelect = data == self._selectPet

		GameUtil.SetGray(petIcon, petMo.isActive == true)
		GameUtil.SetActive(selectGo, isSelect)
		MaterialMgr.resetAll(petIconSelect)
		MaterialMgr.setIcon(petIconSelect, MatType.Pet, petCfg.faceIds)

		if petCfg.elementId > 0 then
			typeChange:SetState(petCfg.elementId - 1)
		end

		txtLv.text = langPara("Lv.%d", petMo.level)

		local isCanUseSuper = self._isUseSuper == true and not petMo.isActive and not AoQiHeroBuffMgr.instance:checkBuffType(petMo.id, AoQiHeroConst.BuffSilence)

		if self._petEffect[superEffect] then
			UIEffectManager.instance:stopEffect(self._petEffect[superEffect])

			self._petEffect[superEffect] = nil
		end

		if isCanUseSuper == true and not isSelect then
			local effectPath = "20250403/aqyst/fx_aqyst_touxiang.prefab"
			local effectHanler = UIEffectManager.instance:playEffect(self, effectPath, nil, 0, 0, true)

			effectHanler:setParent(superEffect.transform)
			effectHanler:setScale(1)
			effectHanler:setLocalPos(0, 0, 0)

			self._petEffect[superEffect] = effectHanler
		end

		GameUtil.SetActive(superBg, isCanUseSuper)

		self._showPetGo[petMo.id] = go

		local showSkillCfg = self._isUseSuper == true and AoQiHeroConfig.instance:getSkillCfg(petMo:getUltSkill()) or AoQiHeroConfig.instance:getSkillCfg(petMo:getNormalSkill())

		uGuiUtil.clearImage(imgRange)
		uGuiUtil.setSpriteToImage(imgRange, uGuiUtil.SpriteType.BigBg, showSkillCfg.rangeImg)

		local isNotCanAttack = AoQiHeroBuffMgr.instance:checkBuffType(petMo.id, AoQiHeroConst.BuffDazed) or AoQiHeroBuffMgr.instance:checkBuffType(petMo.id, AoQiHeroConst.BuffSettled)

		GameUtil.SetActive(imgBuffDazed, isNotCanAttack)

		if buffTableView and self._buffTableCell then
			if not self._petBuffTableDir[go] then
				local buffTableList = ScrollerList.create(buffTableView, self._buffTableCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))

				self._petBuffTableDir[go] = self._petBuffTableDir[go]

				self._petBuffTableDir[go]:dragNotifyParent()

				local list = {}
				local buffMap = {}

				for i, v in ipairs(petMo.buffList) do
					local buffMo = AoQiHeroBuffMgr.instance:getBuff(v)

					if not buffMap[buffMo.configId] then
						buffMap[buffMo.configId] = true

						if not string.nilorempty(buffMo.buffCfg.buffIcon) then
							table.insert(list, buffMo.configId)
						end
					end
				end

				self._petBuffTableDir[go]:reloadData(list)
			end
		end

		GameUtil.addClickHandler(go, function()
			self:_onClickPet(go, petMo.configId, petMo.level)
		end)
	end
end

function AoQiHeroBattleView:_clearPetCell(cell)
	local go = cell.gameObject
	local drag = Framework.UIDragTrigger.Get(go)
	local petIcon = goutil.findChild(go, "petCon/con")
	local petIconSelect = goutil.findChild(go, "select/petCon")
	local superEffect = goutil.findChild(go, "superEffect")
	local imgRange = goutil.findChild(go, "imgRange")

	MaterialMgr.resetAll(petIconSelect)
	PointerDownHandler.Get(go):RemoveLuaHandler(self._pointerDown)
	drag:RemoveDragListener()
	drag:RemoveBeginDragListener()
	drag:RemoveEndDragListener()
	uGuiUtil.clearImage(imgRange)
	uGuiUtil.clearImage(petIcon)

	if self._petEffect[superEffect] then
		UIEffectManager.instance:stopEffect(self._petEffect[superEffect])

		self._petEffect[superEffect] = nil
	end

	local buffScrollList = self._petBuffTableDir[go]

	if buffScrollList then
		buffScrollList:dispose()

		self._petBuffTableDir[go] = nil
	end
end

function AoQiHeroBattleView:_updateBuffCell(view, cell, data, tag)
	local go = cell.gameObject
	local buffCfg = AoQiHeroConfig.instance:getSkillAffixCfg(data)

	uGuiUtil.setSpriteToImage(go, uGuiUtil.SpriteType.BigBg, buffCfg.buffIcon)
end

function AoQiHeroBattleView:_clearBuffCell(cell)
	local go = cell.gameObject

	uGuiUtil.clearImage(go)
end

function AoQiHeroBattleView:_initBigRoundStart()
	AoQiHeroRoundMgr.instance:startBigRound()

	local function handler()
		self._isPlaying = false
	end

	if self._maxRoundLimit >= AoQiHeroConst.MaxRoundLimit then
		self._txtRound.text = langPara("<color=#00FD8AFF>%d</color>", AoQiHeroRoundMgr.instance:getBigRound())
		self._txtRoundTips.text = langPara("当前回合：<color=#00FD8AFF>%d</color>", AoQiHeroRoundMgr.instance:getBigRound())
	else
		self._txtRound.text = langPara("<color=#00FD8AFF>%d</color>/%d", AoQiHeroRoundMgr.instance:getBigRound(), self._maxRoundLimit)
		self._txtRoundTips.text = langPara("当前回合：<color=#00FD8AFF>%d</color>/%d", AoQiHeroRoundMgr.instance:getBigRound(), self._maxRoundLimit)
	end

	self._playingTeam = AoQiHeroConst.AttackTeam

	self._imgChangeStartRountTips:SetState(1)

	self._isPlaying = true

	GameUtil.SetActive(self._startRoundTips, true)

	local tween = UnityTweens.TweenPosition.StartTween(self._startRoundTips, Vector3(0, 0, 0), Vector3(0, 0, 0), ROUND_TIPS_SHOW_TIME / self._gameSpeed)

	tween:AddListener(function()
		GameUtil.SetActive(self._startRoundTips, false)
		handler()
	end)

	self._opTime = nil

	GameUtil.SetActive(self._txtMinRound, true)
	GameUtil.SetActive(self._timeInfo, false)
end

function AoQiHeroBattleView:_exitBigRoundStart()
	self:_refreshInfo()
end

function AoQiHeroBattleView:_updateBigRoundStartShow()
	local topRoundMo = AoQiHeroRoundMgr.instance:getTopRound()

	if not self._isPlaying and (not topRoundMo or not topRoundMo.isInit) then
		if self:_checkGameEnd() then
			self._stateMachine:gotoState(STATE_BLOCK)
		else
			self._stateMachine:gotoState(STATE_MY_TEAM_START)
		end
	elseif not self._isPlaying then
		self._isPlaying = true

		self:_showTopRound(self._startShowEnd)
	end
end

function AoQiHeroBattleView:_startShowEnd()
	AoQiHeroRoundMgr.instance:popTopRound()

	self._isPlaying = false
end

function AoQiHeroBattleView:_refreshInfo()
	self:_updateTowerInfo()

	local teamMo = AoQiHeroEntityMgr.instance:getTeamMo(AoQiHeroConst.DefenceTeam)

	for i, v in ipairs(teamMo.pos) do
		local enemyMo = AoQiHeroEntityMgr.instance:getPet(v)

		if not AoQiHeroEntityMgr.instance:isPetSurvival(v) then
			local obj = self._mapEnemyObject[v]

			if obj then
				self._enemyCellPools:returnObject(obj:getGo())

				self._mapEnemyObject[v] = nil
			end
		else
			local obj = self._mapEnemyObject[v]

			obj:updateCell(enemyMo)
			GameUtil.SetActive(obj:getGo(), true)
		end
	end

	local petTeamInfo = AoQiHeroEntityMgr.instance:getTeamMo(AoQiHeroConst.AttackTeam)

	self._petTableList:reloadData(petTeamInfo.pos)
end

function AoQiHeroBattleView:_showTopRound(handler)
	self._reportIndex = 0
	self._tempHandler = nil
	self._tempHandler = handler

	self:_showNextReport()
end

function AoQiHeroBattleView:_showNextReport()
	GameUtil.SetActive(self._skillEnemyCell, false)
	GameUtil.SetActive(self._skillPetCell, false)

	local topRoundMo = AoQiHeroRoundMgr.instance:getTopRound()

	if self._reportIndex < #topRoundMo.reportMosList then
		self._reportIndex = self._reportIndex + 1
	else
		self:_tempHandler()

		return
	end

	local reportMos = topRoundMo.reportMosList[self._reportIndex]

	self._numberCount = 0
	self._isShowSkill = false

	local isShowAction = false

	for k, reportMo in pairs(reportMos) do
		if reportMo.isShow == true then
			isShowAction = true

			if reportMo.isSkill == true then
				self._isShowSkill = true
			elseif reportMo.isMove == true then
				local enemyMo = AoQiHeroEntityMgr.instance:getPet(reportMo.petId)
				local obj = self._mapEnemyObject[reportMo.petId]

				if enemyMo.teamId == AoQiHeroConst.DefenceTeam and obj then
					local paths = {}
					local sizeX, sizeY = obj:getSize()

					for i, v in ipairs(reportMo.path) do
						local x, y = AoQiHeroBattleModel.instance:grid2XY(v)
						local targetGridCellObj = self._mapObject[x][y]
						local cellPos = GameUtil.getAnchoredPos(targetGridCellObj)
						local cellSizeHalf = self:getCellSizeHalf()

						table.insert(paths, Vector3.New(cellPos.x + cellSizeHalf.x * (sizeY - 1), cellPos.y - cellSizeHalf.y * (sizeX - 1), 0))
					end

					self._numberCount = self._numberCount + 1

					TweenUtil.DOTweenMovePath(obj:getGo().transform, false, paths, MOVE_TIME * #paths / self._gameSpeed, self._moveEnd, self)
				end
			else
				local enemyMo = AoQiHeroEntityMgr.instance:getPet(reportMo.petId)

				if enemyMo.teamId == AoQiHeroConst.DefenceTeam then
					if self._mapEnemyObject[reportMo.petId] then
						self:_showNum(self._mapEnemyObject[reportMo.petId]:getGo(), reportMo)
						self._mapEnemyObject[reportMo.petId]:changeNumber(reportMo.totalHpChange)
					end
				else
					self:_showNum(self._tower, reportMo)
					self:_changeTowerNum(reportMo.totalHpChange)
				end
			end
		end
	end

	if self._isShowSkill == true then
		self:_showCurSkill()
	end

	if not isShowAction then
		self._numberCount = self._numberCount + 1

		local tween = UnityTweens.TweenPosition.StartTween(self._startRoundTips, Vector3(0, 0, 0), Vector3(0, 0, 0), 0.1)

		tween:AddListener(function()
			self._numberCount = self._numberCount - 1

			if self._numberCount <= 0 then
				self:_showNextReport()
			end
		end)
	end
end

function AoQiHeroBattleView:_showCurSkill()
	self._isShowSkill = true

	local topRoundMo = AoQiHeroRoundMgr.instance:getTopRound()
	local reportMos = topRoundMo.reportMosList[self._reportIndex]
	local skillMo = topRoundMo.skillMo

	if not skillMo then
		self:_showNumBySkillReportMos(nil, reportMos)

		return
	end

	local skillCfg = AoQiHeroConfig.instance:getSkillCfg(skillMo.configId)
	local targetGrid = skillMo.targetPos
	local targetGridGo

	if targetGrid == 0 then
		targetGridGo = self._tower
	else
		local posX, posY = AoQiHeroBattleModel.instance:grid2XY(targetGrid)

		targetGridGo = self._mapObject[posX][posY]
	end

	local targetGridPos = GameUtil.getPos(targetGridGo)
	local petMo = AoQiHeroEntityMgr.instance:getPet(skillMo.targetA)
	local formGo = petMo.teamId == AoQiHeroConst.AttackTeam and self._skillPetCellCon or self._mapEnemyObject[petMo.id]:getGo()

	if petMo.teamId == AoQiHeroConst.AttackTeam then
		self:_setSkillPet(skillMo.targetA)
		GameUtil.SetActive(self._skillPetCell, true)

		if not string.nilorempty(skillCfg.useEffect) then
			self._numberCount = self._numberCount + 1

			local effectHandler = UIEffectManager.instance:playEffect(self, skillCfg.useEffect, nil, 0, 0, false, nil, function()
				self._numberCount = self._numberCount - 1

				if self._numberCount <= 0 then
					self:_showNextReport()
				end
			end)

			effectHandler:setParent(self._skillPetCellCon.transform)
			effectHandler:setScale(1)
			effectHandler:setLocalPos(0, 0, 0)
		end

		self:_showFlyEffect(skillCfg, formGo, targetGridPos, reportMos)
	else
		if not string.nilorempty(skillCfg.useEffect) then
			self:_setSkillEnemy(skillMo.targetA, formGo, skillMo.isSuper)
			GameUtil.SetActive(self._skillEnemyCell, true)

			self._numberCount = self._numberCount + 1

			local effectHandler = UIEffectManager.instance:playEffect(self, skillCfg.useEffect, nil, 0, 0, false, nil, function()
				self._numberCount = self._numberCount - 1

				if self._numberCount <= 0 then
					self:_showNextReport()
				end
			end)

			effectHandler:setParent(self._petEffectGo.transform)
			effectHandler:setScale(1)
			effectHandler:setLocalPos(0, 0, 0)
		end

		self:_showFlyEffect(skillCfg, formGo, targetGridPos, reportMos)
	end
end

function AoQiHeroBattleView._clearFlyEffectTrail(handler, eff)
	local trs = eff.effGo:GetComponentsInChildren(typeof(UnityEngine.TrailRenderer))

	for i = 0, trs.Length - 1 do
		trs[i]:Clear()
	end

	local ps = eff.effGo:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem))

	for i = 0, ps.Length - 1 do
		ps[i]:Stop()
		ps[i]:Play()
	end
end

function AoQiHeroBattleView:_showFlyEffect(skillCfg, formGo, targetGridPos, reportMos)
	if not string.nilorempty(skillCfg.flyEffect) then
		for i, v in pairs(reportMos) do
			if v.isSkill == true then
				self:_showSingleFlyEffect(skillCfg, formGo, v)
			end
		end
	else
		self:_showAttackEffect(skillCfg, targetGridPos, reportMos)
	end
end

function AoQiHeroBattleView:_showSingleFlyEffect(skillCfg, formGo, reportMo)
	local targetGo, offsetRate

	if reportMo.petId ~= AoQiHeroConst.TowerEntityId then
		targetGo = self._mapEnemyObject[reportMo.petId]:getGo()
		offsetRate = math.random(-50, 50)
	else
		targetGo = self._tower
		offsetRate = math.random(0, 50)
	end

	local skillFlyEffectHandler = UIEffectManager.instance:playEffect(self, skillCfg.flyEffect, nil, 0, 0, true, nil, nil, AoQiHeroBattleView._clearFlyEffectTrail)
	local flyEffectGo = self:_genarateFlyEffectCell()

	skillFlyEffectHandler:setParent(flyEffectGo.transform)
	skillFlyEffectHandler:setScale(1)
	skillFlyEffectHandler:setLocalPos(0, 0, 0)

	self._petEffect[flyEffectGo] = skillFlyEffectHandler

	local startPos = GameUtil.getPos(formGo)
	local endPos = GameUtil.getPos(targetGo)

	GameUtil.setPos(flyEffectGo, startPos.x, startPos.y, startPos.z)
	GameUtil.SetActive(flyEffectGo, true)

	local dir = endPos - startPos
	local normalVector = Vector3.New(dir.y, -dir.x, endPos.z)

	normalVector:SetNormalize()

	local ctrlPoint = Vector3.New(startPos.x + dir.x / 2 + normalVector.x * offsetRate, startPos.y + dir.y / 2 + normalVector.y * offsetRate, startPos.z)
	local tween = UnityTweens.TweenBezier.StartTweenWithSpeed(flyEffectGo, startPos, endPos, ctrlPoint, FLY_EFFECT_SHOW_TIME * self._gameSpeed, UnityTweens.EaseType.linear, 0)

	tween.coordSpace = UnityTweens.CoordSpace.World
	self._numberCount = self._numberCount + 1

	tween:AddListener(function()
		if self._petEffect[flyEffectGo] then
			UIEffectManager.instance:stopEffect(self._petEffect[flyEffectGo])

			self._petEffect[flyEffectGo] = nil
		end

		self._effectCellPools:returnObject(flyEffectGo)

		self._numberCount = self._numberCount - 1

		self:_showNumBySkillReportMo(skillCfg, reportMo)
	end)
end

function AoQiHeroBattleView:_showNumBySkillReportMo(skillCfg, reportMo)
	local enemyMo = AoQiHeroEntityMgr.instance:getPet(reportMo.petId)

	if enemyMo.teamId == AoQiHeroConst.DefenceTeam then
		if self._mapEnemyObject[reportMo.petId] then
			local enemyGo = self._mapEnemyObject[reportMo.petId]:getGo()

			if self._petEffect[enemyGo] then
				UIEffectManager.instance:stopEffect(self._petEffect[enemyGo])

				self._petEffect[enemyGo] = nil
			end

			local effectHandler = UIEffectManager.instance:playEffect(self, skillCfg.attackEffect, nil, 0, 0, false)

			effectHandler:setParent(enemyGo.transform)
			effectHandler:setScale(1)
			effectHandler:setLocalPos(0, 0, 0)
			self:_showNum(enemyGo, reportMo)
			self._mapEnemyObject[reportMo.petId]:changeNumber(reportMo.totalHpChange)

			self._petEffect[enemyGo] = effectHandler
		end
	else
		if self._petEffect[self._tower] then
			UIEffectManager.instance:stopEffect(self._petEffect[self._tower])

			self._petEffect[self._tower] = nil
		end

		local effectHandler = UIEffectManager.instance:playEffect(self, skillCfg.attackEffect, nil, 0, 0, false)

		effectHandler:setParent(self._tower.transform)
		effectHandler:setScale(1)
		effectHandler:setLocalPos(0, 0, 0)

		self._petEffect[self._tower] = effectHandler

		self:_showNum(self._tower, reportMo)
		self:_changeTowerNum(reportMo.totalHpChange)
	end
end

function AoQiHeroBattleView:_genarateFlyEffectCell()
	if not self._effectCellPools then
		local function resetFunc(obj)
			self:_resetEffectFunc(obj)
		end

		local function disposeFunc(obj)
			self:_disposeEffectFunc(obj)
		end

		local function createFunc()
			return (goutil.cloneAndSetParent(self._flyEffectCell, self._effectContain.gameObject.transform))
		end

		self._effectCellPools = ObjectPool.New(5, createFunc, disposeFunc, resetFunc)
	end

	local cellObj = self._effectCellPools:fetchObject()

	goutil.addChildToParent(cellObj.gameObject, self._effectContain.gameObject.transform)
	GameUtil.SetActive(cellObj.gameObject, true)

	return cellObj
end

function AoQiHeroBattleView:_resetEffectFunc(obj)
	GameUtil.SetActive(obj, false)
end

function AoQiHeroBattleView:_disposeEffectFunc(obj)
	goutil.destroy(obj)
end

function AoQiHeroBattleView:_showAttackEffect(skillCfg, targetPos, reportMos)
	self:_showNumBySkillReportMos(skillCfg, reportMos)
end

function AoQiHeroBattleView:_showNumBySkillReportMos(skillCfg, reportMos)
	for k, reportMo in pairs(reportMos) do
		if reportMo.isSkill == true then
			local enemyMo = AoQiHeroEntityMgr.instance:getPet(reportMo.petId)

			if enemyMo.teamId == AoQiHeroConst.DefenceTeam then
				if self._mapEnemyObject[reportMo.petId] then
					local enemyGo = self._mapEnemyObject[reportMo.petId]:getGo()

					if self._petEffect[enemyGo] then
						UIEffectManager.instance:stopEffect(self._petEffect[enemyGo])

						self._petEffect[enemyGo] = nil
					end

					local effectHandler = UIEffectManager.instance:playEffect(self, skillCfg.attackEffect, nil, 0, 0, false)

					effectHandler:setParent(enemyGo.transform)
					effectHandler:setScale(1)
					effectHandler:setLocalPos(0, 0, 0)
					self:_showNum(enemyGo, reportMo)
					self._mapEnemyObject[reportMo.petId]:changeNumber(reportMo.totalHpChange)

					self._petEffect[enemyGo] = effectHandler
				end
			else
				if self._petEffect[self._tower] then
					UIEffectManager.instance:stopEffect(self._petEffect[self._tower])

					self._petEffect[self._tower] = nil
				end

				local effectHandler = UIEffectManager.instance:playEffect(self, skillCfg.attackEffect, nil, 0, 0, false)

				effectHandler:setParent(self._tower.transform)
				effectHandler:setScale(1)
				effectHandler:setLocalPos(0, 0, 0)

				self._petEffect[self._tower] = effectHandler

				self:_showNum(self._tower, reportMo)
				self:_changeTowerNum(reportMo.totalHpChange)
			end
		end
	end

	if self._numberCount <= 0 then
		self:_showNextReport()
	end
end

function AoQiHeroBattleView:_setSkillPet(petId)
	local petMo = AoQiHeroEntityMgr.instance:getPet(petId)
	local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, petMo.configId)

	MaterialMgr.resetAll(self._skillPetCellCon)
	MaterialMgr.setIcon(self._skillPetCellCon, MatType.Pet, petCfg.faceIds)

	local pos = GameUtil.getPos(self._showPetGo[petMo.id])

	GameUtil.setPos(self._skillPetCell, pos.x, pos.y, pos.z)
end

function AoQiHeroBattleView:_setSkillEnemy(petId, targetGo, isShowImage)
	local petMo = AoQiHeroEntityMgr.instance:getPet(petId)
	local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, petMo.configId)

	MaterialMgr.resetAll(self._skillEnemyCellCon)

	if isShowImage == true then
		MaterialMgr.setIcon(self._skillEnemyCellCon, MatType.Pet, petCfg.faceIds)
		GameUtil.SetActive(self._skillEnemyCellInfo, true)
	else
		GameUtil.SetActive(self._skillEnemyCellInfo, false)
	end

	local pos = GameUtil.getPos(targetGo)

	GameUtil.setPos(self._skillEnemyCell, pos.x, pos.y, pos.z)

	local maxScaleSize = math.min(petMo.sizeY, petMo.sizeX)

	GameUtil.setLocalScale(self._skillEnemyCell, maxScaleSize, maxScaleSize, 1)
end

function AoQiHeroBattleView:_moveEnd()
	self._numberCount = self._numberCount - 1

	if self._numberCount <= 0 then
		self:_showNextReport()
	end
end

function AoQiHeroBattleView:_initMyTeamStart()
	self._txtMinRound.text = lang("我的回合")
	self._playingTeam = AoQiHeroConst.AttackTeam

	AoQiHeroRoundMgr.instance:createAndAddEmptyRound()
	self._stateMachine:gotoState(STATE_CAN_OPERATE)
	GameUtil.SetActive(self._timeOutEffectCon, false)
end

function AoQiHeroBattleView:_initCanOpreate()
	self._selectPet = nil
	self._selectGridX = nil
	self._selectGridY = nil

	self:refreshSelect()

	local petTeamInfo = AoQiHeroEntityMgr.instance:getTeamMo(AoQiHeroConst.AttackTeam)

	self._petTableList:reloadData(petTeamInfo.pos)

	if AoQiHeroEntityMgr.instance:checkPetActiveAndMotion() == false then
		FloatWordMgr.instance:show(lang("已无可行动精灵，自动跳过回合"))

		if AoQiHeroSkillMgr.instance:useAllPetEmptyMotion() == true then
			self._stateMachine:gotoState(STATE_MY_TEAM_ROUND)
		else
			self._stateMachine:gotoState(STATE_ENEMY_TEAM_START)
		end
	end

	if self._opTime == nil then
		self._opTime = ServerTime.now()
	end

	GameUtil.SetActive(self._txtMinRound, false)
	GameUtil.SetActive(self._timeInfo, true)
end

function AoQiHeroBattleView:_exitCanOpreate()
	return
end

function AoQiHeroBattleView:_updateCanOpreate()
	if self._roundTime < 0 then
		return
	end

	if self._opTime + self._roundTime > ServerTime.now() then
		self:_updateOpreateTime()
	elseif AoQiHeroSkillMgr.instance:useAllPetEmptyMotion() == true then
		self._stateMachine:gotoState(STATE_MY_TEAM_ROUND)
	else
		self._stateMachine:gotoState(STATE_ENEMY_TEAM_START)
	end
end

function AoQiHeroBattleView:_initOpreating()
	local petTeamInfo = AoQiHeroEntityMgr.instance:getTeamMo(AoQiHeroConst.AttackTeam)

	self._petTableList:reloadData(petTeamInfo.pos)
end

function AoQiHeroBattleView:_exitOpreating()
	return
end

function AoQiHeroBattleView:_updateOpreating()
	if self._roundTime < 0 then
		return
	end

	if self._opTime + self._roundTime > ServerTime.now() then
		self:_updateOpreateTime()
	else
		self._stateMachine:gotoState(STATE_CAN_OPERATE)
	end
end

function AoQiHeroBattleView:_updateOpreateTime()
	local curTime = checkint(self._opTime + self._roundTime - ServerTime.now())

	GameUtil.SetActive(self._timeOutEffectCon, curTime <= 3)

	curTime = math.max(curTime, 0)
	self._txtTime.text = string.format("<color=#00FD8AFF>%d</color>", curTime)
end

function AoQiHeroBattleView:_initMyTeamRound()
	self._isUseSuper = false
	self._opTime = nil

	GameUtil.SetActive(self._txtMinRound, true)
	GameUtil.SetActive(self._timeInfo, false)
	GameUtil.SetActive(self._timeOutEffectCon, false)
end

function AoQiHeroBattleView:_exitMyTeamRound()
	self:_refreshInfo()
end

function AoQiHeroBattleView:_onMyShowFinish()
	self._selectPet = nil
	self._selectGridX = nil
	self._selectGridY = nil

	self:refreshSelect()
	AoQiHeroRoundMgr.instance:endRound()

	self._isPlaying = false
end

function AoQiHeroBattleView:_updateMyTeamRound()
	local topRoundMo = AoQiHeroRoundMgr.instance:getTopRound()

	if not self._isPlaying and (not topRoundMo or not topRoundMo.isInit) then
		if self:_checkGameEnd() then
			self._stateMachine:gotoState(STATE_BLOCK)
		elseif AoQiHeroRoundMgr.instance:getCurTeamType() == AoQiHeroConst.AttackTeam then
			self._stateMachine:gotoState(STATE_CAN_OPERATE)
		else
			self._stateMachine:gotoState(STATE_ENEMY_TEAM_START)
		end
	elseif not self._isPlaying then
		self._isPlaying = true

		AoQiHeroRoundMgr.instance:startRound()
		self:_showTopRound(self._onMyShowFinish)
		self:_updatePetInfo()
	end
end

function AoQiHeroBattleView:_initEnemyTeamStart()
	self._isUseSuper = false
	self._opTime = nil

	self:_updatePetInfo()

	local function handler()
		self._stateMachine:gotoState(STATE_ENEMY_READY)
	end

	self._txtMinRound.text = lang("对手回合")
	self._playingTeam = AoQiHeroConst.DefenceTeam

	self._imgChangeStartRountTips:SetState(0)

	self._txtRoundTips.text = self._maxRoundLimit >= AoQiHeroConst.MaxRoundLimit and langPara("当前回合：<color=#00FD8AFF>%d</color>", AoQiHeroRoundMgr.instance:getBigRound()) or langPara("当前回合：<color=#00FD8AFF>%d</color>/%d", AoQiHeroRoundMgr.instance:getBigRound(), self._maxRoundLimit)

	GameUtil.SetActive(self._startRoundTips, true)

	local tween = UnityTweens.TweenPosition.StartTween(self._startRoundTips, Vector3(0, 0, 0), Vector3(0, 0, 0), ROUND_TIPS_SHOW_TIME / self._gameSpeed)

	tween:AddListener(function()
		GameUtil.SetActive(self._startRoundTips, false)
		handler()
	end)

	local petTeamInfo = AoQiHeroEntityMgr.instance:getTeamMo(AoQiHeroConst.AttackTeam)

	self._petTableList:reloadData(petTeamInfo.pos)
	GameUtil.SetActive(self._txtMinRound, true)
	GameUtil.SetActive(self._timeInfo, false)
	GameUtil.SetActive(self._timeOutEffectCon, false)
end

function AoQiHeroBattleView:_initEnemyReady()
	AoQiHeroSkillMgr.instance:calculateEnemyAction()
	self._stateMachine:gotoState(STATE_ENEMY_ROUND)
end

function AoQiHeroBattleView:_initEnemyRound()
	return
end

function AoQiHeroBattleView:_exitEnemyRound()
	self:_refreshInfo()
end

function AoQiHeroBattleView:_onEnemyShowFinish()
	AoQiHeroRoundMgr.instance:endRound()

	self._isPlaying = false
end

function AoQiHeroBattleView:_updateEnemyTeamRound()
	local topRoundMo = AoQiHeroRoundMgr.instance:getTopRound()

	if not self._isPlaying and (not topRoundMo or not topRoundMo.isInit) then
		if self:_checkGameEnd() then
			self._stateMachine:gotoState(STATE_BLOCK)
		elseif AoQiHeroRoundMgr.instance:getCurTeamType() == AoQiHeroConst.DefenceTeam then
			self._stateMachine:gotoState(STATE_ENEMY_READY)
		else
			self._stateMachine:gotoState(STATE_BIG_ROUND_END)
		end
	elseif not self._isPlaying then
		AoQiHeroRoundMgr.instance:startRound()

		self._isPlaying = true

		self:_showTopRound(self._onEnemyShowFinish)
	end
end

function AoQiHeroBattleView:_initBigRoundEnd()
	AoQiHeroRoundMgr.instance:endBigRound()
end

function AoQiHeroBattleView:_exitBigRoundEnd()
	self:_refreshInfo()
end

function AoQiHeroBattleView:_updateBigRoundEndShow()
	local topRoundMo = AoQiHeroRoundMgr.instance:getTopRound()

	if not self._isPlaying and (not topRoundMo or not topRoundMo.isInit) then
		self._stateMachine:gotoState(STATE_BLOCK)
	elseif not self._isPlaying then
		self._isPlaying = true

		self:_showTopRound(self._startShowEnd)
	end
end

function AoQiHeroBattleView:_initBlock()
	if self:_checkGameEnd() then
		AoQiHeroController.instance:sendPM_AoQiHeroSyncBattleReq(self._activityId, AoQiHeroRoundMgr.instance:getBigRound(), self._winner == AoQiHeroConst.AttackTeam)
	else
		AoQiHeroController.instance:sendPM_AoQiHeroSyncBattleReq(self._activityId, AoQiHeroRoundMgr.instance:getBigRound())
	end
end

function AoQiHeroBattleView:_initGameEnd()
	local winner = self._winner

	if winner then
		self:_onGameEnd()
	end
end

function AoQiHeroBattleView:_onGameEnd()
	self._isPlaying = false
end

function AoQiHeroBattleView:_checkGameEnd()
	self._winner = nil

	if self._isMidLeave == true then
		self._winner = AoQiHeroConst.DefenceTeam

		return true
	end

	local enemyTeamMo = AoQiHeroEntityMgr.instance:getTeamMo(AoQiHeroConst.DefenceTeam)
	local isAllDead = true

	for i, v in ipairs(enemyTeamMo.pos) do
		local enemyMo = AoQiHeroEntityMgr.instance:getPet(v)

		if enemyMo.isEnemy == true and AoQiHeroEntityMgr.instance:isPetSurvival(v) == true then
			isAllDead = false

			break
		end
	end

	if AoQiHeroEntityMgr.instance:isPetSurvival(AoQiHeroConst.TowerEntityId) == false then
		self._winner = AoQiHeroConst.DefenceTeam

		return true
	end

	if isAllDead then
		self._winner = AoQiHeroConst.AttackTeam

		return true
	end

	if self._stateMachine.lastStateName == STATE_BIG_ROUND_END and AoQiHeroRoundMgr.instance:getBigRound() >= self._maxRoundLimit then
		self._winner = AoQiHeroConst.DefenceTeam

		return true
	end
end

function AoQiHeroBattleView:onPointDown(obj, eventData)
	if self._stateMachine.currStateName ~= STATE_CAN_OPERATE then
		return
	end
end

function AoQiHeroBattleView:_onDrag(eventData)
	if self._stateMachine.currStateName ~= STATE_OPERATING then
		return
	end

	local cellHalf = self:getCellSizeHalf()
	local rectTransform = ViewMgr.instance:getUIRoot():GetComponent("RectTransform")
	local posEvent = goutil.screenToLocalPos(eventData.position, rectTransform)
	local gridX, gridY = self:checkGrid(posEvent.x + self._mapToPetOffset.x - cellHalf.x, posEvent.y + self._mapToPetOffset.y + cellHalf.y)

	if gridX ~= self._selectGridX or gridY ~= self._selectGridY then
		self._selectGridX = gridX
		self._selectGridY = gridY

		self:refreshSelect()
	end
end

function AoQiHeroBattleView:_onDragBegin(obj, eventData)
	if self._stateMachine.currStateName ~= STATE_CAN_OPERATE then
		return
	end

	self._selectGridX = nil
	self._selectGridY = nil

	local nameParam = string.split(obj.name, "_")
	local petId = checknumber(nameParam[2])
	local petMo = AoQiHeroEntityMgr.instance:getPet(petId)

	if petMo.isActive == true then
		return
	end

	if AoQiHeroBuffMgr.instance:checkBuffType(petId, AoQiHeroConst.BuffDazed) or AoQiHeroBuffMgr.instance:checkBuffType(petId, AoQiHeroConst.BuffSettled) then
		FloatWordMgr.instance:show(lang("该精灵不可攻击"))

		return
	end

	if self._isUseSuper == true and AoQiHeroBuffMgr.instance:checkBuffType(petId, AoQiHeroConst.BuffSilence) then
		FloatWordMgr.instance:show(lang("该精灵不可超杀"))

		return
	end

	self._selectPet = petId

	self._stateMachine:gotoState(STATE_OPERATING)
end

function AoQiHeroBattleView:_onDragEnd(eventData)
	if self._stateMachine.currStateName ~= STATE_OPERATING then
		return
	end

	local isCanUse = AoQiHeroSkillMgr.instance:usePetSkill(self._selectPet, self._selectGridX, self._selectGridY, self._isUseSuper)

	if isCanUse == true then
		self._stateMachine:gotoState(STATE_MY_TEAM_ROUND)
	else
		self._stateMachine:gotoState(STATE_CAN_OPERATE)
	end
end

function AoQiHeroBattleView:checkGrid(x, y)
	local cellSizeHalf = self:getCellSizeHalf()
	local rootGridPos = GameUtil.getAnchoredPos(self._mapObject[1][1])
	local offsetX, offsetY = rootGridPos.y - y, x - rootGridPos.x
	local offSetGridX, offSetGridY

	if offsetX < 0 then
		offsetX = offsetX - cellSizeHalf.x
		offSetGridX = math.ceil(offsetX / (cellSizeHalf.x * 2))
	else
		offsetX = offsetX + cellSizeHalf.x
		offSetGridX = math.floor(offsetX / (cellSizeHalf.x * 2))
	end

	if offsetY < 0 then
		offsetY = offsetY - cellSizeHalf.y
		offSetGridY = math.ceil(offsetY / (cellSizeHalf.y * 2))
	else
		offsetY = offsetY + cellSizeHalf.x
		offSetGridY = math.floor(offsetY / (cellSizeHalf.y * 2))
	end

	local realGridX, realGridY = 1 + offSetGridX, 1 + offSetGridY

	return realGridX, realGridY
end

function AoQiHeroBattleView:refreshSelect()
	local petMo = AoQiHeroEntityMgr.instance:getPet(self._selectPet)
	local skillId
	local targetIds, gridIds = AoQiHeroSkillMgr.instance:getSkillTarget(self._selectGridX, self._selectGridY, (petMo or nil) and (self._isUseSuper and petMo:getUltSkill() or petMo:getNormalSkill()))
	local targetMap = {}

	for i, v in ipairs(targetIds) do
		targetMap[v] = true
	end

	for i, v in pairs(self._mapEnemyObject) do
		v:setEnemyCellSelect(targetMap[i])
	end

	local mapSize = AoQiHeroBattleModel.instance:getMapSize()

	for i = 1, mapSize.x do
		for j = 1, mapSize.y do
			self:setGridCellSelect(self._mapObject[i][j], false)
		end
	end

	for i, v in ipairs(gridIds) do
		local x, y = AoQiHeroBattleModel.instance:grid2XY(v)
		local info = AoQiHeroBattleModel.instance:getInfo(x, y)

		if checknumber(info) == AoQiHeroConst.MapEmptyIndex then
			self:setGridCellSelect(self._mapObject[x][y], true)
		end
	end
end

function AoQiHeroBattleView:setGridCellSelect(cell, state)
	local go = cell.gameObject
	local selectGo = goutil.findChild(go, "select")

	GameUtil.SetActive(selectGo, state)
end

function AoQiHeroBattleView:setGridBlock(cell, state)
	local go = cell.gameObject
	local blockGo = goutil.findChild(go, "block")

	GameUtil.SetActive(blockGo, state)
end

function AoQiHeroBattleView:setEnemyCellSelect(cell, state)
	local go = cell.gameObject
	local selectGo = goutil.findChild(go, "select")

	GameUtil.SetActive(selectGo, state)
end

function AoQiHeroBattleView:_onClickPet(go, raceId, lv)
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(go)
	local param = {}

	param.pos = pos
	param.sizeDelta = sizeDelta
	param.view = self
	param.activityId = self._activityId
	param.raceId = raceId
	param.isAttack = true
	param.lv = lv

	ViewMgr.instance:open(ViewName.AoqiHeroPetTipsView, param)
end

function AoQiHeroBattleView:_onClickClose()
	if self._isPlaying == true or self._stateMachine.currStateName ~= STATE_CAN_OPERATE and self._stateMachine.currStateName ~= STATE_GAME_END then
		return
	end

	TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否中途退出，进度将不会保存"), function()
		if self._isPlaying == true or self._stateMachine.currStateName ~= STATE_CAN_OPERATE and self._stateMachine.currStateName ~= STATE_GAME_END then
			FloatWordMgr.instance:show("正在回合中，请在可操作时间内退出")

			return
		end

		self._isMidLeave = true

		self._stateMachine:gotoState(STATE_BLOCK)
	end)
end

function AoQiHeroBattleView:_onClickSuper()
	if self._isPlaying == true or self._stateMachine.currStateName ~= STATE_CAN_OPERATE then
		return
	end

	local curEnergy, maxEnergy = AoQiHeroSkillMgr.instance:getMyTeamEnergy(), AoQiHeroSkillMgr.instance:getMaxEnergy()

	if self._isUseSuper == false and curEnergy < maxEnergy then
		FloatWordMgr.instance:show(lang("气势不足"))

		return
	end

	self._isUseSuper = not self._isUseSuper

	self:_updatePetInfo()
end

function AoQiHeroBattleView:_onClickEndRound()
	if self._isPlaying == true or self._stateMachine.currStateName ~= STATE_CAN_OPERATE then
		return
	end

	TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否结束回合?"), function()
		if self._isPlaying == true or self._stateMachine.currStateName ~= STATE_CAN_OPERATE then
			FloatWordMgr.instance:show("正在回合中，请在可操作时间内结束")

			return
		end

		if AoQiHeroSkillMgr.instance:useAllPetEmptyMotion() == true then
			self._stateMachine:gotoState(STATE_MY_TEAM_ROUND)
		else
			self._stateMachine:gotoState(STATE_ENEMY_TEAM_START)
		end
	end)
end

function AoQiHeroBattleView:_onClickTips()
	local ruleCfgs = AoQiHeroConfig.instance:getImageRuleCfg(1)
	local list = {}

	for i, v in ipairs(ruleCfgs) do
		table.insert(list, {
			url = v.resName,
			desc = v.desc
		})
	end

	TipsFacade.instance:openImageRuleView(list, ruleCfgs[1].title)
end

function AoQiHeroBattleView:_onClickSpeedUp()
	if self._speedBtnTween then
		UnityTweens.TweenRotate.StopTween(self._imgSpeedBg)
		GameUtil.setLocalRotation(self._imgSpeedBg, 0, 0, 0)

		self._speedBtnTween = nil
	end

	if self._gameSpeed == GAME_SPEED_NORMAL then
		self._gameSpeed = GAME_SPEED_ADD
		self._speedBtnTween = UnityTweens.TweenRotate.StartTween(self._imgSpeedBg, Vector3(0, 0, 0), Vector3(0, 0, 3600), 20)
		self._speedBtnTween.loopType = UnityTweens.LoopType.loop
	else
		self._gameSpeed = GAME_SPEED_NORMAL
	end
end

function AoQiHeroBattleView:genarateDamageText(type)
	if not self._demageTextPools[type] then
		local function resetFunc(obj)
			self:_resetDamageFunc(obj)
		end

		local function disposeFunc(obj)
			self:_disposeDamageFunc(obj)
		end

		self._demageTextPools[type] = ObjectPool.New(5, nil, disposeFunc, resetFunc)
	end

	local cellObj

	if self._demageTextPools[type] then
		cellObj = self._demageTextPools[type]:fetchObject()
	end

	local damageNumber

	if not cellObj then
		local cloneTextObject = goutil.findChild(self._damagesText, type)

		cellObj = goutil.clone(self._damageTextCell)

		goutil.addChildToParent(cellObj.gameObject, self._damageContain.gameObject.transform)

		damageNumber = Framework.LuaComponentContainer.Add(cellObj.gameObject, AoQiHeroDamageNumber)

		damageNumber:initCell(cellObj, cloneTextObject, type)
		GameUtil.setLocalPos(cellObj.gameObject, 0, 0, 0)
	else
		goutil.addChildToParent(cellObj.gameObject, self._damageContain.gameObject.transform)

		damageNumber = Framework.LuaComponentContainer.Get(cellObj.gameObject, AoQiHeroDamageNumber)

		GameUtil.setLocalPos(cellObj.gameObject, 0, 0, 0)
	end

	GameUtil.SetActive(cellObj, false)

	return damageNumber
end

function AoQiHeroBattleView:_resetDamageFunc(obj)
	GameUtil.SetActive(obj, false)
end

function AoQiHeroBattleView:_disposeDamageFunc(obj)
	self._updateHuds[obj] = nil

	goutil.destroy(obj)
end

function AoQiHeroBattleView:_updateHud()
	for i, v in pairs(self._updateHuds) do
		v:update(0.02)

		if v:isDone() == true then
			self._updateHuds[v._container] = nil

			GameUtil.SetActive(v._container, false)
			self._demageTextPools[v._type]:returnObject(v._container)
		end
	end
end

function AoQiHeroBattleView:_showNum(effectGo, reportMo, funtionType)
	if funtionType == GameEnum.SkillFuncType.BuffOnly then
		return
	end

	local damage = reportMo.totalHpChange
	local damageNumber = self:genarateDamageText(damage > 0 and "jiaxue" or reportMo.isCritical and "baoji" or "attack")

	damageNumber:setValue(damage)

	local pos = GameUtil.getAnchoredPos(effectGo)

	GameUtil.setAnchoredPos(damageNumber._container, pos.x, pos.y)

	self._updateHuds[damageNumber._container] = damageNumber

	damageNumber:start(effectGo)
end

function AoQiHeroBattleView:_PM_AoQiHeroBattleStartRes()
	self._stateMachine:gotoState(STATE_BIG_ROUND_START)
end

function AoQiHeroBattleView:_PM_AoQiHeroSyncBattleRes()
	if self._winner then
		self._stateMachine:gotoState(STATE_GAME_END)
	else
		self._stateMachine:gotoState(STATE_BIG_ROUND_START)
	end

	if self._isMidLeave == true then
		self:close()
	end
end

return AoQiHeroBattleView
