-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aruishidragongame/view/ARuiShiDragonGameView.lua

module("logic.extensions.aruishidragongame.view.ARuiShiDragonGameView", package.seeall)

local ARuiShiDragonGameView = class("ARuiShiDragonGameView", ViewComponent)

function ARuiShiDragonGameView:buildUI()
	ARuiShiDragonGameView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtLeftTime = self:getTxt("txtLeftTime")
	self._txtItemCount = self:getTxt("txtItemCount")
	self._txtItemCount_icon = self:getGo("txtItemCount/icon")
	self._right_rule_1_item_icon = self:getGo("right/rule_1/item/icon")
	self._right_rule_2_item_1_icon = self:getGo("right/rule_2/item_1/icon")
	self._right_rule_2_item_2_icon = self:getGo("right/rule_2/item_2/icon")
	self._right_rule_3_item_icon = self:getGo("right/rule_3/item/icon")
	self._chessBoard = self:getGo("chessboard")
	self._chessCell = goutil.findChild(self._chessBoard, "chesscell")
	self._chessCellList = {}
	self._chessCellMap = {}
	self._chessDealTypeEnum = {
		twoXThree = 4,
		locked = 6,
		threeXTwo = 5,
		twoXTwo = 3,
		oneCell = 2,
		isWhite = 1
	}

	goutil.setActive(self._chessCell, false)
end

function ARuiShiDragonGameView:bindEvents()
	ARuiShiDragonGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function ARuiShiDragonGameView:unbindEvents()
	ARuiShiDragonGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function ARuiShiDragonGameView:onEnter()
	ARuiShiDragonGameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ARuiShiDragonGameStartRes, self._onStartRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._curType = checknumber(params[2])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("outtime"), function()
			self:close()
		end)

		return
	end

	self._actCfg = ARuiShiDragonGameConfig.instance:getActivityCfg(self._activityId)

	ARuiShiDragonGameModel.instance:initGameInfo(self._activityId)

	self._isStart = false

	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.itemId)

	MaterialMgr.setIcon(self._txtItemCount_icon, matType, matId, nil, nil)
	MaterialMgr.setIcon(self._right_rule_1_item_icon, matType, matId, nil, nil)
	MaterialMgr.setIcon(self._right_rule_2_item_1_icon, matType, matId, nil, nil)
	MaterialMgr.setIcon(self._right_rule_2_item_2_icon, matType, matId, nil, nil)
	MaterialMgr.setIcon(self._right_rule_3_item_icon, matType, matId, nil, nil)
	self:_initViewByCfgAndData()
	removetimer(self.hideEff, self)

	local userRuleKey = "aresmomgameview_first_open_rule"

	if checkint(GameUtil.getUserData(userRuleKey)) <= 0 then
		GameUtil.saveUserData(userRuleKey, 1)
		self:_onClickTip()
	end

	self:_startGame()
end

function ARuiShiDragonGameView:onEnterFinished()
	for k, cell in ipairs(self._chessCellList) do
		self:_preDealCell(cell)
	end

	self:_refreshChessBoard()
end

function ARuiShiDragonGameView:onExit()
	ARuiShiDragonGameView.super.onExit(self)

	for k, cell in ipairs(self._chessCellList) do
		self:_clearCell(cell)
	end

	if self._clickEff then
		UIEffectManager.instance:stopEffect(self._clickEff)

		self._clickEff = nil
	end

	MaterialMgr.resetAll(self._txtItemCount_icon)
	MaterialMgr.resetAll(self._right_rule_1_item_icon)
	MaterialMgr.resetAll(self._right_rule_2_item_1_icon)
	MaterialMgr.resetAll(self._right_rule_2_item_2_icon)
	MaterialMgr.resetAll(self._right_rule_3_item_icon)
end

function ARuiShiDragonGameView:_onClickClose()
	local text = "中途退出小游戏会消耗游玩次数，是否确定退出小游戏！"

	local function okFunc()
		self:_popupResultView()
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc)
end

function ARuiShiDragonGameView:_onStartRes()
	self._isStart = true
end

function ARuiShiDragonGameView:_initViewByCfgAndData()
	self._curInfo = ARuiShiDragonGameModel.instance:getGameInfo(self._activityId)
	self._curTypeCfg = ARuiShiDragonGameConfig.instance:getTypeCfg(self._activityId, self._curType)

	self:buildChessBoard()
	self:_refreshOther()
end

function ARuiShiDragonGameView:buildChessBoard()
	local planId = ARuiShiDragonGameConfig.instance:getGamePlanId(self._activityId, self._curType)
	local count = #ARuiShiDragonGameConfig.instance:getGameCfgList(planId)
	local checkId = Mathf.Random(1, count)
	local gameCfg = ARuiShiDragonGameConfig.instance:getGameCfg(planId, checkId)

	for k, v in pairs(self._chessCellList) do
		goutil.setActive(v.go, false)
	end

	if gameCfg and not string.nilorempty(gameCfg.map) then
		self._chessCellMap = {}

		local chessId = 0
		local mapArrs = string.split(gameCfg.map, ";\r\n")

		for k, rowStr in ipairs(mapArrs) do
			self._chessCellMap[k] = {}

			local rowArrs = string.split(rowStr, ",")

			for k1, blockId in ipairs(rowArrs) do
				chessId = chessId + 1

				local cell = {}
				local goCell = goutil.findChild(self._chessBoard, "chesscell" .. chessId)

				cell.go = goCell or goutil.cloneAndSetParent(self._chessCell, self._chessBoard.transform, "chesscell" .. chessId)
				cell.btnClick = goutil.findChild(cell.go, "btnClick")
				cell.txtShow = goutil.findChildTextComponent(cell.go, "txtShow")
				cell.bg = goutil.findChild(cell.go, "bg")
				cell.icon = goutil.findChild(cell.go, "icon")
				cell.empty = goutil.findChild(cell.go, "empty")
				cell.txtShow.text = ""

				GameUtil.rmClickHandler(cell.btnClick)
				GameUtil.addClickHandler(cell.btnClick, GameUtil.handler(self._onClickChess, self, chessId))

				cell.blockCfg = ARuiShiDragonGameConfig.instance:getBlockCfg(self._activityId, checkint(string.gsub(blockId, "%p+", "")))
				cell.rootId = chessId
				cell.leafId = 1
				cell.id = chessId
				cell.isUnlock = false
				self._chessCellList[chessId] = cell
				self._chessCellMap[k][k1] = self._chessCellList[chessId]
			end
		end
	end

	self:_buildUnlockMap()

	if gameCfg then
		self.visbleBlockIds = gameCfg.visibleBlockIds or {}
	end

	if gameCfg then
		self.itemLimit = gameCfg.itemCount or 0
	end

	if gameCfg then
		self._curInfo.gameTimes = gameCfg.draw or 0
	end

	for k, id in ipairs(self.visbleBlockIds) do
		table.insert(self._curInfo.unlockBlockIds, id)
	end
end

function ARuiShiDragonGameView:_buildUnlockMap()
	self._unlockMap = {}

	for k, rowList in ipairs(self._chessCellMap) do
		for k1, v in ipairs(rowList) do
			if v.blockCfg then
				if v.leafId == 1 then
					if v.blockCfg == self._chessDealTypeEnum.twoXTwo then
						self._chessCellMap[k][k1 + 1].leafId = 2
						self._chessCellMap[k][k1 + 1].rootId = v.id
						self._chessCellMap[k + 1][k1].leafId = 3
						self._chessCellMap[k + 1][k1].rootId = v.id
						self._chessCellMap[k + 1][k1 + 1].leafId = 4
						self._chessCellMap[k + 1][k1 + 1].rootId = v.id
					elseif v.blockCfg == self._chessDealTypeEnum.threeXTwo then
						self._chessCellMap[k][k1 + 1].leafId = 2
						self._chessCellMap[k][k1 + 1].rootId = v.id
						self._chessCellMap[k + 1][k1].leafId = 3
						self._chessCellMap[k + 1][k1].rootId = v.id
						self._chessCellMap[k + 1][k1 + 1].leafId = 4
						self._chessCellMap[k + 1][k1 + 1].rootId = v.id
						self._chessCellMap[k + 2][k1].leafId = 5
						self._chessCellMap[k + 2][k1].rootId = v.id
						self._chessCellMap[k + 2][k1 + 1].leafId = 6
						self._chessCellMap[k + 2][k1 + 1].rootId = v.id
					elseif v.blockCfg == self._chessDealTypeEnum.twoXThree then
						self._chessCellMap[k][k1 + 1].leafId = 2
						self._chessCellMap[k][k1 + 1].rootId = v.id
						self._chessCellMap[k][k1 + 2].leafId = 3
						self._chessCellMap[k][k1 + 2].rootId = v.id
						self._chessCellMap[k + 1][k1].leafId = 4
						self._chessCellMap[k + 1][k1].rootId = v.id
						self._chessCellMap[k + 1][k1 + 1].leafId = 5
						self._chessCellMap[k + 1][k1 + 1].rootId = v.id
						self._chessCellMap[k + 1][k1 + 2].leafId = 6
						self._chessCellMap[k + 1][k1 + 2].rootId = v.id
					end
				end

				if not self._unlockMap[v.rootId] then
					local unlockMap = {}

					table.insert(unlockMap, v)

					self._unlockMap[v.rootId] = unlockMap
				end
			end
		end
	end
end

function ARuiShiDragonGameView:_refreshOther()
	self._txtLeftTime.text = langPara("次数：%d", self._curInfo.gameTimes)
	self._txtItemCount.text = langPara("%s/%s", self._curInfo.itemCount, self.itemLimit)
end

function ARuiShiDragonGameView:_preDealCell(cell)
	if cell and cell.go then
		local folderPath = "aruishidragongame"

		self:_clearCell(cell)

		local blockCfg = cell.blockCfg
		local bgPath = "board_syars_07"
		local bgPathPathListStr = ARuiShiDragonGameConfig.instance:getAmClientCommonValue(self._activityId, "ARES_GAME_BG_PATH_LIST")
		local bgPathReses = string.split(bgPathPathListStr, "#")
		local iconPath = ""

		if blockCfg then
			if blockCfg.dealType == self._chessDealTypeEnum.locked then
				bgPath = blockCfg.res

				uGuiUtil.setSpriteToImage(cell.bg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl(folderPath, blockCfg.res))

				cell.eff = UIEffectManager.instance:playEffect(self, "20220930/aruisimuqin/fx_ui_aruisimq_doudong.prefab", nil, 0, 0, true, false, nil, function(target, eff)
					eff:setParent(cell.go.transform)
					eff:setLocalPos(0, 0, 0)
					eff:setScale(0.75)

					eff.hideEffWhileNotOnTop = true

					eff:setActive(false)

					local effBg = goutil.findChild(eff.effGo, "an1/scale/img_on")

					if effBg then
						uGuiUtil.setSpriteToImage(effBg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl(folderPath, bgPath))
					end
				end)
			else
				bgPath = bgPathReses[Mathf.Random(1, #bgPathReses)]

				uGuiUtil.setSpriteToImage(cell.bg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl(folderPath, bgPath))

				if blockCfg.dealType ~= self._chessDealTypeEnum.isWhite then
					iconPath = blockCfg.res .. "_" .. cell.leafId

					uGuiUtil.setSpriteToImage(cell.icon, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl(folderPath, blockCfg.res .. "_" .. cell.leafId))

					cell.eff = UIEffectManager.instance:playEffect(self, "20220930/aruisimuqin/fx_ui_aruisimq_fanzhuan.prefab", nil, 0, 0, true, false, nil, function(target, eff)
						eff:setParent(cell.go.transform)
						eff:setLocalPos(0, 0, 0)
						eff:setScale(0.75)

						eff.hideEffWhileNotOnTop = true

						eff:setActive(false)

						local effBg = goutil.findChild(eff.effGo, "an/scale/img_down")

						if effBg then
							uGuiUtil.setSpriteToImage(effBg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl(folderPath, bgPath))
						end

						local effUp = goutil.findChild(eff.effGo, "an/scale/img_on")

						if effUp then
							uGuiUtil.setSpriteToImage(effUp, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl(folderPath, iconPath))
						end
					end)
				else
					cell.eff = UIEffectManager.instance:playEffect(self, "20220930/aruisimuqin/fx_ui_aruisimq_dianji.prefab", nil, 0, 0, true, false, nil, function(target, eff)
						eff:setParent(cell.go.transform)
						eff:setLocalPos(0, 0, 0)
						eff:setScale(1)

						eff.hideEffWhileNotOnTop = true

						eff:setActive(false)
					end)
				end
			end
		end

		goutil.setActive(cell.go, true)
	end
end

function ARuiShiDragonGameView:_clearCell(cell)
	if cell and cell.go then
		uGuiUtil.clearImage(cell.bg)
		uGuiUtil.clearImage(cell.icon)
		goutil.setActive(cell.icon, false)
		goutil.setActive(cell.empty, false)
		goutil.setActive(cell.go, false)

		if cell.eff then
			UIEffectManager.instance:stopEffect(cell.eff)

			cell.eff = nil
		end
	end
end

function ARuiShiDragonGameView:_refreshChessBoard()
	for k, cell in ipairs(self._chessCellList) do
		self:_refreshCell(cell)
	end
end

function ARuiShiDragonGameView:_refreshCell(cell)
	if cell and cell.go and cell.isUnlock then
		if cell.blockCfg then
			if cell.blockCfg == self._chessDealTypeEnum.isWhite then
				goutil.setActive(cell.empty, true)
			elseif cell.blockCfg == self._chessDealTypeEnum.locked then
				-- block empty
			else
				goutil.setActive(cell.icon, true)
			end
		end
	end
end

function ARuiShiDragonGameView:_onClickChess(id)
	if not self._isStart then
		return
	end

	local cell = self._chessCellList[id]

	if cell then
		if cell.isUnlock then
			if self._clickEff then
				UIEffectManager.instance:stopEffect(self._clickEff)

				self._clickEff = nil
			end

			self._clickEff = UIEffectManager.instance:playEffect(self, "20220930/aruisimuqin/fx_ui_aruisimq_dianji.prefab", nil, 0, 0, false, false, nil, function(target, eff)
				eff:setParent(cell.go.transform)
				eff:setLocalPos(0, 0, 0)
				eff:setScale(1)

				eff.hideEffWhileNotOnTop = true
			end)
		else
			local dealType = cell.blockCfg.dealType

			if dealType == self._chessDealTypeEnum.locked then
				FloatWordMgr.instance:show(lang("该格子不可点击"))

				if cell.eff then
					cell.eff:setActive(true)
					removetimer(self.hideEff, self)
					settimer(1, self.hideEff, self, false)
				end
			else
				if self._curInfo.gameTimes <= 0 then
					FloatWordMgr.instance:show(lang("当前没有游戏次数,请尝试通关挑战获得"))

					return
				end

				self:_unlock(self._activityId, self._curType, id)

				if cell.eff then
					cell.eff:setActive(true)
					removetimer(self.hideEff, self)
					settimer(1, self.hideEff, self, false)
				end
			end
		end
	end
end

function ARuiShiDragonGameView:hideEff()
	for k, cell in pairs(self._chessCellList) do
		if cell and cell.eff then
			cell.eff:setActive(false)
		end
	end
end

function ARuiShiDragonGameView:_refreshViewByData()
	self:_refreshOther()
	self:_refreshChessBoard()
	self:_estimateGameEnd()
end

function ARuiShiDragonGameView:_onClickTip()
	local pathStr = ARuiShiDragonGameConfig.instance:getAmClientCommonValue(self._activityId, "ARES_GAME_RULE_VIEW_IMG_PATHS")
	local folderPath = "aruishidragongame"

	UIStateManager.instance:push(ViewName.AresMomGameRuleView, self._actCfg.challengeId, folderPath, pathStr)
end

function ARuiShiDragonGameView:_unlock(activityId, curType, chessId)
	self._curInfo.gameTimes = self._curInfo.gameTimes - 1
	self._curInfo.gameTimes = Mathf.Max(0, self._curInfo.gameTimes)

	local cell = self._chessCellList[chessId]

	if cell.isUnlock then
		-- block empty
	else
		cell.isUnlock = true

		table.insert(self._curInfo.unlockBlockIds, chessId)

		if self:_checkBlockAllUnlock(chessId) and cell.blockCfg.dealType ~= self._chessDealTypeEnum.locked and cell.blockCfg.dealType ~= self._chessDealTypeEnum.isWhite then
			local matType, id, matNum = MaterialMgr.getMatParams(cell.blockCfg.prize)

			self._curInfo.itemCount = self._curInfo.itemCount + matNum

			if cell.blockCfg.addTimes > 0 then
				self._curInfo.gameTimes = self._curInfo.gameTimes + cell.blockCfg.addTimes
			end
		end
	end

	self:_refreshViewByData()
end

function ARuiShiDragonGameView:_estimateGameEnd()
	local maxCellNum = #self._chessCellList

	if maxCellNum <= #self._curInfo.unlockBlockIds then
		self:_popupResultView()

		return
	end

	if self._curInfo.gameTimes <= 0 then
		self:_popupResultView()

		return
	end

	if self._curInfo.itemCount >= self.itemLimit then
		self:_popupResultView()

		return
	end
end

function ARuiShiDragonGameView:_popupResultView()
	if self._curInfo.itemCount > self.itemLimit then
		self._curInfo.itemCount = self.itemLimit
	end

	local text = string.format("太幸运了，恭喜获得%d积分\n（最高获得本关游戏的积分上限%d）", self._curInfo.itemCount, self.itemLimit)
	local btnText = "太棒了"

	local function func()
		self:close()
		UIStateManager.instance:popByName(ViewName.ARuiShiDragonGameLevelView)
	end

	TipsFacade.instance:openTipWindow(lang("tip"), text, func, btnText, UnityEngine.TextAnchor.MiddleCenter)

	if self._isStart then
		self:_settleGame(self._curInfo.itemCount)
	end
end

function ARuiShiDragonGameView:_startGame()
	local clientKey = math.random(ServerTime.now())

	self._clientKey = clientKey

	ARuiShiDragonGameAgent.instance:sendPM_ARuiShiDragonGameStartReq(self._activityId, clientKey)
end

function ARuiShiDragonGameView:_settleGame(num)
	local isPass = true
	local serverKey = ARuiShiDragonGameModel.instance:getServerKey(self._activityId)
	local encryptedKey = GameUtil.getClientEncryptedKey(self._clientKey, serverKey, {
		num
	})

	ARuiShiDragonGameAgent.instance:sendPM_ARuiShiDragonGameEndReq(self._activityId, isPass, num, encryptedKey)
end

function ARuiShiDragonGameView:_checkBlockAllUnlock(blockId)
	local chessCell = self._chessCellList[blockId]

	if chessCell then
		if chessCell.rootId then
			for k, cell in pairs(chessCell.rootId) do
				if not cell.isUnlock then
					return false
				end
			end

			return true
		end
	end

	return false
end

function ARuiShiDragonGameView:_checkAllUnlock()
	for k, cell in pairs(self._chessCellList) do
		if cell.blockCfg then
			if cell.blockCfg ~= self._chessDealTypeEnum.locked and not cell.isUnlock then
				return false
			end
		end
	end

	return true
end

return ARuiShiDragonGameView
