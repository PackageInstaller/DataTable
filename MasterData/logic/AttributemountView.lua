-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/christmasandnewyear/AttributemountView.lua

module("logic.extensions.bonus.view.christmasandnewyear.AttributemountView", package.seeall)

local AttributemountView = class("AttributemountView", SummarySubTabView)

function AttributemountView:ctor()
	AttributemountView.super.ctor(self)
end

function AttributemountView:unbindEvents()
	for i, goBtn in ipairs(self.btnGo) do
		GameUtil.rmClickHandler(goBtn)
	end

	AttributemountView.super.unbindEvents(self)
end

function AttributemountView:bindEvents()
	AttributemountView.super.bindEvents(self)

	for i, goBtn in ipairs(self.btnGo) do
		local data = self._cfgs[i]

		if data then
			GameUtil.addClickHandler(goBtn, GameUtil.handler(self._onJump, self, data))
		end
	end
end

function AttributemountView:buildUI()
	AttributemountView.super.buildUI(self)

	self.items = {}
	self.btnGo = {}

	for i = 1, 4 do
		local cell = self:getGo("cell_" .. i)

		table.insert(self.items, cell)

		local btnGo = goutil.findChild(cell, "con/goBtn")

		table.insert(self.btnGo, btnGo)
	end
end

function AttributemountView:buildBtnJump()
	return
end

function AttributemountView:onExit()
	for i, cell in ipairs(self.items) do
		local icon = goutil.findChild(cell, "con/icon")

		MaterialMgr.resetAll(icon)
		GameUtil.rmClickHandler(icon)
	end

	AttributemountView.super.onExit(self)
end

function AttributemountView:onEnter()
	AttributemountView.super.onEnter(self)

	for i, cell in ipairs(self.items) do
		local txtTitle = goutil.findChildTextComponent(cell, "con/txtTitle")
		local icon = goutil.findChild(cell, "con/icon")
		local data = self._cfgs[i]

		if data then
			txtTitle.text = data.params

			MaterialMgr.updateItemByStr(icon, data.background)
			GameUtil.addClickHandler(icon, function()
				CommonTipsMgr.instance:openTipsByConfStr(icon, data.background)
			end)
		end
	end
end

return AttributemountView
