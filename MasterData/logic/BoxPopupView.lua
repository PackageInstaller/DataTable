-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/treasure/BoxPopupView.lua

module("logic.extensions.legend.view.treasure.BoxPopupView", package.seeall)

local BoxPopupView = class("BoxPopupView", ViewComponent)

function BoxPopupView:buildUI()
	BoxPopupView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtTip = self:getTxt("txtTip")
	self._tableview = self:getGo("scrollList"):GetComponent("UITableview")
	self._tableCell = self:getGo("scrollList/item")

	self._tableCell:SetActive(false)
end

function BoxPopupView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function BoxPopupView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function BoxPopupView:onEnter()
	self._boxCfg = self:getFirstParam()

	if not self._boxCfg then
		return
	end

	self:_setText()
	self:_setReward()
end

function BoxPopupView:onExit()
	self:_disposeScrollList()
end

function BoxPopupView:_onClickClose()
	self:close()
end

function BoxPopupView:_setText()
	self._txtTitle.text = string.format("%d号宝箱", self._boxCfg.treasureId)
	self._txtTip.text = self:_getTipText()
end

function BoxPopupView:_getTipText()
	if string.nilorempty(self._boxCfg.condition) then
		return ""
	end

	local list = string.split(self._boxCfg.condition, ",")
	local names = {}

	for i, v in ipairs(list) do
		if not string.nilorempty(v) then
			local str = string.split(v, "_")
			local challengeId = checknumber(str[1])
			local cfg = LegendConfig.instance:getLegendChallengeCfg(challengeId)

			if cfg then
				table.insert(names, cfg.challengeName)
			end
		end
	end

	local resultStr = "通关"

	for i, v in ipairs(names) do
		resultStr = i == 1 and resultStr .. string.format("<color=#EB4642FF>%s</color>挑战", v) or resultStr .. string.format("和<color=#EB4642FF>%s</color>挑战", v)
	end

	return resultStr
end

function BoxPopupView:_setReward()
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)

	self._curViewDatas = {}

	local list = string.split(self._boxCfg.prize, "#")

	if list and #list > 0 then
		for i, v in ipairs(list) do
			table.insert(self._curViewDatas, v)
		end
	end

	self._tableview:ReloadData()
end

function BoxPopupView:_disposeScrollList()
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = nil

	self._tableview:UnRegisterAllCallbacks()
end

function BoxPopupView:_numInView()
	return #self._curViewDatas
end

function BoxPopupView:_cellSize(view, idx)
	return 172, 202
end

function BoxPopupView:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	self:_updateCell(view, cell, data)

	return cell
end

function BoxPopupView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell.gameObject, "node")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local proxy = MaterialMgr.setCellByCfg(data, item)
	local strList = string.split(data, ":")

	txtName.text = MaterialMgr.getMaterialsName(strList[1], strList[2])
end

function BoxPopupView:_clearTableview(cell)
	local item = goutil.findChild(cell.gameObject, "node")

	MaterialMgr.resetAll(item)
end

return BoxPopupView
