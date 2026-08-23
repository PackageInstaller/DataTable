local NewSlgS2CityViewComp = class("NewSlgS2CityViewComp", require("app.fairyGUI.newSlg.UI_NewSlgS2CityViewComp"))
local var_0_1 = g.core.model.User.newSlgData

function NewSlgS2CityViewComp:ctor()
	self._cityComponent = nil
	self._cityInfo = nil
	self._compPlace = self:getChild("Comp_place")

	self.m_shareBtn:addClickListener(handler(self, self._onClickBtnShare))
end

function NewSlgS2CityViewComp:updateView(arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0 = arg_2_1.cityId

	self._cityInfo = var_0_1:getCityInfoById(arg_2_1.cityId)

	local var_2_1 = var_0_1:getBuildInfoById(arg_2_1.buildId)

	self.m_Txt_name:setText(self._cityInfo.name)
	self.m_lvTxt:setText(g.core.lang:get(2052, {
		level = self._cityInfo.level
	}))

	self._cityComponent = var_0_1:getCityComponentById(var_2_0)

	if self._sprite then
		self._sprite:removeFromParent()

		self._sprite = nil
	end

	self._sprite = display.newSprite("#" .. g.core.common.Path:getNewSlgBuilding(self._cityComponent.res_1))

	self._sprite:setScale(self._cityComponent.scale / 10000)
	self._sprite:setAnchorPoint(0.5, 0)
	self._compPlace:addNode(self._sprite)
	self.m_Txt_pos:setText(g.core.lang:get(428986, {
		x = self._cityComponent.anchor_x,
		y = self._cityComponent.anchor_y
	}))
end

function NewSlgS2CityViewComp:_onClickBtnShare()
	if not self._cityInfo then
		return
	end

	if not g.core.model.User.allianceData:hasAlliance() then
		g.core.module.ModuleManager:tip(g.core.lang:get(428966))

		return
	end

	local var_3_0 = var_0_1.shareCityTime or 0
	local var_3_1 = g.core.common.ServerTime:getTime()

	if var_3_0 ~= 0 and var_3_1 - var_3_0 < 15 then
		g.core.module.ModuleManager:tip(g.core.lang:get(429631))

		return
	end

	var_0_1.shareCityTime = var_3_1

	g.core.network.GameNetProxy:send_C2S_BulletScreenSend({
		invite_id = 50,
		content = "",
		type = g.core.const.ConstMgr.ChatConst.ALLIANCE,
		share = {
			share_type = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_24
		},
		param1 = self._cityComponent.anchor_x .. ";" .. self._cityComponent.anchor_y .. ";" .. self._cityInfo.level .. ";" .. self._cityInfo.name
	})
	g.core.module.ModuleManager:tip(g.core.lang:get(110402))
end

return NewSlgS2CityViewComp
