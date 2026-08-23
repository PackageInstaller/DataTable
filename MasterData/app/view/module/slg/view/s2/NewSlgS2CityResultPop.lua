local NewSlgS2CityResultPop = class("NewSlgS2CityResultPop", require("app.fairyGUI.newSlg.UI_NewSlgS2CityResultPop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgS2CityResultPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)
local var_0_1 = g.core.model.User.newSlgData
local var_0_2 = g.core.common.Goods

function NewSlgS2CityResultPop:ctor()
	self:showAtCenter()

	self._listCity = self:getChild("List_city")

	self._listCity:setVirtual(self)
	self._listCity:setItemRenderer(handler(self, self._onRenderListCityCell))
	self.m_closeBtn:setClickCallBack(handler(self, self._onClickClose))
	self.m_closeGraph:addClickListener(handler(self, self._onClickClose))
	self.m_enterTransition:play()
end

function NewSlgS2CityResultPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETALLIANCEINFO, self._onGetInfoRec, self)
	g.core.network.GameNetProxy:send_C2S_NewSlg_GetAllianceInfo({
		user_id = g.core.model.User:getId()
	})
end

function NewSlgS2CityResultPop:_onGetInfoRec()
	self._content = var_0_1:getCityResultServerData()
	self._giveUpCities = var_0_1:getGiveUpCities() or {}

	self:_updateView()
end

function NewSlgS2CityResultPop:_onClickClose()
	if self._inClose then
		return
	end

	self._inClose = true

	self.m_backTransition:play(handler(self, self.onCloseAnimFinish))
end

function NewSlgS2CityResultPop:onCloseAnimFinish()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function NewSlgS2CityResultPop:_updateView()
	if not self._content then
		self.m_isEmptyController:setSelectedIndex(1)

		return
	end

	self._cities = self._content.cities or {}

	if #self._cities == 0 then
		self.m_isEmptyController:setSelectedIndex(1)

		return
	end

	self.m_isEmptyController:setSelectedIndex(0)
	self._listCity:setNumItems(#self._cities + ((self._giveUpCities or nil) and (#self._giveUpCities or 0)))

	local var_7_0 = var_0_1:getAllianceData()
	local var_7_1 = self._content.score or 0
	local var_7_2 = var_0_2:convert({
		type = var_0_2.TYPE_RESOURCE,
		value = var_0_2.RESOURCE.TYPE_NEW_SLG_SCORE
	})

	self.m_occupiedScore:setIcon(var_7_2.icon_mini)
	self.m_occupiedScore:getChild("score"):setText(var_7_0.daily_atk_point)
	self.m_dailyScore:setIcon(var_7_2.icon_mini)
	self.m_dailyScore:getChild("score"):setText(var_7_0.daily_occupied_point)
	self.m_personScore:setIcon(var_0_2:convert({
		type = var_0_2.TYPE_RESOURCE,
		value = var_0_2.RESOURCE.TYPE_NEW_SLG_CONTRIBUTION
	}).icon_mini)
	self.m_personScore:getChild("score"):setText(var_7_1)
end

function NewSlgS2CityResultPop:_onRenderListCityCell(arg_8_1, arg_8_2)
	if self._cities[arg_8_1 + 1] then
		arg_8_2:updateCell(self._cities[arg_8_1 + 1])
	else
		arg_8_2:updateQuitCell(self._giveUpCities[arg_8_1 + 1 - #self._cities])
	end
end

return NewSlgS2CityResultPop
