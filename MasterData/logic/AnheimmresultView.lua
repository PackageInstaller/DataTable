-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/anheimm/AnheimmresultView.lua

module("logic.extensions.timelimitedchallenge.view.anheimm.AnheimmresultView", package.seeall)

local AnheimmresultView = class("AnheimmresultView", TLCBattleResultView)

function AnheimmresultView:unbindEvents()
	AnheimmresultView.super.unbindEvents(self)
	self._btnOk:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnReGame:RemoveClickListener()
end

function AnheimmresultView:bindEvents()
	AnheimmresultView.super.bindEvents(self)
	self._btnOk:AddClickListener(self._onClickOk, self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnReGame:AddClickListener(self._onClickReGame, self)
end

function AnheimmresultView:buildUI()
	self._txtTitle = self:getTxt("txtTitle")
	self._btnOk = self:getBtn("btnGroup/btnOk")
	self._btnCancel = self:getBtn("btnGroup/btnCancel")
	self._btnReGame = self:getBtn("btnGroup/btnReGame")
	self._txtOk = goutil.findChildTextComponent(self._btnOk.gameObject, "Text")
	self._txtCancel = goutil.findChildTextComponent(self._btnCancel.gameObject, "Text")
	self._txtWin = self:getTxt("win/Text")
	self._winTrue = self:getGo("win/true")
	self._winFalse = self:getGo("win/false")
	self._txtPerfect = self:getTxt("perfectWin/Text")
	self._perfectTrue = self:getGo("perfectWin/true")
	self._perfectFalse = self:getGo("perfectWin/false")
	self._failure = self:getGo("failure")
	self._txtTips = self:getTxt("txtTips")
	self._rewards = self:getGo("rewards")
	self._itemsView = self:getGo("rewards/itemsView/Viewport/Content").transform
	self._itemsLayout = self:getGo("rewards/itemsView/Viewport/Content/items"):GetComponent(typeof(UILayoutMulLines))
end

function AnheimmresultView:onEnter()
	self._cells = {}

	local isWin = AnheimmModel.instance:getIsWin()
	local isPerfectWin = AnheimmModel.instance:getIsPerfectWin()

	self._failure:SetActive(not isWin)
	self._rewards:SetActive(isWin)
	self._winTrue:SetActive(isWin)
	self._winFalse:SetActive(not isWin)
	self._perfectTrue:SetActive(isPerfectWin)
	self._perfectFalse:SetActive(not isPerfectWin)

	local ruleId = AnheimmModel.instance:getCurRuleId()
	local ruleCfg = AnheimmConfig.instance:getRuleCfgById(ruleId)

	self._txtPerfect.text = ruleCfg.missionDesc
	self._txtTips.text = ""

	self._btnCancel.gameObject:SetActive(false)
	self._btnOk.gameObject:SetActive(false)
	self._btnReGame.gameObject:SetActive(false)

	if not isWin then
		self._txtTitle.text = "战斗失败"

		self._btnCancel.gameObject:SetActive(true)
	else
		self._txtTitle.text = "战斗胜利"

		local modeId = AnheimmModel.instance:getCurModeId()
		local modeCfg = AnheimmConfig.instance:getModeCfgById(modeId)
		local itemStr = ""
		local items = {}

		self._btnOk.gameObject:SetActive(true)

		if isPerfectWin then
			itemStr = modeCfg.perfectPassPrize
		else
			self._txtTips.text = "未达到完美通关可重新挑战不消耗次数"

			self._btnReGame.gameObject:SetActive(true)

			itemStr = modeCfg.normalPassPrize
		end

		for _, v in ipairs(string.split(itemStr, "#")) do
			local array = string.splitToNumber(v, ":")
			local data = {}

			data.type = array[1]
			data.id = array[2]
			data.num = array[3]

			table.insert(items, data)
		end

		self:_updateRewards(items)
	end

	self._isWin = isWin
	self._isPerfectWin = isPerfectWin
end

function AnheimmresultView:onExit()
	AnheimmresultView.super.onExit(self)
end

function AnheimmresultView:_onClickOk()
	if self._isWin and not self._isPerfectWin then
		AnHeiMMChallengeAgent.instance:sendPM_AnHeiMMChallengeConfirmResultReq(self._onConfirmResult, self)
	else
		self:_closeResultView()
	end
end

function AnheimmresultView:_onClickCancel()
	AnheimmController.instance:setNeedOpenRuleView(true)
	self:_closeResultView()
end

function AnheimmresultView:_onClickReGame()
	AnheimmController.instance:setNeedOpenRuleView(true)
	self:_closeResultView()
end

function AnheimmresultView:_onConfirmResult(msg)
	AnheimmModel.instance:updateChallengeTimes(msg.todayChallengeTimes)

	if checknumber(msg.changeSetId) > 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		AnheimmModel.instance:setChangeSetId(msg.changeSetId)
	end

	self:_closeResultView()
end

function AnheimmresultView:_closeResultView()
	BattleController.instance:endBattle()
end

return AnheimmresultView
