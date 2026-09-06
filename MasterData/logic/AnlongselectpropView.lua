-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anlongselfselect/view/AnlongselectpropView.lua

module("logic.extensions.anlongselfselect.view.AnlongselectpropView", package.seeall)

local AnlongselectpropView = class("AnlongselectpropView", TableViewComponent)

function AnlongselectpropView:ctor()
	AnlongselectpropView.super.ctor(self)
end

function AnlongselectpropView:buildUI()
	AnlongselectpropView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._selectGo2 = self:getGo("proplList/item2/select")
	self._emptyGo2 = self:getGo("proplList/item2/empty")
	self._emptyGo1 = self:getGo("proplList/item1/empty")
	self._selectGo1 = self:getGo("proplList/item1/select")
	self._propConGo1 = self:getGo("proplList/item1/con")
	self._propConGo2 = self:getGo("proplList/item2/con")
end

function AnlongselectpropView:bindEvents()
	AnlongselectpropView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function AnlongselectpropView:unbindEvents()
	AnlongselectpropView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function AnlongselectpropView:destroyUI()
	AnlongselectpropView.super.destroyUI(self)
end

function AnlongselectpropView:onEnter()
	AnlongselectpropView.super.onEnter(self)

	local params = self:getOpenParam()

	self._actId = params[1]
	self._packId = params[2]
	self._selectList = params[3]
	self._ori_optionCache = self._selectList[self._packId]
	self._optionCache = {}

	for k, v in pairs(self._ori_optionCache or {}) do
		self._optionCache[k] = v
	end

	self._okCallBack = params[4]
	self._cacheKey = params[5]
	self._pos2OptionId = 0
	self._pos1OptionId = 0
	self._relpaceIndex = 1
	self._optionCfgs = AnlongselfselectConfig.instance:getOptionCfgs(self._actId, self._packId)

	table.sort(self._optionCfgs, function(a, b)
		return a.optionId < b.optionId
	end)

	self._curViewDatas = self._optionCfgs

	self:_updateUI()
end

function AnlongselectpropView:onEnterFinished()
	AnlongselectpropView.super.onEnterFinished(self)
end

function AnlongselectpropView:onExit()
	AnlongselectpropView.super.onExit(self)
	MaterialMgr.resetAll(self._propConGo1)
	MaterialMgr.resetAll(self._propConGo2)
end

function AnlongselectpropView:onExitFinished()
	AnlongselectpropView.super.onExitFinished(self)
end

function AnlongselectpropView:_onClickbtnClose()
	self._selectList[self._packId] = self._ori_optionCache

	self:close()
end

function AnlongselectpropView:_onClickbtnSure()
	if table.nums(self._optionCache) < 2 then
		FloatWordMgr.instance:show("请先完成定制您的专属礼包哦")

		return
	end

	self._selectList[self._packId] = self._optionCache

	self._okCallBack()
	self:close()
end

function AnlongselectpropView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableView"
	}
end

function AnlongselectpropView:_cellSize(view, index)
	return 100, 100
end

function AnlongselectpropView:_updateCell(view, cell, cfg)
	local goCon = goutil.findChild(cell.gameObject, "con")
	local goSelect = goutil.findChild(cell.gameObject, "select")
	local btnSelect = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnSelect")

	MaterialMgr.setCellByCfg(cfg.optionContent, goCon)
	goutil.setActive(goSelect, self._pos1OptionId == cfg.optionId or self._pos2OptionId == cfg.optionId)
	goutil.setActive(btnSelect.gameObject, self._pos1OptionId ~= cfg.optionId and self._pos2OptionId ~= cfg.optionId)
	btnSelect:AddClickListener(function()
		if self._relpaceIndex > 0 then
			self._curPosIndex = (self._relpaceIndex - 1) % 2 + 1 or 1
		end

		self:_selectGoods(self._curPosIndex, cfg)
	end)
end

function AnlongselectpropView:_selectGoods(index, cfg)
	self._relpaceIndex = self._relpaceIndex + 1
	self._optionCache[index] = self._optionCache[index] or {
		optionId = 0,
		contentStr = ""
	}
	self._optionCache[index].optionId = cfg.optionId
	self._optionCache[index].contentStr = cfg.optionContent
	self._curSelectOptionId = cfg.optionId

	if self._optionCache[2] then
		self._pos2OptionId = self._optionCache[2].optionId or 0
	end

	if self._optionCache[1] then
		self._pos2OptionId = self._optionCache[1].optionId or 0
	end

	self:_updateUI()
end

function AnlongselectpropView:_clearTableview(cell)
	local goCon = goutil.findChild(cell.gameObject, "con")

	MaterialMgr.resetAll(goCon)
end

function AnlongselectpropView:_updateUI()
	self:_setPropItems()
	self:reloadData()
end

function AnlongselectpropView:_setPropItems()
	self._pos2OptionId = 0
	self._pos1OptionId = 0

	for posIndex = 1, 2 do
		local con = self["_propConGo" .. posIndex]

		goutil.setActive(con, self._optionCache[posIndex])

		if self._optionCache[posIndex] then
			if posIndex == 1 then
				self._pos1OptionId = self._optionCache[posIndex].optionId
			else
				self._pos2OptionId = self._optionCache[posIndex].optionId
			end

			MaterialMgr.setCellByCfg(self._optionCache[posIndex].contentStr, con)
		end
	end
end

return AnlongselectpropView
