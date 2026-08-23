local var_0_0 = g.core.model.User.explorationData
local ExplorationFormationDebuffPop = class("ExplorationFormationDebuffPop", require("app.fairyGUI.exploration.UI_ExplorationFormationDebuffPop"), function()
	return fgui.GComponent:create({
		pkgName = "exploration",
		resName = "ExplorationFormationDebuffPop",
		pkgPath = "ui/exploration/exploration"
	}, ...)
end)

function ExplorationFormationDebuffPop:ctor(arg_2_1)
	self._buffInfo = arg_2_1.buffInfo

	self:showAtCenter()
end

function ExplorationFormationDebuffPop:onLoad()
	self:_updateView()
	self:_updateTime()
	self:newSchedule(handler(self, self._updateTime), 1)
end

function ExplorationFormationDebuffPop:_updateView()
	local var_4_0 = math.max(self._buffInfo.initValue - self._buffInfo.ratio * math.floor((g.core.common.ServerTime:getTime() - var_0_0:getTimeData()) / self._buffInfo.time), self._buffInfo.limit) / 10

	var_4_0 = var_4_0 == math.ceil(var_4_0) and tostring(var_4_0) or string.format("%0.1f", var_4_0)

	self.m_effectDesTxt:setText((g.core.lang:get(420699, {
		attrName = self._buffInfo.attrName,
		attrValue = var_4_0,
		ratio = self._buffInfo.ratio / 10
	})))
	self.m_minTipTxt:setText((g.core.lang:get(420700, {
		attrName = self._buffInfo.attrName,
		attrValue = self._buffInfo.limit
	})))
end

function ExplorationFormationDebuffPop:_updateTime()
	local var_5_0 = var_0_0:getTimeData()
	local var_5_1 = g.core.common.ServerTime:getTime()
	local var_5_2 = math.ceil((var_5_1 - var_5_0) / self._buffInfo.time) * self._buffInfo.time
	local var_5_3 = var_5_0 + var_5_2 - var_5_1
	local var_5_4 = ""

	var_5_4 = var_5_0 + var_5_2 - var_5_1 > 86400 and g.core.common.ServerTime:secondToDHMString(var_5_3) or g.core.common.ServerTime:secondToHMString(var_5_3)

	self.m_timeTxt:setText((g.core.lang:get(420701, {
		timeTip = var_5_4
	})))

	if var_5_3 == 0 then
		self:_updateView()
	end
end

function ExplorationFormationDebuffPop:_onClickCloseBtn()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return ExplorationFormationDebuffPop
