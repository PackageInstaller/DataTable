local var_0_0 = g.core.model.User.roleSkinData
local var_0_1 = g.core.const.ConstMgr.RoleSkinConst
local BattleKnight = require("app.view.battle.BattleKnight")
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.event.enum
local var_0_5 = g.core.module.ModuleManager
local RoleSkinDevConfig = require("app.view.module.roleSkin.const.RoleSkinDevConfig")
local RoleSkinLayer = class("RoleSkinLayer", require("app.fairyGUI.roleSkin.UI_RoleSkinLayer"), function()
	return fgui.GComponent:create({
		resName = "RoleSkinLayer",
		pkgPath = "ui/roleSkin/roleSkin",
		isFullScreen = true,
		pkgName = "roleSkin"
	}, ...)
end)

function RoleSkinLayer:ctor(arg_2_1)
	self:_initData(arg_2_1)
	self:_initView()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.ROLE_SKIN)
end

function RoleSkinLayer:_initData(arg_3_1)
	self._showAwardArr = {}
	self._redDevTabData = {}
	self._spine = nil
	self._struct = nil

	if arg_3_1 then
		self._curPart = arg_3_1.part or var_0_1.PART.CLOTH
	end

	self._redDevTabData.part = self._curPart
	self._curShowParams = {}

	if arg_3_1 then
		self._curTabIndex = arg_3_1.devType or RoleSkinDevConfig.DEV_TYPE.LEVEL
	end

	self._partItemList = {}
	self._curSelIndex = 0
	self._tabList = {}

	for iter_3_0, iter_3_1 in ipairs((self.m_tabList:getChildren())) do
		table.insert(self._tabList, iter_3_1)
	end
end

function RoleSkinLayer:_initView()
	self.m_tabList:setSelectedIndex(self._curPart - 1)
	self.m_runnerComp:init({
		target = self.m_tabList
	})
	self:addBg("bg/common/pic_yht_beijing.jpg")
	self.m_topBarComp:setResInfoById(self._curTabIndex == RoleSkinDevConfig.DEV_TYPE.LEVEL and 349 or 350)
	self.m_partName:setText(var_0_0:getPartNameByPart(self._curPart, true))
	self.m_partItemList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickPartItem))
	self.m_partItemList:setVirtual()
	self.m_partItemList:setItemRenderer(handler(self, self._onRenderPartItemList))
	self.m_wearBtn:addClickListener(handler(self, self._onClickWearBtn))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onPartChanged))
end

function RoleSkinLayer:onLoad()
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_SKIN_PART_GETINFO, handler(self, self._onS2CGetInfo), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_SKIN_PART_WEAR, handler(self, self._onS2CWear), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_SKIN_PART_LEVELUP, handler(self, self._onS2CLevelUp), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_SKIN_PART_STAGEUP, handler(self, self._onS2CStageUp), self)
	g.core.network.GameNetProxy:send_C2S_SkinPart_GetInfo({})
	self.m_enterTransition:play()
end

function RoleSkinLayer:_updateRedPoint()
	for iter_6_0, iter_6_1 in ipairs(self._tabList) do
		local var_6_0 = iter_6_1:getChild("redPointComp")

		if self._curTabIndex == RoleSkinDevConfig.DEV_TYPE.LEVEL then
			var_6_0:setShow(var_0_0:hasSkinPartCanLevelUp({
				part = iter_6_0
			}))
		elseif self._curTabIndex == RoleSkinDevConfig.DEV_TYPE.STAGE then
			var_6_0:setShow(var_0_0:hasSkinPartCanStageUp({
				part = iter_6_0
			}))
		else
			var_6_0:setShow(false)
		end
	end
end

function RoleSkinLayer:_onS2CGetInfo(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self._showAwardArr = arg_7_4.awards or {}
	self._curShowParams = {
		[var_0_1.PART.CLOTH] = var_0_0:getWearAdvanceIdByPart(var_0_1.PART.CLOTH),
		[var_0_1.PART.BACK] = var_0_0:getWearAdvanceIdByPart(var_0_1.PART.BACK),
		[var_0_1.PART.WEAPON] = var_0_0:getWearAdvanceIdByPart(var_0_1.PART.WEAPON)
	}

	self:_seqShowAward()
	self:_updateView()
	self:_updateDevelopComp()
	self:_updateRedPoint()
end

function RoleSkinLayer:_onS2CWear(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self.m_partItemList:setNumItems(#self._partItemList)
	self.m_effEquip:removeChildren()
	self.m_effEquip:addEffectSpine({
		anim = "play",
		name = "eff_ui_roleSkin_equip",
		remove = true,
		isLoop = false
	})
	self.m_equipTransition:play()

	if self._struct then
		self.m_wearBtn:setCtrlState("wearState", {
			index = self:_getWearState()
		})
	end
end

function RoleSkinLayer:_onS2CLevelUp(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self:_updatePartItemList()
	self:_updateRedPoint()
end

function RoleSkinLayer:_onS2CStageUp(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self:_updatePartItemList()
	self:_updateSpineSkin((var_0_0:getPartItemByAdvanceId(arg_10_4.advance_id)))
	self:_updateRedPoint()
	self.m_nameComp:updateNameComp(self._struct)
end

function RoleSkinLayer:_updateView()
	self._partItemList = var_0_0:getPartItemListByPart(self._curPart, true)
	self._struct = var_0_0:getPartItemByAdvanceId(self._curShowParams[self._curPart])

	self.m_hasSelController:setSelectedIndex(checkbool(self._struct) and 1 or 0)
	self:_updatePartItemList()

	if self._struct then
		self:_updateCurShow(self._curShowParams)
	end

	self.m_ownNum:setText(var_0_0:getOwnNumByPart(self._curPart))
	self.m_totalNum:setText("/" .. #self._partItemList)
end

function RoleSkinLayer:_getLuaIndexInList(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(self._partItemList) do
		if iter_12_1:getAdvanceId() == arg_12_1 then
			return iter_12_0
		end
	end

	return 0
end

function RoleSkinLayer:_seqShowAward()
	if #self._showAwardArr == 0 then
		return
	end

	local var_13_0 = self._showAwardArr[1]

	table.remove(self._showAwardArr, 1)
	var_0_5:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
		data = var_13_0,
		title = g.core.lang:get(300001),
		showComp = fgui.UIPackage:createObject("roleSkin", "RoleSkinAwardComp"),
		func = handler(self, self._seqShowAward)
	}), {
		touchDisappear = true
	})
end

function RoleSkinLayer:_onPartChanged(arg_14_1)
	local var_14_0 = arg_14_1:getDataValue() + 1

	if var_14_0 == self._curPart then
		return
	end

	self._curPart = var_14_0
	self._redDevTabData.part = var_14_0

	self.m_partName:setText(var_0_0:getPartNameByPart(var_14_0, true))

	self._partItemList = var_0_0:getPartItemListByPart(var_14_0, true)

	self.m_partItemList:setNumItems(#self._partItemList)

	local var_14_1 = self:_getLuaIndexInList((var_0_0:getWearAdvanceIdByPart(self._curPart)))

	self.m_partItemList:setSelectedIndex(var_14_1 - 1)

	self._struct = self._partItemList[var_14_1]

	self.m_ownNum:setText(var_0_0:getOwnNumByPart(self._curPart))
	self.m_totalNum:setText("/" .. #self._partItemList)
	self.m_hasSelController:setSelectedIndex(checkbool(self._struct) and 1 or 0)

	if self._struct then
		self.m_wearBtn:setCtrlState("wearState", {
			index = self:_getWearState()
		})
		self.m_nameComp:updateNameComp(self._struct)
	end

	self._curSelIndex = var_14_1

	self:_updateOwnPartItemUI()
	self.m_rightPanel:updateRedTab()
end

function RoleSkinLayer:_getWearState()
	if not self._struct then
		return
	end

	if self._struct:isOwn() then
		return (var_0_0:getWearAdvanceIdByPart(self._curPart) == self._struct:getAdvanceId() or nil) and (var_0_1.WEAR_STATE.HAS_WEAR or var_0_1.WEAR_STATE.CAN_WEAR)
	else
		return var_0_1.WEAR_STATE.NOT_OWN
	end
end

function RoleSkinLayer:_updateCurShow(arg_16_1)
	self.m_wearBtn:setCtrlState("wearState", {
		index = self:_getWearState()
	})
	self.m_nameComp:updateNameComp(self._struct)

	if not self._spine or self._curShowParams[var_0_1.PART.CLOTH] ~= arg_16_1[var_0_1.PART.CLOTH] then
		local var_16_0 = var_0_0:getPartItemByAdvanceId(arg_16_1[var_0_1.PART.CLOTH])
		local var_16_1 = var_0_0:getPartItemByAdvanceId(arg_16_1[var_0_1.PART.BACK])

		if self._spine then
			self._spine:removeFromParent()
		end

		local var_16_2 = {
			isShowBack = true,
			isMainRole = true,
			resId = tonumber(var_16_0:getSpineId()),
			skinName = var_0_0:getPartItemByAdvanceId(arg_16_1[var_0_1.PART.WEAPON]):getSkinName()
		}

		var_16_2.backName = var_16_1 and var_16_1:getSpineId() or ""
		var_16_2.backSkin = var_16_1 and var_16_1:getSkinName() or ""
		self._spine = BattleKnight.new(var_16_2)

		self.m_spineDad:addNode(self._spine)
	else
		if self._curShowParams[var_0_1.PART.WEAPON] ~= arg_16_1[var_0_1.PART.WEAPON] then
			self._spine:changeSkin(var_0_0:getPartItemByAdvanceId(arg_16_1[var_0_1.PART.WEAPON]):getSkinName())
		end

		if self._curShowParams[var_0_1.PART.BACK] ~= arg_16_1[var_0_1.PART.BACK] then
			local var_16_3 = var_0_0:getPartItemByAdvanceId(arg_16_1[var_0_1.PART.BACK])

			self._spine:addKnightBackSpineAtSlot(var_16_3 and var_16_3:getSpineId() or "", var_16_3 and var_16_3:getSkinName() or "")
		end
	end

	self._spine:setScale(1.75)

	self._curShowParams = arg_16_1
end

function RoleSkinLayer:_updateSpineSkin(arg_17_1)
	if not self._spine then
		return
	end

	local var_17_0 = arg_17_1:getPart()

	if var_17_0 == var_0_1.PART.WEAPON then
		self._spine:changeSkin(arg_17_1:getSkinName())
	elseif var_17_0 == var_0_1.PART.BACK then
		local var_17_1 = arg_17_1 and arg_17_1:getSkinName() or ""
		local var_17_2 = self._spine:getBackSpine()

		if var_17_2 and var_17_1 ~= "" then
			var_17_2:changeSkin(var_17_1)
		end
	end
end

function RoleSkinLayer:_updateDevelopComp()
	self.m_rightPanel:updateDevPanel({
		tabData = RoleSkinDevConfig.DEV_LIST,
		initTabType = self._curTabIndex,
		data = {
			struct = self._struct
		},
		customData = self._redDevTabData
	})
end

function RoleSkinLayer:_onClickWearBtn()
	if self._struct then
		local var_19_0 = self.m_wearBtn:getController("wearState"):getSelectedIndex()

		if var_19_0 == var_0_1.WEAR_STATE.NOT_OWN then
			-- block empty
		elseif var_19_0 == var_0_1.WEAR_STATE.HAS_WEAR then
			var_0_5:tip(g.core.lang:get(430510))
		else
			g.core.network.GameNetProxy:send_C2S_SkinPart_Wear({
				advance_id = self._struct:getAdvanceId()
			})
		end
	end
end

function RoleSkinLayer:_onRenderPartItemList(arg_20_1, arg_20_2)
	arg_20_2:updateItem(self._partItemList[arg_20_1 + 1], self._curTabIndex)
end

function RoleSkinLayer:_onClickPartItem(arg_21_1)
	local var_21_0 = arg_21_1:getDataValue()
	local var_21_1 = self._partItemList[var_21_0 + 1]

	if self._partItemList[var_21_0 + 1]:isOwn() then
		self._struct = var_21_1
		self._curSelIndex = var_21_0

		self:_updateOwnPartItemUI()
		self.m_effRefresh:removeChildren()
		self.m_effRefresh:addEffectSpine({
			anim = "play",
			name = "eff_ui_roleSkin_refresh",
			remove = true,
			isLoop = false
		})
		self.m_equipTransition:play()
	else
		self.m_partItemList:setSelectedIndex(self._curSelIndex)
		var_0_5:pushPopup(require("app.view.module.roleSkin.view.RoleSkinInfoPop").new({
			struct = var_21_1
		}), {
			touchDisappear = false,
			ignoreTouch = false
		})
	end

	self.m_hasSelController:setSelectedIndex(checkbool(self._struct) and 1 or 0)

	self._redDevTabData.struct = var_21_1

	self.m_rightPanel:updateRedTab()
end

function RoleSkinLayer:_updateOwnPartItemUI()
	local var_22_0 = clone(self._curShowParams)

	if self._struct then
		var_22_0[self._curPart] = self._struct:getAdvanceId()

		self:_updateCurShow(var_22_0)
	end

	self:_updateDevelopComp()
end

function RoleSkinLayer:receiveCompEvent(arg_23_1)
	if arg_23_1 == "BaseDevelopPanelComp_tab" then
		self._curTabIndex = ({
			...
		})[1].tabData.index

		self:_updateRedPoint()
		self:_updatePartItemList()
		self.m_topBarComp:setResInfoById(self._curTabIndex == RoleSkinDevConfig.DEV_TYPE.LEVEL and 349 or 350)
	end
end

function RoleSkinLayer:_updatePartItemList()
	self.m_partItemList:setNumItems(#self._partItemList)
	self.m_partItemList:setSelectedIndex(self:_getLuaIndexInList((self._struct or nil) and (self._struct:getAdvanceId() or var_0_0:getWearAdvanceIdByPart(self._curPart))) - 1)
end

return RoleSkinLayer
