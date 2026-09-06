-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arenamonth/view/ArenaMonthView.lua

module("logic.extensions.arenamonth.view.ArenaMonthView", package.seeall)

local ArenaMonthView = class("ArenaMonthView", ViewComponent)
local CELL_INFO = {
	{
		tips = "123",
		name = "王者竞技场",
		jumpTo = "func#1138",
		tag = true,
		prize = "10:426001"
	},
	{
		tips = "123",
		name = "竞技场",
		jumpTo = "func#19",
		tag = true,
		prize = "8:3"
	},
	{
		tips = "",
		name = "排位赛",
		jumpTo = "func#69",
		tag = true,
		prize = "8:3"
	}
}

function ArenaMonthView:ctor()
	ArenaMonthView.super.ctor(self)
end

function ArenaMonthView:unbindEvents()
	ArenaMonthView.super.unbindEvents(self)
end

function ArenaMonthView:bindEvents()
	ArenaMonthView.super.bindEvents(self)
end

function ArenaMonthView:buildUI()
	ArenaMonthView.super.buildUI(self)

	self._cells = {}

	for k, v in pairs(CELL_INFO) do
		local cell = {}
		local go = self:getGo("cell" .. k)

		if go then
			cell.go = go
			self._cells[k] = cell
		end
	end

	self._txtTime = self:getTxt("time/txtTime")
end

function ArenaMonthView:onExit()
	ArenaMonthView.super.onExit(self)

	for k, v in pairs(self._cells) do
		self:removeCell(v)
	end
end

function ArenaMonthView:onEnter()
	ArenaMonthView.super.onEnter(self)

	for k, v in pairs(self._cells) do
		if CELL_INFO[k] then
			GameUtil.SetActive(v, true)
			self:updateCell(v.go, CELL_INFO[k])
		else
			self:removeCell(v.go)
			GameUtil.SetActive(v, false)
		end
	end
end

function ArenaMonthView:updateCell(cell, data)
	local go = cell.gameObject
	local con = goutil.findChild(go, "item/con")
	local tag = goutil.findChild(go, "item/tag")

	GameUtil.SetActive(txtTips, not string.nilorempty(data.tips))
	GameUtil.SetActive(tag, data.tag)
	MaterialMgr.setCellByCfg(data.prize, con)
	GameUtil.addClickHandler(go, function()
		self:_onClickCell(data)
	end, self)
end

function ArenaMonthView:removeCell(cell)
	local go = cell.gameObject

	if go then
		GameUtil.rmClickHandler(go)
	end
end

function ArenaMonthView:_onClickCell(data)
	GotoMgr.gotoByString(data.jumpTo)
end

return ArenaMonthView
