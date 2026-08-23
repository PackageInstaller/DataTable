local NewSlgPvcCityInfoComp = class("NewSlgPvcCityInfoComp", require("app.fairyGUI.newSlg.UI_NewSlgPvcCityInfoComp"))

function NewSlgPvcCityInfoComp:ctor()
	self._compBannerInfo = self:getChild("Comp_bannerInfo")
	self._btnShare = self:getChild("Btn_share")

	self._btnShare:addClickListener(handler(self, self._onClickBtnShare))

	self._compProg = self:getChild("Comp_prog")
	self._compTroop = self:getChild("Comp_troop")
	self._btnCheckDefenderInfo = self:getChild("Btn_checkDefenderInfo")

	self._btnCheckDefenderInfo:addClickListener(handler(self, self._onClickBtnCheckDefenderInfo))

	self._btnGather = self:getChild("Btn_gather")

	self._btnGather:addClickListener(handler(self, self._onClickBtnGather))

	self._btnAward = self:getChild("Btn_award")

	self._btnAward:addClickListener(handler(self, self._onClickBtnAward))

	self._btnRank = self:getChild("Btn_rank")

	self._btnRank:addClickListener(handler(self, self._onClickBtnRank))

	self._txtCityName = self:getChild("Txt_cityName")
	self._txtPos = self:getChild("Txt_pos")
	self._txtProg = self:getChild("Txt_prog")
	self._txtCityDesc = self:getChild("Txt_cityDesc")
	self._lvTxt = self:getChild("lvTxt")
	self._txtTroopNum = self:getChild("Txt_troopNum")
	self._isCaptureCtrl = self:getController("is_capture")
	self._isInfCtrl = self:getController("is_inf")
	self._isCanAttackCtrl = self:getController("isCanAttack")
	self._clickGatherTips = nil
end

function NewSlgPvcCityInfoComp:updateView(arg_2_1)
	if not arg_2_1.cityId then
		return
	end

	local var_2_0 = g.core.model.User.newSlgData

	self._cityId = arg_2_1.cityId

	local var_2_1 = var_2_0:getCityComponentById(arg_2_1.cityId)

	self._compCfg = var_2_1

	local var_2_2 = var_2_0:getCityInfoById(arg_2_1.cityId)

	self._cityCfg = var_2_2

	self._isInfCtrl:setSelectedIndex(var_2_0:isInfiniteCity(arg_2_1.cityId) and 1 or 0)
	self._txtPos:setText(g.core.lang:get(428986, {
		x = var_2_1.anchor_x,
		y = var_2_1.anchor_y
	}))
	self._txtCityName:setText(var_2_2.name)
	self._lvTxt:setText(g.core.lang:get(428987, {
		level = var_2_2.level
	}))

	local var_2_3 = var_2_0:isCityOccupied(arg_2_1.cityId)

	self._isCaptureCtrl:setSelectedIndex(var_2_3 and 1 or 0)
	self._compBannerInfo:updateView({
		bannerType = g.core.const.ConstMgr.NewSlgConst.SLGBannerType.CITY,
		res = g.core.common.Path:getNewSlgSiegeCity(var_2_2.res)
	})

	if var_2_3 then
		self._compProg:setMax(100)
		self._compProg:setValue(0)
		self._txtProg:setText(g.core.lang:get(428977, {
			num1 = 0,
			num2 = var_2_2.city_blood
		}))
	else
		self._compProg:setMax(100)
		self._compProg:setValue(100)
		self._txtProg:setText(g.core.lang:get(428977, {
			num1 = var_2_2.city_blood,
			num2 = var_2_2.city_blood
		}))
		self._compTroop:setCtrlState("type", {
			index = var_2_2.army_type
		})

		local var_2_4 = var_2_0:getCitySerData(arg_2_1.cityId)

		if var_2_4 then
			self._txtTroopNum:setText(var_2_4.defTroopNum)
		else
			self._txtTroopNum:setText(var_2_2.num)
		end

		if var_2_0:isInfiniteCity(self._cityId) then
			self._txtTroopNum:setText(g.core.lang:get(429013))
		end

		self:_updateLockInfo()
		self:_updateGatherBtn()
		self._btnCheckDefenderInfo:setVisible((g.core.model.User.allianceData:hasAlliance()))
	end

	self:getTransition("enter"):play()
end

function NewSlgPvcCityInfoComp:_updateLockInfo()
	local var_3_0 = g.core.model.User.newSlgData
	local var_3_1 = self._cityId
	local var_3_2, var_3_3 = g.core.model.User.newSlgData:isCityDayUnlock(self._cityId)

	if not var_3_2 then
		self._txtCityDesc:setText(g.core.lang:get(428869, {
			num = var_3_3
		}))

		return
	end

	if var_3_0:isChariotGatherTime() or var_3_0:isChariotMoveTime() then
		if var_3_1 ~= var_3_0:getNextAttackCityIds()[1] then
			local var_3_5 = {}

			var_3_5.time = g.core.model.User.newSlgData:getDailyGatherTimeStr()

			self._txtCityDesc:setText(g.core.lang:get(428868, var_3_5))

			return
		end

		if not var_3_0:isProvinceCanPass((var_3_0:getCityComponentById(var_3_1))) then
			self._txtCityDesc:setText(g.core.lang:get(428870))

			return
		end
	end

	if var_3_0:isNewSlgLastDay() then
		if not var_3_0:isLastCity(self._cityId) then
			self._txtCityDesc:setText(g.core.lang:get(428896))

			return
		elseif var_3_0:getNextAttackCityIds()[1] == 0 then
			self._txtCityDesc:setText(g.core.lang:get(428897))

			return
		end
	end

	self._txtCityDesc:setText("")
end

function NewSlgPvcCityInfoComp:_updateGatherBtn()
	self._canClick = false

	local var_4_0 = g.core.model.User.newSlgData

	self._isCanAttackCtrl:setSelectedIndex(0)

	if not g.core.model.User.allianceData:hasAlliance() then
		self._clickGatherTips = g.core.lang:get(428892)

		return
	end

	if not var_4_0:isCityDayUnlock(self._cityId) then
		self._clickGatherTips = g.core.lang:get(428871)

		return
	end

	if not (var_4_0:isChariotGatherTime() or var_4_0:isChariotMoveTime()) then
		self._clickGatherTips = g.core.lang:get(428872)

		return
	end

	if not var_4_0:isProvinceCanPass((var_4_0:getCityComponentById(self._cityId))) then
		self._clickGatherTips = g.core.lang:get(428873)

		self._isCanAttackCtrl:setSelectedIndex(0)

		return
	end

	local var_4_1 = var_4_0:getNextAttackCityIds()[1]

	if var_4_0:isNewSlgLastDay() then
		if not var_4_0:isLastCity(self._cityId) then
			self._clickGatherTips = g.core.lang:get(428896)

			return
		elseif var_4_1 == 0 then
			self._clickGatherTips = g.core.lang:get(428897)

			return
		end
	elseif var_4_1 > 0 and var_4_1 ~= self._cityId then
		self._clickGatherTips = g.core.lang:get(428874)

		return
	end

	if var_4_0:isChariotMoveTime() then
		self._clickGatherTips = g.core.lang:get(428898)

		return
	end

	self._canClick = true
	self._clickGatherTips = nil

	self._isCanAttackCtrl:setSelectedIndex(1)
end

function NewSlgPvcCityInfoComp:_onClickBtnShare()
	if not g.core.model.User.allianceData:hasAlliance() then
		g.core.module.ModuleManager:tip(g.core.lang:get(428891))

		return
	end

	local var_5_0 = g.core.model.User.newSlgData
	local var_5_1 = g.core.model.User.newSlgData.shareCityTime or 0
	local var_5_2 = g.core.common.ServerTime:getTime()

	if var_5_1 ~= 0 and var_5_2 - var_5_1 < 15 then
		g.core.module.ModuleManager:tip(g.core.lang:get(428903))

		return
	end

	var_5_0.shareCityTime = var_5_2

	g.core.network.GameNetProxy:send_C2S_BulletScreenSend({
		invite_id = 50,
		content = "",
		type = g.core.const.ConstMgr.ChatConst.ALLIANCE,
		share = {
			share_type = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_24
		},
		param1 = self._compCfg.anchor_x .. ";" .. self._compCfg.anchor_y .. ";" .. self._cityCfg.level .. ";" .. self._cityCfg.name
	})
	g.core.module.ModuleManager:tip(g.core.lang:get(429025))
end

function NewSlgPvcCityInfoComp:_onClickBtnCheckDefenderInfo()
	if not g.core.model.User.allianceData:hasAlliance() then
		g.core.module.ModuleManager:tip(g.core.lang:get(428892))
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_PVC_DEFENDER_POP, {
		type = g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.CITY,
		id = self._cityId
	})
end

function NewSlgPvcCityInfoComp:_onClickBtnGather()
	local var_7_0

	if not self._canClick then
		if self._clickGatherTips then
			g.core.module.ModuleManager:tip(self._clickGatherTips)
		end

		do return end

		var_7_0 = {
			buildType = g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.CITY
		}
	end

	var_7_0.info = g.core.model.User.newSlgData:getCityInfoById(self._cityId)
	var_7_0.x = self._compCfg.anchor_x
	var_7_0.y = self._compCfg.anchor_y
	var_7_0.key = math.random(1, 9999999999)

	self:dispatchCompEvent("NewSlg_City_Gather", var_7_0)
end

function NewSlgPvcCityInfoComp:_onClickBtnAward()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_RANK, {
		topTab = 2,
		rankType = g.core.const.ConstMgr.NewSlgConst.RANK_TYPE.PERSONAL_UNION,
		cityId = self._cityId
	})
end

function NewSlgPvcCityInfoComp:_onClickBtnRank()
	local var_9_0 = g.core.const.ConstMgr.NewSlgConst.RANK_TYPE.PERSONAL_UNION
	local var_9_1

	if g.core.model.User.newSlgData:isLastCity(self._cityId) then
		var_9_0 = g.core.const.ConstMgr.NewSlgConst.RANK_TYPE.FINAL_DRAGON
		var_9_1 = 2
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_RANK, {
		rankType = var_9_0,
		cityId = self._cityId,
		topTab = (g.core.model.User.newSlgData:isCityOccupied(self._cityId) or nil) and 1
	})
end

return NewSlgPvcCityInfoComp
