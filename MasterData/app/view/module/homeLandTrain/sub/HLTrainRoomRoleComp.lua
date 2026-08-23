local var_0_0 = g.core.model.User
local CommonKnight = require("app.view.common.CommonKnight")
local HLTrainRoomRoleComp = class("HLTrainRoomRoleComp", require("app.fairyGUI.homeLandTrain.UI_HLTrainRoomRoleComp"))

function HLTrainRoomRoleComp:ctor()
	self._knightComp = nil
	self._knightId = nil

	self:addClickListener(handler(self, self._onClickRoleComp))
end

function HLTrainRoomRoleComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EXIT, handler(self, self._onModuleExit), self)
end

function HLTrainRoomRoleComp:_onModuleExit()
	self:_showCircleBarAction()
end

function HLTrainRoomRoleComp:_onClickRoleComp()
	self:_showCircleBarAction()
end

function HLTrainRoomRoleComp:_showCircleBarAction()
	self.m_actionCircleBar:runFGAction(fgui.FSequence:create({
		fgui.FFadeIn:create(0.12),
		fgui.FDelayTime:create(4),
		fgui.FFadeOut:create(0.5)
	}))
end

function HLTrainRoomRoleComp:initWithKnightId(arg_6_1)
	if self._knightId == arg_6_1 then
		return
	end

	self._knightId = arg_6_1

	local var_6_0 = self:getChild("CommonKnight")
	local var_6_2

	if var_6_0 then
		self:removeChild(var_6_0)

		self._knightComp = nil
		var_6_2 = {}
	end

	var_6_2.resId = var_0_0.knightsData:getKnightById(arg_6_1):getResInfo().fight_id

	local var_6_3 = CommonKnight.new(var_6_2)

	var_6_3:setPosition(self.m_roleHolderComp:getPosition())
	self:addChild(var_6_3)

	self._knightComp = var_6_3

	self:updateMobilityBar()
end

function HLTrainRoomRoleComp:playAction(arg_7_1, arg_7_2, arg_7_3)
	self._knightComp:playAction(arg_7_1, arg_7_2, arg_7_3)
end

function HLTrainRoomRoleComp:updateMobilityBar()
	if not self._knightId then
		return
	end

	local var_8_0 = var_0_0.knightsData:getKnightById(self._knightId)

	self.m_actionCircleBar:setCurMax(var_8_0:getMobilityVal(), (var_8_0:getMaxMobility()))
	self.m_actionCircleBar:runFGAction(fgui.FSequence:create({
		fgui.FDelayTime:create(1),
		fgui.FFadeOut:create(0.5)
	}))
end

return HLTrainRoomRoleComp
