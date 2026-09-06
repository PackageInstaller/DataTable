-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManLinkGameEndlessView.lua

module("logic.extensions.linkgame.view.BeastRichManLinkGameEndlessView", package.seeall)

local BeastRichManLinkGameEndlessView = class("BeastRichManLinkGameEndlessView", LinkGameEndlessView)

function BeastRichManLinkGameEndlessView:onEnter()
	self.addGEvent(self, GlobalNotify.PopupImageRuleClose, self._onCloseRuleView, self)
	self.addGEvent(self, GlobalNotify.BeastRichManHandleGridRes, self._onHandleGridRes, self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._zoneId = checknumber(params[2])
	self._gridId = checknumber(params[3])
	self._gameId = 1
	self._ruleId = 1
	self._gameTime = 60
	self._pairs = 0

	GameUtil.SetActive(self._cell, false)

	self._isSelecting = true
	self._cellPools = {}

	self:setMapData()
	self:_genarateMap()

	self._txtTime.text = lang("游戏尚未开始")
	self._txtPairs.text = lang("已消除对数：<color=#63EFF7FF>0</color>")

	if not LinkGameModel.instance:getIsReadRule(self._gameId) then
		self._isFirstReadRule = true

		self:_onClickRule()
		LinkGameModel.instance:setIsReadRule(self._gameId)
	else
		self._isFirstReadRule = false

		self:_readyStartGame()
	end
end

function BeastRichManLinkGameEndlessView:getCellSize()
	return {
		x = 136,
		y = 136
	}
end

function BeastRichManLinkGameEndlessView:_endGame()
	self._isSelecting = true

	local removePairs = self:_getCurRemovePairs()

	if self._isOnTime == true then
		local desc = string.format("成功消除对数%s", removePairs)

		TipsFacade.instance:openTipWindow("游戏结束", desc, function()
			local isPass = self._isOnTime == true

			self:_doFinfishCallBack(isPass, removePairs)
		end)
	else
		self:_doFinfishCallBack(false, removePairs)
		self:close()
	end
end

function BeastRichManLinkGameEndlessView:_doFinfishCallBack(isPass, removePairs)
	if isPass then
		local totalScore = removePairs
		local tb = {
			onekey = false,
			annual = false,
			score = totalScore
		}
		local param = GameUtil.jsonToString(tb)

		BeastRichmanController.instance:sendPM_BeastRichManHandleGridReq(self._activityId, self._zoneId, self._gridId, param)
	end
end

function BeastRichManLinkGameEndlessView:_onHandleGridRes()
	BeastRichmanController.instance:tryPopCurScore(self._activityId)
	self:close()
end

return BeastRichManLinkGameEndlessView
