-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/specialtraining/view/SpecialtrainingView.lua

module("logic.extensions.specialtraining.view.SpecialtrainingView", package.seeall)

local M = class("SpecialtrainingView", ViewComponent)
local iconSkin = {
	"smrtxzc_hero_03",
	"smrtxzc_hero_01",
	"smrtxzc_hero_02"
}

function M:ctor()
	M.super.ctor(self)

	self._planList = false
	self._planCo = false
	self._planId = 0
	self._stageSelected = 1
	self._canGetReward = false
end

function M:buildUI()
	self._iconBigBg = UIComponentType.ImageBigBG(self:getGo("special_training_main_view_704181034"))
	self._taskPanelGo = self:getGo("special_training_main_view_-612870564")
	self._tabGroupGo = self:getGo("special_training_main_view_765097508")
	self._tabGo = self:getGo("special_training_main_view_-1566854751")
	self._scrollRectGo = self:getGo("special_training_main_view_-453127659")
	self._loopList = LoopListHelper.New(self._scrollRectGo)

	self._loopList:InitListView(0, self._updateCell, self)
	goutil.addChildToParent(self._tabGo, self._tabGroupGo.transform.parent)
	goutil.setActive(self._tabGo, false)

	self._txtProcess = self:getText("special_training_main_view_1641437319")
	self._btnGet = Astral.SimpleLuaComponentContainer.Add(self:getGo("9&btn_left_-1571983320"), CommButton)
	self._receivedGo = self:getGo("special_training_main_view_-2072062953")

	local itemGo = self:getGo("6&rewards_detail_item_2141037416")

	self._itemCell = Astral.LuaComponentContainer.Add(itemGo, ItemCell)
	self._animation = self._receivedGo:GetComponent(ComponentType.Animation)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnGet:AddClickListener(self._onClickGet, self)
end

function M:unbindEvents()
	self._btnGet:RemoveClickListener()
end

function M:_addEvents(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.SPECIAL_TRAINING_PLANDATA, self._setViewData, self)
		GlobalDispatcher:addEventListener(EventType.SPECIAL_TRAINING_UPDATETASK, self._refreshTask, self)
		GlobalDispatcher:addEventListener(EventType.SPECIAL_TRAINING_UPDATESTAGE, self._refreshStage, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SPECIAL_TRAINING_PLANDATA, self._setViewData, self)
		GlobalDispatcher:removeEventListener(EventType.SPECIAL_TRAINING_UPDATETASK, self._refreshTask, self)
		GlobalDispatcher:removeEventListener(EventType.SPECIAL_TRAINING_UPDATESTAGE, self._refreshStage, self)
	end
end

function M:onEnter()
	self:_addEvents(true)
	goutil.setActive(self._iconBigBg.gameObject, false)
	SpecialtrainingAgent.instance:sendGrowthTasksRequest()
end

function M:onExit()
	self:_addEvents(false)

	self._planList = false
	self._planCo = false
	self._planId = 0
	self._stageSelected = 1
	self._canGetReward = false
end

function M:onExitFinished()
	self._iconBigBg:ClearImage()
end

function M:_setViewData()
	self._planList = SpecialtrainingModel.instance:getPlans()
	self._planId = SpecialtrainingModel.instance:getPlanId()

	goutil.setActive(self._taskPanelGo, self._planId > 0)

	if self._planId > 0 then
		self._iconBigBg:SetImage(GameUrl.getBigBgUrlSpecialTraining(iconSkin[self._planId]), nil, self)
		goutil.setActive(self._iconBigBg.gameObject, true)
		self:_initTab()

		self._planCo = self._planList[self._planId]

		settimer(0, function()
			self:_tabClick(SpecialtrainingModel.instance:getCurrentStageIndex())
		end, self, false)
	end
end

function M:_initTab()
	local stageList = {}

	for i, v in ipairs(self._planList) do
		if v.id == self._planId then
			stageList = v.stages
		end
	end

	local stageIndex = SpecialtrainingModel.instance:getCurrentStageIndex()

	goutil.clearChildren(self._tabGroupGo)

	for i, v in ipairs(stageList) do
		local tabGo = goutil.clone(self._tabGo, "stage" .. i)

		goutil.setActive(tabGo, true)
		goutil.addChildToParent(tabGo, self._tabGroupGo)

		local txtNormal = goutil.findChildTextComponent(tabGo, "normal/Text1")
		local txtselect = goutil.findChildTextComponent(tabGo, "select/Text1")
		local imgBottom1 = goutil.findChild(tabGo, "img1/imgBottom1")
		local imgBottom2 = goutil.findChild(tabGo, "img1/imgBottom2")
		local finishFlag = goutil.findChild(tabGo, "imgOver")
		local finishFlag1 = goutil.findChild(tabGo, "normal/img1")
		local finishFlag2 = goutil.findChild(tabGo, "select/img1")

		goutil.setActive(imgBottom1, i < #stageList)
		goutil.setActive(imgBottom2, i >= #stageList)
		goutil.setActive(finishFlag, i <= stageIndex)
		goutil.setActive(finishFlag1, i < stageIndex)
		goutil.setActive(finishFlag2, i < stageIndex)

		txtNormal.text = lang("tip_specialtrain_period") .. i
		txtselect.text = lang("tip_specialtrain_period") .. i

		local button = Astral.ButtonAdapter.Get(tabGo)

		button:AddClickListener(function()
			self:_tabClick(i)
		end, self)
	end
end

function M:_updateTabFlag()
	local stageIndex = SpecialtrainingModel.instance:getCurrentStageIndex()

	for i = 1, self._tabGroupGo.transform.childCount do
		local tabGo = goutil.findChild(self._tabGroupGo, "stage" .. i)
		local finishFlag = goutil.findChild(tabGo, "imgOver")
		local finishFlag1 = goutil.findChild(tabGo, "normal/img1")
		local finishFlag2 = goutil.findChild(tabGo, "select/img1")

		goutil.setActive(finishFlag, i <= stageIndex)
		goutil.setActive(finishFlag1, i < stageIndex)
		goutil.setActive(finishFlag2, i < stageIndex)
	end
end

function M:_tabClick(index)
	if index > #self._planCo.stages then
		index = #self._planCo.stages
	end

	self._stageSelected = index

	for i = 0, self._tabGroupGo.transform.childCount - 1 do
		local childGo = self._tabGroupGo.transform:GetChild(i).gameObject
		local normalGo = goutil.findChild(childGo, "normal")
		local selectGo = goutil.findChild(childGo, "select")

		goutil.setActive(normalGo, index ~= i + 1)
		goutil.setActive(selectGo, index == i + 1)
	end

	self:_refreshTask()
end

function M:_refreshRedPoint()
	for i = 1, self._tabGroupGo.transform.childCount do
		local childGo = self._tabGroupGo.transform:GetChild(i - 1).gameObject
		local redPointGo = goutil.findChild(childGo, "red_point")
		local isShow = SpecialtrainingModel.instance:showStageRedPoint(i)

		goutil.setActive(redPointGo, isShow)
	end
end

function M:_refreshStage()
	if self._planCo then
		self:_updateTabFlag()
		self:_refreshTask(nil, true)
		self._animation:Stop()
		self._animation:Play("statereceived_anima")
	end
end

function M:_refreshTask(e, isSingle)
	local stageId = self._planCo.stages[self._stageSelected]

	self._taskMoList = SpecialtrainingModel.instance:getTaskMoList(stageId)

	local itemCount = #self._taskMoList

	self._loopList:SetListItemCount(itemCount)
	self._loopList:RefreshAllShownItem()

	local focusIndex = 0

	for i, v in ipairs(self._taskMoList) do
		if not v:getIsFinish() then
			focusIndex = i

			break
		end
	end

	if isSingle == nil then
		self._loopList:MoveToItemIndex(focusIndex - 1)
	end

	local finishCount = 0

	for i, v in ipairs(self._taskMoList) do
		if v:getIsFinish() then
			finishCount = finishCount + 1
		end
	end

	local stageIndex = SpecialtrainingModel.instance:getCurrentStageIndex()
	local totalCount = #self._taskMoList

	self._canGetReward = finishCount == totalCount
	self._txtProcess.text = string.format("(%s/%s)", finishCount, totalCount)

	self._btnGet:setActiveState(self._canGetReward)
	self._btnGet:setActive(stageIndex <= self._stageSelected)
	goutil.setActive(self._receivedGo, stageIndex > self._stageSelected)
	self._itemCell:setShowSelectedEffect(false)
	goutil.setActive(self._itemCell:getGo(), true)

	local stageCo = SpecialtrainingConfig.instance:getTrainStageCfg(stageId)
	local rewardList = self:_parseReward(stageCo.rewardId)

	if #rewardList > 0 then
		self._itemCell:updateData(ItemUtil.createItemData({
			itemId = rewardList[1].itemId,
			count = rewardList[1].num
		}))
	else
		goutil.setActive(self._itemCell:getGo(), false)
	end

	self:_refreshRedPoint()
end

function M:_updateCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopList:NewListViewItem("special_training_task_item")
	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, SpecialtrainingItem)
	local mo = self._taskMoList[curIndex]
	local isFirst = curIndex == 1
	local isLast = curIndex == #self._taskMoList

	itemView:updateData(mo, self._stageSelected, curIndex, isFirst, isLast)

	return item
end

function M:_parseReward(rewardId)
	local rewardId = tonumber(rewardId)
	local rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardId)
	local tempList = {}

	if rewardCO then
		for i, v in ipairs(rewardCO.reward and rewardCO.reward or {}) do
			table.insert(tempList, {
				itemId = v.code,
				num = v.num
			})
		end
	end

	return tempList
end

function M:_onClickGet()
	if not self._canGetReward then
		return
	end

	local stageId = SpecialtrainingModel.instance:getCurrentStageId()

	SpecialtrainingAgent.instance:sendGrowthStageRewardRequest(stageId)
end

return M
