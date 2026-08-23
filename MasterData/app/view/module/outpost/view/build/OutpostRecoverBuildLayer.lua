local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostRecoverBuildLayer = class("OutpostRecoverBuildLayer", require("app.fairyGUI.outpost.UI_OutpostRecoverBuildLayer"), function()
	return fgui.GComponent:create({
		resName = "OutpostRecoverBuildLayer",
		pkgPath = "ui/outpost/outpost",
		isFullScreen = true,
		pkgName = "outpost"
	}, ...)
end)

function OutpostRecoverBuildLayer:ctor(arg_2_1)
	if arg_2_1.route1 then
		arg_2_1.type = arg_2_1.route1
	end

	self._showIdx = 0
	self._tickTimer = nil
	self._buildData = g.core.model.User.outpostData:getBuildData():getBuild(arg_2_1)
	self._consumptionItemList = self._buildData:getAllConsumptionItem()
	self._knightList = {}
	self._bgSpine = nil

	self:_initLayer()

	self._dragItemData = nil
	self._dragCompPos = nil

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 0.5)
end

function OutpostRecoverBuildLayer:_initLayer()
	self.m_knightList:setVirtual(self)
	self.m_knightList:setItemRenderer(handler(self, self._onKnightItemRender))
	self.m_costItemList:setVirtual(self)
	self.m_costItemList:doFairyBatching(false)
	self.m_costItemList:setItemRenderer(handler(self, self._onCostItemRender))
	self.m_consumptionItemList:setVirtual(self)
	self.m_consumptionItemList:doFairyBatching(false)
	self.m_consumptionItemList:setItemRenderer(handler(self, self._onConsumptionItemRender))
	self.m_consumptionItemList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickConsumptionItem))
	self.m_dailyBtn:addClickListener(handler(self, self._onDailyBtnClicked))
	self:_updateBg()

	local var_4_0 = g.core.common.Path:getIconByTypeValue(var_0_0.EXCHANGE_ITEM_TYPE, var_0_0.KNIGHT_COIN_ID)

	self.m_effectIcon1:setURL(var_4_0)
	self.m_effectIcon2:setURL(var_4_0)
	self.m_effectIcon3:setURL(var_4_0)
	self.m_topBarComp:setResInfoById(381)
end

function OutpostRecoverBuildLayer:_updateBg()
	local var_5_0 = self._buildData:getBuildType()

	if var_0_0.BuildType.Hospital == var_5_0 then
		self:addBg("bg/outpost/bg_hxsz_yiyuanbg.jpg", false, nil, 1)
		self.m_frontBgLoader:setURL("ui_cocos/outpost/buildOther/pic_hxsz_yiyuanzhuo.png")
	elseif var_0_0.BuildType.Restaurant == var_5_0 then
		self:addBg("bg/outpost/bg_hxsz_canguangbg.jpg", false, nil, 1)
		self.m_frontBgLoader:setURL("ui_cocos/outpost/buildOther/pic_hxsz_canguanzhuo.png")
	elseif var_0_0.BuildType.Hotel == var_5_0 then
		self:addBg("bg/outpost/bg_hxsz_lvdianbg.jpg", false, nil, 1)
		self.m_frontBgLoader:setURL("ui_cocos/outpost/buildOther/pic_hxsz_lvdianzhuo.png")
	elseif var_0_0.BuildType.Tavern == var_5_0 then
		self:addBg("bg/outpost/bg_hxsz_jiuguanbg.jpg", false, nil, 1)
		self.m_frontBgLoader:setURL("ui_cocos/outpost/buildOther/pic_hxsz_jiuguanzhuo.png")
	end

	self:_playBgAnim("normal", true)
end

function OutpostRecoverBuildLayer:_doTick()
	if #self._knightList < 1 then
		return
	end

	for iter_6_0, iter_6_1 in ipairs((self.m_knightList:getChildren())) do
		iter_6_1:doTickPro()
	end
end

function OutpostRecoverBuildLayer:_onKnightOut(arg_7_1, arg_7_2, arg_7_3)
	if arg_7_3.buildType == self._buildData:getBuildType() then
		local var_7_0 = false

		for iter_7_0, iter_7_1 in ipairs(self._knightList) do
			if iter_7_1.sid == arg_7_3.sid then
				var_7_0 = true

				break
			end
		end

		if var_7_0 then
			self:_updateKnightList()
		end
	end
end

function OutpostRecoverBuildLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_OUTPOST_KNIGHT_OUT_BUILD, handler(self, self._onKnightOut), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_LEVELUP, handler(self, self._onLevelUp), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_USE, handler(self, self._onS2COutpostBuildUse), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_ORDERPROCESS, handler(self, self._onS2COutpostBuildOrderProcess), self)
	self:_updateLayer()

	self._tickTimer = self._tickTimer or self:newSchedule(handler(self, self._doTick), 1)

	self:_onShowTipComp(self._showIdx)

	if not self._buildData:isHasConsumptionItem() and self._buildData:hasResItem() then
		self:showDragGuideTip()
	end
end

function OutpostRecoverBuildLayer:onUnload()
	self._tickTimer = nil

	local var_9_0 = fgui.DragDropManager:getInstance():getAgent()

	var_9_0:removeEventListener(fgui.UIEventType.DragEnd, g.core.const.ConstMgr.BASE_CONST.DRAG_TAG.OUTPOST_CONSUMPTION)
	var_9_0:removeEventListener(fgui.UIEventType.DragMove, g.core.const.ConstMgr.BASE_CONST.DRAG_TAG.OUTPOST_CONSUMPTION)
end

function OutpostRecoverBuildLayer:_updateLayer()
	self.m_infoComp:updateInfoComp(self._buildData)
	self.m_consumptionItemList:setNumItems(#self._consumptionItemList)
	self.m_costItemList:setNumItems(#self._consumptionItemList)
	self:_updateKnightList()
end

function OutpostRecoverBuildLayer:_updateKnightList()
	self._knightList = {}

	for iter_11_0, iter_11_1 in pairs((self._buildData:getInBuildKnight(true))) do
		if iter_11_1.time ~= -1 then
			self._knightList[#self._knightList + 1] = iter_11_1
		end
	end

	self.m_knightList:setNumItems(#self._knightList)
end

function OutpostRecoverBuildLayer:_onKnightItemRender(arg_12_1, arg_12_2)
	arg_12_2:updateKnightComp(self._knightList[arg_12_1 + 1])
end

function OutpostRecoverBuildLayer:_onCostItemRender(arg_13_1, arg_13_2)
	arg_13_2:updateItemComp(self._consumptionItemList[arg_13_1 + 1])

	local var_13_0 = arg_13_2:getCostData()[1]
	local var_13_1 = g.core.model.User.outpostData:getBagData():getOwnNum(var_13_0.value)

	if var_13_1 >= var_13_0.size and not arg_13_2:hasEventListener(fgui.UIEventType.DragStart) then
		arg_13_2:setDraggable(true)
		arg_13_2:addEventListener(fgui.UIEventType.DragStart, handler(self, self._onCostCompDragStart))
	elseif var_13_1 > 0 then
		arg_13_2:setDraggable(true)
	else
		arg_13_2:setDraggable(false)
	end
end

function OutpostRecoverBuildLayer:_onConsumptionItemRender(arg_14_1, arg_14_2)
	self._consumptionItemList[arg_14_1 + 1].itemInfo.size = self._buildData:getConsumptionNum(self._consumptionItemList[arg_14_1 + 1].itemInfo.value)

	arg_14_2:updateItemComp(self._consumptionItemList[arg_14_1 + 1], self._numChangeAnim)
end

function OutpostRecoverBuildLayer:_onClickConsumptionItem(arg_15_1)
	self._showIdx = arg_15_1:getDataValue()

	self:_onShowTipComp(self._showIdx)
end

function OutpostRecoverBuildLayer:_onShowTipComp(arg_16_1)
	local var_16_0 = self.m_consumptionItemList:getChildAt((self.m_consumptionItemList:itemIndexToChildIndex(arg_16_1)))
	local var_16_1 = self.m_tipsComp:getPosition()

	var_16_1.x = self.m_tipsComp:getParent():globalToLocal((var_16_0:localToGlobal(cc.p(var_16_0:getSize().width / 2, 0)))).x

	self.m_tipsComp:setPosition(var_16_1)

	local var_16_2, var_16_3 = self._buildData:getEffectBaseTimeAndTimeBonus()

	self.m_tipsComp:updateTipComp(self._consumptionItemList[arg_16_1 + 1], {
		effDes = self._buildData:getEffectDes(),
		baseTime = var_16_2,
		timeBonus = var_16_3,
		coinBonus = self._buildData:getCoinBonus()
	})
	self.m_tipsComp:setVisible(true)
end

function OutpostRecoverBuildLayer:_playBgAnim(arg_17_1, arg_17_2)
	self._anim = arg_17_1

	if not self._bgSpine then
		self._bgSpine = self.m_bgEffNode:addEffectSpine({
			remove = false,
			name = table.concat({
				"building_",
				self._buildData:getBuildType()
			}),
			isLoop = arg_17_2,
			anim = self._anim,
			eventHandler = handler(self, self._onBgEffectEnd)
		})
	else
		self._bgSpine:setAnimation(0, arg_17_1, arg_17_2)
	end
end

function OutpostRecoverBuildLayer:_onBgEffectEnd(arg_18_1)
	return
end

function OutpostRecoverBuildLayer:_onCostCompDragStart(arg_19_1)
	self._triggeredDropEvent = false

	arg_19_1:preventDefault()
	arg_19_1:stopPropagation()

	local var_19_0 = arg_19_1:getSender()
	local var_19_1 = fgui.DragDropManager:getInstance()

	var_19_1:startDrag(var_19_0:getResourceURL(), nil, (arg_19_1:getInput():getTouchId()))

	local var_19_2 = var_19_1:getAgent()
	local var_19_3 = var_19_2:getComponent()

	var_19_3:bindLua("app.view.module.outpost.view.build.comp.OutpostRecoverItemComp")

	local var_19_4 = var_19_0:getItemData()

	self._dragItemData = {
		costItemInfo = var_19_0:getCostData()[1],
		id = var_19_4.cfg.id
	}

	var_19_3:updateItemComp(var_19_4, true)
	var_19_2:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onCostCompDragEnd), g.core.const.ConstMgr.BASE_CONST.DRAG_TAG.OUTPOST_CONSUMPTION)
	var_19_2:addEventListener(fgui.UIEventType.DragMove, handler(self, self._onCostCompMove), g.core.const.ConstMgr.BASE_CONST.DRAG_TAG.OUTPOST_CONSUMPTION)
end

function OutpostRecoverBuildLayer:_onCostCompMove(arg_20_1)
	local var_20_0 = fgui.DragDropManager:getInstance():getAgent():getComponent()
	local var_20_1 = var_20_0:getSize()

	self._dragCompPos = var_20_0:localToGlobal(cc.p(var_20_1.width / 2, var_20_1.height / 2))
end

function OutpostRecoverBuildLayer:_onCostCompDragEnd(arg_21_1)
	if self.m_productHoldNode == nil then
		return
	end

	if self._dragCompPos then
		local var_21_0 = self.m_productHoldNode:getSize()
		local var_21_1 = self.m_productHoldNode:localToGlobal(cc.p(0, 0))
		local var_21_2 = self.m_productHoldNode:localToGlobal(cc.p(var_21_0.width, var_21_0.height))

		if cc.rectContainsPoint(cc.rect(var_21_1.x, var_21_1.y, var_21_2.x - var_21_1.x, var_21_2.y - var_21_1.y), self._dragCompPos) then
			self:_doCombineConsumptionItem(self._dragItemData)
		end
	end

	self._dragCompPos = nil
	self._dragItemData = nil
end

function OutpostRecoverBuildLayer:_doCombineConsumptionItem(arg_22_1)
	self._buildData:onEffect({
		orderInfo = {
			itemId = arg_22_1.id,
			num = g.core.model.User.outpostData:getBagData():getOwnNum(arg_22_1.costItemInfo.value)
		}
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_ItemMake)
end

function OutpostRecoverBuildLayer:receiveCompEvent(arg_23_1)
	local var_23_0 = ...

	if arg_23_1 == "buildLevelUp" then
		self:_doLevelUp()

		return true
	elseif arg_23_1 == "refreshKnight" then
		self:_updateKnightList()

		return true
	end
end

function OutpostRecoverBuildLayer:_doLevelUp()
	if not self._buildData:canLevelUp() then
		g.core.module.ModuleManager:tip(self._buildData:getLevelUpDes())

		return
	end

	g.core.network.GameNetProxy:send_C2S_Outpost_Build_LevelUp({
		build_tp = self._buildData:getBuildType()
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_BuildingUp_2)
end

function OutpostRecoverBuildLayer:_onDailyBtnClicked()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.outpost.view.build.OutpostBuildDailyReportPop").new(self._buildData), {
		touchDisappear = true,
		hideContinue = true
	})
end

function OutpostRecoverBuildLayer:_onS2COutpostBuildUse(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	if arg_26_4.build_tp ~= self._buildData:getBuildType() then
		return
	end

	self:_onCheckIn(arg_26_4.knight_id)
end

function OutpostRecoverBuildLayer:_onS2COutpostBuildOrderProcess(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0 = self._buildData:getBuildType()

	if arg_27_4.build_tp ~= var_27_0 then
		return
	end

	self.m_isShowProductController:setSelectedIndex(1)
	self:_playProductAnim(var_27_0)
	self:clearGuideTip()
end

function OutpostRecoverBuildLayer:_playProductAnim(arg_28_1)
	self.m_productTipComp:playShow(handler(self, self._onProductSuccess))

	local var_28_0 = ""

	if arg_28_1 == var_0_0.BuildType.Hospital then
		var_28_0 = "play_1"
	elseif arg_28_1 == var_0_0.BuildType.Hotel then
		var_28_0 = "play_2"
	elseif arg_28_1 == var_0_0.BuildType.Tavern then
		var_28_0 = "play_3"
	elseif arg_28_1 == var_0_0.BuildType.Restaurant then
		var_28_0 = "play_4"
	end

	self.m_productEffNode:addEffectSpine({
		name = "eff_ui_outpost_makelight",
		remove = false,
		isLoop = false,
		anim = var_28_0
	})
end

function OutpostRecoverBuildLayer:_onProductSuccess()
	self._numChangeAnim = true

	self:_updateLayer()

	self._numChangeAnim = false

	self.m_isShowProductController:setSelectedIndex(0)
end

function OutpostRecoverBuildLayer:_onLevelUp()
	self.m_infoComp:checkAndPlayNodeMatchEff(handler(self, self._onInfoCompLevelUpPlayEnd))
end

function OutpostRecoverBuildLayer:_onInfoCompLevelUpPlayEnd()
	self._consumptionItemList = self._buildData:getAllConsumptionItem()

	self:_updateLayer()
	self:_onShowTipComp(self._showIdx)
end

function OutpostRecoverBuildLayer:_onCheckIn(arg_32_1)
	self:_updateLayer()

	local var_32_0 = 0

	for iter_32_0, iter_32_1 in ipairs(self._knightList) do
		if arg_32_1 == iter_32_1.sid then
			var_32_0 = iter_32_0 - 1

			break
		end
	end

	local var_32_1 = self.m_knightList:getChildAt((self.m_knightList:itemIndexToChildIndex(var_32_0)))
	local var_32_2 = var_32_1:localToGlobal(cc.p(var_32_1:getSize().width / 2, self.m_effectIcon1:getSize().height / 2))
	local var_32_3 = {
		size = 1,
		type = var_0_0.EXCHANGE_ITEM_TYPE,
		value = var_0_0.KNIGHT_COIN_ID
	}

	self:newScheduleOnce(handler(self, function(arg_33_0)
		arg_33_0:playAwardFlyAnim(var_32_3, var_32_2, math.floor(math.random(5, 10)))
	end), 0.5)
end

function OutpostRecoverBuildLayer:playAwardFlyAnim(arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	if not arg_34_1 then
		return
	end

	local var_34_0 = arg_34_3 or 5
	local var_34_1 = g.core.common.Goods:convert(arg_34_1)
	local var_34_2 = arg_34_4 or self.m_topBarComp:getResComWorldPos(arg_34_1)

	if not var_34_2 then
		return
	end

	local var_34_3 = self.m_iconEffHolder:globalToLocal(var_34_2)

	self._flyIndex = 0
	self._iconPlay = nil
	self._flyAward = arg_34_1

	local var_34_4 = self.m_iconEffHolder:globalToLocal(arg_34_2)

	for iter_34_0 = 1, var_34_0 do
		local var_34_5 = fgui.UIPackage:createObject("outpost", "OutpostFlyAwardIcon")

		var_34_5:setIcon(var_34_1.icon)
		var_34_5:setPosition(var_34_4)
		self.m_iconEffHolder:addChild(var_34_5)

		local var_34_6 = math.random(35, 50) / 100
		local var_34_7 = math.random(35, 45) / 100
		local var_34_8 = {
			fgui.FSpawn:create(fgui.FSpawn:create(fgui.FEaseQuinticActionOut:create(fgui.FMoveBy:create(var_34_6, cc.p(math.random(-150, 150), math.random(-100, 100)))), fgui.FRotateBy:create(var_34_6 + 0.3, math.random(-45, 45))), (fgui.FSequence:create(fgui.FDelayTime:create(var_34_6 - math.random(5, 10) / 100), fgui.FSpawn:create(fgui.FMoveTo:create(var_34_7, var_34_3), fgui.FScaleTo:create(var_34_7, 0.5))))),
			fgui.FCallFunc:create(handler(self, self._onFlyAnimFinish)),
			fgui.FRemoveSelf:create()
		}
		local var_34_9 = {
			["3_120"] = {
				iconPlay = "play2",
				eff = "eff_ui_common_flyBoom2"
			},
			["3_121"] = {
				iconPlay = "play4",
				eff = "eff_ui_common_flyBoom4"
			},
			["3_122"] = {
				iconPlay = "play1",
				eff = "eff_ui_common_flyBoom1"
			},
			["3_123"] = {
				iconPlay = "play3",
				eff = "eff_ui_common_flyBoom3"
			},
			["3_124"] = {
				iconPlay = "play0",
				eff = "eff_ui_common_flyBoom0"
			}
		}

		if var_34_9[arg_34_1.type .. "_" .. arg_34_1.value] then
			self._iconPlay = var_34_9[arg_34_1.type .. "_" .. arg_34_1.value].iconPlay

			self.m_iconEffHolder:addEffectSpine({
				isLoop = false,
				remove = true,
				name = var_34_9[arg_34_1.type .. "_" .. arg_34_1.value].eff,
				x = var_34_4.x,
				y = -var_34_4.y
			}):setOpacity(128)
		end

		var_34_5:runFGAction(fgui.FSequence:create(var_34_8))
	end
end

function OutpostRecoverBuildLayer:showDragGuideTip()
	fgui.UIPackage:addPackage("ui/guide/guide")

	self._guideComp = fgui.UIPackage:createObject("guide", "GuideTouchComp")

	self._guideComp:setTouchable(false)
	self.m_guideHelper:addChild(self._guideComp)

	local var_35_0 = self.m_costItemList:getChildAt(0)
	local var_35_1 = var_35_0:getSize()
	local var_35_2 = self._guideComp:globalToLocal(self.m_productHoldNode:localToGlobal(cc.p(self.m_productHoldNode:getWidth() / 2, self.m_productHoldNode:getHeight() / 2)))

	self._guideComp:updateView(nil, {
		centerPos1 = self.m_guideHelper:globalToLocal(var_35_0:localToGlobal(cc.p(var_35_1.width / 2, var_35_1.height / 2))),
		centerPos = var_35_2
	}, true, false, true)
	self._guideComp:setPosition(var_35_2)
end

function OutpostRecoverBuildLayer:clearGuideTip()
	if self._guideComp and not tolua.isnull(self._guideComp) then
		self._guideComp:removeSelf()

		self._guideComp = nil
	end
end

function OutpostRecoverBuildLayer:_onFlyAnimFinish()
	self._flyIndex = self._flyIndex + 1

	if self._flyIndex == 1 then
		self.m_topBarComp:playIconEffect(self._flyAward, "eff_ui_common_flyGlow", self._iconPlay)
	end
end

return OutpostRecoverBuildLayer
