-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/armorherolottery/view/ArmorherolotteryresultView.lua

module("logic.extensions.armorherolottery.view.ArmorherolotteryresultView", package.seeall)

local ArmorherolotteryresultView = class("ArmorherolotteryresultView", ViewComponent)

function ArmorherolotteryresultView:ctor()
	ArmorherolotteryresultView.super.ctor(self)
end

function ArmorherolotteryresultView:unbindEvents()
	ArmorherolotteryresultView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function ArmorherolotteryresultView:bindEvents()
	ArmorherolotteryresultView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function ArmorherolotteryresultView:buildUI()
	ArmorherolotteryresultView.super.buildUI(self)

	self._txtLotterTime = self:getTxt("txtLotterTime")
	self._txtScore = self:getTxt("txtScore")
	self._timecellGo = self:getGo("timecell")
	self._timeconGo = self:getGo("timecon")
	self._timeCellLayout = self:getGo("timecon"):GetComponent(ComponentType.UILayoutSingleLine)
	self._btnSure = self:getBtn("btnSure")
	self._txtTitle = self:getTxt("txtTitle")
end

function ArmorherolotteryresultView:onExit()
	ArmorherolotteryresultView.super.onExit(self)
end

function ArmorherolotteryresultView:onEnter()
	ArmorherolotteryresultView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._times = params[2]
	self._ruleIdAndNum = params[3]

	self:_buildTimeCells()
	self:_updateUI()
end

function ArmorherolotteryresultView:_buildTimeCells()
	goutil.setActive(self._timecellGo, false)

	local ruleCfgs = ArmorherolotteryConfig.instance:getRuleCfgs(self._activityId)

	self._timeCellGos = self._timeCellGos or {}

	for i = #ruleCfgs + 1, #self._timeCellGos do
		goutil.setActive(self._timeCellGos[i], false)
	end

	for i = 1, #ruleCfgs do
		if not self._timeCellGos[i] then
			local newTimeCell = goutil.cloneAndSetParent(self._timecellGo, self._timeconGo.transform)

			goutil.setActive(newTimeCell, true)
			table.insert(self._timeCellGos, newTimeCell)
		else
			goutil.setActive(self._timeCellGos[i], true)
		end
	end

	self._timeCellLayout:Layout()
end

function ArmorherolotteryresultView:_updateUI()
	self:_updateTimeCells()

	self._txtLotterTime.text = self._times
end

function ArmorherolotteryresultView:_updateTimeCells()
	self:_initRuleTimes()

	local score = 0
	local ruleCfgs = ArmorherolotteryConfig.instance:getRuleCfgs(self._activityId)

	for i, v in ipairs(ruleCfgs) do
		self:_updateOneTimeCell(i)

		score = score + v.score * self:_getRuleTime(i)
	end

	self._txtScore.text = score
end

function ArmorherolotteryresultView:_initRuleTimes()
	self._ruleTimes = {}

	for i, v in ipairs(self._ruleIdAndNum) do
		self._ruleTimes[v.left] = v.right
	end
end

function ArmorherolotteryresultView:_getRuleTime(ruleId)
	return self._ruleTimes[ruleId] or 0
end

function ArmorherolotteryresultView:_updateOneTimeCell(ruleId)
	local go = self._timeCellGos[ruleId]
	local ruleCfg = ArmorherolotteryConfig.instance:getRuleCfg(self._activityId, ruleId)
	local txtTime = goutil.findChildTextComponent(go, "txtTime")
	local txtName = goutil.findChildTextComponent(go, "txtName")

	txtName.text = ruleCfg.name
	txtTime.text = self:_getRuleTime(ruleId)
end

function ArmorherolotteryresultView:_onClickbtnSure()
	self:close()
end

return ArmorherolotteryresultView
