local ShowFactory = require("app.view.module.show.ShowFactory")
local TreasureGlyphComp = class("TreasureGlyphComp", require("app.fairyGUI.equipAndTreasure.UI_TreasureGlyphComp"))

function TreasureGlyphComp:ctor()
	self._sId = 0
	self._glyphLevel = 0
	self._preGlyphSuit = {}

	self.m_glyphBtn:addClickListener(handler(self, self._onClickGlyph))
	self.m_glyphTouchBtn:addClickListener(handler(self, self._onClickTipBtn))
end

function TreasureGlyphComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TREASURE_GLYPH, handler(self, self._onRcvGlyph), self)
end

function TreasureGlyphComp:_onRcvGlyph(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = g.core.model.User.treasureData:getTreasureDataByOnlyId(arg_3_4.id)
	local var_3_1 = g.core.model.User.treasureData:getKnightPosBySid(arg_3_4.id)
	local var_3_2 = g.core.model.User.formationData:getActiveTreasureGlyphSuit(var_3_1)
	local var_3_3 = false

	if #var_3_2 ~= #self._preGlyphSuit then
		var_3_3 = true
	else
		for iter_3_0 = 1, #var_3_2 do
			if var_3_2[iter_3_0].level ~= self._preGlyphSuit[iter_3_0].level or var_3_2[iter_3_0].num ~= self._preGlyphSuit[iter_3_0].num then
				var_3_3 = true

				break
			end
		end
	end

	if var_3_3 then
		local var_3_4 = {
			glyActive = {
				data = var_3_0,
				glyphType = self._glyphInfo.type
			},
			glyphSuit = {
				type = 2,
				pos = var_3_1
			}
		}

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
			showNow = true,
			frontShow = {
				{
					flag = "glyphSuitActive",
					func = function()
						return ShowFactory:showGlyphSuitActive(var_3_4)
					end
				}
			}
		})
	else
		local var_3_5 = {
			data = var_3_0,
			glyphType = self._glyphInfo.type
		}

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
			showNow = true,
			frontShow = {
				{
					flag = "glyphUp",
					func = function()
						return ShowFactory:showGlyphSuccess(var_3_5)
					end
				}
			}
		})
	end

	self:updateView({
		data = {
			id = arg_3_4.id
		}
	})
	self:stopAllFGActions()
	self:runFGAction(fgui.FSequence:create({
		fgui.FDelayTime:create(1),
		fgui.FCallFunc:create(function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_SHOW, false, {
				startAction = true
			})
		end)
	}))
end

function TreasureGlyphComp:updateView(arg_7_1)
	self:dispatchCompEvent("close_material_view")
	self:dispatchCompEvent("close_knight_select_view")

	self._sId = arg_7_1.data.id
	self._glyphInfo = g.core.model.User.treasureData:getTreasureGlyphInfo(self._sId)

	local var_7_0 = self._glyphInfo.level
	local var_7_1 = g.core.model.User.treasureData:getKnightPosBySid(self._sId)

	self._preGlyphSuit = g.core.model.User.formationData:getActiveTreasureGlyphSuit(var_7_1)

	local var_7_2 = self._glyphInfo.next_level == 0

	self.m_isFullController:setSelectedIndex(self._glyphInfo.next_level == 0 and 1 or 0)

	if var_7_2 then
		self.m_fullTip:updateView({
			text1 = g.core.lang:get(202039),
			text2 = g.core.lang:get(202040)
		})
	end

	if var_7_0 == 0 then
		self.m_glyphComp1:updateView({
			sid = self._sId
		})
		self.m_glyphComp2:updateView({
			sid = self._sId
		})
		self.m_glyphComp1:setGlyphIconByLevel(1)
		self.m_glyphComp1:setGrayed(true)
		self.m_glyphComp2:setGlyphIconByLevel(1)
		self.m_glyphComp2:setGrayed(false)
	else
		self.m_glyphComp1:updateView({
			sid = self._sId
		})
		self.m_glyphComp1:setGrayed(false)

		if not var_7_2 then
			self.m_glyphComp2:updateView({
				isNext = true,
				sid = self._sId
			})
			self.m_glyphComp2:setGrayed(false)
		end
	end

	for iter_7_0 = 1, 2 do
		if not var_7_2 then
			local var_7_3 = g.core.config.glyph_info.get(self._glyphInfo.id, self._glyphInfo.next_level)
			local var_7_4, var_7_5 = g.core.lang:getAttr(var_7_3["affect_type" .. iter_7_0], var_7_3["affect_value" .. iter_7_0], true)

			self["m_attrComp" .. iter_7_0]:updateAttr({
				withoutPlus1 = false,
				type = self._glyphInfo["affect_type" .. iter_7_0],
				value = self._glyphInfo["affect_value" .. iter_7_0],
				value2 = var_7_3["affect_value" .. iter_7_0]
			})
		else
			self["m_attrComp" .. iter_7_0]:updateAttr({
				withoutPlus1 = false,
				type = self._glyphInfo["affect_type" .. iter_7_0],
				value = self._glyphInfo["affect_value" .. iter_7_0]
			})
		end
	end

	local var_7_6, var_7_7 = g.core.model.User.treasureData:getGlyphSuitInfoByPos(var_7_1)

	self.m_suitText:setText(g.core.lang:get(202013, {
		number = var_7_7
	}))

	for iter_7_1 = 1, 4 do
		if var_7_6["affect_type" .. iter_7_1] > 0 then
			local var_7_8, var_7_9 = g.core.lang:getAttr(var_7_6["affect_type" .. iter_7_1], var_7_6["affect_value" .. iter_7_1])

			self["m_attrValueComp" .. iter_7_1]:setVisible(true)
			self["m_attrValueComp" .. iter_7_1]:updateAttr({
				type = var_7_6["affect_type" .. iter_7_1],
				value = var_7_6["affect_value" .. iter_7_1]
			})
		else
			self["m_attrValueComp" .. iter_7_1]:setVisible(false)
		end
	end

	self:updateCost()
end

function TreasureGlyphComp:switchResource()
	self:dispatchCompEvent("treasure_switch_goods", {
		id = 54
	})
end

function TreasureGlyphComp:updateCost()
	if self._glyphInfo.cost_type1 == 0 then
		return
	end

	self.m_resNumComp:updateByTVS({
		type = self._glyphInfo.cost_type1,
		value = self._glyphInfo.cost_value1,
		size = self._glyphInfo.cost_num1
	})
	self:switchResource()
end

function TreasureGlyphComp:_onClickTipBtn()
	local var_10_0 = g.core.model.User.treasureData:getKnightPosBySid(self._sId)
	local var_10_1 = g.core.model.User.treasureData:getTreasureData()[self._sId]
	local var_10_2, var_10_3, var_10_4

	if var_10_1 then
		var_10_2 = var_10_1.base_id

		if not var_10_1.base_id then
			var_10_2 = 0
			var_10_3 = require("app.view.module.equipAndTreasure.view.common.ETGlyphSuitInfoPop").new
			var_10_4 = {
				isShowAll = true,
				glyphType = 2,
				knightIndex = var_10_0
			}
		end
	end

	var_10_4.glyphGroupType = g.core.config.treasure_info.get(var_10_2).treasure_glyph

	self:addPopup(require("app.view.module.equipAndTreasure.view.common.ETGlyphSuitInfoPop").new(var_10_4), {
		touchDisappear = true
	})
end

function TreasureGlyphComp:_onClickGlyph()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.TREASURE_GLYPH) then
		local var_11_0 = g.core.model.User.bagData:getCountById(self._glyphInfo.cost_type1, self._glyphInfo.cost_value1)

		if var_11_0 < self._glyphInfo.cost_num1 then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = self._glyphInfo.cost_type1,
				value = self._glyphInfo.cost_value1,
				size = var_11_0
			})

			return
		end

		local var_11_1 = g.core.model.User.bagData:getCountById(self._glyphInfo.cost_type2, self._glyphInfo.cost_value2)

		if var_11_1 < self._glyphInfo.cost_num2 then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = self._glyphInfo.cost_type2,
				value = self._glyphInfo.cost_value2,
				size = var_11_1
			})

			return
		end

		g.core.network.GameNetProxy:send_C2S_Treasure_Glyph({
			id = self._sId
		})
	end
end

return TreasureGlyphComp
