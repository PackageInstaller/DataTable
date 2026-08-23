local MineConst = require("app.view.module.mine.const.MineConst")
local MineCityComp = class("MineCityComp", require("app.fairyGUI.mine.UI_MineCityComp"))

function MineCityComp:ctor()
	self._cityStruct = nil

	self:addClickListener(handler(self, self._onTouchClick))
end

function MineCityComp:updateCity(arg_2_1)
	self._cityStruct = arg_2_1

	local var_2_0 = self._cityStruct:getCfg()
	local var_2_1 = g.core.model.User.mineData:getActivtyType() or MineConst.ACTIVITY_TYPE.CROSS_SERVER

	self.m_buildIcon:setURL(g.core.common.Path:getCityBuildingPic(var_2_0.city_pic), true)
	self.m_qualityBg:setURL("ui://mine/pic_qsmy_renshubg" .. var_2_0.type, true)

	local var_2_2 = self._cityStruct:isCityOccu()

	self.m_hasGuildController:setSelectedIndex(var_2_2 and 1 or 0)
	self.m_stateController:setSelectedIndex(0)
	self.m_buildIcon:setScale(var_2_0.zoom / 100)

	if var_2_2 then
		self.m_guildNameTxt:setText((self._cityStruct:getGuildName()))

		local var_2_3 = self._cityStruct:getGuildData()

		if var_2_3 then
			if var_2_1 == MineConst.ACTIVITY_TYPE.CROSS_SERVER then
				local var_2_4, var_2_5 = g.core.lang:getFormatServerName(var_2_3.server_name)

				self.m_svrNameTxt:setText(var_2_5)
			end

			if g.core.model.User.guildData:getGuildId() == var_2_3.id then
				self.m_stateController:setSelectedIndex(1)
			elseif g.core.model.User.mineData:isEnemyGuild(var_2_3.id) then
				self.m_stateController:setSelectedIndex(2)
			end
		end
	end

	self.m_playerNumTxt:setText((self._cityStruct:getPeopleNum()))
	self.m_fullController:setSelectedIndex(self._cityStruct:isDecrease() and 1 or 0)
	self.m_cityNameTxt:setText(var_2_0.name)
	self.m_svrTypeController:setSelectedIndex(var_2_1 - 1)
	self.m_isCapitalController:setSelectedIndex(self._cityStruct:isCapital() and 1 or 0)
	self.m_multipleEffComp:removeAllEffect()
	self.m_flagEffComp:removeAllEffect()
	self:updateCityBubble()

	if g.core.model.User.mineData:isGathering() and g.core.model.User.mineData:getGatherCityId() == var_2_0.id then
		self:addFlagEff()
	end
end

function MineCityComp:updateCityBubble()
	local var_3_0 = self._cityStruct:getEventId()

	self.m_typeController:setSelectedIndex(var_3_0 > 0 and 1 or 0)
	self.m_redPointComp:setVisible(true)

	local var_3_1 = {
		cityId = self._cityStruct:getCityId()
	}

	if var_3_0 == MineConst.EVENT_ID.BONUS then
		self.m_bubComp:setCtrlState("type", {
			index = 0
		})
		self.m_multipleEffComp:addEffectSpine({
			name = "eff_ui_mine_multiple",
			anim = "play_2",
			isLoop = true
		})
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_buyForceBtn
		})
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = var_3_1
		})
	elseif var_3_0 == MineConst.EVENT_ID.ADVANCE_BONUS then
		self.m_bubComp:setCtrlState("type", {
			index = 1
		})
		self.m_multipleEffComp:addEffectSpine({
			name = "eff_ui_mine_multiple",
			anim = "play_3",
			isLoop = true
		})
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_buyForceBtn
		})
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = var_3_1
		})
	elseif var_3_0 == MineConst.EVENT_ID.CAPITAL then
		self.m_bubComp:setCtrlState("type", {
			index = 2
		})
		self.m_multipleEffComp:addEffectSpine({
			name = "eff_ui_mine_multiple",
			anim = "play_1",
			isLoop = true
		})
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_buyForceBtn
		})
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = var_3_1
		})
	else
		self.m_redPointComp:setVisible(false)
	end
end

function MineCityComp:addFlagEff()
	self.m_flagEffComp:addEffectSpine({
		name = "eff_ui_mine_flag",
		isLoop = true
	})
end

function MineCityComp:_onTouchClick()
	if self._cityStruct then
		g.core.module.ModuleManager:pushModule(g.view.entrance.MINE_CITY, {
			struct = self._cityStruct
		})
	end
end

return MineCityComp
