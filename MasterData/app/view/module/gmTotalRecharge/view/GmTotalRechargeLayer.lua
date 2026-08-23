local GmTotalRechargeConst = require("app.view.module.gmTotalRecharge.const.GmTotalRechargeConst")
local var_0_2 = GmTotalRechargeConst.TabType
local DrawKnight = require("app.view.common.DrawKnight")
local var_0_4 = g.core.common.Path
local var_0_5 = g.core.common.Goods
local var_0_6 = g.core.common.ServerTime
local var_0_7 = g.core.model.User.gmTotalRechargeData
local GmTotalRechargeLayer = class("GmTotalRechargeLayer", require("app.fairyGUI.gmTotalRecharge.UI_GmTotalRechargeLayer"), function()
	return fgui.GComponent:create({
		resName = "GmTotalRechargeLayer",
		pkgPath = "ui/gmTotalRecharge/gmTotalRecharge",
		isFullScreen = true,
		pkgName = "gmTotalRecharge"
	}, ...)
end)

function GmTotalRechargeLayer:ctor()
	self._playListTrans = true
	self._selectedTabType = var_0_7:getTotalRechargeActType() == GmTotalRechargeConst.ActType.DRAW_CARD and var_0_2.TOTAL_DRAW_CARD or var_0_2.TOTAL_RECHARGE
	self._gmTotalRechargeInfoArr = var_0_7:getGmRechargeTotalInfoArr()
	self._taskInfoArr = var_0_7:getTaskInfoArr()
	self._skinAward = nil

	var_0_7:saveNewGmTotalRechargeActivity()
	self:_initView()
end

function GmTotalRechargeLayer:_initView()
	self.m_list:setVirtual()
	self.m_list:doFairyBatching(false)
	self.m_list:setItemRenderer(handler(self, self._onTotalReChargeItemRenderer))
	self.m_repeatBtn:addClickListener(handler(self, self._onClickRepeatBtn))
	self.m_lookSkinAreaComp:addClickListener(handler(self, self._onClickLookSkinAreaComp))
	self.m_tabTypeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabType))
	self.m_topBarComp:setTitle((var_0_7:getTopBarTitle()))

	local var_3_0 = var_0_7:getGmTotalRechargeGroupInfo()

	self.m_topBarComp:setResInfoById(var_3_0.top_bar)
	self:addBg((var_0_4:getGmTotalRechargeBg(var_3_0.bg)))
	self.m_effComp:removeAllEffect()

	if var_3_0.advance_id == 0 then
		self.m_bgLoader:setURL((var_0_4:getGmTotalRechargeKnightPic(var_3_0.res)))
	else
		local var_3_1 = DrawKnight.new({
			isShowBg = true,
			baseId = var_3_0.advance_id
		})

		self.m_knightPic:removeChildren()
		self.m_knightPic:addChild(var_3_1)
		var_3_1:setX(var_3_0.pos_x)
		var_3_1:setY(var_3_0.pos_y)
	end

	self.m_titleLoader:setURL("ui://text_new/" .. var_3_0.txt_res)

	local var_3_2 = var_0_5:convert({
		type = var_3_0.type,
		value = var_3_0.value
	})

	if var_3_2 then
		self._skinAward = var_3_2

		self.m_qualityLoader:setURL(var_0_4:getQualityArtTxtURL(var_3_2.quality))
		self.m_smallQualityLoader:setURL(var_0_4:getUserIconQualityStarBg(var_3_2.quality))
		self.m_skinNameTxt:setText(var_3_2.name)
		self.m_knightNameTxt:setText(g.core.config.knight_info.get(g.core.config.skin_info.fetch(var_3_0.value).knight_advance_id).name .. g.core.lang:get(404505))
		self.m_picLoader:setURL(g.core.common.Path:getKnightBookPicRes(var_3_0.value))
		self.m_skinGroup:setVisible(true)
	else
		self.m_skinGroup:setVisible(false)
	end

	self.m_enterTransition:play()
end

function GmTotalRechargeLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETGMTOTALRECHARGEAWARD, self._onS2CGmTotalRechargeGetAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETGMTOTALRECHARGETASKAWARD, self._onS2CGmTotalRechargeGetAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETGMTOTALRECHARGETASKDATA, self._onS2CGetGmTotalRechargeTaskData, self)
	self.m_timeTxt:setText(var_0_6:getLeftDHFormat((var_0_7:getGmTotalRechargeEndTime())))

	self._scheduleHandler = self:newSchedule(handler(self, self._onCD), 3)

	local var_4_0 = var_0_7:getTotalRechargeActType()

	if var_4_0 == GmTotalRechargeConst.ActType.RECHARGE_AND_DRAW_CARD then
		self.m_showTabController:setSelectedIndex(1)
		self.m_tabTypeController:setSelectedIndex(self._selectedTabType)
		g.core.network.GameNetProxy:send_C2S_Recharge_GetGMTotalRechargeTaskData({})
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_rechargeTaskBtn
		})
	elseif var_4_0 == GmTotalRechargeConst.ActType.DRAW_CARD then
		self.m_showTabController:setSelectedIndex(0)
		g.core.network.GameNetProxy:send_C2S_Recharge_GetGMTotalRechargeTaskData({})
	else
		self.m_showTabController:setSelectedIndex(0)
	end

	self:_updateListView()
end

function GmTotalRechargeLayer:_onCD()
	self.m_timeTxt:setText(var_0_6:getLeftDHFormat((var_0_7:getGmTotalRechargeEndTime())))

	if var_0_7:getGmTotalRechargeEndTime() < var_0_6:getTime() then
		if self._scheduleHandler then
			self:cancelSchedule(self._scheduleHandler)

			self._scheduleHandler = nil
		end

		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function GmTotalRechargeLayer:_updateListView()
	local var_6_0 = 0

	if self._selectedTabType == var_0_2.TOTAL_RECHARGE then
		var_6_0 = #self._gmTotalRechargeInfoArr

		table.sort(self._gmTotalRechargeInfoArr, var_0_7:getSortFunc())
	else
		var_6_0 = #self._taskInfoArr

		table.sort(self._taskInfoArr, var_0_7:getSortFunc())
	end

	self.m_list:setNumItems(var_6_0)

	if var_6_0 > 0 and self._playListTrans then
		self._playListTrans = false

		self.m_list:transitionShowCells("enter_right", 0.03)
	end
end

function GmTotalRechargeLayer:_onTotalReChargeItemRenderer(arg_7_1, arg_7_2)
	if self._selectedTabType == var_0_2.TOTAL_DRAW_CARD then
		arg_7_2:updateCell(var_0_2.TOTAL_DRAW_CARD, self._taskInfoArr[arg_7_1 + 1])
	else
		arg_7_2:updateCell(var_0_2.TOTAL_RECHARGE, self._gmTotalRechargeInfoArr[arg_7_1 + 1])
	end
end

function GmTotalRechargeLayer:_onS2CGetGmTotalRechargeTaskData()
	if self._selectedTabType == var_0_2.TOTAL_DRAW_CARD then
		self:_updateListView()
	end
end

function GmTotalRechargeLayer:_onS2CGmTotalRechargeGetAward(arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3.awards then
		g.core.module.ModuleManager:awardSummary(arg_9_3.awards)
	end

	self:_updateListView()
end

function GmTotalRechargeLayer:_onClickRepeatBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.gmTotalRecharge.view.GmTotalRechargeTurnPop").new()))
end

function GmTotalRechargeLayer:_onClickLookSkinAreaComp()
	if self._skinAward then
		g.core.common.GlobalFunc.pushInfoPop(self._skinAward)
	end
end

function GmTotalRechargeLayer:_onChangeTabType()
	self._selectedTabType = self.m_tabTypeController:getSelectedIndex()
	self._playListTrans = true

	self:_updateListView()
end

function GmTotalRechargeLayer:onUnload()
	if self._scheduleHandler then
		self:cancelSchedule(self._scheduleHandler)

		self._scheduleHandler = nil
	end
end

return GmTotalRechargeLayer
