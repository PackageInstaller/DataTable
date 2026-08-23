local TreasureDevConfig = require("app.view.module.equipAndTreasure.const.TreasureDevConfig")
local var_0_1 = g.core.model.User.treasureData
local var_0_2 = g.core.model.User.knightsData
local var_0_3 = g.core.config.treasure_info
local ETData = require("app.view.module.equipAndTreasure.model.ETData")
local ShowFactory = require("app.view.module.show.ShowFactory")
local TreasureDevelopLayer = class("TreasureDevelopLayer", require("app.fairyGUI.equipAndTreasure.UI_TreasureDevelopLayer"), function()
	return fgui.GComponent:create({
		resName = "TreasureDevelopLayer",
		pkgPath = "ui/equipAndTreasure/equipAndTreasure",
		isFullScreen = true,
		pkgName = "equipAndTreasure"
	}, ...)
end)

function TreasureDevelopLayer:ctor(arg_2_1)
	self._treasureId = arg_2_1.id
	self._treasureOnlyId = arg_2_1.sid
	self._isRefine = arg_2_1.isRefine or false
	self._curLevel = g.core.model.User.treasureData:getTreasureLevelByOnlyId(self._treasureOnlyId)
	self._curRefineLevel = g.core.model.User.treasureData:getTreasureRefineLevelByOnlyId(self._treasureOnlyId)
	self._knightFormation = g.core.model.User.knightsData:getFormationKnights()
	self._curTabIndex = nil
	self._isFirstEnter = nil
	self._treasureData = nil
	self._treasureSuit = nil
	self._knightIndex = nil
	self._knightId = nil
	self._allTreasureData = nil
	self._treasureType = nil
	self._treasureIndex = nil
	self._effectId = nil
	self._effectDown = nil

	self:_initData()
	self:_initView()
end

function TreasureDevelopLayer:_initData()
	ETData.needChangeKnight = false
	ETData.knightId = nil

	if self._isRefine then
		self._curTabIndex = 2
	end
end

function TreasureDevelopLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TREASURE_UPGRADE, handler(self, self._freshViewUp), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TREASURE_REFINING, handler(self, self._freshViewRefine), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TREASURE_GLYPH, handler(self, self._onRcvGlyph), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TREASURE_UPGRADE_ONELEVEL, handler(self, self._onRcvOnekey), self)

	self._treasureData = var_0_1:getTreasureDataByOnlyId(self._treasureOnlyId)
	self._treasureType = var_0_3.get(self._treasureData.base_id).type
	self._knightIndex = self._treasureData.position > 0 and math.ceil(self._treasureData.position / 2) or nil
	self._knightId = self._knightFormation[self._knightIndex]

	self.m_lineUpComp:updateView({
		developType = "treasure",
		knightId = self._knightId,
		callback = handler(self, self._onChangeKnight)
	})
	self:_onChangeKnight(self._knightId)
	self:_updateTab()
	self:_updateTreasureView()
end

function TreasureDevelopLayer:_onChangeKnight(arg_5_1)
	local var_5_0 = var_0_2:getKnightById(arg_5_1)
	local var_5_1 = var_5_0:getFormationPos()
	local var_5_2 = self:_getTreasureDataOfKnight(var_5_1)

	if #var_5_2 == 0 then
		local var_5_3 = require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(202053),
			desc = g.core.lang:get(202001),
			confirmText = g.core.lang:get(101506),
			cancelText = g.core.lang:get(101507),
			onConfirm = function()
				ETData.needChangeKnight = true
				ETData.knightId = arg_5_1

				g.core.module.ModuleManager:pushModule(g.view.entrance.EQUIP_AND_TREASURE, {
					knightId = arg_5_1,
					knightIndex = var_5_1
				})
			end,
			onCancel = function()
				return
			end
		})

		self:addListen(var_5_3)
		self:addPopup(var_5_3, {
			ignoreTouch = true
		})

		return false
	end

	self._knightId = arg_5_1
	self._allTreasureData = var_5_2
	self._knightIndex = var_5_1
	self._knight = var_5_0
	ETData.needChangeKnight = true
	ETData.knightId = arg_5_1

	if #self._allTreasureData == 2 then
		for iter_5_0 = 1, 2 do
			if self._treasureType == var_0_3.get(self._allTreasureData[iter_5_0].base_id).type then
				self._treasureIndex = iter_5_0 - 1
			end
		end
	else
		self._treasureIndex = 0
	end

	self:_updateTreasures()
	self:_onTreasureIconClick(nil, self._treasureIndex)

	return true
end

function TreasureDevelopLayer:_getTreasureDataOfKnight(arg_8_1)
	local var_8_0 = {}

	for iter_8_0 = 1, 2 do
		local var_8_1 = var_0_1:getTreasureDataByPos((arg_8_1 - 1) * 2 + iter_8_0)

		if var_8_1 then
			table.insert(var_8_0, var_8_1)
		end
	end

	return var_8_0
end

function TreasureDevelopLayer:_updateTab()
	self.m_devComp:updateDevPanel({
		tabData = TreasureDevConfig.DEV_LIST,
		initTabType = self._curTabIndex,
		data = self._treasureData,
		customData = {
			onlyId = self._treasureOnlyId
		}
	})
end

function TreasureDevelopLayer:_initView()
	self:addBg("bg/common/pic_yht_beijing.jpg")
	self.m_devComp:initConfig(TreasureDevConfig)
	self:checkTopBar()
	self.m_treasureList:setIniter()
	self.m_treasureList:setItemRenderer(handler(self, self._onTreasureItemRenderer))
	self.m_treasureList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTreasureIconClick))
	self.m_touchImg:addClickListener(handler(self, self._onTouchBg))
end

function TreasureDevelopLayer:checkTopBar(arg_11_1)
	self.m_topBarComp:setResInfoById(arg_11_1 or 54)
end

function TreasureDevelopLayer:_onTreasureItemRenderer(arg_12_1, arg_12_2)
	if not self._allTreasureData[arg_12_1 + 1] then
		return
	end

	local var_12_0 = {}

	var_12_0.changeControllers = true
	var_12_0.type = g.core.common.Goods.TYPE_TREASURE
	var_12_0.value = self._allTreasureData[arg_12_1 + 1].base_id
	var_12_0.level = self._allTreasureData[arg_12_1 + 1].level
	var_12_0.overrideClick = true
	var_12_0.glyphLevel = self._allTreasureData[arg_12_1 + 1].glyph_level
	var_12_0.changeControllers = true
	var_12_0.refineLevel = self._allTreasureData[arg_12_1 + 1].refining_level

	if self._allTreasureData[arg_12_1 + 1].refining_level > 0 then
		var_12_0.equipStage = self._allTreasureData[arg_12_1 + 1].refining_level
	end

	arg_12_2:updateIcon(var_12_0)
	arg_12_2:getController("isWear"):setSelectedIndex(1)

	local var_12_1 = arg_12_2:getChild("redPointComp")

	if var_12_1 then
		var_12_1:setId(130)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = var_12_1,
			customData = {
				onlyId = self._allTreasureData[arg_12_1 + 1].id
			}
		})
	end
end

function TreasureDevelopLayer:_onTreasureIconClick(arg_13_1, arg_13_2)
	self:_onTouchBg()

	local var_13_0 = arg_13_1 and arg_13_1:getDataValue() or arg_13_2

	self._treasureIndex = var_13_0
	self._treasureData = self._allTreasureData[var_13_0 + 1]
	self._treasureId = self._allTreasureData[var_13_0 + 1].base_id
	self._treasureOnlyId = self._allTreasureData[var_13_0 + 1].id
	self._curLevel = g.core.model.User.treasureData:getTreasureLevelByOnlyId(self._treasureOnlyId)
	self._curRefineLevel = g.core.model.User.treasureData:getTreasureRefineLevelByOnlyId(self._treasureOnlyId)
	self._treasureType = var_0_3.get(self._treasureData.base_id).type

	self:_updateTab()
	self:_updateTreasureView()
end

function TreasureDevelopLayer:_changeTreasureTypeData()
	return
end

function TreasureDevelopLayer:_updateTreasures()
	self.m_treasureList:setNumItems(#self._allTreasureData)
	self.m_treasureList:setSelectedIndex(self._treasureIndex)
end

function TreasureDevelopLayer:_updateTreasureView()
	self.m_equipIconLoader:setURL((g.core.common.Path:getTreasurePicById(self._treasureId)))
	self.m_equipIconLoader:setVisible(true)

	local var_16_0 = var_0_3.get(self._treasureId)

	self.m_nameTxt:setText(var_16_0.name)

	if var_16_0.quality >= g.core.const.ConstMgr.QUALITY_TYPE.UR then
		local var_16_1 = var_16_0.quality == g.core.const.ConstMgr.QUALITY_TYPE.UR and "eff_ui_treasure512_down" or "eff_ui_treasure512_downMR"

		if not self._effectDown then
			self._effectDown = self.m_effectIconDownNode:addEffectSpine({
				anim = "play",
				isLoop = true,
				name = var_16_1
			})
		elseif self._effectDown:getResId() ~= var_16_1 then
			self.m_effectIconDownNode:removeAllEffect()

			self._effectDown = self.m_effectIconDownNode:addEffectSpine({
				anim = "play",
				isLoop = true,
				name = var_16_1
			})
		end

		if self._treasureId ~= self._effectId then
			self.m_effectIconNode:removeAllEffect()
			self.m_effectIconNode:addEffectSpine({
				anim = "play",
				isLoop = true,
				name = "eff_ui_treasure512_" .. self._treasureId
			})

			self._effectId = self._treasureId
		end

		self.m_effectIconDownNode:setVisible(true)
		self.m_effectIconNode:setVisible(true)
	else
		self.m_effectIconDownNode:setVisible(false)
		self.m_effectIconNode:setVisible(false)
	end
end

function TreasureDevelopLayer:_freshViewUp()
	self.m_devComp:getDevCompByType(TreasureDevConfig.DEV_TYPE.STRENGTH):updateView({
		data = {
			init = true,
			base_id = self._treasureId,
			id = self._treasureOnlyId
		}
	})
	self:_updateTreasures()
	self:_judgeActiveMasterAfterUp()
end

function TreasureDevelopLayer:_tipsAfterUp()
	return
end

function TreasureDevelopLayer:_onRcvOnekey()
	self.m_devComp:getDevCompByType(TreasureDevConfig.DEV_TYPE.STRENGTH):updateView({
		data = {
			init = true,
			base_id = self._treasureId,
			id = self._treasureOnlyId
		}
	})
	self:_updateTreasures()
	self:_judgeActiveMasterAfterUp()
end

function TreasureDevelopLayer:_freshViewRefine()
	g.core.module.ModuleManager:tip(g.core.lang:get(202002))

	local var_20_0 = self.m_devComp:getDevCompByType(TreasureDevConfig.DEV_TYPE.REFINE)

	var_20_0:resetRefineBtnState()
	var_20_0:updateAfterRefine({
		data = {
			id = self._treasureId,
			onlyId = self._treasureOnlyId
		}
	})
	self:_updateTreasures()
	self:_judgeActiveMasterAfterUp()
end

function TreasureDevelopLayer:_tipsAfterRefine()
	return
end

function TreasureDevelopLayer:_onRcvGlyph(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	self:_updateTreasures()
end

function TreasureDevelopLayer:receiveCompEvent(arg_23_1)
	local var_23_0 = {
		...
	}

	if arg_23_1 == "select_click" then
		self.m_devComp:getDevCompByType(TreasureDevConfig.DEV_TYPE.STRENGTH):updateSelectMaterial(var_23_0[1])
	elseif arg_23_1 == "BaseDevelopPanelComp_tab" then
		if self._curTabIndex ~= var_23_0[1].tabData.index then
			self._curTabIndex = var_23_0[1].tabData.index
		end

		self._curTabIndex = var_23_0[1].tabData.index

		self:checkTopBar(var_23_0[1].tabData.topId)
	elseif arg_23_1 == "txt_pop_ok" then
		g.core.module.ModuleManager:popModule()
	elseif arg_23_1 == "close_material_view" then
		self:_closeSelectMaterialView()
	elseif arg_23_1 == "close_knight_select_view" then
		self:_closeLineUpView()
	elseif arg_23_1 == "treasure_quick_strength" then
		self.m_devComp:getDevCompByType(TreasureDevConfig.DEV_TYPE.STRENGTH):updateLevel(var_23_0[1])
	elseif arg_23_1 == "treasure_switch_goods" then
		self.m_topBarComp:setResInfoById(var_23_0[1].id)
	elseif arg_23_1 == "block_click" then
		self.m_blockClick:setVisible(var_23_0[1])
	end
end

function TreasureDevelopLayer:_closeSelectMaterialView()
	local var_24_0 = self.m_devComp:getDevCompByType(TreasureDevConfig.DEV_TYPE.STRENGTH)

	if var_24_0 then
		var_24_0:showSelectMaterialView(false)
		var_24_0:closeQuickStrength()
	end
end

function TreasureDevelopLayer:_closeLineUpView()
	return
end

function TreasureDevelopLayer:_onTouchBg()
	self:_closeSelectMaterialView()
	self:_closeLineUpView()
end

function TreasureDevelopLayer:_judgeActiveMasterAfterUp()
	if self._knightId and not math.uint64_lt(self._knightId, 0, true) then
		local var_27_0 = g.core.model.User.equipmentData:getMasterByKnightId(self._knightId)

		if var_27_0 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
				showNow = true,
				frontShow = {
					{
						flag = "treasureMasterStarUp",
						func = function()
							return ShowFactory:showMasterUp(var_27_0)
						end
					}
				}
			})
		end
	end
end

return TreasureDevelopLayer
