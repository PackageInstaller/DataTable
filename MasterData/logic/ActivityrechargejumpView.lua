-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/ActivityrechargejumpView.lua

module("logic.extensions.operationsummary.view.ActivityrechargejumpView", package.seeall)

local ActivityrechargejumpView = class("ActivityrechargejumpView", ViewComponent)

function ActivityrechargejumpView:ctor()
	ActivityrechargejumpView.super.ctor(self)
end

function ActivityrechargejumpView:unbindEvents()
	ActivityrechargejumpView.super.unbindEvents(self)
	self._btnJump2:RemoveClickListener()
	self._btnJump1:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function ActivityrechargejumpView:bindEvents()
	ActivityrechargejumpView.super.bindEvents(self)
	self._btnJump2:AddClickListener(self._onClickbtnJump2, self)
	self._btnJump1:AddClickListener(self._onClickbtnJump1, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function ActivityrechargejumpView:buildUI()
	ActivityrechargejumpView.super.buildUI(self)

	self._btnJump2 = self:getBtn("btnJump2")
	self._btnJump1 = self:getBtn("btnJump1")
	self._btnClose = self:getBtn("btnClose")
	self._redpointGo1 = self:getGo("btnJump1/redpoint")
	self._redpointGo2 = self:getGo("btnJump2/redpoint")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "tipR/txtDesc")
	self._godgemGo = self:getGo("godgem")
end

function ActivityrechargejumpView:onExit()
	ActivityrechargejumpView.super.onExit(self)

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end
end

function ActivityrechargejumpView:onEnter()
	ActivityrechargejumpView.super.onEnter(self)
	OpSummaryModel.instance:clearRechargeJumpHudDot()

	self._activityType = GameEnum.ActivityType.Summary
	self._activityId = 17034
	self._jumpTo1 = nil
	self._jumpTo2 = nil

	local isActive = ActivityDefineController.instance:isInActivityTimeById(self._activityType, self._activityId)

	if not isActive then
		FloatWordMgr.instance:show("活动已结束")
		self:close()
	end

	self:_updateView()
	self:_playEffect()
end

function ActivityrechargejumpView:_onClickbtnJump2()
	if not string.nilorempty(self._jumpTo2) then
		GotoMgr.gotoByString(self._jumpTo2)
	end
end

function ActivityrechargejumpView:_onClickbtnJump1()
	if not string.nilorempty(self._jumpTo1) then
		GotoMgr.gotoByString(self._jumpTo1)
	end
end

function ActivityrechargejumpView:_onClickbtnClose()
	self:close()
end

function ActivityrechargejumpView:_updateView()
	self:_setBg()

	local cfgs = OperationSummaryConfig.instance:getTaskItemsCfg(self._activityId)

	if not cfgs then
		printError("activity_summary_task_items没有配置 activityId：", self._activityId)

		return
	end

	local list = {}

	for k, v in pairs(cfgs) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a.id < b.id
	end)

	self._jumpTo1 = list[1] and list[1].gotoStr
	self._jumpTo2 = list[2] and list[2].gotoStr
	self._redIds1 = string.split((list[1] or nil) and (list[1].redpointId or ""), "#")
	self._redIds2 = string.split((list[2] or nil) and (list[2].redpointId or ""), "#")

	self:_checkRedPoint()
end

function ActivityrechargejumpView:_setBg()
	local isOffical = SDKManager.isOfficial()

	goutil.setActive(self._godgemGo, isOffical)

	self._txtDesc.text = isOffical and "限量小诺银饰、年费次元圣龙" or "年费次元圣龙"
end

function ActivityrechargejumpView:_checkRedPoint()
	local red1 = false

	for i, v in ipairs(self._redIds1) do
		red1 = RedPointModel.instance:isActive(checknumber(v))

		if red1 then
			break
		end
	end

	local red2 = false

	for i, v in ipairs(self._redIds2) do
		red2 = RedPointModel.instance:isActive(checknumber(v))

		if red2 then
			break
		end
	end

	goutil.setActive(self._redpointGo1, red1)
	goutil.setActive(self._redpointGo2, red2)
end

function ActivityrechargejumpView:_playEffect()
	local cfg = OperationSummaryConfig.instance:getTaskBaseCfg(self._activityId)

	if cfg then
		local effName = cfg.effect

		if not string.find(effName, ".prefab") then
			effName = effName .. ".prefab"
		end

		self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

		self._effectHandler:setParent(self.mainGO.transform)
		self._effectHandler:setLocalPos(0, 0, 0)
		self._effectHandler:setScale(1)
	end
end

return ActivityrechargejumpView
