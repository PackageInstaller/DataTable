-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/anheimm/AnheimmsperuleView.lua

module("logic.extensions.timelimitedchallenge.view.anheimm.AnheimmsperuleView", package.seeall)

local AnheimmsperuleView = class("AnheimmsperuleView", ViewComponent)

function AnheimmsperuleView:ctor()
	AnheimmsperuleView.super.ctor(self)
end

function AnheimmsperuleView:buildUI()
	AnheimmsperuleView.super.buildUI(self)

	self._modes = {}
	self._modeId = nil

	for i = 1, 5 do
		local mode = {}
		local str = "btn" .. i

		mode.btn = self:getBtn(str)
		mode.txt = self:getTxt(str .. "/Text")
		mode.uiChanges = self:getGo(str):GetComponent("UIChangeGroup")
		mode.cfg = AnheimmConfig.instance:getModeCfgById(i)

		if mode.cfg then
			mode.txt.text = mode.cfg.desc .. "难度"
		end

		mode.dataList = {}

		local ruleCfgs = AnheimmConfig.instance:getRuleCfgsByModeId(i)

		for _, v in pairs(ruleCfgs) do
			local data = {}

			data.sortId = #mode.dataList + 1
			data.cfg = v

			table.insert(mode.dataList, data)
		end

		self._modes[i] = mode
	end

	self._btnClose = self:getBtn("btnClose")
	self._goCell = self:getGo("right/cell")
	self._goTable = self:getGo("right/tableview")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function AnheimmsperuleView:bindEvents()
	AnheimmsperuleView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)

	for i = 1, 5 do
		self._modes[i].btn:AddClickListener(function()
			self:_onClickModeBtn(i)
		end, self)
	end
end

function AnheimmsperuleView:unbindEvents()
	AnheimmsperuleView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()

	for i = 1, 5 do
		self._modes[i].btn:RemoveClickListener()
	end
end

function AnheimmsperuleView:destroyUI()
	AnheimmsperuleView.super.destroyUI(self)
end

function AnheimmsperuleView:onEnter()
	AnheimmsperuleView.super.onEnter(self)
	self:_onClickModeBtn(1)
end

function AnheimmsperuleView:onEnterFinished()
	AnheimmsperuleView.super.onEnterFinished(self)
end

function AnheimmsperuleView:onExit()
	AnheimmsperuleView.super.onExit(self)
end

function AnheimmsperuleView:onExitFinished()
	AnheimmsperuleView.super.onExitFinished(self)
end

function AnheimmsperuleView:_onClickModeBtn(modeId)
	if self._modeId == modeId then
		return
	end

	local isOpen, openTime = AnheimmModel.instance:getModeIsOpen(modeId)

	if isOpen then
		self._modeId = modeId

		self._tableView:reloadData(self._modes[self._modeId].dataList)
	else
		local str = self._modes[modeId].txt.text

		FloatWordMgr.instance:show(str .. GameUtil.formatTimeStamp("%m月%d日开启", openTime))

		return
	end

	for i = 1, 5 do
		if modeId == i then
			self._modes[i].uiChanges:SetState(1)
		else
			self._modes[i].uiChanges:SetState(0)
		end
	end
end

function AnheimmsperuleView:_updateCell(view, cell, data)
	local uitext = goutil.findChild(cell, "imgNum"):GetComponent("UIImgNumeralText")

	uitext:SetText(data.sortId)

	local txtEffect = goutil.findChildTextComponent(cell, "txtEffect")

	txtEffect.text = data.cfg.buffDes

	local txtWinPrefect = goutil.findChildTextComponent(cell, "txtWinPrefect")
	local str = data.cfg.perfectDes

	str = GameUtil.isEmptyString(str) and "无" or "成功通关同时" .. str
	txtWinPrefect.text = "完美：" .. str
end

function AnheimmsperuleView:_clearCell(cell)
	return
end

return AnheimmsperuleView
