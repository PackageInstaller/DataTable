-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyluckybag/view/BuddyluckypreviewView.lua

module("logic.extensions.buddyluckybag.view.BuddyluckypreviewView", package.seeall)

local BuddyluckypreviewView = class("BuddyluckypreviewView", TableViewComponent)

function BuddyluckypreviewView:ctor()
	BuddyluckypreviewView.super.ctor(self)

	self._poolCfg = nil
	self._colCount = 6
end

function BuddyluckypreviewView:bindEvents()
	GameUtil.asBtn(self._closeBtn):AddClickListener(self.close, self)
end

function BuddyluckypreviewView:unbindEvents()
	GameUtil.asBtn(self._closeBtn):RemoveClickListener()
end

function BuddyluckypreviewView:destroyUI()
	return
end

function BuddyluckypreviewView:onExit()
	self._poolCfg = nil
	self._curViewDatas = nil
end

function BuddyluckypreviewView:buildUI()
	BuddyluckypreviewView.super.buildUI(self)

	local viewBgGo = self:getGo("viewBgGo")

	self._closeBtn = goutil.findChild(viewBgGo, "closeBtn")
	self._leftDesTxt = self:getTxt("viewBgGo/leftInfoGo/tableview/viewport/content")
end

function BuddyluckypreviewView:onEnter()
	self._activityId = self:getFirstParam()
	self._bagCfgs = BuddyLuckyBagConfig.instance:getBagDatas(self._activityId)

	local ruleCo = RulesConfig.instance:getRuleCo("chaifudaiview_rule")

	self._leftDesTxt.text = ruleCo.rules

	self:_updateViewData()
end

function BuddyluckypreviewView:_updateViewData()
	self._curViewDatas = self._bagCfgs

	self._tableview:ReloadData()
end

function BuddyluckypreviewView:_getPath()
	return {
		cellPath = "viewBgGo/callItem",
		viewPath = "viewBgGo/callItemSR"
	}
end

function BuddyluckypreviewView:_cellSize(sv, index)
	local poolId = self._curViewDatas[index + 1].poolId
	local poolObjCfgs = BuddyLuckyBagConfig.instance:getPoolPrizeDatas(poolId)
	local num = #poolObjCfgs
	local row = math.ceil(num / self._colCount)

	return 640, 42 + row * 116.5 + 15
end

function BuddyluckypreviewView:_updateCell(view, cell, data)
	local rateTxt = goutil.findChildTextComponent(cell, "rateTitle/rateTxt")
	local petListRoot = goutil.findChild(cell, "petList")
	local petItem = goutil.findChild(cell, "item")

	petItem:SetActive(false)

	rateTxt.text = data.name

	local list = BuddyLuckyBagConfig.instance:getPoolPrizeDatas(data.poolId)
	local childCount = petListRoot.transform.childCount
	local petNum = #list

	for i = 1, childCount do
		local go = petListRoot.transform:GetChild(i - 1).gameObject

		MaterialMgr.resetAll(go)
		go:SetActive(false)
	end

	local width = 110
	local scale = 0.85
	local realWidth = width * scale
	local gap = 15
	local gapY = 23
	local col = childCount + 1
	local row = 1

	while col > self._colCount do
		col = col - self._colCount
		row = row + 1
	end

	while childCount < petNum do
		local go = goutil.clone(petItem, "pet" .. childCount + 1)

		go.transform:SetParent(petListRoot.transform)
		Framework.TransformUtil.SetLocalPos(go.transform, (col - 1) * (realWidth + gap), -(row - 1) * (realWidth + gapY), 0)
		Framework.TransformUtil.SetLocalScale(go.transform, scale, scale, scale)

		childCount = childCount + 1
		col = col + 1

		if col > self._colCount then
			col = 1
			row = row + 1
		end
	end

	for i = 1, petNum do
		local go = petListRoot.transform:GetChild(i - 1).gameObject

		go:SetActive(true)
		MaterialMgr.resetAll(go)
		MaterialMgr.setCellListByCfg(list[i].prize, go)
	end
end

return BuddyluckypreviewView
