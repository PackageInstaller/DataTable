local NewSlgS2CityResultDetailPop = class("NewSlgS2CityResultDetailPop", require("app.fairyGUI.newSlg.UI_NewSlgS2CityResultDetailPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/newSlg/newSlg",
		resName = "NewSlgS2CityResultDetailPop",
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgS2CityResultDetailPop:ctor(arg_2_1)
	self:showAtCenter()

	arg_2_1 = arg_2_1 or {}
	self._resultState = 0
	self._cellData = arg_2_1.cellData
	self._cityId = self._cellData.city_id

	local var_2_0 = g.core.model.User.newSlgData:getCityInfoById(self._cityId)

	self.m_cityName:setText(g.core.lang:get(429650, {
		level = var_2_0.level,
		name = var_2_0.name
	}))

	self._listAlliance = self:getChild("List_alliance")

	self._listAlliance:setVirtual(self)
	self._listAlliance:setItemRenderer(handler(self, self._onRenderListAllianceCell))
	self.m_closeBtn:setClickCallBack(handler(self, self._onClickClose))
	self.m_closeGraph:addClickListener(handler(self, self._onClickClose))
	self.m_enterTransition:play()
end

function NewSlgS2CityResultDetailPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETSNAPSHOT, self._onS2CAllianceSnapShot, self)
	self:_updateView()
end

function NewSlgS2CityResultDetailPop:_onClickClose()
	if self._inClose then
		return
	end

	self._inClose = true

	self.m_backTransition:play(handler(self, self.onCloseAnimFinish))
end

function NewSlgS2CityResultDetailPop:onCloseAnimFinish()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function NewSlgS2CityResultDetailPop:_updateView()
	self._rankArr = self._cellData.rank_alliance_ids or {}

	self._listAlliance:setNumItems(#self._rankArr)
end

function NewSlgS2CityResultDetailPop:_onRenderListAllianceCell(arg_7_1, arg_7_2)
	arg_7_2:updateCell({
		allianceId = self._rankArr[arg_7_1 + 1],
		isWin = self._cellData.is_win,
		isDef = self._cellData.is_def,
		win_alliance_id = self._cellData.win_alliance_id,
		rank = arg_7_1 + 1
	})
end

function NewSlgS2CityResultDetailPop:_onS2CAllianceSnapShot()
	self:_updateView()
end

return NewSlgS2CityResultDetailPop
