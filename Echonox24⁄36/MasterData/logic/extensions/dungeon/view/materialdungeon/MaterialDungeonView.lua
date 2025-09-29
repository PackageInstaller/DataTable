-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/materialdungeon/MaterialDungeonView.lua

module("logic.extensions.dungeon.view.materialdungeon.MaterialDungeonView", package.seeall)

local M = class("MaterialDungeonView", ViewComponent)
local timeDuration = 0.2
local PosScale = {
	0.23,
	0.3,
	0.5,
	0.7,
	1,
	1.3,
	1.3
}
local alphaList = {
	1,
	1,
	1,
	1,
	1,
	0,
	0
}
local colorList = {
	{
		112,
		136,
		149,
		148
	},
	{
		126,
		151,
		165,
		74
	},
	{
		126,
		151,
		165,
		43
	},
	{
		126,
		151,
		165,
		20
	},
	{
		126,
		151,
		165,
		0
	},
	{
		126,
		151,
		165,
		0
	},
	{
		126,
		151,
		165,
		0
	}
}
local focusIndex = 5

function M:buildUI()
	self._btnReturn = self:getBtn("title_view_-878360263")
	self._btnHome = self:getBtn("title_view_1398742689")
	self._3dTouchGo = self:getGo("resources_main_view_-1176264848")
	self._3dPanelGo = self:getGo("resources_main_view_756175767")
	self._tabContentGo = self:getGo("resources_main_view_753581926")
	self._tabContentSizeFilter = self._tabContentGo:GetComponent("ContentSizeFitter")
	self._tabPanelGo = self:getGo("resources_main_view_2092464206")
	self._scrollEntrance = self:getUIComponent("resources_main_view_2092464206", UIComponentType.ScrollRect)
	self._dungeonPanelGo = self:getGo("resources_main_view_979758523")

	goutil.setActive(self._dungeonPanelGo, true)

	self._goMove = self._3dPanelGo:GetComponent("GameObjectMove")
	self._dungeonNameTxt = self:getText("resources_main_view_-1507206412")
	self._dungeonDescTxt = self:getText("resources_main_view_46810056")
	self._dungeonScoreRateTxt = self:getTextByPath("levelDetailsPanel/layout/instanceInfo/txtNum")
	self._dungeonScoreRateGo = self:getGo("3&instance_danger_-1654566369")
	self._moreRewardBtn = self:getBtn("resources_main_view_1398759850")
	self._rewardListGo = self:getGo("resources_main_view_-995583512")
	self._rewardPrefab = self._rewardListGo.transform:GetChild(0).gameObject

	goutil.setActive(self._rewardPrefab, false)

	self._btnQuickFight = self:getBtn("resources_main_view_1178281811")
	self._fightBtn = self:getBtn("resources_main_view_192684683")
	self._costTxt = self:getText("resources_main_view_385037953")
	self._goBg1 = self:getGo("resources_main_view_-1990553543")
	self._goBg2 = self:getGo("resources_main_view_-542070609")
	self._goBg3 = self:getGo("resources_main_view_724499106")
	self._imgBgCareerIcon = self:getImage("resources_main_view_206957199")
	self._img2TargetScale = Vector3.New(1.3, 1.3, 1.838)
	self._img3TargetScale = Vector3.New(1.9, 1.9, 1.781)
	self._img4TargetScale = Vector3.New(3, 3, 2.112)
	self._img5TargetScale = Vector3.New(5, 5, 1)
	self._img5OriginPosY = -403
	self._img5TargetPosY = -1308
	self._starFinishSignGoList = {
		self:getGo("resources_main_view_-1785103561"),
		self:getGo("resources_main_view_822072290"),
		self:getGo("resources_main_view_-348823648")
	}
	self._starDescTxtList = {
		self:getText("resources_main_view_88734947"),
		self:getText("resources_main_view_570577991"),
		self:getText("resources_main_view_873927216")
	}
	self._tabPosX = self._tabPanelGo.transform.localPosition.x
	self._dungeonPosX = self._dungeonPanelGo.transform.localPosition.x
	self._3dPanelPosX = self._3dPanelGo.transform.localPosition.x
	self._btnExplain = self:getBtn("2&title_view_-636449388")
	self._btnEnemy = self:getBtnByPath("levelDetailsPanel/layout/enemyInfo/Image1")

	local btn_skill_bonusGo = goutil.findChild(self._moreRewardBtn.transform.parent.gameObject, "btn_skill_bonus")

	self._btnSkillUp = UIComponentType.ButtonAdapter(goutil.findChild(btn_skill_bonusGo, "btnUp"))
	self._btnSkillDown = UIComponentType.ButtonAdapter(goutil.findChild(btn_skill_bonusGo, "btnDown"))

	goutil.setActive(self._btnSkillUp.gameObject, false)
	goutil.setActive(self._btnSkillDown.gameObject, false)
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self._moreRewardBtn:AddClickListener(self._onClickMoreReward, self)
	self._fightBtn:AddClickListener(self._onClickStartFight, self)
	self._btnQuickFight:AddClickListener(self._onClickQuickFight, self)
	self._goMove:SetLuaFuncCallBack(self._getCurTime, self)
	self._btnExplain:AddClickListener(self._onClickExplain, self)
	self._btnEnemy:AddClickListener(self._onClickBtnEnemy, self)
	self._btnSkillUp:AddClickListener(self._onOpenSkillSmallTips, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	self._moreRewardBtn:RemoveClickListener()
	self._fightBtn:RemoveClickListener()
	self._btnQuickFight:RemoveClickListener()
	self._btnExplain:RemoveClickListener()
	self._btnEnemy:RemoveClickListener()
	self._btnSkillUp:RemoveClickListener()
end

function M:_bindEvents()
	self._raycastProxy = RaycastProxy.Get(self._3dTouchGo)

	self._raycastProxy:SetBeginDragListener(self._onBeginDrag, self)
	self._raycastProxy:SetDragListener(self._onDrag, self)
	self._raycastProxy:SetEndDragListener(self._onEndDrag, self)
	self._raycastProxy:SetClickListener(self._globalClickCloseDungeonPanel, self)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Material)
	DungeonDispatcher:addEventListener(DungeonEventType.Reward_Detail_Click_Close, self._onRewardDetailClose, self)
	GlobalDispatcher:addEventListener(EventType.ON_DUNGEON_DANGER_TIPS_CONFIRM, self._goFight, self)
	GlobalDispatcher:addEventListener(EventType.ON_MULTI_FIGHT_TIPS_CONFIRM, self._handleMultiFightTipsConfirm, self)
end

function M:_unbindEvents()
	self._raycastProxy:RemoveBeginDragListener()
	self._raycastProxy:RemoveDragListener()
	self._raycastProxy:RemoveEndDragListener()
	self._raycastProxy:RemoveClickListener()

	for i, v in pairs(self._tabViewList) do
		v:OnDestroy()
	end

	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Material)
	DungeonDispatcher:removeEventListener(DungeonEventType.Reward_Detail_Click_Close, self._onRewardDetailClose, self)
	GlobalDispatcher:removeEventListener(EventType.ON_DUNGEON_DANGER_TIPS_CONFIRM, self._goFight, self)
	GlobalDispatcher:removeEventListener(EventType.ON_MULTI_FIGHT_TIPS_CONFIRM, self._handleMultiFightTipsConfirm, self)
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Fight)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_ResourcesExplore)
	self:_bindEvents()

	self._curSelectDungeonIndex = false
	self._canCloseDungeon = true

	self:initAnimPos(true)
	self:_initData()
	self:_initTab()

	self._waitGlobalTouchFinish = false

	self:_refreshRightView()
	self:_onClickCloseDungeonPanel()
	self:updateTopCurrencyShow()
	self:_doAnim(false)
end

function M:_initTab()
	goutil.clearChildren(self._tabContentGo)

	self._tabViewList = {}

	local delayTime = 0.2
	local path = ResName.Resources_explore_resource_tab
	local prefab = self._viewPresentor:getPrefab(path)

	for curIndex, v in ipairs(self._chapterList) do
		local obj = Astral.GameObjectUtil.CloneAndSetParent(prefab, self._tabContentGo.transform, nil)
		local data = self._chapterList[curIndex]
		local shower = Astral.LuaComponentContainer.Add(obj, MaterialDungeonTabCellComp)

		self._tabViewList[curIndex] = shower

		shower:setSelectTab(self._curSelectTab)
		shower:updateData(data, curIndex)
		shower:setClickCallBack(self._clickTabCallBack, self)

		if data then
			obj.gameObject.name = string.format("item_%s", data:getChapterId())
		end
	end

	settimer(0, self._timerForPointToTabPos, self, false)
end

function M:_timerForPointToTabPos()
	local verticalLayOut = self._tabContentGo:GetComponent(UIComponentType.VerticalLayoutGroup)
	local tabSpacing = verticalLayOut.spacing
	local tabHeight = RectTransformUtils.GetHeight(self._tabContentGo.transform:GetChild(0))
	local tab = self._tabViewList[self._curSelectTab]

	if tab then
		self._scrollEntrance:StopMovement()

		if self._scrollEntrance.content then
			local limit = goutil.getHeight(self._scrollEntrance.content) - goutil.getHeight(self._scrollEntrance.viewport)
			local posY = tab:getTransform().anchoredPosition.y * -1

			posY = posY < tabSpacing * 3 + tabHeight * 4 and 0 or posY
			posY = posY - tabSpacing * 3 - tabHeight * 2.5
			posY = posY < 0 and 0 or posY
			posY = limit < posY and limit or posY

			Astral.TransformUtil.SetAnchoredPos(self._scrollEntrance.content, 0, posY)
		end
	end
end

function M:_refreshTab()
	for i, data in ipairs(self._chapterList) do
		local shower = self._tabViewList[i]

		shower:setSelectTab(self._curSelectTab)
		shower:updateData(data, i)
	end

	self._tabContentSizeFilter.enabled = false
	self._tabContentSizeFilter.enabled = true
end

function M:_initData()
	local chapterList = DungeonMaterialChapterModel.instance:getAllChapter()

	self._chapterList = {}

	for k, v in pairs(chapterList) do
		table.insert(self._chapterList, v)
	end

	table.sort(self._chapterList, function(chapter1, chapter2)
		if chapter1:getIsChapterUnlock() == chapter2:getIsChapterUnlock() then
			return chapter1:getChapterId() < chapter2:getChapterId()
		end

		return chapter1:getIsChapterUnlock()
	end)

	local lastClickChapterId, index = DungeonMaterialChapterModel.instance:getClickChapterIdAndDungeonIndex()

	self._curSelectTab = 1
	self._curDungeonIndex = nil

	local selectTabChapterId = self:getFirstParam()
	local dungeonIndex = self:getOpenParam()[2]

	if self:getFirstParam() then
		self._viewPresentor._openParam[1] = nil
	end

	if selectTabChapterId then
		for i, v in ipairs(self._chapterList) do
			if v:getChapterId() == tonumber(selectTabChapterId) and v:getIsChapterUnlock() then
				self._curSelectTab = i
				self._curDungeonIndex = dungeonIndex or 1
			end
		end
	elseif lastClickChapterId then
		for i, v in ipairs(self._chapterList) do
			if v:getChapterId() == lastClickChapterId then
				self._curSelectTab = i
				self._curDungeonIndex = index

				break
			end
		end
	end

	self._curChapterMo = self._chapterList[self._curSelectTab]

	if not self._curDungeonIndex then
		self._curDungeonIndex = self._curChapterMo:getLastPassDungeonIndex() or 1
	end

	self:_refreshBgShow()
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Fight)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_ResourcesExplore)
	removetimer(self._waitingGlobalTouchFinish, self)
	removetimer(self._timerForPointToTabPos, self)

	if self._compList then
		for i, v in ipairs(self._compList) do
			DG.Tweening.DOTween.Kill(v._go.transform)
		end
	end

	self:_unbindEvents()
end

function M:_onClickExplain()
	ViewMgr.instance:open(ViewName.ImageGuide, {
		1001
	})
end

function M:_animationDoneListener(animationName)
	if animationName == "close" then
		-- block empty
	end

	if animationName == "open" then
		-- block empty
	end
end

function M:_clickTabCallBack(index)
	self._curSelectTab = index

	self:_refreshTab()

	self._curChapterMo = self._chapterList[self._curSelectTab]
	self._curDungeonIndex = self._curChapterMo:getLastPassDungeonIndex() or 1

	self:_refreshBgShow()
	self:_refreshRightView()
	self:updateTopCurrencyShow()
end

function M:_refreshBgShow()
	local chapterId = self._curChapterMo:getChapterId()

	if chapterId == 1001 then
		goutil.setActive(self._goBg1.gameObject, true)
		goutil.setActive(self._goBg2.gameObject, false)
		goutil.setActive(self._goBg3.gameObject, false)
	elseif chapterId == 1002 then
		goutil.setActive(self._goBg1.gameObject, false)
		goutil.setActive(self._goBg2.gameObject, true)
		goutil.setActive(self._goBg3.gameObject, false)
	else
		goutil.setActive(self._goBg1.gameObject, false)
		goutil.setActive(self._goBg2.gameObject, false)
		goutil.setActive(self._goBg3.gameObject, true)

		local career = self._curChapterMo:getCareer()

		if career > 0 then
			IconLoader.setSprite(self._imgBgCareerIcon, IconType.DynSpriteAtlas_ResourcesExplore, CommEnum.Career2IconResourceExplore[career])
		end

		goutil.setActive(self._imgBgCareerIcon.gameObject, career > 0)
	end
end

function M:_refreshRightView()
	self._dungeonMoList = {}

	for i, v in ipairs(self._curChapterMo:getDungeonIds()) do
		local dungeonMo = DungeonMaterialChapterModel.instance:getDungeonMoById(v)

		table.insert(self._dungeonMoList, dungeonMo)
	end

	self._lastPassTime = timeDuration * (focusIndex + self._curDungeonIndex - 2)

	if self._curDungeonIndex == #self._dungeonMoList then
		self._lastOpenTime = self._lastPassTime
	elseif self._dungeonMoList[self._curDungeonIndex]:hasPassed() then
		self._lastOpenTime = self._lastPassTime + timeDuration
	else
		self._lastOpenTime = self._lastPassTime
	end

	self._curDungeonMo = self._dungeonMoList[self._curDungeonIndex]

	self:_refresh3dPanel()
end

function M:_refresh3dPanel()
	goutil.setActive(self._3dPanelGo, true)
	goutil.clearChildren(self._3dPanelGo)

	self._3dCanvasGroupList = {}
	self._compList = {}

	for i, v in ipairs(self._dungeonMoList) do
		local path = ResName.Resources_explore_resources_level_item
		local prefab = self._viewPresentor:getPrefab(path)
		local obj = Astral.GameObjectUtil.CloneAndSetParent(prefab, self._3dPanelGo.transform, nil)
		local shower = Astral.LuaComponentContainer.Add(obj, MaterialDepthDungeonCellComp)

		table.insert(self._compList, shower)
		table.insert(self._3dCanvasGroupList, obj:GetComponent(ComponentType.CanvasGroup))
		shower:setSelectIndex(self._curSelectDungeonIndex)
		shower:updateData(v, i, self._curChapterMo)
		shower:setClickCallBack(self._onClickDepthDungeon, self)

		if v then
			obj.gameObject.name = string.format("item_%s", v:getMaterialDungeonCode())
		end
	end

	local childCount = #self._compList

	for i, v in ipairs(self._compList) do
		v._go.transform:SetSiblingIndex(childCount - i)
	end

	self:_initDepthPanelCell()
end

function M:_initDepthPanelCell()
	self._dTime = 0.2 * (focusIndex + self._curDungeonIndex - 2)

	self:_updateDepthPanelCellPos(true)
end

function M:_updateDepthCell()
	for i, v in ipairs(self._compList) do
		local go = v._go
		local time = self:getTimeByIndex(i)

		if time >= timeDuration * 0 and time < timeDuration * 5 then
			local scale, alpha, color = self:getCellScaleAndAlpha(time)

			goutil.setActive(go, true)
			self._goMove:SetPos(time, go.transform)
			Astral.TransformUtil.SetLocalScale(go.transform, scale, scale, 1)

			self._3dCanvasGroupList[i].alpha = alpha

			v:setMaskImgColor(color)
		else
			goutil.setActive(go, false)
		end
	end
end

function M:getTimeByIndex(index)
	return self._dTime - (index - 1) * timeDuration
end

function M:getCellScaleAndAlpha(time)
	local scale, alpha
	local color = {}
	local index = math.floor(time / timeDuration) + 1

	alpha = alphaList[index] + (alphaList[index + 1] - alphaList[index]) * (time - (index - 1) * timeDuration) / timeDuration
	scale = PosScale[index] + (PosScale[index + 1] - PosScale[index]) * (time - (index - 1) * timeDuration) / timeDuration
	color[1] = colorList[index][1] + (colorList[index + 1][1] - colorList[index][1]) * (time - (index - 1) * timeDuration) / timeDuration
	color[2] = colorList[index][2] + (colorList[index + 1][2] - colorList[index][2]) * (time - (index - 1) * timeDuration) / timeDuration
	color[3] = colorList[index][3] + (colorList[index + 1][3] - colorList[index][3]) * (time - (index - 1) * timeDuration) / timeDuration
	color[4] = colorList[index][4] + (colorList[index + 1][4] - colorList[index][4]) * (time - (index - 1) * timeDuration) / timeDuration

	local colorStr = string.format("#%s", self:get16StrByNum(color))

	return scale, alpha, colorStr
end

function M:get16StrByNum(color)
	local str = ""

	for i = 1, #color do
		str = string.format("%s%02x", str, color[i])
	end

	return str
end

function M:_updateTimer()
	self._times = self._times + 1
	self._dTime = self._dTime + self._dRotation

	if self._times >= self._totalTime then
		self._dTime = self._targetDTime
	end

	self:_updateDepthCell()

	if self._times >= self._totalTime then
		removetimer(self._updateTimer, self)
	end
end

function M:_getCurTime(time)
	self._dTime = time

	self:_updateDepthCell()
end

function M:_updateDepthPanelCellPos(isImmediate)
	if isImmediate then
		self:_updateDepthCell()
	else
		self._goMove:DOAnim(math.abs(self._targetDTime - self._dTime), self._dTime, self._targetDTime)
	end
end

function M:_onBeginDrag(x, y, pointerId)
	self._startDragY = y
	self._scaleMaxOffsetY = 600
	self._startDragDTime = self._dTime
end

function M:_onDrag(x, y, pointerId)
	local dy = y - self._startDragY

	self:changeBgScale(dy)

	self._dTime = self._startDragDTime - dy / 1000

	self:_updateDepthPanelCellPos(true)
end

function M:_onEndDrag(x, y, pointerId)
	self._startDragY = nil
	self._isDrag = true

	self:_handleDragBack()
	self:changeBgScale(0)
end

function M:changeBgScale(offset)
	local percent = offset / self._scaleMaxOffsetY

	percent = percent < 1 and percent or 1
	percent = percent > 0 and percent or -percent
end

function M:_onPlaneScrollDragEnd()
	self._isDrag = true
end

function M:_handleDragBack()
	local isNeedDragBack = false

	if self._lastOpenTime < self._dTime then
		self._targetDTime = self._lastOpenTime
		isNeedDragBack = true
	elseif self._dTime < (focusIndex - 1) * timeDuration then
		self._targetDTime = (focusIndex - 1) * timeDuration
		isNeedDragBack = true
	end

	if isNeedDragBack then
		self:_updateDepthPanelCellPos()
	end
end

function M:_onClickDepthDungeon(index)
	local x, y, z = TransformUtils.GetLocalPosition(self._dungeonPanelGo.transform, 0, 0, 0)

	if x == self._dungeonPosX and self._curDungeonIndex == index then
		return
	end

	self._curDungeonIndex = index
	self._curSelectDungeonIndex = index
	self._curDungeonMo = self._dungeonMoList[index]
	self._waitGlobalTouchFinish = true

	removetimer(self._waitingGlobalTouchFinish, self)
	settimer(0, self._waitingGlobalTouchFinish, self, false)

	self._targetDTime = (self._curDungeonIndex + focusIndex - 2) * timeDuration

	self:_updateDepthPanelCellPos()
	self:_updatetDepthPanelCell()
end

function M:_updatetDepthPanelCell()
	for i, shower in ipairs(self._compList) do
		shower:setSelectIndex(self._curSelectDungeonIndex)
		shower:updateSelect()
	end
end

function M:_onClickReturn()
	local curSceneFlowTyp = SceneFace.instance:getCurSceneFlowTyp()

	if curSceneFlowTyp == nil then
		self:_onClickHome()
	else
		DungeonMaterialChapterModel.instance:setClickChapterIdAndDungeonIndex(self._curChapterMo:getChapterId(), nil)
		self:back()
	end
end

function M:_onClickHome()
	DungeonMaterialChapterModel.instance:setClickChapterIdAndDungeonIndex(self._curChapterMo:getChapterId(), nil)
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:_onRewardDetailClose()
	self._canCloseDungeon = true
end

function M:_onClickMoreReward()
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_click, nil, nil, nil)

	self._canCloseDungeon = false

	ViewMgr.instance:open(ViewName.DungeonRewardDetailView, self._curDungeonMo:getId())
end

function M:_onClickStartFight()
	if not self._curDungeonMo:getIsUnlock() then
		local isPrePassed = true
		local preDungeonId = self._curDungeonMo:getPreDungeonId()

		if preDungeonId then
			local preDungeonMo = DungeonMaterialChapterModel.instance:getDungeonMoById(preDungeonId)

			isPrePassed = preDungeonMo:hasPassed()
		end

		if not self._isPrePassed then
			FloatWordMgr.instance:show(lang("tip_teaching_lock"))

			return
		end

		local unlockLv = self._curDungeonMo:getUnlockLevel()

		if unlockLv > PlayerModel.instance:getLevel() then
			if unlockLv >= 100 then
				FloatWordMgr.instance:show(lang("tip_system_open_not_online"))

				return
			end

			FloatWordMgr.instance:show(string.format(lang("tip_player_not_reach_level"), self:_formatLevel(unlockLv)))
		end

		return
	end

	if self._curDungeonMo:getPointCost() > ItemModel.instance:getItemCountByItemId(GameEnum.CurrencyCodeEnum.TlCode) then
		ToolTipsMgr.showHealthExchangeTips()

		return
	end

	BattleCalculateModel.instance:setDefaultItemMoList(self._curDungeonMo:getPointCost())

	local info = {}

	info.dungeonCode = self._curDungeonMo:getId()
	info.afflatusBuff = false
	info.isShowPlot = true
	info.multiCount = 1
	info.gamePlay = BattleEnum.GamePlayType.NORMAL

	self:_startFight(info)
end

function M:_handleMultiFightTipsConfirm(e, tipsInfo)
	local chapterMo = self._curChapterMo
	local dungeonMo = self._curDungeonMo

	if dungeonMo:getId() ~= tipsInfo.dungeonId then
		return
	end

	local dungeonId = tipsInfo.dungeonId
	local multiCount = tipsInfo.multiCount
	local gamePlay = tipsInfo.gamePlay
	local pointCost = dungeonMo:getPointCost()

	BattleCalculateModel.instance:setDefaultItemMoList(pointCost * multiCount)

	local info = {}

	info.dungeonCode = dungeonId
	info.afflatusBuff = false
	info.isShowPlot = false
	info.multiCount = multiCount
	info.gamePlay = gamePlay

	self:_startFight(info, false)
end

function M:_startFight(info, checkDanger)
	if checkDanger == nil then
		checkDanger = true
	end

	if not checkDanger then
		self:_goFight(false, info)

		return
	end

	local scoreRate = DungeonModel.instance:getDungeonScoreRate(self._curDungeonMo:getId()) * 1000
	local scoreCO = DungeonConfig.instance:getDungeonScoreCOByScore(scoreRate, self._curDungeonMo:getScoreGroup())

	if not DungeonController.instance:tryOpenDangerTips(scoreCO, info) then
		self:_goFight(false, info)
	end
end

function M:_goFight(_, info)
	local chapterMo = self._curChapterMo
	local dungeonMo = self._curDungeonMo

	DungeonMaterialChapterModel.instance:setClickChapterIdAndDungeonIndex(chapterMo:getChapterId(), self._curDungeonIndex)
	SceneFace.instance:exitScene()
	Astral.LocalStorage.Instance:SetString("dungeon_latest_type", string.format("2,%d,%02d", chapterMo:getChapterId(), self._curDungeonIndex))
	Astral.LocalStorage.Instance:SetString("dungeon_latest_id", PlayerModel.instance:getId())
	Astral.LocalStorage.Instance:SetString("dungeon_latest_info", dungeonMo:getId())
	DungeonController.instance:startDungeonBattle(info)
end

function M:_onClickQuickFight()
	local gamePlay = BattleEnum.GamePlayType.CONSECUTIVE
	local chapterMo = self._curChapterMo
	local dungeonMo = self._curDungeonMo
	local chapterId = chapterMo:getChapterId()
	local dungeonId = dungeonMo:getId()
	local starCount = dungeonMo:getStarCount()
	local hasPassed = dungeonMo:hasPassed()
	local canOpenMulti = chapterMo:getCanOpenMulti()
	local multiOpenCondition = chapterMo:getMultiplicityOpenCondition()
	local canQuickFight = false
	local canProxy = chapterMo:canProxy()
	local maxCount = 0

	if gamePlay == BattleEnum.GamePlayType.RECORD then
		maxCount = chapterMo:getMultiMaxCount()

		if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DungeonMultipleBattle, true) then
			return
		end

		if not canOpenMulti then
			FloatWordMgr.instance:show(lang("tip_not_open_multiple"))

			return
		elseif not hasPassed then
			FloatWordMgr.instance:show(lang("tip_pass_open_multiple"))

			return
		end
	elseif gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
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

	ToolTipsMgr.showMultiFightTipsView(dungeonId, maxCount, canQuickFight, canProxy, gamePlay)
end

function M:_globalClickCloseDungeonPanel()
	if self._waitGlobalTouchFinish then
		return
	end

	if self._isDrag then
		self._isDrag = false

		return
	end

	if not self._canCloseDungeon then
		return
	end

	self:_onClickCloseDungeonPanel()
end

function M:_onClickCloseDungeonPanel()
	self._curSelectDungeonIndex = false

	self:_updatetDepthPanelCell()
	self:_doAnim(false)
end

function M:_doAnim(isOpen)
	if isOpen then
		DG.Tweening.DOTween.Kill(self._3dPanelGo.transform)

		local sequence = DG.Tweening.DOTween.Sequence()

		sequence:Append(self._3dPanelGo.transform:DOLocalMoveX(self._3dPanelPosX - 370, 0.5):SetEase(DG.Tweening.Ease.OutBack, 1))
		sequence:SetTarget(self._3dPanelGo.transform)
		DG.Tweening.DOTween.Kill(self._tabPanelGo.transform)

		local sequence = DG.Tweening.DOTween.Sequence()

		sequence:Append(self._tabPanelGo.transform:DOLocalMoveX(self._tabPosX - 800, 0.5):SetEase(DG.Tweening.Ease.OutBack, 1))
		sequence:SetTarget(self._tabPanelGo.transform)
		DG.Tweening.DOTween.Kill(self._dungeonPanelGo.transform)

		local sequence = DG.Tweening.DOTween.Sequence()

		sequence:Append(self._dungeonPanelGo.transform:DOLocalMoveX(self._dungeonPosX, 0.5):SetEase(DG.Tweening.Ease.OutBack, 1))
		sequence:SetTarget(self._dungeonPanelGo.transform)
		settimer(0.1, self._onOpenAnimFinish, self, false)
	else
		DG.Tweening.DOTween.Kill(self._3dPanelGo.transform)

		local sequence = DG.Tweening.DOTween.Sequence()

		sequence:Append(self._3dPanelGo.transform:DOLocalMoveX(self._3dPanelPosX, 0.5):SetEase(DG.Tweening.Ease.OutBack, 1))
		sequence:SetTarget(self._3dPanelGo.transform)
		DG.Tweening.DOTween.Kill(self._tabPanelGo.transform)

		local sequence = DG.Tweening.DOTween.Sequence()

		sequence:Append(self._tabPanelGo.transform:DOLocalMoveX(self._tabPosX, 0.5):SetEase(DG.Tweening.Ease.OutBack, 1))
		sequence:SetTarget(self._tabPanelGo.transform)
		DG.Tweening.DOTween.Kill(self._dungeonPanelGo.transform)

		local sequence = DG.Tweening.DOTween.Sequence()

		sequence:Append(self._dungeonPanelGo.transform:DOLocalMoveX(self._dungeonPosX + 1000, 0.5):SetEase(DG.Tweening.Ease.OutBack, 1))
		sequence:SetTarget(self._dungeonPanelGo.transform)
	end
end

function M:_onOpenAnimFinish()
	return
end

function M:initAnimPos(isOpen)
	if isOpen then
		Astral.TransformUtil.SetLocalPosX(self._tabPanelGo.transform, self._tabPosX - 800)
		Astral.TransformUtil.SetLocalPosX(self._dungeonPanelGo.transform, self._dungeonPosX)
		Astral.TransformUtil.SetLocalPosX(self._3dPanelGo.transform, self._3dPanelPosX)
	else
		Astral.TransformUtil.SetLocalPosX(self._tabPanelGo.transform, self._tabPosX)
		Astral.TransformUtil.SetLocalPosX(self._dungeonPanelGo.transform, self._dungeonPosX + 1000)
		Astral.TransformUtil.SetLocalPosX(self._3dPanelGo.transform, self._3dPanelPosX)
	end
end

function M:_waitingGlobalTouchFinish()
	goutil.setActive(self._dungeonPanelGo, true)
	self:_doAnim(true)

	self._waitGlobalTouchFinish = false

	self:_refreshDungeonInfoPanel()
end

function M:_refreshDungeonInfoPanel()
	if self._dungeonPanelGo.activeSelf == false then
		return
	end

	local isShow = self._curDungeonMo:getId() == 130101

	goutil.setActive(self._btnSkillUp.gameObject, isShow and AchievementModel.instance:isGetSkill(CommEnum.CharacterSkillType.Type4))

	self._dungeonNameTxt.text = self._curDungeonMo:getName()
	self._dungeonDescTxt.text = self._curDungeonMo:getDesc()

	local scoreRate = DungeonModel.instance:getDungeonScoreRate(self._curDungeonMo:getId(), self._curChapterMo:getChapterId()) * 1000
	local scoreCO = DungeonConfig.instance:getDungeonScoreCOByScore(scoreRate, self._curDungeonMo:getScoreGroup())

	self._dungeonScoreRateTxt.text = self._curDungeonMo:getDifficultyStr()

	goutil.setActive(self._dungeonScoreRateTxt.gameObject, false)
	DifficultyUtil.setDifficultyFlag(self._dungeonScoreRateGo, scoreCO)

	self._costTxt.text = self._curDungeonMo:getPointCost()

	self:_refreshRewardPanel()
	self:_refreshStarPanel()
	self:_refreshBottomPanel()
end

function M:_refreshBottomPanel()
	local showBtn = true
	local gamePlay = BattleEnum.GamePlayType.CONSECUTIVE
	local isPassed = self._curDungeonMo:hasPassed()

	if gamePlay == BattleEnum.GamePlayType.RECORD then
		showBtn = isPassed and self._curChapterMo:getCanOpenMulti() and SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DungeonMultipleBattle, false)
	elseif gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
		local maxCount = self._curChapterMo:getConsecutiveLimit()

		showBtn = isPassed and maxCount and maxCount > 0 and SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DungeonConsecutiveBattle, false)
	end

	goutil.setActive(self._btnQuickFight.gameObject, showBtn)
end

function M:_refreshEnemyPanel()
	goutil.clearChildren(self._bossListGo)

	local hasEnterDungeon = DungeonModel.instance:getIfDungeonEntered(self._curDungeonMo:getId())

	if self._curDungeonMo:hasPassed() then
		hasEnterDungeon = true
	end

	local enemyList = self._curDungeonMo:getEnemyIds()

	for i, v in ipairs(enemyList) do
		if i <= 3 then
			local obj = self:getResInstance(ResName.Common_enemy_head)

			obj:SetActive(true)

			local objBeh = Astral.LuaComponentContainer.Add(obj, MonsterHeadCell)

			goutil.addChildToParent(obj, self._bossListGo)
			objBeh:setShowMonsterStatus(hasEnterDungeon)
			objBeh:setMonsterCode(v)
		end
	end

	if #enemyList > 3 then
		local obj = self:getResInstance(ResName.Common_enemy_head)

		obj:SetActive(true)

		local objBeh = Astral.LuaComponentContainer.Add(obj, MonsterHeadCell)

		goutil.addChildToParent(obj, self._bossListGo)
		objBeh:setShowMonsterStatus(false)
		objBeh:setMonsterCode(0)
	end
end

function M:_onClickBtnEnemy()
	local luaTable = {}

	luaTable.dungeonMo = self._curDungeonMo

	ViewMgr.instance:open(ViewName.DungeonEnemy, luaTable)
end

function M:_refreshRewardPanel()
	local maxNum = 3
	local root = self._rewardListGo.transform
	local hasPassed = self._curDungeonMo:hasPassed()
	local lst = {}

	if not hasPassed then
		local _tmpTable = {}

		for i, reward in ipairs(self._curDungeonMo:getAllFirstPassReward()) do
			table.insert(_tmpTable, ItemUtil.createItemData({
				itemId = reward.code,
				count = reward.num
			}))
		end

		if #_tmpTable > 0 then
			table.sort(_tmpTable, ItemUtil.commonSortFunc)

			for _, _itemData in ipairs(_tmpTable) do
				local luaTable = {
					code = _itemData:getItemId(),
					count = _itemData:getCount(),
					rewardStatus = hasPassed and CommEnum.RewardEnum.HasGot or CommEnum.RewardEnum.CanNotGot,
					itemData = _itemData,
					itemSign = CommEnum.BackPackItemSignTyp.First,
					signTyp = CommEnum.BackPackItemSignTyp.First
				}

				luaTable.itemData:setCount(_itemData:getCount())
				table.insert(lst, luaTable)

				if maxNum <= #lst then
					break
				end
			end
		end
	end

	if maxNum > #lst then
		local _tmpTable = {}

		for i, code in ipairs(self._curDungeonMo:getImportantPassReward()) do
			table.insert(_tmpTable, ItemUtil.createItemData({
				itemId = code
			}))
		end

		if #_tmpTable > 0 then
			table.sort(_tmpTable, ItemUtil.commonSortFunc)

			for _, _itemData in ipairs(_tmpTable) do
				local luaTable = {
					code = _itemData:getItemId(),
					itemData = _itemData,
					rewardStatus = CommEnum.RewardEnum.CanNotGot
				}

				luaTable.itemData:setCount(0)
				table.insert(lst, luaTable)

				if maxNum <= #lst then
					break
				end
			end
		end
	end

	if hasPassed and #lst == 0 then
		local _tmpTable = {}

		for i, reward in ipairs(self._curDungeonMo:getAllFirstPassReward()) do
			table.insert(_tmpTable, ItemUtil.createItemData({
				itemId = reward.code,
				count = reward.num
			}))
		end

		if #_tmpTable > 0 then
			table.sort(_tmpTable, ItemUtil.commonSortFunc)

			for _, _itemData in ipairs(_tmpTable) do
				local luaTable = {
					code = _itemData:getItemId(),
					count = _itemData:getCount(),
					rewardStatus = hasPassed and CommEnum.RewardEnum.HasGot or CommEnum.RewardEnum.CanNotGot,
					itemSign = CommEnum.BackPackItemSignTyp.Get,
					itemData = _itemData,
					signTyp = CommEnum.BackPackItemSignTyp.Get
				}

				luaTable.itemData:setCount(_itemData:getCount())
				table.insert(lst, luaTable)

				if maxNum <= #lst then
					break
				end
			end
		end
	end

	local maxDisplayCount = math.min(maxNum, #lst)

	self._allRewardCells = self._allRewardCells or {}
	self._allRewardGos = self._allRewardGos or {}

	for k, v in pairs(self._allRewardGos) do
		goutil.setActive(v, false)
	end

	for i = 1, maxDisplayCount do
		local itemCell = self._allRewardCells[i]

		if not itemCell then
			local go = goutil.cloneAndSetParent(self._rewardPrefab, root)

			itemCell = Astral.LuaComponentContainer.Add(go, RewardCell)
			self._allRewardCells[i] = itemCell
			self._allRewardGos[i] = go
		end

		local data = lst[i]

		itemCell:updateData(data)
		goutil.setActive(self._allRewardGos[i], true)
	end
end

function M:_refreshStarPanel()
	local star = self._curDungeonMo:getStar()
	local starRequire = self._curDungeonMo:getStarRequire()

	for i = 1, 3 do
		goutil.setActive(self._starFinishSignGoList[i], star[i])

		self._starDescTxtList[i].color = star[i] and Astral.ColorUtil.ParseColor("#ffffff") or Astral.ColorUtil.ParseColor("#747474")
	end

	for i = 1, 3 do
		local dungeonStarCOWrapper = DungeonConfig.instance:getDungeonStarCOWrapper(starRequire[i])

		if dungeonStarCOWrapper then
			self._starDescTxtList[i].text = dungeonStarCOWrapper:getDescription()
		elseif enableErrorLog then
			printError("三星条件id不存在:", starRequire[i])
		end
	end
end

function M:updateTopCurrencyShow()
	local chapterId = self._curChapterMo:getChapterId()
	local showTypeKeyStr = string.format("MaterialChapter%s", chapterId)

	self:localNotify(EventType.UPDAET_TOP_MONEY_VIEW_SHOW, CommEnum.MoneyShowType[showTypeKeyStr])
end

function M:_onOpenSkillSmallTips()
	local param = {}

	param.obj = self._btnSkillUp.transform.parent.gameObject
	param.skillType = CommEnum.CharacterSkillType.Type4

	ViewMgr.instance:open(ViewName.AchievementSkillSmallTips, param)
end

return M
