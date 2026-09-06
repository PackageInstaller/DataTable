-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/admiremoon/view/AdmireMoonView.lua

module("logic.extensions.admiremoon.view.AdmireMoonView", package.seeall)

local AdmireMoonView = class("AdmireMoonView", ViewComponent)

function AdmireMoonView:ctor()
	AdmireMoonView.super.ctor(self)
end

function AdmireMoonView:unbindEvents()
	AdmireMoonView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnFirework)
end

function AdmireMoonView:bindEvents()
	AdmireMoonView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnFirework, self._onClickFirework, self)
end

function AdmireMoonView:buildUI()
	AdmireMoonView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._rewardCell = self:getGo("rewardCell")
	self._clippRect = self:getGo("tableview/Viewport"):GetComponent(goutil.Type_RectTransform)
	self._btnFirework = self:getBtn("btnFirework")
	self._rpBtnFirework = self:getGo("btnFirework/redpoint")
	self._towerViewCon = self:getGo("towerCon/tower/Viewport/Content")
	self._towerView = self:getGo("towerCon/tower/Viewport")
	self._towerTop = self:getGo("towerCon/top")
	self._towerMiddle = self:getGo("towerCon/middle")
	self._towerDown = self:getGo("towerCon/down")
	self._star = self:getGo("towerCon/star")
	self._player = self:getGo("towerCon/player")
	self._mask = self:getGo("mask")
	self._starCon = self:getGo("towerCon/tower/Viewport/Content/starCon")
	self._goldBar = self:getGo("goldBarCon")
	self._txtProgress = self:getTxt("progress/txt")
	self._txtTime = self:getTxt("time/txt")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._tableview = ScrollerList.create(self._tableviewGo, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function AdmireMoonView:onExit()
	AdmireMoonView.super.onExit(self)
	self._tableview:dispose()

	if self._effectRewardList then
		for _, effect in ipairs(self._effectRewardList) do
			for _, effectCell in ipairs(effect) do
				if effect then
					UIEffectManager.instance:stopEffect(effectCell)
				end
			end
		end
	end

	self._effectRewardList = nil

	for _, effect in ipairs(self._effectList) do
		if effect then
			UIEffectManager.instance:stopEffect(effect)
		end
	end

	self._effectList = nil

	removetimer(self._move, self)
	UnityTweens.TweenRotate.StopTween(self._player)
	UnityTweens.TweenPosition.StopTween(self._towerViewCon)
	UnityTweens.TweenPosition.StopTween(self._player)
	RedPointController.instance:unregRedPoint(self._rpBtnFirework)
end

function AdmireMoonView:onEnter()
	AdmireMoonView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._progressId = checknumber(params[2])

	if self._activityId <= 0 or self._progressId <= 0 then
		FloatWordMgr.instance:show("没有活动id或进度id~")
		self:close()
	end

	self.addGEvent(self, GlobalNotify.GetActivityPluginProgressInfoRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.GainActivityPluginProgressPrizeRes, self._sendGetInfoReq, self)

	self._planCfg = OperationSummaryConfig.instance:getPluginProgressPlanCfg(self._activityId, self._progressId)
	self._prizeCfg = OperationSummaryConfig.instance:getPluginProgressPrizeCfg(self._planCfg.planId)
	self._priceCfgCount = #self._prizeCfg
	self._curProgressId = Mathf.Clamp(OpSummaryController.instance:pluginProgressId(self._activityId), 0, self._prizeCfg[self._priceCfgCount].needScore)
	self._progressInfo = OpSummaryModel.instance:getAdmireMoonInfo()
	self._effectRewardList = {}
	self._effectList = {}
	self._towerId = 0
	self._starId = 0
	self._cacheScore = checknumber(GameUtil.getUserData("admiremoon_tower" .. self._activityId))

	self._tableview:reloadData(self._prizeCfg)
	self:_initTower()
	self:_playIdleEffect()
	GameUtil.SetActive(self._mask, false)

	local objList = {
		{
			showAdd = true,
			id = self._planCfg.materialId
		}
	}

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, objList)

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(math.floor(self._activityId / 1000), self._activityId)

	self._txtTime.text = string.format("活动时间：%s", GameUtil.getFormatTimeByStamp(startTime, endTime))

	RedPointController.instance:regRedPoint(self._rpBtnFirework, RedPointModel.ID_ADMIREMOON)
	self:_sendGetInfoReq()
end

function AdmireMoonView:_sendGetInfoReq()
	OpSummaryController.instance:sendPM_GetActivityPluginProgressInfoReq(self._activityId)
end

function AdmireMoonView:_refresh()
	self._curProgressId = Mathf.Clamp(OpSummaryController.instance:pluginProgressId(self._activityId), 0, self._prizeCfg[self._priceCfgCount].needScore)
	self._txtProgress.text = string.format("当前满月值：<size=30>%d</size>", self._curProgressId)

	self._tableview:refresh()

	if self._cacheScore < self._curProgressId then
		self:_moveAnim()
	else
		UnityTweens.TweenPosition.StartTween(self._player, Vector3.New(0, 0, 0), Vector3.New(0, 6, 0), 0.6).loopType = UnityTweens.LoopType.pingPong
	end
end

function AdmireMoonView:_initTower()
	self._starDataList = {}

	if self._prizeCfg and self._priceCfgCount > 0 then
		local topClone = goutil.findChild(self._towerViewCon, "tower_Top")

		if topClone == nil then
			topClone = goutil.cloneAndSetParent(self._towerTop, self._towerViewCon.transform, "tower_Top")
		end

		local win = goutil.findChild(topClone, "win")
		local isWin = self._cacheScore >= self._prizeCfg[self._priceCfgCount].needScore

		GameUtil.SetActive(win, isWin)

		if isWin then
			self:_playWinEffect()
		end

		for i = self._priceCfgCount - 1, 1, -1 do
			local cfg = self._prizeCfg[i]
			local clone = goutil.findChild(self._towerViewCon, "tower_" .. cfg.id)

			if clone == nil then
				clone = goutil.cloneAndSetParent(self._towerMiddle, self._towerViewCon.transform, "tower_" .. cfg.id)
			end
		end

		local downClone = goutil.findChild(self._towerViewCon, "tower_Down")

		if downClone == nil then
			downClone = goutil.cloneAndSetParent(self._towerDown, self._towerViewCon.transform, "tower_Down")
		end

		local score = 0

		for _, cfg in ipairs(self._prizeCfg) do
			local tower = cfg.id == 1 and goutil.findChild(self._towerViewCon, "tower_Down") or goutil.findChild(self._towerViewCon, "tower_" .. cfg.id - 1)

			if cfg.id % 2 == 0 then
				self:_starCell(cfg.id, tower, true, false)
			else
				self:_starCell(cfg.id, tower, false, cfg.id == 1)
			end

			score = cfg.needScore
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._towerViewCon:GetComponent(goutil.Type_RectTransform))
	self:_setCellPos()
end

function AdmireMoonView:_starCell(towerId, go, isFlip, isFrist)
	self._starDataList[towerId] = {}

	local towerStarCount = self._planCfg.towerStarCount
	local starScore, upStageScore = self:_starScore(towerId)

	if towerStarCount > 0 then
		for i = 1, towerStarCount do
			local parent = goutil.findChild(go, "starCon")
			local starX = tonumber(self._planCfg.spaceX)
			local starY = tonumber(self._planCfg.spaceY)

			if isFrist then
				GameUtil.setLocalPos(parent, 156, -37, 0)

				starX = starX * i * -1
			elseif isFlip then
				GameUtil.setLocalPos(parent, -47, -77, 0)

				starX = starX * i
			else
				GameUtil.setLocalPos(parent, 156, -77, 0)

				starX = starX * i * -1
			end

			local star = goutil.findChild(parent.transform, "star_" .. i)

			if star == nil then
				star = goutil.cloneAndSetParent(self._star, parent.transform, "star_" .. i)
			end

			local starY = starY * i

			GameUtil.setLocalPos(star, starX, starY, 0)

			self._starDataList[towerId][i] = upStageScore + starScore * i

			local isGray = self._cacheScore < upStageScore + starScore * i
			local starState = star:GetComponent("UIImageSpriteChange")

			if not isGray then
				self._towerId = towerId
				self._starId = i
			end

			starState:SetState(isGray and 0 or 1)
		end
	end
end

function AdmireMoonView:_refreshStarState()
	local towerStarCount = self._planCfg.towerStarCount
	local star

	if self._targetTowerId then
		for towerId = 1, self._targetTowerId do
			for starId = 1, towerStarCount do
				star = towerId == 1 and goutil.findChild(self._towerViewCon, "tower_Down/starCon/star_" .. starId) or goutil.findChild(self._towerViewCon, "tower_" .. towerId - 1 .. "/starCon/star_" .. starId)

				local isGray = self._cacheScore < self._starDataList[towerId][starId]
				local starState = star:GetComponent("UIImageSpriteChange")

				starState:SetState(isGray and 0 or 1)
				print("self._towerId", towerId, "self._starId", starId, "已刷新状态:", isGray)
			end
		end
	end
end

function AdmireMoonView:_starScore(towerId)
	if towerId == 1 then
		return self._prizeCfg[towerId].needScore / self._planCfg.towerStarCount, 0
	else
		return (self._prizeCfg[towerId].needScore - self._prizeCfg[towerId - 1].needScore) / self._planCfg.towerStarCount, self._prizeCfg[towerId - 1].needScore
	end
end

function AdmireMoonView:_moveAnim()
	self._targetTowerId, self._targetStarId = self:_setTarget()

	if self._targetTowerId <= self._towerId and self._targetStarId <= self._starId then
		return
	end

	GameUtil.saveUserData("admiremoon_tower" .. self._activityId, self._curProgressId)
	GameUtil.SetActive(self._mask, true)
	UnityTweens.TweenPosition.StopTween(self._player)

	UnityTweens.TweenRotate.StartTween(self._player, Vector3.New(0, 0, 10), Vector3.New(0, 0, -10), 0.4).loopType = UnityTweens.LoopType.pingPong

	settimer(0.5, self._move, self)
end

function AdmireMoonView:_move()
	if self._towerId < 1 then
		self._towerId = 1
	end

	if self._starId + 1 > self._planCfg.towerStarCount then
		self._towerId = self._towerId + 1
		self._starId = 1
	else
		self._starId = self._starId + 1
	end

	self:_setCellPos()

	if self._targetTowerId <= self._towerId and self._targetStarId <= self._starId then
		self._cacheScore = self._curProgressId

		if self._cacheScore >= self._prizeCfg[self._priceCfgCount].needScore then
			local win = goutil.findChild(self._towerViewCon, "tower_Top/win")

			GameUtil.SetActive(win, true)
			self:_playWinEffect()
		end

		removetimer(self._move, self)
		GameUtil.SetActive(self._mask, false)
		UnityTweens.TweenRotate.StopTween(self._player)
		removetimer(self._move, self)
		GameUtil.setLocalRotation(self._player, 0, 0, 0)

		UnityTweens.TweenPosition.StartTween(self._player, Vector3.New(0, 0, 0), Vector3.New(0, 6, 0), 0.6).loopType = UnityTweens.LoopType.pingPong
	end
end

function AdmireMoonView:_setTarget()
	for towerId, towerData in ipairs(self._starDataList) do
		for starId, starScore in ipairs(towerData) do
			if starScore >= self._curProgressId then
				return towerId, starId
			end
		end
	end

	return 0, 0
end

function AdmireMoonView:_setCellPos()
	local parent

	if self._towerId == 0 then
		parent = goutil.findChild(self._towerViewCon, "tower_Down/startPos")

		self._player.transform:SetParent(parent.transform)
		uGuiUtil.setImageGrayStateRecursive(self._player, false)
		GameUtil.setLocalPos(self._player, 0, 0, 0)
		GameUtil.setLocalPos(self._towerViewCon, 0, 0, 0)

		return
	end

	self:_moveCellToCenter()

	parent = self._towerId == 1 and goutil.findChild(self._towerViewCon, "tower_Down/starCon/star_" .. self._starId) or goutil.findChild(self._towerViewCon, "tower_" .. self._towerId - 1 .. "/starCon/star_" .. self._starId)

	self._player.transform:SetParent(parent.transform)

	if self._towerId % 2 == 0 then
		GameUtil.setLocalPos(self._player, -12, 5, 0)
	else
		GameUtil.setLocalPos(self._player, 9, 7, 0)
	end

	uGuiUtil.setImageGrayStateRecursive(parent, false)
end

function AdmireMoonView:_moveCellToCenter()
	if self._towerId > 3 and self._towerId <= self._priceCfgCount then
		local viewConSize = GameUtil.getHeight(self._towerViewCon)
		local viewSize = GameUtil.getHeight(self._towerView)
		local parent
		local offset = GameUtil.getAnchoredPos(self._towerId < self._priceCfgCount and goutil.findChild(self._towerViewCon, "tower_" .. self._towerId) or goutil.findChild(self._towerViewCon, "tower_Top")).y
		local offsetTo = (viewConSize + offset - viewSize * 0.5) * -1
		local startPos = GameUtil.getLocalPos(self._towerViewCon)
		local endPos = Vector3.New(startPos.x, offsetTo, 0)

		UnityTweens.TweenPosition.StartTween(self._towerViewCon, startPos, endPos, 0.6, UnityTweens.EaseType.easeInSine)
	end
end

function AdmireMoonView:_updateCell(view, cell, data)
	local txtLevel = goutil.findChildTextComponent(cell, "txtLevel")
	local btnReceive = goutil.findChildButtonComponent(cell, "btnReceive")
	local receive = goutil.findChild(cell, "received")
	local rewardCon = goutil.findChild(cell, "rewardCon")
	local layout = goutil.findChild(cell, "rewardCon"):GetComponent(ComponentType.UILayoutSingleLine)
	local rewardCell = {}

	for i = 1, 3 do
		local reward = {}

		reward.go = goutil.findChild(cell, "rewardCon/item_" .. i)
		reward.con = goutil.findChild(cell, "rewardCon/item_" .. i .. "/con")
		reward.effect = goutil.findChild(cell, "rewardCon/item_" .. i .. "/effect")

		table.insert(rewardCell, reward)
	end

	local isGainPrize = OpSummaryController.instance:isGainPrize(self._activityId, data.id)
	local isCanGet = self._curProgressId >= data.needScore
	local prizeStr = string.split(data.prize, "#")

	if self._effectRewardList[cell.gameObject] ~= nil then
		self:_removeRewardEffect(cell.gameObject)
	end

	for i, v in ipairs(rewardCell) do
		local prize = prizeStr[i]

		if prize then
			GameUtil.SetActive(rewardCell[i].go, true)
			MaterialMgr.setCellByCfg(prize, rewardCell[i].con)

			if isCanGet and not isGainPrize then
				self:_playRewardEffect(rewardCell[i].effect, cell.gameObject, i)
			end
		else
			GameUtil.SetActive(rewardCell[i].go, false)
			MaterialMgr.resetAll(rewardCell[i].con)
		end
	end

	layout:Layout()

	txtLevel.text = "第" .. data.id .. "层"

	GameUtil.SetActive(btnReceive.gameObject, isCanGet and not isGainPrize)
	GameUtil.SetActive(receive, isGainPrize)
	GameUtil.addClickHandler(btnReceive, GameUtil.handler(self._onClickReceive, self, data.id))
end

function AdmireMoonView:_clearCell(cell)
	self:_removeRewardEffect(cell.gameObject)

	for i = 1, 3 do
		MaterialMgr.resetAll(goutil.findChild(cell, "rewardCon/item_" .. i .. "/con"))
	end
end

function AdmireMoonView:_playIdleEffect()
	local effectPath = "20230929/shangyuetai/fx_ui_shangyuetai.prefab"
	local effect = self:_playEffect(effectPath, self.mainGO, false)

	table.insert(self._effectList, effect)
end

function AdmireMoonView:_playWinEffect()
	local effectPath = "20230929/shangyuetai/fx_ui_shangyuetai_yanhua.prefab"
	local parent = goutil.findChild(self._towerViewCon, "tower_Top/effect")
	local effect = self:_playEffect(effectPath, parent, false)

	table.insert(self._effectList, effect)
end

function AdmireMoonView:_playRewardEffect(parent, cell, id)
	local effectPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	if self._effectRewardList[cell] == nil then
		self._effectRewardList[cell] = {}
	end

	self._effectRewardList[cell][id] = self:_playEffect(effectPath, parent, true)
end

function AdmireMoonView:_playEffect(path, parent, isClip)
	local effect = UIEffectManager.instance:playEffect(self, path, parent, 0, 0, true, nil, nil, function(target, eff)
		if isClip then
			eff:setClipping(self._clippRect)
		end
	end, self)

	effect:setParent(parent.transform)
	effect:setLocalPos(0, 0, 0)
	effect:setScale(1)

	return effect
end

function AdmireMoonView:_removeRewardEffect(cell)
	local effects = self._effectRewardList[cell]

	if effects then
		for _, eff in ipairs(effects) do
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	self._effectRewardList[cell] = nil
end

function AdmireMoonView:_onClickTip()
	TipsFacade.instance:openRulesView("admiremoon_rule")
end

function AdmireMoonView:_onClickReceive(prizeId)
	OpSummaryController.instance:sendPM_GainActivityPluginProgressPrizeReq(self._activityId, self._progressId, prizeId)
end

function AdmireMoonView:_onClickFirework()
	GotoMgr.gotoByString("event#admiremoonview#17126#1")
	self:_sendGetInfoReq()
	self:_refreshStarState()
end

return AdmireMoonView
