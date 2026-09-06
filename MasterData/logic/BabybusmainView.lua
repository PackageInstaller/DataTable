-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/babybus/view/BabybusmainView.lua

module("logic.extensions.babybus.view.BabybusmainView", package.seeall)

local BabybusmainView = class("BabybusmainView", ViewComponent)

function BabybusmainView:ctor()
	BabybusmainView.super.ctor(self)

	self._itemGroups = {}
	self._cacheProgressCellNodes = {}
	self._effectHandlers = {}
	self._indexKey = "curProgressIndex"
	self._progressShowNum = 3
end

function BabybusmainView:unbindEvents()
	BabybusmainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnGoto:RemoveClickListener()
end

function BabybusmainView:bindEvents()
	BabybusmainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnLeft:AddClickListener(self._onClickbtnLeft, self)
	self._btnRight:AddClickListener(self._onClickbtnRight, self)
	self._btnGoto:AddClickListener(self._onClickbtnGoto, self)
end

function BabybusmainView:buildUI()
	BabybusmainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._txtTime = self:getTxt("openTime/txtTime")
	self._progressTablecellGo = self:getGo("progress/tablecell")
	self._progressTableviewGo = self:getGo("progress/tableview")
	self._progressScrollerList = ScrollerList.create(self._progressTableviewGo, self._progressTablecellGo, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))
	self._rwtablecellGo = self:getGo("reward/tablecell")
	self._rwtableviewGo = self:getGo("reward/tableview")
	self._rewardScrollerList = ScrollerList.create(self._rwtableviewGo, self._rwtablecellGo, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._scrollRect = self:getGo("reward/tableview"):GetComponent(ComponentType.ScrollRect)
	self._btnLeft = self:getBtn("progress/btnLeft")
	self._btnRight = self:getBtn("progress/btnRight")
	self._redpointRightGo = self:getGo("progress/btnRight/redpoint")
	self._redpointLeftGo = self:getGo("progress/btnLeft/redpoint")
	self._effectGo = self:getGo("effect")
	self._goRoleTr = self:getGo("progress/goRole").transform
	self._btnGoto = self:getBtn("btnGoto")
	self._redPointBtnGoto = self:getGo("btnGoto/redPoint")
end

function BabybusmainView:onExit()
	BabybusmainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._onEndStory, self)
	GlobalDispatcher:removeListener(BabyBusAgent.BabyBusWalk, self._updateUI, self)
	GlobalDispatcher:removeListener(BabyBusAgent.BabyBusGainPrize, self._updateUI, self)
	self._progressScrollerList:dispose()
	self._rewardScrollerList:dispose()

	for k, v in pairs(self._itemGroups) do
		v:dispose()
	end

	removetimer(self._updateMover, self)

	for k, v in pairs(self._effectHandlers) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._effectHandlers = {}
	self._curProgressIndex = nil

	UIEffectManager.instance:stopEffect(self._effectHandler)
	RedPointController.instance:unregRedPoint(self._redPointBtnGoto)
end

function BabybusmainView:onEnter()
	BabybusmainView.super.onEnter(self)

	self._playingStoryId = 0
	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.BabyBus)

	if self._activityId <= 0 then
		self:close()

		return
	end

	self._baseCfg = BabybusConfig.instance:getBaseCfg(self._activityId)

	self.addGEvent(self, BabyBusAgent.BabyBusGetInfo, self._onBabyBusGetInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.EndStory, self._onEndStory, self)
	GlobalDispatcher:addListener(BabyBusAgent.BabyBusWalk, self._updateUI, self)
	GlobalDispatcher:addListener(BabyBusAgent.BabyBusGainPrize, self._updateUI, self)

	self._progressScrollerListReloaded = false

	self:_setActTime()
	self:_updateUI()
	BabyBusAgent.instance:sendPM_BabyBusGetInfoReq(self._activityId)
	self:_setEffect()
	RedPointController.instance:regRedPoint(self._redPointBtnGoto, 351)
end

function BabybusmainView:_onClickbtnClose()
	if self._isMoving then
		FloatWordMgr.instance:show("正在前进")

		return
	end

	if self._playingStoryId > 0 then
		FloatWordMgr.instance:show("正在播放剧情")

		return
	end

	self:close()
end

function BabybusmainView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("babybus")
end

function BabybusmainView:_onClickbtnLeft()
	if not self._progressScrollerListReloaded then
		return
	end

	self._curProgressIndex = self._curProgressIndex - 1

	if self._curProgressIndex <= 0 then
		self._curProgressIndex = 0
	end

	self._progressScrollerList:MoveCellToBegin(self._curProgressIndex)
	GameUtil.saveUserData(self._indexKey, self._curProgressIndex)
	self:_checkBtnRedpoint()
end

function BabybusmainView:_onClickbtnRight()
	if not self._progressScrollerListReloaded then
		return
	end

	self._curProgressIndex = self._curProgressIndex + 1

	if self._curProgressIndex >= self._maxProgress - self._progressShowNum then
		self._curProgressIndex = self._maxProgress - self._progressShowNum
	end

	self._progressScrollerList:MoveCellToBegin(self._curProgressIndex)
	GameUtil.saveUserData(self._indexKey, self._curProgressIndex)
	self:_checkBtnRedpoint()
end

function BabybusmainView:_onClickbtnGoto()
	GotoMgr.gotoByString("func#690")
end

function BabybusmainView:_setActTime()
	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.BabyBus, self._activityId)
end

function BabybusmainView:_updateUI()
	self._isWalkedToday = BabybusModel.instance:isWalkedToday()
	self._curProgress = BabybusModel.instance:getCurprogress()

	local cfgs = BabybusConfig.instance:getPrizeCfgs(self._baseCfg.prizePlanId)
	local newCfgs = {}
	local firstCfg = {
		progress = 0,
		name = BabybusConfig.instance:getCommonVelue("Xuyuanlin_name"),
		jumpTo = BabybusConfig.instance:getCommonVelue("Xuyuanlin_jumpTo"),
		icon = BabybusConfig.instance:getCommonVelue("Xuyuanlin_icon"),
		redpointId = checknumber(BabybusConfig.instance:getCommonVelue("Xuyuanlin_redpointId"))
	}

	table.insert(newCfgs, firstCfg)
	table.insertto(newCfgs, cfgs)

	self._maxProgress = #newCfgs

	self._progressScrollerList:reloadData(newCfgs)
	self._rewardScrollerList:reloadData(cfgs)

	if self._needMoveBegin then
		self._needMoveBegin = false

		local idx = math.max(self._curProgress, 0)

		self._progressScrollerList:MoveCellToBegin(idx)
	end
end

function BabybusmainView:_updateProgressCell(view, cell, cfg, tag)
	local btnGo = Framework.ButtonAdapter.GetFrom(cell.gameObject, "root/btnGo")
	local goRedPoint = goutil.findChild(cell.gameObject, "root/btnGo/redPoint")
	local goRoot = goutil.findChild(cell.gameObject, "root")
	local goIcon = goutil.findChild(cell.gameObject, "root/icon")
	local txtBtnGo = goutil.findChildTextComponent(cell.gameObject, "root/btnGo/text")
	local rootTr = goutil.findChild(cell.gameObject, "root").transform
	local goRedPointJump = goutil.findChild(cell.gameObject, "root/redPointJump")
	local goRolecon = goutil.findChild(cell.gameObject, "root/rolecon")

	goutil.setActive(goRedPointJump, false)

	local isLock = cfg.progress > self._curProgress
	local needGo = not self._isWalkedToday and self._curProgress + 1 == cfg.progress

	if isLock then
		local spriteName = GameUrl.getBigbgFolderUrl("babybus", "board_sizhounianqinghuodong_02")

		uGuiUtil.setSpriteToImage(goIcon, nil, spriteName, function()
			local img = goIcon:GetComponent(goutil.Type_UIImage)

			img:SetNativeSize()

			img.raycastTarget = false
		end)
	else
		local spriteName = GameUrl.getBigbgFolderUrl("babybus", cfg.icon)

		uGuiUtil.setSpriteToImage(goIcon, nil, spriteName, function()
			local img = goIcon:GetComponent(goutil.Type_UIImage)

			img:SetNativeSize()

			img.raycastTarget = false
		end)
	end

	txtBtnGo.text = needGo and "前往" or "进入" .. cfg.name

	goutil.setActive(goRedPoint, needGo)
	btnGo:AddClickListener(function()
		if self._isMoving then
			return
		end

		if needGo then
			self:_move(cfg)

			return
		end

		if isLock then
			local str = string.format("未满足登录%s天，还未解锁该景点噢~", cfg.progress)

			FloatWordMgr.instance:show(str)

			return
		end

		self:_autoJumpTo(cfg)
	end)
	self:_setProgressLu(cell, cfg)
	self:_setProgressCellPos(rootTr, cell)

	if cfg.redpointId and cfg.redpointId > 0 then
		RedPointController.instance:regRedPoint(goRedPointJump, cfg.redpointId)
	else
		RedPointController.instance:unregRedPoint(goRedPointJump)
	end

	local roleConVisible = false

	if self._curProgress == cfg.progress then
		roleConVisible = true

		self._goRoleTr:SetParent(goRolecon.transform)
		Framework.TransformUtil.SetAnchoredPos(self._goRoleTr, 0, -120)
	end

	goutil.setActive(goRolecon, roleConVisible)
end

function BabybusmainView:_setProgressLu(cell, cfg)
	local goLu = goutil.findChild(cell.gameObject, "root/lu")
	local goLu2 = goutil.findChild(cell.gameObject, "root/lu2")
	local luGos = {}

	goutil.setActive(goLu, false)
	goutil.setActive(goLu2, false)

	if cell.data < self._maxProgress then
		if cell.data % 2 == 0 then
			goLu = goLu2
		end

		goutil.setActive(goLu, true)
	end

	local luGo = goutil.findChild(goLu, "lu1")
	local luIndex = 1

	while luGo do
		luIndex = luIndex + 1
		luGo = goutil.findChild(goLu, "lu" .. luIndex)

		if luGo then
			table.insert(luGos, luGo)
		end
	end

	self._cacheProgressCellNodes[cfg.progress] = {
		rootTr = goLu.transform,
		luGos = luGos
	}
end

function BabybusmainView:_setProgressCellPos(rootTr, cell)
	if cell.data == 1 then
		Framework.TransformUtil.SetAnchoredPos(rootTr, 0, -5)
	elseif cell.data % 2 == 0 then
		Framework.TransformUtil.SetAnchoredPos(rootTr, 0, -80)
	elseif cell.data % 2 == 1 then
		Framework.TransformUtil.SetAnchoredPos(rootTr, -12, 21)
	end
end

function BabybusmainView:_clearProgressCell(cell)
	local goRedPointJump = goutil.findChild(cell.gameObject, "root/redPointJump")
	local goIcon = goutil.findChild(cell.gameObject, "root/icon")

	RedPointController.instance:unregRedPoint(goRedPointJump)
	uGuiUtil.clearImage(goIcon)
end

function BabybusmainView:_playStory()
	if self._playingStoryId and self._playingStoryId > 0 then
		GlobalDispatcher:dispatch(GlobalNotify.StartStory, self._playingStoryId)
	else
		self:_onEndStory(self._playingStoryId, true)
	end
end

function BabybusmainView:_onEndStory(storyId, forceEnd)
	if storyId == self._playingStoryId or forceEnd then
		self._playingStoryId = 0

		if not self._isWalkedToday then
			BabyBusAgent.instance:sendPM_BabyBusWalkReq(self._activityId)
		end

		if self._currMovCfg then
			self:_autoJumpTo(self._currMovCfg)
		end
	end
end

function BabybusmainView:_updateRewardCell(view, cell, cfg, tag)
	local btnExchangeCode = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnExchangeCode")
	local btnReview = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnReview")
	local goRewardcell = goutil.findChild(cell.gameObject, "rewardcell")
	local goRewardcon = goutil.findChild(cell.gameObject, "rewardcon")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local isGain = BabybusModel.instance:isGainPrize(cfg.prizeId)
	local isCanGain = BabybusModel.instance:isCanGainPrize(cfg.prizeId, cfg.progress)

	txtName.text = string.format("第%s站\n%s", cell.data, cfg.name)

	goutil.setActive(btnReview.gameObject, isGain and cfg.storyId > 0)
	self:_setReward(goRewardcon, goRewardcell, cfg, isGain, isCanGain)
	btnReview:AddClickListener(function()
		GlobalDispatcher:dispatch(GlobalNotify.StartStory, cfg.storyId)
	end)

	local code = BabybusModel.instance:getExchangeCode(cfg.prizeId)

	goutil.setActive(btnExchangeCode.gameObject, isGain and not string.nilorempty(code))
	btnExchangeCode:AddClickListener(function()
		UIStateManager.instance:push(ViewName.BabybuscodetipView, code)
	end)
end

function BabybusmainView:_setReward(goRewardcon, goRewardcell, cfg, isGain, isCanGain)
	local layoutComp = goRewardcon:GetComponent(ComponentType.UILayoutSingleLine)
	local list = string.split(cfg.prize, "#")
	local itemGroup = self._itemGroups[goRewardcon]

	if not itemGroup then
		itemGroup = ItemGroup.New(goRewardcon, goRewardcell, nil, nil, true, self._disposeItem, self)
		self._itemGroups[goRewardcon] = itemGroup
	end

	itemGroup:updateWithMoArray(list, function(item, cfgStr)
		local conGo = goutil.findChild(item.mainGO, "con")
		local effectGo = goutil.findChild(item.mainGO, "effect")
		local gouGo = goutil.findChild(item.mainGO, "gou")

		goutil.setActive(gouGo, isGain)

		local proxy = MaterialMgr.setCellByCfg(cfgStr, conGo)

		proxy.binder:setAutoTips(not isCanGain)

		if isCanGain then
			proxy.binder:setCallBack(function()
				BabybusController.instance:sendPM_BabyBusGainPrizeReq(self._activityId, cfg.prizeId)
			end)
		else
			proxy.binder:setCallBack(nil)
		end

		goutil.setActive(effectGo, isCanGain)

		if isCanGain then
			local handler = self._effectHandlers[effectGo]

			if not handler then
				handler = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", nil, nil, nil, true, nil, nil, function()
					handler:setScrollRectClipping(self._scrollRect)
				end)
				self._effectHandlers[effectGo] = handler
			end

			handler:setParent(effectGo.transform)
			handler:setScale(0.7)
			handler:setLocalPos(0, 0, 0)
		end
	end)
	layoutComp:Layout()
end

function BabybusmainView:_disposeItem(item)
	local conGo = goutil.findChild(item.mainGO, "con")

	MaterialMgr.resetAll(conGo)
end

function BabybusmainView:_clearRewardCell(cell)
	return
end

function BabybusmainView:_initCurrProgressIndex()
	self._curProgressIndex = self._curProgressIndex or GameUtil.getUserData(self._indexKey)
	self._curProgressIndex = self._curProgressIndex or self._curProgress

	GameUtil.saveUserData(self._indexKey, self._curProgressIndex)
	self:_checkBtnRedpoint()
end

function BabybusmainView:_checkBtnRedpoint()
	if self._isWalkedToday then
		goutil.setActive(self._redpointLeftGo, false)
		goutil.setActive(self._redpointRightGo, false)

		return
	end

	local todayProgress = self._curProgress + 1
	local inRight = todayProgress > self._curProgressIndex + self._progressShowNum - 1

	goutil.setActive(self._redpointRightGo, inRight)

	local inLeft = todayProgress < self._curProgressIndex

	goutil.setActive(self._redpointLeftGo, inLeft)
end

function BabybusmainView:_setEffect()
	local effName = "20230331/shizhounianfuli/fx_ui_shizhounianfuli_fw.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

function BabybusmainView:_autoJumpTo(cfg)
	if not string.nilorempty(cfg.jumpTo) then
		GotoMgr.gotoByString(cfg.jumpTo)

		if cfg.behaviorId then
			SurveyController.instance:reportBehavior(cfg.behaviorId)
		end
	end
end

function BabybusmainView:_move(cfg)
	self._mover = {
		speed = 120,
		t = 0,
		currentWaypointIndex = 1,
		position = {
			x = 0,
			y = 0
		},
		waypoints = {}
	}

	local luGos = self._cacheProgressCellNodes[cfg.progress - 1].luGos
	local posx, posy = Framework.TransformUtil.GetLocalPos(luGos[1].transform, 0, 0, 0)

	self._mover.position.x = posx
	self._mover.position.y = posy
	self._mover.parent = self._cacheProgressCellNodes[cfg.progress - 1].rootTr

	for i, v in ipairs(luGos) do
		posx, posy = Framework.TransformUtil.GetLocalPos(v.transform, 0, 0, 0)

		table.insert(self._mover.waypoints, {
			x = posx,
			y = posy
		})
	end

	self._isMoving = true
	self._playingStoryId = cfg.storyId
	self._currMovCfg = cfg

	settimer(0, self._updateMover, self, true)
	self:_updateMover()
end

function BabybusmainView:_updateMover()
	local dt = Time.deltaTime
	local mover = self._mover
	local currentWaypoint = mover.waypoints[mover.currentWaypointIndex]
	local nextWaypoint = mover.waypoints[mover.currentWaypointIndex + 1]

	if nextWaypoint then
		mover.t = mover.t + mover.speed * dt / math.sqrt((nextWaypoint.x - currentWaypoint.x)^2 + (nextWaypoint.y - currentWaypoint.y)^2)

		if mover.t >= 1 then
			mover.t = 0
			mover.currentWaypointIndex = mover.currentWaypointIndex + 1
			mover.position.x = nextWaypoint.x
			mover.position.y = nextWaypoint.y
		else
			mover.position.x = self:_lerp(currentWaypoint.x, nextWaypoint.x, mover.t)
			mover.position.y = self:_lerp(currentWaypoint.y, nextWaypoint.y, mover.t)
		end

		self._goRoleTr:SetParent(mover.parent)
		Framework.TransformUtil.SetLocalPos(self._goRoleTr, mover.position.x, mover.position.y, 0)
	else
		removetimer(self._updateMover, self)

		self._isMoving = false

		self:_playStory()
	end
end

function BabybusmainView:_lerp(a, b, t)
	return a + (b - a) * t
end

function BabybusmainView:_onBabyBusGetInfo()
	self._needMoveBegin = true

	self:_updateUI()
end

return BabybusmainView
