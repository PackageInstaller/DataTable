-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManCollectView.lua

module("logic.extensions.beastrichman.view.BeastRichManCollectView", package.seeall)

local BeastRichManCollectView = class("BeastRichManCollectView", ViewComponent)
local dealType = {
	stage = 2,
	item = 1,
	boss = 3
}

function BeastRichManCollectView:ctor()
	BeastRichManCollectView.super.ctor(self)
end

function BeastRichManCollectView:unbindEvents()
	BeastRichManCollectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function BeastRichManCollectView:bindEvents()
	BeastRichManCollectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function BeastRichManCollectView:buildUI()
	BeastRichManCollectView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")

	local cellProgress = self:getGo("prize/cell")
	local tabProgress = self:getGo("prize/tableview")

	self._tableviewProgress = ScrollerList.create(tabProgress, cellProgress, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))
	self._progressBar = self:getSlider("prize/tableview/viewport/content/progressBar")
	self._txtNumCurProgress = self:getTxt("prize/curProgress/txtNum")
	self._itemLayer = self:getGo("itemLayer")
	self._bosscell = self:getGo("bossLayer/bosscell")
	self._bossLayer = self:getGo("bossLayer")
	self._itemcell = self:getGo("itemLayer/itemcell")

	goutil.setActive(self._bosscell, false)
	goutil.setActive(self._itemcell, false)

	self._itemcellList = {}
	self._bosscellList = {}
	self._txtTips = self:getTxt("txtTips")
	self._btnTip = self:getGo("leftTop/btnTip")
end

function BeastRichManCollectView:onExit()
	BeastRichManCollectView.super.onExit(self)
	self._tableviewProgress:dispose()

	for _, cell in ipairs(self._itemcellList) do
		if cell.go then
			uGuiUtil.clearImage(cell.go)
		end

		if cell.btn then
			GameUtil.rmClickHandler(cell.btn)
		end

		cell.cfg = nil
	end

	for _, cell in ipairs(self._bosscellList) do
		if cell.go then
			uGuiUtil.clearImage(cell.go)
		end

		cell.cfg = nil
	end
end

function BeastRichManCollectView:onEnter()
	BeastRichManCollectView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BeastRichManBeastPrizeInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.BeastRichManGainBeastPrizeRes, self._updatePrizes, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 558001
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	BeastRichmanAgent.instance:sendPM_BeastRichManBeastPrizeInfoReq(self._activityId)
end

function BeastRichManCollectView:_updateUIByCfg()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._bossPrizeCfgs = BeastRichmanConfig.instance:getBeastPrizeCfgs(self._activityId) or {}
	self._actCfg = BeastRichmanConfig.instance:getActCfg(self._activityId)
	self._showCfgs = BeastRichmanConfig.instance:getBeastCollectShowCfgs(self._activityId) or {}
	self._prizeItemList = {}

	if not self._actCfg then
		printError("配置缺失，活动ID：%s", self._activityId)
		self:close()

		return
	end

	self._prizeItemList = self._actCfg.prizeItemList or {}

	for _, cell in ipairs(self._itemcellList) do
		if cell.go then
			uGuiUtil.clearImage(cell.go)
			goutil.setActive(cell.go, false)
		end

		if cell.btn then
			GameUtil.rmClickHandler(cell.btn)
		end
	end

	for _, cell in ipairs(self._bosscellList) do
		if cell.go then
			uGuiUtil.clearImage(cell.go)
			goutil.setActive(cell.go, false)
		end
	end

	local itemCellId = 0
	local bossCellId = 0

	for i, v in ipairs(self._showCfgs) do
		if not v.showPicPath then
			local showPicPath = ""
			local realPath = string.format("%s.png", showPicPath)

			if not v.dealParam then
				local dealParam = ""

				if v.dealType == dealType.item then
					itemCellId = itemCellId + 1

					local cell = self:_getItemCell(itemCellId)

					cell.cfg = v

					goutil.setActive(cell.go, true)
					uGuiUtil.setSpriteToImage(cell.go, uGuiUtil.SpriteType.BigBg, realPath, function()
						cell.go:GetComponent("Image"):SetNativeSize()

						cell.go:GetComponent("Image").raycastTarget = false
					end)

					if not v.pos then
						local pos = {
							0,
							0
						}

						GameUtil.setAnchoredPos(cell.go, pos[1], pos[2])
						GameUtil.addClickHandler(cell.btn, function()
							local itemId = checknumber(dealParam)

							CommonTipsMgr.instance:openMaterialTips(cell.go, MatType.ACTIVITY_ITEM, itemId, 0)
						end, self)
					end
				elseif v.dealType == dealType.boss or v.dealType == dealType.stage then
					bossCellId = bossCellId + 1

					local cell = self:_getBossCell(bossCellId)

					cell.cfg = v

					goutil.setActive(cell.go, true)
					uGuiUtil.setSpriteToImage(cell.go, uGuiUtil.SpriteType.BigBg, realPath, function()
						cell.go:GetComponent("Image"):SetNativeSize()

						cell.go:GetComponent("Image").raycastTarget = false
					end)

					if not v.pos then
						local pos = {
							0,
							0
						}

						GameUtil.setAnchoredPos(cell.go, pos[1], pos[2])
					end
				end
			end
		end
	end

	self._txtTips.text = string.format("一个文字=%s进度\n一个形象=%s进度", self._actCfg.prizeItemScore, self._actCfg.prizeBossScore)
end

function BeastRichManCollectView:_getItemCell(cellId)
	local cell = self._itemcellList[cellId]

	if not cell then
		cell = {
			go = goutil.cloneAndSetParent(self._itemcell, self._itemLayer.transform, "itemcell_" .. cellId)
		}
		cell.btn = goutil.findChild(cell.go, "btn")
		cell.cfg = nil

		table.insert(self._itemcellList, cell)
	end

	return cell
end

function BeastRichManCollectView:_getBossCell(cellId)
	local cell = self._bosscellList[cellId]

	if not cell then
		cell = {
			go = goutil.cloneAndSetParent(self._bosscell, self._bossLayer.transform, "bosscell_" .. cellId)
		}
		cell.cfg = nil

		table.insert(self._bosscellList, cell)
	end

	return cell
end

function BeastRichManCollectView:_updateUIByInfo()
	self._bossInfoMap = {}
	self._stagesInfoMap = {}
	self._curProgress = 0

	local info = BeastRichmanModel.instance:getCollectInfo(self._activityId)

	if info then
		if not info.boss then
			if not info.stages then
				local stages = {}

				for _, v in ipairs(info.boss) do
					self._bossInfoMap[v.bossId] = v
				end

				for _, v in ipairs(stages) do
					self._stagesInfoMap[v.bossId] = v
				end
			end
		end
	end

	self._curProgress = self:_getCurProgress()

	self:_updatePrizes()
end

function BeastRichManCollectView:_getCurProgress()
	local hasCollestStageIdMap = {}
	local hasCollestBossIdMap = {}
	local curColletItemCount = 0

	for _, prizeId in ipairs(self._prizeItemList) do
		curColletItemCount = MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, prizeId) + curColletItemCount
	end

	for _, cell in ipairs(self._itemcellList) do
		local cfg = cell.cfg

		if cfg and cfg.dealType == dealType.item then
			if not cfg.dealParam then
				local dealParam = ""
				local checkItemId = checknumber(dealParam)
				local isCollect = MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, checkItemId) > 0

				goutil.setActive(cell.go, not isCollect)
				goutil.setActive(cell.btn, not isCollect)
			end
		end
	end

	local curCollectBossCount = 0

	self._bossInfoMap = self._bossInfoMap or {}

	for bossId, bossInfo in pairs(self._bossInfoMap) do
		local isCollect = BeastRichmanConfig.instance:getBossIsCollect(self._activityId, bossId, bossInfo.historyDamage)

		if isCollect then
			hasCollestBossIdMap[bossId] = true
			curCollectBossCount = curCollectBossCount + 1
		end
	end

	self._stagesInfoMap = self._stagesInfoMap or {}

	for bossId, stageInfo in pairs(self._stagesInfoMap) do
		local isCollect = BeastRichmanConfig.instance:getIsStageBossCollect(self._activityId, bossId, stageInfo.stageId)

		if isCollect then
			hasCollestStageIdMap[bossId] = true
			curCollectBossCount = curCollectBossCount + 1
		end
	end

	for _, cell in ipairs(self._bosscellList) do
		local cfg = cell.cfg

		if cfg then
			if cfg.dealType == dealType.boss then
				local bossId = checknumber((not cfg.dealParam or nil) and "")
				local isCollect = hasCollestBossIdMap[bossId] == true

				goutil.setActive(cell.go, not isCollect)
			elseif cfg.dealType == dealType.stage then
				local bossId = checknumber((not cfg.dealParam or nil) and "")
				local isCollect = hasCollestStageIdMap[bossId] == true

				goutil.setActive(cell.go, not isCollect)
			end
		end
	end

	return curColletItemCount * self._actCfg.prizeItemScore + curCollectBossCount * self._actCfg.prizeBossScore
end

function BeastRichManCollectView:_updateProgressCell(view, cell, data)
	local item = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.setCellByCfg(data.prize, item)

	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")

	txtNum.text = data.needScore

	if not self._hasGainPrizeMap[data.prizeId] then
		local isGain = false
		local isMatchGain = not isGain and self._curProgress >= checknumber(data.needScore)
		local btnGet = goutil.findChild(cell.gameObject, "btnGet")

		goutil.setActive(btnGet, isMatchGain)

		local effect = goutil.findChild(cell.gameObject, "effect")

		if isMatchGain then
			self:_playCellEffect(effect)
			GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGainPrize, self, data.prizeId))
		else
			self:_clearCellEffect(effect)
		end

		local geted = goutil.findChild(cell.gameObject, "geted")

		goutil.setActive(geted, isGain)
	end
end

function BeastRichManCollectView:_clearProgressCell(cell)
	local item = goutil.findChild(cell.gameObject, "item")

	if item then
		MaterialMgr.resetAll(item)
	end

	local btnGet = goutil.findChild(cell.gameObject, "btnGet")

	if btnGet then
		GameUtil.rmClickHandler(btnGet)
	end

	local effect = goutil.findChild(cell.gameObject, "effect")

	if effect then
		self:_clearCellEffect(effect)
	end
end

function BeastRichManCollectView:_updatePrizes()
	self._hasGainPrizeMap = {}

	local info = BeastRichmanModel.instance:getCollectInfo(self._activityId)

	if info then
		if not info.gainedPrizeIds then
			do
				local gainedPrizeIds = {}

				for _, v in ipairs(gainedPrizeIds) do
					self._hasGainPrizeMap[v] = true
				end
			end

			local showIndex = -1
			local lastIndex = -1
			local scoreList = {}

			for i, v in ipairs(self._bossPrizeCfgs) do
				if checknumber(v.needScore) <= self._curProgress then
					if not self._hasGainPrizeMap[i] then
						if showIndex <= 0 then
							showIndex = i
						end
					else
						lastIndex = i
					end
				end

				table.insert(scoreList, checknumber(v.needScore))
			end

			if lastIndex <= 0 then
				lastIndex = 1
			end

			if showIndex <= 0 then
				showIndex = lastIndex
			end

			self._tableviewProgress:updateUnderSlider(self._progressBar, self._curProgress, scoreList)
			self._tableviewProgress:reloadData(self._bossPrizeCfgs)
			self._tableviewProgress:MoveCellToBegin(showIndex - 1)

			self._txtNumCurProgress.text = self._curProgress
		end
	end
end

function BeastRichManCollectView:_onClickGainPrize(progressId)
	BeastRichmanAgent.instance:sendPM_BeastRichManBeastGainPrizeReq(self._activityId, progressId)
end

function BeastRichManCollectView:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("prize/tableview/viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScaleXYZ(0.96, 1, 0.87)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function BeastRichManCollectView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function BeastRichManCollectView:_onClickTip()
	local key = self._actCfg.collectRuleKey

	TipsFacade.instance:openRulesView(key)
end

return BeastRichManCollectView
