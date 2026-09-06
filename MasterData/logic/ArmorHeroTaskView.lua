-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/armorhero/view/ArmorHeroTaskView.lua

module("logic.extensions.armorhero.view.ArmorHeroTaskView", package.seeall)

local ArmorHeroTaskView = class("ArmorHeroTaskView", ViewComponent)

function ArmorHeroTaskView:ctor()
	ArmorHeroTaskView.super.ctor(self)
end

function ArmorHeroTaskView:unbindEvents()
	ArmorHeroTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGain)
end

function ArmorHeroTaskView:bindEvents()
	ArmorHeroTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnGain, self._onClickGainPrize, self)
end

function ArmorHeroTaskView:buildUI()
	ArmorHeroTaskView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnGain = self:getGo("btnGain")
	self._markHasGain = self:getGo("markHasGain")
	self._showPrizeIcon = self:getGo("showPrizeIcon")

	local goTableview = self:getGo("tableview")
	local goTablecell = self:getGo("tableview/Viewport/Content/tablecell")

	self._tableviewTask = ScrollerList.create(goTableview, goTablecell, GameUtil.handler(self._updateTaskCell, self), GameUtil.handler(self._clearTaskCell, self))
end

function ArmorHeroTaskView:onExit()
	ArmorHeroTaskView.super.onExit(self)
	self._tableviewTask:dispose()
	MaterialMgr.resetAll(self._showPrizeIcon)
end

function ArmorHeroTaskView:onEnter()
	ArmorHeroTaskView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_ArmorHeroGainTaskPrizeRes, self._updateUIByInfo, self)

	self._activityId = 540001

	local params = self:getOpenParam()

	if params and params[1] then
		self._activityId = checknumber(params[1])
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
end

function ArmorHeroTaskView:_updateUIByCfg()
	self._actCfg = ArmorHeroConfig.instance:getActivityCfgByActId(self._activityId)

	if not self._actCfg.taskPrize then
		MaterialMgr.setCellByCfg(self._actCfg.taskPrize, self._showPrizeIcon)

		self._taskDescCfgs = ArmorHeroConfig.instance:getTaskDescCfgsByPlanId(self._actCfg.taskDescPlanId) or {}

		self._tableviewTask:reloadData(self._taskDescCfgs)

		if not self._actCfg.prizeOpenTime then
			local prizeOpenTime = ""

			self._dateOpen = GameUtil.string2date(prizeOpenTime)
			self._timeOpenStamp = GameUtil.string2time(prizeOpenTime)
		end
	end
end

function ArmorHeroTaskView:_updateUIByInfo()
	self._isGainTaskPrzie = false

	local info = ArmorHeroModel.instance:getInfo(self._activityId)

	if info then
		self._isGainTaskPrzie = info.hasGainTaskPrize or false
	end

	goutil.setActive(self._markHasGain, self._isGainTaskPrzie)

	if self:_isAllTaskComplete() and self:_isTimeOk() then
		GameUtil.SetGray(self._btnGain, false)
	else
		GameUtil.SetGray(self._btnGain, true)
	end
end

function ArmorHeroTaskView:_onClickGainPrize()
	if self._isGainTaskPrzie then
		FloatWordMgr.instance:show(lang("已经领取过该奖励"))

		return
	end

	if not self:_isAllTaskComplete() then
		FloatWordMgr.instance:show(lang("请完成所有任务后领取奖励"))

		return
	end

	if not self:_isTimeOk() then
		local tipsStr = string.format("%s月%s日05:00后可领取", self._dateOpen.month, tostring(self._dateOpen.day))

		FloatWordMgr.instance:show(tipsStr)

		return
	end

	ArmorHeroController.instance:sendGainTaskPrize(self._activityId)
end

function ArmorHeroTaskView:_isAllTaskComplete()
	for _, cfg in ipairs(self._taskDescCfgs) do
		if cfg then
			local isFinish = ArmorHeroModel.instance:isfinishTask(self._activityId, cfg.taskType)

			if not isFinish then
				return false
			end
		end
	end

	return true
end

function ArmorHeroTaskView:_isTimeOk()
	return ServerTime.now() >= self._timeOpenStamp
end

function ArmorHeroTaskView:_updateTaskCell(view, cell, data)
	local txtdesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtTitle = goutil.findChildTextComponent(cell.gameObject, "txtTitle")
	local finishGo = goutil.findChild(cell.gameObject, "finishGo")
	local notFinishGo = goutil.findChild(cell.gameObject, "notFinishGo")

	txtdesc.text = data.taskdesc or ""
	txtTitle.text = string.format("任务%s", GameUtil.getChineseNumber(data.taskId) or "")

	local isFinish = ArmorHeroModel.instance:isfinishTask(self._activityId, data.taskType)

	goutil.setActive(finishGo, isFinish)
	goutil.setActive(notFinishGo, not isFinish)
end

function ArmorHeroTaskView:_clearTaskCell(cell)
	return
end

return ArmorHeroTaskView
