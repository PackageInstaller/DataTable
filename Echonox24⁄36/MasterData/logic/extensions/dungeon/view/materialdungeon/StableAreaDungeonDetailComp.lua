-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/materialdungeon/StableAreaDungeonDetailComp.lua

module("logic.extensions.dungeon.view.materialdungeon.StableAreaDungeonDetailComp", package.seeall)

local M = class("StableAreaDungeonDetailComp", ViewComponent)
local RewardEnum = CommEnum.RewardEnum
local SignTyp = CommEnum.BackPackItemSignTyp

function M:ctor()
	self._rewardGoList = {}
	self._ememyGoList = {}
end

function M:buildUI()
	self._textName = self:getText("stable_area_chapters_view_-236092512")
	self._textNum = self:getText("stable_area_chapters_view_-1341491592")
	self._goDifficultyFlag = self:getGo("1&instance_danger_-1654566369")
	self._transfRewardRoot = self:getRectTransform("stable_area_chapters_view_-1981974375")
	self._starFinishSignGoList = {
		self:getGo("stable_area_chapters_view_-1034083741"),
		self:getGo("stable_area_chapters_view_2071565361"),
		self:getGo("stable_area_chapters_view_-1805224189")
	}
	self._starDescTxtList = {
		self:getText("stable_area_chapters_view_1385014711"),
		self:getText("stable_area_chapters_view_-2070327041"),
		self:getText("stable_area_chapters_view_433522888")
	}
	self._transfEnemyRoot = self:getRectTransform("stable_area_chapters_view_-2038098754")
	self._btnMoreReward = self:getBtn("stable_area_chapters_view_-440926356")
	self._goBtns1 = self:getGo("stable_area_chapters_view_-143722429")
	self._goBtns2 = self:getGo("stable_area_chapters_view_-1439337759")
	self._costCell1 = PrefabReferenceUtil.createCurrencyCostLuaCell(self:getGo("14&com_price_1317146225"))
	self._costCell2 = PrefabReferenceUtil.createCurrencyCostLuaCell(self:getGo("15&com_price_1317146225"))
	self._btnEnemy = self:getBtn("stable_area_chapters_view_-63366535")
	self._quickFightCell = Astral.SimpleLuaComponentContainer.Add(self:getGo("8&btn_left_-1571983320"), CommButton)
	self._fightBtnCell1 = Astral.SimpleLuaComponentContainer.Add(self:getGo("9&btn_right_1251431307"), CommButton)
	self._fightBtnCell2 = Astral.SimpleLuaComponentContainer.Add(self:getGo("11&btn_middle_-31477526"), CommButton)
	self._textFight = self:getText("8&btn_left_423343501")
	self._doubleHintGo = self:getGo("13&com_multiple_rewards_right_hint_1207926246")
	self._txtNumberMultiple = self:getText("13&com_multiple_rewards_right_hint_1142272974")
	self._txtTimesMultiple = self:getText("13&com_multiple_rewards_right_hint_490855671")
end

function M:bindEvents()
	self._btnMoreReward:AddClickListener(self._onClickMoreReward, self)
	self._btnEnemy:AddClickListener(self._onClickBtnEnemy, self)
	self._fightBtnCell1:AddClickListener(self._onClickStartFight, self)
	self._fightBtnCell2:AddClickListener(self._onClickStartFight, self)
	self._quickFightCell:AddClickListener(self._onClickQuickFight, self)
end

function M:unbindEvents()
	self._btnMoreReward:RemoveClickListener()
	self._btnEnemy:RemoveClickListener()
	self._fightBtnCell1:RemoveClickListener()
	self._fightBtnCell2:RemoveClickListener()
	self._quickFightCell:RemoveClickListener()
end

function M:onEnter()
	self:_bindDispatcherEvent()
end

function M:onExit()
	self:_unbindDispatcherEvent()
end

function M:destroyUI()
	self._rewardGoList = nil
	self._ememyGoList = nil
end

function M:_bindDispatcherEvent()
	GlobalDispatcher:addEventListener(EventType.ON_DUNGEON_DANGER_TIPS_CONFIRM, self._goFight, self)
	GlobalDispatcher:addEventListener(EventType.ON_MULTI_FIGHT_TIPS_CONFIRM, self._handleMultiFightTipsConfirm, self)
end

function M:_unbindDispatcherEvent()
	GlobalDispatcher:removeEventListener(EventType.ON_DUNGEON_DANGER_TIPS_CONFIRM, self._goFight, self)
	GlobalDispatcher:removeEventListener(EventType.ON_MULTI_FIGHT_TIPS_CONFIRM, self._handleMultiFightTipsConfirm, self)
end

function M:setData(dungeonMo, chapterMo, dungeonIndex)
	self._dungeonMo = dungeonMo
	self._dungeonId = dungeonMo:getId()
	self._dungeonIndex = dungeonIndex
	self._chapterMo = chapterMo
	self._gamePlay = BattleEnum.GamePlayType.RECORD

	self:_refreshUI()
end

function M:_refreshUI()
	self:_refreshBaseInfo()
	self:_refreshStarPanel()
	self:_refreshEnemyPanel()
	self:_refreshRewardPanel()
	self:_refreshBottomPanel()
	self:_refreshMultipleDrop()
end

function M:_refreshMultipleDrop()
	local type = self._dungeonMo:getType()
	local isShow = false
	local redPointMultiple = RedDotModel.instance:getRedDotDetailList(GameEnum.RedPointEnum.DungeonRewardUp) or {}

	for k, v in ipairs(redPointMultiple) do
		if tonumber(v) == type then
			isShow = true
		end
	end

	if isShow then
		local rewardId = self._dungeonMo:getImportantPassReward()
		local tabelT = MultipleDropController.instance:getLeftNumberByTypeAndReward(type, rewardId)

		if tabelT.times == "" or tabelT.leftNumber == 0 then
			isShow = false
		else
			self._txtNumberMultiple.text = tabelT.left
			self._txtTimesMultiple.text = tabelT.times
		end
	end

	goutil.setActive(self._doubleHintGo.gameObject, isShow)
end

function M:_refreshBaseInfo()
	self._textName.text = self._dungeonMo:getName()
	self._textNum.text = string.format("%02d", self._dungeonIndex)

	local scoreRate = DungeonModel.instance:getDungeonScoreRate(self._dungeonId) * 1000
	local scoreCO = DungeonConfig.instance:getDungeonScoreCOByScore(scoreRate, self._dungeonMo:getScoreGroup())

	DifficultyUtil.setDifficultyFlag(self._goDifficultyFlag, scoreCO)

	local cost = self._dungeonMo:getPointCost()

	self._costCell1:updateData(CommEnum.CurrencyCodeEnum.TlCode, cost)
	self._costCell2:updateData(CommEnum.CurrencyCodeEnum.TlCode, cost)
end

function M:_refreshStarPanel()
	local star = self._dungeonMo:getStar()
	local starRequire = self._dungeonMo:getStarRequire()

	for i = 1, 3 do
		goutil.setActive(self._starFinishSignGoList[i], star[i])

		local dungeonStarCOWrapper = DungeonConfig.instance:getDungeonStarCOWrapper(starRequire[i])

		self._starDescTxtList[i].text = dungeonStarCOWrapper:getDescription()
		self._starDescTxtList[i].color = star[i] and Astral.ColorUtil.ParseColor("#ffffff") or Astral.ColorUtil.ParseColor("#747474")
	end
end

function M:_refreshEnemyPanel()
	local enemyList = self._dungeonMo:getEnemyIds()

	for _, go in ipairs(self._ememyGoList) do
		goutil.setActive(go, false)
	end

	for index, enemyId in ipairs(enemyList) do
		local go = self._ememyGoList[index]

		if go == nil then
			go = self:getResInstance(ResName.Common_hero_item)

			goutil.addChildToParent(go, self._transfEnemyRoot)

			self._ememyGoList[index] = go
		end

		go:SetActive(true)

		local cell = Astral.SimpleLuaComponentContainer.Add(go, CommMonsterHeadCell)

		cell:setData(enemyId)
		cell:setClickListener(self._onClickEnemyCell, self)
	end
end

function M:_refreshRewardPanel()
	local allRewardList = self:_getAllReward()

	for _, go in pairs(self._rewardGoList) do
		goutil.setActive(go, false)
	end

	for i = 1, #allRewardList do
		local go = self._rewardGoList[i]

		if not go then
			go = self:getResInstance(ResName.Common_Backpack_Item)

			goutil.addChildToParent(go, self._transfRewardRoot)

			self._rewardGoList[i] = go
		end

		local rewardCell = Astral.SimpleLuaComponentContainer.Add(go, RewardCell)
		local data = allRewardList[i]

		rewardCell:updateData(data)
		goutil.setActive(self._rewardGoList[i], true)
	end
end

function M:_getAllReward()
	local hasPassed = self._dungeonMo:hasPassed()
	local allRewardList = {}

	if not hasPassed then
		local firstRewards = self._dungeonMo:getAllFirstPassReward()
		local firstRewardList = self:_createRewardData(firstRewards, RewardEnum.HasGot, SignTyp.First, SignTyp.First)

		TableUtil.addRange(allRewardList, firstRewardList)
	end

	local importRewards = self._dungeonMo:getImportantPassReward()
	local rewardsAdapter = {}

	for _, code in ipairs(importRewards) do
		table.insert(rewardsAdapter, {
			num = 0,
			code = code
		})
	end

	local importRewardList = self:_createRewardData(rewardsAdapter, RewardEnum.CanNotGot)

	TableUtil.addRange(allRewardList, importRewardList)

	if hasPassed and #allRewardList == 0 then
		local gotRewards = self._dungeonMo:getAllFirstPassReward()
		local gotRewardList = self:_createRewardData(gotRewards, RewardEnum.HasGot, SignTyp.Get, SignTyp.Get)

		TableUtil.addRange(allRewardList, gotRewardList)
	end

	return allRewardList
end

function M:_createRewardData(rewards, rewardStatus, itemSign, signTyp)
	local itemList = {}
	local dataList = {}

	for _, reward in ipairs(rewards) do
		table.insert(itemList, ItemUtil.createItemData({
			itemId = reward.code,
			count = reward.num
		}))
	end

	table.sort(itemList, ItemUtil.commonSortFunc)

	for _, itemData in ipairs(itemList) do
		local count = itemData:getCount()
		local rewardData = RewardData.New({
			code = itemData:getItemId(),
			count = count ~= 0 and count or nil,
			rewardStatus = rewardStatus,
			itemData = itemData,
			itemSign = itemSign,
			signTyp = signTyp,
			clickCallBack = self._onClickMoreReward,
			clickCallBackObj = self
		})

		table.insert(dataList, rewardData)
	end

	return dataList
end

function M:_refreshBottomPanel()
	local showBtn = true
	local isPassed = self._dungeonMo:hasPassed()

	if self._gamePlay == BattleEnum.GamePlayType.RECORD then
		self._textFight.text = lang("multi_fight_title")
		showBtn = isPassed and self._chapterMo:getCanOpenMulti() and SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DungeonMultipleBattle, false)
	elseif self._gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
		local maxCount = self._chapterMo:getConsecutiveLimit()

		showBtn = isPassed and maxCount and maxCount > 0 and SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DungeonConsecutiveBattle, false)
	end

	local isUnlock = self._dungeonMo:getIsUnlock()

	self._fightBtnCell1:setActiveState(isUnlock)
	self._fightBtnCell2:setActiveState(isUnlock)
	self._quickFightCell:setActiveState(isUnlock)
	goutil.setActive(self._goBtns1, showBtn)
	goutil.setActive(self._goBtns2, not showBtn)
end

function M:_openEnemyView()
	local info = {}

	info.dungeonMo = self._dungeonMo

	ViewMgr.instance:open(ViewName.DungeonEnemy, info)
end

function M:_formatLevel(level)
	local a = math.floor(level / 10)
	local b = level % 10

	return string.format("%s-%s", a, b)
end

function M:_onClickEnemyCell()
	return
end

function M:_onClickBtnEnemy()
	return
end

function M:_onClickMoreReward()
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_click)
	ViewMgr.instance:open(ViewName.DungeonRewardDetailView, self._dungeonId)
end

function M:_onClickQuickFight()
	local chapterMo = self._chapterMo
	local dungeonMo = self._dungeonMo
	local hasPassed = dungeonMo:hasPassed()
	local canOpenMulti = chapterMo:getCanOpenMulti()
	local canQuickFight = false
	local canProxy = chapterMo:canProxy()
	local maxCount = 0

	if self._gamePlay == BattleEnum.GamePlayType.RECORD then
		maxCount = chapterMo:getMultiMaxCount()

		if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DungeonMultipleBattle, true) then
			-- block empty
		end

		if not canOpenMulti then
			FloatWordMgr.instance:show(lang("tip_not_open_multiple"))

			return
		elseif not hasPassed then
			FloatWordMgr.instance:show(lang("tip_pass_open_multiple"))

			return
		end
	elseif self._gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
		maxCount = chapterMo:getConsecutiveLimit()

		if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DungeonConsecutiveBattle, true) then
			return
		end

		if maxCount <= 0 then
			FloatWordMgr.instance:show(lang("tip_not_open_consecutive"))

			return
		elseif not hasPassed then
			FloatWordMgr.instance:show(lang("tip_pass_open_consecutive"))

			return
		end
	else
		return
	end

	ToolTipsMgr.showMultiFightTipsView(self._dungeonId, maxCount, canQuickFight, canProxy, self._gamePlay)
end

function M:_onClickStartFight()
	if self._dungeonMo:getIsLock(true) then
		return
	end

	if self._dungeonMo:getPointCost() > ItemModel.instance:getItemCountByItemId(GameEnum.CurrencyCodeEnum.TlCode) then
		ToolTipsMgr.showHealthExchangeTips()

		return
	end

	BattleCalculateModel.instance:setDefaultItemMoList(self._dungeonMo:getPointCost())

	local info = {}

	info.dungeonCode = self._dungeonId
	info.afflatusBuff = false
	info.isShowPlot = true
	info.multiCount = 1
	info.gamePlay = BattleEnum.GamePlayType.NORMAL

	self:_startFight(info)
end

function M:_startFight(info, checkDanger)
	checkDanger = checkDanger == nil and true or checkDanger

	if not checkDanger then
		self:_goFight(false, info)

		return
	end

	local scoreRate = DungeonModel.instance:getDungeonScoreRate(self._dungeonId) * 1000
	local scoreCO = DungeonConfig.instance:getDungeonScoreCOByScore(scoreRate, self._dungeonMo:getScoreGroup())

	if not DungeonController.instance:tryOpenDangerTips(scoreCO, info) then
		self:_goFight(false, info)
	end
end

function M:_goFight(_, info)
	local chapterMo = self._chapterMo

	DungeonMaterialChapterModel.instance:setClickChapterIdAndDungeonIndex(chapterMo:getChapterId(), self._dungeonIndex)
	SceneFace.instance:exitScene()
	Astral.LocalStorage.Instance:SetString("dungeon_latest_type", string.format("2,%d,%02d", chapterMo:getChapterId(), self._dungeonIndex))
	Astral.LocalStorage.Instance:SetString("dungeon_latest_id", PlayerModel.instance:getId())
	Astral.LocalStorage.Instance:SetString("dungeon_latest_info", self._dungeonId)
	DungeonController.instance:startDungeonBattle(info)
end

function M:_handleMultiFightTipsConfirm(_, tipsInfo)
	if self._dungeonId ~= tipsInfo.dungeonId then
		return
	end

	local pointCost = self._dungeonMo:getPointCost()

	BattleCalculateModel.instance:setDefaultItemMoList(pointCost * tipsInfo.multiCount)

	local info = {}

	info.dungeonCode = self._dungeonId
	info.afflatusBuff = false
	info.isShowPlot = false
	info.multiCount = tipsInfo.multiCount
	info.gamePlay = tipsInfo.gamePlay

	self:_startFight(info, false)
end

return M
