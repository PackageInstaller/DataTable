local RobTreasureFragMainLayer = class("RobTreasureFragMainLayer", require("app.fairyGUI.robTreasure.UI_RobTreasureFragMainLayer"), function()
	return fgui.GComponent:create({
		resName = "RobTreasureFragMainLayer",
		pkgName = "robTreasure",
		isFullScreen = true,
		pkgPath = "ui/robTreasure/robTreasure"
	}, ...)
end)
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.module.ModuleManager

function RobTreasureFragMainLayer:ctor(arg_2_1)
	self._treasureData = arg_2_1
	self._fragNum = arg_2_1.fragNum
	self._fragComp = nil
	self._selectedFrag = nil
	self._selectedFragIndex = nil
	self._isAutoUse = g.core.model.User.robTreasureData:getAutoUse()
	self._dropData = nil

	self:_addListener()
	self:_initView()
end

function RobTreasureFragMainLayer:_addListener()
	self.m_taskBtn:addClickListener(handler(self, self._onClickTask))
	self.m_shopBtn:addClickListener(handler(self, self._onClickShop))
	self.m_autoUseComp:addClickListener(handler(self, self._onClickAutoUse))
	self.m_composeBtn:addClickListener(handler(self, self._onClickCompose))
	self.m_oneKeyBtn:addClickListener(handler(self, self._onClickOneKey))
	self.m_exploreBtn1:addClickListener(handler(self, self._onClickExplore))
	self.m_exploreBtn2:addClickListener(handler(self, self._onClickExplore))
	self.m_treasureImg:addClickListener(handler(self, self._onClickImg))
end

function RobTreasureFragMainLayer:_onClickTask()
	var_0_2:pushPopup((require("app.view.module.robTreasure.view.RobTreasureTaskPop").new()))
end

function RobTreasureFragMainLayer:_onClickShop()
	var_0_2:pushModule(g.view.entrance.SHOP, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.BW
	})
end

function RobTreasureFragMainLayer:_onClickAutoUse()
	self._isAutoUse = self.m_autoUseComp:isSelected()

	g.core.model.User.robTreasureData:setAutoUse(self._isAutoUse)
end

function RobTreasureFragMainLayer:_onClickCompose()
	local var_7_0, var_7_1, var_7_2, var_7_3 = self:_getCurFragmentInfo()

	if not var_7_0 then
		var_0_2:tip(g.core.lang:get(304006))

		return
	end

	if var_7_1 > 1 then
		-- block empty
	else
		g.core.model.User.robTreasureData:recordComposeFlag()
		g.core.network.GameNetProxy:send_C2S_Fragment_Compose({
			num = 1,
			id = var_7_3
		})
	end
end

function RobTreasureFragMainLayer:_onClickOneKey()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.ROB_TREASURE_ONEKEY) then
		if g.core.model.User.resourceData:getRobNum() > 0 or self._isAutoUse and self.m_autoUseComp:getResNum() > 0 then
			self:sendOnekey()
		else
			require("app.view.base.infoPop.BasePlayNumPop").createPlayNum(var_0_1.ITEM.TYPE_ROB_TOKEN)
		end
	end
end

function RobTreasureFragMainLayer:sendOnekey()
	local var_9_0 = self._isAutoUse

	g.core.common.GlobalFunc.checkBagBeforeBattle(function()
		g.core.network.GameNetProxy:send_C2S_ExploreTreasure_Event_OneKey({
			id = self._treasureData.id,
			sweep = var_9_0
		})
	end)
end

function RobTreasureFragMainLayer:_onClickExplore()
	g.core.network.GameNetProxy:send_C2S_ExploreTreasure_Info({
		id = self._treasureData.id
	})
end

function RobTreasureFragMainLayer:_getCurFragmentInfo()
	local var_12_0 = 0
	local var_12_1 = g.core.config.treasure_info.get(self._treasureData.id)
	local var_12_2 = true
	local var_12_3 = -1

	for iter_12_0 = 1, 8 do
		if var_12_1["fragment_" .. iter_12_0] ~= 0 then
			local var_12_4 = g.core.model.User.bagData:getCountById(var_0_1.TYPE_FRAGMENT, var_12_1["fragment_" .. iter_12_0])

			if var_12_4 == 0 then
				var_12_2 = false
			end

			if var_12_3 == -1 then
				var_12_3 = var_12_4
				var_12_0 = var_12_1["fragment_" .. iter_12_0]
			end

			if var_12_4 < var_12_3 then
				var_12_3 = var_12_4
				var_12_0 = var_12_1["fragment_" .. iter_12_0]
			end
		end
	end

	return var_12_2, var_12_3, self._treasureData.id, var_12_0
end

function RobTreasureFragMainLayer:_size(arg_13_1)
	if self._selectedFrag == nil then
		return
	end

	if arg_13_1 > g.core.model.User.resourceData:getRobNum() then
		require("app.view.base.infoPop.BasePlayNumPop").createPlayNum(var_0_1.ITEM.TYPE_ROB_TOKEN)

		return
	end
end

function RobTreasureFragMainLayer:_initView()
	self:addBg("bg/robTreasure/bg_xinxihecheng.jpg")
	self.m_effectHolder:addEffectSpine({
		name = "eff_ui_transistor_audio",
		isLoop = true
	})
	self.m_topBar:setHelpId(g.core.const.ConstMgr.HelpConst.HELP_TYPE.ROB_TREASURE)
	self.m_treasureImg:setURL((g.core.common.Path:getTreasurePicById(self._treasureData.id)))

	self._isAutoUse = g.core.model.User.robTreasureData:getAutoUse()

	self.m_autoUseComp:setSelected(self._isAutoUse)
	self.m_fragNumComp:initStar({
		style = 2,
		gap = 0,
		index = 5,
		num = self._treasureData.fragHasNum,
		max = self._fragNum
	})

	self._fragComp = fgui.UIPackage:createObject("robTreasure", "RobTreasureFragComp" .. self._fragNum)

	self.m_fragComp:addChildWithListen(self._fragComp)
	self.m_autoUseComp:setResource({
		type = g.core.const.ConstMgr.BAG_TYPE.ITEM,
		value = var_0_1.ITEM.TYPE_ROB_TOKEN
	})

	self._isShowOneKey = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ROB_TREASURE_ONEKEY)
end

function RobTreasureFragMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CONTEND_TREASURE_GETLIST, handler(self, self._recvGetList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRAGMENT_COMPOSE, handler(self, self._freshViewAfterComPose), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CONTEND_TREASURE_FAST, handler(self, self._recvRob), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORE_TREASURE_EVENT_ONEKEY, handler(self, self._recvOneKeyRob), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OP_OBJECT, handler(self, self._onRcvResourceFlush), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORE_TREASURE_INFO, handler(self, self._onRcvExploreInfo), self)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
	self:_updateView()
end

function RobTreasureFragMainLayer:_freshViewAfterComPose(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	self.m_canComposeController:setSelectedIndex(2)

	self._composeNum = arg_16_4.num

	self:showEffect()
end

function RobTreasureFragMainLayer:_recvRob(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	self:_updateView()
	self:addPopup(require("app.view.module.robTreasure.view.RobTreasureSweepPop").new(arg_17_4))
end

function RobTreasureFragMainLayer:_recvOneKeyRob(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	g.core.network.GameNetProxy:send_C2S_GetModuleTaskInfo({
		module_id = g.core.const.ConstMgr.TaskConst.MODULE_ID.ROB
	})
	self:addPopup(require("app.view.module.robTreasure.view.RobTreasureOneKeyPop").new(arg_18_4))
	self:_updateView()
end

function RobTreasureFragMainLayer:_onRcvResourceFlush()
	self.m_autoUseComp:updateResNum()
end

function RobTreasureFragMainLayer:_onRcvExploreInfo(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	if arg_20_4.explore_treasure and arg_20_4.explore_treasure.explore_events then
		local ExploreStage = require("app.view.module.robTreasure.stage.ExploreStage")

		g.core.module.ModuleManager:pushModule({
			modType = g.view.entrance.FULL_SCREEN,
			create = function()
				return ExploreStage.new({
					treasure = self._treasureData,
					map = arg_20_4.explore_treasure.explore_events
				})
			end
		})
	end
end

function RobTreasureFragMainLayer:_updateView()
	g.core.network.GameNetProxy:send_C2S_GetModuleTaskInfo({
		module_id = g.core.const.ConstMgr.TaskConst.MODULE_ID.ROB
	})
	self:_updateTreasureInfo()

	if self._treasureData.compose == 1 then
		self.m_treasureImg:setColor(cc.c3b(255, 255, 255))
		self.m_canComposeController:setSelectedIndex(1)
	else
		self.m_treasureImg:setColor(cc.c3b(102, 102, 102))
		self.m_canComposeController:setSelectedIndex(0)
		self.m_isOneKeyController:setSelectedIndex(self._isShowOneKey and 1 or 0)
	end

	if self._selectedFrag and self._selectedFrag.num > 0 then
		self._selectedFragIndex = nil
	end

	self._fragComp:setFragmentInfo(self._treasureData.fragment)
	self.m_fragNumComp:setStarNum(self._treasureData.fragHasNum)
	self.m_autoUseComp:updateResNum()
	self.m_numComp:updateNum()

	if not self._treasureData.isHave then
		var_0_2:tip(g.core.lang:get(304011))
		self:newScheduleOnce(function()
			var_0_2:popComponent()
		end, 0.5)
	end
end

function RobTreasureFragMainLayer:_updateTreasureInfo()
	local var_24_0 = 0

	self._treasureData.isHave = false
	self._treasureData.compose = 1

	for iter_24_0, iter_24_1 in ipairs(self._treasureData.fragment) do
		local var_24_1 = iter_24_1.id
		local var_24_2 = g.core.model.User.bagData:getCountById(var_0_1.TYPE_FRAGMENT, iter_24_1.id)

		if var_24_2 > 0 then
			self._treasureData.isHave = true
			var_24_0 = var_24_0 + 1
		else
			self._treasureData.compose = 0
		end

		self._treasureData.fragment[iter_24_0] = {
			id = var_24_1,
			num = var_24_2
		}
	end

	self._treasureData.isHave = self._treasureData.isHave or self._treasureData.contendType == 2
	self._treasureData.fragHasNum = var_24_0
	self._selectedFrag = self._treasureData.fragment[self._selectedFragIndex]
end

function RobTreasureFragMainLayer:receiveCompEvent(arg_25_1)
	local var_25_0 = {
		...
	}

	if arg_25_1 == "RobTreasure_selectedTreasureFrag" and (not self._selectedFragIndex or self._selectedFragIndex ~= var_25_0[1]) then
		self._selectedFragIndex = var_25_0[1]
		self._selectedFrag = self._treasureData.fragment[self._selectedFragIndex]
	end
end

function RobTreasureFragMainLayer:showEffect()
	self._fragComp:showEffect()
	self.m_effectHolder:addEffectSpine({
		name = "eff_ui_transistor_fuse_02",
		scale = 1,
		isLoop = false
	})
	self.m_picEffectHolder:addEffectSpine({
		name = "eff_ui_transistor_fuse_03",
		scale = 1,
		isLoop = false,
		eventHandler = handler(self, self._onCompose)
	})
end

function RobTreasureFragMainLayer:_onCompose()
	require("app.view.module.show.ShowFactory"):awardSummary({
		(var_0_1:convert({
			type = var_0_1.TYPE_TREASURE,
			value = self._treasureData.id,
			size = self._composeNum
		}))
	}, false, nil, g.core.lang:get(300001), handler(self, self._updateView))
end

function RobTreasureFragMainLayer:_onClickImg()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.TreasureInfoPop").new({
		id = self._treasureData.id
	}), {
		hideContinue = true,
		touchDisappear = true
	})
end

return RobTreasureFragMainLayer
