-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManStorySelectView.lua

module("logic.extensions.beastrichman.view.BeastRichManStorySelectView", package.seeall)

local BeastRichManStorySelectView = class("BeastRichManStorySelectView", ViewComponent)

function BeastRichManStorySelectView:ctor()
	BeastRichManStorySelectView.super.ctor(self)
end

function BeastRichManStorySelectView:unbindEvents()
	BeastRichManStorySelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSelect)
	self._btnGiveUp:RemoveClickListener()
end

function BeastRichManStorySelectView:bindEvents()
	BeastRichManStorySelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSelect, self.close, self)
	self._btnGiveUp:AddClickListener(self._onClickbtnGiveUp, self)
end

function BeastRichManStorySelectView:buildUI()
	BeastRichManStorySelectView.super.buildUI(self)

	self._btnClose = self:getGo("bg/btnClose")
	self._icon = self:getGo("bg/pet/mask/icon")
	self._select = self:getGo("select")
	self._btnSelect = self:getGo("select/btnSelect")
	self._tableviewSelect = self:getGo("select/tableview")
	self._tablecellSelect = self:getGo("select/tableview/tablecell")
	self._scrollListSelect = ScrollerList.create(self._tableviewSelect, self._tablecellSelect, GameUtil.handler(self._updateSelectCell, self), GameUtil.handler(self._clearSelectCell, self))
	self._event = self:getGo("event")
	self._txtEventTip = self:getTxt("event/eventTip/img/txt")
	self._tablecellEvent = self:getGo("event/eventTip/tableview/tablecell")
	self._tableviewEvent = self:getGo("event/eventTip/tableview")
	self._scrollListEvent = ScrollerList.create(self._tableviewEvent, self._tablecellEvent, GameUtil.handler(self._updateEventCell, self), GameUtil.handler(self._clearEventCell, self))
	self._btnGiveUp = self:getBtn("btnGiveUp")
end

function BeastRichManStorySelectView:onExit()
	BeastRichManStorySelectView.super.onExit(self)
	uGuiUtil.clearImage(self._icon)
	self._scrollListSelect:dispose()
	self._scrollListEvent:dispose()
end

function BeastRichManStorySelectView:onEnter()
	BeastRichManStorySelectView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BeastRichManHandleGridRes, self._onHandleGridRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 558001
	end

	self._zoneId = checknumber(params[2])
	self._gridId = checknumber(params[3])
	self._pathCfg = BeastRichmanConfig.instance:getGridCfg(self._activityId, self._zoneId, self._gridId)

	local storyId = 1

	if self._pathCfg then
		storyId = checknumber(self._pathCfg.gridParam) > 0 and checknumber(self._pathCfg.gridParam) or 1
	end

	self._actCfg = BeastRichmanConfig.instance:getActCfg(self._activityId)
	self._storyCfg = BeastRichmanConfig.instance:getStoryCfgById(self._activityId, storyId)
	self._gridStoryCfgs = BeastRichmanConfig.instance:getGridStoryCfgsById(self._activityId, storyId)
	self._selectIdx = 0

	self:_initUI()
end

function BeastRichManStorySelectView:_initUI()
	GameUtil.SetActive(self._event, true)
	GameUtil.SetActive(self._select, false)

	local zoneCfg = BeastRichmanConfig.instance:getZoneCfgById(self._activityId, self._zoneId)
	local skinId = zoneCfg.skinId
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

	if modelCo and not string.nilorempty(modelCo.cardName) then
		local imgUrl = GameUrl.getPetImgUrl(modelCo.cardName)

		uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, imgUrl)
	end

	self._txtEventTip.text = self._storyCfg.content

	self._scrollListEvent:reloadData(self._gridStoryCfgs)
end

function BeastRichManStorySelectView:_updateSelectCell(view, cell, data)
	local txtSelect = goutil.findChildTextComponent(cell, "txtSelect")

	txtSelect.text = data.desc
end

function BeastRichManStorySelectView:_clearSelectCell(cell)
	return
end

function BeastRichManStorySelectView:_updateEventCell(view, cell, data)
	local txtSelect = goutil.findChildTextComponent(cell, "txtSelect")

	txtSelect.text = data.desc

	GameUtil.addClickHandler(cell, function()
		local curScore = BeastRichmanModel.instance:getScore(self._activityId)
		local cost = data.cost

		if curScore < cost then
			FloatWordMgr.instance:show("积分不足,无法选择该选项")

			return
		end

		local param = ""

		param = param .. data.selectionId
		self._dialogueId = data.dialogueId
		self._isGiveUp = false

		BeastRichmanController.instance:sendPM_BeastRichManHandleGridReq(self._activityId, self._zoneId, self._gridId, param)
	end, self)
end

function BeastRichManStorySelectView:_clearEventCell(cell)
	return
end

function BeastRichManStorySelectView:_onHandleGridRes()
	if self._isGiveUp then
		self:close()

		return
	end

	GameUtil.SetActive(self._event, false)
	GameUtil.SetActive(self._btnGiveUp.gameObject, false)
	GameUtil.SetActive(self._select, true)

	self._dialogueCfg = BeastRichmanConfig.instance:getGridStoryEndCfgsById(self._activityId, self._dialogueId)

	self._scrollListSelect:reloadData(self._dialogueCfg)
	BeastRichmanController.instance:tryPopCurScore(self._activityId)
end

function BeastRichManStorySelectView:_onClickbtnGiveUp()
	local param = "-1"

	self._isGiveUp = true

	BeastRichmanController.instance:sendPM_BeastRichManHandleGridReq(self._activityId, self._zoneId, self._gridId, param)
end

return BeastRichManStorySelectView
