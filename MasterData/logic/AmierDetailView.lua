-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/amier/AmierDetailView.lua

module("logic.extensions.timelimitedchallenge.view.amier.AmierDetailView", package.seeall)

local AmierDetailView = class("AmierDetailView", TimeLimitedDetailView)

function AmierDetailView:buildUI()
	AmierDetailView.super.buildUI(self)

	self._challengeId = 5
	self._imgNum = goutil.findChildComponent(self.mainGO, "imgNum", typeof(UIImgNumeralText))
	self._btnTip = self:getBtn("btnTip")
end

function AmierDetailView:bindEvents()
	AmierDetailView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function AmierDetailView:unbindEvents()
	AmierDetailView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
end

function AmierDetailView:_onClickTip()
	TipsFacade.instance:openTipWindow("提示", lang("amier_detail_tip"))
end

function AmierDetailView:_updateUI()
	AmierDetailView.super._updateUI(self)
	self._imgNum:SetText(self._info.hasChallengeCircle + 1)
end

function AmierDetailView:_updateOneRoundCell(cell, data)
	local idx = 0

	for k, v in ipairs(self._cfgs) do
		if v == data then
			idx = k

			break
		end
	end

	local txtTitle = goutil.findChildTextComponent(cell, "txt")

	txtTitle.text = string.format("第%d轮\n战斗", idx)

	local imgSelect = goutil.findChild(cell, "imgSelect")

	imgSelect:SetActive(self._curRound == idx)

	local imgState = goutil.findChild(cell, "imgState")

	imgState:SetActive(idx < self._curRound)

	local txtBattleState = goutil.findChildTextComponent(cell, "txtBattleState")

	txtBattleState.text = "未战斗"

	local imgBattle = goutil.findChild(cell, "imgBattle")

	txtBattleState.gameObject:SetActive(false)
	imgBattle:SetActive(false)

	if self._curRound == idx then
		imgBattle:SetActive(true)
	elseif idx > self._curRound then
		txtBattleState.gameObject:SetActive(true)
	end
end

return AmierDetailView
