-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/burygame/view/BuryGameRankView.lua

module("logic.extensions.burygame.view.BuryGameRankView", package.seeall)

local BuryGameRankView = class("BuryGameRankView", LightKingRankView)

function BuryGameRankView:onExit()
	BuryGameRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.BuryRankInfoRes, self._onRankInfoRes, self)
end

function BuryGameRankView:buildUI()
	BuryGameRankView.super.buildUI(self)

	self._txtTitle = self:getTxt("title/txtTitle")

	local ruleCfg = RulesConfig.instance:getRuleCo("burygamegate3")
	local rankThreshold = BuryGameConfig.instance:getConstantValue("RANK_THRESHOLD")

	self._txtTip.text = string.format(ruleCfg.rules, rankThreshold)
end

function BuryGameRankView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.BuryRankInfoRes, self._onRankInfoRes, self)
	BuryGameController.instance:sendGetRankInfoReq()
end

function BuryGameRankView:_onRankInfoRes()
	print("_onRankInfoRes")

	local rankInfo = BuryGameModel.instance:getRankInfo()

	self._curViewDatas = rankInfo.rankList or {}

	local myRank = checknumber(rankInfo.myRank)

	self._txtMyRank.text = myRank > 0 and myRank or lang("未上榜")

	self._goEmpty:SetActive(#self._curViewDatas == 0)
	self:reloadData()
end

function BuryGameRankView:_updateCell(view, cell, data)
	BuryGameRankView.super._updateCell(self, view, cell, data)

	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtTime")

	txtDesc.text = data.score
end

return BuryGameRankView
