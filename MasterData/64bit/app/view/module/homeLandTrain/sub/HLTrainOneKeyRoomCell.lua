local var_0_0 = {
	NO = 0,
	YES = 1
}
local var_0_1 = g.core.model.User.hlTrainData
local HLTrainOneKeyRoomCell = class("HLTrainOneKeyRoomCell", require("app.fairyGUI.homeLandTrain.UI_HLTrainOneKeyRoomCell"))

function HLTrainOneKeyRoomCell:ctor()
	self._indexLua = 0
	self._advId = 0
	self._choseKnightIdArr = {}
	self.m_choseKnightCompArr = {
		self.m_choseKnightComp_1,
		self.m_choseKnightComp_2,
		self.m_choseKnightComp_3
	}

	for iter_1_0, iter_1_1 in ipairs(self.m_choseKnightCompArr) do
		iter_1_1:setIndex(iter_1_0)
		iter_1_1:addClickListener(handler(self, self._onClickChoseKnight))
	end

	self.m_productIconComp:addClickListener(handler(self, self._onClickProductIcon))
	self.m_blankAreaGraph:addClickListener(handler(self, self._onClickBlankArea))
end

function HLTrainOneKeyRoomCell:updateCell(arg_2_1, arg_2_2, arg_2_3)
	self._indexLua = arg_2_1
	self._advId = arg_2_2

	local var_2_0 = var_0_1:getRoomStruct(arg_2_2)

	self._choseKnightIdArr = var_2_0.knightIdArr

	if var_2_0:isUnlocked() then
		self:_updateChoseKnights()
		self.m_roomNameTxt:setText(var_2_0.refCfgBaseInfo.name)
		self.m_productIconComp:updateIcon(var_2_0.productId)
		self.m_unlockedController:setSelectedIndex(1)
	else
		self.m_unlockTipTxt:setText(g.core.lang:get(111045, {
			name = var_2_0.refCfgBaseInfo.name
		}))
		self.m_unlockedController:setSelectedIndex(0)
	end

	self:setChose(arg_2_3)
end

function HLTrainOneKeyRoomCell:setChoseKnights(arg_3_1)
	self._choseKnightIdArr = arg_3_1 or {}

	self:_updateChoseKnights()
end

function HLTrainOneKeyRoomCell:updateKnightsMobility()
	self:_updateChoseKnights()
end

function HLTrainOneKeyRoomCell:_onClickProductIcon()
	self:dispatchCompEvent("event_click_product_icon", {
		indexLua = self._indexLua
	})
end

function HLTrainOneKeyRoomCell:_onClickChoseKnight(arg_6_1)
	local var_6_0 = arg_6_1:getSender():getIndex()

	if self:_isDispatchPlaceLocked(var_6_0) then
		local var_6_1 = var_0_1:getRoomStruct(self._advId)

		g.core.module.ModuleManager:tip((g.core.lang:get(111036, {
			name = var_6_1.refCfgBaseInfo.name,
			level = var_6_1:getDispatchPlaceUnlockLv(var_6_0)
		})))
	else
		local var_6_2 = {
			indexLua = self._indexLua
		}

		var_6_2.knightId = self._choseKnightIdArr[var_6_0]

		self:dispatchCompEvent("event_click_knight_icon", var_6_2)
	end
end

function HLTrainOneKeyRoomCell:_onClickBlankArea()
	self:dispatchCompEvent("event_click_room_blank_area", {
		indexLua = self._indexLua
	})
end

function HLTrainOneKeyRoomCell:_isDispatchPlaceLocked(arg_8_1)
	return arg_8_1 > var_0_1:getRoomStruct(self._advId).refCfgInfo.limit_dispatch
end

function HLTrainOneKeyRoomCell:_updateChoseKnights()
	for iter_9_0, iter_9_1 in ipairs(self.m_choseKnightCompArr) do
		iter_9_1:updateComp(self:_isDispatchPlaceLocked(iter_9_0), self._choseKnightIdArr[iter_9_0])
	end
end

function HLTrainOneKeyRoomCell:setChose(arg_10_1)
	if self:isChose() ~= arg_10_1 then
		self.m_choseController:setSelectedIndex((arg_10_1 or nil) and (var_0_0.YES or var_0_0.NO))
	end
end

function HLTrainOneKeyRoomCell:isChose()
	return self.m_choseController:getSelectedIndex() == var_0_0.YES
end

return HLTrainOneKeyRoomCell
