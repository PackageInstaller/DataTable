-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breachformmaster/view/BreachFormMasterPrizeView.lua

module("logic.extensions.breachformmaster.view.BreachFormMasterPrizeView", package.seeall)

local BreachFormMasterPrizeView = class("BreachFormMasterPrizeView", ViewComponent)
local TABTYPE_BASE = 1
local TABTYPE_ATTACK = 2
local TABTYPE_DEFENSCE = 3
local DEFAULT_PRIZE_STEP = 2

function BreachFormMasterPrizeView:ctor()
	BreachFormMasterPrizeView.super.ctor(self)
end

function BreachFormMasterPrizeView:unbindEvents()
	BreachFormMasterPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBasePrize)
	GameUtil.rmClickHandler(self._btnAttackRank)
	GameUtil.rmClickHandler(self._btnRankPrize)
	GameUtil.rmClickHandler(self._btnDefenseRank)
end

function BreachFormMasterPrizeView:bindEvents()
	BreachFormMasterPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnBasePrize, self._onClickBasePrize, self)
	GameUtil.addClickHandler(self._btnAttackRank, self._onClickAttack, self)
	GameUtil.addClickHandler(self._btnRankPrize, self._onClickAttack, self)
	GameUtil.addClickHandler(self._btnDefenseRank, self._onClickDefense, self)
end

function BreachFormMasterPrizeView:buildUI()
	BreachFormMasterPrizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnBasePrize = self:getGo("btnBasePrize")
	self._txtSelectGoBase = self:getGo("btnBasePrize/txtSelectGo")
	self._txtNorGoBase = self:getGo("btnBasePrize/txtNorGo")
	self._imgSelectBase = self:getGo("btnBasePrize/imgSelect")
	self._imgSelectChangeBase = self._imgSelectBase:GetComponent(ComponentType.UIImageSpriteChange)
	self._btnRankPrize = self:getGo("btnRankPrize")
	self._txtSelectGoRank = self:getGo("btnRankPrize/txtSelectGo")
	self._txtNorGoRank = self:getGo("btnRankPrize/txtNorGo")
	self._imgSelectRank = self:getGo("btnRankPrize/imgSelect")
	self._imgSelectChangeRank = self._imgSelectRank:GetComponent(ComponentType.UIImageSpriteChange)
	self._dropLine = self:getGo("dropLine")
	self._btnAttackRank = self:getGo("btnAttackRank")
	self._imgNorAttack = self:getGo("btnAttackRank/imgNor")
	self._txtNorGoAttack = self:getGo("btnAttackRank/txtNorGo")
	self._txtSelectGoAttack = self:getGo("btnAttackRank/txtSelectGo")
	self._imgSelectAttack = self:getGo("btnAttackRank/imgSelect")
	self._btnDefenseRank = self:getGo("btnDefenseRank")
	self._imgNorDefense = self:getGo("btnDefenseRank/imgNor")
	self._txtNorGoDefense = self:getGo("btnDefenseRank/txtNorGo")
	self._txtSelectGoDefense = self:getGo("btnDefenseRank/txtSelectGo")
	self._imgSelectDefense = self:getGo("btnDefenseRank/imgSelect")
	self._rankInfo = self:getGo("rankInfo")
	self._baseInfo = self:getGo("baseInfo")
	self._prizeTablecell = self:getGo("prizeTablecell")
	self._prizetableview = self:getGo("baseInfo/tableview/viewport/content/prizetableview")
	self._prizeTableList = ScrollerList.create(self._prizetableview, self._prizeTablecell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._rankTablecell = self:getGo("rankInfo/rankTableview/rankTablecell")
	self._rankTableview = self:getGo("rankInfo/rankTableview")
	self._rankTableList = ScrollerList.create(self._rankTableview, self._rankTablecell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function BreachFormMasterPrizeView:onExit()
	BreachFormMasterPrizeView.super.onExit(self)

	for i, v in pairs(self._itemTableDir) do
		v:dispose()
	end

	self._itemTableDir = {}
end

function BreachFormMasterPrizeView:onEnter()
	BreachFormMasterPrizeView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())
	self._tabType = TABTYPE_BASE
	self._itemTableDir = {}

	self:_initBaseView()
	self:_onClickBasePrize()
end

function BreachFormMasterPrizeView:_initBaseView()
	local curStepId = BreachFormMasterModel.instance:getCurStepId(self._activityId)
	local stageCfg = BreachFormMasterConfig.instance:getStageCfg(self._activityId, curStepId, 1)
	local prizeArr = string.split(stageCfg.firstPassPrize, "#")

	self._prizeTableList:reloadData(prizeArr)
end

function BreachFormMasterPrizeView:_refreshView()
	self:_refreshTabBtn()

	local curStepId = 3

	GameUtil.SetActive(self._baseInfo, self._tabType == TABTYPE_BASE)
	GameUtil.SetActive(self._rankInfo, self._tabType ~= TABTYPE_BASE)

	local cfgs

	if self._tabType == TABTYPE_ATTACK then
		cfgs = BreachFormMasterConfig.instance:getAttackPrizeCfgs(self._activityId, curStepId)

		if not cfgs then
			BreachFormMasterConfig.instance:getAttackPrizeCfgs(self._activityId, DEFAULT_PRIZE_STEP)
		end
	else
		cfgs = BreachFormMasterConfig.instance:getDefenscPrizeCfgs(self._activityId, curStepId)

		if not cfgs then
			BreachFormMasterConfig.instance:getDefenscPrizeCfgs(self._activityId, DEFAULT_PRIZE_STEP)
		end
	end

	self._rankTableList:reloadData(cfgs)
end

function BreachFormMasterPrizeView:_refreshTabBtn()
	GameUtil.SetActive(self._txtSelectGoBase, self._tabType == TABTYPE_BASE)
	GameUtil.SetActive(self._txtNorGoBase, self._tabType ~= TABTYPE_BASE)
	self._imgSelectChangeBase:SetState(self._tabType == TABTYPE_BASE and 1 or 0)
	GameUtil.SetActive(self._txtSelectGoRank, self._tabType == TABTYPE_ATTACK or self._tabType == TABTYPE_DEFENSCE)
	GameUtil.SetActive(self._txtNorGoRank, self._tabType ~= TABTYPE_ATTACK and self._tabType ~= TABTYPE_DEFENSCE)
	self._imgSelectChangeRank:SetState((self._tabType == TABTYPE_ATTACK or self._tabType == TABTYPE_DEFENSCE) and 1 or 0)
	GameUtil.SetActive(self._dropLine, self._tabType == TABTYPE_ATTACK or self._tabType == TABTYPE_DEFENSCE)
	GameUtil.SetActive(self._btnAttackRank, self._tabType == TABTYPE_ATTACK or self._tabType == TABTYPE_DEFENSCE)
	GameUtil.SetActive(self._btnDefenseRank, self._tabType == TABTYPE_ATTACK or self._tabType == TABTYPE_DEFENSCE)
	GameUtil.SetActive(self._imgNorAttack, self._tabType ~= TABTYPE_ATTACK)
	GameUtil.SetActive(self._txtNorGoAttack, self._tabType ~= TABTYPE_ATTACK)
	GameUtil.SetActive(self._txtSelectGoAttack, self._tabType == TABTYPE_ATTACK)
	GameUtil.SetActive(self._imgSelectAttack, self._tabType == TABTYPE_ATTACK)
	GameUtil.SetActive(self._imgNorDefense, self._tabType ~= TABTYPE_DEFENSCE)
	GameUtil.SetActive(self._txtNorGoDefense, self._tabType ~= TABTYPE_DEFENSCE)
	GameUtil.SetActive(self._txtSelectGoDefense, self._tabType == TABTYPE_DEFENSCE)
	GameUtil.SetActive(self._imgSelectDefense, self._tabType == TABTYPE_DEFENSCE)
end

function BreachFormMasterPrizeView:_updatePrizeCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function BreachFormMasterPrizeView:_clearPrizeCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function BreachFormMasterPrizeView:_updateRankCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local bgChange = goutil.findChildComponent(go, "bg", ComponentType.UIImageColorChange)

	bgChange:SetState(data.id % 2 == 1 and 0 or 1)

	txtRank.text = data.rank[1] == data.rank[2] and langPara("第%s名", data.rank[1]) or langPara("第%s~%s名", data.rank[1], data.rank[2])

	local subTab = self._itemTableDir[cell.gameObject]

	if not subTab then
		local prizeCom = goutil.findChild(cell.gameObject, "prizeTableview")

		subTab = ScrollerList.create(prizeCom, self._prizeTablecell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

		subTab:dragNotifyParent()

		self._itemTableDir[cell.gameObject] = subTab
	end

	if data then
		if not data.prize then
			local prize = ""
			local itemList = string.split(prize, "#")

			subTab:reloadData(itemList)
			subTab:MoveCellToBegin(0)
		end
	end
end

function BreachFormMasterPrizeView:_clearRankCell(cell)
	return
end

function BreachFormMasterPrizeView:_onClickBasePrize()
	self._tabType = TABTYPE_BASE

	self:_refreshView()
end

function BreachFormMasterPrizeView:_onClickAttack()
	self._tabType = TABTYPE_ATTACK

	self:_refreshView()
end

function BreachFormMasterPrizeView:_onClickDefense()
	self._tabType = TABTYPE_DEFENSCE

	self:_refreshView()
end

return BreachFormMasterPrizeView
