local ExplorationMapCommon = require("app.view.module.exploration.common.ExplorationMapCommon")
local ExplorationConst = require("app.view.module.exploration.const.ExplorationConst")
local ExplorationRoomMiniComp = class("ExplorationRoomMiniComp", require("app.fairyGUI.exploration.UI_ExplorationRoomMiniComp"))

function ExplorationRoomMiniComp:ctor()
	self._roomData = nil
	self._battleIconLoader = nil
	self._bgIconLoader = nil
	self._effectEnable = true
	self._lineDict = {}

	self:addClickListener(handler(self, self._onClickComp))
	self:setTouchable(false)
end

function ExplorationRoomMiniComp:_updateBg(arg_2_1)
	if not self._bgIconLoader then
		self._bgIconLoader = fgui.GLoader:create()

		self._bgIconLoader:setAutoSize(true)
		self:addChild(self._bgIconLoader)
		self._bgIconLoader:setTouchable(false)
	end

	self._bgIconLoader:setURL(arg_2_1)
end

function ExplorationRoomMiniComp:updateMiniComp(arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_1 then
		return
	end

	self._roomData = arg_3_1

	local var_3_0 = arg_3_1:getEntranceList()
	local var_3_1

	if arg_3_1:getMirrorTiled() then
		var_3_1 = "ui://exploration/bg_slmj_mapdi0_zhongdian"
	elseif arg_3_1:getBirthTiled() then
		var_3_1 = "ui://exploration/bg_slmj_mapdi0_qidian"
	elseif arg_3_1:getCfg().difficulty > 1 then
		var_3_1 = "ui://exploration/bg_slmj_mapdi0_zhandou"
	end

	if var_3_1 then
		self:_updateBg(var_3_1)
	end

	local var_3_2 = 0

	for iter_3_0, iter_3_1 in pairs(ExplorationConst.DIRECTION) do
		if var_3_0[iter_3_1] ~= nil then
			var_3_2 = var_3_2 + 1
		end
	end

	if arg_3_3 then
		self.m_stateController:setSelectedIndex(3)
	else
		self.m_stateController:setSelectedIndex(arg_3_1:getRoomState() + 1)
	end

	self:setTouchable(true)
end

function ExplorationRoomMiniComp:_onClickComp()
	self:dispatchCompEvent("moveToMap", {
		closePop = true,
		coord = cc.p(ExplorationMapCommon.getGlobalCoordinateByRoomAndRoomCoordinate(self._roomData, cc.p(4, 4)))
	})
end

function ExplorationRoomMiniComp:setEffectEnable(arg_5_1)
	self._effectEnable = arg_5_1
end

return ExplorationRoomMiniComp
