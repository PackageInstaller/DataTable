local var_0_0 = g.core.const.ConstMgr
local TreasureWearCell = class("TreasureWearCell", require("app.fairyGUI.equipAndTreasure.UI_TreasureWearCell"))
local var_0_2 = g.core.model.User.knightsData
local var_0_3 = g.core.config.treasure_info
local var_0_4 = g.core.common.Goods
local var_0_5 = g.core.model.User.treasureData

function TreasureWearCell:ctor()
	self._treasureId = nil
	self._treasureOnlyId = nil
	self._treasureType = nil
	self._wearPos = 0

	self.getSharedTrans(self, "listCrosbandBUiRightIn_cell", "LineUpRightList", self)
	self:_initView()
end

function TreasureWearCell:onLoad()
	return
end

function TreasureWearCell:onUnload()
	return
end

function TreasureWearCell:updateView(arg_4_1)
	local var_4_0, var_4_1

	if arg_4_1 then
		var_4_0 = arg_4_1.data or nil

		if arg_4_1 then
			var_4_1 = arg_4_1.selectPositionData or {}
		end
	end

	self._selectPositionData = var_4_1

	if not var_4_0 then
		return
	end

	local var_4_2 = var_4_0.base_id
	local var_4_3 = var_4_0.position

	self._data = var_4_0
	self._treasureId = var_4_2
	self._treasureOnlyId = var_4_0.id
	self._wearPos = var_4_1.pos or 0

	local var_4_4 = var_4_0.refining_level
	local var_4_5 = var_0_3.get(var_4_2)

	if not var_4_5 then
		return
	end

	self._treasureType = var_4_5.type

	self.m_nameText:setText(var_4_5.name)

	local var_4_6 = {
		pos = var_4_3,
		type = self._treasureType,
		id = var_4_2,
		onlyId = var_4_0.id
	}

	if var_4_5 and var_4_5.type ~= 3 or var_4_5.type ~= 4 then
		self.m_treasureIcon:updateIcon({
			changeControllers = true,
			type = var_0_4.TYPE_TREASURE,
			value = var_4_2,
			equipStage = var_4_4,
			glyphLevel = var_4_0.glyph_level,
			refineLevel = var_4_0.refining_level,
			level = var_4_0.level,
			treasure = var_4_6,
			treasureOnlyId = self._treasureOnlyId
		})
	else
		self.m_treasureIcon:updateIcon({
			size = 0,
			type = var_0_4.TYPE_TREASURE,
			value = var_4_2,
			treasure = var_4_6
		})
	end

	self:_updateWearState(var_4_3)

	if var_4_3 ~= 0 then
		if g.core.model.User.treasureData:isActiveAssct(var_4_5.advance_id, (math.ceil(var_4_3 / 2))) then
			self.m_showLinkController:setSelectedIndex(0)
			self.m_linkComp:initStar({
				index = 1,
				style = 1,
				num = 1,
				type = 1
			})
		else
			self.m_showLinkController:setSelectedIndex(1)
		end
	else
		self.m_showLinkController:setSelectedIndex(1)
	end

	self:_showWearSpecialAttrsScore()
end

function TreasureWearCell:_initView()
	self:addClickListener(handler(self, self._onCellClicked))
	self.m_treasureIcon:setQualityEffectEnable(true)
end

function TreasureWearCell:_updateWearState(arg_6_1)
	if arg_6_1 ~= 0 then
		self.m_wearStateController:setSelectedIndex(0)
		self.m_wearComp:updateView((var_0_2:getKnightByFormationIndex((math.ceil(arg_6_1 / 2)))))
	else
		self.m_wearStateController:setSelectedIndex(1)
	end
end

function TreasureWearCell:_onCellClicked()
	if self._data and self._wearPos and self._treasureOnlyId then
		local var_7_0 = var_0_5:getTreasureDataByPos(self._wearPos)

		if var_7_0 then
			if var_7_0.level > 1 or var_7_0.refining_level > 0 or var_0_5:isHasPurifyScore(self._treasureOnlyId) then
				g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.InheritFormationPop").new({
					pos = self._wearPos,
					id = self._treasureOnlyId,
					type = var_0_0.InfoConst.InheritType.TREASURE
				})))
			else
				local var_7_1 = {}

				var_7_1.tp = g.core.network.proto.TYPE_TREASURE
				var_7_1.pos = self._wearPos
				var_7_1.id = self._treasureOnlyId

				g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation(var_7_1)
			end
		else
			local var_7_2 = {}

			var_7_2.tp = g.core.network.proto.TYPE_TREASURE
			var_7_2.pos = self._wearPos
			var_7_2.id = self._treasureOnlyId

			g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation(var_7_2)
		end
	end
end

function TreasureWearCell:_showWearSpecialAttrsScore()
	self.m_showAttrScoreController:setSelectedIndex(0)

	local var_8_0 = g.core.model.User.treasureData:getTreasureSpecialAttrsScore(self._treasureOnlyId)

	if var_8_0 and var_8_0 ~= 0 then
		self.m_showAttrScoreController:setSelectedIndex(1)
		self.m_scoreTxt:setText(var_8_0)
		self.m_scoreTipController:setSelectedIndex(0)

		if self._selectPositionData and self._selectPositionData.sid then
			local var_8_1 = g.core.model.User.treasureData:getTreasureSpecialAttrsScore(self._selectPositionData.sid)

			if var_8_1 and var_8_1 ~= 0 and var_8_1 < var_8_0 then
				self.m_scoreTipController:setSelectedIndex(1)
			end
		end
	end
end

return TreasureWearCell
