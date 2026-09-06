-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AoQiAttackForceMainView.lua

module("logic.extensions.aoqiattackforce.view.AoQiAttackForceMainView", package.seeall)

local AoQiAttackForceMainView = class("AoQiAttackForceMainView", ViewComponent)

function AoQiAttackForceMainView:ctor()
	AoQiAttackForceMainView.super.ctor(self)
end

function AoQiAttackForceMainView:unbindEvents()
	AoQiAttackForceMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClg1)
	GameUtil.rmClickHandler(self._btnClg2)
	GameUtil.rmClickHandler(self._btnClg3)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnJump5)
	GameUtil.rmClickHandler(self._btnJump6)
end

function AoQiAttackForceMainView:bindEvents()
	AoQiAttackForceMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnClg1, self._onClickBtnClg1, self)
	GameUtil.addClickHandler(self._btnClg2, self._onClickBtnClg2, self)
	GameUtil.addClickHandler(self._btnClg3, self._onClickBtnClg3, self)
	GameUtil.addClickHandler(self._btnJump1, self._onClickBtnJump1, self)
	GameUtil.addClickHandler(self._btnJump2, self._onClickBtnJump2, self)
	GameUtil.addClickHandler(self._btnJump3, self._onClickBtnJump3, self)
	GameUtil.addClickHandler(self._btnJump4, self._onClickBtnJump4, self)
	GameUtil.addClickHandler(self._btnJump5, self._onClickBtnJump5, self)
	GameUtil.addClickHandler(self._btnJump6, self._onClickBtnJump6, self)
end

function AoQiAttackForceMainView:buildUI()
	AoQiAttackForceMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClg1 = self:getGo("clgBtnCol/btnClg1/btn")
	self._txtDescClg1 = self:getTxt("clgBtnCol/btnClg1/desc/txt")
	self._iconDescClg1 = self:getGo("clgBtnCol/btnClg1/desc/txt/icon")
	self._btnClg2 = self:getGo("clgBtnCol/btnClg2/btn")
	self._descClg2 = self:getTxt("clgBtnCol/btnClg2/desc")
	self._txtDescClg2 = self:getTxt("clgBtnCol/btnClg2/desc/txt")
	self._descTimeClg2 = self:getGo("clgBtnCol/btnClg2/descTime")
	self._txtDescTimeClg2 = self:getTxt("clgBtnCol/btnClg2/descTime/txt")
	self._btnClg3 = self:getGo("clgBtnCol/btnClg3/btn")
	self._descClg3Go = self:getGo("clgBtnCol/btnClg3/desc")
	self._txtDescClg3 = self:getTxt("clgBtnCol/btnClg3/desc/txt")
	self._txtPrizeNumClg3 = self:getTxt("clgBtnCol/btnClg3/prize/txtNum")
	self._prizeConClg3 = self:getGo("clgBtnCol/btnClg3/prize/con")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._btnJump5 = self:getGo("jumpBtnCol/btnJump5")
	self._btnJump6 = self:getGo("jumpBtnCol/btnJump6")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._redPoint3 = self:getGo("jumpBtnCol/btnJump3/redPoint")
end

function AoQiAttackForceMainView:onExit()
	AoQiAttackForceMainView.super.onExit(self)
	uGuiUtil.clearImage(self._iconDescClg1)
	MaterialMgr.resetAll(self._prizeConClg3)
	RedPointController.instance:unregRedPoint(self._redPoint3)
end

function AoQiAttackForceMainView:onEnter()
	AoQiAttackForceMainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 436001
	end

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self:_updateByCfg()
	self.addGEvent(self, GlobalNotify.AQAFGetInfoRes, self._updateByInfo, self)
	AoQiAttackForceController.instance:getInfo(self._activityId)
	RedPointController.instance:regRedPoint(self._redPoint3, 625)

	local userDataKey = "AoQiAttackForceMainView_first_open_" .. self._activityId

	if checknumber(GameUtil.getUserDayData(userDataKey)) <= 0 then
		GameUtil.saveUserDayData(userDataKey, 1)
		self:_onClickBtnJump1()
	end
end

function AoQiAttackForceMainView:_updateByCfg()
	self._actCfg = AoQiAttackForceConfig.instance:getActivityCfg(self._activityId)
	self._finalCfg = AoQiAttackForceConfig.instance:getFinalChallengeCfg(self._activityId)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local tiliPath = GameUrl.getItemIconUrl(AoQiAttackForceConfig.instance:getTiliIconPath(self._activityId))

	uGuiUtil.setSpriteToImage(self._iconDescClg1, uGuiUtil.SpriteType.BigBg, tiliPath, function()
		local img = self._iconDescClg1:GetComponent(goutil.Type_UIImage)

		img.raycastTarget = false
	end)

	local matType, matId, _ = MaterialMgr.getMatParams(self._actCfg.heroPrizeKey)

	MaterialMgr.setIcon(self._prizeConClg3, matType, matId)
end

function AoQiAttackForceMainView:_updateByInfo()
	local baseInfo = AoQiAttackForceModel.instance:getBaseInfoByActId(self._activityId)
	local dailyStrength = self._actCfg.dailyStrength
	local useStrength = baseInfo.dailyUsedStrength

	self._txtDescClg1.text = langPara("%s/%s", dailyStrength - useStrength, dailyStrength)
	self._openTips = langPara("历史最高击杀：%s", baseInfo.endlessMaxKillNum)
	self._txtDescClg2.text = self._openTips

	if self._finalCfg then
		local openDate = GameUtil.string2date(self._finalCfg.openDateTime)

		self._txtDescTimeClg2.text = langPara("%d.%02d %02d:00后开启", openDate.month, openDate.day, openDate.hour)
		self._isOpenFinalClg = ServerTime.now() >= GameUtil.string2time(self._finalCfg.openDateTime)
	end

	GameUtil.SetActive(self._descTimeClg2, not self._isOpenFinalClg)
	GameUtil.SetActive(self._descClg2, self._isOpenFinalClg or false)

	self._heroCfg = AoQiAttackForceConfig.instance:getHeroChallengeInfoClg(self._activityId)

	if self._heroCfg then
		local openDate = GameUtil.string2date(self._heroCfg.openDateTime)

		self._txtDescClg3.text = langPara("%d.%02d %02d:00后开启", openDate.month, openDate.day, openDate.hour)
		self._isOpenHeroClg = ServerTime.now() >= GameUtil.string2time(self._heroCfg.openDateTime)
	end

	self._txtPrizeNumClg3.text = langPara("%s/%s", baseInfo.dailyHeroPrizeLimit, self._actCfg.heroPrizeDailyLimit)

	GameUtil.SetActive(self._descClg3Go, not self._isOpenHeroClg or false)
end

function AoQiAttackForceMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function AoQiAttackForceMainView:_onClickBtnClg1()
	UIStateManager.instance:push(ViewName.AoQiAttackForceClgView, self._activityId)
end

function AoQiAttackForceMainView:_onClickBtnClg2()
	if self._isOpenFinalClg then
		local baseInfo = AoQiAttackForceModel.instance:getBaseInfoByActId(self._activityId)
		local limitNum = self._actCfg.useEquipmentLimit

		if baseInfo then
			if not baseInfo.equipments then
				local equipInfos = {}
				local curUnlockNum = 0
				local curUseNum = 0

				for _, equipInfo in ipairs(equipInfos) do
					if equipInfo.isUsed then
						curUseNum = curUseNum + 1
					end

					if equipInfo.level > 0 then
						curUnlockNum = curUnlockNum + 1
					end
				end

				local isMatch = false

				isMatch = limitNum < curUnlockNum and curUseNum == limitNum or curUseNum == curUnlockNum

				if not isMatch then
					local tips = "前方挑战艰难，请上阵更多装备，提高胜算"

					TipsFacade.instance:openTipWindow("提示", tips, nil, "确定", UnityEngine.TextAnchor.MiddleCenter)

					return
				end

				AoQiAttackForceController.instance:startFinalClg(self._activityId)
			end
		end
	else
		TipsFacade.instance:openCommonTips(self._openTips)
	end
end

function AoQiAttackForceMainView:_onClickBtnClg3()
	if self._heroCfg then
		if self._isOpenHeroClg == true then
			local baseInfo = AoQiAttackForceModel.instance:getBaseInfoByActId(self._activityId)

			if baseInfo.maxHeroWaveId >= AoQiAttackForceConfig.instance:getHeroChallengeWaveTotalNums(self._activityId) then
				local tips = lang("已通关，是否进行扫荡？")

				TipsFacade.instance:openPopupWindow("提示", tips, function()
					if baseInfo.dailyHeroPrizeLimit >= self._actCfg.heroPrizeDailyLimit then
						FloatWordMgr.instance:show(lang("今日获得奖励已达上限，无法扫荡"))
					else
						AoQiAttackForceController.instance:sweepHeroClg(self._activityId)
					end
				end, function()
					AoQiAttackForceController.instance:startHeroClg(self._activityId)
				end, lang("扫荡"), lang("开始游戏"), UnityEngine.TextAnchor.MiddleCenter)
			else
				AoQiAttackForceController.instance:startHeroClg(self._activityId)
			end
		else
			local openDate = GameUtil.string2date(self._heroCfg.openDateTime)

			TipsFacade.instance:openCommonTips(langPara("%d.%02d %02d:00后开启", openDate.month, openDate.day, openDate.hour))
		end
	end
end

function AoQiAttackForceMainView:_onClickBtnJump1()
	local ruleCfg = AoQiAttackForceConfig.instance:getImgRuleCfgs(self._activityId)
	local ruleList = {}

	for i, v in ipairs(ruleCfg) do
		local obj = {}

		obj.url = v.imgPath
		obj.desc = v.desc

		table.insert(ruleList, obj)
	end

	TipsFacade.instance:openImageRuleView(ruleList)
end

function AoQiAttackForceMainView:_onClickBtnJump2()
	UIStateManager.instance:push(ViewName.AoqiAttackForceRankView, self._activityId)
end

function AoQiAttackForceMainView:_onClickBtnJump3()
	local gotoStr = self._actCfg.taskGotoStr

	GotoMgr.gotoByString(gotoStr)
end

function AoQiAttackForceMainView:_onClickBtnJump4()
	UIStateManager.instance:push(ViewName.AoQiAttackForceEquipView, self._activityId)
end

function AoQiAttackForceMainView:_onClickBtnJump5()
	local gotoStr = self._actCfg.exchangeGotoStr

	GotoMgr.gotoByString(gotoStr)
end

function AoQiAttackForceMainView:_onClickBtnJump6()
	UIStateManager.instance:push(ViewName.AoQiAttackForceHeroRankView, self._activityId)
end

return AoQiAttackForceMainView
