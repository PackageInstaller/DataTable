-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapter4MainView.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapter4MainView", package.seeall)

local BoccaccioChapter4MainView = class("BoccaccioChapter4MainView", ViewComponent)

function BoccaccioChapter4MainView:ctor()
	BoccaccioChapter4MainView.super.ctor(self)
end

function BoccaccioChapter4MainView:unbindEvents()
	BoccaccioChapter4MainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnFight)
	GameUtil.rmClickHandler(self._btnTrail)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnTip)
end

function BoccaccioChapter4MainView:bindEvents()
	BoccaccioChapter4MainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnFight, self._onClickBtnFight, self)
	GameUtil.addClickHandler(self._btnTrail, self._onClickBtnTrail, self)
	GameUtil.addClickHandler(self._btnLeft, self._onClickBtnLeft, self)
	GameUtil.addClickHandler(self._btnRight, self._onClickBtnRight, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function BoccaccioChapter4MainView:buildUI()
	BoccaccioChapter4MainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")

	local cellProgress = self:getGo("prize/cell")
	local tabProgress = self:getGo("prize/tableview")

	self._tableviewProgress = ScrollerList.create(tabProgress, cellProgress, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))
	self._progressBar = self:getSlider("prize/tableview/viewport/content/progressBar")
	self._txtNumDamage = self:getTxt("prize/damageNum/txtNum")
	self._txtScore = self:getTxt("score/txt")
	self._btnFight = self:getGo("btnFight")
	self._txtTimes = self:getTxt("times/txt")
	self._btnTrail = self:getGo("btnTrail")
	self._btnLeft = self:getGo("btnLeft")
	self._btnRight = self:getGo("btnRight")
	self._stageCell = self:getGo("stageCol/stageCell")
	self._stageView = self:getGo("stageCol/stageView")
	self._btnRank = self:getGo("btnRank")
	self._con = self:getGo("con")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnTip = self:getGo("leftTop/btnTip")
end

function BoccaccioChapter4MainView:onExit()
	BoccaccioChapter4MainView.super.onExit(self)
	self._tableviewProgress:dispose()
	self:_onClearStageCol()

	self._loader = RoleObjectPool.instance:removeRole(self._loader)
end

function BoccaccioChapter4MainView:onEnter()
	BoccaccioChapter4MainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HandlePM_BoccaccioChapterInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.HandlePM_BoccaccioChapterOneClickGainProgressPrizeRes, self._updatePrizes, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 580001
	end

	self._curShowStageId = nil

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	self:_switchCurStage(1)
	BoccaccioChapterController.instance:sendPM_BoccaccioChapterInfoReq(self._activityId)
end

function BoccaccioChapter4MainView:_updateUIByCfg()
	self._actCfg = BoccaccioChapterConfig.instance:getActivityData(self._activityId)
	self._progressCfgs = BoccaccioChapterConfig.instance:getProgressPrizeDatas(self._activityId, BoccaccioChapterEnum.ChapterId_4) or {}
	self._clgTimeMax = 0

	if self._actCfg then
		self._clgTimeMax = checknumber(self._actCfg.chapter4DailyClgTimes)
	end

	local stageDataLists = BoccaccioChapterConfig.instance:getChapter1StageDataListsInStar(self._activityId) or {}

	self._stageIdMax = #stageDataLists
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	local skinId = 17027
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[3] then
		local x, y, scale = checknumber(modelCfg[1]), checknumber(modelCfg[2]), 1

		self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self._con, modelCfg[3], nil, true, x, y)
	end
end

function BoccaccioChapter4MainView:_updateUIByInfo()
	self._curLeftTimes = 0
	self._maxSingleBossDamage = 0

	local chapter4Info = BoccaccioChapterController.instance:getChapterInfo(self._activityId, BoccaccioChapterEnum.ChapterId_4)

	if chapter4Info then
		self._curLeftTimes = math.max(0, self._clgTimeMax - checknumber(chapter4Info.todayChallengeTimes))
		self._maxSingleBossDamage = checknumber(chapter4Info.maxSingleBossDamage)
	end

	self._txtTimes.text = langPara("剩余次数:<color=#%s>%d</color>/%d", self._curLeftTimes > 0 and "2ff5a3" or "FF0000", self._curLeftTimes, self._clgTimeMax)
	self._txtScore.text = self:numberToString(self._maxSingleBossDamage)

	self:_updatePrizes()

	self._curShowStageId = nil

	self:_switchCurStage(1)
	BoccaccioChapterController.instance:unlockPlot(self._activityId, BoccaccioChapterEnum.PolotUnlockType.TotalDamage, self._totalBossDamage or 0)
end

function BoccaccioChapter4MainView:_updatePrizes()
	self._totalBossDamage = 0
	self._maxGainProgressId = 0

	local chapter4Info = BoccaccioChapterController.instance:getChapterInfo(self._activityId, BoccaccioChapterEnum.ChapterId_4)

	if chapter4Info then
		self._totalBossDamage = checknumber(chapter4Info.totalBossDamage)
		self._maxGainProgressId = checknumber(chapter4Info.maxGainProgressId)
	end

	local showIndex = -1
	local lastIndex = -1
	local scoreList = {}

	for index, cfg in ipairs(self._progressCfgs) do
		if self._totalBossDamage >= checknumber(cfg.progress) then
			if self._maxGainProgressId < checknumber(cfg.progressId) then
				if showIndex < 0 then
					showIndex = index
				end
			else
				lastIndex = index
			end
		end

		table.insert(scoreList, checknumber(cfg.progress))
	end

	if lastIndex <= 0 then
		lastIndex = 1
	end

	if showIndex < 0 then
		showIndex = lastIndex
	end

	self._tableviewProgress:updateUnderSlider(self._progressBar, self._totalBossDamage, scoreList)
	self._tableviewProgress:reloadData(self._progressCfgs)
	self._tableviewProgress:MoveCellToBegin(showIndex - 1)

	self._txtNumDamage.text = self:numberToString(self._totalBossDamage)
end

function BoccaccioChapter4MainView:_updateProgressCell(view, cell, data)
	local item = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.setCellByCfg(data.prize, item)

	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")

	txtNum.text = self:numberToString(checknumber(data.progress))

	local isGain = self._maxGainProgressId >= checknumber(data.progressId)
	local isMatchGain = not isGain and self._totalBossDamage >= checknumber(data.progress)
	local btnGet = goutil.findChild(cell.gameObject, "btnGet")

	goutil.setActive(btnGet, isMatchGain)

	local effect = goutil.findChild(cell.gameObject, "effect")

	if isMatchGain then
		self:_playCellEffect(effect)
		GameUtil.addClickHandler(btnGet, self._onClickGainPrize, self)
	else
		self:_clearCellEffect(effect)
	end

	local geted = goutil.findChild(cell.gameObject, "geted")

	goutil.setActive(geted, isGain)
end

function BoccaccioChapter4MainView:_clearProgressCell(cell)
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

function BoccaccioChapter4MainView:_onClickGainPrize()
	BoccaccioChapterController.instance:sendPM_BoccaccioChapterOneClickGainProgressPrizeReq(self._activityId, BoccaccioChapterEnum.ChapterId_4)
end

function BoccaccioChapter4MainView:_playCellEffect(effGo)
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

function BoccaccioChapter4MainView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function BoccaccioChapter4MainView:numberToString(num)
	return num >= 100000000 and string.format("%.2f亿", num / 100000000) or num >= 10000 and string.format("%.2f万", num / 10000) or tostring(num)
end

function BoccaccioChapter4MainView:_onClickBtnFight()
	if self._curLeftTimes <= 0 then
		FloatWordMgr.instance:show("今日挑战次数已用完")

		return
	end

	BoccaccioChapterController.instance:enterBattleC4(self._activityId, false)
end

function BoccaccioChapter4MainView:_onClickBtnTrail()
	BoccaccioChapterController.instance:enterBattleC4(self._activityId, true)
end

function BoccaccioChapter4MainView:_onClickBtnLeft()
	if self._curShowStageId and self._curShowStageId > 1 then
		self:_switchCurStage(self._curShowStageId - 1)
	end
end

function BoccaccioChapter4MainView:_onClickBtnRight()
	if self._curShowStageId and self._curShowStageId < self._stageIdMax then
		self:_switchCurStage(self._curShowStageId + 1)
	end
end

function BoccaccioChapter4MainView:_switchCurStage(id)
	if self._curShowStageId == id then
		return
	end

	self._curShowStageId = id

	goutil.setActive(self._btnLeft, self._curShowStageId > 1)
	goutil.setActive(self._btnRight, self._curShowStageId < self._stageIdMax)

	local dataList = BoccaccioChapterConfig.instance:getChapter1StageDataListInStar(self._activityId, self._curShowStageId) or {}

	GameUtil.updateCellsList(self._stageView, self._stageCell, dataList, self._updateStageCell, self)
end

function BoccaccioChapter4MainView:_updateStageCell(mainGo, data, tabIdx)
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local bg = goutil.findChild(mainGo, "bg")
	local tips = goutil.findChild(mainGo, "tips")
	local txtTips = goutil.findChildTextComponent(mainGo, "tips/txt")

	if not data.C4Pos then
		if not data.C4Pos[3] then
			local x, y, scale = checknumber(data.C4Pos[1]), checknumber(data.C4Pos[2]), 1
			local needProgress = checknumber(data.C4UnlockNeed) or 0
			local isMatch = needProgress <= self._totalBossDamage

			GameUtil.setLocalPos(mainGo, x, y)
			GameUtil.setLocalScale(bg, scale)

			txtName.text = data.name

			goutil.setActive(tips, not isMatch)

			txtTips.text = langPara("累计<color=#%s>%s</color>\n伤害可复原", "ff2e2e", self:numberToString(needProgress))

			GameUtil.SetGray(bg, not isMatch)
			GameUtil.setUIImageSpriteIdx(bg, tabIdx - 1)
		end
	end
end

function BoccaccioChapter4MainView:_clearStageCell(mainGo)
	return
end

function BoccaccioChapter4MainView:_onClearStageCol()
	GameUtil.clearCells(self._stageView, self._clearStageCell, self)
end

function BoccaccioChapter4MainView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.BoccaccioChapter4RankView, self._activityId)
end

function BoccaccioChapter4MainView:_onClickBtnTip()
	BoccaccioChapterController.instance:openChapterRule(self._activityId, BoccaccioChapterEnum.ChapterId_4)
end

return BoccaccioChapter4MainView
