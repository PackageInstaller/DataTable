-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastrichmanbookshopaddView.lua

module("logic.extensions.beastrichman.view.BeastrichmanbookshopaddView", package.seeall)

local BeastrichmanbookshopaddView = class("BeastrichmanbookshopaddView", ViewComponent)

function BeastrichmanbookshopaddView:ctor()
	BeastrichmanbookshopaddView.super.ctor(self)
end

function BeastrichmanbookshopaddView:unbindEvents()
	BeastrichmanbookshopaddView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function BeastrichmanbookshopaddView:bindEvents()
	BeastrichmanbookshopaddView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function BeastrichmanbookshopaddView:buildUI()
	BeastrichmanbookshopaddView.super.buildUI(self)

	self._btnClose = self:getGo("bg/btnClose")
	self._icon = self:getGo("bg/pet/mask/icon")
	self._tablecell = self:getGo("tablecell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function BeastrichmanbookshopaddView:onExit()
	BeastrichmanbookshopaddView.super.onExit(self)
	uGuiUtil.clearImage(self._icon)
	self._scrollList:dispose()
end

function BeastrichmanbookshopaddView:onEnter()
	BeastrichmanbookshopaddView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 558001
	end

	self._zoneId = checknumber(params[2])

	self:_initUI()
end

function BeastrichmanbookshopaddView:_initUI()
	local bookShopAddDataList = BeastRichmanModel.instance:getBookShopAddDataList(self._activityId, self._zoneId)

	self._scrollList:reloadData(bookShopAddDataList)

	local zoneCfg = BeastRichmanConfig.instance:getZoneCfgById(self._activityId, self._zoneId)
	local skinId = zoneCfg.skinId
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

	if modelCo and not string.nilorempty(modelCo.cardName) then
		local imgUrl = GameUrl.getPetImgUrl(modelCo.cardName)

		uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, imgUrl)
	end
end

function BeastrichmanbookshopaddView:_updateCell(view, cell, data)
	local txtLv = goutil.findChildTextComponent(cell, "txtLv")
	local txtReward = goutil.findChildTextComponent(cell, "txtReward")
	local id = data.id
	local level = data.level
	local buildCfg = BeastRichmanConfig.instance:getEventBuildShowCfgByLv(self._activityId, id, level)

	txtLv.text = string.format("%s级书店", level)
	txtReward.text = buildCfg.buffDesc
end

function BeastrichmanbookshopaddView:_clearCell(cell)
	return
end

return BeastrichmanbookshopaddView
