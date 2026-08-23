local var_0_0 = g.core.model.User.gveDataMgr
local var_0_1 = g.core.model.User.gveDataMgr:getGveInstituteData()
local var_0_2 = g.core.const.ConstMgr.GveConst
local GveInstitutePop = class("GveInstitutePop", require("app.fairyGUI.gve.UI_GveInstitutePop"), function()
	return fgui.GComponent:create({
		pkgName = "gve",
		resName = "GveInstitutePop",
		pkgPath = "ui/gve/gve"
	}, ...)
end)

function GveInstitutePop:ctor(arg_2_1)
	var_0_1 = var_0_0:getGveInstituteData()

	local var_2_0 = arg_2_1 and arg_2_1.route2

	self:showAtCenter()

	self._eventStructList = var_0_1:getInstituteStruct()
	self._compList = {}

	self:initTab()

	self._isFirstEnter = true

	self.m_bgComp:setIcon("bg/gve/bg_pshc_tanchuang.jpg")

	self._curIndex = 1
	self._defaultJumpIndex = nil

	if var_2_0 then
		for iter_2_0, iter_2_1 in ipairs(self._eventStructList) do
			if iter_2_1:getEventCfg().type == var_2_0 then
				self._defaultJumpIndex = iter_2_0

				break
			end
		end
	end

	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabChanged))
end

function GveInstitutePop:initTab()
	for iter_3_0, iter_3_1 in ipairs(self._eventStructList) do
		self["m_tab" .. iter_3_0]:setTitle(iter_3_1:getName())

		if self:checkIsLock(iter_3_1) then
			self["m_tab" .. iter_3_0]:setCtrlState("lock", {
				index = 1
			})
		else
			self["m_tab" .. iter_3_0]:setCtrlState("lock", {
				index = 0
			})
		end
	end
end

function GveInstitutePop:checkIsLock(arg_4_1)
	if arg_4_1:isNeedCheckLock() then
		if var_0_0:getGveData():hasKillBoss() then
			return false
		else
			return true
		end
	end

	return false
end

function GveInstitutePop:onLoad()
	if self._defaultJumpIndex then
		self.m_tabController:setSelectedIndex(self._defaultJumpIndex - 1)

		self._defaultJumpIndex = nil
	else
		self.m_tabController:setSelectedIndex(self._curIndex - 1)
	end

	self:changeTag()

	for iter_5_0, iter_5_1 in ipairs(self._eventStructList) do
		self["m_tab" .. iter_5_0]:setRedPointId(iter_5_1:getRedPointId())
	end

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_GETRESEARCHINFO, self._onGetResearchInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self.requestResearchInfo, self)
	self:requestResearchInfo()
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_PSXY_MenuOpen)
	self:newSchedule(handler(self, self._onCD), 1)
end

function GveInstitutePop:_onGetResearchInfo()
	for iter_6_0, iter_6_1 in ipairs(self._compList) do
		iter_6_1:updateGICompShow()
	end
end

function GveInstitutePop:_onCD(arg_7_1)
	for iter_7_0, iter_7_1 in pairs(self._compList) do
		if iter_7_1:isVisible() and iter_7_1.onCD then
			iter_7_1:onCD(arg_7_1)
		end
	end
end

function GveInstitutePop:_onTabChanged()
	if self:checkIsLock(self._eventStructList[self.m_tabController:getSelectedIndex() + 1]) then
		self._withOutAnim = true

		self.m_tabController:setSelectedIndex(self._curIndex - 1)
		g.core.module.ModuleManager:tip(g.core.lang:get(309179))

		return
	end

	self:changeTag()

	self._curIndex = self.m_tabController:getSelectedIndex() + 1
end

function GveInstitutePop:requestResearchInfo()
	g.core.network.GameNetProxy:send_C2S_GVE_GetResearchInfo({})
end

function GveInstitutePop:changeTag()
	local var_10_0 = self.m_tabController:getSelectedIndex() + 1

	for iter_10_0, iter_10_1 in pairs(self._compList) do
		iter_10_1:setVisible(false)
	end

	if not self._compList[var_10_0] then
		local var_10_1 = fgui.UIPackage:createObject("gve", self._eventStructList[var_10_0]:getCompName())

		self.m_compHolder:addChild(var_10_1)

		self._compList[var_10_0] = var_10_1

		self._compList[var_10_0]:updateGveCompObj(self._eventStructList[var_10_0])
	else
		self._compList[var_10_0]:setVisible(true)
	end

	if not self._withOutAnim then
		self._compList[var_10_0]:playEnterAnim()

		local var_10_2 = self._eventStructList[var_10_0]:getEventCfg().type

		if var_10_2 == var_0_2.GVE_INSTITUTE_TYPE.RAND_BOSS then
			self.m_bgComp:playEnterKill()
		elseif var_10_2 == var_0_2.GVE_INSTITUTE_TYPE.RESEARCH then
			self.m_bgComp:playEnterGrad()
		end
	end

	self._withOutAnim = false
end

return GveInstitutePop
