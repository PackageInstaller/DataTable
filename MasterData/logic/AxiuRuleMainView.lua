-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/axiu/AxiuRuleMainView.lua

module("logic.extensions.timelimitedchallenge.view.axiu.AxiuRuleMainView", package.seeall)

local AxiuRuleMainView = class("AxiuRuleMainView", ViewComponent)

function AxiuRuleMainView:ctor()
	AxiuRuleMainView.super.ctor(self)
end

function AxiuRuleMainView:unbindEvents()
	AxiuRuleMainView.super.unbindEvents(self)
	self._rankBtn:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._closeBtn:RemoveClickListener()
	self._callXiaoYan:RemoveClickListener()
	self._purgatoryBtn:RemoveClickListener()
end

function AxiuRuleMainView:bindEvents()
	AxiuRuleMainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		self:close()
	end)
	self._rankBtn:AddClickListener(function()
		GotoMgr.gotoByString(PerfectRuleModeConfig.instance:getPerfectCfgByKey("YANLUO_RANK_JUMP"))
		SurveyController.instance:reportBehavior(201091)
	end)
	self._callXiaoYan:AddClickListener(function()
		GotoMgr.gotoByString(PerfectRuleModeConfig.instance:getPerfectCfgByKey("YANLUO_CALL_JUMP"))
		SurveyController.instance:reportBehavior(201092)
	end)
	self._purgatoryBtn:AddClickListener(function()
		local curRuleId = self._curInfo.curRuleId

		if curRuleId and curRuleId > 0 then
			UIStateManager.instance:push(self._commonCfg.ruleview, self._challengeId)
		else
			UIStateManager.instance:push(self._commonCfg.difficultyview, self._challengeId)
		end
	end)
	self._btnInfo:AddClickListener(function()
		PetbookController.instance:openPetinfoView(checknumber(15011))
	end, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
end

function AxiuRuleMainView:onExit()
	AxiuRuleMainView.super.onExit(self)
	self._playerSliderMo:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.PerfectRuleModeInfoUpdate, self._setRewardCount, self)
	GlobalDispatcher:removeListener(GlobalNotify.PerfectRuleModeProgressUpdate, self._infoUpdate, self)
end

function AxiuRuleMainView:buildUI()
	AxiuRuleMainView.super.buildUI(self)

	self._rankBtn = self:getBtn("rankBtn")
	self._closeBtn = self:getBtn("btnClose")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._callXiaoYan = self:getBtn("callXiaoYan")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._purgatoryBtn = self:getBtn("purgatoryBtn")
	self._txtCoin = self:getTxt("purgatoryBtn/txtCoin")
	self._txtTime = self:getTxt("time/txtTime")
	self._petName = self:getTxt("petInfo/txtName")
	self._goldBarCon = self:getGo("goldBarCon")
	self._rankBtnRed = self:getGo("rankBtn/redpointGo")
	self._redpointGo = self:getGo("purgatoryBtn/redpointGo")
	self._callXiaoYanRed = self:getGo("callXiaoYan/redpointGo")
	self._txtTotal = self:getTxt("txtTotal")
	self._times = self:getTxt("times")

	local playerRoot = self:getGo("playerRoot")

	self._playerSliderMo = PlayerSliderMo.New(playerRoot)
end

function AxiuRuleMainView:onEnter()
	AxiuRuleMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PerfectRuleModeInfoUpdate, self._setRewardCount, self)
	GlobalDispatcher:addListener(GlobalNotify.PerfectRuleModeProgressUpdate, self._infoUpdate, self)

	self._challengeId = 46
	self._commonCfg = PerfectRuleModeConfig.instance:getCommonCfg(self._challengeId)
	self._planId = self._commonCfg.progressPrizePlanId

	self:_initPlayerParams()

	local allTimes = 0
	local leftTimes = 0
	local progress = PerfectRuleModeModel.instance:getInfo(self._challengeId) or {}

	allTimes = self._commonCfg.dailyTimes + checknumber(progress.hasBuyTimes)
	leftTimes = self._commonCfg.dailyTimes + checknumber(progress.hasBuyTimes) - checknumber(progress.hasUseTimes)
	self._txtTotal.text = checknumber(progress.score)
	self._times.text = langPara("今日次数：%s/%s", leftTimes, allTimes)

	PerfectRuleFightAgent.instance:sendPM_PerfectRuleFightGetInfoReq(self._challengeId)

	local objList = {
		{
			id = "4:146",
			showAdd = true
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)

	self._txtTime.text = PerfectRuleModeConfig.instance:getPerfectCfgByKey("YANLUO_ACTIVITY_TIME")

	self:_firstOpenActivity()

	self._petName.text = "圣骑·阎罗"
end

function AxiuRuleMainView:_initPlayerParams()
	local param = {}

	param.view = self
	param.prizeCfgs = PerfectRuleModeConfig.instance:getProgressPrizeCfg(self._planId)

	function param.getPlayerProgress()
		local progress = PerfectRuleModeModel.instance:getInfo(self._challengeId) or {}

		return checknumber(progress.score)
	end

	function param.getPrizeByRewardCfg(cfg)
		local prizes = string.split(cfg.prize, "#")

		return prizes[1]
	end

	function param.getNeedScoreByRewardCfg(cfg)
		return cfg.progress
	end

	function param.isPlayerRewardCanGet(cfg)
		return PerfectRuleModeModel.instance:isPlayerRewardCanGet(self._challengeId, cfg.id, cfg.progress)
	end

	function param.isPlayerRewardGeted(cfg)
		return PerfectRuleModeModel.instance:isPlayerRewardGeted(self._challengeId, cfg.id)
	end

	function param.sendGainPlayerPrizeReq(cfg)
		PerfectRuleModeController.instance:sendPM_PerfectRuleFightGainProgressPrizeReq(self._challengeId, cfg.id)
	end

	function param.parseGetProgress(cfg)
		return StringUtil.numberToString(cfg.progress)
	end

	self._playerSliderMo:initParam(param, true)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function AxiuRuleMainView:_firstOpenActivity()
	local str = "yanluo_dengchang_donghua"
	local value = GameUtil.getUserDayData(str)

	if checknumber(value) == 1 then
		return
	end

	ViewBlockMgr.instance:blockClick(true, self)
	AnimationPlayer.play("storyconfig/animations/yanluo_dengchang.txt", function()
		ViewBlockMgr.instance:blockClick(false, self)
	end, nil, self)
	GameUtil.saveUserDayData(str, 1)
end

function AxiuRuleMainView:_setRewardCount()
	local count = 0

	self._curInfo = PerfectRuleModeModel.instance:getInfo(self._challengeId) or {}

	if not self._curInfo.gainedProgressPrizeIds then
		local list = {}

		for k, v in pairs(list) do
			if self._commonCfg and self._commonCfg.progressPrizePlanId > 0 then
				local pCfg = PerfectRuleModeConfig.instance:getProgressPrizeCfg(self._commonCfg.progressPrizePlanId)

				if pCfg and pCfg[v] then
					local prizes = string.split(pCfg[v].prize, "#")
					local prize = string.split(prizes[1], ":")

					if checknumber(prize[2]) == 146 then
						count = count + checknumber(prize[3])
					end
				end
			end
		end

		self._txtCoin.text = string.format("已经获得：<color=#FFE3A0FF>%s</color>/120", count)

		self._playerSliderMo:updatePlayerReward()

		local progress = PerfectRuleModeModel.instance:getInfo(self._challengeId) or {}

		self._txtTotal.text = checknumber(progress.score)
		self._times.text = langPara("今日次数：%s/%s", self._commonCfg.dailyTimes + checknumber(progress.hasBuyTimes) - checknumber(progress.hasUseTimes), self._commonCfg.dailyTimes + checknumber(progress.hasBuyTimes))
	end
end

function AxiuRuleMainView:_infoUpdate()
	PerfectRuleFightAgent.instance:sendPM_PerfectRuleFightGetInfoReq(self._challengeId)
	self._playerSliderMo:updatePlayerReward()
end

function AxiuRuleMainView:_setRedPoint()
	local cfg = PerfectRuleModeConfig.instance:getCommonCfg(self._challengeId)
	local pCfg = PerfectRuleModeConfig.instance:getProgressPrizeCfg(cfg.progressPrizePlanId)

	for k, v in pairs(pCfg) do
		if PerfectRuleModeModel.instance:isPlayerRewardCanGet(self._challengeId, v.id, v.progress) then
			return true
		end
	end

	return false
end

function AxiuRuleMainView:_onClickSkill()
	local skinId = checknumber(15011)

	if skinId then
		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if cfg then
			local raceId = cfg.raceId

			PetbookController.instance:previewBattle(raceId, skinId)
		end
	end
end

return AxiuRuleMainView
