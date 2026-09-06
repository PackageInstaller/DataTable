-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/view/AnnualFubenCombineView.lua

module("logic.extensions.annualfuben.view.AnnualFubenCombineView", package.seeall)

local AnnualFubenCombineView = class("AnnualFubenCombineView", ViewComponent)

function AnnualFubenCombineView:ctor()
	AnnualFubenCombineView.super.ctor(self)
end

function AnnualFubenCombineView:unbindEvents()
	AnnualFubenCombineView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnEnter)
	GameUtil.rmClickHandler(self._btnTip)
end

function AnnualFubenCombineView:bindEvents()
	AnnualFubenCombineView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickEnter, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)

	for i, v in ipairs(self._downGoList) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._onClickDown, self, i))
	end
end

function AnnualFubenCombineView:buildUI()
	AnnualFubenCombineView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._clueTableCell = self:getGo("clueTableCell")
	self._clueTableview = self:getGo("clueTableview")
	self._clueTableList = ScrollerList.create(self._clueTableview, self._clueTableCell, GameUtil.handler(self._updateClueCell, self), GameUtil.handler(self._clearClueCell, self))
	self._btnClose = self:getGo("btnClose")
	self._btnEnter = self:getGo("btnEnter")
	self._btnTip = self:getGo("btnTip")
	self._downGoList = {}

	for i = 1, 3 do
		local go = self:getGo("down_" .. i)

		table.insert(self._downGoList, go)
	end
end

function AnnualFubenCombineView:onExit()
	AnnualFubenCombineView.super.onExit(self)
	self._clueTableList:dispose()
end

function AnnualFubenCombineView:onEnter()
	AnnualFubenCombineView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_FusionSoulCombineClueRes, self._PM_FusionSoulCombineClueRes, self)
	self.addGEvent(self, GlobalNotify.FusionSoulAddTip, self._onAddClue, self)

	self._activityId = checknumber(self:getFirstParam())
	self._selectClueIds = {}

	self:_refreshView()
end

function AnnualFubenCombineView:_refreshView()
	self._gainClueIdMap = AnnualFubenController.instance:getAllGainClueIds(self._activityId)

	local cfgs = AnnualFubenConfig.instance:getClueCfgs(self._activityId)

	self._clueTableList:reloadData(cfgs)
	self:_refreshDown()
end

function AnnualFubenCombineView:_refreshDown()
	for i, v in ipairs(self._downGoList) do
		local txt = goutil.findChildTextComponent(v, "txt")
		local img = goutil.findChild(v, "img")
		local clueId = self._selectClueIds[i]

		if clueId then
			local cfg = AnnualFubenConfig.instance:getClueCfg(self._activityId, clueId) or {}

			txt.text = cfg.name

			GameUtil.SetActive(img, true)
		else
			txt.text = ""

			GameUtil.SetActive(img, false)
		end
	end

	GameUtil.SetGray(self._btnEnter, #self._selectClueIds == 0 or AnnualFubenController.instance:isCollectAllClue(self._activityId))
end

function AnnualFubenCombineView:_updateClueCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txt")
	local btn = go
	local lock = goutil.findChild(go, "lock")

	if not self._gainClueIdMap[data.clueId] then
		local gainClue = false

		txtName.text = gainClue == true and data.name or "?"

		GameUtil.SetActive(lock, not gainClue)
		GameUtil.SetActive(txtName, gainClue)
		GameUtil.rmClickHandler(btn)
		GameUtil.addClickHandler(btn, function()
			self:_onClickClue(data.clueId)
		end)
	end
end

function AnnualFubenCombineView:_clearClueCell(cell)
	local btn = cell.gameObject

	GameUtil.rmClickHandler(btn)
end

function AnnualFubenCombineView:_onAddClue(clueId)
	if #self._selectClueIds < #self._downGoList then
		if table.indexof(self._selectClueIds, clueId) == false then
			table.insert(self._selectClueIds, clueId)
			self:_refreshDown()
		end
	else
		FloatWordMgr.instance:show(lang("已达可选上限"))
	end
end

function AnnualFubenCombineView:_onClickClue(clueId)
	if self._gainClueIdMap[clueId] == true then
		UIStateManager.instance:push(ViewName.AnnualFubenClueTipView, self._activityId, clueId)
	else
		FloatWordMgr.instance:show(lang("未获得该线索"))
	end
end

function AnnualFubenCombineView:_onClickDown(idx)
	table.remove(self._selectClueIds, idx)
	self:_refreshDown()
end

function AnnualFubenCombineView:_onClickEnter()
	if #self._selectClueIds <= 0 then
		FloatWordMgr.instance:show(lang("请填入线索"))
	elseif AnnualFubenController.instance:isCollectAllClue(self._activityId) == true then
		FloatWordMgr.instance:show(lang("已完成所有委托，无法关联"))
	else
		AnnualFubenController.instance:sendPM_AnnualFubenFormulaReq(self._activityId, self._selectClueIds)
	end
end

function AnnualFubenCombineView:_onClickTip()
	TipsFacade.instance:openRulesView("annual_fuben_chapter_one_rule")
end

function AnnualFubenCombineView:_PM_FusionSoulCombineClueRes(isCombineCorrect, clueId)
	if isCombineCorrect == true then
		self._selectClueIds = {}

		self:_refreshView()

		local clueCfg = AnnualFubenConfig.instance:getClueCfg(self._activityId, clueId)

		FloatWordMgr.instance:show(langPara("获得新线索%s", clueCfg.name))
		UIStateManager.instance:push(ViewName.AnnualFubenClueTipView, self._activityId, clueId)
	end
end

return AnnualFubenCombineView
