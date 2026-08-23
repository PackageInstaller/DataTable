local NewSlgFarmInfoTopComp = class("NewSlgFarmInfoTopComp")

function NewSlgFarmInfoTopComp:ctor()
	self._compBannerInfo = self:getChild("Comp_bannerInfo")
	self.m_posTxt = self:getChild("posTxt")
	self._compBelongName = self:getChild("Comp_belongName")
	self._btnShare = self:getChild("Btn_share")

	self._btnShare:addClickListener(handler(self, self._onClickBtnShare))

	self._compTroop = self:getChild("Comp_troop")
	self._txtName = self:getChild("Txt_name")
	self._txtBelongCity = self:getChild("Txt_belongCity")
	self._txtTime = self:getChild("Txt_time")
	self._showTimeCtrl = self:getController("show_time")
	self._lvTxt = self:getChild("Txt_Lv")
	self._armyTxt = self:getChild("Txt_army")
	self._authTxt = self:getChild("Txt_rule")
	self._armyShow = self:getChild("armyShow")
end

function NewSlgFarmInfoTopComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETFARMDEFINFO, handler(self, self.onGetFarmTeamInfo), self)
end

function NewSlgFarmInfoTopComp:updateView(arg_3_1)
	if not arg_3_1 then
		return
	end

	self._farmId = arg_3_1.farmId
	self._info = g.core.model.User.newSlgData:getFarmInfoById(self._farmId)
	self._data = g.core.model.User.newSlgData:getFarmDataById(self._farmId)

	self._txtName:setText(self._info.name)
	self._compBannerInfo:updateView({
		bannerType = 5,
		res = g.core.common.Path:getNewSlgFarm(self._info.res)
	})
	self._lvTxt:setText("Lv." .. self._info.level)
	self._txtBelongCity:setText(g.core.model.User.newSlgData:getCityInfoById(self._info.belong).name)

	if self._data.userId > 0 then
		local var_3_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._data.userId)

		if var_3_0 then
			self._compBelongName:setText(var_3_0.name)
		end
	else
		self._compBelongName:setText(g.core.lang:get(429679))
	end

	self._compTroop:updateView({
		armyType = self._info.army_type
	})

	local var_3_1 = g.core.model.User.newSlgData:getFarmComponentById(self._info.id)

	self.m_posTxt:setText(g.core.lang:get(428957, {
		x = var_3_1.anchor_x,
		y = var_3_1.anchor_y
	}))
	self:updateTime()
	self._armyShow:setVisible(false)
	g.core.network.GameNetProxy:send_C2S_NewSlg_GetFarmDefInfo({
		farm_id = self._farmId
	})
end

function NewSlgFarmInfoTopComp:onGetFarmTeamInfo(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self._defTeams = arg_4_4.def_data.def_teams or {}
	self._farmTeams = arg_4_4.def_data.farm_teams or {}

	local var_4_0 = 0
	local var_4_1 = 0

	for iter_4_0, iter_4_1 in ipairs(self._defTeams) do
		var_4_0 = var_4_0 + iter_4_1.authority
		var_4_1 = var_4_1 + iter_4_1.troops
	end

	for iter_4_2, iter_4_3 in ipairs(self._farmTeams) do
		var_4_0 = var_4_0 + iter_4_3.authority
		var_4_1 = var_4_1 + iter_4_3.troops
	end

	if self._defTeams[1] and self._defTeams[1].troop_type then
		self._compTroop:updateView({
			armyType = self._defTeams[1].troop_type
		})
	end

	if not self._defTeams[1] then
		self._defTeams = arg_4_4.def_data.robot_teams or {}

		for iter_4_4, iter_4_5 in ipairs(self._defTeams) do
			var_4_0 = var_4_0 + iter_4_5.authority
			var_4_1 = var_4_1 + iter_4_5.troops
		end
	end

	if self._defTeams[1].uid then
		var_4_0 = 0

		for iter_4_6, iter_4_7 in ipairs(self._defTeams) do
			var_4_0 = var_4_0 + iter_4_7.authority
		end

		var_4_0 = math.floor(var_4_0 * (100 - g.core.model.User.newSlgData:getAuthorityDecreaseNum(self._info.belong, self._defTeams[1].uid)) / 100)
	end

	self._armyTxt:setText(var_4_1)
	self._authTxt:setText(var_4_0)
	self._armyShow:setVisible(true)
end

function NewSlgFarmInfoTopComp:updateTime()
	if self._data then
		local var_5_0, var_5_1 = g.core.model.User.newSlgData:isProtecting(self._data)

		if var_5_0 then
			self._showTimeCtrl:setSelectedIndex(1)
			self._txtTime:setText(g.core.lang:get(429680, {
				time = g.core.common.ServerTime:secondToMSString(var_5_1)
			}))
		else
			self._showTimeCtrl:setSelectedIndex(0)
		end
	end
end

function NewSlgFarmInfoTopComp:_onClickBtnShare()
	if not g.core.model.User.allianceData:hasAlliance() then
		g.core.module.ModuleManager:tip(g.core.lang:get(428891))

		return
	end

	local var_6_0 = g.core.model.User.newSlgData
	local var_6_1 = g.core.model.User.newSlgData.shareFarmTime or 0
	local var_6_2 = g.core.common.ServerTime:getTime()

	if var_6_1 ~= 0 and var_6_2 - var_6_1 < g.core.model.User.newSlgData:getNewSlgParamsValueById(188) then
		g.core.module.ModuleManager:tip(g.core.lang:get(429682))

		return
	end

	local var_6_3 = g.core.model.User.newSlgData:getFarmComponentById(self._info.id)

	var_6_0.shareFarmTime = var_6_2

	g.core.network.GameNetProxy:send_C2S_BulletScreenSend({
		invite_id = 50,
		content = "",
		type = g.core.const.ConstMgr.ChatConst.ALLIANCE,
		share = {
			share_type = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_24
		},
		param1 = var_6_3.anchor_x .. ";" .. var_6_3.anchor_y .. ";" .. self._info.level .. ";" .. self._info.name
	})
	g.core.module.ModuleManager:tip(g.core.lang:get(429025))
end

return NewSlgFarmInfoTopComp
