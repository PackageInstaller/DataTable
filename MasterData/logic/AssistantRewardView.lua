-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/AssistantRewardView.lua

module("logic.extensions.xiaonuoassistant.view.AssistantRewardView", package.seeall)

local AssistantRewardView = class("AssistantRewardView", ViewComponent)

function AssistantRewardView:ctor()
	AssistantRewardView.super.ctor(self)
end

function AssistantRewardView:buildUI()
	AssistantRewardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tableviewGo = self:getGo("tableview")
	self._cellGo = self:getGo("cell")
	self.scrollList = ScrollerList.create(self._tableviewGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self.scrollList:regReloadFinish(GameUtil.handler(self._onReloadFinish, self))

	self._scrollrect = self._tableviewGo:GetComponent("ScrollRect")
	self._excuting = self:getGo("excuting")

	goutil.setActive(self._excuting, false)
end

function AssistantRewardView:bindEvents()
	AssistantRewardView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function AssistantRewardView:unbindEvents()
	AssistantRewardView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function AssistantRewardView:onEnter()
	AssistantRewardView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoAssistantNotifyReward, self._onNotifyReward, self)
	GlobalDispatcher:addListener(InfiniteFightAgent.InfiniteSweepRes, self._onInfiniteSweepRes, self)
	GlobalDispatcher:addListener(ThroneAgent.PM_GainThroneDailyPrizeRes, self._onGainThroneDailyPrizeRes, self)
	GlobalDispatcher:addListener(MoneyCatAgent.MakeMoneyRes, self._onMakeMoneyRes, self)
	GlobalDispatcher:addListener(GlobalNotify.BasicBenefitsGainStrengthPrizeRes_assistant, self._onBasicBenefitsGainStrengthPrizeRes, self)
	GlobalDispatcher:addListener(StrengthAgent.PM_StrengthBuyRes, self._onStrengthBuyRes, self)
	GlobalDispatcher:addListener(AnimalsAgent.PM_AnimalsPigAdventurePrizeRes, self._onAnimalsPigAdventurePrizeRes, self)
	GlobalDispatcher:addListener(AnimalsAgent.PM_AnimalsFeedRes, self._onAnimalsFeedRes, self)
	GlobalDispatcher:addListener(AnimalsAgent.PM_AnimalsTouchRes, self._onAnimalsTouchRes, self)
	self.addGEvent(self, AnimalsAgent.PM_AnimalsProcessFeedBackRes, self._onAnimalsFeedBackRes, self)
	GlobalDispatcher:addListener(GlobalNotify.SendHeart_assistant, self._onSendHeart, self)
	GlobalDispatcher:addListener(GlobalNotify.GainHeart_assistant, self._onGainHeart, self)
	GlobalDispatcher:addListener(GlobalNotify.DiamondCardGainDailyPrize, self._DiamondCardGainDailyPrize, self)
	GlobalDispatcher:addListener(MonthCardAgent.PM_MonthCardGainDailyPrizeRes, self._MonthCardGainDailyPrizeRes, self)
	self.addGEvent(self, FamilyAgent.FamilyDonateRes, self._onFamilyDonateRes, self)
	self.addGEvent(self, GlobalNotify.NotifyPayShopItemBuySucRes, self._onNotifyPayShopItemBuySucRes, self)
	self.addGEvent(self, PayShopAgent.BuyItemRes, self._onBuyItemRes, self)
	self.addGEvent(self, WarriorTowerAgent.TurnTimeWarriorTowerRes, self._onTurnTimeWarriorTowerRes, self)
	self.addGEvent(self, GoodFeelingAgent.PM_GFNotifyAfterHandleEventRes, self._onGFNotifyAfterHandleEventRes, self)
	self.addGEvent(self, GoodFeelingAgent.PM_GFHandleEventRes, self._onGFHandleEventRes, self)
	self.addGEvent(self, LegendChallengeAgent.SweepsByTimesRes, self._onSweepsByTimesRes, self)
	self.addGEvent(self, MaterialChallengeAgent.MCLG_SweepsByTimesRes, self._onMCLG_SweepsByTimesRes, self)
	self.addGEvent(self, PetDispatchAgent.PM_GainTaskPrizeRes, self._onGainTaskPrizeRes, self)
	self.addGEvent(self, PetDispatchAgent.PM_RefreshTaskRes, self._onRefreshTaskRes, self)
	self.addGEvent(self, PetDispatchAgent.PM_DispatchPetsRes, self._onDispatchPetsRes, self)
	self.addGEvent(self, VipAgent.PM_GainVipDailyBonusRes, self._onGainVipDailyBonusRes, self)
	self.addGEvent(self, AnnuityAgent.PM_AnnuityGainWeeklyPrizeRes, self._onAnnuityGainWeeklyPrizeRes, self)
	self.addGEvent(self, AnnuityAgent.PM_AnnuityGainMonthPrizeRes, self._onAnnuityGainMonthPrizeRes, self)
	self.addGEvent(self, WarriorTowerAgent.GainWarriorTowerProfitPrizeRes, self._onGainWarriorTowerProfitPrizeRes, self)
	self.addGEvent(self, BasicBenefitsAgent.PM_BasicBenefitsGainPrizeRes, self._BasicBenefitsGainPrizeRes, self)
	self.addGEvent(self, ArenaAgent.ArenaChallengeRes, self._onArenaChallengeRes, self)
	self.addGEvent(self, Arena3v3Agent.Arena3v3ChallengeRes, self._onArena3v3ChallengeRes, self)
	self.addGEvent(self, LingWenAgent.LingWenSweepRes, self._onLingWenSweepRes, self)
	self.addGEvent(self, BreachFormationAgent.PM_BreachFormationQuickPassRes, self._onBreakFormationQuickPassRes, self)
	self.addGEvent(self, BreachFormationAgent.PM_BreachFormationBuyFirstPassTimesRes, self._onGainBreakFormationBuyTimesRes, self)
	self.addGEvent(self, BreachFormationAgent.PM_BreachFormationOneKeyGainProgressPrizeRes, self._onGainBreakFormationOneKeyGainProgressPrizeRes, self)
	self.addGEvent(self, GlobalNotify.handlePM_GainAllBuildingOutputResResp, self._onGainCutePetBuildingOneKeyGainPrizeRes, self)
	self.addGEvent(self, GlobalNotify.PM_FamilyTaskGainPrizeRes, self._onGainFamilyTaskPrizeOneKeyGainPrizeRes, self)
	self.addGEvent(self, GlobalNotify.TimeGateSelectOpenRes, self._onTimeGateSelectOpenRes, self)
	self.addGEvent(self, GlobalNotify.SignInBuffUpgradeSignIn, self._onBatchUpgradeSignInBuffRes, self)
	self.addGEvent(self, GoodFeelingAgent.PM_GFGetEventInfoRes, self._onGFGetEventInfoRes, self)
	self.addGEvent(self, GlobalNotify.XiaoNuoAssistantSendNextReq, self._sendNextRequest, self)
	self.addGEvent(self, LotteryAgent.LotteryDrawRes, self._handleLotteryDrawRes, self)

	local params = self:getOpenParam()

	self._xiaoNuoSendMoList = params[1]
	self._curTabIndex = params[2]
	self._xiaoNuoSendMoDic = {}
	self._callbackList = {}
	self._funcIdList = {}
	self._callbackStageList = {}
	self._callbackIndex = 1
	self._calbackMaxIndex = 1
	self._rewardInfoList = {}
	self._isFinishExcute = false
	self._curFuncId = 0

	goutil.setActive(self._excuting, true)
	self:_initRewardInfos()
	self:_sendNextRequest()
end

function AssistantRewardView:onExit()
	AssistantRewardView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoAssistantNotifyReward, self._onNotifyReward, self)
	GlobalDispatcher:removeListener(InfiniteFightAgent.InfiniteSweepRes, self._onInfiniteSweepRes, self)
	GlobalDispatcher:removeListener(ThroneAgent.PM_GainThroneDailyPrizeRes, self._onGainThroneDailyPrizeRes, self)
	GlobalDispatcher:removeListener(MoneyCatAgent.MakeMoneyRes, self._onMakeMoneyRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.BasicBenefitsGainStrengthPrizeRes_assistant, self._onBasicBenefitsGainStrengthPrizeRes, self)
	GlobalDispatcher:removeListener(StrengthAgent.PM_StrengthBuyRes, self._onStrengthBuyRes, self)
	GlobalDispatcher:removeListener(AnimalsAgent.PM_AnimalsPigAdventurePrizeRes, self._onAnimalsPigAdventurePrizeRes, self)
	GlobalDispatcher:removeListener(AnimalsAgent.PM_AnimalsFeedRes, self._onAnimalsFeedRes, self)
	GlobalDispatcher:removeListener(AnimalsAgent.PM_AnimalsTouchRes, self._onAnimalsTouchRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.SendHeart_assistant, self._onSendHeart, self)
	GlobalDispatcher:removeListener(GlobalNotify.GainHeart_assistant, self._onGainHeart, self)
	GlobalDispatcher:removeListener(GlobalNotify.DiamondCardGainDailyPrize, self._DiamondCardGainDailyPrize, self)
	GlobalDispatcher:removeListener(MonthCardAgent.PM_MonthCardGainDailyPrizeRes, self._MonthCardGainDailyPrizeRes, self)
	self.scrollList:dispose()
end

function AssistantRewardView:_onClickClose()
	if self._isFinishExcute then
		GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantUpdateMainView)
		self:close()
	else
		FloatWordMgr.instance:show("正在执行中...")
	end
end

function AssistantRewardView:_onTimeGateSelectOpenRes(status, msg)
	if self._curFuncId ~= XiaoNuoAssistantModel.FuncEnum.SHI_KONG_ZHI_MEN_SIGN then
		return
	end

	if status ~= nil and status ~= 0 then
		self:_finishAssist25Results(XiaoNuoAssistantModel.Assist25ResultGroup.OpenThenSign, XiaoNuoAssistantModel.Assist25ResultState.Failed, lang("开门失败"))

		if self._callbackStageList[self._callbackIndex] == XiaoNuoAssistantModel.Assist25CallbackStage.SignAfterOpen then
			self._callbackIndex = self._callbackIndex + 1
		end
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onBatchUpgradeSignInBuffRes(status, msg)
	if self._curFuncId == XiaoNuoAssistantModel.FuncEnum.SHI_KONG_ZHI_MEN_SIGN then
		local isDirectSign = self._curCallbackStage == XiaoNuoAssistantModel.Assist25CallbackStage.DirectSign

		if isDirectSign then
			if not XiaoNuoAssistantModel.Assist25ResultGroup.DirectSign then
				local group = XiaoNuoAssistantModel.Assist25ResultGroup.OpenThenSign
				local isSuccess = status == nil or status == 0

				if isSuccess then
					if not XiaoNuoAssistantModel.Assist25ResultState.Success then
						local state = XiaoNuoAssistantModel.Assist25ResultState.Failed
						local resultText = isSuccess and lang("签到成功") or lang("签到失败")

						self:_finishAssist25Results(group, state, resultText)
						self:_sendNextRequest()
					end
				end
			end
		end
	end
end

function AssistantRewardView:_finishAssist25Results(group, state, resultText)
	local sendMo = self._xiaoNuoSendMoDic[XiaoNuoAssistantModel.FuncEnum.SHI_KONG_ZHI_MEN_SIGN]

	for _, result in ipairs(sendMo.resultItemList) do
		if result.group == group and result.state == XiaoNuoAssistantModel.Assist25ResultState.Pending then
			result.state = state
			result.resultText = resultText
		end
	end
end

function AssistantRewardView:_onRefreshTaskRes(status, msg)
	if status ~= 0 and self._curFuncId == XiaoNuoAssistantModel.FuncEnum.ONE_KEY_DISPATCH then
		self:_sendNextRequest()
	end
end

function AssistantRewardView:_onGFGetEventInfoRes(status, msg)
	if status ~= 0 and self._curFuncId == XiaoNuoAssistantModel.FuncEnum.GOOD_FEELING_ANSWER then
		self:_sendNextRequest()
	end
end

function AssistantRewardView:_onNotifyReward(funcIndex, changeSetId, msg)
	printInfo("test 下发了功能1 funcIndex = ", funcIndex, changeSetId)

	local items = MaterialController.instance:getTempItemsByChangeSetId(changeSetId) or {}

	printInfo("test 下发了功能2 items = ", funcIndex, items and #items, items)

	local rewardList = {}

	for i, v in ipairs(items) do
		printInfo("test 奖励", v:toString(), v.type, v.id)
		table.insertto(rewardList, MaterialMgr.changeItemStrArr(v:toString()))
	end

	if funcIndex == XiaoNuoAssistantModel.FuncEnum.LEGEND_CHALLENGE_SWEEP then
		if msg then
			local prizes = msg.prizes

			for i, v in ipairs(prizes) do
				local list = {}

				self:_insertTolist(list, v.prizes)
				self:_insertTolist(list, v.experience)
				table.insertto(rewardList, list)
			end
		end
	elseif funcIndex == XiaoNuoAssistantModel.FuncEnum.MATERIAL_CHALLENGE_SWEEP then
		if msg then
			local prizes = msg.prizes

			if not msg.multiplyTimes then
				for i, v in ipairs(prizes) do
					local list = {}

					self:_insertTolist(list, v.prizes)
					self:_insertTolist(list, v.experience)
					table.insertto(rewardList, list)
				end
			end
		end
	elseif funcIndex == XiaoNuoAssistantModel.FuncEnum.LingWen and msg then
		local prizes = msg.prizes

		for i, v in ipairs(prizes) do
			local list = {}

			self:_insertTolist(list, v.prizes)
			self:_insertTolist(list, v.experience)
			table.insertto(rewardList, list)
		end
	end

	local index = 0

	for i, v in ipairs(self._rewardInfoList) do
		if v.funcIndex == funcIndex then
			table.insertto(v.rewardList, rewardList)

			index = i - 1

			break
		end
	end
end

function AssistantRewardView:_insertTolist(list, input)
	local arr = MaterialMgr.changeItemStrArr(input)

	for i, str in ipairs(arr) do
		if string.trim(str) ~= "" then
			table.insert(list, str)
		end
	end
end

function AssistantRewardView:_onInfiniteSweepRes(status, msg)
	if status == 0 then
		printInfo("test 保存奖励 > 无尽试炼扫荡 changeSetId = ", msg.changeSetId, "funcType = ", XiaoNuoAssistantModel.FuncEnum.INFINITE_FIGHT)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.INFINITE_FIGHT, msg.changeSetId)
	else
		printInfo("test 请求失败>> 无尽试炼扫荡")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onGainThroneDailyPrizeRes(status, msg)
	if status == 0 then
		printInfo("test 保存奖励 > 每日原液 changeSetId = ", msg.changeSetId, "funcType = ", XiaoNuoAssistantModel.FuncEnum.THRONE_DAILY_PRIZE)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.THRONE_DAILY_PRIZE, msg.changeSetId)
	else
		printInfo("test 请求失败>> 请求每日原液失败")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onMakeMoneyRes(status, msg)
	if status == 0 then
		printInfo("test 保存奖励 > 招财诺 changeSetId = ", msg.changeSetId, "funcType = ", XiaoNuoAssistantModel.FuncEnum.MONEY_CAT)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.MONEY_CAT, msg.changeSetId)
	else
		printInfo("test 请求失败>> 无尽试炼扫荡")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onBasicBenefitsGainStrengthPrizeRes(status, msg)
	if status == 0 then
		printInfo("test 保存奖励 > 米其林免费体力 changeSetId = ", msg.changeSetId, "funcType = ", XiaoNuoAssistantModel.FuncEnum.DAILY_MIQILIN_STRENGTH)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.DAILY_MIQILIN_STRENGTH, msg.changeSetId)
	else
		printInfo("test 请求失败>> 米其林免费体力")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_BasicBenefitsGainPrizeRes(status, msg)
	if status == 0 then
		printInfo("test 保存奖励 > 米其林-早餐午餐晚餐 changeSetId = ", msg.changeSetId, "funcType = ", XiaoNuoAssistantModel.FuncEnum.DAILY_MIQILIN_STRENGTH)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.DAILY_MIQILIN_STRENGTH, msg.changeSetId)
	else
		printInfo("test 请求失败>> 米其林-早餐午餐晚餐")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onStrengthBuyRes(status, msg)
	if status == 0 then
		printInfo("test 保存奖励 > 每日免费体力 changeSetId = ", msg.changeSetId, "funcType = ", XiaoNuoAssistantModel.FuncEnum.DAILY_FREE_STRENGTH)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.DAILY_FREE_STRENGTH, msg.changeSetId)
	else
		printInfo("test 请求失败>> 每日免费体力")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onAnimalsPigAdventurePrizeRes(status, msg)
	if status == 0 then
		printInfo("test 保存奖励 > 溜溜宠 一键领取 changeSetId = ", msg.changeSetId, "funcType = ", XiaoNuoAssistantModel.FuncEnum.MY_ANIMALS)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.MY_ANIMALS, msg.changeSetId)
	else
		printInfo("test 请求失败>> 溜溜宠 一键领取")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onAnimalsFeedRes(status, msg)
	if status == 0 then
		printInfo("test 保存奖励 > 溜溜宠 一键喂养 changeSetId = ", msg.changeSetId, "funcType = ", XiaoNuoAssistantModel.FuncEnum.MY_ANIMALS)

		if msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.MY_ANIMALS, msg.changeSetId)
		end
	else
		printInfo("test 请求失败>> 溜溜宠 一键喂养")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onAnimalsTouchRes(status, msg)
	if status == 0 then
		printInfo("test 保存奖励 > 溜溜宠 一键抚摸 changeSetId = ", msg.changeSetId, "funcType = ", XiaoNuoAssistantModel.FuncEnum.MY_ANIMALS)

		if msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.MY_ANIMALS, msg.changeSetId)
		end
	else
		printInfo("test 请求失败>> 溜溜宠 一键抚摸")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onAnimalsFeedBackRes(status, msg)
	if status == 0 then
		printInfo("test 保存奖励 > 溜溜宠 宠物奇事 changeSetId = ", msg.changeSetId, "funcType = ", XiaoNuoAssistantModel.FuncEnum.MY_ANIMALS)

		if msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.MY_ANIMALS, msg.changeSetId)
		end
	else
		printInfo("test 请求失败>> 溜溜宠 宠物奇事")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onSendHeart(status, msg)
	if status == 0 then
		printInfo("test 保存奖励 > 好友 一键赠送好感度 changeSetId = ", msg.changeSetId, "funcType = ", XiaoNuoAssistantModel.FuncEnum.GOOD_FEELING)

		if msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.GOOD_FEELING, msg.changeSetId)
		end
	else
		printInfo("test 请求失败>> 好友 一键赠送好感度 ")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onGainHeart(status, msg)
	if status == 0 then
		printInfo("test 保存奖励 > 好友 一键获得好感度 changeSetId = ", msg.changeSetId, "funcType = ", XiaoNuoAssistantModel.FuncEnum.GOOD_FEELING)

		if msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.GOOD_FEELING, msg.changeSetId)
		end
	else
		printInfo("test 请求失败>> 好友 一键获得好感度 ")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_DiamondCardGainDailyPrize(status, msg)
	if status == 0 then
		printInfo("test 保存奖励 > 资源卡 金钻卡 changeSetId = ", msg.changeSetId, "funcType = ", XiaoNuoAssistantModel.FuncEnum.MATERILAL_CARD)

		if msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.MATERILAL_CARD, msg.changeSetId)
		end
	else
		printInfo("test 请求失败>> 资源卡 金钻卡 ")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_MonthCardGainDailyPrizeRes(status, msg)
	if status == 0 then
		printInfo("test 保存奖励 > 资源卡 月卡 changeSetId = ", msg.changeSetId, "funcType = ", XiaoNuoAssistantModel.FuncEnum.MATERILAL_CARD, "cardId = ", msg.cardId)

		if msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.MATERILAL_CARD, msg.changeSetId)
		end
	else
		printInfo("test 请求失败>> 资源卡 月卡 ")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_handleLotteryDrawRes(status, msg)
	if status == 0 then
		printInfo("test 保存奖励 > 资源卡 金钻卡 抽卡 changeSetId = ", msg.changeSetId, "funcType = ", XiaoNuoAssistantModel.FuncEnum.MATERILAL_CARD, "cardId = ", msg.cardId)
		MaterialController.instance:saveChangeSetToTemp(msg.decomposeStrengthenCsi)
		MaterialController.instance:saveChangeSetToTemp(msg.decomposeExtraCsi)

		if msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)

			local items1 = MaterialController.instance:___getTempItemsByChangeSetIdOnlyRead(msg.decomposeExtraCsi)
			local items2 = MaterialController.instance:___getTempItemsByChangeSetIdOnlyRead(msg.decomposeStrengthenCsi)

			if msg.decomposeExtraCsi > 0 and items1 and #items1 > 0 or msg.decomposeStrengthenCsi > 0 and items2 and #items2 > 0 then
				local petItems = MaterialController.instance:___getTempItemsByChangeSetIdOnlyRead(msg.changeSetId)

				if petItems then
					for i = #petItems, 1, -1 do
						if petItems[i].type == MatType.Pet then
							table.remove(petItems, i)
						end
					end
				end
			end

			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.MATERILAL_CARD, msg.changeSetId)
		end

		if msg.decomposeExtraCsi > 0 then
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.MATERILAL_CARD, msg.decomposeExtraCsi)
		end

		if msg.decomposeStrengthenCsi > 0 then
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.MATERILAL_CARD, msg.decomposeStrengthenCsi)
		end
	else
		printInfo("test 请求失败>> 资源卡 金钻卡 抽卡 ")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onFamilyDonateRes(status, msg)
	if status == 0 then
		printInfo("test 保存奖励 > 家族捐献 changeSetId = ", msg.changeSetId, "funcType = ", XiaoNuoAssistantModel.FuncEnum.FAMILY_DONATE)

		if msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.FAMILY_DONATE, msg.changeSetId)
		end
	else
		printInfo("test 请求失败>> 家族捐献 ")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onNotifyPayShopItemBuySucRes(status, msg)
	if status == 0 and msg.changeSetId > 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)

		if self._curFuncId == XiaoNuoAssistantModel.FuncEnum.PAY_SHOP then
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.PAY_SHOP, msg.changeSetId)
		elseif self._curFuncId == XiaoNuoAssistantModel.FuncEnum.TimeWheel_Exchange then
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.TimeWheel_Exchange, msg.changeSetId)
		end
	end
end

function AssistantRewardView:_onBuyItemRes(status, msg)
	if status == 0 then
		-- block empty
	elseif self._curFuncId == XiaoNuoAssistantModel.FuncEnum.PAY_SHOP then
		printInfo("test 请求失败>> 9折购买 ")
	elseif self._curFuncId == XiaoNuoAssistantModel.FuncEnum.TimeWheel_Exchange then
		printInfo("test 请求失败>> 溯源商店购买 ")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onTurnTimeWarriorTowerRes(status, msg)
	if status == 0 then
		if msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.WARRIOR_TOWER_TURN_TIME, msg.changeSetId)
		end
	else
		printInfo("test 请求失败>> 勇者之塔-产出购买")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onGainBreakFormationBuyTimesRes(status, msg)
	if status == 0 then
		-- block empty
	else
		printInfo("test 请求失败>>破阵天下购买次数")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onBreakFormationQuickPassRes(status, msg)
	if status == 0 then
		if msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.BoZhenTianXia, msg.changeSetId)
		end

		BreakFormationController.instance:onQuickPassXiaoNuoRes(msg)
	else
		printInfo("test 请求失败>> 破阵天下首通奖励")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onGainBreakFormationOneKeyGainProgressPrizeRes(status, msg)
	if status == 0 then
		if msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.BoZhenTianXia, msg.changeSetId)
		end

		BreachFormationAgent.instance:sendPM_BreachFormationGetUserInfoReq(function(msg)
			BreakFormationModel.instance:handlePM_BreachFormationGetUserInfoRes(msg)
		end)
	else
		printInfo("test 请求失败>> 破阵天下一键领取进度奖励")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onGainCutePetBuildingOneKeyGainPrizeRes(status, msg)
	if status == 0 then
		if msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.CutePet, msg.changeSetId)
		end
	else
		printInfo("test 请求失败>> 萌宠园-一键领取冒险奖励")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onGainFamilyTaskPrizeOneKeyGainPrizeRes(status, msg)
	if status == 0 then
		if msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.FAMILY_TASK, msg.changeSetId)
		end
	else
		printInfo("test 请求失败>> 家族任务-一键领取家族任务")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onGainWarriorTowerProfitPrizeRes(status, msg)
	if status == 0 then
		if msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.WARRIOR_TOWER_TURN_TIME, msg.changeSetId)
		end
	else
		printInfo("test 请求失败>> 勇者之塔-宝箱奖励")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onGFNotifyAfterHandleEventRes(status, msg)
	if status == 0 then
		if msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.GOOD_FEELING_ANSWER, msg.changeSetId)
		end
	else
		printInfo("test 请求失败>> 好感度答题")
	end
end

function AssistantRewardView:_onGFHandleEventRes(status, msg)
	self:_sendNextRequest()
end

function AssistantRewardView:_onSweepsByTimesRes(status, msg)
	if status == 0 then
		self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.LEGEND_CHALLENGE_SWEEP, msg.changeSetId, msg)
	else
		printInfo("test 请求失败>> 精灵挑战奖励")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onMCLG_SweepsByTimesRes(status, msg)
	if status == 0 then
		self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.MATERIAL_CHALLENGE_SWEEP, nil, msg)
	else
		printInfo("test 请求失败>> 资源副本奖励")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onGainTaskPrizeRes(status, msg)
	if status == 0 then
		if msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.ONE_KEY_DISPATCH, msg.changeSetId)
		end
	else
		printInfo("test 请求失败>> 领取任务奖励")
		self:_sendNextRequest()
	end
end

function AssistantRewardView:_onDispatchPetsRes(status, msg)
	self:_sendNextRequest()
end

function AssistantRewardView:_onGainVipDailyBonusRes(status, msg)
	if status == 0 then
		if msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.VIP_REWARD, msg.changeSetId)
		end
	else
		printInfo("test 请求失败>> 领取VIP每日奖励")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onAnnuityGainWeeklyPrizeRes(status, msg)
	if status == 0 then
		if msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.YEAR_REWARD, msg.changeSetId)
		end
	else
		printInfo("test 请求失败>> 年费奖励-每周奖励")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onAnnuityGainMonthPrizeRes(status, msg)
	if status == 0 then
		if msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.YEAR_REWARD, msg.changeSetId)
		end
	else
		printInfo("test 请求失败>> 年费奖励-每月奖励")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onArenaChallengeRes(status, msg)
	if status == 0 then
		printInfo("test 保存奖励 > 竞技场 changeSetId = ", msg.changeSetId, "funcType = ", XiaoNuoAssistantModel.FuncEnum.ARENA)

		if msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.ARENA, msg.changeSetId)
		end
	else
		printInfo("test 请求失败>> 竞技场-竞技场")
	end

	self:_sendNextRequest(true)
end

function AssistantRewardView:_onArena3v3ChallengeRes(status, msg)
	if status == 0 then
		printInfo("test 保存奖励 > 竞技场-3v3高阶竞技场 changeSetId = nil, funcType = ", XiaoNuoAssistantModel.FuncEnum.ARENA)
	else
		printInfo("test 请求失败>> 竞技场-3v3高阶竞技场")
	end

	self:_sendNextRequest(true)
end

function AssistantRewardView:_onLingWenSweepRes(status, msg)
	if status == 0 then
		self:_onNotifyReward(XiaoNuoAssistantModel.FuncEnum.LingWen, nil, msg)
	else
		printInfo("test 请求失败>> 灵纹幻境")
	end

	self:_sendNextRequest()
end

function AssistantRewardView:_onReloadFinish()
	if self._isFinishExcute then
		GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantFinishExcute)
	end
end

function AssistantRewardView:_updateCell(view, cell, data, tag)
	local cls = GameUtil.AddLuaOnce(cell.gameObject, AssistantRewardCell)

	cls:init(data, self._scrollrect)
end

function AssistantRewardView:_clearCell(cell)
	local cls = GameUtil.GetLua(cell.gameObject, AssistantRewardCell)

	if cls then
		cls:reset()
	end
end

function AssistantRewardView:_initRewardInfos()
	local funcIndexList = XiaoNuoAssistantModel.TabList[self._curTabIndex]

	for _, sendMo in ipairs(self._xiaoNuoSendMoList) do
		self._xiaoNuoSendMoDic[sendMo.funcEnum] = sendMo
	end

	for _, funcEnum in ipairs(funcIndexList) do
		local sendMo = self._xiaoNuoSendMoDic[funcEnum]

		if sendMo then
			if #sendMo.resultItemList > 0 then
				for _, resultItem in ipairs(sendMo.resultItemList) do
					self:_addRewardInfo(sendMo, resultItem)
				end
			else
				self:_addRewardInfo(sendMo)
			end
		end
	end

	self.scrollList:reloadData({})

	for _, v in ipairs(self._xiaoNuoSendMoList) do
		table.insertto(self._callbackList, v.callbackList)

		local count = #v.callbackList

		for i = 1, count do
			table.insert(self._funcIdList, v.funcEnum)
			table.insert(self._callbackStageList, v.callbackStageList[i] or false)
		end
	end

	self._calbackMaxIndex = #self._callbackList
end

function AssistantRewardView:_addRewardInfo(sendMo, resultItem)
	local mo = {}

	mo.funcIndex = sendMo.funcEnum
	mo.rewardList = {}
	mo.sendMo = sendMo
	mo.resultItem = resultItem

	table.insert(self._rewardInfoList, mo)
end

function AssistantRewardView:_sendNextRequest(isExcuteInterval)
	if self._callbackIndex <= self._calbackMaxIndex then
		local callback = self._callbackList[self._callbackIndex]

		self._curFuncId = self._funcIdList[self._callbackIndex] or 0
		self._curCallbackStage = self._callbackStageList[self._callbackIndex]
		self._callbackIndex = self._callbackIndex + 1

		local curSendMo = self._xiaoNuoSendMoDic[self._curFuncId]

		if curSendMo then
			curSendMo:addExcuteCount()

			if isExcuteInterval and curSendMo:isNeedInterval() then
				TweenUtil.DoDelay(curSendMo:getExcuteInterval(), function()
					printInfo("test 执行时间 = ", ServerTime.now())
					GameUtil.callBack(callback)
				end)
			else
				GameUtil.callBack(callback)
			end
		else
			printError("curSendMo is nil")
		end
	else
		FloatWordMgr.instance:show("执行完成")
		printInfo("test 奖励领取完成")

		self._isFinishExcute = true

		for i, v in ipairs(self._rewardInfoList) do
			v.isFinishExcute = true
		end

		self.scrollList:reloadData(self._rewardInfoList)
		goutil.setActive(self._excuting, false)
	end
end

return AssistantRewardView
