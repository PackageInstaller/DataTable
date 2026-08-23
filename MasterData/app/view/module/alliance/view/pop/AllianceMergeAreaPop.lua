local var_0_1 = g.core.model.User.areaMergeData
local var_0_2 = g.core.const.ConstMgr.AreaMergeConst
local AllianceMergeAreaPop = class("AllianceMergeAreaPop", require("app.fairyGUI.alliance.UI_AllianceMergeAreaPop"), function()
	return fgui.GComponent:create({
		resName = "AllianceMergeAreaPop",
		pkgPath = "ui/alliance/alliance",
		pkgName = "alliance"
	}, ...)
end)

function AllianceMergeAreaPop:ctor()
	self:showAtCenter()
	self:initView()
	g.core.model.User.dayNotifyTool:saveTodayRecord(require("app.view.common.const.DayNotifyToolConst").TYPE_MERGE_AREA_TIP, true, true)
end

function AllianceMergeAreaPop:initView()
	self._stage = var_0_1:getMergeAreaStage()

	if self._stage == var_0_2.STAGE.PREVIEW then
		self.m_bgPanel:setTitle(g.core.lang:get(430108))
		self.m_titleTip:setText(g.core.lang:get(430103))
		self.m_timeTxt:setText(g.core.lang:get(430104) .. g.core.common.ServerTime:getTimeString((var_0_1:getMergeTime())))
		self.m_descTxt:setText(g.core.lang:get(430110) .. var_0_1:getAllAreasName())
	elseif self._stage == var_0_2.STAGE.MERGE then
		self.m_bgPanel:setTitle(g.core.lang:get(430109))
		self.m_titleTip:setText(g.core.lang:get(430105))
		self.m_timeTxt:setText(g.core.lang:get(430106) .. g.core.common.ServerTime:getTimeString((var_0_1:getMergeAreaEndTime())))
		self.m_descTxt:setText(g.core.lang:get(430107))
	end
end

return AllianceMergeAreaPop
