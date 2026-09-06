-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aresmom/view/AresMomGameView.lua

module("logic.extensions.aresmom.view.AresMomGameView", package.seeall)

local AresMomGameView = class("AresMomGameView", ViewComponent)

function AresMomGameView:buildUI()
	AresMomGameView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnAddTime = self:getGo("btnAddTime")
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

function AresMomGameView:bindEvents()
	AresMomGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnAddTime, self._onClickAddTime, self)
end

function AresMomGameView:unbindEvents()
	AresMomGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnAddTime)
end

function AresMomGameView:onEnter()
	AresMomGameView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._challengeId = checknumber(params[1])
	self._curType = checknumber(params[2])

	local isInTime = AresMomController.instance:isInTime(self._challengeId)

	if not isInTime or self._curType <= 0 then
		local text = "未开启"

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actCfg = AresMomConfig.instance:getActCfgById(self._challengeId)

	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.itemId)

	MaterialMgr.setIcon(self._txtItemCount_icon, matType, matId, nil, nil)
	MaterialMgr.setIcon(self._right_rule_1_item_icon, matType, matId, nil, nil)
	MaterialMgr.setIcon(self._right_rule_2_item_1_icon, matType, matId, nil, nil)
	MaterialMgr.setIcon(self._right_rule_2_item_2_icon, matType, matId, nil, nil)
	MaterialMgr.setIcon(self._right_rule_3_item_icon, matType, matId, nil, nil)
	AresMomModel.instance:setCurType(self._curType)
	self:_initViewByCfgAndData()
	GlobalDispatcher:addListener(GlobalNotify.AresMomUnlock, self._refreshViewByData, self)
	GlobalDispatcher:addListener(GlobalNotify.AresMomBuyTimes, self._refreshOther, self)
	removetimer(self.hideEff, self)

	local userRuleKey = "aresmomgameview_first_open_rule"

	if checkint(GameUtil.getUserData(userRuleKey)) <= 0 then
		GameUtil.saveUserData(userRuleKey, 1)
		self:_onClickTip()
	end
end

function AresMomGameView:onEnterFinished()
	for k, cell in ipairs(self._chessCellList) do
		self:_preDealCell(cell)
	end

	self:_refreshChessBoard()
end

function AresMomGameView:onExit()
	AresMomGameView.super.onExit(self)

	for k, cell in ipairs(self._chessCellList) do
		self:_clearCell(cell)
	end

	GlobalDispatcher:removeListener(GlobalNotify.AresMomUnlock, self._refreshViewByData, self)
	GlobalDispatcher:removeListener(GlobalNotify.AresMomBuyTimes, self._refreshOther, self)

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

function AresMomGameView:_onClickTip()
	local pathStr = AresMomConfig.instance:getAmClientCommonValue(self._challengeId, "ARES_GAME_RULE_VIEW_IMG_PATHS")
	local folderPath = "aruisimuqin"

	UIStateManager.instance:push(ViewName.AresMomGameRuleView, self._challengeId, folderPath, pathStr)
end

function AresMomGameView:buildChessBoard()
	local planId = AresMomConfig.instance:getGamePlanId(self._challengeId, self._curType)
	local gameCfg = AresMomConfig.instance:getGameCfg(planId, self._curInfo.gameDay)

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

				cell.blockCfg = AresMomConfig.instance:getBlockCfg(self._challengeId, checkint(string.gsub(blockId, "%p+", "")))
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
end

function AresMomGameView:_buildUnlockMap()
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

function AresMomGameView:_checkBlockAllUnlock(blockId)
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

function AresMomGameView:_checkAllUnlock()
	for k, cell in pairs(self._chessCellList) do
		if cell.blockCfg then
			if cell.blockCfg ~= self._chessDealTypeEnum.locked and not cell.isUnlock then
				return false
			end
		end
	end

	return true
end

function AresMomGameView:_onClickChess(id)
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
				if self._gameTimes <= 0 then
					FloatWordMgr.instance:show(lang("当前没有游戏次数,请尝试通关挑战获得"))
					self:_onClickAddTime()

					return
				end

				AresMomController.instance:unlock(self._challengeId, self._curType, id)

				if cell.eff then
					cell.eff:setActive(true)
					removetimer(self.hideEff, self)
					settimer(1, self.hideEff, self, false)
				end
			end
		end
	end
end

function AresMomGameView:hideEff()
	for k, cell in pairs(self._chessCellList) do
		if cell and cell.eff then
			cell.eff:setActive(false)
		end
	end
end

function AresMomGameView:_refreshChessBoard()
	if self._curInfo then
		if self.visbleBlockIds then
			for k, id in ipairs(self.visbleBlockIds) do
				table.insert(self._curInfo, id)
			end
		end

		for k, cell in ipairs(self._chessCellList) do
			cell.isUnlock = table.keyof(self._curInfo, cell.id)

			self:_refreshCell(cell)
		end
	end
end

function AresMomGameView:_preDealCell(cell)
	if cell and cell.go then
		self:_clearCell(cell)

		local blockCfg = cell.blockCfg
		local bgPath = "board_aruisimuqin_18"
		local bgPathPathListStr = AresMomConfig.instance:getAmClientCommonValue(self._challengeId, "ARES_GAME_BG_PATH_LIST")
		local bgPathReses = string.split(bgPathPathListStr, "#")
		local iconPath = ""

		if blockCfg then
			if blockCfg.dealType == self._chessDealTypeEnum.locked then
				bgPath = blockCfg.res

				uGuiUtil.setSpriteToImage(cell.bg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("aresmom", blockCfg.res))

				cell.eff = UIEffectManager.instance:playEffect(self, "20220930/aruisimuqin/fx_ui_aruisimq_doudong.prefab", nil, 0, 0, true, false, nil, function(target, eff)
					eff:setParent(cell.go.transform)
					eff:setLocalPos(0, 0, 0)
					eff:setScale(0.75)

					eff.hideEffWhileNotOnTop = true

					eff:setActive(false)

					local effBg = goutil.findChild(eff.effGo, "an1/scale/img_on")

					if effBg then
						uGuiUtil.setSpriteToImage(effBg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("aresmom", bgPath))
					end
				end)
			else
				bgPath = bgPathReses[Mathf.Random(1, #bgPathReses)]

				uGuiUtil.setSpriteToImage(cell.bg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("aresmom", bgPath))

				if blockCfg.dealType ~= self._chessDealTypeEnum.isWhite then
					iconPath = blockCfg.res .. "_" .. cell.leafId

					uGuiUtil.setSpriteToImage(cell.icon, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("aresmom", blockCfg.res .. "_" .. cell.leafId))

					cell.eff = UIEffectManager.instance:playEffect(self, "20220930/aruisimuqin/fx_ui_aruisimq_fanzhuan.prefab", nil, 0, 0, true, false, nil, function(target, eff)
						eff:setParent(cell.go.transform)
						eff:setLocalPos(0, 0, 0)
						eff:setScale(0.75)

						eff.hideEffWhileNotOnTop = true

						eff:setActive(false)

						local effBg = goutil.findChild(eff.effGo, "an/scale/img_down")

						if effBg then
							uGuiUtil.setSpriteToImage(effBg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("aresmom", bgPath))
						end

						local effUp = goutil.findChild(eff.effGo, "an/scale/img_on")

						if effUp then
							uGuiUtil.setSpriteToImage(effUp, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("aresmom", iconPath))
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

function AresMomGameView:_refreshCell(cell)
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

function AresMomGameView:_clearCell(cell)
	if cell and cell.go then
		if cell.eff and not goutil.isNil(cell.eff.effGo) then
			local effBg1 = goutil.findChild(cell.eff.effGo, "an/scale/img_down")
			local effBg2 = goutil.findChild(cell.eff.effGo, "an1/scale/img_on")
			local effUp = goutil.findChild(cell.eff.effGo, "an/scale/img_on")

			if effBg1 then
				uGuiUtil.clearImage(effBg1)
			end

			if effBg2 then
				uGuiUtil.clearImage(effBg2)
			end

			if effUp then
				uGuiUtil.clearImage(effUp)
			end
		end

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

function AresMomGameView:_refreshOther()
	self._gameTimes = self._curInfo and self._curInfo.gameTimes
	self._txtLeftTime.text = langPara("次数：%s", self._gameTimes)
	self._txtItemCount.text = langPara("%s/%s", self._curInfo.itemCount, self.itemLimit)
end

function AresMomGameView:_refreshViewByData()
	self:_refreshOther()
	self:_refreshChessBoard()
end

function AresMomGameView:_initViewByCfgAndData()
	self._curInfo = AresMomModel.instance:getChallengeInfo(self._curType)
	self._curTypeCfg = AresMomConfig.instance:getTypeCfg(self._challengeId, self._curType)
	self._addTimeCost = self._curTypeCfg.cost

	self:buildChessBoard()
	self:_refreshOther()
end

function AresMomGameView:_onClickAddTime()
	if self:_checkAllUnlock() then
		FloatWordMgr.instance:show(lang("通关了 不需要购买次数啦~"))

		return
	end

	if self._gameTimes > 0 then
		FloatWordMgr.instance:show(lang("当前有次数请使用完毕后再次购买"))

		return
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(self._addTimeCost)
	local content = langPara("确定花费%s%s增加%s次游戏次数？", matNum, MaterialMgr.getMaterialsNameByCfg(self._addTimeCost), self._curTypeCfg.num)

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
		AresMomController.instance:buyTimes(self._challengeId, self._curType)
	end)
end

return AresMomGameView
