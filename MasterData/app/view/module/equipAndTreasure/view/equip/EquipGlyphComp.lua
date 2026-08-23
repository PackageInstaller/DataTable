local ShowFactory = require("app.view.module.show.ShowFactory")
local EquipGlyphComp = class("EquipGlyphComp", require("app.fairyGUI.equipAndTreasure.UI_EquipGlyphComp"))

function EquipGlyphComp:ctor()
	self._glyphInfo = {}
	self._glyphLevel = 0
	self._equipStruct = {}

	self.m_sureBtn:addClickListener(handler(self, self._onClickGlyph))
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EQUIPMENT_GLYPH, handler(self, self._onRcvGlyph), self)

	self._preGlyphSuit = {}

	self.m_infoTouchLayer:startListen(self)
end

function EquipGlyphComp:onLoad()
	return
end

function EquipGlyphComp:_onRcvGlyph(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = self._equipStruct:getKnightPos()
	local var_3_1 = g.core.model.User.formationData:getActiveEquipGlyphSuit(var_3_0)
	local var_3_2 = false

	if #var_3_1 ~= #self._preGlyphSuit then
		var_3_2 = true
	else
		for iter_3_0 = 1, #var_3_1 do
			if var_3_1[iter_3_0].level ~= self._preGlyphSuit[iter_3_0].level or var_3_1[iter_3_0].num ~= self._preGlyphSuit[iter_3_0].num then
				var_3_2 = true

				break
			end
		end
	end

	if var_3_2 then
		local var_3_3 = {
			glyActive = {
				data = self._equipStruct,
				glyphType = self._glyphInfo.type
			},
			glyphSuit = {
				type = 1,
				pos = var_3_0
			}
		}

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
			showNow = true,
			frontShow = {
				{
					flag = "glyphSuitActive",
					func = function()
						return ShowFactory:showGlyphSuitActive(var_3_3)
					end
				}
			}
		})
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_SHOW, false, {
			showMoment = true,
			glyphSuitActive = {
				glyActive = {
					data = self._equipStruct,
					glyphType = self._glyphInfo.type
				},
				glyphSuit = {
					type = 1,
					pos = var_3_0
				}
			}
		})
	else
		local var_3_4 = {
			data = self._equipStruct,
			glyphType = self._glyphInfo.type
		}

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
			showNow = true,
			frontShow = {
				{
					flag = "glyphUp",
					func = function()
						return ShowFactory:showGlyphSuccess(var_3_4)
					end
				}
			}
		})
	end

	self._equipStruct = g.core.model.User.equipmentData:getEquipBySid(arg_3_4.id)

	self:updateView({
		data = self._equipStruct
	})
	self:stopAllFGActions()
	self:runFGAction(fgui.FSequence:create({
		fgui.FDelayTime:create(0.1),
		fgui.FCallFunc:create(function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_SHOW, false, {
				startAction = true
			})
		end)
	}))
	self:_playGlyphIconEffect()
end

function EquipGlyphComp:_playGlyphIconEffect()
	return
end

function EquipGlyphComp:updateView(arg_8_1)
	self._equipStruct = arg_8_1.data

	self.m_haveEquipController:setSelectedIndex(next(self._equipStruct) and 1 or 0)

	if not next(self._equipStruct) then
		return
	end

	local var_8_0 = self._equipStruct:getKnightPos()

	self.knightPos = var_8_0
	self._preGlyphSuit = g.core.model.User.formationData:getActiveEquipGlyphSuit(var_8_0)
	self._glyphInfo = self._equipStruct:getGlyphInfo()

	local var_8_1 = self._equipStruct:isMaxGlyph()
	local var_8_2 = self._glyphInfo.level > 0

	self.m_glyFirstIcon:getChild("imageIcon"):setURL((g.core.common.Path:getGlyphIcon(self._glyphInfo.icon)))

	local var_8_3, var_8_4 = g.core.lang:getAttr(self._glyphInfo.affect_type1, self._glyphInfo.affect_value1, false)
	local var_8_6

	if not var_8_1 then
		local var_8_7 = g.core.config.glyph_info.get(self._glyphInfo.id, self._glyphInfo.next_level)

		self.m_glyNextIcon:getChild("imageIcon"):setURL(g.core.common.Path:getGlyphIcon(var_8_7.icon))

		local var_8_8

		var_8_8, var_8_6 = g.core.lang:getAttr(var_8_7.affect_type1, var_8_7.affect_value1, false)
	end

	self.m_glyFirstIcon:getController("mask"):setSelectedIndex(var_8_2 and 0 or 1)
	self.m_strengDescComp:updateAttr({
		name = var_8_3,
		value = var_8_4,
		value2 = var_8_6
	})
	self.m_strengDescComp:setAttrIconByType(self._glyphInfo.affect_type1)
	self.m_glyStateController:setSelectedIndex(var_8_1 and 1 or 0)

	local var_8_9 = self._equipStruct:getSuitInfo(2)
	local var_8_10 = self._equipStruct:getKnightPos()
	local var_8_11 = g.core.model.User.formationData:getActiveEquipGlyphSuit(var_8_10)
	local var_8_12 = {}

	if self._equipStruct:getPosition() == 0 or not next(var_8_11) then
		for iter_8_0 = 2, 4 do
			table.insert(var_8_12, {
				isActive = false,
				info = self._equipStruct:getSuitInfo(iter_8_0)
			})
		end

		self.m_attrsComp:updateAttrComp({
			info = var_8_12
		}, var_8_10)
	else
		local var_8_13 = var_8_11[1]
		local var_8_14 = g.core.model.User.equipmentData:getGlyphSuitInfoByLevel(var_8_11[1].level, self._equipStruct:getGlyphInfo().type)

		for iter_8_1 = 2, 4 do
			table.insert(var_8_12, {
				info = clone(var_8_14[iter_8_1]),
				isActive = iter_8_1 <= var_8_13.num and true or false
			})
		end
	end

	self.m_attrsComp:updateAttrComp(var_8_12, var_8_10)
	self:updateCost()
end

function EquipGlyphComp:updateCost()
	if self._glyphInfo.cost_type1 == 0 then
		return
	end

	self.m_costIcon:setURL((g.core.common.Path:getIconByTypeValue(self._glyphInfo.cost_type1, self._glyphInfo.cost_value1, true)))

	local var_9_0 = g.core.model.User.bagData:getOwnNum(self._glyphInfo.cost_type1, self._glyphInfo.cost_value1)
	local var_9_1 = self._glyphInfo.cost_num1

	self.m_ownMoneyText:setText(var_9_0)
	self.m_costMoneyText:setText("/" .. var_9_1)
	self.m_textColorController:setSelectedIndex(var_9_1 <= var_9_0 and 0 or 1)
end

function EquipGlyphComp:_onClickGlyph()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.EQUIP_GLYPH) then
		local var_10_0 = g.core.model.User.bagData:getOwnNum(self._glyphInfo.cost_type1, self._glyphInfo.cost_value1)

		if var_10_0 < self._glyphInfo.cost_num1 then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = self._glyphInfo.cost_type1,
				value = self._glyphInfo.cost_value1,
				size = var_10_0
			})

			return
		end

		local var_10_1 = g.core.model.User.bagData:getOwnNum(self._glyphInfo.cost_type2, self._glyphInfo.cost_value2)
		local var_10_2

		if var_10_1 < self._glyphInfo.cost_num2 then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = self._glyphInfo.cost_type2,
				value = self._glyphInfo.cost_value2,
				size = var_10_1
			})

			do return end

			var_10_2 = {}
		end

		var_10_2.id = self._equipStruct:getServerData().id

		g.core.network.GameNetProxy:send_C2S_Equipment_Glyph(var_10_2)
	end
end

function EquipGlyphComp:onCoverTouchEnded(arg_11_1)
	self:addPopup(require("app.view.module.equipAndTreasure.view.common.ETGlyphSuitInfoPop").new({
		isShowAll = true,
		glyphType = 1,
		knightIndex = self.knightPos,
		glyphGroupType = self._equipStruct:getCfg().equipment_glyph
	}), {
		touchDisappear = true
	})
end

return EquipGlyphComp
