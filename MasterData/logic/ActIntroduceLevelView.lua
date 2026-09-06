-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/actintroduce/view/ActIntroduceLevelView.lua

module("logic.extensions.actintroduce.view.ActIntroduceLevelView", package.seeall)

local ActIntroduceLevelView = class("ActIntroduceLevelView", ViewComponent)

function ActIntroduceLevelView:ctor()
	ActIntroduceLevelView.super.ctor(self)
end

function ActIntroduceLevelView:buildUI()
	self._tabelView = self:getGo("tableview")
	self._tableCell = self:getGo("cell")
	self._goldBarCon = self:getGo("goldBarCon")
	self._scrollRect = goutil.findChildComponent(self.mainGO, "tableview", "ScrollRect")
end

function ActIntroduceLevelView:bindEvents()
	return
end

function ActIntroduceLevelView:unbindEvents()
	return
end

function ActIntroduceLevelView:onEnter()
	self._tabConf = self:getFirstParam()
	self._activityId = checknumber(self._tabConf.params[1])
	self._scrollList = ScrollerList.create(self._tabelView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	GlobalDispatcher:addListener(HuarongRoadController.PM_HuarongRoadBuyQuickPassRes, self._PM_HuarongRoadBuyQuickPassRes, self)
	GlobalDispatcher:addListener(HuarongRoadController.PM_HuarongRoadGetInfoRes, self._afterGetInfo, self)
	HuarongRoadAgent.instance:sendPM_HuarongRoadGetInfoReq(self._activityId)
end

function ActIntroduceLevelView:onExit()
	GlobalDispatcher:removeListener(HuarongRoadController.PM_HuarongRoadBuyQuickPassRes, self._PM_HuarongRoadBuyQuickPassRes, self)
	GlobalDispatcher:removeListener(HuarongRoadController.PM_HuarongRoadGetInfoRes, self._afterGetInfo, self)
	self._scrollList:dispose()

	self._isSetGold = nil
end

function ActIntroduceLevelView:_afterGetInfo()
	self:_refreshView()
	self:_setTopGoldBar()
end

function ActIntroduceLevelView:_refreshView()
	if not self._activityId then
		return
	end

	self._passStageIds = HuarongRoadModel.instance:getPassStageIds(self._activityId)

	local maxLevel = HuarongRoadModel.instance:getMaxLevel(self._activityId)
	local data = HuarongRoadConfig.instance:getStage(self._activityId)

	self._scrollList:reloadData(data)
	self._scrollList:MoveCellToCenter(math.min(maxLevel + 1, #data))
	self:_setTopGoldBar()
end

function ActIntroduceLevelView:_reRoadFinish()
	local maxLevel = HuarongRoadModel.instance:getMaxLevel(self._activityId)

	self._scrollRect.horizontal = maxLevel >= 1
end

function ActIntroduceLevelView:_setTopGoldBar()
	if not self._isSetGold then
		self._isSetGold = true

		local btn_list = {
			{
				showAdd = true,
				id = GameEnum.GoldType.Diamond
			}
		}

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
	end
end

function ActIntroduceLevelView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local btnStart = goutil.findChildButtonComponent(go, "btnBegin")
	local btnStartGo = goutil.findChild(go, "btnBegin")
	local btnQuicklyComplete = goutil.findChildButtonComponent(go, "btnCost")
	local btnQuicklyCompleteGo = goutil.findChild(go, "btnCost")
	local imgCon = goutil.findChild(go, "imgCon")
	local iconLevel = goutil.findChildComponent(go, "iconLevel", "UIImageSpriteChange")
	local txtRule = goutil.findChildTextComponent(go, "txtRule")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtCost = goutil.findChildTextComponent(go, "btnCost/cost/textNum")
	local iconCost = goutil.findChild(go, "btnCost/cost/icon")
	local prizeCon1 = goutil.findChild(go, "prizeItem1")
	local prizeCon1Rev = goutil.findChild(go, "receive1")
	local prizeCon2 = goutil.findChild(go, "prizeItem2")
	local prizeCon2Rev = goutil.findChild(go, "receive2")
	local passGo = goutil.findChild(go, "pass")
	local guideFinger = goutil.findChild(go, "btnBegin/guideFinger")

	txtName.text = data.name

	uGuiUtil.clearImage(imgCon)

	if not string.nilorempty(data.picName) then
		local picPath = GameUrl.getBigbgFolderUrl("saintknight/xiaonuo", data.picName)

		uGuiUtil.setSpriteToImage(imgCon, uGuiUtil.SpriteType.BigBg, picPath)
	end

	txtRule.text = langPara("%dx%d", data.rule[1], data.rule[2])

	local levelDiff = 0

	if data.diff then
		if data.diff == "S" then
			levelDiff = 0
		elseif data.diff == "A" then
			levelDiff = 1
		elseif data.diff == "B" then
			levelDiff = 2
		elseif data.diff == "C" then
			levelDiff = 3
		elseif data.diff == "D" then
			levelDiff = 4
		end
	end

	iconLevel:SetState(levelDiff)
	MaterialMgr.resetAll(prizeCon1)
	MaterialMgr.resetAll(prizeCon2)

	local prizeCfgs = string.split(data.prize, "#")

	if prizeCfgs[1] then
		MaterialMgr.setCellByCfg(prizeCfgs[1], prizeCon1)
	end

	if prizeCfgs[2] then
		MaterialMgr.setCellByCfg(prizeCfgs[2], prizeCon2)
	end

	local costType, costId, costNum
	local var_11_0, var_11_1, var_11_2 = MaterialMgr.getMatParams(data.passCost)

	costId = var_11_1
	costType = var_11_0
	txtCost.text = langPara("%d", checknumber(var_11_2))

	MaterialMgr.setIcon(iconCost, var_11_0, var_11_1)
	GameUtil.addClickHandler(btnStart, function()
		self:_onClickStart(data.stageId)
	end)
	GameUtil.addClickHandler(btnQuicklyComplete, function()
		self:_onClickQuicklyComplete(data.stageId)
	end)

	local pass = false
	local maxLevel = HuarongRoadModel.instance:getMaxLevel(self._activityId)
	local needHide = false
	local needHideQuickLy = false

	for i, v in ipairs(self._passStageIds) do
		if data.stageId == v then
			pass = true
		end
	end

	goutil.setActive(guideFinger, needHideQuickLy)
	goutil.setActive(btnStartGo, not needHide and not pass)
	goutil.setActive(btnQuicklyCompleteGo, not needHide and not needHideQuickLy and not pass)
	goutil.setActive(passGo, not needHide and pass)
	goutil.setActive(prizeCon1Rev, pass and prizeCfgs[1])
	goutil.setActive(prizeCon2Rev, pass and prizeCfgs[2])
end

function ActIntroduceLevelView:_clearCell(cell)
	local go = cell.gameObject
	local btnStart = goutil.findChildButtonComponent(go, "btnBegin")
	local imgCon = goutil.findChild(go, "imgCon")
	local prizeCon1 = goutil.findChild(go, "prizeItem1")
	local prizeCon2 = goutil.findChild(go, "prizeItem2")
	local iconCost = goutil.findChild(go, "btnCost/cost/icon")

	uGuiUtil.clearImage(imgCon)
	MaterialMgr.resetAll(prizeCon1)
	MaterialMgr.resetAll(prizeCon2)
	MaterialMgr.clearIcon(iconCost)
	GameUtil.rmClickHandler(btnStart)
end

function ActIntroduceLevelView:_onClickStart(stageId)
	local totalTimes = HuarongRoadConfig.instance:challengeDailyTimes(self._activityId)
	local playTimes = HuarongRoadModel.instance:getPlayCount(self._activityId)
	local enterTimes = totalTimes - playTimes

	if enterTimes > 0 then
		UIStateManager.instance:push(ViewName.HuarongRoadGameView, self._activityId, stageId)
	else
		FloatWordMgr.instance:show("今日通关次数已达上限")
	end
end

function ActIntroduceLevelView:_onClickQuicklyComplete(stageId)
	local totalTimes = HuarongRoadConfig.instance:challengeDailyTimes(self._activityId)
	local playTimes = HuarongRoadModel.instance:getPlayCount(self._activityId)
	local enterTimes = totalTimes - playTimes
	local cfg = HuarongRoadConfig.instance:getGameStageCfg(self._activityId, stageId)

	if enterTimes > 0 then
		local type, id, num = MaterialMgr.getMatParams(cfg.passCost)

		TipsFacade.instance:openPopupCostMatViewNew(type, id, num, langPara("确定要花费%d%s，直接一键通过%s?", num, MaterialMgr.getMaterialsName(type, id), cfg.name), function()
			self:_buyCompleteGame(stageId)
		end)
	else
		FloatWordMgr.instance:show("今日通关次数已达上限")
	end
end

function ActIntroduceLevelView:_buyCompleteGame(stageId)
	HuarongRoadAgent.instance:sendPM_HuarongRoadBuyQuickPassReq(self._activityId, stageId)
end

function ActIntroduceLevelView:_PM_HuarongRoadBuyQuickPassRes()
	self:_refreshView()
end

return ActIntroduceLevelView
