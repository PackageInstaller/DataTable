-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/newyear/BaseupdateView.lua

module("logic.extensions.bonus.view.newyear.BaseupdateView", package.seeall)

local BaseupdateView = class("BaseupdateView", SummarySubTabView)

function BaseupdateView:ctor()
	BaseupdateView.super.ctor(self)
end

function BaseupdateView:unbindEvents()
	BaseupdateView.super.unbindEvents(self)
end

function BaseupdateView:bindEvents()
	BaseupdateView.super.bindEvents(self)
end

function BaseupdateView:buildUI()
	BaseupdateView.super.buildUI(self)

	self.txtDesc = {}
	self.TableView = self:getGo("tableview")
	self.Cell = self:getGo("Cell")
	self.tableview = ScrollerList.create(self.TableView, self.Cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function BaseupdateView:onExit()
	self.tableview:dispose()
	BaseupdateView.super.onExit(self)
end

function BaseupdateView:onEnter()
	BaseupdateView.super.onEnter(self)
	self.tableview:reloadData(self._cfgs)
end

function BaseupdateView:_updateCell(view, cell, data)
	local paramsArr = string.split(data.params, "#")
	local cell1 = goutil.findChild(cell, "cell1")
	local cell2 = goutil.findChild(cell, "cell2")
	local cellShow = cell1
	local isCellType1 = data.id == 6 or data.id == 7

	if isCellType1 then
		goutil.setActive(cell1, true)
		goutil.setActive(cell2, false)

		cellShow = cell1
	else
		goutil.setActive(cell1, false)
		goutil.setActive(cell2, true)

		cellShow = cell2
	end

	local txtName = goutil.findChildTextComponent(cellShow, "txtName")
	local txt1 = goutil.findChildTextComponent(cellShow, "txt1/txtDesc")

	txtName.text = paramsArr[1]
	txt1.text = paramsArr[2]

	local btnJump = goutil.findChild(cellShow, "btnJump")

	GameUtil.addClickHandler(btnJump, GameUtil.handler(self._onJump, self, data))

	if isCellType1 then
		local txt2 = goutil.findChildTextComponent(cellShow, "txt2/txtDesc")

		txt2.text = paramsArr[3]
	else
		local btnTip = goutil.findChild(cellShow, "btnTip")
		local tipId = checknumber(paramsArr[3])

		if tipId > 0 then
			goutil.setActive(btnTip, true)
			GameUtil.addClickHandler(btnTip, GameUtil.handler(self._onTip, self, tipId))
		else
			GameUtil.rmClickHandler(btnTip)
			goutil.setActive(btnTip, false)
		end

		local item = goutil.findChild(cellShow, "item")

		uGuiUtil.setSpriteToImage(item, nil, GameUrl.getBonusIconUrl(data.background))
	end
end

function BaseupdateView:_clearCell(cell)
	local btnTip = goutil.findChild(cell, "cell2/btnTip")

	GameUtil.rmClickHandler(btnTip)

	local btnJump = goutil.findChild(cell, "cell1/btnJump")

	GameUtil.rmClickHandler(btnJump)

	btnJump = goutil.findChild(cell, "cell2/btnJump")

	GameUtil.rmClickHandler(btnJump)

	local item = goutil.findChild(cell, "cell2/item")

	uGuiUtil.clearImage(item)
end

function BaseupdateView:_onTip(id)
	UIStateManager.instance:push(ViewName.BaseupdatetipView, id)
end

return BaseupdateView
