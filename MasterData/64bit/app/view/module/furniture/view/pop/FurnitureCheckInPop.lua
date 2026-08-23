local var_0_0 = g.core.config.dormroom_info
local var_0_1 = g.core.model.User.furnitureData
local BaseConfirmPop = require("app.view.base.pop.BaseConfirmPop")
local var_0_3 = g.core.model.User.knightsData
local var_0_4 = g.core.model.User.hlTrainData
local FurnitureCheckInPop = class("FurnitureCheckInPop", require("app.fairyGUI.furniture.UI_FurnitureCheckInPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/furniture/furniture",
		resName = "FurnitureCheckInPop",
		pkgName = "furniture"
	}, ...)
end)

function FurnitureCheckInPop:ctor()
	self._scheduler = nil
	self._passedTime = 0
	self._isOneKeyRelease = false
	self._isOneKeyCheckIn = false

	self:showAtCenter()
	self.m_stayList:setVirtual(self)
	self.m_stayList:setItemRenderer(handler(self, self._onStayItemRender))

	self._dormCount = var_0_0.getLength()

	local var_2_0 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.FURNITURE_ONEKEY_CHECKIN)
	local var_2_1 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.FURNITURE_ONEKEY_RELEASE)

	self.m_oneKeyStayIn:setVisible(var_2_0)
	self.m_oneKeyRelease:setVisible(var_2_1)
	self.m_oneKeyStayIn:addClickListener(handler(self, self._onClickOneKeyCheckIn))
	self.m_oneKeyRelease:addClickListener(handler(self, self._onClickOneKeyRelease))
	self.m_openOneKeyController:setSelectedIndex((var_2_0 or var_2_1) and 1 or 0)
end

function FurnitureCheckInPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_GETINFO, self._onS2CFurnitureRoomGetInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_PLACEKNIGHT, self._onRcvPlaceKnightsChange, self)
	self.m_stayList:setNumItems(self._dormCount)
end

function FurnitureCheckInPop:_onS2CFurnitureRoomGetInfo()
	self.m_stayList:setNumItems(self._dormCount)
end

function FurnitureCheckInPop:_onRcvPlaceKnightsChange()
	self.m_stayList:setNumItems(self._dormCount)

	if self._isOneKeyRelease then
		g.core.module.ModuleManager:tip(g.core.lang:get(111056))
	end

	self._isOneKeyRelease = false

	if self._isOneKeyCheckIn then
		g.core.module.ModuleManager:tip(g.core.lang:get(112564))
	end

	self._isOneKeyCheckIn = false
end

function FurnitureCheckInPop:_onStayItemRender(arg_6_1, arg_6_2)
	arg_6_2:updateCell(arg_6_1 + 1)
end

function FurnitureCheckInPop:_onClickOneKeyCheckIn()
	local var_7_0 = {}
	local var_7_1 = false

	for iter_7_0 = 1, self._dormCount do
		if var_0_1:isDormUnlocked(iter_7_0) then
			local var_7_2 = var_0_1:getCheckInCountLimit(iter_7_0) - #var_0_1:getCheckInKnightIdsWithDormId(iter_7_0)

			var_7_0[iter_7_0] = var_7_2

			if var_7_2 > 0 then
				var_7_1 = true
			end
		end
	end

	if not var_7_1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(112561))

		return
	end

	local var_7_3 = var_0_3:getSpList(function(arg_8_0)
		if arg_8_0:isCanBeDispatched() and not var_0_1:isKnightCheckIn(arg_8_0:getServerId()) then
			return arg_8_0:getMobilityVal() < arg_8_0:getMaxMobility()
		end
	end, nil, true)

	if #var_7_3 == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(112562))

		return
	end

	table.sort(var_7_3, function(arg_9_0, arg_9_1)
		local var_9_0 = var_0_4:isKnightDispatched(arg_9_0:getServerId()) and arg_9_0:getMobilityVal() <= 0 and 0 or 1
		local var_9_1 = var_0_4:isKnightDispatched(arg_9_1:getServerId()) and arg_9_1:getMobilityVal() <= 0 and 0 or 1

		if var_9_0 ~= var_9_1 then
			return var_9_0 < var_9_1
		end

		return arg_9_0:getMobilityVal() < arg_9_1:getMobilityVal()
	end)

	local var_7_4 = {}
	local var_7_5 = {}
	local var_7_6 = 1

	for iter_7_1, iter_7_2 in pairs(var_7_0) do
		if iter_7_2 > 0 then
			local var_7_7 = clone(var_0_1:getCheckInKnightIdsWithDormId(iter_7_1))

			for iter_7_3 = 1, iter_7_2 do
				local var_7_8 = var_7_3[var_7_6]:getServerId()

				if var_0_4:isKnightDispatched(var_7_8) then
					table.insert(var_7_5, var_7_8)
				end

				table.insert(var_7_7, var_7_8)

				var_7_6 = var_7_6 + 1

				if var_7_6 > #var_7_3 then
					break
				end
			end

			table.insert(var_7_4, {
				room_id = iter_7_1,
				knight_id = var_7_7
			})
		end

		if var_7_6 > #var_7_3 then
			break
		end
	end

	if next(var_7_5) then
		g.core.module.ModuleManager:pushPopup(BaseConfirmPop.new({
			title = g.core.lang:get(112503),
			desc = g.core.lang:get(112563),
			onConfirm = function()
				g.core.network.GameNetProxy:send_C2S_FurnitureRoom_PlaceKnight({
					knight_id = var_7_4
				})

				self._isOneKeyCheckIn = true
			end
		}))
	else
		g.core.network.GameNetProxy:send_C2S_FurnitureRoom_PlaceKnight({
			knight_id = var_7_4
		})

		self._isOneKeyCheckIn = true
	end
end

function FurnitureCheckInPop:_onClickOneKeyRelease()
	local var_11_0 = {}

	for iter_11_0 = 1, self._dormCount do
		if #var_0_1:getCheckInKnightIdsWithDormId(iter_11_0) > 0 then
			table.insert(var_11_0, {
				room_id = iter_11_0,
				knight_id = {
					0,
					0,
					0,
					0,
					0
				}
			})
		end
	end

	if next(var_11_0) then
		g.core.module.ModuleManager:pushPopup(BaseConfirmPop.new({
			title = g.core.lang:get(112507),
			desc = g.core.lang:get(112560),
			onConfirm = function()
				g.core.network.GameNetProxy:send_C2S_FurnitureRoom_PlaceKnight({
					knight_id = var_11_0
				})

				self._isOneKeyRelease = true
			end
		}))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(112559))
	end
end

return FurnitureCheckInPop
