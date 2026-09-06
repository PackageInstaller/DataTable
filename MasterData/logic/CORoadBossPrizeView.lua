-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/boss/CORoadBossPrizeView.lua

module("logic.extensions.cantonoperaroad.view.boss.CORoadBossPrizeView", package.seeall)

local CORoadBossPrizeView = class("CORoadBossPrizeView", ViewComponent)

function CORoadBossPrizeView:buildUI()
	CORoadBossPrizeView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")

	local prizeScrollerview = goutil.findChild(self.mainGO, "prizeCol/prizeScrollerview")
	local prizeScrollercell = goutil.findChild(self.mainGO, "prizeCol/prizeScrollercell")

	self._itemScrollercell = goutil.findChild(self.mainGO, "prizeCol/itemScrollercell")
	self._prizeScrollList = ScrollerList.create(prizeScrollerview, prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)
end

function CORoadBossPrizeView:bindEvents()
	CORoadBossPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function CORoadBossPrizeView:unbindEvents()
	CORoadBossPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function CORoadBossPrizeView:onEnter()
	CORoadBossPrizeView.super.onEnter(self)

	self._activityId = 189001
	self._modelId = GameEnum.ModelTypeAsCOR.BOSS

	self:_onSetUI()
	self:_onUpdate()
end

function CORoadBossPrizeView:onExit()
	CORoadBossPrizeView.super.onExit(self)
	self._prizeScrollList:dispose()
end

function CORoadBossPrizeView:_onSetUI()
	return
end

function CORoadBossPrizeView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function CORoadBossPrizeView:_onUpdateData()
	return
end

function CORoadBossPrizeView:_onUpdateUI()
	self:_onUpdatePrizeColUI()
end

function CORoadBossPrizeView:_onUpdatePrizeColUI()
	local cfg = CantonOperaRoadConfig.instance:getCorBossPrizeDataListById(self._activityId)

	self._prizeScrollList:reloadData(cfg or {})
end

function CORoadBossPrizeView:_updatePrizeCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")

	txtDesc.text = data.txtDesc

	if itemScrollerview and self._itemScrollercell then
		local prizeStrArr = string.split(data.prize, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = self._itemScrollListDic[mainGo]

			self._itemScrollListDic[mainGo]:reloadData(prizeStrArr)
			self._itemScrollListDic[mainGo]:dragNotifyParent()
		end
	end
end

function CORoadBossPrizeView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function CORoadBossPrizeView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo, urlOrGo, luaCls, isOne)
end

function CORoadBossPrizeView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return CORoadBossPrizeView
