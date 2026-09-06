-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelinvestor/view/AngelInvestorFightView.lua

module("logic.extensions.angelinvestor.view.AngelInvestorFightView", package.seeall)

local AngelInvestorFightView = class("AngelInvestorFightView", ViewComponent)

function AngelInvestorFightView:ctor()
	AngelInvestorFightView.super.ctor(self)
end

function AngelInvestorFightView:unbindEvents()
	AngelInvestorFightView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function AngelInvestorFightView:bindEvents()
	AngelInvestorFightView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function AngelInvestorFightView:buildUI()
	AngelInvestorFightView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function AngelInvestorFightView:onExit()
	AngelInvestorFightView.super.onExit(self)
	self._scrollList:dispose()
end

function AngelInvestorFightView:onEnter()
	AngelInvestorFightView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 588001
	end

	self._info = AngelInvestorModel.instance:getInfo(self._activityId)
	self._actCfg = AngelInvestorConfig.instance:getActivityCfg(self._activityId)
	self._stageCfgs = AngelInvestorConfig.instance:getStageCfgs(self._activityId)
	self._stageReviveCountMap = AngelInvestorModel.instance:getStageReviveCountMap(self._activityId)

	local stageMaxReviveCounts = self._info and checktable(self._info.stageMaxReviveCounts) or {}

	self._scrollList:reloadData(stageMaxReviveCounts)
end

function AngelInvestorFightView:_updateCell(view, cell, data)
	local stageFmt = goutil.findChild(cell, "stageFmt/fmt")
	local btnChallenge = goutil.findChild(cell, "btnChallenge")
	local txtStage = goutil.findChildTextComponent(cell, "stage/txtStage")
	local txtBuff = goutil.findChildTextComponent(cell, "txtBuff")
	local stageCfg = self._stageCfgs[data.left]
	local creepsMasterId = stageCfg.creepsMasterId
	local creepsCfg = AngelInvestorConfig.instance:getCreepsCfgs(creepsMasterId)
	local reviveCount = self._stageReviveCountMap and checknumber(self._stageReviveCountMap[stageCfg.stageId]) or 0
	local revivePower = self._actCfg and checknumber(self._actCfg.revivePower) or 0
	local totalPower = reviveCount * revivePower

	self:_setFmt(stageFmt, creepsCfg)

	txtStage.text = string.format("第%d关", stageCfg.stageId)
	txtBuff.text = string.format("已复活%s只\n获得%s能量", reviveCount, totalPower)

	GameUtil.addClickHandler(btnChallenge, function()
		AngelInvestorController.instance:enterBattleClg(self._activityId, stageCfg.stageId)
	end, self)
end

function AngelInvestorFightView:_clearCell(cell)
	local stageFmt = goutil.findChild(cell, "stageFmt/fmt")
	local btnChallenge = goutil.findChild(cell, "btnChallenge")

	GameUtil.rmClickHandler(btnChallenge)
	self:_clearFmt(stageFmt)
end

function AngelInvestorFightView:_setFmt(fmtView, cfg)
	local map = {}

	for _, data in ipairs(cfg) do
		map[data.posId] = data
	end

	for posId = 1, 9 do
		local creepsData = map[posId]
		local go = fmtView.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")

		MaterialMgr.clearIcon(con)
		GameUtil.SetActive(go, false)

		if creepsData then
			MaterialMgr.setIcon(con, MatType.PET_SKIN, (checknumber(creepsData.faceId) > 0 or nil) and checknumber(creepsData.faceId))
			GameUtil.SetActive(go, true)
			GameUtil.SetActive(con, true)
		end
	end
end

function AngelInvestorFightView:_clearFmt(fmt)
	for posId = 1, 9 do
		local go = fmt.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")

		MaterialMgr.clearIcon(con)
	end
end

function AngelInvestorFightView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

return AngelInvestorFightView
