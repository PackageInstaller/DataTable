local KnightAssctDescCell = class("KnightAssctDescCell", require("app.fairyGUI.tip.UI_KnightAssctDescCell"))
local var_0_1 = g.core.config.knight_association_info
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.model.User
local var_0_4 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_5 = g.core.model.User.knightsData
local var_0_6 = g.core.model.User.equipmentData
local var_0_7 = g.core.model.User.treasureData

function KnightAssctDescCell:ctor()
	self._knightInfo = nil
	self._assctInfo = nil
	self._isActive = false
	self._isLineup = false
	self._listData = {}
	self._itemNum = 0

	self.m_knightList:setIniter()
	self.m_knightList:setItemRenderer(handler(self, self._onKnightIconRenderer))
end

function KnightAssctDescCell:_onKnightIconRenderer(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_2:getChild("iconComp")
	local var_2_1 = arg_2_2:getController("isActive")
	local var_2_2 = arg_2_2:getController("isLast")

	if arg_2_1 == 0 then
		self:_updateSelfIcon(var_2_0)
	else
		self:_updateOtherIcon(arg_2_1, var_2_0)
	end

	var_2_1:setSelectedIndex(self._isActive and 1 or 0)
	var_2_2:setSelectedIndex(self._itemNum == arg_2_1 + 1 and 1 or 0)
end

function KnightAssctDescCell:_updateOtherIcon(arg_3_1, arg_3_2)
	local var_3_0

	if self._assctInfo["value_" .. arg_3_1] > 0 then
		if self._assctInfo.type == var_0_4.ASS_TYPE.KNIGHT then
			var_3_0 = {
				isGetShow = true,
				type = var_0_2.TYPE_KNIGHT,
				advanceId = self._assctInfo["value_" .. arg_3_1],
				isMask = not var_0_5:hasKnightByAdvanceId(self._assctInfo["value_" .. arg_3_1])
			}
		elseif self._assctInfo.type == var_0_4.ASS_TYPE.EQUIP then
			var_3_0 = {
				state = 0,
				isGetShow = true,
				type = var_0_2.TYPE_EQUIP,
				value = self._assctInfo["value_" .. arg_3_1],
				isMask = not var_0_6:hasEquipByAdvId(self._assctInfo["value_" .. arg_3_1])
			}
		elseif self._assctInfo.type == var_0_4.ASS_TYPE.TREATURE then
			var_3_0 = {
				isGetShow = true,
				type = var_0_2.TYPE_TREASURE,
				value = var_0_7:getKnightTreasureIdByAdvanceId(self._assctInfo["value_" .. arg_3_1], self._knightPos),
				isMask = not var_0_7:hasTreasureByAdvId(self._assctInfo["value_" .. arg_3_1])
			}
		end
	end

	if var_3_0 then
		arg_3_2:updateIcon(var_3_0)
		arg_3_2:setGrayed(var_3_0.isMask)
	end
end

function KnightAssctDescCell:_updateSelfIcon(arg_4_1)
	local var_4_0 = 0
	local var_4_1

	if self._knightInfo.type == 1 then
		var_4_0 = var_0_3:getDressId()
		var_4_1 = {
			isGetShow = true,
			type = var_0_2.TYPE_KNIGHT,
			info = self._knightInfo,
			dressId = var_4_0
		}
	end

	var_4_1.isMask = not var_0_5:hasKnightByAdvanceId(self._knightInfo.advance_id)

	arg_4_1:updateIcon(var_4_1)
	arg_4_1:setGrayed(var_4_1.isMask)
end

function KnightAssctDescCell:updateComp(arg_5_1)
	local var_5_0 = var_0_5:getKnight({
		base_id = arg_5_1.knightId
	})

	self._knightInfo = var_5_0:getBaseInfo()
	self._assctInfo = var_0_1.get(arg_5_1.assId)
	self._isActive = arg_5_1.isActive
	self._isLineup = var_5_0:isLineup()

	self.m_nameComp:setAssct(arg_5_1)

	self._itemNum = g.core.model.User.formationData:getAssctCountByAssId(arg_5_1.assId) + 1

	self.m_knightList:setNumItems(self._itemNum)
	self.m_descText:setText(self._assctInfo.directions)
	self.m_isActiveController:setSelectedIndex(self._isActive and 1 or 0)
end

return KnightAssctDescCell
