-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/power_challenge/PowerChallengeBattleView.lua

module("logic.extensions.welfare.view.power_challenge.PowerChallengeBattleView", package.seeall)

local M = class("PowerChallengeBattleView", ViewComponent)

function M:ctor()
	self._activeIndex = 1
end

function M:buildUI()
	self._leftList = self:getGo("power_challenge_battle_view_-1823497265")
	self._leftItem = self:getGo("power_challenge_battle_view_-1582764141")
	self._txtName = self:getText("power_challenge_battle_view_-1415833307")
	self._txtLevel = self:getText("power_challenge_battle_view_-2013563094")

	local videoGo = self:getGo("power_challenge_battle_view_-967555036")

	self._videoMgr = CriWareVideoMgr.Get(videoGo)
	self._btnGuide = self:getBtn("power_challenge_battle_view_-502013961")
	self._tabControl = ToggleTabControl.New()

	self._tabControl:setViewPager(self)
	self._tabControl:addToggleTab(self:getUIComponent("power_challenge_battle_view_1009787254", UIComponentType.SpaceXToggle))
	self._tabControl:addToggleTab(self:getUIComponent("power_challenge_battle_view_758532918", UIComponentType.SpaceXToggle))
	self._tabControl:addToggleTab(self:getUIComponent("power_challenge_battle_view_-489678592", UIComponentType.SpaceXToggle))

	self._DifficultTab = self:getGo("power_challenge_battle_view_-2131338400")
	self._txtContent = self:getUIComponent("power_challenge_battle_view_1916975064", UIComponentType.TextMeshProUGUI)
	self._btnReward = self:getBtn("0&btn_left_-1571983320")
	self._btnStart = self:getBtn("1&btn_right_1251431307")
	self._txtHint = self:getGo("power_challenge_battle_view_-2000579580")
	self._redPoint = goutil.findChild(self._btnReward.gameObject, "red_point")
end

function M:onEnter()
	TaskAgent.instance:sendListTaskRequest(TaskEnum.TaskLabel.PowerChallenge)

	self._planId = self:getFirstParam()
	self._taskList = PowerChallengeConfig.instance:getChapterConfById(self._planId)

	self:_refreshLeftList()

	local chapterIdx, tabIdx = PowerChallengeModel.instance:getLastPageIndex()

	self:_onClickTag(chapterIdx or self._taskList[1].chapterId)
	self._tabControl:selectTab(tabIdx or 1)
	self:_refreshRedPoint()
	PowerChallengeModel.instance:setLastPageIndex(1, 1)
end

function M:onExit()
	return
end

function M:bindEvents()
	self._btnReward:AddClickListener(self._onClickReward, self)
	self._btnGuide:AddClickListener(self._onClickGuide, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	GlobalDispatcher:addEventListener(EventType.POWER_CHALLENGE_TASK_REFRESH, self._refreshRedPoint, self)
end

function M:unbindEvents()
	self._btnReward:RemoveClickListener()
	self._btnGuide:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.POWER_CHALLENGE_TASK_REFRESH, self._refreshRedPoint, self)
end

function M:setPage(tabIndex)
	self._activeIndex = tabIndex

	local conf = self._taskList[self._chapterId]
	local dungeonCO = DungeonConfig.instance:getDungeonCfgById(conf.dungeonIds[tabIndex])
	local levelCO = BattleConfig.instance:getBattleLevelCO(dungeonCO.levelID)
	local desc = ""

	goutil.setActive(self._txtHint, tabIndex > 1)

	for _, code in ipairs(levelCO.globalSkillCodeList) do
		local skillCO = ActiveSkillConfig.instance:getActiveSkillCOWrapper(code)

		if skillCO then
			desc = desc .. skillCO:getDescription() .. "\n"
		end
	end

	self._txtLevel.text = "推荐等级 " .. conf.recommendLv[tabIndex]

	if string.nilorempty(desc) then
		self._txtContent.text = "配置关卡无全局技能"
	else
		self._txtContent.text = desc
	end
end

function M:_refreshMovie(guideVideoName)
	local fullVideoPath = GameUrl.getVideoUrl(guideVideoName)

	self._videoMgr:Reset()
	self._videoMgr:PlayForSeek(fullVideoPath, 0, true, true)
	self._videoMgr:SetVolume(0, true)
end

function M:_refreshLeftList()
	self._tagList = {}

	goutil.clearChildren(self._leftList)

	for idx, item in ipairs(self._taskList) do
		local go = goutil.cloneAndSetParent(self._leftItem, self._leftList.transform)
		local itemView = Astral.LuaComponentContainer.Add(go, PowerChallengeLabelCell)

		itemView:updateData(self._taskList[idx])
		itemView:setHandler(self, self._onClickTag)
		goutil.setActive(go, true)
		table.insert(self._tagList, itemView)
	end
end

function M:_refreshRightPanel(chapterId)
	local conf = self._taskList[chapterId]

	self._txtName.text = conf.name

	self:_refreshMovie(conf.guideVideoName)
	self._tabControl:selectTab(1)
end

function M:_onClickTag(chapterId)
	self._chapterId = chapterId

	self:_refreshRightPanel(chapterId)

	for idx, item in ipairs(self._tagList) do
		item:setSelect(idx == chapterId)
	end
end

function M:_onClickStart()
	local conf = self._taskList[self._chapterId]
	local info = {}

	info.dungeonCode = conf.dungeonIds[self._activeIndex]
	info.afflatusBuff = false
	info.isShowPlot = false
	info.multiCount = 1
	info.gamePlay = BattleEnum.GamePlayType.NORMAL

	PowerChallengeModel.instance:setLastPageIndex(self._chapterId, self._activeIndex)
	DungeonController.instance:startDungeonBattle(info)
end

function M:_onClickReward()
	ViewMgr.instance:open(ViewName.PowerChallengeReward, self._planId)
end

function M:_onClickGuide()
	local conf = self._taskList[self._chapterId]

	ViewMgr.instance:open(ViewName.ImageGuide, {
		conf.imageGuideId
	})
end

function M:destroyUI()
	if self._videoMgr then
		self._videoMgr:DestroyMovie()
	end

	self._tabControl:destroy()

	self._tabControl = nil
end

function M:_refreshRedPoint()
	local isVisible = PowerChallengeModel.instance:getCanReceive()

	goutil.setActive(self._redPoint, isVisible)
end

return M
