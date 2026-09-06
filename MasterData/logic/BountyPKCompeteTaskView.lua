-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/view/BountyPKCompeteTaskView.lua

module("logic.extensions.bountypkcompete.view.BountyPKCompeteTaskView", package.seeall)

local BountyPKCompeteTaskView = class("BountyPKCompeteTaskView", ViewComponent)
local TYPE_DAILY = "daily"
local TYPE_ONCE = "once"

function BountyPKCompeteTaskView:ctor()
	BountyPKCompeteTaskView.super.ctor(self)
end

function BountyPKCompeteTaskView:unbindEvents()
	BountyPKCompeteTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTab1)
	GameUtil.rmClickHandler(self._btnTab2)
end

function BountyPKCompeteTaskView:bindEvents()
	BountyPKCompeteTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTab1, self.onTabClick1, self)
	GameUtil.addClickHandler(self._btnTab2, self.onTabClick2, self)
end

function BountyPKCompeteTaskView:buildUI()
	BountyPKCompeteTaskView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTab1 = self:getGo("tab/btn_1")
	self._dotTab1 = self:getGo("tab/btn_1/dot")
	self._btnTab2 = self:getGo("tab/btn_2")
	self._dotTab2 = self:getGo("tab/btn_2/dot")

	local scrollerGo = self:getGo("middle/tableview")
	local cellGo = self:getGo("middle/cell")

	self.scrollList = ScrollerList.create(scrollerGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function BountyPKCompeteTaskView:onExit()
	BountyPKCompeteTaskView.super.onExit(self)

	local controller = BountyPKCompeteController.instance

	controller:unregisterLocalNotify(BountyPKCompeteController.E_BountyPKGetInfoRes, self.onRefreshUI, self)
	controller:unregisterLocalNotify(BountyPKCompeteController.E_BountyPKDailyTaskPrizeRes, self.onRefreshUI, self)
	self.scrollList:dispose()
end

function BountyPKCompeteTaskView:onEnter()
	BountyPKCompeteTaskView.super.onEnter(self)

	local seasonConfig = BountyPKCompeteConfig.instance:getSeasonConfig(BountyPKCompeteModel.instance:getActivityId())

	self.taskPlanId = seasonConfig.taskPlan
	self.curTabType = TYPE_DAILY

	local controller = BountyPKCompeteController.instance

	controller:registerLocalNotify(BountyPKCompeteController.E_BountyPKGetInfoRes, self.onRefreshUI, self)
	controller:registerLocalNotify(BountyPKCompeteController.E_BountyPKDailyTaskPrizeRes, self.onRefreshUI, self)

	local cfgList = BountyPKCompeteConfig.instance:getTaskConfigsByPlan(self.taskPlanId)

	self._tabList = {
		[TYPE_DAILY] = {},
		[TYPE_ONCE] = {}
	}

	for i, v in pairs(cfgList) do
		table.insert(self._tabList[v.refreshType], v)
	end

	self:onRefreshUI()
end

function BountyPKCompeteTaskView:onRefreshUI()
	local taskMap = BountyPKCompeteModel.instance:getTaskModel()

	table.sort(self._tabList[self.curTabType], function(a, b)
		local objA = taskMap[a.taskId]
		local objB = taskMap[b.taskId]
		local canGainA = checknumber(objA.progress) >= checknumber(a.progress)
		local canGainB = checknumber(objB.progress) >= checknumber(b.progress)

		if objA.received == objB.received then
			if canGainA == canGainB then
				return a.taskId > b.taskId
			elseif canGainA then
				return true
			else
				return false
			end
		else
			return objB.received
		end
	end)
	self.scrollList:reloadData(self._tabList[self.curTabType])

	if self.curTabType == TYPE_DAILY then
		GameUtil.setUIGroupIdx(self._btnTab1, 1)
		GameUtil.setUIGroupIdx(self._btnTab2, 0)
	else
		GameUtil.setUIGroupIdx(self._btnTab1, 0)
		GameUtil.setUIGroupIdx(self._btnTab2, 1)
	end

	GameUtil.SetActive(self._dotTab1, self:isTabRed(TYPE_DAILY))
	GameUtil.SetActive(self._dotTab2, self:isTabRed(TYPE_ONCE))
end

function BountyPKCompeteTaskView:isTabRed(tabType)
	local list = self._tabList[tabType]
	local taskMap = BountyPKCompeteModel.instance:getTaskModel()

	for i, v in ipairs(list) do
		local obj = taskMap[v.taskId]

		if math.min(checknumber(obj.progress), checknumber(v.progress)) >= checknumber(v.progress) and not checkbool(obj.received) then
			return true
		end
	end
end

function BountyPKCompeteTaskView:onTabClick1()
	self:onChangeTab(TYPE_DAILY)
end

function BountyPKCompeteTaskView:onTabClick2()
	self:onChangeTab(TYPE_ONCE)
end

function BountyPKCompeteTaskView:onChangeTab(type)
	if self.curTabType ~= type then
		self.curTabType = type

		self:onRefreshUI()
	end
end

function BountyPKCompeteTaskView:clearCell(cell)
	local btnGainGo = goutil.findChild(cell, "btnGain")
	local item = goutil.findChild(cell, "item")

	GameUtil.rmClickHandler(btnGainGo)
	MaterialMgr.resetAll(item)
end

function BountyPKCompeteTaskView:_updateCell(view, cell, data)
	local hasGainGo = goutil.findChild(cell, "hasGain")
	local noPassGo = goutil.findChild(cell, "noPass")
	local btnGainGo = goutil.findChild(cell, "btnGain")
	local btnGainRedPointGo = goutil.findChild(btnGainGo, "dot")
	local item = goutil.findChild(cell, "item")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
	local txtProgress = goutil.findChildTextComponent(cell, "txtProgress")
	local itemLayout = item:GetComponent(ComponentType.UILayoutSingleLine)

	GameUtil.SetActive(noPassGo, false)
	GameUtil.SetActive(hasGainGo, false)
	GameUtil.SetActive(btnGainGo, false)
	GameUtil.SetActive(btnGainRedPointGo, false)

	local taskMap = BountyPKCompeteModel.instance:getTaskModel()
	local count = 0
	local obj = taskMap[data.taskId]

	if obj then
		count = math.min(checknumber(obj.progress), checknumber(data.progress))

		GameUtil.SetActive(hasGainGo, checkbool(obj.received))
		GameUtil.SetActive(btnGainGo, not checkbool(obj.received))
		GameUtil.SetGray(btnGainGo, count < checknumber(data.progress))
		GameUtil.SetActive(btnGainRedPointGo, count >= checknumber(data.progress) and not checkbool(obj.received))
	end

	txtProgress.text = count .. "/" .. data.progress
	txtDesc.text = data.desc
	txtTitle.text = data.title

	MaterialMgr.resetAll(item)

	for i, v in ipairs(string.split(data.prize or "", "#")) do
		MaterialMgr.setCellByCfg(v, item, nil, nil, false)
	end

	if checknumber(data.scorePrize) > 0 then
		local prizeItemId = BountyPKCompeteConfig.instance:getCommonValue("BOUNTY_ITEM_ID", true)

		MaterialMgr.setCellByCfg(MaterialMgr.createSerName(MatType.Item_Fake, prizeItemId, data.scorePrize), item, nil, nil, false)
	end

	itemLayout:Layout()
	GameUtil.addClickHandler(btnGainGo, GameUtil.handler(self.onClickGain, self, data))
end

function BountyPKCompeteTaskView:onClickGain(data)
	local taskMap = BountyPKCompeteModel.instance:getTaskModel()
	local obj = taskMap[data.taskId]

	if obj and checknumber(obj.progress) >= checknumber(data.progress) and not checkbool(obj.received) then
		BountyPKCompeteAgent.instance:sendPM_BountyPKDailyTaskPrizeReq(data.taskId)

		return
	end

	TipsFacade.instance:openCommonTips(lang("请先完成任务"))
end

return BountyPKCompeteTaskView
