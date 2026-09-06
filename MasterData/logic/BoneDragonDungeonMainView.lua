-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragondungeon/view/BoneDragonDungeonMainView.lua

module("logic.extensions.bonedragondungeon.view.BoneDragonDungeonMainView", package.seeall)

local BoneDragonDungeonMainView = class("BoneDragonDungeonMainView", ViewComponent)

function BoneDragonDungeonMainView:ctor()
	BoneDragonDungeonMainView.super.ctor(self)
end

function BoneDragonDungeonMainView:unbindEvents()
	BoneDragonDungeonMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function BoneDragonDungeonMainView:bindEvents()
	BoneDragonDungeonMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function BoneDragonDungeonMainView:buildUI()
	BoneDragonDungeonMainView.super.buildUI(self)

	self._btnStart = self:getGo("btnStart")
	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._tableView = self:getGo("tableView")
	self._tableCell = self:getGo("tableView/tableCell")
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtGameTime = self:getTxt("gameTime/txtGameTime")
	self._txtTime = self:getTxt("time/txtTime")
end

function BoneDragonDungeonMainView:onExit()
	BoneDragonDungeonMainView.super.onExit(self)
end

function BoneDragonDungeonMainView:onEnter()
	BoneDragonDungeonMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_BoneDragonDungeonGetInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_BoneDragonDungeonGetInfoRes, self._refreshView, self)

	self._activityId = self:getFirstParam() or 490001
	self._activityCfg = BoneDragonDungeonConfig.instance:getActivityCfg(self._activityId)

	BoneDragonDungeonAgent.instance:sendPM_BoneDragonDungeonGetInfoReq(self._activityId)

	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
end

function BoneDragonDungeonMainView:_refreshView()
	local list = BoneDragonDungeonConfig.instance:getProgressCfgs(self._activityId)

	self._tableList:reloadData(list)

	local index = 0

	for i, v in ipairs(list) do
		local isUnLock = MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, self._activityCfg.progressMpKey) >= v.progress
		local isGain = BoneDragonDungeonModel.instance:isGainProgressPrize(self._activityId, v.prizeId)

		if isUnLock and not isGain then
			index = i

			break
		end
	end

	if index ~= 0 then
		self._tableList:MoveCellToCenter(index - 1)
	end

	local gameTime = BoneDragonDungeonModel.instance:getGameTime(self._activityId)

	self._txtGameTime.text = langPara("今日剩余次数：<color=#008AC7>%d/%d</color>", self._activityCfg.dailyGameTimes - gameTime, self._activityCfg.dailyGameTimes)
end

function BoneDragonDungeonMainView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local costIcon = goutil.findChild(go, "icon")
	local prizeCon = goutil.findChild(go, "prize/con")
	local receivedGo = goutil.findChild(go, "prize/received")
	local btnGet = goutil.findChild(go, "btnGet")
	local effGo = goutil.findChild(go, "effect")
	local empty = goutil.findChild(go, "empty")
	local isUnLock = MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, self._activityCfg.progressMpKey) >= data.progress
	local isGain = BoneDragonDungeonModel.instance:isGainProgressPrize(self._activityId, data.prizeId)

	MaterialMgr.setCellByCfg(data.prize, prizeCon)
	uGuiUtil.setSpriteToImage(costIcon, nil, string.format("ui/%s.png", data.icon))
	GameUtil.SetActive(receivedGo, isGain)

	txtDesc.text = data.desc

	GameUtil.SetActive(costIcon, isUnLock)
	GameUtil.SetActive(txtDesc, isUnLock)
	GameUtil.SetActive(empty, not isUnLock)
	GameUtil.SetActive(btnGet, isUnLock and not isGain)
	GameUtil.SetActive(effGo, isUnLock and not isGain)
	GameUtil.addClickHandler(btnGet, function()
		self:_onClickPrize()
	end)
	self:_playEffect(effGo)
end

function BoneDragonDungeonMainView:_clearCell(cell)
	local go = cell.gameObject
	local costIcon = goutil.findChild(go, "icon")
	local prizeCon = goutil.findChild(go, "prize/con")
	local effGo = goutil.findChild(go, "effect")

	MaterialMgr.resetAll(prizeCon)
	uGuiUtil.clearImage(costIcon)
	self:_clearEffect(effGo)
end

function BoneDragonDungeonMainView:_playEffect(effGo)
	self:_clearEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("tableView/viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function BoneDragonDungeonMainView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function BoneDragonDungeonMainView:_onClickPrize()
	BoneDragonDungeonAgent.instance:sendPM_BoneDragonDungeonGainProgressPrizeReq(self._activityId)
end

function BoneDragonDungeonMainView:_onClickStart()
	local gameTime = BoneDragonDungeonModel.instance:getGameTime(self._activityId)
	local curStageId = BoneDragonDungeonModel.instance:getCurStageId(self._activityId)
	local curStagePass = BoneDragonDungeonModel.instance:getCurStagePass(self._activityId)
	local stageCfgs = BoneDragonDungeonConfig.instance:getStageCfgs(self._activityId)
	local maxStageId = #stageCfgs

	if curStageId == 0 then
		UIStateManager.instance:push(ViewName.BoneDragonDungeonGameView, self._activityId, 1)
	elseif curStageId ~= 0 and not curStagePass then
		UIStateManager.instance:push(ViewName.BoneDragonDungeonGameView, self._activityId, curStageId)
	elseif curStagePass == true then
		if maxStageId <= curStageId then
			FloatWordMgr.instance:show(lang("已通关全部关卡"))
		elseif gameTime >= self._activityCfg.dailyGameTimes then
			FloatWordMgr.instance:show(lang("今日游戏次数已经用完，明天再来吧~"))
		else
			UIStateManager.instance:push(ViewName.BoneDragonDungeonGameView, self._activityId, curStageId + 1)
		end
	end
end

function BoneDragonDungeonMainView:_onClickTips()
	TipsFacade.instance:openRulesView("bone_dragon_dungeon_rule")
end

return BoneDragonDungeonMainView
