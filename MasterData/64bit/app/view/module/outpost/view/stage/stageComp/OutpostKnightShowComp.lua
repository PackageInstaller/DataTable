local var_0_0 = g.core.const.ConstMgr.outpostConst
local var_0_1 = g.core.model.User.outpostData
local OutpostKnightShowComp = class("OutpostKnightShowComp", require("app.fairyGUI.outpost.UI_OutpostKnightShowComp"))

function OutpostKnightShowComp:ctor()
	self._knights = {}

	self.m_knightList:setVirtual()
	self.m_knightList:doFairyBatching(false)
	self.m_knightList:setItemRenderer(handler(self, self._onKnightListRenderer))
	self:addListen(self.m_knightList)
	self.m_lineUpBtn:addClickListener(handler(self, self.onKnightAreaChangeClick))
	self.m_changeLineUpBtn:addClickListener(handler(self, self.onLineUpClick))
end

function OutpostKnightShowComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_KNIGHT_ENTRANCE, self.updateCurUpKnights, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_KNIGHT_EXIT, self.updateCurUpKnights, self)
	self:updateCurUpKnights()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_changeLineUpBtn
	})
end

function OutpostKnightShowComp:_onKnightListRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateKnightShow(self._knights[arg_3_1 + 1])
end

function OutpostKnightShowComp:onLineUpClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.OUT_POST_FORMATION_LAYER)
	self:dispatchCompEvent("Outpost_close_Knight_comp")
end

function OutpostKnightShowComp:updateCurUpKnights()
	self._knights = var_0_1:getKnightsData():getAllLineUpKnights()

	self.m_lineUpNumTxt:setText(g.core.lang:get(432607, {
		num1 = #self._knights,
		num2 = var_0_1:getBuildData():getBuild({
			type = var_0_0.BuildType.Main
		}):getMaxRoleNum()
	}))
	self.m_knightList:setNumItems(#self._knights)
	self.m_isEmptyController:setSelectedIndex(#self._knights > 0 and 0 or 1)
end

function OutpostKnightShowComp:onKnightAreaChangeClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.outpost.view.formation.OutpostFormationArenaPop").new()))
	self:dispatchCompEvent("Outpost_close_Knight_comp")
end

function OutpostKnightShowComp:playShow()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	self.m_enterTransition:play(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end)
end

function OutpostKnightShowComp:playHide(arg_9_1)
	if arg_9_1 then
		self.m_backTransition:play(arg_9_1)
	else
		self.m_backTransition:play()
	end
end

return OutpostKnightShowComp
