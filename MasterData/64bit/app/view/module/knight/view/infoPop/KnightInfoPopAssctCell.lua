local KnightInfoPopAssctCell = class("KnightInfoPopAssctCell", require("app.fairyGUI.knight.UI_KnightInfoPopAssctCell"))
local var_0_1 = g.core.config.knight_association_info
local var_0_2 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_3 = g.core.common.Goods
local var_0_4 = g.core.model.User
local var_0_5 = g.core.model.User.knightsData
local var_0_6 = g.core.model.User.equipmentData
local var_0_7 = g.core.model.User.treasureData

function KnightInfoPopAssctCell:ctor()
	self._knightAdvId = nil
	self._assData = nil
	self._assctInfo = nil
	self._itemNum = 0

	self.m_knightList:setIniter()
	self.m_knightList:setItemRenderer(handler(self, self._onKnightIconRenderer))
end

function KnightInfoPopAssctCell:_onKnightIconRenderer(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_2:getChild("iconComp")
	local var_2_1 = arg_2_2:getController("isActive")
	local var_2_2 = arg_2_2:getController("isLast")

	if arg_2_1 == 0 then
		self:_updateSelfIcon(var_2_0)
	else
		self:_updateOtherIcon(arg_2_1, var_2_0)
	end

	var_2_1:setSelectedIndex(self._assData.isActive and 1 or 0)
	var_2_2:setSelectedIndex(self._itemNum == arg_2_1 + 1 and 1 or 0)
end

function KnightInfoPopAssctCell:_updateOtherIcon(arg_3_1, arg_3_2)
	local var_3_0
	local var_3_1 = self._assctInfo["value_" .. arg_3_1]

	if self._assctInfo["value_" .. arg_3_1] > 0 then
		local var_3_2 = false

		if self._assctInfo.type == var_0_2.ASS_TYPE.KNIGHT then
			var_3_2 = self._matchInfos and self._matchInfos[g.core.common.Goods.TYPE_KNIGHT][var_3_1] or var_0_5:hasKnightByAdvanceId(var_3_1)
			var_3_0 = {
				isGetShow = true,
				type = var_0_3.TYPE_KNIGHT,
				advanceId = var_3_1,
				isMask = not var_3_2
			}
		elseif self._assctInfo.type == var_0_2.ASS_TYPE.EQUIP then
			var_3_2 = self._matchInfos and self._matchInfos[g.core.common.Goods.TYPE_EQUIP][var_3_1] or var_0_6:hasEquipByAdvId(var_3_1)
			var_3_0 = {
				isGetShow = true,
				state = 0,
				type = var_0_3.TYPE_EQUIP,
				value = var_3_1,
				isMask = not var_3_2
			}
		elseif self._assctInfo.type == var_0_2.ASS_TYPE.TREATURE then
			var_3_2 = self._matchInfos and self._matchInfos[g.core.common.Goods.TYPE_TREASURE][var_3_1] or var_0_7:hasTreasureByAdvId(var_3_1)
			var_3_0 = {
				isGetShow = true,
				type = var_0_3.TYPE_TREASURE,
				value = var_3_1,
				isMask = not var_3_2
			}
		end
	end

	arg_3_2:updateIcon(var_3_0)
	arg_3_2:setGrayed(var_3_0.isMask)
end

function KnightInfoPopAssctCell:_updateSelfIcon(arg_4_1)
	local var_4_0 = 0

	if self._knightInfo.type == 1 then
		var_4_0 = var_0_4:getDressId()
	end

	local var_4_1 = false

	var_4_1 = self._matchInfos and self._matchInfos[g.core.common.Goods.TYPE_KNIGHT][self._knightAdvId] or var_0_5:hasKnightByAdvanceId(self._knightAdvId)

	local var_4_2 = {
		isGetShow = true,
		type = var_0_3.TYPE_KNIGHT,
		info = self._knightInfo,
		dressId = var_4_0,
		isMask = not var_4_1
	}

	arg_4_1:updateIcon(var_4_2)
	arg_4_1:setGrayed(var_4_2.isMask)
end

function KnightInfoPopAssctCell:updateComp(arg_5_1, arg_5_2)
	self._matchInfos = arg_5_2
	self._knightAdvId = arg_5_1.knightAdvId
	self._assData = arg_5_1.assData
	self._assctInfo = var_0_1.get(self._assData.assId)
	self._knightInfo = var_0_5:getKnight({
		base_id = self._assData.knightId
	}):getBaseInfo()

	self.m_nameTxt:setText(self._assctInfo.name)

	self._itemNum = g.core.model.User.formationData:getAssctCountByAssId(self._assData.assId) + 1

	self.m_knightList:setNumItems(self._itemNum)
	self.m_descText:setText(self._assctInfo.directions)
	self.m_isActiveController:setSelectedIndex(self._assData.isActive and 1 or 0)
end

return KnightInfoPopAssctCell
