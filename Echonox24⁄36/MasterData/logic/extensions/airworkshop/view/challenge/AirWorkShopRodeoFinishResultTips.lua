-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/challenge/AirWorkShopRodeoFinishResultTips.lua

module("logic.extensions.airworkshop.view.challenge.AirWorkShopRodeoFinishResultTips", package.seeall)

local M = class("AirWorkShopRodeoFinishResultTips", ViewComponent)

M.State = {
	Abandon = 3,
	Fail = 2,
	Win = 1
}

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnClose = self:getBtn("air_workshop_sports_calculate_tips_911618446")
	self._btnConfirm = self:getBtnByPath("content/btnConfirm")
	self._txtWinCount = self:getText("air_workshop_sports_calculate_tips_973672927")
	self._txtCurRoundTotalScore = self:getText("air_workshop_sports_calculate_tips_-336053523")
	self._txtWeekMaxScore = self:getText("air_workshop_sports_calculate_tips_598094442")
	self._cellRound = {}

	local goItemRoot = self:getUIComponent("air_workshop_sports_calculate_tips_686938782", UIComponentType.RectTransform)

	for i = 0, goItemRoot.childCount - 1 do
		local _round = i + 1
		local _go = goItemRoot:GetChild(i).gameObject

		table.insert(self._cellRound, self:_buildRoundItemCell(_go, _round))
	end
end

function M:destroyUI()
	self._cellRound = nil
end

function M:bindEvents()
	self._btnConfirm:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnConfirm:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)
	self:refreshView()
end

function M:onExit()
	self:setEvent(false)
	AirWorkBattleResultController.instance:setRodeoFinishData(nil)

	local info = self:getFirstParam() or {}

	if info.exitFunc then
		if info.exitHandler then
			info.exitFunc(info.exitHandler)
		else
			info.exitFunc()
		end
	end
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:_onClickClose()
	self:close()
end

function M:_buildRoundItemCell(go, round)
	local cell = {
		go = go,
		round = round,
		goWin = goutil.findChild(go, "imgWin").gameObject,
		goFail = goutil.findChild(go, "imgLose").gameObject,
		goAbandon = goutil.findChild(go, "imgAbandon").gameObject,
		goIsReborn = goutil.findChild(go, "txtRevive").gameObject,
		txtRound = goutil.findChildComponent(go, "txtNumber", UIComponentType.Text),
		txtScore = goutil.findChildComponent(go, "imgIcon/txtStore", UIComponentType.Text)
	}

	return cell
end

function M:refreshView()
	local info = self:getFirstParam() or {}
	local roundList = info.roundList
	local len = roundList and #roundList or 0

	if len == 0 then
		self:close()
	end

	local winCount = 0
	local totalScore = 0

	for index, cell in ipairs(self._cellRound or {}) do
		local data = roundList[index]
		local state = M.State.Abandon
		local isReborn = false
		local score = "---"
		local scoreColor = "#B6B7B7"

		if data then
			state = data.win and M.State.Win or M.State.Fail
			isReborn = data.useLife

			if data.score >= 0 then
				score = string.format("+%s", data.score)
				scoreColor = "#D2833A"
			else
				score = data.score
			end

			if data.win then
				winCount = winCount + 1
			end

			totalScore = totalScore + data.score
		end

		cell.txtRound.text = langF("the_x_session", index)
		cell.txtScore.text = score
		cell.txtScore.color = parsecolor(scoreColor)

		goutil.setActive(cell.goWin, state == M.State.Win)
		goutil.setActive(cell.goFail, state == M.State.Fail)
		goutil.setActive(cell.goAbandon, state == M.State.Abandon)
		goutil.setActive(cell.goIsReborn, isReborn)
	end

	self._txtWinCount.text = winCount
	self._txtCurRoundTotalScore.text = totalScore

	local challengeMo = AirWorkShopChallengeModel.instance:getPlayerInfoMo()
	local maxOfWeek = challengeMo and challengeMo:getMaxOfWeek() or 0

	maxOfWeek = maxOfWeek < totalScore and totalScore or maxOfWeek
	self._txtWeekMaxScore.text = maxOfWeek
end

return M
