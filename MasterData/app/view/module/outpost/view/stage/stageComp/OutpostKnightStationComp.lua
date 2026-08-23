local OutpostKnightStationComp = class("OutpostKnightStationComp", require("app.fairyGUI.outpost.UI_OutpostKnightStationComp"))

function OutpostKnightStationComp:ctor()
	self._struct = nil

	self.m_locationBtn:addClickListener(handler(self, self.onLocationClick))
	self.m_knightComp:addClickListener(handler(self, self.onShowKnightDetail))
end

function OutpostKnightStationComp:updateKnightShow(arg_2_1)
	self.m_knightComp:updateKnightWithStruct(arg_2_1)

	self._struct = arg_2_1

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			sid = arg_2_1:getServerId()
		}
	})
	self.m_areaTxt:setText(g.core.lang:get(432674, {
		name = g.core.model.User.outpostData:getAllArenaInfo()[arg_2_1:getOwnTargetArena()].subName
	}))
end

function OutpostKnightStationComp:onLocationClick()
	self:dispatchCompEvent("OutpostKnightStationComp_jump_knight", {
		struct = self._struct
	})
end

function OutpostKnightStationComp:onShowKnightDetail()
	self:dispatchCompEvent("Outpost_close_Knight_comp")
	g.core.module.ModuleManager:pushModule(g.view.entrance.OUT_POST_KNIGHT_DETAIL, {
		struct = self._struct
	})
end

return OutpostKnightStationComp
