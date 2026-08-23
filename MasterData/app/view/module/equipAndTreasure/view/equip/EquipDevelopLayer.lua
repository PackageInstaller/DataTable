local ShowFactory = require("app.view.module.show.ShowFactory")
local var_0_1 = g.core.model.User.equipmentData
local var_0_2 = table.sort
local EquipDevConfig = require("app.view.module.equipAndTreasure.const.EquipDevConfig")
local var_0_4 = g.core.const.ConstMgr
local var_0_5 = g.core.const.ConstMgr.BaseShowTypeConst
local var_0_6 = g.core.const.ConstMgr.ETConst.DEV_TYPE
local DayNotifyToolConst = require("app.view.common.const.DayNotifyToolConst")
local var_0_8 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_9 = g.core.event
local var_0_10 = g.core.model.User.knightsData
local ETData = require("app.view.module.equipAndTreasure.model.ETData")
local var_0_12 = g.core.module.ModuleManager
local var_0_13 = g.core.const.ConstMgr.EquipConst
local EquipDevelopLayer = class("EquipDevelopLayer", require("app.fairyGUI.equipAndTreasure.UI_EquipDevelopLayer"), function()
	return fgui.GComponent:create({
		resName = "EquipDevelopLayer",
		pkgPath = "ui/equipAndTreasure/equipAndTreasure",
		isFullScreen = true,
		pkgName = "equipAndTreasure"
	}, ...)
end)

EquipDevelopLayer.EQUIP_TYPE_ORDER = {
	1,
	4,
	3,
	2
}

function EquipDevelopLayer:ctor()
	self._isFirstEnter = true
	self._curTabIndex = nil
	self._isCheckNotify = true
	self._equipSuits = nil
	self._isInWear = nil
	self._isLazy = false
	self._lastRefineLevel = 0
	self._lastEquipId = 0
	self._lastSelectIdx = 0
	self._upgradeItems = {}
	self._curSuitId = 0
	self._isExpand = false
	self._curSuitActiveMap = nil

	self.m_isExpandController:setSelectedIndex(0)
	self:addBg("bg/common/pic_yht_beijing.jpg")
	self.m_topBarComp:setResInfoById(52)
	self.m_equipSuitList:setIniter()
	self.m_equipSuitList:setItemRenderer(handler(self, self._onListEquipSuitItemRenderer))
	self.m_equipSuitList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onEquipIconClick))
	self.m_touchImg:addClickListener(handler(self, self._onTouchBg))
	self.m_oneKeyEquipStrengthenBtn:addClickListener(handler(self, self._onClickOneKeyEquipStrengthen))
	self.m_expandBtn:addClickListener(handler(self, self._onExpandChanged))
	self.m_enterTransition:play()
end

function EquipDevelopLayer:_getNextKnightEquip(arg_3_1, arg_3_2)
	local var_3_0 = g.core.model.User.knightsData:getLineUpList()
	local var_3_1 = -1

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if math.uint64_equal(iter_3_1:getInfo().id, arg_3_1:getInfo().id) then
			var_3_1 = iter_3_0

			break
		end
	end

	local var_3_2 = var_3_1 + arg_3_2

	if var_3_1 + arg_3_2 < 1 then
		var_3_2 = #var_3_0
	elseif var_3_2 > #var_3_0 then
		var_3_2 = 1
	end

	local var_3_3 = var_3_0[var_3_2]
	local var_3_4 = var_0_1:getEquipSuitByKnightPos(var_3_0[var_3_2]:getFormationPos())

	if #var_3_4 > 0 then
		for iter_3_2 = 1, #var_3_4 do
			if type(var_3_4[iter_3_2]) ~= "number" and var_3_4[iter_3_2].getCfg then
				return var_3_4[iter_3_2]
			end
		end
	end

	return self:_getNextKnightEquip(var_3_3, arg_3_2)
end

function EquipDevelopLayer:_changeEquip(arg_4_1)
	self:_updateData(arg_4_1)
	self.m_equipSuitList:setNumItems(#self._equipSuits)

	local var_4_0 = 0

	for iter_4_0 = 1, #self._equipSuits do
		if self._equipSuits[iter_4_0]:getServerData().id == arg_4_1 then
			for iter_4_1 = 1, 4 do
				if EquipDevelopLayer.EQUIP_TYPE_ORDER[self._equipSuits[iter_4_0]:getCfg().type] == iter_4_1 then
					var_4_0 = iter_4_1 - 1
				end
			end
		end
	end

	self.m_equipSuitList:setSelectedIndex(var_4_0)
	self:_updateCommonView()
	self:_updateTab(arg_4_1, self.m_tabSelectController:getSelectedIndex() + 1)
end

function EquipDevelopLayer:_initConfig()
	self.m_devComp:initConfig(EquipDevConfig)
end

function EquipDevelopLayer:_updateTab(arg_6_1, arg_6_2)
	self._curTabIndex = arg_6_2

	self.m_devComp:updateDevPanel({
		tabData = EquipDevConfig.DEV_LIST,
		initTabType = self._curTabIndex,
		data = self._equipData,
		customData = {
			id = self._equipData:getServerData().id
		}
	})
end

function EquipDevelopLayer:onLoad(arg_7_1, arg_7_2, arg_7_3)
	arg_7_2 = arg_7_2 or var_0_6.STRENGTH

	if self._isFirstEnter then
		self.m_devComp:refreshFuncUnlock()

		self._curTabIndex = arg_7_2
		self._isFirstEnter = false
	else
		arg_7_2 = self._curTabIndex or var_0_6.STRENGTH

		if self._equipData then
			arg_7_3 = self._equipData:getServerData().id
		end
	end

	if not table.keyof(var_0_6, arg_7_2) then
		g.core.log:error("Invalid Index: " .. tostring(arg_7_2))
	end

	var_0_9.EventManager:addEventListener(var_0_9.enum.EVENT_NET_S2C_EQUIPMENT_UPGRADE, handler(self, self._onEquipmentUpgrade), self)
	var_0_9.EventManager:addEventListener(var_0_9.enum.EVENT_NET_S2C_EQUIPMENT_REFINING, handler(self, self._onEquipmentRefining), self)
	var_0_9.EventManager:addEventListener(var_0_9.enum.EVENT_NET_S2C_EQUIPMENT_REFININGONELEVEL, handler(self, self._onEquipmentRefining), self)
	var_0_9.EventManager:addEventListener(var_0_9.enum.EVENT_NET_S2C_EQUIPMENT_GLYPH, handler(self, self._onRcvGlyph), self)
	var_0_9.EventManager:addEventListener(var_0_9.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION, handler(self, self._recvChangeFormation), self)
	var_0_9.EventManager:addEventListener(var_0_9.enum.EVENT_NET_S2C_EQUIPMENT_RESONANCE_UP, handler(self, self._onRcvResonanceUp), self)
	var_0_9.EventManager:addEventListener(var_0_9.enum.EVENT_NET_S2C_EQUIPMENT_MAGICALSTAGE_UP, handler(self, self._onRcvMagicalStageUp), self)
	self:_updateData(arg_7_3)
	self:_updateTab(arg_7_3, arg_7_2)
	self:setCtrlState("tabSelect", {
		index = arg_7_2 - 1
	})

	if self._isInWear then
		self.m_equipSuitList:setNumItems(#self._equipSuits)

		local var_7_0 = 0

		for iter_7_0 = 1, #self._equipSuits do
			if self._equipSuits[iter_7_0]:getServerData().id == arg_7_3 then
				var_7_0 = iter_7_0 - 1
			end
		end

		self.m_equipSuitList:setSelectedIndex(var_7_0)
	end

	self:_updateCommonView()
	self.m_oneKeyEquipStrengthenBtn:setVisible(g.core.common.ModuleUnlock:isModuleUnlock(var_0_8.EQUIP_STRENGTHEN_QUICK))
end

function EquipDevelopLayer:_onListEquipSuitItemRenderer(arg_8_1, arg_8_2)
	if self._equipSuits[arg_8_1 + 1] then
		local var_8_1 = {
			changeControllers = true,
			magicalScale = 0.175,
			overrideClick = true,
			type = g.core.common.Goods.TYPE_EQUIP,
			value = self._equipSuits[arg_8_1 + 1]:getCfg().id,
			level = self._equipSuits[arg_8_1 + 1]:getServerData().level,
			serverId = self._equipSuits[arg_8_1 + 1]:getServerData().id,
			refineLevel = self._equipSuits[arg_8_1 + 1]:getServerData().refining_level,
			glyphLevel = self._equipSuits[arg_8_1 + 1]:getServerData().glyph_level
		}

		var_8_1.magicalStage = self._equipSuits[arg_8_1 + 1]:getServerData().magical_stage or 0

		local var_8_2 = var_8_1

		arg_8_2:updateIcon(var_8_1)
		arg_8_2:getController("isWear"):setSelectedIndex(1)

		local var_8_3 = arg_8_2:getChild("redPointComp")

		if var_8_3 then
			var_8_3:setId(122)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
				redPointComp = var_8_3,
				customData = {
					id = var_8_2.serverId
				}
			})
		end

		arg_8_2:setResonanceLevel((self._equipSuits[arg_8_1 + 1]:hasResonance() or nil) and self._equipSuits[arg_8_1 + 1]:getResonanceLevel())

		if self._upgradeItems[self._equipSuits[arg_8_1 + 1]:getServerData().id] then
			arg_8_2:playUpgradeAnim()
		end
	else
		arg_8_2:getController("isWear"):setSelectedIndex(0)
	end
end

function EquipDevelopLayer:_onEquipIconClick(arg_9_1)
	local var_9_0 = self._equipSuits[arg_9_1:getDataValue() + 1]

	if not var_9_0 then
		self:_updateNoEquipView()

		return
	end

	self._lastSelectIdx = self.m_equipSuitList:getSelectedIndex()
	self._equipData = var_9_0

	self:_updateView()
	self:_updateTab(var_9_0:getServerData().id, self.m_tabSelectController:getSelectedIndex() + 1)
	self.m_switchTransition:play()
end

function EquipDevelopLayer:_updateData(arg_10_1)
	self._equipSuits = {}
	self._equipData = var_0_1:getEquipBySid(arg_10_1)

	dump(arg_10_1)

	local var_10_0 = self._equipData:getPosition()

	self._knightId = self._equipData:getOwner():getInfo().id
	self._knightIndex = var_10_0 > 0 and math.ceil(var_10_0 / 4) or nil

	if var_10_0 ~= 0 then
		self._isInWear = true
		self._equipSuits = var_0_1:getEquipSuitByEquipPos(var_10_0)

		var_0_2(self._equipSuits, function(arg_11_0, arg_11_1)
			return EquipDevelopLayer.EQUIP_TYPE_ORDER[arg_11_0:getCfg().type] < EquipDevelopLayer.EQUIP_TYPE_ORDER[arg_11_1:getCfg().type]
		end)
	else
		self._isInWear = false
		self._equipSuits[1] = self._equipData
	end

	self:setCtrlState("isWear", {
		index = not self._isInWear and 1 or 0
	})
end

function EquipDevelopLayer:_onClickOneKeyEquipStrengthen()
	self._isCheckNotify = true

	if g.core.model.User.dayNotifyTool:isTodayHasRecord(DayNotifyToolConst.TYPE_EQUIP_ONE_KEY_STRENGTHEN, false) then
		self:onOneKeyStrengthen()
	else
		local var_12_0 = require("app.view.base.pop.BaseConfirmPop").new

		g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(1257),
			desc = g.core.lang:get(201590),
			onConfirm = handler(self, self.onOneKeyStrengthen),
			onCancel = function()
				return
			end,
			tip = {
				isChecked = true,
				txt = g.core.lang:get(201591)
			},
			onCheck = handler(self, self._onCheckClickNotify)
		})))
	end
end

function EquipDevelopLayer:_onCheckClickNotify(arg_14_1)
	self._isCheckNotify = arg_14_1
end

function EquipDevelopLayer:onOneKeyStrengthen()
	g.core.model.User.dayNotifyTool:saveTodayRecord(DayNotifyToolConst.TYPE_EQUIP_ONE_KEY_STRENGTHEN, self._isCheckNotify, false)

	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.EQUIP_STRENGTH) then
		return
	end

	local var_15_0 = g.core.model.User:getLevel() * 2
	local var_15_1 = {
		id = {},
		times = {}
	}
	local var_15_2 = 0
	local var_15_3 = {}
	local var_15_4 = g.core.model.User.resourceData:getCoin()
	local var_15_5 = false

	for iter_15_0 = 1, 10 do
		local var_15_6 = 0
		local var_15_7 = 0

		for iter_15_1, iter_15_2 in ipairs(self._equipSuits) do
			local var_15_8 = var_15_3[iter_15_1] or iter_15_2:getServerData().level

			if var_15_0 > var_15_8 then
				local var_15_9 = math.ceil(iter_15_2:getOnceStrengthCost(var_15_8))

				if var_15_4 >= var_15_2 + var_15_9 then
					var_15_3[iter_15_1] = var_15_8 + 1
					var_15_2 = var_15_2 + var_15_9
				else
					var_15_6 = var_15_6 + 1
					var_15_7 = var_15_7 + 1
				end
			else
				var_15_6 = var_15_6 + 1
			end
		end

		if var_15_7 > 0 then
			var_15_5 = true
		end

		if var_15_6 >= #self._equipSuits then
			break
		end
	end

	for iter_15_3, iter_15_4 in ipairs(self._equipSuits) do
		if var_15_3[iter_15_3] then
			table.insert(var_15_1.id, iter_15_4:getServerData().id)
			table.insert(var_15_1.times, var_15_3[iter_15_3] - iter_15_4:getServerData().level)
		end
	end

	if next(var_15_1.id) then
		g.core.network.GameNetProxy:send_C2S_Equipment_Upgrade(var_15_1)
	elseif var_15_5 then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			value = 3,
			type = g.core.common.Goods.TYPE_RESOURCE,
			size = g.core.model.User.resourceData:getCoin()
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(201514))
	end
end

function EquipDevelopLayer:_updateView()
	self:_updateCommonView()
end

function EquipDevelopLayer:_updateNoEquipView()
	self.m_nameTxt:setText("")
	self.m_equipIconComp:setVisible(false)
	self.m_devComp:updateDevPanel({
		tabData = EquipDevConfig.DEV_LIST,
		initTabType = self._curTabIndex
	})
end

function EquipDevelopLayer:_updateCommonView()
	local var_18_0 = self._equipData:getServerData()
	local var_18_1 = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_EQUIP,
		value = self._equipData:getCfg().id
	})

	self.m_equipIconComp:updateIcon({
		id = self._equipData:getCfg().id,
		icon = var_18_1.pic,
		equip = self._equipData,
		magicalStage = self._equipData:getMagicalStage()
	})
	self.m_equipIconComp:setVisible(true)
	self.m_nameTxt:setText(var_18_1.name)
	self.m_lineupComp:updateView({
		developType = "equipment",
		knightId = self._knightId,
		callback = handler(self, self._onChangeKnight)
	})

	if self._lastEquipId ~= var_18_0.id then
		self._lastEquipId = var_18_0.id
		self._lastRefineLevel = var_18_0.refining_level
	end
end

function EquipDevelopLayer:_onEquipmentUpgrade(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	self._isLazy = var_0_1:isLazy()

	var_0_1:setLazy(false)
	self:playSummary(arg_19_4)
	self:_updateView()

	if self._isInWear then
		self._upgradeItems = {}

		for iter_19_0, iter_19_1 in ipairs(arg_19_4.id) do
			self._upgradeItems[iter_19_1] = true
		end

		self.m_equipSuitList:setNumItems(#self._equipSuits)
	end

	self._isLazy = false

	local var_19_0 = self._equipData:getOwner()

	if var_19_0 then
		local var_19_1 = var_0_1:getMasterByKnightId(var_19_0:getInfo().id)

		if var_19_1 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
				showNow = true,
				frontShow = {
					{
						flag = "equipMasterStarUp",
						func = function()
							return ShowFactory:showMasterUp(var_19_1)
						end
					}
				}
			})
		end
	end
end

function EquipDevelopLayer:_cacheStrengthEquipInfo(arg_21_1)
	self._curLevels = {}
	self._attrs = {}
	self._lastAttrValues = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		local var_21_0 = var_0_1:getEquipBySid(iter_21_1)
		local var_21_1 = var_21_0:getEquipAttrAll()

		self._curLevels[iter_21_1] = var_21_0:getServerData().level
		self._attrs[iter_21_1] = var_21_1[1].attr
		self._lastAttrValues[iter_21_1] = var_21_1[1].value
	end
end

function EquipDevelopLayer:playSummary(arg_22_1)
	local var_22_0 = arg_22_1.last_cri[#arg_22_1.last_cri] or 0

	if var_22_0 > 0 then
		if var_22_0 == var_0_4.EquipConst.EQUIP_STRENGTH_BIGCRI then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
				baseShowPop = {
					type = var_0_5.ET_STRENGTH_CRI_SUCCESS
				}
			})
		elseif var_22_0 == var_0_4.EquipConst.EQUIP_STRENGTH_CRI then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
				baseShowPop = {
					type = var_0_5.ET_STRENGTH_CRI_SUCCESS
				}
			})
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
				baseShowPop = {
					type = var_0_5.ET_STRENGTH_SUCCESS
				}
			})
		end
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
			baseShowPop = {
				type = var_0_5.ET_STRENGTH_SUCCESS
			}
		})
	end
end

function EquipDevelopLayer:_onRcvGlyph()
	self:_updateView()

	if self._isInWear then
		self.m_equipSuitList:setNumItems(#self._equipSuits)
	end
end

function EquipDevelopLayer:_onEquipmentRefining(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	self:_updateView()

	if self._isInWear then
		self.m_equipSuitList:setNumItems(#self._equipSuits)
	end

	self._lastRefineLevel = self._equipData:getServerData().refining_level

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
		baseShowPop = {
			type = var_0_5.ET_REFINE_SUCCESS
		}
	})

	local var_24_0 = self._equipData:getOwner()

	if var_24_0 then
		local var_24_1 = var_0_1:getMasterByKnightId(var_24_0:getInfo().id)

		if var_24_1 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
				showNow = true,
				frontShow = {
					{
						flag = "equipMasterStarUp",
						func = function()
							return ShowFactory:showMasterUp(var_24_1)
						end
					}
				}
			})
		end
	end
end

function EquipDevelopLayer:_recvChangeFormation(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	if arg_26_4.tp == 3 and arg_26_4.pos > 0 and arg_26_4.tp == 3 then
		self:_changeEquip(arg_26_4.id)
	end
end

function EquipDevelopLayer:_onChangeKnight(arg_27_1)
	local var_27_0 = var_0_10:getKnightById(arg_27_1):getFormationPos()
	local var_27_1 = var_0_1:getEquipSuitByKnightPos(var_27_0)

	if #var_27_1 > 0 then
		local var_27_2 = 0

		for iter_27_0 = 1, #var_27_1 do
			if type(var_27_1[iter_27_0]) ~= "number" and var_27_1[iter_27_0].getCfg then
				self:_changeEquip(var_27_1[iter_27_0]:getServerData().id)

				ETData.needChangeKnight = true
				ETData.knightId = arg_27_1

				return true
			else
				var_27_2 = var_27_2 + 1
			end
		end

		if var_27_2 == 4 then
			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(302032),
				desc = g.core.lang:get(201552),
				onConfirm = handler(self, function()
					ETData.needChangeKnight = true
					ETData.knightId = arg_27_1

					g.core.module.ModuleManager:pushModule(g.view.entrance.EQUIP_AND_TREASURE, {
						knightId = arg_27_1,
						knightIndex = var_27_0
					})
				end)
			}))

			return false
		end
	else
		return false
	end

	return true
end

function EquipDevelopLayer:receiveCompEvent(arg_29_1)
	if arg_29_1 == "BaseDevelopPanelComp_tab" then
		local var_29_0 = ({
			...
		})[1].tabData

		self._curTabIndex = var_29_0.index

		self:setSelectedIndex("tabSelect", var_29_0.index - 1)

		if var_29_0.index == var_0_6.RESONANCE then
			self.m_topBarComp:setResInfoById(248)
		else
			self.m_topBarComp:setResInfoById(52)
		end

		if var_29_0.index == var_0_6.MAGICAL then
			local var_29_1 = var_0_1:getSuitMagicalActiveMap(self._equipData:getKnightPos())

			self.m_suitInfoComp:updateView({
				suitActiveMap = var_29_1,
				equip = self._equipData
			})

			self._curSuitActiveMap = var_29_1

			if self._isExpand and self._expandHandler then
				self:cancelSchedule(self._expandHandler)

				self._expandHandler = nil
			end

			self._isExpand = false

			self:_onExpandChanged()

			self._expandHandler = self:newScheduleOnce(handler(self, self._autoCollapse), 3)
		else
			self._isExpand = true

			self:_onExpandChanged()
		end
	elseif arg_29_1 == "EVENT_EQUIPMENT_UPGRADE" then
		local var_29_2 = {
			...
		}

		self:_cacheStrengthEquipInfo(var_29_2[1].id)
		g.core.network.GameNetProxy:send_C2S_Equipment_Upgrade(var_29_2[1])
	elseif arg_29_1 == "close_knight_select_view" then
		self:_closeLineUpView()
	end
end

function EquipDevelopLayer:_closeLineUpView()
	self.m_lineupComp:showLineUpView(false)
end

function EquipDevelopLayer:_closeSelectMaterialView()
	local var_31_0 = self.m_devComp:getDevCompByType(var_0_6.RESONANCE)

	if var_31_0 and var_31_0.resetMaterialSelect then
		var_31_0:resetMaterialSelect()
	end
end

function EquipDevelopLayer:_onTouchBg()
	self:_closeSelectMaterialView()
end

function EquipDevelopLayer:_autoCollapse()
	self._expandHandler = nil

	self:_onExpandChanged()
end

function EquipDevelopLayer:_onExpandChanged()
	self._isExpand = not self._isExpand

	self.m_isExpandController:setSelectedIndex(self._isExpand and 1 or 0)

	if self._isExpand then
		self.m_suitInfoComp:playShow()
	else
		if self._expandHandler then
			self:cancelSchedule(self._expandHandler)

			self._expandHandler = nil
		end

		self.m_suitInfoComp:playHide()
	end
end

function EquipDevelopLayer:_onRcvResonanceUp(arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	self:_updateData(arg_35_4.id)
	self.m_equipSuitList:setNumItems(#self._equipSuits)

	local var_35_0 = self._equipData:getOwner()

	if var_35_0 then
		local var_35_1 = var_0_1:getMasterByKnightId(var_35_0:getInfo().id)

		if var_35_1 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
				showNow = true,
				afterShow = {
					{
						flag = "equipMasterStarUp",
						func = function()
							return ShowFactory:showMasterUp(var_35_1)
						end
					}
				}
			})
		end
	end
end

function EquipDevelopLayer:_onRcvMagicalStageUp(arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	local var_37_0 = {}
	local var_37_1 = self._equipData:getSuitId()
	local var_37_2 = var_0_1:getCacheActiveSuitMap()
	local var_37_3 = var_0_1:getSuitMagicalActiveMap(self._equipData:getKnightPos())
	local var_37_4

	if var_37_3 then
		var_37_4 = var_37_3[var_37_1] or {}
	end

	self.m_equipSuitList:setNumItems(#self._equipSuits)
	self.m_equipIconComp:updateIcon({
		id = self._equipData:getCfg().id,
		icon = g.core.common.Goods:convert({
			type = g.core.common.Goods.TYPE_EQUIP,
			value = self._equipData:getCfg().id
		}).pic,
		equip = self._equipData,
		magicalStage = self._equipData:getMagicalStage()
	})
	self.m_suitInfoComp:updateView({
		suitActiveMap = var_37_3,
		equip = self._equipData
	})
	table.insert(var_37_0, {
		flag = "SINGLE_SUIT",
		func = function()
			return var_0_12:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
				equip = self._equipData,
				title = g.core.lang:get(201662),
				showComp = fgui.UIPackage:createObject("equipAndTreasure", "EquipMagicalStageUpComp")
			}), {
				touchDisappear = true,
				hideContinue = false
			})
		end
	})

	local var_37_5

	if var_37_2 then
		var_37_5 = var_37_2[var_37_1] or {}
	end

	local var_37_6 = var_37_5.minStage or -1
	local var_37_7 = var_37_4.minStage or -1
	local var_37_8 = var_37_4.maxStage or -1

	if (var_37_5.maxStage or -1) < var_37_8 then
		local var_37_9 = var_0_1:getSuitStageInfoBySuitIdAndStage(var_37_1, var_37_8)

		table.insert(var_37_0, {
			flag = "TWO_SUIT",
			func = function()
				return var_0_12:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
					cfg = var_37_9,
					suitType = var_0_13.EQUIP_SUIT_TYPE.TWO,
					suitId = var_37_1,
					stage = var_37_8,
					title = g.core.lang:get(201663),
					showComp = fgui.UIPackage:createObject("equipAndTreasure", "EquipMagicalSuitStageUpComp")
				}), {
					touchDisappear = true,
					hideContinue = false
				})
			end
		})
	end

	if var_37_6 < var_37_7 then
		local var_37_10 = var_0_1:getSuitStageInfoBySuitIdAndStage(var_37_1, var_37_7)

		table.insert(var_37_0, {
			flag = "FOUR_SUIT",
			func = function()
				return var_0_12:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
					cfg = var_37_10,
					suitType = var_0_13.EQUIP_SUIT_TYPE.FOUR,
					suitId = var_37_1,
					stage = var_37_7,
					title = g.core.lang:get(201663),
					showComp = fgui.UIPackage:createObject("equipAndTreasure", "EquipMagicalSuitStageUpComp")
				}), {
					touchDisappear = true,
					hideContinue = false
				})
			end
		})
	end

	var_0_9.EventManager:dispatchEvent(var_0_9.enum.EVENT_ADD_POP_SHOW, false, {
		showNow = true,
		frontShow = var_37_0
	})
end

return EquipDevelopLayer
