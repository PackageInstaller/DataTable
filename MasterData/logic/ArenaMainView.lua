-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaMainView.lua

module("logic.extensions.arena.view.ArenaMainView", package.seeall)

local ArenaMainView = class("ArenaMainView", ViewComponent)

function ArenaMainView:ctor()
	ArenaMainView.super.ctor(self)

	self._challengers = {}
end

function ArenaMainView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._Btn_Reward:AddClickListener(self._onClickReward, self)
	self._Btn_Report:AddClickListener(self._onClickReport, self)
	self._Btn_Rank:AddClickListener(self._onClickRank, self)
	self._Btn_Task:AddClickListener(self._onClickTask, self)
	self._Btn_Form:AddClickListener(self._onClickForm, self)
	self._Btn_Refresh:AddClickListener(self._onClickRefresh, self)
	self._clearCDBtn:AddClickListener(self._onClickClearCD, self)
	self._addClgBtn:AddClickListener(self._onClickAddClg, self)
	self._chooseBtn:AddClickListener(self._onClickChoose, self)
	self._Btn_Change:AddClickListener(self._onClickExchange, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
end

function ArenaMainView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._Btn_Reward:RemoveClickListener()
	self._Btn_Report:RemoveClickListener()
	self._Btn_Rank:RemoveClickListener()
	self._Btn_Task:RemoveClickListener()
	self._Btn_Form:RemoveClickListener()
	self._Btn_Refresh:RemoveClickListener()
	self._clearCDBtn:RemoveClickListener()
	self._addClgBtn:RemoveClickListener()
	self._chooseBtn:RemoveClickListener()
	self._Btn_Change:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function ArenaMainView:buildUI()
	self._closeButton = self:getBtn("lefttop/btn_back")
	self._Btn_Reward = self:getBtn("RightBtns/Btn_Reward")
	self._redPointReward = self:getGo("RightBtns/Btn_Reward/imgPoint")
	self._redPointDailyTask = self:getGo("RightBtns/Btn_Task/dot")
	self._Btn_Report = self:getBtn("RightBtns/Btn_Report")
	self._Btn_Rank = self:getBtn("RightBtns/Btn_Rank")
	self._Btn_Task = self:getBtn("RightBtns/Btn_Task")
	self._Btn_Form = self:getBtn("RightBtns/Btn_Form")
	self._Btn_Refresh = self:getBtn("Btn_Refresh")
	self._imgRefreshCd = goutil.findChildImageComponent(self._Btn_Refresh.gameObject, "imgCd")
	self._txtRefreshCd = goutil.findChildTextComponent(self._Btn_Refresh.gameObject, "txtCd")
	self._txtRefreshCnt = goutil.findChildTextComponent(self._Btn_Refresh.gameObject, "TxtClgCnt")
	self._addClgBtn = self:getBtn("LeftInfos/BtnClg")
	self._clearCDBtn = self:getBtn("LeftInfos/BtnTime")
	self._chooseBtn = self:getBtn("LeftInfos/BtnChange")
	self._challengerCloneGo = self:getGo("arenachallenger")
	self._Txt_ArenaName = self:getGo("LeftInfos/Txt_ArenaName"):GetComponent(goutil.Type_UIText)
	self._Txt_Num = self:getGo("LeftInfos/TxtClgCnt"):GetComponent(goutil.Type_UIText)
	self._grpTxt = self:getGo("LeftInfos/Group/TxtGroup"):GetComponent("Text")
	self._modelCam = self:getGo("modelCam")
	self._txtClgCd = self:getGo("LeftInfos/TxtTime"):GetComponent("Text")
	self._txtSeason = goutil.findChildTextComponent(self.mainGO, "LeftInfos/TxtSeason")
	self._txtSeasonTime = goutil.findChildTextComponent(self.mainGO, "LeftInfos/TxtSeasonTime")
	self._poses = {}
	self._Btn_Change = self:getBtn("RightBtns/Btn_Change")
	self._goldBarCon = self:getGo("goldBarCon")

	for i = 1, 5 do
		self._poses[i] = self:getGo("Pos/p" .. i - 1).transform.position
	end

	self:_initChallengers()
	GameUtil.SetActive(self._challengerCloneGo, false)

	self._nextRewardMainGo = self:getGo("reward")
	self._nextRankText = self:getGo("reward/txtRank"):GetComponent(goutil.Type_UIText)
	self._nextRankRewardCon1 = self:getGo("reward/itemGroup/item1")
	self._nextRankRewardCon2 = self:getGo("reward/itemGroup/item2")
	self._nextRankRewardCon3 = self:getGo("reward/itemGroup/item3")

	goutil.setActive(self._nextRewardMainGo, false)

	self._btnTip = self:getBtn("lefttop/btnTip")
end

function ArenaMainView:destroyUI()
	return
end

function ArenaMainView:onEnter()
	LightMgr.instance:setUseModelLight(true)
	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	WaitingView.instance:show(nil, self)
	settimer(1, self._closeWatingView, self, false)
	self:checkShowUpPosition()

	local btn_list = {
		{
			showAdd = false,
			id = GameEnum.GoldType.ArenaCoin
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list)
	GlobalModel.instance:visibleSceneHUDs(false)
	self._modelCam.transform:SetParent(nil)

	self._cd = 0

	self:_refresh()
	ArenaController.instance:getArenaInfos()
	ArenaController.instance:registerLocalNotify("RefreshArenaInfo", self._refresh, self)
	ArenaController.instance:registerLocalNotify("ChallengeCdChange", self._onChallengeCdChange, self)
	ArenaController.instance:registerLocalNotify("RefreshChallengeTimes", self._refreshChallengeTimes, self)
	ArenaController.instance:registerLocalNotify("RoleResLoadFinish", self._roleResLoadFinish, self)
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._updateRedPoint, self)
	self.addGEvent(self, ArenaAgent.ArenaChallengeRes, self._onClgFinish, self)

	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)
	self:_updateRedPoint()

	for i = 1, #self._challengers do
		self._challengers[i]:onEnter()
	end

	self:_setNextTopGroupReward()
	self:_checkIsChangeSeason()
end

function ArenaMainView:checkShowUpPosition()
	local data = ArenaModel.instance:getUpPositionData()

	if data then
		UIStateManager.instance:open(ViewName.ArenaHistoryupView)
	end
end

function ArenaMainView:_updateRedPoint()
	self._redPointReward:SetActive(RedPointModel.instance:isActive(10))
	self._redPointDailyTask:SetActive(RedPointModel.instance:isActive(31))
end

function ArenaMainView:_isDayFirstEnterHero()
	local zoneId = ArenaModel.instance:getZoneId()

	if zoneId < 1 then
		return false
	end

	local is_recorded, cur_record_key_str = self:IsRecorded()

	if is_recorded then
		return false
	end

	GameUtil.setLocalString(cur_record_key_str, "true")

	return true
end

function ArenaMainView:formatYestoday(fmt)
	return GameUtil.formatTimeStamp(fmt, ServerTime.now() - 86400)
end

function ArenaMainView:IsRecorded()
	local today_date = ServerTime.formatNow("%Y/%m/%d/%H/%M")
	local today_key = ServerTime.formatNow("%Y/%m/%d")
	local yestoday_key = self:formatYestoday("%Y/%m/%d")
	local today_date_array = string.split(today_date, "/")

	if tonumber(today_date_array[4]) > 0 and tonumber(today_date_array[4]) < 5 then
		local yestoday_key_str = RoleModel.instance:getUserName() .. yestoday_key .. "showArenaHeroTask"
		local str = GameUtil.getLocalString(yestoday_key_str)

		if not str or str == "" then
			return false, yestoday_key_str
		else
			return true, ""
		end
	else
		local today_key_str = RoleModel.instance:getUserName() .. today_key .. "showArenaHeroTask"
		local str = GameUtil.getLocalString(today_key_str)

		if not str or str == "" then
			return false, today_key_str
		else
			return true, ""
		end
	end
end

function ArenaMainView:_refreshChallengeTimes()
	local canClgCount = ArenaModel.instance:getLeftChallengeTimes()

	self._Txt_Num.text = langPara("%s", canClgCount)
end

function ArenaMainView:_refreshClgCD()
	local leftTime = ArenaModel.instance:getChallengeCdEndTime() - ServerTime.now()

	if leftTime <= 0 then
		self._isClgCd = false
		self._txtClgCd.text = "冷却时间：无"

		self._clearCDBtn.gameObject:SetActive(false)
	else
		self._isClgCd = true

		local hour, min, sec = GameUtil.getTimeHHMMSS(leftTime)

		self._txtClgCd.text = string.format("冷却时间：%d:%02d", min, sec)

		self._clearCDBtn.gameObject:SetActive(true)
	end
end

function ArenaMainView:_refreshRefreshCnt()
	self._txtRefreshCnt.text = "换一批"

	local leftCnt = ArenaModel.instance:getLeftRefreshCnt()

	uGuiUtil.setImageGrayStateRecursive(self._Btn_Refresh, leftCnt < 0)
end

function ArenaMainView:_refreshRefreshCD()
	local leftTime = ArenaModel.instance:getRefreshCdEndTime() - ServerTime.nowMs() * 0.001

	if leftTime <= 0 then
		self._isRefreshCd = false
		self._txtRefreshCd.text = ""
		self._imgRefreshCd.fillAmount = 0

		uGuiUtil.setImageGrayStateRecursive(self._Btn_Refresh, false)
	else
		self._isRefreshCd = true

		local hour, min, sec = GameUtil.getTimeHHMMSS(math.ceil(leftTime))

		self._txtRefreshCd.text = string.format("%d", sec)
		self._imgRefreshCd.fillAmount = leftTime / ArenaConfig.instance:getRefreshCd()

		uGuiUtil.setImageGrayStateRecursive(self._Btn_Refresh, true)
	end
end

function ArenaMainView:Update()
	if self._isClgCd then
		self:_refreshClgCD()
	end

	if self._isRefreshCd then
		self:_refreshRefreshCD()
	end
end

function ArenaMainView:onEnterFinished()
	return
end

function ArenaMainView:onExit()
	LightMgr.instance:setUseModelLight(false)
	WaitingView.instance:hide(self)
	removetimer(self._closeWatingView, self)
	self._modelCam.transform:SetParent(self.mainGO.transform)
	GlobalModel.instance:visibleSceneHUDs(true)
	ArenaController.instance:unregisterLocalNotify("RefreshArenaInfo", self._refresh, self)
	ArenaController.instance:unregisterLocalNotify("ChallengeCdChange", self._onChallengeCdChange, self)
	ArenaController.instance:unregisterLocalNotify("RefreshChallengeTimes", self._refreshChallengeTimes, self)
	ArenaController.instance:unregisterLocalNotify("RoleResLoadFinish", self._roleResLoadFinish, self)
	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._updateRedPoint, self)

	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	for i = 1, #self._challengers do
		self._challengers[i]:onExit()
	end

	MaterialMgr.resetAll(self._nextRankRewardCon1)
	MaterialMgr.resetAll(self._nextRankRewardCon2)
	MaterialMgr.resetAll(self._nextRankRewardCon3)
	LightMgr.instance:setLightForNormalScene()
end

function ArenaMainView:_onRefreshArenaInfo()
	self:_refresh()
end

function ArenaMainView:onExitFinished()
	return
end

function ArenaMainView:_refresh()
	self:_refreshChallengers()
	self:_refreshMyInfo()

	local zoneId = ArenaModel.instance:getZoneId()

	self._Txt_ArenaName.text = "未知"

	if zoneId > 0 and ArenaModel.instance:getZoneName() then
		self._Txt_ArenaName.text = ArenaModel.instance:getZoneName()
	end

	local gpCfg = ArenaConfig.instance:getArenaTopGroupCfgById(ArenaModel.instance:getTopGroupId())

	if gpCfg then
		self._grpTxt.text = gpCfg.topGroupName
	end

	local seasonId = ArenaModel.instance:getSeasonId()

	self._txtSeason.text = "第" .. GameUtil.getChineseNumber(seasonId) .. "届"

	self:_refreshChallengeTimes()
	self:_refreshClgCD()
	self:_refreshRefreshCnt()
	self:_refreshRefreshCD()
	self:_refreshSeasonTime()
end

function ArenaMainView:_onChallengeCdChange()
	self:_refreshClgCD()
end

function ArenaMainView:_onClickClose()
	UIStateManager.instance:pop()
end

function ArenaMainView:_onClickReward()
	if SceneMgr.instance.isGogingToEnterBattleScene then
		return
	end

	UIStateManager.instance:open("arenaRewardView")
end

function ArenaMainView:_onClickReport()
	ArenaAgent.instance:sendGetMyArenaChallengeRecordsReq()
end

function ArenaMainView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("arenamainview")
end

function ArenaMainView:_initChallengers()
	for i = 1, 5 do
		local obj = goutil.cloneAndSetParent(self._challengerCloneGo, self.mainGO.transform)

		GameUtil.SetActive(obj, true)

		obj.name = "arenachallenger_" .. i
		self._challengers[i] = ArenaChallenger.AddOnce(obj)

		local pos = self._poses[i]

		GameUtil.setPos(self._challengers[i]._container, pos.x, pos.y, pos.z)
	end
end

function ArenaMainView:_refreshChallengers()
	local oldList = ArenaModel.instance:getChallengers()

	if oldList == nil then
		return nil
	end

	local challengers = {}

	for i, v in ipairs(oldList) do
		table.insert(challengers, v)
	end

	local challengerDat = {
		_userName = RoleModel.instance:getUserName(),
		_maxZdl = RoleModel.instance:getMaxPower(),
		_position = ArenaModel.instance:getPosition(),
		gender = RoleModel.instance:getGender(),
		_clothes = RoleModel.instance:getClothes()
	}

	table.insert(challengers, challengerDat)
	table.sort(challengers, function(a, b)
		return a._position < b._position
	end)

	for i, v in ipairs(self._challengers) do
		v._container:SetActive(false)
	end

	local mainRolePos = ArenaModel.instance:getPosition()
	local lastVo

	self._challengerLen = #challengers

	for i = 1, #challengers do
		local vo = challengers[i]

		if vo then
			if vo._userId and i >= #challengers and mainRolePos < vo._position then
				lastVo = vo

				break
			end

			self._challengers[i]._container:SetActive(true)
			self._challengers[i]:initChallenger(vo)
		end
	end

	local vo = lastVo
	local lastIndex = #challengers

	if vo and lastIndex > 0 and lastIndex < 6 then
		self._challengers[5]._container:SetActive(true)
		self._challengers[5]:initChallenger(vo)

		local pos = self._poses[5]

		GameUtil.setPos(self._challengers[5]._container, pos.x, pos.y, pos.z)
	end
end

function ArenaMainView:_refreshMyInfo()
	return
end

function ArenaMainView:_refreshSeasonTime()
	local seasonId = ArenaModel.instance:getSeasonId()

	if seasonId then
		local cfg = ArenaConfig.instance:getSeasonCfg(seasonId)

		if cfg then
			self._txtSeasonTime.text = cfg.desc or "未知"
		end
	end
end

function ArenaMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.Rank, GameEnum.RankType.ArenaCombine, 1)
end

function ArenaMainView:_onClickChoose()
	UIStateManager.instance:push("arenaChooseView")
end

function ArenaMainView:_onClickForm()
	ArenaModel.instance:setOpenArenaFmtViewTag(true)
	ArenaAgent.instance:sendGetMyArenaFormationReq()
end

function ArenaMainView:_onClickTask()
	ArenaAgent.instance:sendGetDailyTaskInfoReq()
end

function ArenaMainView:_onClickRefresh()
	local leftTime = ArenaModel.instance:getRefreshCdEndTime() - ServerTime.nowMs() * 0.001

	if leftTime > 0 then
		FloatWordMgr.instance:show("冷却中")

		return
	end

	ArenaController.instance:refreshTargets()
end

function ArenaMainView:_onClickClearCD()
	ArenaController.instance:showBuyCD()
end

function ArenaMainView:_onClickAddClg()
	local buyTimes = ArenaModel.instance:getChallengeBuyTime()
	local totalCanBuyTimes = VipModel.instance:getAbleToBuyTimesOfArena()
	local leftBuyCnt = totalCanBuyTimes - buyTimes

	if leftBuyCnt <= 0 then
		TipsFacade.instance:openCommonTips(lang("今天的购买次数用完咯！明天再来吧！"))
	else
		ArenaController.instance:buyClgTime()
	end
end

function ArenaMainView:_onClickExchange()
	GotoMgr.gotoByString("func#470#ExchangeArena")
end

function ArenaMainView:_roleResLoadFinish()
	if self._challengerLen then
		self._challengerLen = self._challengerLen - 1

		if self._challengerLen <= 0 then
			WaitingView.instance:hide(self)

			self._challengerLen = false
		end
	else
		WaitingView.instance:hide(self)
	end
end

function ArenaMainView:_closeWatingView()
	removetimer(self._closeWatingView, self)
	WaitingView.instance:hide(self)
end

function ArenaMainView:_setNextTopGroupReward()
	for i = 1, 3 do
		self["_nextRankRewardCon" .. i]:SetActive(false)
	end

	local topGroupId = ArenaModel.instance:getTopGroupId()

	if topGroupId <= 1 then
		goutil.setActive(self._nextRewardMainGo, false)

		return
	else
		goutil.setActive(self._nextRewardMainGo, true)

		local cfg = ArenaConfig.instance:getArenaTopGroupCfgByArenaId(topGroupId - 1)

		self._nextRankText.text = "达到名次\n" .. cfg.numOrPercent

		local list = string.split(cfg.achieveGroupPrize, "#")

		for i, v in ipairs(list) do
			self["_nextRankRewardCon" .. i]:SetActive(true)
			MaterialMgr.setCellByCfg(v, self["_nextRankRewardCon" .. i])
		end
	end
end

function ArenaMainView:_checkIsChangeSeason()
	local seasonId = ArenaModel.instance:getSeasonId()

	if seasonId then
		local lastId = GameUtil.getUserData("ArenaLastSeason")

		lastId = checknumber(lastId)

		if seasonId > 1 and (lastId <= 0 or lastId < seasonId) then
			local zoneId = ArenaModel.instance:getZoneId()
			local content = string.format("欢迎来到第%s赛季竞技场，\n你被分配至%s。\n可重新获得段位奖励和赛季历史排名奖励。", seasonId, ArenaModel.instance:getZoneName(zoneId))

			TipsFacade.instance:openTipWindowNoX("通知", content)
			GameUtil.saveUserData("ArenaLastSeason", seasonId)
		end
	end
end

function ArenaMainView:_onClgFinish(status, msg)
	if msg.changeSetId > 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		MaterialController.instance:showChangeSetInTemp(msg.changeSetId)
	end

	self:_refresh()
end

return ArenaMainView
