-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaMissionView.lua

module("logic.extensions.arena.view.ArenaMissionView", package.seeall)

local ArenaMissionView = class("ArenaMissionView", MissionView)

function ArenaMissionView:ctor()
	ArenaMissionView.super.ctor(self)
end

function ArenaMissionView:onEnter()
	self:onEnterInherit()
	self:_setMaskBlock(false)
	self:procMid()
	ArenaController.instance:registerLocalNotify("ChallengeCdChange", self._refreshClgCD, self)
	settimer(0, self.Update, self, true)
end

function ArenaMissionView:onExit()
	ArenaMissionView.super.onExit(self)
	self:stopCool()
	ArenaController.instance:unregisterLocalNotify("ChallengeCdChange", self._refreshClgCD, self)
	removetimer(self.Update, self)
end

function ArenaMissionView:procMid()
	self:_setDescStr(lang("竞技场"), "", lang("击败所有敌方精灵可获得胜利"))
	self:_refreshClgCD()

	self._txtCd.text = ""
end

function ArenaMissionView:_refreshClgCD()
	local leftTime = ArenaModel.instance:getChallengeCdEndTime() - ServerTime.now()

	if leftTime <= 0 and (not self._isClgCd or true) then
		self._isClgCd = false
		self._txtCd.text = ""
	else
		if not self._isClgCd then
			-- block empty
		end

		self._isClgCd = true

		local hour, min, sec = GameUtil.getTimeHHMMSS(leftTime)

		self._txtCd.text = leftTime > 3600 and langPara("%d时%d分%d秒", hour, min, sec) or leftTime > 60 and langPara("%d分%d秒", min, sec) or langPara("%d秒", leftTime)
	end
end

function ArenaMissionView:Update()
	if self._isClgCd then
		self:_refreshClgCD()
	end
end

function ArenaMissionView:_startNow()
	GlobalDispatcher:removeListener(GlobalNotify.FormationRefresh, self._startNow, self)
	self:_setMaskBlock(true)
	self:_setBattleResultTxtTitle()
	ArenaController.instance:startArenaFight(ArenaModel.instance:getCurChallengerPos())
end

function ArenaMissionView:_onClickStart()
	if self.isCool then
		FloatWordMgr.instance:show("冷却中")

		return
	end

	self:starCool()
	ArenaMissionView.super._onClickStart(self)
end

function ArenaMissionView:starCool()
	self.isCool = true

	settimer(0.5, self.stopCool, self)
end

function ArenaMissionView:stopCool()
	self.isCool = false

	removetimer(self.stopCool, self)
end

return ArenaMissionView
