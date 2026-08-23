local NewSlgS2CityInfoTopComp = class("NewSlgS2CityInfoTopComp", require("app.fairyGUI.newSlg.UI_NewSlgS2CityInfoTopComp"))
local var_0_1 = g.core.model.User.newSlgData
local var_0_2 = g.core.const.ConstMgr.NewSlgConst

function NewSlgS2CityInfoTopComp:ctor()
	self._snapshot = nil
	self._allianceId = 0

	self.m_Btn_share:addClickListener(handler(self, self._onClickBtnShare))

	self._txtProg = self:getChild("Txt_prog")
end

function NewSlgS2CityInfoTopComp:updateView(arg_2_1)
	if not arg_2_1.cityId then
		return
	end

	self._cityId = arg_2_1.cityId

	local var_2_0 = var_0_1:getCityComponentById(arg_2_1.cityId)

	self._compCfg = var_2_0

	local var_2_1 = var_0_1:getCityInfoById(arg_2_1.cityId)
	local var_2_2, var_2_3 = var_0_1:getCitySerData(arg_2_1.cityId)

	self._cityCfg = var_2_1

	self.m_Txt_pos:setText(g.core.lang:get(428986, {
		x = var_2_0.anchor_x,
		y = var_2_0.anchor_y
	}))
	self.m_Txt_cityName:setText(var_2_1.name)
	self.m_lvTxt:setText(g.core.lang:get(428987, {
		level = var_2_1.level
	}))
	self.m_Comp_bannerInfo:updateView({
		bannerType = var_0_2.SLGBannerType.CITY,
		res = g.core.common.Path:getNewSlgSiegeCity(var_2_1.res)
	})
	self.m_occupyScore:setText(g.core.lang:get(429801, {
		score = var_2_1.occupy_point
	}))
	self.m_firstScore:setText(g.core.lang:get(429802, {
		score = var_2_1.capture_points
	}))

	self._allianceId = var_0_1:getCityOccupyAlliance(arg_2_1.cityId) or 0

	self.m_is_occupiedController:setSelectedIndex(0)

	if self._allianceId > 0 then
		self.m_isOtherController:setSelectedIndex(self._allianceId == g.core.model.User.allianceData:getAllianceId() and 0 or 1)
		self._txtProg:setText(g.core.lang:get(428977, {
			num1 = 0,
			num2 = var_2_1.city_blood
		}))
		self.m_Comp_prog:setMax(100)
		self.m_Comp_prog:setValue(0)
		self:_updateAlliance()
	else
		self.m_Comp_prog:setMax(100)
		self.m_Comp_prog:setValue(100)
		self._txtProg:setText(g.core.lang:get(428977, {
			num1 = var_2_1.city_blood,
			num2 = var_2_1.city_blood
		}))
	end

	if var_2_3 then
		self.m_elemIcon:setURL((g.core.common.Path:getKnightElementIcon(var_2_3.element, "ui://newSlg_mapUI/")))
		self.m_elemTipTypeIcon:setURL(table.concat({
			"ui://newSlg_mapUI/pic_hzts_ysjt",
			var_2_3.type
		}))
		self.m_showElemController:setSelectedIndex(1)

		local var_2_4 = g.core.lang:get(429770 + var_2_3.element)
		local var_2_5 = ""

		if var_2_3.type == 1 then
			var_2_5 = g.core.lang:get(429769)
		elseif var_2_3.type == 2 then
			var_2_5 = g.core.lang:get(429770)
		end

		self.m_elemDesTxt:setText(g.core.lang:get(429768, {
			teamType = var_2_4,
			effectType = var_2_5
		}))
		self.m_elemTypeController:setSelectedIndex(var_2_3.type)
	else
		self.m_showElemController:setSelectedIndex(0)
		self.m_elemTypeController:setSelectedIndex(0)
	end
end

function NewSlgS2CityInfoTopComp:_onClickBtnShare()
	if not g.core.model.User.allianceData:hasAlliance() then
		g.core.module.ModuleManager:tip(g.core.lang:get(428891))

		return
	end

	local var_3_0 = var_0_1.shareCityTime or 0
	local var_3_1 = g.core.common.ServerTime:getTime()

	if var_3_0 ~= 0 and var_3_1 - var_3_0 < 15 then
		g.core.module.ModuleManager:tip(g.core.lang:get(428903))

		return
	end

	var_0_1.shareCityTime = var_3_1

	g.core.network.GameNetProxy:send_C2S_BulletScreenSend({
		content = "",
		invite_id = 50,
		type = g.core.const.ConstMgr.ChatConst.ALLIANCE,
		share = {
			share_type = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_24
		},
		param1 = self._compCfg.anchor_x .. ";" .. self._compCfg.anchor_y .. ";" .. self._cityCfg.level .. ";" .. self._cityCfg.name
	})
	g.core.module.ModuleManager:tip(g.core.lang:get(429025))
end

function NewSlgS2CityInfoTopComp:_updateAlliance()
	self._snapshot = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.ALLIANCE, self._allianceId)

	if self._snapshot then
		self.m_is_occupiedController:setSelectedIndex(1)
		self.m_Txt_alliance:setText(g.core.lang:get(429617, {
			alliance = self._snapshot.name
		}))
	end
end

function NewSlgS2CityInfoTopComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETSNAPSHOT, handler(self, self._updateAlliance), self)
end

return NewSlgS2CityInfoTopComp
