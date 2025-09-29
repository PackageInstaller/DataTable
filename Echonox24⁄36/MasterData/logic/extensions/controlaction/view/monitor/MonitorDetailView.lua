-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/monitor/MonitorDetailView.lua

module("logic.extensions.controlaction.view.monitor.MonitorDetailView", package.seeall)

local M = class("MonitorDetailView")
local LvLimitedKey = WordEnum.LvLimit

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()
end

function M:_buildUI()
	self._imgIcon = goutil.findChildImageComponent(self._mainGo, "unlock/imgIcon")
	self._txtName = goutil.findChildTextComponent(self._mainGo, "txtName")
	self._txtDesc = goutil.findChildComponent(self._mainGo, "txtContent", UIComponentType.TextMeshProUGUI)
	self._txtCost = goutil.findChildTextComponent(self._mainGo, "btnTake/txtCost")

	local btnBookGo = goutil.findChild(self._mainGo, "btnBook")
	local btnTakeGo = goutil.findChild(self._mainGo, "btnTake/button1")
	local btnQuickTakeGo = goutil.findChild(self._mainGo, "btnTake/button2")
	local btnTake2Go = goutil.findChild(self._mainGo, "btnTake/button3")
	local clickGo = goutil.findChild(self._mainGo, "rewardContent/click")

	self._btnBook = Astral.ButtonAdapter.Get(btnBookGo)
	self._btnTake = Astral.ButtonAdapter.Get(btnTakeGo)
	self._btnTake2 = Astral.ButtonAdapter.Get(btnTake2Go)
	self._btnQuickTake = Astral.ButtonAdapter.Get(btnQuickTakeGo)
	self._btnPreview = Astral.ButtonAdapter.Get(clickGo)
	self._rewardListGo = goutil.findChild(self._mainGo, "rewardContent/itemList")
	self._rewardItem = goutil.findChild(self._mainGo, "rewardContent/itemList/item1")

	goutil.addChildToParent(self._rewardItem, goutil.findChild(self._mainGo, "rewardContent"))
	goutil.setActive(self._rewardItem, false)

	self._textLvLimit = goutil.findChildTextComponent(self._mainGo, "txtLvSuppress")
	self._btnLvLimit = Astral.ButtonAdapter.Get(goutil.findChild(self._mainGo, "txtLvSuppress/clickBtn"))
	self._goTipsPos = goutil.findChild(self._mainGo, "tipsPos")
	self._goLvLimit = goutil.findChild(self._mainGo, "txtLvSuppress")
	self._doubleHintGo = goutil.findChild(self._mainGo, "rewardContent/doubleHint")
	self._txtNumberMultiple = goutil.findChildTextComponent(self._mainGo, "rewardContent/doubleHint/txtNum")
	self._txtTimesMultiple = goutil.findChildTextComponent(self._mainGo, "rewardContent/doubleHint/Text1")

	self:_bindEvents()
end

function M:_bindEvents()
	self._btnBook:AddClickListener(self._onClickBook, self)
	self._btnTake:AddClickListener(self._onClickTake, self)
	self._btnTake2:AddClickListener(self._onClickTake, self)
	self._btnQuickTake:AddClickListener(self._onClickQuickTake, self)
	self._btnPreview:AddClickListener(self._onClickPreview, self)
	self._btnLvLimit:AddClickListener(self._onClickLvLimit, self)
	GlobalDispatcher:addEventListener(EventType.ON_MULTI_FIGHT_TIPS_CONFIRM, self._handleQuickFight, self)
end

function M:_unbindEvents()
	self._btnBook:RemoveClickListener()
	self._btnTake:RemoveClickListener()
	self._btnTake2:RemoveClickListener()
	self._btnQuickTake:RemoveClickListener()
	self._btnPreview:RemoveClickListener()
	self._btnLvLimit:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.ON_MULTI_FIGHT_TIPS_CONFIRM, self._handleQuickFight, self)
end

function M:OnDestroy()
	self:_unbindEvents()
end

function M:initViewID(id)
	self._viewId = id
end

function M:_onClickLvLimit()
	local info = {
		wordKey = LvLimitedKey,
		lvLimited = self._limitCo.heroLvLimit,
		bindGo = self._goTipsPos
	}

	ViewMgr.instance:open(ViewName.ControlActionLvLimitView, info)
end

function M:_onClickBook()
	ViewMgr.instance:close(ViewName.ControlActionMonitor)

	if not self._dungeonMo:hasPassed() then
		if not self._preMo then
			ViewMgr.instance:open(ViewName.ControlActionManual)
		else
			ViewMgr.instance:open(ViewName.ControlActionManual, self._id)
		end
	else
		ViewMgr.instance:open(ViewName.ControlActionManual, self._id)
	end
end

function M:_isWeekLimit(showTips)
	local isTeachDungeon = ControlActionConfig.instance:isTeachDungeon(self._id, self._dungeonMo:getId())

	if ControlActionModel.instance:getWeekLeftTimes() <= 0 and not isTeachDungeon then
		if showTips then
			FloatWordMgr.instance:show(lang("control_action_week_limit"))
		end

		return true
	end

	return false
end

function M:_onClickTake()
	local info = {}

	info.dungeonCode = self._dungeonMo:getId()
	info.afflatusBuff = false
	info.isShowPlot = false
	info.multiCount = 1
	info.gamePlay = BattleEnum.GamePlayType.NORMAL

	if not self._dungeonMo:getIsPlotNode() then
		if info.multiCount * self._dungeonMo:getPointCost() > ItemModel.instance:getItemCountByItemId(GameEnum.CurrencyCodeEnum.TlCode) then
			ToolTipsMgr.showHealthExchangeTips()

			return
		end

		BattleCalculateModel.instance:setDefaultItemMoList(self._dungeonMo:getPointCost())
	end

	if self:_isWeekLimit(true) then
		return
	end

	if not self._preMo then
		DungeonController.instance:startDungeonBattle(info)
		ControlActionModel.instance:setBattleInfo(self._viewId, self._difficultIndex)

		return
	end

	if PlayerModel.instance:getLevel() < self._limitCo.level then
		FloatWordMgr.instance:show(lang("tip_system_open_not_online"))

		return
	end

	if self._preMo:hasPassed() then
		DungeonController.instance:startDungeonBattle(info)
		ControlActionModel.instance:setBattleInfo(self._viewId, self._difficultIndex)
	else
		FloatWordMgr.instance:show(lang("tip_pre_difficult_notpass"))
	end
end

function M:_onClickQuickTake()
	local gamePlay = BattleEnum.GamePlayType.CONSECUTIVE
	local maxMultiCount = 0

	if gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
		if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DungeonConsecutiveBattle, true) then
			return
		end

		maxMultiCount = self._limitCo.consecutive

		if maxMultiCount <= 0 then
			FloatWordMgr.instance:show(lang("tip_not_open_consecutive"))

			return
		end
	elseif gamePlay == BattleEnum.GamePlayType.RECORD then
		if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DungeonMultipleBattle, true) then
			return
		end

		maxMultiCount = self._limitCo.multiplicityLimit
	end

	maxMultiCount = math.min(maxMultiCount, ControlActionModel.instance:getWeekLeftTimes())

	if not self._dungeonMo:hasPassed() then
		if gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
			FloatWordMgr.instance:show(lang("tip_pass_open_consecutive"))
		elseif gamePlay == BattleEnum.GamePlayType.RECORD then
			FloatWordMgr.instance:show(lang("tip_pass_open_multiple"))
		end

		return
	end

	if self:_isWeekLimit(true) then
		return
	end

	local param = {}

	param.dungeonMo = self._dungeonMo
	param.rewardCodeConst = self._rewardCodeConst
	param.rewardCodeInfo = self._rewardCodeInfo
	param.rewardCodeZone = self._rewardCodeZone
	param.canProxy = self._dungeonMo:canRecord()
	param.gamePlay = gamePlay
	param.maxMultiCount = maxMultiCount

	ViewMgr.instance:open(ViewName.ControlActionQuickTake, param)
end

function M:_onClickPreview()
	if self._rewardCodeInfo == 0 and self._rewardCodeZone == 0 then
		return
	end

	local param = {}

	param.dungeonMo = self._dungeonMo
	param.rewardCodeConst = self._rewardCodeConst
	param.rewardCodeInfo = self._rewardCodeInfo
	param.rewardCode = self._rewardCode
	param.rewardCodeZone = self._rewardCodeZone

	GlobalDispatcher:dispatchEvent(EventType.CONTROLACTION_MONITOR_REWARD, param)
end

function M:_handleQuickFight(e, infoQuick)
	local info = {}

	info.dungeonCode = infoQuick.dungeonId
	info.afflatusBuff = false
	info.isShowPlot = false
	info.multiCount = infoQuick.multiCount
	info.viewId = self._viewId
	info.difficultIndex = self._difficultIndex
	info.gamePlay = infoQuick.gamePlay

	DungeonController.instance:startDungeonBattle(info)
end

function M:refresh(data, preMo, info)
	self._dungeonMo = data
	self._preMo = preMo
	self._id = info.id
	self._rewardCodeConst = ConstConfig.instance:getNumValueByKey("ControlActionReward")
	self._rewardCodeInfo = info.rewardCodeInfo
	self._rewardCodeZone = info.rewardCodeZone
	self._viewId = info.viewId
	self._difficultIndex = info.difficultIndex
	self._txtName.text = self._dungeonMo:getName()
	self._txtDesc.text = self._dungeonMo:getDesc()
	self._txtCost.text = self._dungeonMo:getPointCost()

	local dungeonCode = self._dungeonMo:getId()

	self._limitCo = ControlActionConfig.instance:getMonitorDungeonLimitCfg(dungeonCode)

	local isShow = true
	local gamePlay = BattleEnum.GamePlayType.CONSECUTIVE

	if gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
		local maxMultiCount = self._limitCo.consecutive

		isShow = self._dungeonMo:hasPassed() and maxMultiCount and maxMultiCount > 0

		SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DungeonConsecutiveBattle, false)
	elseif gamePlay == BattleEnum.GamePlayType.RECORD then
		isShow = self._dungeonMo:hasPassed() and self._limitCo.canMultiplicityCost == 1 and SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DungeonMultipleBattle, false)
	end

	goutil.setActive(self._goLvLimit, self._limitCo.heroLvLimit > 0)

	self._textLvLimit.text = langF("control_action_lv_limit", self._limitCo.heroLvLimit)

	goutil.setActive(self._btnQuickTake.gameObject, isShow)
	goutil.setActive(self._btnTake2.gameObject, isShow)
	goutil.setActive(self._btnTake.gameObject, not isShow)
	self:_refreshReward()
	self:_refreshMultipleDrop()
end

function M:_refreshReward()
	goutil.clearChildren(self._rewardListGo)

	if self._rewardCodeInfo == 0 and self._rewardCodeZone == 0 then
		return
	end

	local count = 0
	local maxCount = 3
	local allRewardList = {}
	local normalList1 = ControlActionModel.instance:getRewardLstNormal(self._rewardCodeConst)
	local randomList1 = ControlActionModel.instance:getRewardLstRandom(self._rewardCodeConst)

	for i, v in ipairs(normalList1) do
		table.insert(allRewardList, v)
	end

	for i, v in ipairs(randomList1) do
		table.insert(allRewardList, v)
	end

	local normalList2 = ControlActionModel.instance:getRewardLstNormal(self._rewardCodeInfo)
	local randomList2 = ControlActionModel.instance:getRewardLstRandom(self._rewardCodeInfo)

	for i, v in ipairs(normalList2) do
		table.insert(allRewardList, v)
	end

	for i, v in ipairs(randomList2) do
		table.insert(allRewardList, v)
	end

	local normalList3 = ControlActionModel.instance:getRewardLstNormal(self._rewardCodeZone)
	local randomList3 = ControlActionModel.instance:getRewardLstRandom(self._rewardCodeZone)

	for i, v in ipairs(normalList3) do
		table.insert(allRewardList, v)
	end

	for i, v in ipairs(randomList3) do
		table.insert(allRewardList, v)
	end

	if not self._dungeonMo:hasPassed() then
		local _tmpTable = {}

		for i, reward in ipairs(self._dungeonMo:getAllFirstPassReward()) do
			table.insert(_tmpTable, ItemUtil.createItemData({
				itemId = reward.code,
				count = reward.num
			}))
		end

		if #_tmpTable > 0 then
			table.sort(_tmpTable, ItemUtil.commonSortFunc)

			for _, _itemData in ipairs(_tmpTable) do
				local obj = goutil.clone(self._rewardItem, "item")

				obj:SetActive(true)
				goutil.addChildToParent(obj, self._rewardListGo)

				local objBeh = Astral.LuaComponentContainer.Add(obj, RewardCell)
				local rewardData = RewardData.New({
					code = _itemData:getItemId(),
					count = _itemData:getCount(),
					rewardStatus = self._dungeonMo:hasPassed() and CommEnum.RewardEnum.HasGot or CommEnum.RewardEnum.CanNotGot,
					itemSign = CommEnum.BackPackItemSignTyp.First
				})

				objBeh:updateData(rewardData)

				count = count + 1

				if maxCount <= count then
					return
				end
			end
		end
	end

	if #allRewardList > 0 then
		table.sort(allRewardList, ItemUtil.commonSortFunc)
	end

	for i, itemData in ipairs(allRewardList) do
		local obj = goutil.clone(self._rewardItem, "item")

		obj:SetActive(true)
		goutil.addChildToParent(obj, self._rewardListGo)

		local objBeh = Astral.LuaComponentContainer.Add(obj, RewardCell)
		local rewardData = RewardData.New({
			code = itemData:getItemId(),
			rewardStatus = CommEnum.RewardEnum.CanNotGot
		})

		objBeh:updateData(rewardData)

		count = count + 1

		if maxCount <= count then
			return
		end
	end
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

return M
