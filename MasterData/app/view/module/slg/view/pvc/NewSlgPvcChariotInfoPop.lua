local var_0_0 = g.core.model.User.newSlgData
local var_0_1 = {
	[232] = true,
	[202] = true,
	[225] = true,
	[239] = true,
	[221] = true,
	[244] = true,
	[201] = true,
	[242] = true,
	[203] = true
}
local NewSlgPvcChariotInfoPop = class("NewSlgPvcChariotInfoPop", require("app.fairyGUI.newSlg.UI_NewSlgPvcChariotInfoPop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgPvcChariotInfoPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgPvcChariotInfoPop:ctor(arg_2_1)
	self:showAtCenter()

	self._objectData = arg_2_1.object
	self._btnGather = self:getChild("Btn_gather")

	self._btnGather:addClickListener(handler(self, self._onClickBtnGather))

	self._txtAuthority = self:getChild("Txt_authority")
	self._titleTxt = self:getChild("titleTxt")
	self._listTeam = self:getChild("List_team")

	self._listTeam:setVirtual(self)
	self._listTeam:setItemRenderer(handler(self, self._onRenderListTeamCell))

	self._gatherStateCtrl = self:getController("gather_state")
	self._isEmptyCtrl = self:getController("is_empty")
	self._teamArr = {}
	self._userMap = {}

	self.m_closeBtn:setClickCallBack(handler(self, self.onClose))
	self.m_closeGraph:addClickListener(handler(self, self.onClose))

	self._isSpecialId = var_0_1[self._objectData.value]

	self.m_isMulAlliController:setSelectedIndex(self._isSpecialId and 1 or 0)
end

function NewSlgPvcChariotInfoPop:onLoad()
	self.m_enterTransition:play()

	if not self._objectData then
		g.core.module.ModuleManager:popComponent()

		return
	end

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETCITYGATHER, handler(self, self._onRcvNewSlgGetCityGather), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SYNCUSERTEAM, handler(self, self._onRcvTeamRefresh), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_CITYMARCHNTF, handler(self, self._onRcvTeamRefresh), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self.updateUserSnap, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETSNAPSHOT, self._updateView, self)
	g.core.network.GameNetProxy:send_C2S_NewSlg_GetCityGather({
		city_id = self._objectData.value,
		car_id = self._objectData.id
	})
end

function NewSlgPvcChariotInfoPop:onClose()
	if self._isClose then
		return
	end

	self._isClose = true

	self.m_backTransition:play(handler(self, self.onCloseFinish))
end

function NewSlgPvcChariotInfoPop:onCloseFinish()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function NewSlgPvcChariotInfoPop:_updateView()
	self._cityCfg = var_0_0:getCityInfoById(self._objectData.value)

	local var_6_0, var_6_1 = var_0_0:getCitySerData(self._objectData.value)

	self._cityElementInfo = var_6_1

	self._titleTxt:setText(g.core.lang:get(428876, {
		num1 = #self._teamArr,
		num2 = var_0_0:getChariotGatherMaxNum(self._objectData.value, self._objectData.value2)
	}))

	local var_6_2 = var_0_0:getChariotBelongAlliance(self._objectData.value, self._objectData.value2)

	if var_6_2 then
		local var_6_3 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.ALLIANCE, var_6_2)

		if var_6_3 then
			self.m_allianceNameTxt:setText(var_6_3.name)
		end
	end

	local var_6_4 = 0

	for iter_6_0, iter_6_1 in ipairs(self._teamArr) do
		var_6_4 = var_6_4 + iter_6_1.authority
	end

	self._txtAuthority:setText(var_6_4)
	self:_updateGatherStatus()

	if self._cityElementInfo then
		self.m_elemIcon:setURL((g.core.common.Path:getKnightElementIcon(self._cityElementInfo.element, "ui://newSlg_mapUI/")))
		self.m_elemTipTypeIcon:setURL(table.concat({
			"ui://newSlg_mapUI/pic_hzts_ysjt",
			self._cityElementInfo.type
		}))
		self.m_hasElemController:setSelectedIndex(1)
	else
		self.m_hasElemController:setSelectedIndex(0)
	end

	local var_6_5 = #self._teamArr

	self._isEmptyCtrl:setSelectedIndex(#self._teamArr == 0 and 1 or 0)
	self._listTeam:setNumItems(var_6_5)
end

function NewSlgPvcChariotInfoPop:_updateGatherStatus()
	local var_7_0 = 0
	local var_7_1 = var_0_0:getChariotBelongAlliance(self._objectData.value, self._objectData.value2)

	if var_7_1 and var_7_1 == g.core.model.User.allianceData:getAllianceId() then
		local var_7_2 = false

		for iter_7_0, iter_7_1 in ipairs(self._teamArr) do
			if iter_7_1.uid == g.core.model.User:getId() then
				var_7_2 = true
			end
		end

		if var_0_0:getChariotGatherMaxNum(self._objectData.value, self._objectData.value2) <= var_0_0:getSelfGatherNum(self._objectData.value) then
			var_7_0 = 3
		elseif var_7_2 then
			var_7_0 = 2
		end

		if var_7_0 == 0 and var_0_0:getTeamMoveToChariot(self._objectData.value) then
			var_7_0 = 1
		end
	else
		var_7_0 = 4
	end

	self._gatherStateCtrl:setSelectedIndex(var_7_0)
end

function NewSlgPvcChariotInfoPop:_onClickBtnGather()
	local var_8_0 = g.core.model.User.newSlgData:getCityComponentById(self._cityCfg.id)

	self:dispatchCompEvent("NewSlg_City_Gather", {
		gatherTp = 0,
		buildType = g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.CITY,
		info = self._cityCfg,
		x = var_8_0.anchor_x,
		y = var_8_0.anchor_y
	})
end

function NewSlgPvcChariotInfoPop:_onRenderListTeamCell(arg_9_1, arg_9_2)
	arg_9_2:updateCell(self._teamArr[arg_9_1 + 1], self._userMap[self._teamArr[arg_9_1 + 1].uid], self._isSpecialId, self._cityElementInfo)
end

function NewSlgPvcChariotInfoPop:_onRcvNewSlgGetCityGather(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self._teamArr = arg_10_4.teams or {}
	self._userMap = {}

	for iter_10_0, iter_10_1 in ipairs(self._teamArr) do
		local var_10_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, iter_10_1.uid)

		if var_10_0 then
			self._userMap[iter_10_1.uid] = var_10_0
		end
	end

	self:_updateView()
end

function NewSlgPvcChariotInfoPop:updateUserSnap()
	self._userMap = {}

	for iter_11_0, iter_11_1 in ipairs(self._teamArr) do
		local var_11_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, iter_11_1.uid)

		if var_11_0 then
			self._userMap[iter_11_1.uid] = var_11_0
		end
	end

	self:_updateView()
end

function NewSlgPvcChariotInfoPop:_onRcvTeamRefresh()
	self:_updateGatherStatus()
end

return NewSlgPvcChariotInfoPop
