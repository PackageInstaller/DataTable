-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/judgesystem/RogueJudgeView.lua

module("logic.extensions.roguelike.view.judgesystem.RogueJudgeView", package.seeall)

local kThrowTipsShowDelayTime = 5
local kShowQuitBtnRound = 0
local kWaitForTeachTime = 10
local kWaitForSwitchBtnTime = 10
local kShowCardItemIndex = {
	{
		3
	},
	{
		3,
		4
	},
	{
		2,
		3,
		4
	},
	{
		2,
		3,
		4,
		5
	},
	{
		1,
		2,
		3,
		4,
		5
	},
	{
		1,
		2,
		3,
		4,
		5,
		6
	}
}
local M = class("RogueJudgeView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._goExtraPts = {}
	self._curRoundTextIndex = 1
	self._cardItems = {}
end

function M:buildUI()
	self._goTeach = self:getGo("rungroup_dice_view_-1438267768")
	self._bottomBtn = self:getBtn("rungroup_dice_view_1271550211")
	self._btnSuccess = self:getBtn("rungroup_dice_view_-2144282883")
	self._btnFail = self:getBtn("rungroup_dice_view_711033444")
	self._btnDrag = UIPassableDragTrigger.Get(self._bottomBtn.gameObject)
	self._goRound = self:getGo("rungroup_dice_view_-1538084641")
	self._aniRound = self._goRound:GetComponent(ComponentType.Animation)
	self._txtRound = self:getText("rungroup_dice_view_1969371743")
	self._goRoundTitle = self:getGo("rungroup_dice_view_1283543785")
	self._goSixInfo = self:getGo("rungroup_dice_view_981331722")
	self._qua6Ploygon = UIPolygon.Get(self:getGo("rungroup_dice_view_1943579919"))

	self._qua6Ploygon:Init(6)

	self._goExtraPtItem = self:getGo("rungroup_dice_view_copy_-696925944")
	self._traExtraPtParent = self:getGo("rungroup_dice_view_copy_-466934571").transform
	self._goExtraPtEmpty = self:getGo("rungroup_dice_view_1928294608")
	self._goEnemyHp = self:getGo("rungroup_dice_view_28540807")
	self._txtEnemyHp = self:getText("rungroup_dice_view_1141404539")
	self._goRoleHp = self:getGo("rungroup_dice_view_1146982641")
	self._txtRoleHp = self:getText("rungroup_dice_view_1322536734")
	self._traCardParent = self:getGo("rungroup_dice_view_-1426553779").transform
	self._traCardDanShu = goutil.findChild(self._traCardParent.gameObject, "danShu").transform
	self._traCardShuangShu = goutil.findChild(self._traCardParent.gameObject, "shuangShu").transform
	self._aniCardParent = self._traCardParent:GetComponent(ComponentType.Animation)
	self._goExtraPattern = self:getGo("rungroup_dice_view_copy_-272041848")
	self._btnCloseExtraPattern = self:getBtn("rungroup_dice_view_-2072026574")
	self._btnExtraPatternDetail = self:getBtn("rungroup_dice_view_copy_-2085034490")
	self._btnExtraHint = self:getBtn("rungroup_dice_view_copy_-1555096807")
	self._btnExtraExplain = self:getBtn("0&btn_explain_-1936547904")
	self._btnJudgeExplain = self:getBtn("rungroup_dice_view_copy_-203006267")
	self._btnSelectCard = self:getBtn("rungroup_dice_view_-1947932559")
	self._btnProp = self:getBtn("rungroup_dice_view_copy_730910196")
	self._goSanity = self:getGo("9&rungroup_sanity_item_-1911028484")
	self._goHeadGroup = self:getGo("rungroup_dice_view_copy_503862590")
	self._goPropList = self:getGo("rungroup_dice_view_copy_-632247426")
	self._goRoleInfo = goutil.findChild(self.mainGO, "role_info_detail")
	self._goCardContainer = self:getGo("rungroup_dice_view_copy_141146417")
	self._goBottomNormal = self:getGo("rungroup_dice_view_copy_732242252")
	self._txtEventDiff = self:getText("rungroup_dice_view_copy_-551488321")
	self._iconEventJudge = self:getImage("rungroup_dice_view_copy_-495183622")
	self._goEventFail = self:getGo("rungroup_dice_view_copy_-1516602515")
	self._goTeach = self:getGo("rungroup_dice_view_-1438267768")
	self._txtJudgeTips = self:getText("rungroup_dice_view_-127251271")
	self._btnQuit = self:getBtn("rungroup_dice_view_-708473867")
	self._goReminder = self:getGo("rungroup_dice_view_-1042577388")
	self._traBroadcastHeadParent = self:getGo("rungroup_dice_view_-1776509882").transform
	self._goBroadcastHeadItem = self._traBroadcastHeadParent:GetChild(0).gameObject
	self._goDiceDescTips = self:getGo("rungroup_dice_view_-2101343444")
	self._diceDescTips = Astral.LuaComponentContainer.Add(self._goDiceDescTips, RogueDiceDescTips)
	self._btnCloseDesc = self:getBtn("rungroup_dice_view_-1374251213")
	self.go_card_mask = self:getGo("rungroup_dice_view_-688037725")
	self._sanityItem = Astral.LuaComponentContainer.Add(self._goSanity, RogueSanityItem)

	self._sanityItem:updateData()

	self._propBtnItem = Astral.LuaComponentContainer.Add(self._btnProp.gameObject, RoguePropBtnItem)
	self._teamHead = Astral.LuaComponentContainer.Add(self._goHeadGroup, RogueTeamHead)

	self._teamHead:setClickCallback(function(idx)
		self:_onRoleHeadClick(idx)
	end)

	self._propListTips = Astral.LuaComponentContainer.Add(self._goPropList, RoguePropListTips)
	self._roleInfoDetail = Astral.LuaComponentContainer.Add(self._goRoleInfo, RogueRoleInfoDetail)
	self._cardContainer = Astral.LuaComponentContainer.Add(self._goCardContainer, RogueJudgeCardContainer)

	self._cardContainer:setCardSelectCallback(function(idx)
		self:onSmallCardSelect(idx)
	end)
	self._cardContainer:setCardPrefab(self:getResInstance(ResName.Rungroupother_rungroup_judge_card))
	goutil.setActive(self._goReminder, false)
	goutil.setActive(self._goEnemyHp, false)
	goutil.setActive(self._goSixInfo, false)

	local patterns = {
		"power",
		"agile",
		"knowledge",
		"communicate",
		"insight",
		"lucky"
	}

	self._goPatternSelects = {}
	self._goPatternNormals = {}
	self._txtSixLevels = {}

	for k, v in pairs(patterns) do
		table.insert(self._goPatternSelects, goutil.findChild(self._goSixInfo, v .. "/select"))
		table.insert(self._goPatternNormals, goutil.findChild(self._goSixInfo, v .. "/normal"))
		table.insert(self._txtSixLevels, goutil.findChildTextComponent(self._goSixInfo, v .. "/select/txtLevel"))
	end

	self._txtExtraPatternCount = self:getText("rungroup_dice_view_-211252069")
	self._goMonsterCard = self:getGo("rungroup_dice_view_680127508")
	self._monsterCard = Astral.LuaComponentContainer.Add(goutil.findChild(self._goMonsterCard, "readjust_item"), RogueJudgeCard)

	self:_initCardContainer()
end

function M:destroyUI()
	self._sanityItem:OnDestroy()
	self._propBtnItem:OnDestroy()
	self._teamHead:OnDestroy()
	self._propListTips:OnDestroy()
	self._roleInfoDetail:OnDestroy()
end

function M:bindEvents()
	self._btnSuccess:AddClickListener(self._onClickSuccess, self)
	self._btnFail:AddClickListener(self._onClickFail, self)
	self._btnDrag:AddBeginDragListener(self._onBeginDrag, self)
	self._btnDrag:AddDragListener(self._onDrag, self)
	self._btnDrag:AddEndDragListener(self._onEndDrag, self)
	self._btnExtraPatternDetail:AddClickListener(self._onClickExtraPatternDetail, self)
	self._btnExtraHint:AddClickListener(self._onClickExtraHint, self)
	self._btnExtraExplain:AddClickListener(self._onClickExtraExplain, self)
	self._btnJudgeExplain:AddClickListener(self._onClickJudgeExplain, self)
	self._btnSelectCard:AddClickListener(self._onClickSelectCard, self)
	self._btnCloseExtraPattern:AddClickListener(self._onClickCloseExtraHint, self)
	self._btnQuit:AddClickListener(self._onClickQuit, self)
	self._btnCloseDesc:AddClickListener(self._onClickCloseDesc, self)
	self._btnProp:AddClickListener(self._onClickProp, self)
end

function M:unbindEvents()
	self._btnSuccess:RemoveClickListener()
	self._btnFail:RemoveClickListener()
	self._btnDrag:RemoveBeginDragListener()
	self._btnDrag:RemoveDragListener()
	self._btnDrag:RemoveEndDragListener()
	self._btnDrag:SetPassToGameObject(nil)
	self._btnExtraPatternDetail:RemoveClickListener()
	self._btnExtraHint:RemoveClickListener()
	self._btnExtraExplain:RemoveClickListener()
	self._btnJudgeExplain:RemoveClickListener()
	self._btnSelectCard:RemoveClickListener()
	self._btnCloseExtraPattern:RemoveClickListener()
	self._btnQuit:RemoveClickListener()
	self._btnCloseDesc:RemoveClickListener()
	self._btnProp:RemoveClickListener()
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_QUIT_SUCCESS, self._onQuitSuccess, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_HAD_EXTRA_RESULT, self._onExtraResult, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_RESULT_FINISH, self._onResultFinish, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_SHOW_NEXT_ROLE_PREPARE, self._onShowNextRolePrepare, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_SHOW_ROLE_ANI, self._onPlayRoleAni, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_ROUND_BEGIN, self._onRoundBegin, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_CHANGE_ROLE, self._onRoleChange, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_ROLE_DEATH, self._onRoleDeath, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_BEGIN_DICE_THROW, self._onShowThrowTips, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_REFRESH_EXTRA_PATTERN, self._onExtraPatternRefresh, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_CREATE_COMBAT_DICE, self._updateCombatDice, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_REFRESH_COMBAT_DICE_COUNT, self._changeCombatDice, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_JUDGE_ROLE_SELECT, self._judgeRoleSelectAction, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_REFRESH_ROLE_DICE_WALL, self._refreshRoleDiceWall, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_FIRST_ROLE_SWITCH, self._onFirstRoleSwitch, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_ADD_BROADCAST_HEAD, self._onAddBroadcastHead, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_SHOW_CUR_MONSTER_CARD, self._onShowMonsterCard, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_SELECT_ROLE_UNIT, self._onSelectRoleUnit, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_QUIT_SUCCESS, self._onQuitSuccess, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_HAD_EXTRA_RESULT, self._onExtraResult, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_RESULT_FINISH, self._onResultFinish, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SHOW_NEXT_ROLE_PREPARE, self._onShowNextRolePrepare, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SHOW_ROLE_ANI, self._onPlayRoleAni, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_ROUND_BEGIN, self._onRoundBegin, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_CHANGE_ROLE, self._onRoleChange, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_ROLE_DEATH, self._onRoleDeath, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_BEGIN_DICE_THROW, self._onShowThrowTips, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_REFRESH_EXTRA_PATTERN, self._onExtraPatternRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_CREATE_COMBAT_DICE, self._updateCombatDice, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_REFRESH_COMBAT_DICE_COUNT, self._changeCombatDice, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_JUDGE_ROLE_SELECT, self._judgeRoleSelectAction, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_REFRESH_ROLE_DICE_WALL, self._refreshRoleDiceWall, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_FIRST_ROLE_SWITCH, self._onFirstRoleSwitch, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_ADD_BROADCAST_HEAD, self._onAddBroadcastHead, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SHOW_CUR_MONSTER_CARD, self._onShowMonsterCard, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SELECT_ROLE_UNIT, self._onSelectRoleUnit, self)
	end
end

function M:_initCardContainer()
	self._traDanShuContainer = {}
	self._traShuangeShuContainer = {}

	for i = 1, self._traCardDanShu.childCount do
		table.insert(self._traDanShuContainer, self._traCardDanShu:GetChild(i - 1))
	end

	for i = 1, self._traCardShuangShu.childCount do
		table.insert(self._traShuangeShuContainer, self._traCardShuangShu:GetChild(i - 1))
	end

	goutil.setActive(self._traCardDanShu.gameObject, true)
	goutil.setActive(self._traCardShuangShu.gameObject, true)
end

function M:_onRoleHeadClick(index)
	local data = {}

	data.index = index

	function data.closeCallback()
		self._teamHead:reset()
	end

	self._roleInfoDetail:updateData(data)
end

function M:_onQuitSuccess()
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_SKIP_TO_JUDGE_RESULT, false)
end

function M:onEnter()
	RendererFeatureUtil.toggleRendererFeature(RendererFeatureName.SHIELD_RIPPLE, true, self._viewPresentor:getViewName())

	local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_GUIDE_INFO, GuideEnum.GuideRoguelikeTriggerType.JudgeType, eventType)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Dice)

	if not RogueMgr.instance:getIsClientMode() then
		RoguelikeAgent.instance:sendJudgeArchiveRequest(nil)
	end

	self:showEnterBroadCast()
	self:_onRoundBegin()
	self:setGoActive()
	self:updateExtraPattern()
	self:updateJudgeTips()
	goutil.setActive(self.go_card_mask, false)
end

function M:onExit()
	if ViewMgr.instance:isOpen(ViewName.ImageGuide) then
		ViewMgr.instance:close(ViewName.ImageGuide)
	end

	if ViewMgr.instance:isOpen(ViewName.RogueMonsterCard) then
		ViewMgr.instance:close(ViewName.RogueMonsterCard)
	end

	RendererFeatureUtil.toggleRendererFeature(RendererFeatureName.SHIELD_RIPPLE, false, self._viewPresentor:getViewName())
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Dice)
	self:setEvent(false)

	if RogueMgr.instance:getModel() then
		local roleMos = RogueMgr.instance:getModel():getAllRoleMos()

		for k, v in pairs(roleMos) do
			v.transform:setPositionXYZ(-20, 0, 0)
			v.transform:setActive(false)
			v.infoBar:setVisible(false)
		end

		local mapMgr = RogueMgr.instance:getMapMgr()

		if mapMgr then
			mapMgr:setActive(true)
		end
	end

	self:onShowResultFinish()

	self._lastRoleMo = false

	removetimer(self.onShowResultFinish, self)
	removetimer(self.syncRoleActive, self)
	removetimer(self.onShowTipsFinish, self)
	removetimer(self._delayShowThrowTips, self)
	removetimer(self._onShowThrowTips, self)
	removetimer(self.showTeachSlider, self)
	removetimer(self._delayShowSwitchGuide, self)
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_FORECAST_LINE, false)
end

function M:_onClickClose()
	self:close()
end

function M:_onClickSuccess()
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_SKIP_TO_JUDGE_RESULT, true)
end

function M:_onClickFail()
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_SKIP_TO_JUDGE_RESULT, false)
end

function M:_onBeginDrag(eventData)
	self._originPos = eventData.position

	return true
end

function M:_onDrag(eventData)
	local dragPosition = eventData.position

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_DICE_DRAG, self._originPos, dragPosition, eventData.delta)

	return true
end

function M:_onEndDrag(eventData)
	local endPosition = eventData.position

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_DICE_THROW, self._originPos, endPosition, eventData.delta)
	self:_onHideThrowTips()

	return true
end

function M:checkOnlyOne(roleId)
	local roleMos = RogueMgr.instance:getModel():getAllRoleMos()

	for k, v in pairs(roleMos) do
		if v.roleProp:getRoleId() ~= roleId and not v.roleProp:getIsDeath() then
			return false
		end
	end

	return true
end

function M:onShowResultFinish()
	return
end

function M:_onExtraResult(sender, result)
	if self._goExtraResult == nil then
		self._goExtraResult = self:getResInstance(ResName.Rungroupjudgement_jedgement_special_result)

		goutil.addChildToParent(self._goExtraResult, self.mainGO)
	end

	goutil.setActive(self._goExtraResult, true)

	local success = goutil.findChild(self._goExtraResult, "bigSucceed")

	goutil.setActive(success, result == RoguelikeConst.ROGUE_EXTRA_TYPE.BIG_SUCCESS)
	settimer(1.5, self.onShowExtraResultFinish, self, false)
end

function M:onShowExtraResultFinish()
	goutil.setActive(self._goExtraResult, false)
end

function M:_onShowNextRolePrepare(sender, roleIndex)
	self._curRoleIndex = roleIndex

	local roleMo = RogueMgr.instance:getModel():getAllRoleMos()[roleIndex]
	local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()
	local isEventJudge = RogueMgr.instance:getRogueFlow().model:getIsEventJudge()
	local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE
	local mapMgr = RogueMgr.instance:getMapMgr()
	local pos = mapMgr:getMapRolePos()

	if self._curRoleMo and eventType ~= RoguelikeConst.ROGUE_EVENT_TYPE.SINGLE_EVENT then
		self._lastRoleMo = self._curRoleMo

		self._lastRoleMo.meshModel:setDirection(UnitSpineDir.Left)
		self._lastRoleMo.meshModel:play(UnitAnimState.Walk, true)

		local idx = self._lastRoleMo.roleProp:getRoleIndex()
		local position = Vector3.New(pos.x, 0, pos.z + (idx - 1) * kMapItemSize)

		self._lastRoleMo.transform:doMove(position, 1):OnComplete(self.delayChangeSpineState2, self)
	end

	if roleMo then
		roleMo.transform:setActive(true)
		roleMo.infoBar:setVisible(true)
		roleMo.meshModel:play(UnitAnimState.Walk, true)

		local idx = roleMo.roleProp:getRoleIndex()
		local midPos = Vector3.New(pos.x + kMapItemSize, 0, pos.z + 1 * kMapItemSize)

		roleMo.transform:doMove(midPos, 1):OnComplete(self.delayChangeSpineState, self)
		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_paotuan_chess_forward)
	end

	self._curRoleMo = roleMo
end

function M:delayChangeSpineState()
	self._curRoleMo.meshModel:play(UnitAnimState.Idle, true)
	goutil.setActive(self._bottomBtn.gameObject, true)

	local mapMgr = RogueMgr.instance:getMapMgr()
	local pos = mapMgr:getMapRolePos()
	local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE

	VirtualCameraMgr.instance:doFollowPosition(pos.x + 2.5 * kMapItemSize, RoguelikeConst.MAP_ROLE_OFFSET_Y, pos.z + 1.5 * kMapItemSize - RoguelikeConst.MAP_ROLE_OFFSET_Z, 0.5)
end

function M:delayChangeSpineState2()
	if self._lastRoleMo and self._lastRoleMo.roleProp:getIsDeath() then
		self._lastRoleMo.meshModel:play(RoguelikeConst.ROGUE_ROLE_ANI.DEATH, false)
		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_paotuan_chess_die)
		settimer(2.5, function()
			if self._lastRoleMo then
				self._lastRoleMo.transform:setActive(false)
				self._lastRoleMo.infoBar:setVisible(false)
			end
		end, self, false)

		return
	end

	self._lastRoleMo.meshModel:play(UnitAnimState.Idle, true)
	self._lastRoleMo.meshModel:setDirection(UnitSpineDir.Right)

	local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()

	if eventType == RoguelikeConst.ROGUE_EVENT_TYPE.ENCOUNTER_EVENT then
		self._lastRoleMo.transform:setActive(false)
		self._lastRoleMo.infoBar:setVisible(false)
	end
end

function M:showRoleSixInfo(roleProp)
	function getRealIndex(idx)
		if idx == 1 then
			return 2
		elseif idx == 2 then
			return 1
		elseif idx == 6 then
			return 3
		elseif idx == 5 then
			return 4
		elseif idx == 3 then
			return 0
		elseif idx == 4 then
			return 5
		end
	end

	local qua6List = {}

	for i = 1, 6 do
		table.insert(qua6List, roleProp:getPropertyLevel(i))
		self._qua6Ploygon:InitPolygon(getRealIndex(i), CharacterCOUtil.qua2Ratio(qua6List[i]))

		self._txtSixLevels[i].text = qua6List[i]

		TextUtils.SetColor(self._txtSixLevels[i], CharacterCOUtil.qua2Color(qua6List[i]))
	end
end

function M:_onRoundBegin(sender, round)
	local roundIndex = round or RogueMgr.instance:getStateMgr():getRoundIndex()
	local isEventJudge = RogueMgr.instance:getRogueFlow().model:getIsEventJudge()

	goutil.setActive(self._btnQuit.gameObject, roundIndex >= kShowQuitBtnRound and not isEventJudge)

	self._txtRound.text = roundIndex

	self:updateRoundTitle(round)
	goutil.setActive(self._goBottomNormal, true)
	goutil.setActive(self._goCardContainer, true)
	goutil.setActive(self._traCardParent.gameObject, false)
end

function M:updateRoundTitle(round)
	local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()
	local roundIndex = round or RogueMgr.instance:getStateMgr():getRoundIndex()
	local roundText = roundIndex

	goutil.setActive(self._goRoundTitle, eventType == RoguelikeConst.ROGUE_EVENT_TYPE.FIGHT_EVENT)

	if eventType == RoguelikeConst.ROGUE_EVENT_TYPE.SINGLE_EVENT then
		roundText = string.format(lang("tip_r_single_judge"), "")
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.MULTI_EVENT then
		roundText = string.format(lang("tip_r_mult_judge"), "")
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.ENCOUNTER_EVENT then
		roundText = lang("tip_r_encounter_judge")
	end

	self._txtRound.text = roundText
end

function M:playRoundAni()
	local roundIndex = RogueMgr.instance:getStateMgr():getRoundIndex()
	local roundText = roundIndex

	self._txtRound.text = roundText

	self._aniRound:Play("rungroup_dice_view_round_open")
end

function M:_onRoleChange(sender, roleId, roleIndex)
	self:updateExtraPattern()

	if roleIndex == 1 then
		-- block empty
	end
end

function M:_onRoleDeath(sender, roleId, roleIndex)
	local roleMo = RogueMgr.instance:getModel():getAllRoleMos()[roleIndex]

	if roleMo then
		roleMo.meshModel:play(RoguelikeConst.ROGUE_ROLE_ANI.DEATH, false, true)
		removetimer(self.syncRoleActive, self)
		settimer(1.5, self.syncRoleActive, self)
		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_paotuan_chess_die)
	end
end

function M:syncRoleActive()
	local roleMos = RogueMgr.instance:getModel():getAllRoleMos()

	for k, v in pairs(roleMos) do
		if v.roleProp:getIsDeath() then
			v.transform:setActive(false)
			v.infoBar:setVisible(false)
		end
	end
end

function M:_onPlayRoleAni(sender, aniName, changeIdleTime)
	if not self._curRoleMo then
		return
	end

	removetimer(self._onRoleAniFinish, self)

	self.lastRoleAniName = aniName

	self._curRoleMo.meshModel:play(aniName, false, true)
	settimer(changeIdleTime, self._onRoleAniFinish, self, false)
end

function M:_onRoleAniFinish()
	if not self._curRoleMo then
		return
	end

	if self.lastRoleAniName == RoguelikeConst.ROGUE_ROLE_ANI.DEATH then
		self._curRoleMo.transform:setActive(false)

		return
	end

	self._curRoleMo.meshModel:play(RoguelikeConst.ROGUE_ROLE_ANI.IDLE, true, true)
end

function M:_onClickExtraPatternDetail()
	ViewMgr.instance:open(ViewName.RogueSurfaceTips)
end

function M:_onClickExtraHint()
	local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()

	if eventType ~= RoguelikeConst.ROGUE_EVENT_TYPE.FIGHT_EVENT then
		return
	end

	self._goExtraHintShow = not self._goExtraHintShow

	if self._goExtraHintShow then
		self:updateExtraPattern()
	end

	goutil.setActive(self._goExtraPattern, self._goExtraHintShow)

	if self._goExtraHintShow then
		if eventType == RoguelikeConst.ROGUE_EVENT_TYPE.FIGHT_EVENT then
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_GUIDE_INFO, GuideEnum.GuideRoguelikeTriggerType.ActiveUI, ViewName.RogueMonsterJudge, self._goExtraPattern)
		else
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_GUIDE_INFO, GuideEnum.GuideRoguelikeTriggerType.ActiveUI, ViewName.RogueEventJudge, self._goExtraPattern)
		end
	end
end

function M:_onClickExtraExplain()
	ViewMgr.instance:open(ViewName.ImageGuide, {
		CommEnum.ManualKey.RogueExtraTips
	})
end

function M:_onClickJudgeExplain()
	local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()

	if eventType == RoguelikeConst.ROGUE_EVENT_TYPE.FIGHT_EVENT then
		ViewMgr.instance:open(ViewName.ImageGuide, {
			CommEnum.ManualKey.RogueFight
		})
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.SINGLE_EVENT then
		ViewMgr.instance:open(ViewName.ImageGuide, {
			CommEnum.ManualKey.RogueSingle
		})
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.MULTI_EVENT then
		ViewMgr.instance:open(ViewName.ImageGuide, {
			CommEnum.ManualKey.RogueMult
		})
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.ENCOUNTER_EVENT then
		ViewMgr.instance:open(ViewName.ImageGuide, {
			CommEnum.ManualKey.RogueEncounter
		})
	end
end

function M:_onClickSelectCard()
	self:onSmallCardSelect(1)
end

function M:updateJudgeTips()
	local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()

	self._txtJudgeTips.text = eventType == RoguelikeConst.ROGUE_EVENT_TYPE.FIGHT_EVENT and lang("tip_r_judge_monster_hint") or lang("tip_r_judge_event_hint")
end

function M:_onClickCloseExtraHint()
	self._goExtraHintShow = false

	goutil.setActive(self._goExtraPattern, self._goExtraHintShow)
end

function M:_onClickQuit()
	local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_r_script_quit"))

	dialog:setConfirmListener(function()
		RoguelikeAgent.instance:sendQuitRequest()
		goutil.setActive(self.go_card_mask, true)
	end, self)
end

function M:_onClickSwitchAction()
	self._isShowActionCard = not self._isShowActionCard

	if self._inSelectAction then
		goutil.setActive(self._traCardParent.gameObject, self._isShowActionCard)
		removetimer(self._delayShowSwitchGuide, self)

		if not self._isShowActionCard then
			settimer(kWaitForSwitchBtnTime, self._delayShowSwitchGuide, self, false)
		end
	end
end

function M:_delayShowSwitchGuide()
	return
end

function M:pairsPatternByKeys(t)
	local temp = {}

	for n in pairs(t) do
		temp[#temp + 1] = n
	end

	table.sort(temp, function(a, b)
		local aLevel = RoguePredictionUtil.instance:getPatternCalcCount(RoguelikeUtil.instance:convertSAttrTypeCSType(a))
		local bLevel = RoguePredictionUtil.instance:getPatternCalcCount(RoguelikeUtil.instance:convertSAttrTypeCSType(b))

		if aLevel ~= bLevel then
			return bLevel < aLevel
		else
			return b < a
		end
	end)

	local result = {}

	for k, v in pairs(temp) do
		table.insert(result, {
			v,
			t[v]
		})
	end

	return result
end

function M:updateExtraPattern()
	local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()

	if eventType ~= RoguelikeConst.ROGUE_EVENT_TYPE.FIGHT_EVENT then
		self._txtExtraPatternCount.text = ""

		return
	end

	local index = RogueMgr.instance:getModel():getCurRoleIndex()
	local extraPattern, usedPatterns = RogueMgr.instance:getStateMgr():getTmpExtraFaces(true)
	local patternCount = #extraPattern

	if self._txtExtraPatternCount.text ~= tostring(patternCount) then
		DoTweenUtil.ToInt(self._lastPatternCount or 0, patternCount, 0.5, 0, DG.Tweening.Ease.Linear, 0, DG.Tweening.LoopType.Incremental, nil, function(value)
			self._txtExtraPatternCount.text = value
		end, function()
			self._txtExtraPatternCount.text = #extraPattern
		end, nil)
	end

	self._lastPatternCount = patternCount
	self._txtExtraPatternCount.text = #extraPattern

	local temp = {}
	local temp2 = {}

	for k, v in pairs(extraPattern) do
		temp[v] = temp[v] or 0
		temp[v] = temp[v] + 1
	end

	for k, v in pairs(usedPatterns) do
		temp2[v] = temp2[v] or 0
		temp2[v] = temp2[v] + 1
	end

	for i = 0, self._traExtraPtParent.childCount - 1 do
		goutil.setActive(self._traExtraPtParent:GetChild(i).gameObject, false)
	end

	goutil.setActive(self._goExtraPtEmpty, #extraPattern + #usedPatterns == 0)

	temp = self:pairsPatternByKeys(temp)

	local tempIndex = 0

	for k, v in pairs(temp) do
		tempIndex = tempIndex + 1

		local item = self._goExtraPts[tempIndex]

		if not item then
			item = Astral.GameObjectUtil.CloneAndSetParent(self._goExtraPtItem, self._traExtraPtParent, nil)
			self._goExtraPts[tempIndex] = item
		end

		goutil.setActive(item, true)

		local icon = goutil.findChild(item, "icon"):GetComponent("Image")
		local count = goutil.findChild(item, "txtCount"):GetComponent("Text")
		local imgLevel = goutil.findChildImageComponent(item, "level")

		count.text = "x" .. v[2]

		local face = RoguelikeUtil.instance:convertSAttrTypeCSType(v[1])
		local level = RoguelikeConst.GetPatternLevel(face)

		IconLoader.setSprite(icon, IconType.DynSpriteAtlas_Dice, string.format("dice_%d", RoguelikeConst.GetPatterIcon(face)))
		IconLoader.setSprite(imgLevel, IconType.DynSpriteAtlas_Dice, string.format("dice_num_%d", level))

		local isRed = RoguelikeConst.GetPatternType(face) == RoguelikeConst.DICE_PATTERN.BLEEDING or RoguelikeConst.GetPatternType(face) == RoguelikeConst.DICE_PATTERN.CURSE

		icon.color = isRed and Astral.ColorUtil.ParseColor("#c64949") or Astral.ColorUtil.ParseColor("#7cabbc")
	end

	for k, v in pairs(temp2) do
		tempIndex = tempIndex + 1

		local item = self._goExtraPts[tempIndex]

		if not item then
			item = Astral.GameObjectUtil.CloneAndSetParent(self._goExtraPtItem, self._traExtraPtParent, nil)
			self._goExtraPts[tempIndex] = item
		end

		goutil.setActive(item, true)

		local icon = goutil.findChild(item, "icon"):GetComponent("Image")
		local count = goutil.findChild(item, "txtCount"):GetComponent("Text")
		local imgLevel = goutil.findChildImageComponent(item, "level")

		count.text = "x" .. v

		local face = RoguelikeUtil.instance:convertSAttrTypeCSType(k)
		local level = RoguelikeConst.GetPatternLevel(face)

		IconLoader.setSprite(icon, IconType.DynSpriteAtlas_Dice, string.format("dice_%d", RoguelikeConst.GetPatterIcon(face)))
		IconLoader.setSprite(imgLevel, IconType.DynSpriteAtlas_Dice, string.format("dice_num_%d", level))

		icon.color = Astral.ColorUtil.ParseColor("#7b7b7b")
	end
end

function M:_onShowThrowTips()
	if not RoguelikeConst.IsGuildMode() then
		settimer(kThrowTipsShowDelayTime, self._delayShowThrowTips, self, false)
	else
		settimer(1, self._onShowThrowTips, self, false)
	end
end

function M:_delayShowThrowTips()
	goutil.setActive(self._goTeach, true)
end

function M:_onHideThrowTips()
	removetimer(self._delayShowThrowTips, self)
	goutil.setActive(self._goTeach, false)
end

function M:_onExtraPatternRefresh(sender, patternCount)
	if patternCount then
		self._txtExtraPatternCount.text = patternCount

		return
	end

	self:updateExtraPattern()
end

function M:_judgeRoleSelectAction(sender, actionIds, callback)
	self._actionIds = actionIds
	self._selectActionCallback = callback
	self._inSelectAction = true
	self._isShowActionCard = true

	self:updateCardInfo()

	local isFirst = RogueMgr.instance:getModel():getIsFirstRondRoleIndex()

	goutil.setActive(self._goBottomNormal, isFirst)
	goutil.setActive(self._goCardContainer, isFirst)
	goutil.setActive(self._traCardParent.gameObject, not isFirst)

	for k, v in pairs(self._cardItems) do
		v:setSelect(false, false, true)
	end
end

function M:showSixInfoHighLight(idx)
	for i = 1, 6 do
		goutil.setActive(self._goPatternSelects[i], i == idx)
		goutil.setActive(self._goPatternNormals[i], i ~= idx)
	end
end

function M:_refreshRoleDiceWall(sender, wallCount)
	goutil.setActive(self._goRoleHp, wallCount > 0)

	self._txtRoleHp.text = "x" .. wallCount

	local originCount = self._lastWallCount or 0

	DoTweenUtil.ToInt(originCount, wallCount, 0.5, 0, DG.Tweening.Ease.Linear, 0, DG.Tweening.LoopType.Incremental, nil, function(value)
		self._txtRoleHp.text = "x" .. value
	end, function()
		self._txtRoleHp.text = "x" .. wallCount
	end, nil)

	self._lastWallCount = wallCount
end

function M:_onFirstRoleSwitch()
	self:playRoundAni()
end

function M:_onShowMonsterCard(sender, data)
	self._monsterCard:updateData(data)
	goutil.setActive(self._goMonsterCard, true)
	self._monsterCard:playAnimation("readjust_item_appear")
	settimer(2, function()
		goutil.setActive(self._goMonsterCard, false)
	end, self, false)
end

function M:_onSelectRoleUnit()
	return
end

function M:_onAddBroadcastHead(sender, data)
	local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()

	if eventType ~= RoguelikeConst.ROGUE_EVENT_TYPE.FIGHT_EVENT then
		return
	end

	self._broadcastDatas = self._broadcastDatas or {}
	self._broadcastHeadItems = self._broadcastHeadItems or {}

	table.insert(self._broadcastDatas, data)

	local showListData = {}

	if #self._broadcastDatas <= 5 then
		showListData = self._broadcastDatas
	else
		for i = #self._broadcastDatas - 4, #self._broadcastDatas do
			table.insert(showListData, self._broadcastDatas[i])
		end
	end

	for k, v in pairs(showListData) do
		local item = self._broadcastHeadItems[k]

		if not item then
			local go = goutil.cloneAndSetParent(self._goBroadcastHeadItem, self._traBroadcastHeadParent)

			item = Astral.LuaComponentContainer.Add(go, RogueDiceRoleHeadItem)
			self._broadcastHeadItems[k] = item
		end

		local itemData = {}

		itemData.data = showListData[k]

		local broadcastData = showListData[k]
		local index = k

		function itemData.callback()
			self:_onBroadcastHeadClick(broadcastData, index)
		end

		if broadcastData.isRole then
			itemData.roleId = broadcastData.sourceId
		else
			itemData.monsterId = broadcastData.sourceId
		end

		item:updateData(itemData)
		item:setSelect(false)
	end
end

function M:_onBroadcastHeadClick(data, index)
	for k, v in pairs(self._broadcastHeadItems) do
		v:setSelect(k == index)
	end

	local posY = self._broadcastHeadItems[index]._go.transform.position.y + 0.5

	self._diceDescTips:setPosY(posY)
	self._diceDescTips:updateData(data)
end

function M:_onClickCloseDesc()
	self._diceDescTips:setActive(false)

	for k, v in pairs(self._broadcastHeadItems) do
		v:setSelect(false)
	end
end

function M:_onClickProp()
	self._propListTips:updateData()
end

function M:onSmallCardSelect(index)
	if index ~= 1 then
		return
	end

	goutil.setActive(self._goBottomNormal, false)
	goutil.setActive(self._goCardContainer, false)
	goutil.setActive(self._traCardParent.gameObject, true)
end

function M:updateCardInfo()
	for k, v in pairs(self._cardItems) do
		v:setActive(false)
	end

	removetimer(self.showTeachSlider, self)

	local cardData = {}

	cardData.index = RogueMgr.instance:getModel():getCurRoleIndex()

	self._cardContainer:updateData(cardData)

	for i = 1, #self._actionIds do
		local item = self._cardItems[i]
		local realIndex = i
		local co = RoguelikeConfig.instance:getRoleActionById(self._actionIds[realIndex])
		local data = {}

		data.name = co.name
		data.co = co

		local pattern = RoguelikeUtil.instance:convertCAttrType2SType(co.attr)
		local attrLevel = CharacterCOUtil.qua2Score(self._curRoleMo.roleProp:getPropertyLevel(co.attr))
		local attrText = string.format("<color=#%s>%s</color>", RoguelikeConst.ATTR_COLOR[self._curRoleMo.roleProp:getPropertyLevel(co.attr)], attrLevel)

		data.attr = RoguelikeConst.AttrType2Name[pattern]
		data.attrLevel = self._curRoleMo.roleProp:getPropertyLevel(co.attr)
		data.pattern = co.attr
		data.isBan = RoguelikeModel.instance:getCardIsBan(i)
		data.isInCd = RoguelikeModel.instance:getCardIsInCd(i)
		data.cd = RoguelikeModel.instance:getCardCdByIndex(i)
		data.center = self._bottomBtn.gameObject
		data.slotCount = RoguelikeUtil.instance:getCardSlotCount(self._curRoleMo.roleProp:getPropertyLevel(co.attr))

		local cardEntries, tempEntries, continueEntries = RogueMgr.instance:getRogueFlow().judgeModel:getSelectCardEntries(self._actionIds[realIndex], nil, i)

		cardEntries = cardEntries or {}
		data.effect = RoguePredictionUtil.instance:predictionRoleActionRang(self._curRoleMo.roleProp, self._curRoleIndex, co, data.attrLevel, cardEntries)
		data.entryEffectText = RoguePredictionUtil.instance:getCardEntryEffectDesc(cardEntries)
		data.cardEntries = cardEntries
		tempEntries = tempEntries or {}
		continueEntries = continueEntries or {}
		data.outline = #cardEntries > 0
		data.throwDiceText = string.format("投掷%sx%d", RoguelikeConst.GetAttrGraphic(pattern, 20), self._curRoleMo.roleProp:getPropertyLevel(co.attr))

		if co.useTime > 0 then
			data.useTimeOut = RogueMgr.instance:getRogueFlow().stateMgr:getJudgeCardUseCount(co.id) >= co.useTime
		end

		if not item then
			local go = self:getResInstance(ResName.Rungroupother_rungroup_judge_card)

			item = Astral.LuaComponentContainer.Add(go, RogueJudgeCard)
			self._cardItems[i] = item
		end

		local index = i
		local attr = i

		function data.selectCallback()
			self:onCardSelect(index, attr)
		end

		function data.useCallback()
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_FORECAST_LINE, false)
			self:useCard(index)
		end

		function data.longPressCallback(isLongPressOn)
			if isLongPressOn then
				self:showCardDetail(index)
			else
				self:hideCardDetail()
			end
		end

		function data.longPressExitCallback(isExit)
			self:hideCardDetail()
		end

		function data.beginDragCallback(eventData)
			self._beginDragPos = eventData.position
			self._isShowLine = false
		end

		function data.dragCallback(eventData)
			self:hideCardDetail()

			if eventData.position.y - self._beginDragPos.y > 20 and not self._isShowLine then
				GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_FORECAST_LINE, false)
				GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_FORECAST_LINE, true, self._actionIds[realIndex])

				self._isShowLine = true
			elseif eventData.position.y - self._beginDragPos.y < 20 and self._isShowLine then
				GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_FORECAST_LINE, false)

				self._isShowLine = false
			end
		end

		self:_setJudgeCardPos(item:getGo(), i, #self._actionIds)
		item:resetState()
		item:updateData(data)
	end
end

function M:_setJudgeCardPos(go, index, totalCount)
	local isDanShu = math.fmod(totalCount, 2) ~= 0
	local parent = isDanShu and self._traDanShuContainer or self._traShuangeShuContainer
	local showIndex = kShowCardItemIndex[totalCount][index]

	go.transform:SetParent(parent[showIndex], false)
end

function M:showCardDetail(index)
	if self._cardTips == nil then
		local go = self:getResInstance(ResName.Rungroupexplore_dice_effect_container)

		go.transform:SetParent(self.mainGO.transform, false)

		self._cardTips = Astral.LuaComponentContainer.Add(go, RogueJudgeCardTips)
	end

	self:hideCardDetail()

	local data = {}

	data.leftData = {}
	data.rightData = {}

	local cardIndex = index
	local cardEntries = RogueMgr.instance:getRogueFlow().judgeModel:getSelectCardEntries(self._actionIds[index], self._curRoleMo.roleProp, cardIndex)

	for k, v in pairs(cardEntries) do
		local entryCo = RoguelikeConfig.instance:getCardEntryById(cardEntries[k])

		if entryCo then
			if entryCo.type == 2 then
				table.insert(data.rightData, v)
			end

			if entryCo.type == 1 then
				table.insert(data.leftData, v)
			end
		end
	end

	self._cardTips:setParent(self._cardItems[index]:getTransform(), false)
	self._cardTips:updateData(data)
end

function M:hideCardDetail()
	if self._cardTips ~= nil then
		self._cardTips:setActive(false)
	end
end

function M:onCardSelect(index, attr)
	local item = self._cardItems[index]
	local isSelect = item:getIsSelect()

	for k, v in pairs(self._cardItems) do
		v:setSelect(k == index)
	end

	self._selectCardIndex = index

	removetimer(self.showTeachSlider, self)
	settimer(kWaitForTeachTime, self.showTeachSlider, self, false)
end

function M:showTeachSlider()
	for k, v in pairs(self._cardItems) do
		v:showTeach(k == self._selectCardIndex)
	end
end

function M:useCard(idx)
	if self._selectActionCallback then
		self._selectActionCallback(idx)
	end

	self._inSelectAction = false

	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_paotuan_cardattack)
	settimer(0.3, self.onShowTipsFinish, self, false)
end

function M:onShowTipsFinish()
	goutil.setActive(self._traCardParent.gameObject, false)
end

return M
