local var_0_0 = g.core.const.ConstMgr.FurnitureConst
local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local var_0_2 = g.core.model.User
local var_0_3 = g.core.model.User.knightsData
local var_0_4 = g.core.model.User.furnitureData
local BaseConfirmPop = require("app.view.base.pop.BaseConfirmPop")
local FurnitureStayInfoPop = class("FurnitureStayInfoPop", require("app.fairyGUI.furniture.UI_FurnitureStayInfoPop"), function()
	return fgui.GComponent:create({
		resName = "FurnitureStayInfoPop",
		pkgPath = "ui/furniture/furniture",
		pkgName = "furniture"
	}, ...)
end)

function FurnitureStayInfoPop:ctor(arg_2_1)
	self._dormId = arg_2_1
	self._ownKnightList = var_0_3:getSpList(self:_getKnightFilter())
	self._checkInList = var_0_4:getCheckInKnightIds()
	self._checkInMap = {}
	self._choseList = clone(self._checkInList[arg_2_1])
	self._choseMap = {}

	self:_initData()
	self:_initView()
end

function FurnitureStayInfoPop:_initData()
	for iter_3_0, iter_3_1 in ipairs(self._checkInList) do
		if iter_3_0 ~= self._dormId then
			for iter_3_2, iter_3_3 in ipairs(iter_3_1) do
				self._checkInMap[iter_3_3] = iter_3_0
			end
		end
	end

	for iter_3_4, iter_3_5 in ipairs(self._choseList) do
		self._choseMap[iter_3_5] = true
	end

	if #self._ownKnightList > 1 then
		table.sort(self._ownKnightList, self:_getSortRule())
	end
end

function FurnitureStayInfoPop:_initView()
	self.m_choseList:setIniter()
	self.m_choseList:setItemRenderer(handler(self, self._onChoseListItemRenderer))
	self.m_choseList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickChoseKnightItem))
	self.m_ownList:setVirtual()
	self.m_ownList:doFairyBatching(false)
	self.m_ownList:setItemRenderer(handler(self, self._onOwnListItemRenderer))
	self.m_ownList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickOwnKnightItem))
	self.m_confirmBtn:addClickListener(handler(self, self._onClickConfirmBtn))
	self:showAtCenter()
end

function FurnitureStayInfoPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_GETINFO, self._onS2CFurnitureRoomGetInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_PLACEKNIGHT, self._onRcvRoomPlaceKnight, self)
	self.m_floorTxt:setText(g.core.lang:get(112509, {
		floor = self._dormId
	}))
	self:_refreshChoseListView()
	self:_refreshOwnListView()
end

function FurnitureStayInfoPop:_getSortRule()
	return function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0:getServerId()
		local var_7_1 = arg_7_1:getServerId()
		local var_7_2

		if self._choseMap[var_7_0] ~= self._choseMap[var_7_1] then
			do return checkbool(self._choseMap[var_7_0]) end

			var_7_2 = checkbool(self._checkInMap[var_7_1])
		end

		if checkbool(self._checkInMap[var_7_0]) ~= var_7_2 then
			return var_7_2
		end

		local var_7_3 = arg_7_0:getMobilityVal()
		local var_7_4 = arg_7_1:getMobilityVal()

		if var_7_3 ~= var_7_4 then
			return var_7_3 < var_7_4
		end

		local var_7_5 = arg_7_0:getQuality()
		local var_7_6 = arg_7_1:getQuality()

		if var_7_5 ~= var_7_6 then
			return var_7_6 < var_7_5
		end

		local var_7_7 = arg_7_0:getStarLv()
		local var_7_8 = arg_7_1:getStarLv()

		if var_7_7 == var_7_8 then
			return var_7_1 < var_7_0
		else
			return var_7_8 < var_7_7
		end
	end
end

function FurnitureStayInfoPop:_getKnightFilter()
	return function(arg_9_0)
		return arg_9_0:isCanCheckIn()
	end
end

function FurnitureStayInfoPop:_refreshChoseListView()
	self.m_choseList:setNumItems(var_0_0.FURNITURE_KNIGHT_MAX)
end

function FurnitureStayInfoPop:_refreshOwnListView()
	self.m_ownList:setNumItems(#self._ownKnightList)
end

function FurnitureStayInfoPop:_onChoseListItemRenderer(arg_12_1, arg_12_2)
	arg_12_1 = arg_12_1 + 1

	arg_12_2:updateCell(arg_12_1, self._dormId, self._choseList[arg_12_1])
end

function FurnitureStayInfoPop:_onOwnListItemRenderer(arg_13_1, arg_13_2)
	local var_13_0 = self._ownKnightList[arg_13_1 + 1]:getServerId()

	arg_13_2:updateCell(self._ownKnightList[arg_13_1 + 1], checkbool(self._choseMap[var_13_0]), self._checkInMap[var_13_0])
end

function FurnitureStayInfoPop:_onClickChoseKnightItem(arg_14_1)
	local var_14_0 = self._choseList[arg_14_1:getDataValue() + 1]

	if not var_14_0 then
		return
	end

	for iter_14_0, iter_14_1 in ipairs(self._ownKnightList) do
		if iter_14_1:getServerId() == var_14_0 then
			self:_changeChoseState(iter_14_0 - 1, var_14_0)

			break
		end
	end
end

function FurnitureStayInfoPop:_onClickOwnKnightItem(arg_15_1)
	local var_15_0 = arg_15_1:getDataValue()
	local var_15_1 = self._ownKnightList[var_15_0 + 1]:getServerId()

	if self._choseMap[var_15_1] then
		self:_changeChoseState(var_15_0, var_15_1)

		return
	end

	local var_15_2 = #self._choseList

	if #self._choseList >= var_0_0.FURNITURE_KNIGHT_MAX then
		g.core.module.ModuleManager:tip(g.core.lang:get(112534))

		return
	end

	if var_15_2 >= var_0_4:getCheckInCountLimit(self._dormId) then
		g.core.module.ModuleManager:tip(g.core.lang:get(112511, {
			level = var_0_4:getUnlockLevelByCount(self._dormId, var_15_2 + 1)
		}))

		return
	end

	if self._checkInMap[var_15_1] then
		g.core.module.ModuleManager:pushPopup(BaseConfirmPop.new({
			title = g.core.lang:get(112503),
			desc = g.core.lang:get(112521),
			onConfirm = handler(self, function()
				self:_changeChoseState(var_15_0, var_15_1)
			end)
		}))
	elseif var_0_2.hlTrainData:isKnightDispatched(var_15_1) then
		g.core.module.ModuleManager:pushPopup(BaseConfirmPop.new({
			title = g.core.lang:get(112503),
			desc = g.core.lang:get(112542),
			onConfirm = handler(self, function()
				self:_changeChoseState(var_15_0, var_15_1)
			end)
		}))
	else
		self:_changeChoseState(var_15_0, var_15_1)
	end
end

function FurnitureStayInfoPop:_onClickConfirmBtn()
	if self:_isChangedCheckInKnight() then
		local var_18_0 = self:_getSendDataList()

		g.core.network.GameNetProxy:send_C2S_FurnitureRoom_PlaceKnight({
			knight_id = var_18_0
		})
		self:_playWorkSound(var_18_0)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(112530))
	end
end

function FurnitureStayInfoPop:_playWorkSound(arg_19_1)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs(arg_19_1) do
		if iter_19_1.knight_id then
			for iter_19_2, iter_19_3 in pairs(iter_19_1.knight_id) do
				table.insert(var_19_0, iter_19_3)
			end
		end
	end

	if #var_19_0 > 0 then
		local var_19_1 = var_19_0[1]
		local var_19_2

		if #var_19_0 > 1 then
			var_19_1 = var_19_0[math.random(1, #var_19_0)]
			var_19_2 = {
				voiceType = "work_sound"
			}
		end

		var_19_2.knight = var_0_2.knightsData:getKnight({
			id = var_19_1
		})

		KnightVoiceCommon.playVoice(var_19_2)
	end
end

function FurnitureStayInfoPop:_onRcvRoomPlaceKnight()
	g.core.module.ModuleManager:popModule()
end

function FurnitureStayInfoPop:_onS2CFurnitureRoomGetInfo()
	self:_refreshChoseListView()
	self:_refreshOwnListView()
end

function FurnitureStayInfoPop:_changeChoseState(arg_22_1, arg_22_2)
	local var_22_0 = not self._choseMap[arg_22_2]

	self._choseMap[arg_22_2] = not self._choseMap[arg_22_2]

	if var_22_0 then
		table.insert(self._choseList, arg_22_2)
	else
		table.removebyvalue(self._choseList, arg_22_2, false)
	end

	local var_22_1 = self.m_ownList:itemIndexToChildIndex(arg_22_1)

	if var_22_1 >= 0 and var_22_1 < self.m_ownList:numChildren() then
		self.m_ownList:getChildAt(var_22_1):setChose(var_22_0)
	end

	self:_refreshChoseListView()
end

function FurnitureStayInfoPop:_isChangedCheckInKnight()
	local var_23_0 = self._checkInList[self._dormId]

	if #(self._checkInList[self._dormId] or {}) ~= #self._choseList then
		return true
	elseif #self._choseList == 0 then
		return false
	elseif #self._choseList == 1 then
		return var_23_0[1] ~= self._choseList[1]
	else
		local var_23_1 = " "
		local var_23_2 = clone(var_23_0)

		table.sort(var_23_2)

		local var_23_3 = table.concat(var_23_2, var_23_1)
		local var_23_4 = clone(self._choseList)

		table.sort(var_23_4)

		return var_23_3 ~= table.concat(var_23_4, var_23_1)
	end
end

function FurnitureStayInfoPop:_getSendDataList()
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(self._choseList) do
		if self._checkInMap[iter_24_1] then
			var_24_0[self._checkInMap[iter_24_1]] = var_24_0[self._checkInMap[iter_24_1]] or clone(self._checkInList[self._checkInMap[iter_24_1]])

			table.removebyvalue(var_24_0[self._checkInMap[iter_24_1]], iter_24_1, false)
		end
	end

	local var_24_1 = {
		{
			room_id = self._dormId,
			knight_id = clone(self._choseList)
		}
	}

	for iter_24_2, iter_24_3 in pairs(var_24_0) do
		table.insert(var_24_1, {
			room_id = iter_24_2,
			knight_id = iter_24_3
		})
	end

	return var_24_1
end

function FurnitureStayInfoPop:_getDeltaMobility(arg_25_1)
	local var_25_0 = 0

	if self._checkInMap[arg_25_1] then
		var_25_0 = var_0_4:getRoomInfo(self._dormId):getMobilityRecoverBaseSpeed() / 3600 * self._passedTime
	elseif var_0_2.hlTrainData:isKnightDispatched(arg_25_1) then
		var_25_0 = -var_0_2.hlTrainData:getMobilityBaseCostPerHourWithKnightId(arg_25_1) / 3600 * self._passedTime
	end

	return var_25_0
end

return FurnitureStayInfoPop
