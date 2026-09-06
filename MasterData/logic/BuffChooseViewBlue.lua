-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/BuffChooseViewBlue.lua

module("logic.extensions.common.view.BuffChooseViewBlue", package.seeall)

local BuffChooseViewBlue = class("BuffChooseViewBlue", ViewComponent)

function BuffChooseViewBlue:ctor()
	BuffChooseViewBlue.super.ctor(self)
end

function BuffChooseViewBlue:buildUI()
	BuffChooseViewBlue.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._btnSure = self:getGo("btnSure")
	self._txtTips = self:getTxt("txtTips")
	self._empty = self:getGo("empty")
	self._txtEmpty = self:getTxt("empty/txt")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function BuffChooseViewBlue:bindEvents()
	BuffChooseViewBlue.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function BuffChooseViewBlue:unbindEvents()
	BuffChooseViewBlue.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function BuffChooseViewBlue:onEnter()
	BuffChooseViewBlue.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._hasBuffIds = params[1] or {}
	self._buffCfgs = params[2] or {}
	self._chooseCallBackFunc = params[3]
	self._selectedBuffId = checknumber(params[4])
	self._tipsStr = params[5]
	self._emptyStr = params[6]

	self:_onSetUI()
	self:_onUpdate()
	self:_setScrollToCenter()
end

function BuffChooseViewBlue:onExit()
	BuffChooseViewBlue.super.onExit(self)

	if self._scrollList then
		self._scrollList:dispose()
	end
end

function BuffChooseViewBlue:_onSetUI()
	local dontHasTip = string.nilorempty(self._tipsStr)
	local dontHasEmpty = string.nilorempty(self._emptyStr)

	if not dontHasTip then
		self._txtTips.text = self._tipsStr
	end

	if not dontHasEmpty then
		self._txtEmpty.text = self._emptyStr
	end

	GameUtil.SetActive(self._txtTips.gameObject, not dontHasTip)
end

function BuffChooseViewBlue:_onUpdate()
	local hasBuff = #self._hasBuffIds > 0

	GameUtil.SetActive(self._empty, not hasBuff)
	GameUtil.SetActive(self._tableview, hasBuff)
	GameUtil.SetActive(self._btnSure.gameObject, hasBuff)
	self._scrollList:reloadData(self._hasBuffIds)
	self._scrollList:setCenterMode(true)
end

function BuffChooseViewBlue:_setScrollToCenter()
	if self._selectedBuffId > 0 then
		local idx = table.indexof(self._hasBuffIds, self._selectedBuffId)

		if checknumber(idx) > 0 then
			self._scrollList:MoveCellToCenter(idx - 1)
		end
	end
end

function BuffChooseViewBlue:_updateCell(view, cell, buffId)
	local selectGo = goutil.findChild(cell, "select")
	local btnGo = goutil.findChild(cell, "btn")
	local BuffIcon = goutil.findChild(cell, "BuffIcon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "sv/Viewport/txtDesc")
	local cfg = self._buffCfgs[buffId]

	if cfg then
		txtName.text = cfg.name or ""
		txtDesc.text = cfg.desc or ""

		GameUtil.SetActive(selectGo, self._selectedBuffId == buffId)
		GameUtil.addClickHandler(btnGo, GameUtil.handler(self._onClickBuffCell, self, buffId))
		uGuiUtil.setSpriteToImage(BuffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfg.icon))
	end
end

function BuffChooseViewBlue:_clearCell(cell)
	local btnGo = goutil.findChild(cell, "btn")
	local BuffIcon = goutil.findChild(cell, "BuffIcon")

	GameUtil.rmClickHandler(btnGo)
	uGuiUtil.clearImage(BuffIcon)
end

function BuffChooseViewBlue:_onClickBuffCell(buffId)
	self._selectedBuffId = buffId

	self:_onUpdate()
end

function BuffChooseViewBlue:_onClickSure()
	if self._selectedBuffId <= 0 then
		FloatWordMgr.instance:show(lang("请选择祝福"))

		return
	end

	if self._chooseCallBackFunc then
		GameUtil.callBack(self._chooseCallBackFunc, self._selectedBuffId)
	end

	self:close()
end

return BuffChooseViewBlue
