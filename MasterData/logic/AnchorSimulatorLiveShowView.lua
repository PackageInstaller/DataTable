-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anchorsimulator/view/AnchorSimulatorLiveShowView.lua

module("logic.extensions.anchorsimulator.view.AnchorSimulatorLiveShowView", package.seeall)

local AnchorSimulatorLiveShowView = class("AnchorSimulatorLiveShowView", ViewComponent)

function AnchorSimulatorLiveShowView:ctor()
	AnchorSimulatorLiveShowView.super.ctor(self)

	self._goodFlyGos = {}
	self._bulletCells = {}
	self._tweenerMoves = {}
	self._sequenceGoodFlys = {}
	self._txtGoals = {}
end

function AnchorSimulatorLiveShowView:buildUI()
	AnchorSimulatorLiveShowView.super.buildUI(self)

	self._con = self:getGo("con")
	self._bulletView = self:getGo("bulletCol/bulletView")
	self._bulletCell = self:getGo("bulletCol/bulletCell")
	self._bulletPoolRoot = self:getGo("bulletCol/bulletPoolRoot")
	self._startPos = self:getGo("bulletCol/startPos")
	self._endPos = self:getGo("bulletCol/endPos")
	self._txtGain = self:getTxt("infoCol/txtGain")
	self._btnGood = self:getGo("btnGood")
	self._success = self:getGo("success")
	self._txtLevelInSuccess = self:getTxt("success/txtLevel")
	self._fail = self:getGo("fail")

	local goalScrView = self:getGo("infoCol/goalCol/scrView")
	local goalScrCell = self:getGo("infoCol/goalCol/scrCell")

	self._goalScrollerList = ScrollerList.create(goalScrView, goalScrCell, GameUtil.handler(self._updateGoalCell, self), GameUtil.handler(self._clearGoalCell, self))
	self._viewGoodFly = self:getGo("goodFly/view")
	self._cellGoodFly = self:getGo("goodFly/cell")
	self._poolRootGoodFly = self:getGo("goodFly/poolRoot")
	self._endPosGoodFly = self:getGo("goodFly/endPos")
	self._startPosGoodFly = self:getGo("goodFly/startPos")

	GameUtil.SetActive(self._cellGoodFly, false)

	self._exitMask = self:getGo("exitMask")

	GameUtil.SetActive(self._bulletCell, false)
end

function AnchorSimulatorLiveShowView:bindEvents()
	AnchorSimulatorLiveShowView.super.bindEvents(self)
	GameUtil.addClickHandler(self._exitMask, self._onClickBtnExitMask, self)
	GameUtil.addClickHandler(self._btnGood, self._onClickBtnGood, self)
end

function AnchorSimulatorLiveShowView:unbindEvents()
	AnchorSimulatorLiveShowView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._exitMask)
	GameUtil.rmClickHandler(self._btnGood)
end

function AnchorSimulatorLiveShowView:onEnter()
	AnchorSimulatorLiveShowView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._liveMsg = params[2]
	self._activityType = AnchorSimulatorController.instance:getActivityType()

	local isInTime = AnchorSimulatorController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._anchorSimulatorMo = AnchorSimulatorController.instance:getAnchorSimulatorMo(self._activityId)
	self._actData = AnchorSimulatorConfig.instance:getActData(self._activityId)
	self._liveTimes = self._liveMsg.finishLiveRounds
	self._guestIds = self._liveMsg.guestIds
	self._endHeatValue = checknumber(self._liveMsg.heatValue)
	self._addHeatValue = checknumber(self._liveMsg.addHeatValue)
	self._startHeatValue = Mathf.Max(0, self._endHeatValue - self._addHeatValue)
	self._goalData = AnchorSimulatorConfig.instance:getGoalData(self._activityId, self._liveTimes)
	self._bulletCfg = AnchorSimulatorConfig.instance:getBulletCfg(self._goalData.bulletPlanId)

	self:_creatGoodFlyPool()

	local curLevelData = AnchorSimulatorConfig.instance:getLevelDataByHeat(self._activityId, self._startHeatValue)
	local curLevel = curLevelData.level
	local maxLevel = AnchorSimulatorConfig.instance:getMaxLevel(self._activityId)
	local nextLevel = Mathf.Min(curLevel + 1, maxLevel)
	local nextLevelData = AnchorSimulatorConfig.instance:getLevelData(self._activityId, nextLevel)
	local endLevelData = AnchorSimulatorConfig.instance:getLevelDataByHeat(self._activityId, self._endHeatValue)
	local endLevel = endLevelData.level

	self._nextHeatValue = nextLevelData.heatValue
	self._isSuccess = nextLevel <= endLevel
	self._endProgressInGoals = {}

	local propertyCfg = AnchorSimulatorConfig.instance:getPropertyCfg(self._activityId) or {}

	for _, data in ipairs(propertyCfg) do
		local exp = self._anchorSimulatorMo:getCurPropertyExp(data.propertyType)
		local data = AnchorSimulatorConfig.instance:getPropertyLevelDataByExp(self._activityId, data.propertyType, exp)

		for index, value in ipairs(data.dataValues) do
			self._endProgressInGoals[index] = checknumber(self._endProgressInGoals[index]) + value
		end
	end

	for _, guestId in pairs(self._guestIds) do
		local data = AnchorSimulatorConfig.instance:getGuestData(self._activityId, guestId)

		if data then
			for index, value in ipairs(data.goalValues) do
				self._endProgressInGoals[index] = checknumber(self._endProgressInGoals[index]) + value
			end
		end
	end

	local goalIndexs = {}

	for idx, v in ipairs(self._actData.goalArray) do
		table.insert(goalIndexs, idx)
	end

	self._goalScrollerList:reloadData(goalIndexs)
	self:_startShow()
end

function AnchorSimulatorLiveShowView:onExit()
	AnchorSimulatorLiveShowView.super.onExit(self)
	self:_onStopTicking()
	removetimer(self._showExitMask, self)
	self:_unloadSpine()
	self:_clearBulletPool()
	self:_clearGoodFlyPool()
	self._goalScrollerList:dispose()
	table.clear(self._txtGoals)
end

function AnchorSimulatorLiveShowView:destroyUI()
	AnchorSimulatorLiveShowView.super.destroyUI(self)
	self:_onDestorySpine()
end

function AnchorSimulatorLiveShowView:_updateGoalCell(view, cell, goalIndexs, tag)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtValue = goutil.findChildTextComponent(mainGo, "txtValue")

	if self._actData.goalIconArray then
		local spriteName = self._actData.goalIconArray[goalIndexs]

		if not string.nilorempty(spriteName) then
			local spritePath = GameUrl.getBigbgPngUrl(spriteName)

			uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, spritePath, function()
				icon:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end)
		else
			uGuiUtil.clearImage(icon)
		end

		if self._actData.goalArray then
			txtName.text = self._actData.goalArray[goalIndexs] or ""
		end

		txtValue.text = 0
		self._txtGoals[txtValue] = goalIndexs
	end
end

function AnchorSimulatorLiveShowView:_clearGoalCell(cell)
	local mainGo = cell.gameObject
	local txtValue = goutil.findChildTextComponent(mainGo, "txtValue")
	local icon = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(icon)

	self._txtGoals[txtValue] = nil
end

function AnchorSimulatorLiveShowView:_startShow()
	GameUtil.SetActive(self._exitMask, false)
	self:_loadSpine()
	self:_loadBullet()
	GameUtil.SetActive(self._success, false)
	GameUtil.SetActive(self._fail, false)
	GameUtil.SetActive(self._btnGood, true)
	self._spineCtrl:resumeAnim()
	self:_onStartTicking()
end

function AnchorSimulatorLiveShowView:_endShow()
	self:_onStopTicking()
	GameUtil.SetActive(self._btnGood, false)

	if self._curShowHeatValue > self._nextHeatValue then
		GameUtil.SetActive(self._success, true)

		local data = AnchorSimulatorConfig.instance:getLevelDataByHeat(self._activityId, self._curShowHeatValue)

		self._txtLevelInSuccess.text = data.desc
	else
		GameUtil.SetActive(self._fail, true)
	end

	self._spineCtrl:playHuanHuAnim()
	settimer(1.5, self._showExitMask, self, false)
end

function AnchorSimulatorLiveShowView:_showExitMask()
	GameUtil.SetActive(self._exitMask, true)
end

function AnchorSimulatorLiveShowView:_onStartTicking()
	self._totalShowTime = 15
	self._curShowTime = 0
	self._bulletFireCd = 1
	self._curBulletFireDeltaTime = 0
	self._curShowHeatValue = 0

	self:_onTicking()
	settimer(0, self._onTicking, self, true)
end

function AnchorSimulatorLiveShowView:_onStopTicking()
	removetimer(self._onTicking, self)
end

function AnchorSimulatorLiveShowView:_onTicking()
	self._deltaTime = UnityEngine.Time.deltaTime
	self._curShowTime = self._curShowTime + self._deltaTime

	local time = self._curShowTime / self._totalShowTime

	time = Mathf.SmoothStep(0, 1, time)
	self._curBulletFireDeltaTime = self._curBulletFireDeltaTime + self._deltaTime

	if self._curBulletFireDeltaTime >= self._bulletFireCd then
		self._curBulletFireDeltaTime = 0

		self:_fireBullet()
	end

	for index, value in ipairs(self._endProgressInGoals) do
		for txt, goalIndex in pairs(self._txtGoals) do
			if goalIndex == index then
				txt.text = Mathf.Ceil(Mathf.Lerp(0, value, time))

				break
			end
		end
	end

	self._curShowHeatValue = Mathf.Ceil(Mathf.Lerp(0, self._endHeatValue, time))
	self._txtGain.text = string.format("%s/%s", self._curShowHeatValue, self._nextHeatValue)

	if self._curShowTime >= self._totalShowTime then
		self:_endShow()

		return
	end
end

function AnchorSimulatorLiveShowView:_loadBullet()
	self:_creatBulletPool()
end

function AnchorSimulatorLiveShowView:_fireBullet()
	local bulletId = Mathf.Random(1, #self._bulletCfg)
	local cell = self:_fetchBulletCell(bulletId)
	local formPos = GameUtil.getPos(self._startPos)
	local toPos = GameUtil.getPos(self._endPos)
	local distance = Vector2.Distance(formPos, toPos)
	local deltaTime = distance / 0.3

	GameUtil.setPos(cell._mainGo, formPos.x, formPos.y, formPos.z)

	local tweenerMove = cell._mainGo.transform:DOMove(toPos, deltaTime)

	tweenerMove:SetEase(DG.Tweening.Ease.Linear)
	tweenerMove:OnComplete(function()
		self:_returnBulletCell(cell)
	end)

	self._tweenerMoves[cell._mainGo] = tweenerMove
end

function AnchorSimulatorLiveShowView:_fetchBulletCell(bulletId)
	local cell = self._bulletPool:fetchObject()

	self._bulletCells[cell._entityId] = cell

	local data = self._bulletCfg[bulletId]

	MaterialMgr.setIcon(cell._con, MatType.Pet, data.skinId, nil, nil)

	cell._txtDesc.text = data.desc

	goutil.addChildToParent(cell._mainGo, self._bulletView)
	GameUtil.SetActive(cell._mainGo, true)

	return cell
end

function AnchorSimulatorLiveShowView:_returnBulletCell(cell)
	self._bulletCells[cell._entityId] = nil

	local tweenerMove = self._tweenerMoves[cell._mainGo]

	if tweenerMove then
		tweenerMove:Kill(false)

		self._tweenerMoves[cell._mainGo] = nil
	end

	MaterialMgr.clearIcon(cell._con)

	cell._txtDesc.text = ""

	self._bulletPool:returnObject(cell)
end

function AnchorSimulatorLiveShowView:_creatBulletPool()
	if self._bulletPool ~= nil then
		return
	end

	self._curMaxEntityId = 0
	self._recycleEntityIdList = {}

	local function createFunc()
		local entityId = self._recycleEntityIdList[#self._recycleEntityIdList]

		if entityId == nil then
			self._curMaxEntityId = self._curMaxEntityId + 1
			entityId = self._curMaxEntityId
		else
			self._recycleEntityIdList[#self._recycleEntityIdList] = nil
		end

		local mainGo = goutil.cloneAndSetParent(self._bulletCell, self._bulletPoolRoot.transform, self._bulletCell.name .. entityId)
		local cell = {}

		cell._mainGo = mainGo
		cell._entityId = entityId
		cell._con = goutil.findChild(mainGo, "head/con")
		cell._txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

		return cell
	end

	local function disposeFunc(cell)
		table.insert(self._recycleEntityIdList, cell._entityId)
		goutil.destroy(cell._mainGo)
		table.clear(cell)
	end

	local function resetFunc(cell)
		goutil.addChildToParent(cell._mainGo, self._bulletPoolRoot.transform)
	end

	self._bulletPool = ObjectPool.New(20, createFunc, disposeFunc, resetFunc)
end

function AnchorSimulatorLiveShowView:_clearBulletPool()
	local list = TableUtil.toList(self._bulletCells)

	for _, cell in ipairs(list) do
		self:_returnBulletCell(cell)
	end

	if self._bulletPool then
		self._bulletPool:clear()

		self._bulletPool = nil
	end
end

function AnchorSimulatorLiveShowView:_loadSpine()
	local spineRoot = self._con
	local spinePath = "character/10385_xiaonailong/10385_xiaonailong-ui_p.prefab"

	self._spineCtrl = self._spineCtrl or AnchorSimulatorLiveSpineCtrl.New()

	self._spineCtrl:onInit(spineRoot, self, spinePath)
end

function AnchorSimulatorLiveShowView:_unloadSpine()
	if self._spineCtrl then
		self._spineCtrl:onClear()
	end
end

function AnchorSimulatorLiveShowView:_onDestorySpine()
	if self._spineCtrl then
		self._spineCtrl:onDestory()
	end
end

function AnchorSimulatorLiveShowView:_playAnimSpine(animName)
	if self._spineCtrl and not string.nilorempty(animName) then
		self._spineCtrl:_playAnim(animName, true)
	end
end

function AnchorSimulatorLiveShowView:_shootGoodFly()
	local mainGo = self:_fetchGoodFlyGo()

	if self._sequenceGoodFlys[mainGo] then
		self._sequenceGoodFlys:Kill(false)

		self._sequenceGoodFlys[mainGo] = nil
	end

	local formPos = GameUtil.getPos(self._startPosGoodFly)
	local toPos = GameUtil.getPos(self._endPosGoodFly)
	local distance = Vector2.Distance(formPos, toPos)
	local duration = distance / 0.6

	GameUtil.setPos(mainGo, formPos.x, formPos.y, formPos.z)

	local randomNum = Mathf.Random(0, 60) / 100
	local pathPoints = self:_getArcPathPoints(formPos, toPos, -randomNum, -randomNum)
	local tweenerPath = mainGo.transform:DOPath(pathPoints, duration, DG.Tweening.PathType.CatmullRom)

	tweenerPath:SetEase(DG.Tweening.Ease.Linear)

	local img = mainGo:GetComponent(ComponentType.Image)

	self._tempColor = self._tempColor or Color.New(img.color.r, img.color.g, img.color.b, 1)
	self._tempColor.r, self._tempColor.g, self._tempColor.b, self._tempColor.a = img.color.r, img.color.g, img.color.b, 1
	img.color = self._tempColor

	local tweenerFade = img:DOFade(0.3, duration * 0.5)

	tweenerFade:SetEase(DG.Tweening.Ease.Linear)

	local sequence = DG.Tweening.DOTween.Sequence()

	sequence:Append(tweenerPath)
	sequence:Insert(duration * 0.5, tweenerFade)
	sequence:OnComplete(function()
		self._sequenceGoodFlys[mainGo] = nil

		self:_returnGoodFlyGo(mainGo)
	end)

	self._sequenceGoodFlys[mainGo] = sequence
end

function AnchorSimulatorLiveShowView:_getArcPathPoints(formPos, toPos, arcXFactor, arcYFactor)
	local pathPoints = {
		formPos
	}
	local midPoint = Vector3.Lerp(formPos, toPos, 0.5)
	local offessX = Mathf.Abs(toPos.x - midPoint.x)
	local offessY = Mathf.Abs(toPos.y - midPoint.y)

	midPoint.x = midPoint.x + offessX * arcXFactor
	midPoint.y = midPoint.y + offessY * arcYFactor

	table.insert(pathPoints, midPoint)
	table.insert(pathPoints, toPos)

	return pathPoints
end

function AnchorSimulatorLiveShowView:_fetchGoodFlyGo()
	local mainGo = self._goodFlyPool:fetchObject()

	self._goodFlyGos[mainGo] = mainGo

	goutil.addChildToParent(mainGo, self._viewGoodFly)
	GameUtil.SetActive(mainGo, true)

	return mainGo
end

function AnchorSimulatorLiveShowView:_returnGoodFlyGo(mainGo)
	self._goodFlyGos[mainGo] = nil

	if self._sequenceGoodFlys[mainGo] then
		self._sequenceGoodFlys[mainGo]:Kill(false)

		self._sequenceGoodFlys[mainGo] = nil
	end

	GameUtil.SetActive(mainGo, false)
	self._goodFlyPool:returnObject(mainGo)
end

function AnchorSimulatorLiveShowView:_creatGoodFlyPool()
	if self._goodFlyPool ~= nil then
		return
	end

	local function createFunc()
		return goutil.cloneAndSetParent(self._cellGoodFly, self._poolRootGoodFly.transform, self._cellGoodFly.name)
	end

	local function disposeFunc(mainGo)
		goutil.destroy(mainGo)
	end

	local function resetFunc(mainGo)
		GameUtil.SetActive(mainGo, false)
		goutil.addChildToParent(mainGo, self._poolRootGoodFly.transform)
	end

	self._goodFlyPool = ObjectPool.New(20, createFunc, disposeFunc, resetFunc)
end

function AnchorSimulatorLiveShowView:_clearGoodFlyPool()
	local list = TableUtil.toList(self._goodFlyGos)

	for _, mainGo in ipairs(list) do
		self:_returnGoodFlyGo(mainGo)
	end

	if self._goodFlyPool then
		self._goodFlyPool:clear()

		self._goodFlyPool = nil
	end
end

function AnchorSimulatorLiveShowView:_shootGoodFlyEff()
	local effParentGO = self._viewGoodFly
	local effPath = "20241220/nailong/fx_ui_nailong_goodfly.prefab"

	local function _finishHandle(handlerTarget, eff)
		return
	end

	local function _loadedHandler(handlerTarget, eff)
		eff:setParent(effParentGO.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1, 1, 1)
	end

	local effect = UIEffectManager.instance:playEffect(self, effPath, effParentGO, 0, 0, false, false, _finishHandle, _loadedHandler, nil)
end

function AnchorSimulatorLiveShowView:_onClickBtnExitMask()
	self:close()
end

function AnchorSimulatorLiveShowView:_onClickBtnGood()
	self:_shootGoodFlyEff()
end

return AnchorSimulatorLiveShowView
