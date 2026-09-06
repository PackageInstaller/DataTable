-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/AceteambossView.lua

module("logic.extensions.aceteam.view.AceteambossView", package.seeall)

local AceteambossView = class("AceteambossView", ViewComponent)

function AceteambossView:ctor()
	AceteambossView.super.ctor(self)
end

function AceteambossView:unbindEvents()
	AceteambossView.super.unbindEvents(self)
	self._btnChallenge:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function AceteambossView:bindEvents()
	AceteambossView.super.bindEvents(self)
	self._btnChallenge:AddClickListener(self._onClickbtnChallenge, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function AceteambossView:buildUI()
	AceteambossView.super.buildUI(self)

	self._btnChallenge = self:getBtn("btnChallenge")
	self._btnClose = self:getBtn("btnClose")
	self._roleModelGo = self:getGo("roleModel")
	self._txtRoleName = goutil.findChildTextComponent(self.mainGO, "name/txtName")
	self._txtBossLeftTime = goutil.findChildTextComponent(self.mainGO, "leavetime/txtTime")
	self._txtRule = goutil.findChildTextComponent(self.mainGO, "rule/txtRule")
	self._txtLeavetimeTitle = goutil.findChildTextComponent(self.mainGO, "leavetime/txtTitle")
	self._txtPrizeDesc = goutil.findChildTextComponent(self.mainGO, "prize/txtRule")
	self._txtPrizeTitle = goutil.findChildTextComponent(self.mainGO, "prize/txtTitle")
	self._txtRuleTitle = goutil.findChildTextComponent(self.mainGO, "rule/txtTitle")
	self._txtBossCount = goutil.findChildTextComponent(self.mainGO, "txtBossCount")
	self._txtChallengeCount = goutil.findChildTextComponent(self.mainGO, "txtChallengeCount")
	self._goldBarCon = self:getGo("goldBarCon")
end

function AceteambossView:onExit()
	AceteambossView.super.onExit(self)
	RoleObjectPool.instance:removeRole(self._roleObj)
	removetimer(self._updateTimer, self)
end

function AceteambossView:onEnter()
	AceteambossView.super.onEnter(self)

	self._creepsMasterId = AceTeamModel.instance:getCurrBossId()
	self._monsterCfg = AceTeamConfig.instance:getMonsterCfg(self._creepsMasterId)

	if not self._monsterCfg then
		self:close()
		printError("不存在的bossId：", self._creepsMasterId)

		return
	end

	self._dailyBossMetTimes = AceTeamConfig.instance:getCommonValue("DAILY_TRIGGER_BOSS_TIMES", true)

	self:_setRole()
	self:_updateUI()

	local btnList = {
		{
			showAdd = true,
			id = MaterialMgr.createSerName(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT),
			showAddCallBack = function()
				AceTeamController.instance:sendAddPointCount()
			end
		},
		{
			showAdd = false,
			id = AceTeamConfig.instance:getCommonValue("MAIN_TOP_ITEM")
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btnList)
end

function AceteambossView:_onClickbtnChallenge()
	local currBossCanBattleTime = self._monsterCfg.challengeTimes

	if currBossCanBattleTime <= self._curBossBattleTime then
		FloatWordMgr.instance:show("该boss挑战达到上限")

		return
	end

	UIStateManager.instance:push(ViewName.AceteamMissionView, self._creepsMasterId)
end

function AceteambossView:_onClickbtnClose()
	self:close()
end

function AceteambossView:_setRole()
	local skinId = self._monsterCfg.raceId
	local displayBagOffset = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, skinId, self._roleModelGo, scale, nil, true, x, y)
	self._txtRoleName.text = self._monsterCfg.name
end

function AceteambossView:_updateUI()
	self:_setBossLeftTime()
	self:_setRuleDesc()
	self:_setPrizeDesc()
	self:_updateTodayBattleTime()
	self:_updateCurrBossBattleTime()
end

function AceteambossView:_setBossLeftTime()
	local nowTime = ServerTime.nowServerLook()
	local date = GameUtil.time2date(nowTime)
	local endTimeStr = AceTeamConfig.instance:getCommonValue("DAILY_END_TIME")
	local nums = string.split(endTimeStr, ":")
	local endHour, endMin, endSec = checknumber(nums[1]), checknumber(nums[2]), checknumber(nums[3])

	self._destTime = endHour > date.hour and GameUtil.date2time(date.year, date.month, date.day, endHour, 0, 0) or GameUtil.date2time(date.year, date.month, date.day + 1, endHour, 0, 0)

	if self._destTime > 0 then
		settimer(1, self._updateTimer, self, true)
		self:_updateTimer()
	else
		self:_actEndOp()
	end
end

function AceteambossView:_updateTimer()
	self._leftTime = self._destTime - ServerTime.nowServerLook()

	if self._leftTime > 0 then
		self._txtBossLeftTime.text = self:_formatLeftTimeStr(self._leftTime)
	else
		self:_actEndOp()
	end
end

function AceteambossView:_formatLeftTimeStr(leftTime)
	local d, h, m, s = GameUtil.getTimeDDHHMMSS(leftTime)
	local hstr = h
	local mstr = m
	local sstr = s

	if h < 10 then
		hstr = "0" .. h
	end

	if m < 10 then
		mstr = "0" .. m
	end

	if s < 10 then
		sstr = "0" .. s
	end

	return d > 0 and string.format("时间剩余：%s天%s时%s分", d, hstr, mstr) or h > 0 and string.format("时间剩余：%s时%s分%s秒", hstr, mstr, sstr) or string.format("时间剩余：%s分%s秒", mstr, sstr)
end

function AceteambossView:_actEndOp()
	self._txtBossLeftTime.text = "BOSS已离开"

	removetimer(self._updateTimer, self)
end

function AceteambossView:_setRuleDesc()
	local challengeTimes = self._monsterCfg.challengeTimes

	self._txtRule.text = langPara("aceteambossview__1", challengeTimes)
end

function AceteambossView:_setPrizeDesc()
	local a, b, c, d = self._monsterCfg.winScoreNum, self._monsterCfg.winMedalNum, self._monsterCfg.loseScoreNum, self._monsterCfg.loseMedalNum

	self._txtPrizeDesc.text = langPara("aceteambossview__2", a, b, c, d)
end

function AceteambossView:_updateTodayBattleTime()
	self._curBossBattleTime = AceTeamModel.instance:getBossHasFightTimes()
	self._txtChallengeCount.text = string.format("已战斗次数：<color=#CD7800FF>%s</color>/%s", self._curBossBattleTime, self._monsterCfg.challengeTimes)
end

function AceteambossView:_updateCurrBossBattleTime()
	self._todayBossBattleTime = AceTeamModel.instance:getBossHasMetTimes()
	self._txtBossCount.text = string.format("今日已遭遇BOSS战：<color=#CD7800FF>%s</color>/%s次", self._todayBossBattleTime, self._dailyBossMetTimes)
end

return AceteambossView
