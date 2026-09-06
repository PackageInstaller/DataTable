-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/AceteammemberView.lua

module("logic.extensions.aceteam.view.AceteammemberView", package.seeall)

local AceteammemberView = class("AceteammemberView", ViewComponent)

function AceteammemberView:ctor()
	AceteammemberView.super.ctor(self)
end

function AceteammemberView:unbindEvents()
	AceteammemberView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
end

function AceteammemberView:bindEvents()
	AceteammemberView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function AceteammemberView:buildUI()
	AceteammemberView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.cell = self:getGo("cell")
	self.tableview = self:getGo("tableview")
	self._scrollRect = self:getGo("tableview"):GetComponent("ScrollRect")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function AceteammemberView:_updateCell(view, cell, data, tag)
	local petMo = AceTeamModel.instance:getPetMoByCfgId(data.creepsMasterId, data.creepsId)
	local container = goutil.findChild(cell.gameObject, "container")
	local comp = PetShowCard.AddOnce(container)

	comp:setPetMo(petMo, self)
	comp:setClickCallBack(function()
		CommonTipsMgr.instance:showPetTips(petMo)
	end)
	comp:initEvent()

	local petMaskImg = goutil.findChildImageComponent(container, "mask")

	petMaskImg.color = Framework.ColorUtil.ParseColor("#FFFFFFFF")
end

function AceteammemberView:clearCell(cell)
	local container = goutil.findChild(cell.gameObject, "container")
	local comp = PetShowCard.AddOnce(container)

	comp:dispose()
end

function AceteammemberView:onExit()
	AceteammemberView.super.onExit(self)
	self.scrollList:dispose()
end

function AceteammemberView:onEnter()
	AceteammemberView.super.onEnter(self)

	local groupId = checknumber(self:getFirstParam())
	local list = AceTeamConfig.instance:getPetListByGroupId(groupId)

	self.scrollList:reloadData(list)
end

return AceteammemberView
