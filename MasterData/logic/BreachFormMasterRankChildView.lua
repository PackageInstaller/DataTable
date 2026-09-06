-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breachformmaster/view/BreachFormMasterRankChildView.lua

module("logic.extensions.breachformmaster.view.BreachFormMasterRankChildView", package.seeall)

local BreachFormMasterRankChildView = class("BreachFormMasterRankChildView", ViewComponent)

function BreachFormMasterRankChildView:ctor()
	BreachFormMasterRankChildView.super.ctor(self)
end

function BreachFormMasterRankChildView:unbindEvents()
	BreachFormMasterRankChildView.super.unbindEvents(self)
end

function BreachFormMasterRankChildView:bindEvents()
	BreachFormMasterRankChildView.super.bindEvents(self)
end

function BreachFormMasterRankChildView:buildUI()
	BreachFormMasterRankChildView.super.buildUI(self)

	self._txtMyStep = self:getTxt("myRank/txtMyStep")
	self._txtMyRank = self:getTxt("myRank/txtMyRank")
	self._tableview = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._tableList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearRankCell, self))
	self._empty = self:getGo("empty")
	self._prizeItem = self:getGo("reward")
	self._txtTip = self:getTxt("myRank/txtTip")
end

function BreachFormMasterRankChildView:onExit()
	BreachFormMasterRankChildView.super.onExit(self)

	for i, v in pairs(self._itemTableDir) do
		v:dispose()
	end

	self._itemTableDir = {}
end

function BreachFormMasterRankChildView:onEnter()
	BreachFormMasterRankChildView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_BreachFormMasterRankViewReq, self._refreshView, self)

	self._activityId = BreachFormMasterModel.instance:getCurActivityId()

	local params = self:getOpenParam()

	self._rankType = checknumber(params[1])
	self._stepId = checknumber(params[2])
	self._itemTableDir = {}

	local curStepId = BreachFormMasterModel.instance:getCurStepId(self._activityId)

	if curStepId < self._stepId then
		self:_refreshView()
	else
		BreachFormMasterAgent.instance:sendPM_BreachFormMasterRankViewReq(self._activityId, self._rankType, self._stepId)
	end

	local activityCfg = BreachFormMasterConfig.instance:getActivityCfg(self._activityId)

	self._txtTip.text = self._rankType == BreachFormMasterController.ATTACK_RANK_TYPE and activityCfg.attackRankDesc or self._rankType == BreachFormMasterController.DEFECSE_RANK_TYPE and activityCfg.defenseRankDesc or ""
end

function BreachFormMasterRankChildView:_refreshView()
	local rankInfo = BreachFormMasterModel.instance:getRankInfo(self._activityId, self._rankType, self._stepId)

	if rankInfo then
		if not rankInfo.rankInfoList then
			local rankInfoList = {}

			self._tableList:reloadData(rankInfoList)

			if rankInfo then
				self._txtMyStep.text = rankInfo.myScore

				if rankInfo.myRank > 0 then
					self._txtMyRank.text = rankInfo.myRank or lang("未上榜")
				end
			else
				self._txtMyStep.text = 0
				self._txtMyRank.text = lang("未上榜")
			end

			GameUtil.SetActive(self._empty, #rankInfoList <= 0)
		end
	end
end

function BreachFormMasterRankChildView:_updateCell(view, cell, data, tag)
	local goHeadIcon = goutil.findChild(cell.gameObject, "head")
	local imgChangeImgRank = goutil.findChild(cell.gameObject, "imgRank"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtRank = goutil.findChildTextComponent(cell.gameObject, "txtRank")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtScore = goutil.findChildTextComponent(cell.gameObject, "txtScore")
	local txtTime = goutil.findChildTextComponent(cell.gameObject, "txtTime")

	HeadItemController.instance:resetHeadCell(goHeadIcon)
	HeadItemController.instance:setHeadCellByInfo(goHeadIcon, data.headInfo, true)

	local isTop3 = data.rank <= 3

	if isTop3 then
		imgChangeImgRank:SetState(data.rank - 1)
		goutil.setActive(imgChangeImgRank.gameObject, true)
		goutil.setActive(txtRank.gameObject, false)
	else
		goutil.setActive(txtRank.gameObject, true)
		goutil.setActive(imgChangeImgRank.gameObject, false)

		txtRank.text = data.rank
	end

	txtName.text = data.headInfo.userName
	txtScore.text = checknumber(data.value)

	local date = GameUtil.time2date(checkint(checknumber(data.time) / 1000))

	txtTime.text = langPara("%d %d.%d\n%02d:%02d:%02d", date.year, date.month, date.day, date.hour, date.min, date.sec)

	local subTab = self._itemTableDir[cell.gameObject]

	if not subTab then
		local prizeCom = goutil.findChild(cell.gameObject, "rewardView")

		subTab = ScrollerList.create(prizeCom, self._prizeItem, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
		self._itemTableDir[cell.gameObject] = subTab
	end

	local prizeCfg = BreachFormMasterConfig.instance:getRankCfgByRank(self._activityId, self._rankType, self._stepId, data.rank)

	if prizeCfg then
		if not prizeCfg.prize then
			local prize = ""
			local itemList = string.split(prize, "#")

			subTab:reloadData(itemList)
			subTab:MoveCellToBegin(0)
		end
	end
end

function BreachFormMasterRankChildView:_clearRankCell(cell)
	local goHeadIcon = goutil.findChild(cell.gameObject, "head")

	HeadItemController.instance:resetHeadCell(goHeadIcon)

	local subTab = self._subTabs[cell.gameObject]

	if subTab then
		subTab:dispose()
	end
end

function BreachFormMasterRankChildView:_updateItemCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function BreachFormMasterRankChildView:_clearItemCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

return BreachFormMasterRankChildView
