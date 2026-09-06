-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessmissionextView.lua

module("logic.extensions.autochess.view.AutochessmissionextView", package.seeall)

local AutochessmissionextView = class("AutochessmissionextView", BaseLuaOnce)

function AutochessmissionextView:ctor(go)
	AutochessmissionextView.super.ctor(self, go)

	self._upEffectHandlers = {}
	self._starUpEffectHandlers = {}
	self._recommendEffectHandlers = {}
	self._animTime = 2
end

function AutochessmissionextView:unbindEvents()
	AutochessmissionextView.super.unbindEvents(self)
	self._btnRefresh:RemoveClickListener()
	self._btnLock:RemoveClickListener()
	DropHandler.Get(self._dropThrowAwayAreaGo.gameObject):RemoveLuaHandler(self._onDropBgHandler)
	self._btnBuffs:RemoveClickListener()
	self._btnTeam:RemoveClickListener()
	self._MaskBlock:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function AutochessmissionextView:bindEvents()
	AutochessmissionextView.super.bindEvents(self)
	self._btnRefresh:AddClickListener(self._onClickbtnRefresh, self)
	self._btnLock:AddClickListener(self._onClickbtnLock, self)

	self._onDropBgHandler = DropHandler.Get(self._dropThrowAwayAreaGo.gameObject):AddLuaHandler(function(go, eventData)
		self:_OnDropBg()
	end)

	self._btnBuffs:AddClickListener(self._onClickbtnBuffs, self)
	self._btnTeam:AddClickListener(self._onClickbtnTeam, self)
	self._MaskBlock:AddClickListener(self._onClickMaskBlock, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function AutochessmissionextView:buildUI()
	AutochessmissionextView.super.buildUI(self)

	self._playercellGo = self:getGo("playercell")
	self._playerconGo = self:getGo("playercon")
	self._goodsconGo = self:getGo("goodspart/goodscon")
	self._goodscellGo = self:getGo("goodspart/goodscell")
	self._txtCoin = self:getTxt("coinbg/txtCoin")
	self._txtRefreshCost = self:getTxt("goodspart/btnRefresh/txtRefreshCost")
	self._btnRefresh = self:getBtn("goodspart/btnRefresh")
	self._goodsItemGroup = ItemGroup.New(self._goodsconGo, self._goodscellGo, nil, nil, true, self._clearGoodsCell, self)
	self._onGo = self:getGo("goodspart/btnLock/on")
	self._offGo = self:getGo("goodspart/btnLock/off")
	self._btnLock = self:getBtn("goodspart/btnLock")

	goutil.setActive(self._playercellGo, false)
	goutil.setActive(self._goodscellGo, false)

	self._singleLinePlayer = self:getGo("playercon"):GetComponent(ComponentType.UILayoutSingleLine)
	self._singleLineGoods = self:getGo("goodspart/goodscon"):GetComponent(ComponentType.UILayoutSingleLine)
	self._dropThrowAwayAreaGo = self:getGo("dropThrowAwayArea")
	self._txtSellMoney = self:getTxt("dropThrowAwayArea/txtSellMoney")
	self._txtRound = self:getTxt("txtRound")
	self._txtKjLv = self:getTxt("txtKjLv")
	self._btnBuffs = self:getBtn("btnBuffs")
	self._btnTeam = self:getBtn("fetterpart/btnTeam")
	self._fettertableviewGo = self:getGo("fetterpart/tableview")
	self._fettertablecellGo = self:getGo("fetterpart/tablecell")
	self._fetterScrollerList = ScrollerList.create(self._fettertableviewGo, self._fettertablecellGo, GameUtil.handler(self._updateFetterCell, self), GameUtil.handler(self._clearFetterCell, self))
	self._txtTime = self:getTxt("txtTime")
	self._btnTeamGo = self:getGo("fetterpart/btnTeam")
	self._goodspartGo = self:getGo("goodspart")
	self._MaskBlock = self:getBtn("MaskBlock")
	self._maskBlockGo = self._MaskBlock.gameObject
	self._btnClose = self:getBtn("btnClose")
	self._fetterEmptyGo = self:getGo("fetterpart/empty")
	self._txtTeamName = self:getTxt("fetterpart/txtTeamName")
	self._timeNumGo = self:getGo("timeNum"):GetComponent(ComponentType.UIImgNumeralText)

	goutil.setActive(self._dropThrowAwayAreaGo, false)
	goutil.setActive(self._goodspartGo, true)

	self._huiheEffectGo = self:getGo("topImg/huiheEffect")
	self._shenzhuangEffectGo = self:getGo("btnBuffs")
end

function AutochessmissionextView:onExit()
	AutochessmissionextView.super.onExit(self)
	self._goodsItemGroup:dispose()

	self._missionViewRef = nil

	removetimer(self._tick, self)
	self._fetterScrollerList:dispose()
	uGuiUtil.clearImage(self._btnTeamGo)

	if self._huiheeffectHandler then
		UIEffectManager.instance:stopEffect(self._huiheeffectHandler)
	end

	self._huiheeffectHandler = nil

	if self._shenzhuangeffectHandler then
		UIEffectManager.instance:stopEffect(self._shenzhuangeffectHandler)
	end

	self._shenzhuangeffectHandler = nil

	if self._enemyeffectHandler then
		UIEffectManager.instance:stopEffect(self._enemyeffectHandler)
	end

	self._enemyeffectHandler = nil

	removetimer(self._moveFinish, self)

	for i = 1, self._playerconGo.transform.childCount do
		local go = self._playerconGo.transform:GetChild(i - 1).gameObject

		self:_clearPlayerCell(go)
	end
end

function AutochessmissionextView:onEnter(missionViewRef, viewPresentor)
	AutochessmissionextView.super.onEnter(self)

	self._firstPlayerAnim = true
	self._missionViewRef = missionViewRef
	self._viewPresentor = viewPresentor

	self.addGEvent(self, AutoChessAgent.ACNotifyRefreshPetShopRes, self._onACRefreshShopRes, self)
	self.addGEvent(self, AutoChessAgent.ACLockShopRes, self._onACLockShopRes, self)
	self.addGEvent(self, AutoChessAgent.ACNotifyRefreshPetShopRes, self._updateGoods, self)
	self.addGEvent(self, AutoChessAgent.ACNotifyAfterPetChangedRes, self._updateGoods, self)
	self.addGEvent(self, GlobalNotify.FormationBeginDragSeat, self._onFormationBeginDragSeat, self)
	self.addGEvent(self, GlobalNotify.FormationEndDragSeat, self._onFormationEndDragSeat, self)
	self.addGEvent(self, GlobalNotify.FormationDragBegin, self._onFormationBeginDragSeat, self)
	self.addGEvent(self, GlobalNotify.FormationDropBag, self._onFormationEndDragSeat, self)
	self.addGEvent(self, AutoChessAgent.ACNotifyNextRoundRes, self._onACNotifyNextRoundRes, self)
	self.addGEvent(self, GlobalNotify.FormationPosChanged, self._onFormationPosChanged, self)

	self._activityId = AutochessModel.instance:getActivityId()

	self:_loadRoundData()
	self:_startTick()
	self:_updateUI()
	goutil.setActive(self._maskBlockGo, false)
	self:_setHuiHeEffect()
	self:_setShenzhuangEffect()
end

function AutochessmissionextView:_onClickbtnRefresh()
	local shop = AutochessModel.instance:getPetShop()
	local myMoney = shop.myMoney

	if myMoney < self._refreshCost then
		FloatWordMgr.instance:show("金币不足")

		return
	end

	AutoChessAgent.instance:sendPM_ACRefreshShopReq()
end

function AutochessmissionextView:_onClickbtnLock()
	local shop = AutochessModel.instance:getPetShop()

	AutoChessAgent.instance:sendPM_ACLockShopReq(not shop.locked)
end

function AutochessmissionextView:_onACRefreshShopRes()
	self:_setRefreshCost()
end

function AutochessmissionextView:_onACLockShopRes()
	self:_updateGoods()
end

function AutochessmissionextView:_updateUI()
	self:_updatePlayers()
	self:_updateGoods()
	self:_setRefreshCost()
	self:_updateFetter()
	self:_setTeamIcon()
end

function AutochessmissionextView:_updatePlayers(ignore)
	self._myUserId = RoleModel.instance:getUserId()
	self._players = AutochessModel.instance:getPlayers()
	self._players = self:_changePlayersAnSetAnimParams(self._players, ignore)
	self._decHp = AutochessModel.instance:getDecHp()

	local itemGos = {}
	local needCnt = #self._players
	local childCount = self._playerconGo.transform.childCount

	if childCount < needCnt then
		for i = childCount + 1, needCnt do
			goutil.cloneAndSetParent(self._playercellGo, self._playerconGo.transform)
		end
	end

	for i = 1, self._playerconGo.transform.childCount do
		local go = self._playerconGo.transform:GetChild(i - 1).gameObject

		goutil.setActive(go, false)
		table.insert(itemGos, go)
	end

	for i, v in ipairs(self._players) do
		local player = self._players[i]
		local go = itemGos[i]

		goutil.setActive(go, true)
		self:_updatePlayerCell(go, player, i)
	end

	self._singleLinePlayer:Layout()
	self:_playChangeRankAnim()
end

function AutochessmissionextView:_changePlayersAnSetAnimParams(players, ignore)
	if not self._firstPlayerAnim or ignore then
		return players
	end

	self._firstPlayerAnim = false

	local newPlayers
	local lastRank = AutochessModel.instance:getLastRank()

	self._hasChangeAnim = false
	self._changeAnimLastItem = false
	self._changeAnimCurrItem = false

	if lastRank > 0 and self._players[i] and self._players[i].headInfo.userId ~= self._myUserId then
		newPlayers = {}

		local myCurrRank = -1

		for i, v in ipairs(self._players) do
			if v.headInfo.userId == self._myUserId then
				myCurrRank = i
			end

			newPlayers[i] = v
		end

		if myCurrRank > 0 then
			newPlayers[lastRank], newPlayers[myCurrRank] = newPlayers[myCurrRank], newPlayers[lastRank]
			self._hasChangeAnim = true
			self._changeAnimLastRank = lastRank
			self._changeAnimCurrRank = myCurrRank
		end
	end

	return newPlayers or players
end

function AutochessmissionextView:_updatePlayerCell(mainGO, player, index)
	local goHead = goutil.findChild(mainGO, "head")
	local goMyTag = goutil.findChild(mainGO, "myTag")
	local goSelect = goutil.findChild(mainGO, "select")
	local txtHp = goutil.findChildTextComponent(mainGO, "hpbg/txtHp")
	local txtRank = goutil.findChildTextComponent(mainGO, "rank")
	local isMe = self._myUserId == player.headInfo.userId

	HeadItemController.instance:resetHeadCell(goHead)

	local proxy = HeadItemController.instance:setHeadCell(goHead, player.headInfo.headIconId, 0, 0)

	proxy.binder:setAutoTips(false)
	proxy.binder:setCallBack(function()
		UIStateManager.instance:push(ViewName.AutochessplayertipsView, player, goHead)
	end)

	local hp = player.hp

	if hp < 0 then
		hp = 0
	end

	GameUtil.SetGray(goHead, hp <= 0)

	txtHp.text = isMe and self._decHp > 0 and string.format("<color=%s>-%s</color>(%s)", GameEnum.ColorConst.Red, self._decHp, hp) or hp
	txtRank.text = index

	goutil.setActive(goSelect, false)
	goutil.setActive(goMyTag, isMe)

	local isBattleEnemy = player.headInfo.userId == AutochessModel.instance:getEnemyUserId()

	self:_playEnemyEffect(mainGO, isBattleEnemy)

	if self._hasChangeAnim and self._changeAnimLastRank == index then
		self._changeAnimLastItem = mainGO
	end

	if self._hasChangeAnim and self._changeAnimCurrRank == index then
		self._changeAnimCurrItem = mainGO
	end
end

function AutochessmissionextView:_clearPlayerCell(mainGO)
	local goHead = goutil.findChild(mainGO, "head")

	HeadItemController.instance:resetHeadCell(goHead)
	GameUtil.SetGray(goHead, false)
end

function AutochessmissionextView:_playChangeRankAnim()
	if not self._hasChangeAnim then
		return
	end

	self._hasChangeAnim = false

	if self._changeAnimLastItem and self._changeAnimCurrItem then
		self._changeAnimLastItem.transform:SetAsLastSibling()
		self._changeAnimCurrItem.transform:SetAsLastSibling()
		self:_setMoveParams(self._changeAnimLastItem, self._changeAnimCurrItem)
		self:_setMoveParams(self._changeAnimCurrItem, self._changeAnimLastItem)

		local tween1 = self._changeAnimLastItem:GetComponent(UnityTweensType.TweenPosition)
		local tween2 = self._changeAnimCurrItem:GetComponent(UnityTweensType.TweenPosition)

		tween1.time = self._animTime
		tween2.time = self._animTime

		tween1:Begin()
		tween2:Begin()
		settimer(self._animTime, self._moveFinish, self, false)
	end
end

function AutochessmissionextView:_moveFinish()
	self:_updatePlayers(true)
end

function AutochessmissionextView:_setMoveParams(formitem, toitem)
	local tween = formitem:GetComponent(UnityTweensType.TweenPosition)
	local v3 = Vector3.New(0, 0, 0)
	local x, y = Framework.TransformUtil.GetAnchoredPos(formitem.transform, 0, 0)

	v3.x = x
	v3.y = y
	tween.from = v3

	local x, y = Framework.TransformUtil.GetAnchoredPos(toitem.transform, 0, 0)

	v3.x = x
	v3.y = y
	tween.to = v3
end

function AutochessmissionextView:_updateGoods()
	local shop = AutochessModel.instance:getPetShop()

	self._goodsLocked = shop.locked

	goutil.setActive(self._onGo, not shop.locked)
	goutil.setActive(self._offGo, shop.locked)
	goutil.setActive(self._btnRefresh.gameObject, not shop.locked)

	self._txtCoin.text = shop.myMoney
	self._goods = shop.index

	self._goodsItemGroup:updateWithMoArray(self._goods, function(item, goods)
		self:_updateGoodsCell(item, goods)
	end)
	self._singleLineGoods:Layout()
end

function AutochessmissionextView:_updateGoodsCell(item, goods)
	local cell = item.mainGO
	local btnDetail = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnDetail")
	local btnBuy = Framework.ButtonAdapter.Get(cell.gameObject)
	local goCon = goutil.findChild(cell.gameObject, "mask/con")
	local goLock = goutil.findChild(cell.gameObject, "lock")
	local goBuy = goutil.findChild(cell.gameObject, "buy")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "name/txtName")
	local txtCost = goutil.findChildTextComponent(cell.gameObject, "cost/txtCost")
	local costGo = goutil.findChild(cell.gameObject, "cost")
	local txtTip = goutil.findChildTextComponent(item.mainGO, "tip/txtTip")
	local goTip = goutil.findChild(item.mainGO, "tip")
	local goEffect = goutil.findChild(item.mainGO, "effect")
	local goAttr = goutil.findChild(cell.gameObject, "attr/Img_attr")
	local attrIcon = goAttr:GetComponent("UIImageSpriteChange")
	local starRoot = goutil.findChild(cell.gameObject, "star")
	local upTagGo = goutil.findChild(cell.gameObject, "star/upTag")
	local starGos = {}

	for i = 1, AutochessController.MaxStarNum do
		starGos[i] = goutil.findChild(starRoot, "star" .. i)
	end

	local creepsId = self:_getCreepsId(goods.raceId)
	local creepsCfg = AutochessConfig.instance:getCreepsCfg(creepsId)
	local targetValue = AutochessController.instance:getAttrIconIndex(creepsCfg.raceId)

	attrIcon:SetState(targetValue)
	goutil.setActive(goBuy, goods.bought)
	goutil.setActive(costGo, not goods.bought)
	goutil.setActive(goLock, self._goodsLocked)

	txtCost.text = AutochessConfig.instance:getBuyCost(goods.raceId)

	local modelCo = CharacterConfig.instance:getModelCo(creepsCfg.raceId)

	uGuiUtil.setSpriteToImage(goCon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	local cardCfg = AutochessConfig.instance:getCardCfg(goods.raceId)
	local isRecommend = not string.nilorempty(cardCfg.tip)

	txtTip.text = cardCfg.tip

	goutil.setActive(goTip, isRecommend)
	btnDetail:AddClickListener(function()
		local petMo = AutochessModel.instance:getPet(creepsCfg.creepsId)

		CommonTipsMgr.instance:showPetTips(petMo)
	end)
	btnBuy:AddClickListener(function()
		if goods.bought then
			FloatWordMgr.instance:show("已购买")

			return
		end

		if self._goodsLocked then
			FloatWordMgr.instance:show("已上锁")

			return
		end

		local isOk = self:_checkCostEnough(goods.raceId)

		if not isOk then
			FloatWordMgr.instance:show("金币不足")

			return
		end

		local maxStar = AutochessConfig.instance:getRaceIdMaxStar(goods.raceId)
		local starData = AutochessModel.instance:getIndexShopStarData(goods.index)

		if starData then
			if not starData.star then
				local star = 0

				if star > 0 and maxStar <= star then
					FloatWordMgr.instance:show("该精灵已满星")

					return
				end

				self:_onClickBuyPet(goods.index, goods.raceId)
			end
		end
	end)
	self:_setStar(goods.raceId, goods.index, starGos, upTagGo)
	self:_setRecommendEffect(goEffect, isRecommend)
end

function AutochessmissionextView:_clearGoodsCell(item)
	local upTagGo = goutil.findChild(item.mainGO, "star/upTag")
	local goEffect = goutil.findChild(item.mainGO, "effect")
	local handler = self._upEffectHandlers[upTagGo]

	if handler then
		UIEffectManager.instance:stopEffect(handler)

		self._upEffectHandlers[upTagGo] = nil
	end

	local handler = self._starUpEffectHandlers[upTagGo]

	if handler then
		UIEffectManager.instance:stopEffect(handler)

		self._starUpEffectHandlers[upTagGo] = nil
	end

	local handler = self._recommendEffectHandlers[goEffect]

	if handler then
		UIEffectManager.instance:stopEffect(handler)

		self._recommendEffectHandlers[goEffect] = nil
	end
end

function AutochessmissionextView:_getCreepsId(raceId)
	local num = self:_getNum(raceId)
	local initStarLevel = AutochessConfig.instance:getInitStarLevel(raceId)
	local nextStarNum = num + initStarLevel
	local cfg = AutochessConfig.instance:getCreepsCfgByStarLevel(raceId, nextStarNum)

	return cfg.creepsId
end

function AutochessmissionextView:_getNum(raceId)
	local list = AutochessModel.instance:getPetInfoList()

	return list[raceId] and 1 or 0
end

function AutochessmissionextView:_checkCostEnough(raceId)
	local cost = AutochessConfig.instance:getBuyCost(raceId)
	local shop = AutochessModel.instance:getPetShop()

	return cost <= shop.myMoney
end

function AutochessmissionextView:_onClickBuyPet(index, raceId)
	local infoList = AutochessModel.instance:getPetInfoList()
	local cnt = table.nums(infoList)

	if cnt >= AutochessConfig.instance:getPackageLimit(self._activityId) and not infoList[raceId] then
		FloatWordMgr.instance:show("精灵背包达到上限")

		return
	end

	AutochessController.instance:sendPM_ACBuyPetReq(index, raceId)
end

function AutochessmissionextView:_onClickbtnBuffs()
	UIStateManager.instance:push(ViewName.AutochessbuffshowView)
end

function AutochessmissionextView:_onClickbtnTeam()
	local initBuffId = AutochessModel.instance:getInitBuffId()
	local initBuffCfg = AutochessConfig.instance:getInitBuffCfg(initBuffId)
	local data = BufftipsView.getBuffTipSimpleData(initBuffCfg.name, initBuffCfg.buffDesc, initBuffCfg.iconPath)

	CommonTipsMgr.instance:openBuffTipView(data, self._btnTeam.gameObject)
end

function AutochessmissionextView:_onClickMaskBlock()
	FloatWordMgr.instance:show("请等待")
end

function AutochessmissionextView:_onClickbtnClose()
	local text = "确定要退出吗？"

	TipsFacade.instance:openPopupWindow("提示", text, function()
		self:_realClose()
	end)
end

function AutochessmissionextView:_realClose()
	BattleSettlementModel.instance:onReset()
	AutoChessAgent.instance:sendPM_ACLeaveGameReq(self._activityId)
end

function AutochessmissionextView:_tick()
	local leftTime = self._targetTickTime - ServerTime.now()

	self._timeNumGo:SetNum(leftTime)

	if leftTime <= 0 then
		self._timeNumGo:SetNum(0)
		removetimer(self._tick, self)
		self._missionViewRef:_onClickStart()
		goutil.setActive(self._maskBlockGo, true)
	end
end

function AutochessmissionextView:_setRefreshCost()
	local initBuffId = AutochessModel.instance:getInitBuffId()
	local initBuffCfg = AutochessConfig.instance:getInitBuffCfg(initBuffId)
	local cost = AutochessConfig.instance:getRefreshShopMoney(self._activityId)

	if initBuffCfg.type == "RefreshDiscounts" then
		local times = AutochessModel.instance:getRoundRefreshTimes()

		if times <= 0 then
			cost = 0
		end
	end

	self._refreshCost = cost
	self._txtRefreshCost.text = cost
end

function AutochessmissionextView:_OnDropBg(go, eventData)
	local leftView = self._viewPresentor:getViewByName("AutochessFmtLeftView")

	if leftView._dragSeat then
		local petId = leftView._dragSeat:GetData()

		if leftView._dragSeat:IsOpen() and petId > 0 then
			self:_sellPet(leftView._dragSeat:getPetMo())
		end
	end

	local rightView = self._viewPresentor:getViewByName("AutochessFmtRightView")

	if rightView._dragging and rightView._dragingGo then
		local pet = ItemPet.Get(rightView._dragingGo):GetData()

		if pet then
			self:_sellPet(pet)
		end
	end
end

function AutochessmissionextView:_sellPet(petMo)
	local petInfos = AutochessModel.instance:getPetInfoList()
	local star = petInfos[petMo.raceId]

	AutochessController.instance:sendPM_ACSellPetReq(petMo.raceId, star)
end

function AutochessmissionextView:_onFormationBeginDragSeat()
	local raceId = 0
	local leftView = self._viewPresentor:getViewByName("AutochessFmtLeftView")

	if leftView._dragSeat then
		local petId = leftView._dragSeat:GetData()

		if leftView._dragSeat:IsOpen() and petId > 0 then
			raceId = leftView._dragSeat:getPetMo().raceId
		end
	end

	local rightView = self._viewPresentor:getViewByName("AutochessFmtRightView")

	if rightView._dragging and rightView._dragingGo then
		local pet = ItemPet.Get(rightView._dragingGo):GetData()

		if pet then
			raceId = pet.raceId
		end
	end

	local petInfos = AutochessModel.instance:getPetInfoList()
	local star = petInfos[raceId]

	if star then
		self:_showSellPart(star)
	end
end

function AutochessmissionextView:_onFormationEndDragSeat()
	goutil.setActive(self._goodspartGo, true)
	goutil.setActive(self._dropThrowAwayAreaGo, false)
end

function AutochessmissionextView:_onACNotifyNextRoundRes()
	goutil.setActive(self._maskBlockGo, false)
	self:_loadRoundData()
	self:_startTick()
	self:_updateGoods()
	self:_updatePlayers()
end

function AutochessmissionextView:_loadRoundData()
	self._roundId = AutochessModel.instance:getRoundId()

	local roundCfg = AutochessConfig.instance:getRoundCfg(self._roundId)

	self._formationNum = roundCfg.formationNum
	self._targetTickTime = roundCfg.phaseTimeSec + ServerTime.now()
	self._txtRound.text = string.format("第%s轮", self._roundId)
	self._txtKjLv.text = string.format("科技等级：%s", roundCfg.scienceLevel)
end

function AutochessmissionextView:_startTick()
	local isBuffRound = AutochessModel.instance:getIsBuffRound()

	if not isBuffRound then
		settimer(1, self._tick, self, true)
		self:_tick()
	end
end

function AutochessmissionextView:_onFormationPosChanged()
	self:_updateFetter()
end

function AutochessmissionextView:_getCurFormation()
	return AutochessModel.instance:getCurrFormation()
end

function AutochessmissionextView:_getCurPositions()
	return self:_getCurFormation():GetPositions()
end

function AutochessmissionextView:_updateFetter()
	local positions = self:_getCurPositions()
	local creepsIds = {}

	for i, petId in ipairs(positions) do
		if petId > 0 then
			table.insert(creepsIds, petId)
		end
	end

	local fetters = AutochessController.instance:getFetterDatas(creepsIds)

	goutil.setActive(self._fetterEmptyGo, #fetters <= 0)
	self._fetterScrollerList:reloadData(fetters)
end

function AutochessmissionextView:_updateFetterCell(view, cell, data, tag)
	local goIcon = goutil.findChild(cell.gameObject, "icon")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")
	local txtNumDesc = goutil.findChildTextComponent(cell.gameObject, "txtNumDesc")
	local btnIcon = Framework.ButtonAdapter.GetFrom(cell.gameObject, "icon")
	local iconChange = btnIcon.gameObject:GetComponent(ComponentType.UIImageSpriteChange)
	local fettersBuffCfg = AutochessConfig.instance:getFettersBuffCfg(data.fettersId, data.num)

	fettersBuffCfg = fettersBuffCfg or AutochessConfig.instance:getFettersCfg(data.fettersId)
	txtNum.text = data.num
	txtName.text = fettersBuffCfg.name
	txtNumDesc.text = data.numDesc

	iconChange:ChangeSprite(fettersBuffCfg.iconPath)
	btnIcon:AddClickListener(function()
		UIStateManager.instance:push(ViewName.AutochessfettertipsView, fettersBuffCfg.fettersId, goIcon)
	end)
end

function AutochessmissionextView:_clearFetterCell(cell)
	return
end

function AutochessmissionextView:_setTeamIcon()
	local buffId = AutochessModel.instance:getInitBuffId()
	local cfg = AutochessConfig.instance:getInitBuffCfg(buffId)
	local spriteName = string.format("ui/icon/%s.png", cfg.iconPath)

	uGuiUtil.setSpriteToImage(self._btnTeamGo, nil, spriteName)

	self._txtTeamName.text = cfg.name
end

function AutochessmissionextView:_setStar(raceId, index, starGos, upTagGo)
	local starData = AutochessModel.instance:getIndexShopStarData(index)
	local star = starData.star
	local nextStar = star
	local hasBuy = star >= 0
	local maxStar = AutochessConfig.instance:getRaceIdMaxStar(raceId)

	if hasBuy then
		nextStar = star + 1
	else
		star = AutochessConfig.instance:getInitStarLevel(raceId)
		nextStar = star
	end

	local showUp = star < maxStar and star < nextStar and nextStar <= AutochessController.MaxStarNum

	goutil.setActive(upTagGo, showUp)

	for i = 1, AutochessController.MaxStarNum do
		goutil.setActive(starGos[i], i <= nextStar)
	end

	self:_setUpffect(upTagGo, showUp, nextStar, starGos[nextStar])
end

function AutochessmissionextView:_setUpffect(goEffect, showUp, nextStar, starGo)
	local handler = self._upEffectHandlers[goEffect]

	if handler then
		UIEffectManager.instance:stopEffect(handler)

		self._upEffectHandlers[goEffect] = nil
	end

	local handler = self._starUpEffectHandlers[goEffect]

	if handler then
		UIEffectManager.instance:stopEffect(handler)

		self._starUpEffectHandlers[goEffect] = nil
	end

	if not showUp then
		return
	end

	local effName = "20230728/zizouqi/fx_ui_zizouqi_jiantou.prefab"

	handler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	handler:setParent(goEffect.transform)
	handler:setScale(1)
	handler:setLocalPos(0, 0, 0)

	self._upEffectHandlers[goEffect] = handler

	if starGo then
		local effName = "20230728/zizouqi/fx_ui_zizouqi_xingxingshanshuo.prefab"
		local handler1 = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

		handler1:setParent(starGo.transform)
		handler1:setScale(1)
		handler1:setLocalPos(0, 0, 0)

		self._starUpEffectHandlers[goEffect] = handler1
	end
end

function AutochessmissionextView:_setRecommendEffect(goEffect, isRecommend)
	local handler = self._recommendEffectHandlers[goEffect]

	if handler then
		UIEffectManager.instance:stopEffect(handler)

		self._recommendEffectHandlers[goEffect] = nil
	end

	if not isRecommend then
		return
	end

	local effName = "20230728/zizouqi/fx_ui_zizouqi_tuijianjingling.prefab"

	handler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	handler:setParent(goEffect.transform)
	handler:setScale(1)
	handler:setLocalPos(0, 0, 0)

	self._recommendEffectHandlers[goEffect] = handler
end

function AutochessmissionextView:_showSellPart(star)
	local num = AutochessConfig.instance.instance:getSellMoney(star)
	local initBuffId = AutochessModel.instance:getInitBuffId()
	local initBuffCfg = AutochessConfig.instance:getInitBuffCfg(initBuffId)

	if initBuffCfg.type == "Sell" then
		num = num + checknumber(initBuffCfg.param)
	end

	self._txtSellMoney.text = num

	goutil.setActive(self._goodspartGo, false)
	goutil.setActive(self._dropThrowAwayAreaGo, true)
end

function AutochessmissionextView:_setHuiHeEffect()
	local effName = "20230728/zizouqi/fx_ui_zizouqi_huihe.prefab"

	self._huiheeffectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._huiheeffectHandler:setParent(self._huiheEffectGo.transform)
	self._huiheeffectHandler:setScale(1)
	self._huiheeffectHandler:setLocalPos(0, -30, 0)
end

function AutochessmissionextView:_setShenzhuangEffect()
	if self._shenzhuangeffectHandler then
		UIEffectManager.instance:stopEffect(self._shenzhuangeffectHandler)

		self._shenzhuangeffectHandler = nil
	end

	if not AutochessModel.instance:getShowBtnEquipEffect() then
		return
	end

	local effName = "20230728/zizouqi/fx_ui_zizouqi_shenzhuanganniu.prefab"

	self._shenzhuangeffectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._shenzhuangeffectHandler:setParent(self._shenzhuangEffectGo.transform)
	self._shenzhuangeffectHandler:setScale(1)
	self._shenzhuangeffectHandler:setLocalPos(0, 0, 0)
end

function AutochessmissionextView:_playEnemyEffect(goEffect, isBattleEnemy)
	if not isBattleEnemy then
		return
	end

	if self._enemyeffectHandler then
		UIEffectManager.instance:stopEffect(self._enemyeffectHandler)
	end

	local effName = "20230728/zizouqi/fx_ui_zizouqi_difanghongzhen.prefab"

	self._enemyeffectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._enemyeffectHandler:setParent(goEffect.transform)
	self._enemyeffectHandler:setScale(1)
	self._enemyeffectHandler:setLocalPos(0, 0, 0)
end

return AutochessmissionextView
