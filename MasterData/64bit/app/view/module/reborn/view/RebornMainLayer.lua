local RebornConst = require("app.view.module.reborn.const.RebornConst")
local var_0_1 = RebornConst.SELECT_INDEX_MAP
local var_0_2 = g.core.const.ConstMgr
local var_0_3 = g.core.common.Goods
local var_0_4 = g.core.common.Path
local var_0_5 = g.core.module.ModuleManager
local var_0_6 = g.core.model.User.rebornData
local var_0_7 = {
	[RebornConst.SELECT_INDEX_MAP.KNIGHT] = RebornConst.TYPE_KNIGHT,
	[RebornConst.SELECT_INDEX_MAP.EQUIP] = RebornConst.TYPE_EQUIP,
	[RebornConst.SELECT_INDEX_MAP.TREASURE] = RebornConst.TYPE_TREASURE,
	[RebornConst.SELECT_INDEX_MAP.TOKEN] = RebornConst.TYPE_UNITE_TOKEN,
	[RebornConst.SELECT_INDEX_MAP.ARTIFACT] = RebornConst.TYPE_ARTIFACT,
	[RebornConst.SELECT_INDEX_MAP.FURNITURE] = RebornConst.TYPE_FURNITURE,
	[RebornConst.SELECT_INDEX_MAP.PET] = RebornConst.TYPE_PET,
	[RebornConst.SELECT_INDEX_MAP.CUSTOM_FRAG] = RebornConst.TYPE_CUSTOM_FRAG
}
local RebornMainLayer = class("RebornMainLayer", require("app.fairyGUI.reborn.UI_RebornMainLayer"), function()
	return fgui.GComponent:create({
		resName = "RebornMainLayer",
		pkgName = "reborn",
		isFullScreen = true,
		pkgPath = "ui/reborn/reborn"
	}, ...)
end)

function RebornMainLayer:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	if arg_2_1.title then
		self.m_topBar:setTitle(arg_2_1.title)
	end

	self._selectedTabIndex = arg_2_1.index or 1
	self._knightRebornList = {}
	self._allEquipRebornList = {}
	self._allTreasureRebornList = {}
	self._allCustomFragRebornList = {}
	self._allRebornTokenList = {}
	self._allRebornArtifactList = {}
	self._allFurnitureIdArr = {}
	self._allRebornPetList = {}
	self._selectedTable = {}

	self.m_tabList:setVirtual()
	self.m_tabList:setItemRenderer(handler(self, self._onTabRenderer))

	self._tabCfg = var_0_6:getRebornList()

	self.m_typeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabCtrl))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabItemClick))
	self.m_rebornBtn:addClickListener(handler(self, self._onRebornBtnClick))
	self.m_rebornBtn1:addClickListener(handler(self, self._onRebornBtnClick))
	self.m_furnitureSellBtn:addClickListener(handler(self, self._onRebornBtnClick))
	self.m_selectAllBtn:addClickListener(handler(self, self._onSelectAllBtnClick))
	self:initList()
	self:addBg("bg/common/pic_bb_beijing.jpg")
end

function RebornMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_REBORN_EXECUTE, self._onReceiveRebornExecute, self)
	self.m_tabList:setNumItems(#self._tabCfg)

	local var_3_0 = self._selectedTabIndex

	for iter_3_0 = 1, #self._tabCfg do
		if self._tabCfg[iter_3_0].index == self._selectedTabIndex then
			var_3_0 = iter_3_0
		end
	end

	if self._tabCfg[1] then
		self.m_typeController:setSelectedIndex(self._tabCfg[1].index - 1)

		if self._selectedTabIndex then
			self.m_tabList:setSelectedIndex(var_3_0 - 1)
			self.m_typeController:setSelectedIndex(self._selectedTabIndex - 1)
		else
			self.m_tabList:setSelectedIndex(0)
		end
	end

	self:_onChangeTabCtrl()
	self.m_decorativePointLoader:setURL((var_0_4:getIconByTypeValue(var_0_3.TYPE_RESOURCE, var_0_3.RESOURCE.TYPE_DECORATIVE_POINT, true)))
	self:updateTabShow()
end

function RebornMainLayer:_onTabRenderer(arg_4_1, arg_4_2)
	arg_4_2:setTitle(self._tabCfg[arg_4_1 + 1].name)
	arg_4_2:setRedPointId(self._tabCfg[arg_4_1 + 1].redPointId)
end

function RebornMainLayer:_onTabItemClick()
	local var_5_0 = self.m_tabList:getSelectedIndex() + 1

	if self._selectedTabIndex + 1 ~= self._tabCfg[var_5_0].index then
		self._selectedTabIndex = self._tabCfg[var_5_0].index

		self.m_typeController:setSelectedIndex(self._tabCfg[var_5_0].index - 1)
	end
end

function RebornMainLayer:initList()
	self.m_knightList:setVirtual()
	self.m_knightList:setItemRenderer(handler(self, self._onKnightListRenderer))
	self.m_knightList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onKnightItemClick))
	self.m_knightList:doFairyBatching(false)
	self.m_equipList:setVirtual()
	self.m_equipList:setItemRenderer(handler(self, self._onEquipListRenderer))
	self.m_uniteTokenList:setVirtual()
	self.m_uniteTokenList:setItemRenderer(handler(self, self._onTokenListRenderer))
	self.m_uniteTokenList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onUniteTokenItemClick))
	self.m_uniteTokenList:doFairyBatching(false)
	self.m_artifactList:setVirtual()
	self.m_artifactList:setItemRenderer(handler(self, self._onArtifactListRenderer))
	self.m_artifactList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onArtifactItemClick))
	self.m_artifactList:doFairyBatching(false)
	self.m_furnitureList:setItemIniter(function(arg_7_0, arg_7_1)
		fgui.UIPackage.iterObject(arg_7_1, self)
		fgui.UIPackage.bindUIComponent(arg_7_1, "app.view.module.reborn.view.RebornFurnitureCell", self)
	end)
	self.m_furnitureList:setVirtualBase()
	self.m_furnitureList:doFairyBatching(true)
	self.m_furnitureList:setItemRenderer(handler(self, self._onFurnitureListRenderer))
	self.m_furnitureList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onFurnitureItemClick))
	self.m_petList:setItemIniter(function(arg_8_0, arg_8_1)
		fgui.UIPackage.iterObject(arg_8_1, self)
		fgui.UIPackage.bindUIComponent(arg_8_1, "app.view.module.reborn.view.RebornPetCell", self)
	end)
	self.m_petList:setVirtual()
	self.m_petList:doFairyBatching(true)
	self.m_petList:setItemRenderer(handler(self, self._onPetListRenderer))
	self.m_petList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onPetItemClick))
	self.m_ableFragmentList:setVirtual()
	self.m_ableFragmentList:setItemRenderer(handler(self, self._onAbleFragRenderer))
	self.m_qualityFilterComp:initComp(var_0_2.QUALITY_TYPE.R, var_0_2.QUALITY_TYPE.SSR)
end

function RebornMainLayer:updateTabShow()
	self:_onChangeTabCtrl()
end

function RebornMainLayer:_onReceiveRebornExecute(arg_10_1, arg_10_2, arg_10_3)
	var_0_5:awardSummary(arg_10_3.awards, false, nil, g.core.lang:get(103004))
	self:updateTabShow()
end

function RebornMainLayer:receiveCompEvent(arg_11_1)
	if arg_11_1 == "RebornItemStateChange" then
		self:_updateCostShow()
	elseif arg_11_1 == "ChangeFiltrateQualityType" then
		self:_onChangeFiltrateQualityType()
	end
end

function RebornMainLayer:_onReceiveRebornPreview(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	return
end

function RebornMainLayer:_onRebornBtnClick()
	local var_13_0 = self._selectedTabIndex + 1

	if ({
		[RebornConst.SELECT_INDEX_MAP.EQUIP] = true,
		[RebornConst.SELECT_INDEX_MAP.TREASURE] = true,
		[RebornConst.SELECT_INDEX_MAP.CUSTOM_FRAG] = true
	})[self._selectedTabIndex + 1] then
		if not next(self._selectedTable) then
			var_0_5:tip(g.core.lang:get(103001))

			return
		end

		local var_13_1 = g.core.lang:get(103003)
		local var_13_2

		if self._selectedTabIndex + 1 == RebornConst.SELECT_INDEX_MAP.TREASURE then
			if self:checkTreasureBagIsFull() then
				return
			end

			var_13_1 = g.core.lang:get(103007)
		elseif self._selectedTabIndex + 1 == RebornConst.SELECT_INDEX_MAP.CUSTOM_FRAG then
			var_13_1 = g.core.lang:get(103042)
			var_13_2 = require("app.view.base.pop.BaseConfirmPop").new
		end

		var_0_5:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(103002),
			desc = var_13_1,
			onConfirm = handler(self, self._sendRebornRequest)
		}))
	elseif self._selectedTabIndex + 1 == RebornConst.SELECT_INDEX_MAP.FURNITURE then
		local var_13_3 = self:_getSelectedFurnitureIdArr()

		if #var_13_3 == 0 then
			var_0_5:tip(g.core.lang:get(103012))

			return
		end

		if self:_isIncludeSSRFurniture(var_13_3) then
			var_0_5:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(103013),
				desc = g.core.lang:get(103014),
				onConfirm = handler(self, function()
					self:_sendSellFurnitureRequest(var_13_3)
				end)
			})))
		else
			self:_sendSellFurnitureRequest(var_13_3)
		end
	else
		local var_13_4
		local var_13_5 = 103002
		local var_13_6 = 103003

		if self._selectedTabIndex + 1 == RebornConst.SELECT_INDEX_MAP.KNIGHT then
			var_13_4 = self._knightRebornList[self._knightRebornSelectIndex + 1]
			var_13_5 = 103005
			var_13_6 = 103006
		elseif self._selectedTabIndex + 1 == RebornConst.SELECT_INDEX_MAP.TOKEN then
			var_13_4 = self._allRebornTokenList[self._rebornSelectIndex + 1]
		elseif self._selectedTabIndex + 1 == RebornConst.SELECT_INDEX_MAP.ARTIFACT then
			var_13_4 = self._allRebornArtifactList[self._rebornSelectIndex + 1]
			var_13_6 = 103040
		elseif self._selectedTabIndex + 1 == RebornConst.SELECT_INDEX_MAP.PET then
			var_13_4 = self._allRebornPetList[self._rebornSelectIndex + 1]
		end

		if not var_13_4 then
			return
		end

		local var_13_7
		local var_13_8

		if var_13_4.getServerId then
			var_13_7 = var_13_4:getServerId()
		elseif var_13_4.getServerOnlyId then
			var_13_7 = var_13_4:getServerOnlyId()
		else
			var_13_7 = var_13_4:getSid()
			var_13_8 = require("app.view.base.pop.BaseConfirmPop").new
		end

		var_0_5:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(var_13_5),
			desc = g.core.lang:get(var_13_6),
			onConfirm = function()
				g.core.network.GameNetProxy:send_C2S_Reborn_Execute({
					sys_type = var_0_7[var_13_0],
					op_type = RebornConst.OP_TYPE_REBORN,
					ids = {
						var_13_7
					}
				})
			end
		}))
	end
end

function RebornMainLayer:_onSelectAllBtnClick()
	for iter_16_0 = 1, #self._allEquipRebornList do
		self._selectedTable[iter_16_0] = true
	end

	self.m_equipList:selectAll()
	self.m_equipList:setNumItems(#self._allEquipRebornList)
	self:_updateCostShow()
end

function RebornMainLayer:checkTreasureBagIsFull()
	if g.core.config.role_info.get(g.core.model.User:getLevel()).treasure_bag_num_client <= g.core.model.User.treasureData:countTreasureNum() then
		g.core.module.ModuleManager:pushPopup((require("app.view.base.component.BaseAssistPopComp").new({
			text = g.core.lang:get(1215),
			text_ok = g.core.lang:get(1103),
			text_cancel = g.core.lang:get(1084),
			handler_ok = function()
				g.core.module.ModuleManager:pushModule(g.view.entrance.LINE_UP)
			end
		})))

		return true
	end

	return false
end

function RebornMainLayer:_getSelectedRebornItemList()
	local var_19_0 = {}

	if next(self._selectedTable) then
		if self._selectedTabIndex + 1 == var_0_1.EQUIP then
			for iter_19_0, iter_19_1 in pairs(self._selectedTable) do
				if iter_19_1 then
					table.insert(var_19_0, self._allEquipRebornList[iter_19_0]:getServerData().id)
				end
			end
		elseif self._selectedTabIndex + 1 == var_0_1.TREASURE then
			for iter_19_2, iter_19_3 in pairs(self._selectedTable) do
				if iter_19_3 then
					table.insert(var_19_0, self._allTreasureRebornList[iter_19_2].id)
				end
			end
		end
	end

	return var_19_0
end

function RebornMainLayer:_sendRebornRequest()
	g.core.network.GameNetProxy:send_C2S_Reborn_Execute({
		sys_type = var_0_7[self._selectedTabIndex + 1],
		op_type = RebornConst.OP_TYPE_REBORN,
		ids = self:_getSelectedRebornItemList()
	})
end

function RebornMainLayer:_onChangeTabCtrl()
	self._selectedTabIndex = self.m_typeController:getSelectedIndex()

	if self._selectedTabIndex + 1 == var_0_1.KNIGHT then
		self:refreshKnightRebornShow()
	elseif self._selectedTabIndex + 1 == var_0_1.EQUIP then
		self:refreshEquipRebornShow()
	elseif self._selectedTabIndex + 1 == var_0_1.TREASURE then
		self:refreshTreasureRebornShow()
	elseif self._selectedTabIndex + 1 == var_0_1.TOKEN then
		self:refreshTokenRebornShow()
	elseif self._selectedTabIndex + 1 == var_0_1.ARTIFACT then
		self:refreshArtifactRebornShow()
	elseif self._selectedTabIndex + 1 == var_0_1.FURNITURE then
		self:refreshFurnitureRebornShow()
	elseif self._selectedTabIndex + 1 == var_0_1.PET then
		self:refreshPetRebornShow()
	elseif self._selectedTabIndex + 1 == var_0_1.CUSTOM_FRAG then
		self:refreshCustomFragRebornShow()
	end
end

function RebornMainLayer:refreshKnightRebornShow()
	self._knightRebornList = var_0_6:getKnightRebornList()

	if #self._knightRebornList == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_knightList:setNumItems(#self._knightRebornList)
		self.m_knightList:transitionShowCells("enter_scaleOut", 0.03, 1)

		self._knightRebornSelectIndex = 0

		self.m_knightList:setSelectedIndex(self._knightRebornSelectIndex)
		self:_updateRightView(self._knightRebornList[self._knightRebornSelectIndex + 1], RebornConst.TYPE_KNIGHT)
	end

	var_0_6:setIgnoreKnight()
end

function RebornMainLayer:_onKnightListRenderer(arg_23_1, arg_23_2)
	arg_23_2:updateView(self._knightRebornList[arg_23_1 + 1])
end

function RebornMainLayer:_onKnightItemClick()
	g.core.sound.SoundManager:playSound(var_0_2.SoundConst.Sound.CLICK_ENTER)

	self._knightRebornSelectIndex = self.m_knightList:getSelectedIndex()

	self:_updateRightView(self._knightRebornList[self._knightRebornSelectIndex + 1], RebornConst.TYPE_KNIGHT)
end

function RebornMainLayer:refreshEquipRebornShow()
	self._selectedTable = {}

	self.m_equipList:clearSelection()

	self._allEquipRebornList = var_0_6:getEquipRebornList(true)

	local var_25_0 = #self._allEquipRebornList

	if #self._allEquipRebornList == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
	end

	self.m_equipList:setNumItems(var_25_0)
	self.m_equipList:transitionShowCells("listIconUiScaleIn", 0.03, 1)
	self:_updateCostShow()
end

function RebornMainLayer:_updateCostShow()
	if next(self._selectedTable) then
		self:_updateCost()
	else
		self.m_isShowCostController:setSelectedIndex(0)
	end
end

function RebornMainLayer:_updateCost()
	local var_27_0 = var_0_6:getCfgByType(var_0_7[self._selectedTabIndex + 1], 1)

	if var_27_0.cost_type == 0 or var_27_0.cost_size == 0 then
		self.m_isShowCostController:setSelectedIndex(0)
	else
		self.m_isShowCostController:setSelectedIndex(1)

		local var_27_1 = table.nums(self._selectedTable)

		self.m_resComp:updateByTVS({
			type = var_27_0.cost_type,
			value = var_27_0.cost_value,
			size = var_27_0.cost_size * var_27_1
		})
		self.m_resComp1:updateByTVS({
			type = var_27_0.cost_type,
			value = var_27_0.cost_value,
			size = var_27_0.cost_size * var_27_1
		})
	end
end

function RebornMainLayer:_onEquipListRenderer(arg_28_1, arg_28_2)
	if self._selectedTabIndex + 1 == var_0_1.EQUIP then
		arg_28_2:updateItem(arg_28_1 + 1, self._allEquipRebornList[arg_28_1 + 1]:getServerData(), var_0_3.TYPE_EQUIP, self._selectedTable)
	elseif self._selectedTabIndex + 1 == var_0_1.TREASURE then
		arg_28_2:updateItem(arg_28_1 + 1, self._allTreasureRebornList[arg_28_1 + 1], var_0_3.TYPE_TREASURE, self._selectedTable)
	elseif self._selectedTabIndex + 1 == var_0_1.CUSTOM_FRAG then
		arg_28_2:updateItem(arg_28_1 + 1, self._allCustomFragRebornList[arg_28_1 + 1], var_0_3.TYPE_ITEM, self._selectedTable)
	end
end

function RebornMainLayer:refreshTreasureRebornShow()
	self._selectedTable = {}

	self.m_equipList:clearSelection()

	self._allTreasureRebornList = var_0_6:getTreasureRebornList()

	local var_29_0 = #self._allTreasureRebornList

	if #self._allTreasureRebornList == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
	end

	self.m_equipList:setNumItems(var_29_0)
	self.m_equipList:transitionShowCells("listIconUiScaleIn", 0.03, 1)
	self:_updateCostShow()
end

function RebornMainLayer:refreshTokenRebornShow()
	self._allRebornTokenList = var_0_6:getTokenRebornList()

	if #self._allRebornTokenList == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_uniteTokenList:setNumItems(#self._allRebornTokenList)
		self.m_uniteTokenList:transitionShowCells("enter_scaleOut", 0.03, 1)

		self._rebornSelectIndex = 0

		self.m_uniteTokenList:setSelectedIndex(self._rebornSelectIndex)
		self:_updateRightView(self._allRebornTokenList[self._rebornSelectIndex + 1], RebornConst.UNITE_TOKEN)
	end
end

function RebornMainLayer:refreshArtifactRebornShow()
	self._allRebornArtifactList = var_0_6:getArtifactRebornList()

	if #self._allRebornArtifactList == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_artifactList:setNumItems(#self._allRebornArtifactList)
		self.m_artifactList:transitionShowCells("enter_scaleOut", 0.03, 1)

		self._rebornSelectIndex = 0

		self.m_artifactList:setSelectedIndex(self._rebornSelectIndex)
		self:_updateRightView(self._allRebornArtifactList[self._rebornSelectIndex + 1], RebornConst.ARTIFACT)
	end
end

function RebornMainLayer:_onTokenListRenderer(arg_32_1, arg_32_2)
	arg_32_2:updateView(self._allRebornTokenList[arg_32_1 + 1])
end

function RebornMainLayer:_onUniteTokenItemClick()
	g.core.sound.SoundManager:playSound(var_0_2.SoundConst.Sound.CLICK_ENTER)

	self._rebornSelectIndex = self.m_uniteTokenList:getSelectedIndex()

	self:_updateRightView(self._allRebornTokenList[self._rebornSelectIndex + 1], RebornConst.UNITE_TOKEN)
end

function RebornMainLayer:_onArtifactListRenderer(arg_34_1, arg_34_2)
	arg_34_2:updateView(self._allRebornArtifactList[arg_34_1 + 1])
end

function RebornMainLayer:_onArtifactItemClick()
	g.core.sound.SoundManager:playSound(var_0_2.SoundConst.Sound.CLICK_ENTER)

	self._rebornSelectIndex = self.m_artifactList:getSelectedIndex()

	self:_updateRightView(self._allRebornArtifactList[self._rebornSelectIndex + 1], RebornConst.ARTIFACT)
end

function RebornMainLayer:_updateRightView(arg_36_1, arg_36_2)
	if arg_36_2 == RebornConst.UNITE_TOKEN or arg_36_2 == RebornConst.ARTIFACT then
		local var_36_0 = ""
		local var_36_1

		if arg_36_2 == RebornConst.UNITE_TOKEN then
			var_36_0 = var_0_4:getUniteTokenCardImg(arg_36_1:getCfg().res_id)
			var_36_1 = var_0_6:getCfgByType(RebornConst.TYPE_UNITE_TOKEN, 1)
		elseif arg_36_2 == RebornConst.ARTIFACT then
			var_36_0 = var_0_4:getArtifactImg(arg_36_1:getCfg().res_id)
			var_36_1 = var_0_6:getCfgByType(RebornConst.TYPE_ARTIFACT, 1)
		end

		self.m_itemIcon:setURL(var_36_0)

		local var_36_2 = var_36_1 or {}
		local var_36_3 = var_36_2.cost_type or 0
		local var_36_4 = var_36_2.cost_size or 0
		local var_36_5 = var_36_2.cost_value or 0

		if var_36_4 == 0 then
			self.m_isShowCostController:setSelectedIndex(0)
		else
			self.m_isShowCostController:setSelectedIndex(1)
			self.m_resComp:updateByTVS({
				type = var_36_3,
				value = var_36_5,
				size = var_36_4
			})
			self.m_resComp1:updateByTVS({
				type = var_36_3,
				value = var_36_5,
				size = var_36_4
			})
		end
	elseif arg_36_2 == RebornConst.PET then
		self.m_petPicComp:setURL((g.core.common.Path:getPetMiddle(arg_36_1:getCfg().resource)))

		local var_36_6 = var_0_6:getCfgByType(RebornConst.TYPE_PET, 1)

		if var_36_6.cost_size == 0 then
			self.m_isShowCostController:setSelectedIndex(0)
		else
			self.m_isShowCostController:setSelectedIndex(1)
			self.m_resComp:updateByTVS({
				type = var_36_6.cost_type,
				value = var_36_6.cost_value,
				size = var_36_6.cost_size
			})
			self.m_resComp1:updateByTVS({
				type = var_36_6.cost_type,
				value = var_36_6.cost_value,
				size = var_36_6.cost_size
			})
		end
	else
		self.m_knightPicComp:updateKnight({
			resId = arg_36_1:getResInfo().painted_id
		})
		self.m_knightPicComp:setAlphaRect(var_0_2.SpineConst.MASK_TYPE.HORIZON, cc.rect(-100, 0, 200, 0), 200)

		local var_36_7 = var_0_6:getCfgByType(RebornConst.TYPE_KNIGHT, 1)

		if var_36_7.cost_size == 0 then
			self.m_isShowCostController:setSelectedIndex(0)
		else
			self.m_isShowCostController:setSelectedIndex(1)
			self.m_resComp:updateByTVS({
				type = var_36_7.cost_type,
				value = var_36_7.cost_value,
				size = var_36_7.cost_size
			})
			self.m_resComp1:updateByTVS({
				type = var_36_7.cost_type,
				value = var_36_7.cost_value,
				size = var_36_7.cost_size
			})
		end
	end
end

function RebornMainLayer:refreshFurnitureRebornShow()
	self._allFurnitureIdArr = g.core.model.User.furnitureData:getCanSellFurnitureIdArr()
	self._selectedTable = {}

	self.m_qualityFilterComp:clearSelectedQuality()
	self.m_furnitureList:setNumItems(#self._allFurnitureIdArr)

	if #self._allFurnitureIdArr == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_furnitureList:transitionShowCells("listIconUiScaleIn", 0.03, 1)
	end

	self:_updateReturnResOnSellFurniture()
end

function RebornMainLayer:_updateReturnResOnSellFurniture()
	local var_38_0 = 0

	for iter_38_0, iter_38_1 in pairs(self._selectedTable) do
		if iter_38_1 then
			var_38_0 = var_38_0 + g.core.config.furniture_info.get(self._allFurnitureIdArr[iter_38_0]).sell
		end
	end

	self.m_decorativePointTxt:setText(var_38_0)
end

function RebornMainLayer:_onFurnitureListRenderer(arg_39_1, arg_39_2)
	arg_39_2:updateCell(self._allFurnitureIdArr[arg_39_1 + 1], self._selectedTable[arg_39_1 + 1])
end

function RebornMainLayer:_onFurnitureItemClick(arg_40_1)
	local var_40_0 = arg_40_1:getDataValue() + 1

	self._selectedTable[var_40_0] = not self._selectedTable[var_40_0]

	self:_updateReturnResOnSellFurniture()
	g.core.sound.SoundManager:playSound(var_0_2.SoundConst.Sound.CLICK_ENTER)
end

function RebornMainLayer:_onChangeFiltrateQualityType()
	local var_41_0 = self.m_qualityFilterComp:getSelectedQuality()

	self._selectedTable = {}

	if var_41_0 then
		for iter_41_0, iter_41_1 in ipairs(self._allFurnitureIdArr) do
			if g.core.config.furniture_info.get(iter_41_1).quality == var_41_0 then
				self._selectedTable[iter_41_0] = true
			end
		end

		if not next(self._selectedTable) then
			self.m_qualityFilterComp:clearSelectedQuality()
			var_0_5:tip(g.core.lang:get(103015))
		end
	else
		self.m_furnitureList:clearSelection()
	end

	self:_updateReturnResOnSellFurniture()
	self.m_furnitureList:setNumItems(#self._allFurnitureIdArr)
end

function RebornMainLayer:_getSelectedFurnitureIdArr()
	local var_42_0 = {}

	for iter_42_0, iter_42_1 in pairs(self._selectedTable) do
		if iter_42_1 then
			table.insert(var_42_0, self._allFurnitureIdArr[iter_42_0])
		end
	end

	return var_42_0
end

function RebornMainLayer:_sendSellFurnitureRequest(arg_43_1)
	g.core.network.GameNetProxy:send_C2S_Reborn_Execute({
		sys_type = RebornConst.TYPE_FURNITURE,
		op_type = RebornConst.OP_TYPE_DECOMPOSE,
		ids = arg_43_1
	})
end

function RebornMainLayer:_isIncludeSSRFurniture(arg_44_1)
	for iter_44_0, iter_44_1 in pairs(arg_44_1) do
		if g.core.config.furniture_info.get(iter_44_1).quality == var_0_2.QUALITY_TYPE.SSR then
			return true
		end
	end

	return false
end

function RebornMainLayer:refreshPetRebornShow()
	self._allRebornPetList = var_0_6:getPetRebornList()
	self._rebornSelectIndex = 0

	if #self._allRebornPetList == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_petList:setNumItems(#self._allRebornPetList)
		self.m_petList:transitionShowCells("enter_scaleOut", 0.03, 1)

		self._rebornSelectIndex = 0

		self.m_petList:setSelectedIndex(self._rebornSelectIndex)
		self:_updateRightView(self._allRebornPetList[self._rebornSelectIndex + 1], RebornConst.PET)
	end
end

function RebornMainLayer:_onPetListRenderer(arg_46_1, arg_46_2)
	arg_46_2:updateView(self._allRebornPetList[arg_46_1 + 1], true)
end

function RebornMainLayer:_onPetItemClick()
	g.core.sound.SoundManager:playSound(var_0_2.SoundConst.Sound.CLICK_ENTER)

	self._rebornSelectIndex = self.m_petList:getSelectedIndex()

	self:_updateRightView(self._allRebornPetList[self._rebornSelectIndex + 1], RebornConst.PET)
end

function RebornMainLayer:refreshCustomFragRebornShow()
	self._allCustomFragRebornList = var_0_6:getCustomFragRebornList()

	local var_48_0 = #self._allCustomFragRebornList

	if #self._allCustomFragRebornList == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
	end

	self.m_ableFragmentList:setNumItems(var_48_0)
	self.m_ableFragmentList:transitionShowCells("listIconUiScaleIn", 0.03, 1)
end

function RebornMainLayer:_onAbleFragRenderer(arg_49_1, arg_49_2)
	local var_49_0 = self._allCustomFragRebornList[arg_49_1 + 1]

	self._allCustomFragRebornList[arg_49_1 + 1].overrideClick = true

	arg_49_2:updateIcon(self._allCustomFragRebornList[arg_49_1 + 1])
	arg_49_2.getSharedTrans(arg_49_2, "listIconUiScaleIn", "ItemBagList", arg_49_2)

	local var_49_1 = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_ITEM,
		value = var_0_6:getCustomFragRebornId(self._allCustomFragRebornList[arg_49_1 + 1].value)
	})

	arg_49_2:setTouchFunc(function()
		g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.AbleFragmentConvertPop").new({
			state = 1,
			type = 7,
			goods1 = var_49_0,
			goods2 = var_49_1
		})))
	end)
end

return RebornMainLayer
