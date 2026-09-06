-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assistancebox/view/AssistanceboxprizeView.lua

module("logic.extensions.assistancebox.view.AssistanceboxprizeView", package.seeall)

local AssistanceboxprizeView = class("AssistanceboxprizeView", ViewComponent)

function AssistanceboxprizeView:buildUI()
	AssistanceboxprizeView.super.buildUI(self)

	self._tableview = self:getGo("norTypePanel/tableview")
	self._tablecell = self:getGo("norTypePanel/tablecell")
	self._btnClose = self:getBtn("btnClose")
end

function AssistanceboxprizeView:bindEvents()
	AssistanceboxprizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AssistanceboxprizeView:unbindEvents()
	AssistanceboxprizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AssistanceboxprizeView:onEnter()
	AssistanceboxprizeView.super.onEnter(self)

	local boxCfgId = self:getFirstParam()

	self._boxCfg = AssistanceBoxConfig.instance:getDefineCfgById(checknumber(boxCfgId))
	self._prizeList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	local prize = string.split(self._boxCfg.showPrize, "#")

	self._prizeList:reloadData(prize)
end

function AssistanceboxprizeView:onExit()
	AssistanceboxprizeView.super.onExit(self)
	self._prizeList:dispose()
end

function AssistanceboxprizeView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local matCon = goutil.findChild(go, "root/con")
	local txtName = goutil.findChildTextComponent(go, "root/txtName")
	local type, id, num = MaterialMgr.getMatParams(data)

	if type == MatType.DROP_ITEM then
		local cfg = MaterialConfig.instance:getCfgByDropId(id)

		uGuiUtil.setSpriteToImage(matCon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(cfg.icon))
	else
		MaterialMgr.setCellByCfg(data, matCon)
	end

	txtName.text = MaterialMgr.getMaterialsNameByCfg(data)
end

function AssistanceboxprizeView:_clearCell(cell)
	local go = cell.gameObject
	local matCon = goutil.findChild(go, "root/con")

	MaterialMgr.resetAll(matCon)
	uGuiUtil.clearImage(matCon)
end

return AssistanceboxprizeView
