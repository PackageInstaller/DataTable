-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AoQiAttackForceSelectBuffView.lua

module("logic.extensions.aoqiattackforce.view.AoQiAttackForceSelectBuffView", package.seeall)

local AoQiAttackForceSelectBuffView = class("AoQiAttackForceSelectBuffView", ViewComponent)

function AoQiAttackForceSelectBuffView:ctor()
	AoQiAttackForceSelectBuffView.super.ctor(self)
end

function AoQiAttackForceSelectBuffView:unbindEvents()
	AoQiAttackForceSelectBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGain)
	GameUtil.rmClickHandler(self._btnGetAll)
	GameUtil.rmClickHandler(self._btnRefresh)
end

function AoQiAttackForceSelectBuffView:bindEvents()
	AoQiAttackForceSelectBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGain, self._onClickGetOne, self)
	GameUtil.addClickHandler(self._btnGetAll, self._onClickGetAll, self)
	GameUtil.addClickHandler(self._btnRefresh, self._onClickRefresh, self)
end

function AoQiAttackForceSelectBuffView:buildUI()
	AoQiAttackForceSelectBuffView.super.buildUI(self)

	local tableviewGo = self:getGo("ScrollView")
	local cellGo = self:getGo("cell")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableview:setCenterMode(true)

	self._btnRefresh = self:getGo("btnRefresh")
	self._btnGetAll = self:getGo("btnGetAll")
	self._btnGain = self:getGo("btnGain")
	self._txtTips = self:getTxt("txtTips")
	self._txtNumCostRefresh = self:getTxt("costRefresh/txtNum")
	self._txtNumCostGainAll = self:getTxt("costGainAll/txtNum")
	self._txtCoin = self:getTxt("txtCoin")
	self._iconCoin = self:getGo("txtCoin/icon")
	self._iconCostGainAll = self:getGo("costGainAll/icon")
	self._iconCostRefresh = self:getGo("costRefresh/icon")
end

function AoQiAttackForceSelectBuffView:onExit()
	AoQiAttackForceSelectBuffView.super.onExit(self)
	self._tableview:dispose()
	uGuiUtil.clearImage(self._iconCoin)
	uGuiUtil.clearImage(self._iconCostGainAll)
	uGuiUtil.clearImage(self._iconCostRefresh)
end

function AoQiAttackForceSelectBuffView:onEnter()
	AoQiAttackForceSelectBuffView.super.onEnter(self)

	self._curActCfg = AoQiAttackForceModel.instance:getCurActCfg()
	self._txtNumCostGainAll.text = self._curActCfg.getAllBuffCost
	self._txtNumCostRefresh.text = self._curActCfg.refreshBuffCost

	local curBuffIds, limit = AoQiAttackForceModel.instance:getRandomBuffList(3)

	self._curLeftLimit = limit

	local curEquipsInGame = AoQiAttackForceModel.instance:getCurEquipsInGame()

	self._curEquipMap = {}

	for i, equip in ipairs(curEquipsInGame) do
		self._curEquipMap[equip.defineId] = true
	end

	self:_refreshBuff()

	local coinPath = GameUrl.getItemIconUrl(AoQiAttackForceConfig.instance:getCoinIconPath(self._curActCfg.activityId))

	uGuiUtil.setSpriteToImage(self._iconCoin, uGuiUtil.SpriteType.BigBg, coinPath, function()
		local img = self._iconCoin:GetComponent(goutil.Type_UIImage)
	end)
	uGuiUtil.setSpriteToImage(self._iconCostGainAll, uGuiUtil.SpriteType.BigBg, coinPath, function()
		local img = self._iconCostGainAll:GetComponent(goutil.Type_UIImage)
	end)
	uGuiUtil.setSpriteToImage(self._iconCostRefresh, uGuiUtil.SpriteType.BigBg, coinPath, function()
		local img = self._iconCostRefresh:GetComponent(goutil.Type_UIImage)
	end)
end

function AoQiAttackForceSelectBuffView:_refreshBuff()
	self._curSelectIndex = nil

	local curBuffIds = AoQiAttackForceModel.instance:getRandomBuffList(3)

	self._curDataList = {}

	for i, buffId in ipairs(curBuffIds) do
		local data = {}

		data.index = i
		data.buffId = buffId
		data.cfg = AoQiAttackForceConfig.instance:getBuffCfgInGameCfg(buffId)

		table.insert(self._curDataList, data)
	end

	if #curBuffIds <= 0 then
		if AoQiAttackForceModel.instance:getIsEndlessState() then
			UIStateManager.instance:push(ViewName.AoQiAttackForceGameView)
		else
			UIStateManager.instance:push(ViewName.AoqiattackbackpackView)
		end

		self:close()

		return
	end

	self._curSelectIndex = 1

	self._tableview:reloadData(self._curDataList)

	self._curBuffTimeLimit = AoQiAttackForceModel.instance:getCurBuffLimitTimes()
	self._curBuffTimeLeft = AoQiAttackForceModel.instance:getCurBuffTimes()

	local canGainTime = Mathf.Min(self._curLeftLimit, self._curBuffTimeLimit)

	self._txtTips.text = string.format("数量：%s/%s", self._curBuffTimeLimit - self._curBuffTimeLeft, canGainTime)
	self._txtCoin.text = AoQiAttackForceModel.instance:getCurCoinNum()
end

function AoQiAttackForceSelectBuffView:_updateCell(view, cell, data)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local buffIcon = goutil.findChild(cell, "BuffIcon")
	local select = goutil.findChild(cell, "select")
	local mark = goutil.findChild(cell, "mark")

	txtName.text = data.cfg.name
	txtDesc.text = data.cfg.desc

	goutil.setActive(select, data.index == self._curSelectIndex)
	goutil.setActive(mark, self._curEquipMap[data.cfg.equipIdlimit])

	local btn = goutil.findChild(cell, "btn")

	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickBtnSelect, self, data))
	uGuiUtil.clearImage(buffIcon)

	local picPath = string.format("%s.png", data.cfg.icon)

	uGuiUtil.setSpriteToImage(buffIcon, uGuiUtil.SpriteType.BigBg, picPath)
end

function AoQiAttackForceSelectBuffView:_clearCell(cell)
	local buffIcon = goutil.findChild(cell, "BuffIcon")

	uGuiUtil.clearImage(buffIcon)
end

function AoQiAttackForceSelectBuffView:_onClickBtnSelect(data)
	self._curSelectIndex = data.index

	self._tableview:reloadData(self._curDataList)
end

function AoQiAttackForceSelectBuffView:_onClickGetOne()
	self:_selectBuff(false)
end

function AoQiAttackForceSelectBuffView:_onClickGetAll()
	local costNum = self._curActCfg.getAllBuffCost

	if costNum <= AoQiAttackForceModel.instance:getCurCoinNum() then
		AoQiAttackForceModel.instance:costCoin(costNum)
		self:_selectBuff(true)
	else
		TipsFacade.instance:openCommonTips("货币不足")
	end
end

function AoQiAttackForceSelectBuffView:_onClickRefresh()
	local costNum = self._curActCfg.refreshBuffCost

	if costNum <= AoQiAttackForceModel.instance:getCurCoinNum() then
		AoQiAttackForceModel.instance:costCoin(costNum)
		self:_refreshBuff()
	else
		TipsFacade.instance:openCommonTips("货币不足")
	end
end

function AoQiAttackForceSelectBuffView:_selectBuff(isAll)
	local buffIds = {}

	if isAll then
		for i, buffData in ipairs(self._curDataList) do
			table.insert(buffIds, buffData.buffId)
		end
	else
		table.insert(buffIds, self._curDataList[self._curSelectIndex].buffId)
	end

	AoQiAttackForceModel.instance:selectBuffs(buffIds)

	if AoQiAttackForceModel.instance:getCurBuffTimes() > 0 then
		self:_refreshBuff()
	else
		if AoQiAttackForceModel.instance:getIsEndlessState() then
			UIStateManager.instance:push(ViewName.AoQiAttackForceGameView)
		else
			UIStateManager.instance:push(ViewName.AoqiattackbackpackView)
		end

		self:close()
	end
end

return AoQiAttackForceSelectBuffView
