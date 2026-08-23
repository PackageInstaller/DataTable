local var_0_0 = g.core.config.pet_compose_advanced_info
local var_0_1 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_2 = g.core.model.User.petHandBookData
local var_0_3 = g.core.const.ConstMgr.PetHandBookConst
local PetHandBookMainLayer = class("PetHandBookMainLayer", require("app.fairyGUI.petHandBook.UI_PetHandBookMainLayer"), function()
	return fgui.GComponent:create({
		resName = "PetHandBookMainLayer",
		pkgName = "petHandBook",
		isFullScreen = true,
		pkgPath = "ui/petHandBook/petHandBook"
	})
end)

function PetHandBookMainLayer:ctor()
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_topBarComp:setResInfoById(189)

	self._allPetInfoDict = {}
	self._curQualitySelect = var_0_1.NONE
	self._curQualityGroup = {}
	self._groupStructList = {}

	self.m_selectBtn:addClickListener(handler(self, self._onShowSelectComp))
	self.m_touchLayer:addClickListener(handler(self, self._onHideSelectComp))
	self.m_processComp:addClickListener(handler(self, self._onAchievementBtnClick))
	self.m_previewBtn:addClickListener(handler(self, self._onClickPreviewBtn))
	self.m_oneKeyBtn:addClickListener(handler(self, self._onOneKeyBtnClick))
	self.m_tabSelController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabSelChanged))
	self:_initView()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.PET_HANDBOOK)
end

function PetHandBookMainLayer:_initView()
	self.m_bookList:setVirtual()
	self.m_bookList:doFairyBatching(false)
	self.m_bookList:setItemRenderer(handler(self, self._onBookRenderer))
	self.m_groupList:setVirtual()
	self.m_groupList:doFairyBatching(false)
	self.m_groupList:setItemRenderer(handler(self, self._onGroupRenderer))

	self._allPetInfoDict = var_0_2:getAllPetInfoDict()
	self._curQualityGroup = var_0_2:getQualityGroup(self._curQualitySelect)

	self.m_processComp:update()

	local var_3_0 = g.core.common.ModuleUnlock:isFunctionUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PET_UR_GROUP) and var_0_2:hasGroupPut()

	if var_3_0 then
		self._groupStructList = var_0_2:getGroupStructList()
	end

	self.m_urGroupTab:setVisible(var_3_0)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_urGroupTab
	})
end

function PetHandBookMainLayer:_updateView()
	self:_onTabSelChanged()
end

function PetHandBookMainLayer:_onTabSelChanged()
	if self.m_tabSelController:getSelectedIndex() == 0 then
		self:_updateBookList()
	else
		if g.core.common.ModuleUnlock:isFunctionUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PET_UR_GROUP) then
			g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.PET_UR_GROUP)
		end

		self:_updateGroupList()
	end

	self:_updateOneKeyGroup()
end

function PetHandBookMainLayer:_updateBookList()
	self._curQualityGroup = var_0_2:getQualityGroup(self._curQualitySelect)

	self.m_bookList:setNumItems(#self._curQualityGroup)
	self.m_bookList:transitionShowCells("enter_left", 0.1)
	self.m_processComp:update()
end

function PetHandBookMainLayer:_updateGroupList()
	self.m_activeNum:setText(var_0_2:getGroupActiveNum())
	self.m_groupList:setNumItems(#self._groupStructList)
	self.m_groupList:transitionShowCells("enter_left", 0.1)
end

function PetHandBookMainLayer:_updateOneKeyGroup()
	local var_8_0 = self.m_tabSelController:getSelectedIndex()
	local var_8_1 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HANDBOOK_ONEKEY_PET)

	if var_8_0 == 1 then
		var_8_1 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HANDBOOK_ONEKEY_PET_UR)
	end

	local var_8_2, var_8_3, var_8_4 = var_0_2:getAllCanActiveOrUpgradeHandBookList(var_8_0 == 1)
	local var_8_5 = #var_8_2 > 0

	self.m_oneKeyController:setSelectedIndex((var_8_1 and var_8_5 and #var_8_3 <= 0 or nil) and 1)

	if not self._oneKeyEffSpine then
		local var_8_7 = self.m_oneKeyBtn:getSize()

		self._oneKeyEffSpine = self.m_oneKeyBtn:addEffectSpine({
			name = "eff_ui_handbook_activatebtn",
			scale = 1,
			isLoop = true,
			x = var_8_7.width / 2,
			y = var_8_7.height / 2
		})
	end

	self._oneKeyEffSpine:setVisible(var_8_5)
end

function PetHandBookMainLayer:_onHandBookInfo(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self:_updateView()
end

function PetHandBookMainLayer:_onRcvActivate(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.petHandbook.view.PetHandBookLvUpPop").new({
		level = 0,
		showLvUpFeedBack = false,
		state = var_0_3.CELL_STATE.CAN_ACTIVATE,
		preId = var_0_2:getAdvanceIdById(arg_10_4.id),
		id = arg_10_4.id
	}), {
		touchDisappear = true
	})
	self:_updateView()
end

function PetHandBookMainLayer:_onRcvUpgrade(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = self._allPetInfoDict[var_0_2:getAdvanceIdById(arg_11_4.id)]

	g.core.module.ModuleManager:pushPopup(require("app.view.module.petHandbook.view.PetHandBookLvUpPop").new({
		showLvUpFeedBack = false,
		state = var_0_3.CELL_STATE.CAN_STAR_UP,
		level = var_11_0.level - 1,
		preId = arg_11_4.id,
		id = var_11_0.handBookId
	}), {
		touchDisappear = true
	})
	self:_updateView()
end

function PetHandBookMainLayer:_onRcvGroupActive(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	self:_onTabSelChanged()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.petHandbook.view.PetHandbookGroupUpgradePop").new({
		groupStruct = var_0_2:getGroupStructByGroup(var_0_0.get(arg_12_4.id).group),
		upgradeType = var_0_3.GROUP_UPGRADE_TYPE.ACTIVATE
	}), {
		touchDisappear = true
	})
end

function PetHandBookMainLayer:_onRcvGroupUpgrade(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.petHandbook.view.PetHandbookGroupUpgradePop").new({
		groupStruct = var_0_2:getGroupStructByGroup(var_0_0.get(arg_13_4.id).group),
		upgradeType = var_0_3.GROUP_UPGRADE_TYPE.UPGRADE,
		prevId = arg_13_4.id
	}), {
		touchDisappear = true
	})
	self:_onTabSelChanged()
end

function PetHandBookMainLayer:_onRcvURHandbookInfo()
	self:_onTabSelChanged()
end

function PetHandBookMainLayer:_onRcvOneKeyUpgrade(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	if arg_15_4.tp == g.core.network.proto.PET_HB then
		if arg_15_4.ids and #arg_15_4.ids > 0 then
			local var_15_0 = var_0_2:getAdvanceIdById(arg_15_4.ids[#arg_15_4.ids])

			g.core.module.ModuleManager:pushPopup(require("app.view.module.petHandbook.view.PetHandBookLvUpPop").new((self._allPetInfoDict[var_15_0].level > 0 or nil) and {
				showLvUpFeedBack = false,
				state = var_0_3.CELL_STATE.CAN_STAR_UP,
				level = self._allPetInfoDict[var_15_0].level - 1,
				preId = arg_15_4.ids[#arg_15_4.ids],
				id = self._allPetInfoDict[var_15_0].handBookId
			}), {
				touchDisappear = true
			})
		end

		self:_updateView()
	elseif arg_15_4.tp == g.core.network.proto.UR_PET_HB then
		self:_onTabSelChanged()

		if arg_15_4.ids and #arg_15_4.ids > 0 then
			local var_15_2 = var_0_2:getGroupStructByGroup(var_0_0.get(arg_15_4.ids[#arg_15_4.ids]).group)
			local var_15_3 = var_0_3.GROUP_UPGRADE_TYPE.ACTIVATE
			local var_15_4

			if var_15_2:getLevel() > 1 then
				var_15_3 = var_0_3.GROUP_UPGRADE_TYPE.UPGRADE
				var_15_4 = arg_15_4.ids[#arg_15_4.ids]
			end

			g.core.module.ModuleManager:pushPopup(require("app.view.module.petHandbook.view.PetHandbookGroupUpgradePop").new({
				groupStruct = var_15_2,
				upgradeType = var_15_3,
				prevId = var_15_4
			}), {
				touchDisappear = true
			})
		end
	end
end

function PetHandBookMainLayer:_onShowSelectComp()
	self.m_selectStateController:setSelectedIndex(1)
	self.m_pnlEnterTransition:play()
end

function PetHandBookMainLayer:_onHideSelectComp()
	self.m_selectStateController:setSelectedIndex(0)
	self.m_pnlEnterTransition:playReverse()
end

function PetHandBookMainLayer:_onAchievementBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.petHandbook.view.PetHandBookAchievementPop").new(), {
		touchDisappear = true
	})
end

function PetHandBookMainLayer:_onBookRenderer(arg_19_1, arg_19_2)
	arg_19_2:updateCell(self._curQualityGroup[arg_19_1 + 1])
end

function PetHandBookMainLayer:_onGroupRenderer(arg_20_1, arg_20_2)
	arg_20_2:updateGroupCell(self._groupStructList[arg_20_1 + 1])
end

function PetHandBookMainLayer:_onClickPreviewBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.petHandbook.view.PetHandbookGroupAttrPop").new(), {
		touchDisappear = true
	})
end

function PetHandBookMainLayer:_onOneKeyBtnClick()
	local var_22_0 = self.m_tabSelController:getSelectedIndex()
	local var_22_1 = g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.HANDBOOK_ONEKEY_PET)

	if not ((var_22_0 == 1 or nil) and g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.HANDBOOK_ONEKEY_PET_UR)) then
		return
	end

	local var_22_2, var_22_3, var_22_4 = var_0_2:getAllCanActiveOrUpgradeHandBookList(var_22_0 == 1)

	if #var_22_4 == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(205574))
	elseif var_22_0 == 0 then
		g.core.network.GameNetProxy:send_C2S_Handbook_OneKeyUpgrade({
			tp = g.core.network.proto.PET_HB,
			ids = var_22_4
		})
	elseif var_22_0 == 1 then
		g.core.network.GameNetProxy:send_C2S_Handbook_OneKeyUpgrade({
			tp = g.core.network.proto.UR_PET_HB,
			ids = var_22_4
		})
	end
end

function PetHandBookMainLayer:receiveCompEvent(arg_23_1, arg_23_2)
	if arg_23_1 == "HandBookConfirm_Click" then
		self:_onHideSelectComp()

		if self._curQualitySelect == arg_23_2.quality then
			return
		end

		self._curQualitySelect = arg_23_2.quality

		self:_updateView()
		self.m_bookList:scrollToView(0, true)
	end
end

function PetHandBookMainLayer:onEffPlayFinish()
	local var_24_0 = require("app.view.module.petHandbook.view.PetHandBookLvUpPop").new
	local var_24_1 = {
		preId = self._preId,
		curId = self._curId
	}

	var_24_1.showLvUpFeedBack = false

	g.core.module.ModuleManager:pushPopup(require("app.view.module.petHandbook.view.PetHandBookLvUpPop").new(var_24_1), {
		touchDisappear = true
	})
end

function PetHandBookMainLayer:onLoad()
	self.m_enterTransition:play()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PET_HANDBOOKINFO, handler(self, self._onHandBookInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PET_HANDBOOKACTIVATE, handler(self, self._onRcvActivate), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PET_HANDBOOKUPGRADE, handler(self, self._onRcvUpgrade), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PET_UR_HANDBOOKACTIVE, handler(self, self._onRcvGroupActive), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PET_UR_HANDBOOKUPGRADE, handler(self, self._onRcvGroupUpgrade), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_HANDBOOK_INFO, handler(self, self._onRcvURHandbookInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_HANDBOOK_ONEKEYUPGRADE, handler(self, self._onRcvOneKeyUpgrade), self)
	g.core.network.GameNetProxy:send_C2S_Pet_HandbookInfo({})

	if g.core.common.ModuleUnlock:isFunctionUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PET_UR_GROUP) then
		g.core.network.GameNetProxy:send_C2S_Handbook_Info({
			id = g.core.network.proto.UR_PET_HB
		})
	end
end

return PetHandBookMainLayer
