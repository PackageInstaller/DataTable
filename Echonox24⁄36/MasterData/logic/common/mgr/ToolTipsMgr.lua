-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/mgr/ToolTipsMgr.lua

module("logic.common.mgr.ToolTipsMgr", package.seeall)

function showTips(viewName, info)
	ViewMgr.instance:open(viewName, info)
end

function showTipsBlock(viewName, info)
	TipsBlockController.instance:openView(viewName, info)
end

function closeAllItemTips(isQuickClose)
	local closeType = isQuickClose and WindowType.WindowCloseReasonType.QuickCloseType or WindowType.WindowCloseReasonType.NormalCloseType

	for _, _viewName in ipairs(ToolTipsUtil.getAllItemTipsView() or {}) do
		if ViewMgr.instance:isOpen(_viewName) then
			ViewMgr.instance:close(_viewName, false, closeType)
		end
	end
end

function showGainItemView(info, openBlock)
	if openBlock then
		ToolTipsMgr.showTipsBlock(ViewName.GainItemView, info)
	else
		ToolTipsMgr.showTips(ViewName.GainItemView, info)
	end
end

function showSkillTips(heroId, skillCode, hangGO, isPassEvent, hideCD, awakeStatus)
	return
end

function showBattleSkillTips(skillInfo)
	local info = ToolTipsUtil.createSkillTipsData(skillInfo, true)

	info.defaultShowAll = true

	local viewName = ViewName.ToolTipsCharacterSkillDetailViewPresentor

	if ViewMgr.instance:isOpen(viewName) then
		ViewMgr.instance:close(viewName, false, WindowType.WindowCloseReasonType.QuickCloseType)
		ViewMgr.instance:destroy(viewName, false, true)
	end

	ToolTipsMgr.showTips(viewName, info)
end

function showBattleBuffTips(unit, hangGO, forceAlign, forceTipsAlignVer, maskClickClose)
	local info = ToolTipsUtil.createBattleBuffTipsData(unit, hangGO, forceAlign, forceTipsAlignVer, maskClickClose)

	ToolTipsMgr.showTips(ViewName.ToolTipsBattleBuffViewPresentor, info)
end

function showHeroInfoTip(heroId, isConfigOnly, hangGO)
	local info = ToolTipsUtil.creatHeroTipsData(heroId, isConfigOnly, hangGO)

	ToolTipsMgr.showTips(ViewName.RoleInfoTipsViewPresentor, info)
end

function showHealthExchangeTips()
	if ViewMgr.instance:isOpen(ViewName.HealthTipsView) then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.HealthExchangeTipsView) then
		return
	end

	ToolTipsMgr.showTips(ViewName.HealthExchangeTipsView)
end

function showHealthTips(itemData)
	local info = ToolTipsUtil.createHealthTipsData(itemData)

	ToolTipsMgr.showTips(ViewName.HealthTipsView, info)
end

function showHealthGetActionTimeTipsView(addEnergy)
	local info = {
		addEnergy = addEnergy
	}

	ToolTipsMgr.showTipsBlock(ViewName.HealthGetActionTimeTipsView, info)
end

function showUseItemTips(item, maxUseCount, isHandleExpireTime, title, hint)
	if not item or item:getCount() < 0 then
		printWarn("批量使用物品为空或者数量小于0")

		return
	end

	local info = ToolTipsUtil.createUseItemTipsData(item, maxUseCount, isHandleExpireTime, title, hint)

	ToolTipsMgr.showTips(ViewName.UseItemTipsView, info)
end

function showFacilityHoldingInfoTips(roomId, protomerId)
	local info = ToolTipsUtil.createFacilityHoldingInfoTipsData(roomId, protomerId)

	ToolTipsMgr.showTips(ViewName.FacilityHoldingInformationTipsView, info)
end

function showFacilityHoldingBillboardTips(roomId)
	local info = ToolTipsUtil.createFacilityHoldingBillboardTipsData(roomId)

	ToolTipsMgr.showTips(ViewName.FacilityHoldingBillboardTipsView, info)
end

function showFacilityHoldingModuleTips(protomerId, moduleCode, moduleId, moduleLockTyp)
	local info = ToolTipsUtil.createFacilityHoldingModuleTipsData(protomerId, moduleCode, moduleId, moduleLockTyp)

	ToolTipsMgr.showTips(ViewName.FacilityHoldingModuleTipsView, info)
end

function showFacilityHoldingReportSpeedupTips(roomId)
	local info = ToolTipsUtil.createFacilityHoldingReportSpeedupTipsData(roomId)

	ToolTipsMgr.showTips(ViewName.FacilityHoldingReportSpeedupTipsView, info)
end

function showFacilityHoldingUnlockConditionTips(protomerId)
	local info = ToolTipsUtil.createFacilityHoldingUnlockConditionTipsData(protomerId)

	ToolTipsMgr.showTips(ViewName.FacilityHoldingUnlockConditionTipsView, info)
end

function showHouseRoomActiveTips(roomId, focus, callBackFunc, callBackHandler)
	local info = ToolTipsUtil.createHouseRoomActiveTipsData(roomId, focus, callBackFunc, callBackHandler)

	ToolTipsMgr.showTips(ViewName.RoomActiveDialogTipsView, info)
end

function showDailySignInTips()
	local info = ToolTipsUtil.createDailySignInTipsData()

	ToolTipsMgr.showTips(ViewName.DailySignInTips, info)
end

function showSevenSignInTips(actId)
	local info = ToolTipsUtil.createSevenSignInTipsData(actId)

	ToolTipsMgr.showTips(ViewName.SevenSignInTips, info)
end

function showCurrencyExchangeTips(id, minMulti, isMulti, multiStep, titleStr)
	local info = ToolTipsUtil.createCurrencyExchangeTipsData(id, minMulti, isMulti, multiStep, titleStr)

	ToolTipsMgr.showTips(ViewName.CurrencyExchangeTipsView, info)
end

function showItemExchangeTips(sourceId, targetId, sourceStep, targetStep, isMulti, minMulti, maxLimit, jumpId)
	local info = ToolTipsUtil.createItemExchangeTipsData(sourceId, targetId, sourceStep, targetStep, isMulti, minMulti, maxLimit, jumpId)

	ToolTipsMgr.showTips(ViewName.ItemExchangeTipsView, info)
end

function showCommonUsePropSingleTips(itemId, costCount, txtContent, moneyShowType, confirmCallBackFunc, confirmCallBackHandler, timerCallBack, timerCallBackHandler)
	local info = {
		itemId = itemId,
		costCount = costCount,
		txtContent = txtContent,
		moneyShowType = moneyShowType,
		confirmCallBackFunc = confirmCallBackFunc,
		confirmCallBackHandler = confirmCallBackHandler,
		timerCallBack = timerCallBack,
		timerCallBackHandler = timerCallBackHandler
	}

	ToolTipsMgr.showTips(ViewName.CommonUsePropSingleTipsView, info)
end

function showPoachingPayTips(heroId)
	local info = ToolTipsUtil.createPoachingPayTipsData(heroId)

	ToolTipsMgr.showTips(ViewName.PoachingPayTips, info)
end

function showHandbookMonsterdataEvaluateTips(monsterId)
	local info = ToolTipsUtil.createHandbookMonsterdataEvaluateTipsData(monsterId)

	ToolTipsMgr.showTips(ViewName.HandbookMonsterdataEvaluateTipsView, info)
end

function showHandbookCampTips(camp)
	local info = ToolTipsUtil.createHandbookCampTipsData(camp)

	ToolTipsMgr.showTips(ViewName.HandbookRelationCampTipsView, info)
end

function showEchoUpgradeShowView(echoItemId, curLevel)
	local info = ToolTipsUtil.createEchoUpgradeShowViewData(echoItemId, curLevel)

	ToolTipsMgr.showTips(ViewName.EchoUpgradeShowView, info)
end

function showMultiFightTipsView(dungeonId, maxMultiCount, canQuickFight, canProxy, gamePlay)
	local info = ToolTipsUtil.createMultiFightTipsViewData(dungeonId, maxMultiCount, canQuickFight, canProxy, gamePlay)

	ViewMgr.instance:open(ViewName.EquipExploreMultiplicityFightTipsView, info)
end

function showControlMultiFightView(dungeonId, gamePlay)
	local info = ToolTipsUtil.createControlActionMultiFightData(dungeonId, gamePlay)

	ViewMgr.instance:open(ViewName.ControlActionQuickTake, info)
end

function showHouseFurnitureSimpleInfoTips(itemId)
	local info = ToolTipsUtil.createHouseFurnitureSimpleInfoTipsData(itemId)

	ViewMgr.instance:open(ViewName.ToolTipsFurnitureSimpleInfoView, info)
end

function showAirWorkShopRodeoCheckRecordTips()
	local info = ToolTipsUtil.createAirWorkShopRodeoCheckRecordTipsData()

	ToolTipsMgr.showTips(ViewName.AirWorkShopRodeoCheckRecordTips, info)
end

function showAirWorkShopFreeCheckRecordTips()
	local info = ToolTipsUtil.createAirWorkShopFreeCheckRecordTipsData()

	ToolTipsMgr.showTips(ViewName.AirWorkShopRodeoCheckRecordTips, info)
end

function showAirWorkShopRodeoRewardTips()
	local info = ToolTipsUtil.createAirWorkShopRodeoRewardTipsData()

	ToolTipsMgr.showTips(ViewName.AirWorkShopRodeoRewardTips, info)
end

function showAirWorkShopChallengeStatisticsTips(id)
	local info = ToolTipsUtil.createAirWorkShopChallengeStatisticsTipsData(id)

	ToolTipsMgr.showTips(ViewName.AirWorkShopChallengeStatisticsTips, info)
end

function showAirWorkShopFreeRankTipsView()
	local info = ToolTipsUtil.createAirWorkShopFreeRankTipsViewData()

	ToolTipsMgr.showTips(ViewName.AirWorkShopFreeRankTipsView, info)
end

function showAirWorkShopRodeoWeekRewardTips(oldLv, curLv)
	local info = {
		oldLv = oldLv,
		curLv = curLv
	}

	ToolTipsMgr.showTips(ViewName.AirWorkShopRodeoWeekRewardTips, info)
end

function showAirWorkShopRodeoFinishResultTips(roundList, exitFunc, exitHandler)
	local info = {
		roundList = roundList,
		exitFunc = exitFunc,
		exitHandler = exitHandler
	}

	ToolTipsMgr.showTips(ViewName.AirWorkShopRodeoFinishResultTips, info)
end

function showAirWorkShopRodeoRankTips()
	local info = {}

	ToolTipsMgr.showTips(ViewName.AirWorkShopRodeoRankTips, info)
end

function showAirWorkShopMessageLogTipsView(id, cover, hideEditBtn, editBtnInteractable)
	local info = {
		id = id,
		cover = cover,
		hideEditBtn = hideEditBtn,
		editBtnInteractable = editBtnInteractable
	}

	ToolTipsMgr.showTips(ViewName.AirWorkShopMessageLogTipsView, info)
end

function showAirWorkShopBattleCalculateTagView(mapId, tagIds)
	local info = {
		id = mapId,
		tagIds = tagIds
	}

	if ViewMgr.instance:isOpen(ViewName.AirWorkBattleCalculateTagView) then
		ViewMgr.instance:close(ViewName.AirWorkBattleCalculateTagView, false, WindowType.WindowCloseReasonType.QuickCloseType, false)
	end

	ToolTipsMgr.showTips(ViewName.AirWorkBattleCalculateTagView, info)
end

function showOpenFunctionsHintTips(code, isBlock, exitFunc, exitHandler, singleMode)
	local cfg = SystemOpenConfig.instance:getSystemOpenHint(code)

	if not cfg then
		printWarn(string.format("无法从[t_%s]找到[%s]的配置，不打开功能开启界面", ConfigName.SystemOpenHint, code))

		if exitFunc then
			if exitHandler then
				exitFunc(exitHandler)
			else
				exitFunc()
			end
		end

		return
	end

	local info = ToolTipsUtil.createOpenFunctionsHintTipsData(code, singleMode, exitFunc, exitHandler)

	if isBlock then
		ToolTipsMgr.showTipsBlock(ViewName.OpenFunctionsHintTips, info)
	else
		ToolTipsMgr.showTips(ViewName.OpenFunctionsHintTips, info)
	end
end

function showOpenChapterTips(code, exitFunc, exitHandler)
	local cfg = SystemOpenConfig.instance:getSystemOpenHint(code)

	if not cfg then
		printWarn(string.format("无法从[t_%s]找到[%s]的配置，不打开功能开启界面", ConfigName.SystemOpenHint, code))

		if exitFunc then
			exitFunc(exitHandler)
		end

		return
	end

	local info = {
		cfg = cfg,
		exitFunc = exitFunc,
		exitHandler = exitHandler
	}

	ToolTipsMgr.showTips(ViewName.ChapterOpenTipsView, info)
end

function showAirtightRoomTimeShowTips()
	local info

	ToolTipsMgr.showTips(ViewName.AirtightRoomTimeShowTips, info)
end

function showAirtightRoomTimeOpenTips()
	local info

	ToolTipsMgr.showTips(ViewName.AirtightRoomTimeOpenTips, info)
end

function showCharacterTopToast(content, topToastIcon, delayHide, isPermanent)
	local info = ToolTipsUtil.createCharacterTopToastData(content, topToastIcon, delayHide, isPermanent)

	if ViewMgr.instance:isOpen(ViewName.CharacterTopToastTips) then
		ViewMgr.instance:close(ViewName.CharacterTopToastTips, false, WindowType.WindowCloseReasonType.QuickCloseType, false)
	end

	ToolTipsMgr.showTips(ViewName.CharacterTopToastTips, info)
end

function getSkillTipsInfo()
	return {
		hasDispatch = true,
		defaultShowAll = false,
		hangGO = false,
		hideCD = false,
		enhanceCodes = false,
		simulateCloseWhenDraging = false,
		heroId = false,
		entityId = false,
		skillId = false,
		offsetY = false,
		awakeStatus = false,
		isPreview = false,
		isPassEvent = true,
		popType = false,
		offsetX = false,
		hideEnhanceDetail = false,
		skillStatus = false,
		forceAlign = false
	}
end

function showCharacterSysSkillTips(skillTipsInfo)
	local enhanceCodes = skillTipsInfo.enhanceCodes
	local isCustom = false

	if enhanceCodes then
		isCustom = true
	end

	local info = ToolTipsUtil.createSkillTipsData(skillTipsInfo, isCustom)

	TableUtil.dump(info)

	local viewName = ViewName.ToolTipsCharacterSkillDetailViewPresentor

	if ViewMgr.instance:isOpen(viewName) then
		ViewMgr.instance:close(viewName, false, WindowType.WindowCloseReasonType.QuickCloseType)
		ViewMgr.instance:destroy(viewName, false, true)
	end

	ToolTipsMgr.showTips(viewName, info)
end

function showManualSkillTips(skillInfo)
	local isCustom = false

	if skillInfo.enhanceCodes then
		isCustom = true
	end

	local info = ToolTipsUtil.createSkillTipsData(skillInfo, isCustom)

	ToolTipsMgr.showTips(ViewName.ToolTipsCharacterSkillManualViewPresentor, info)
end

function showCharacterAuthorityUpgradeResultTips(info)
	ToolTipsMgr.showTips(ViewName.CharacterAuthorityUpgradeResultTips, info)
end

function showCharacterRoleFileTips(heroId)
	local info = ToolTipsUtil.createCharacterRoleFileTipsData(heroId)

	ToolTipsMgr.showTips(ViewName.CharacterFileTips, info)
end

function showCharacterVoiceTips(heroId)
	local info = ToolTipsUtil.createCharacterVoiceTipsData(heroId)

	ToolTipsMgr.showTips(ViewName.CharacterVoiceTipsView, info)
end

function showCharacterHeartAnchorImpressionUpgradeResultTips(heroId, lvBefore, lvAfter)
	local info = ToolTipsUtil.createCharacterHeartAnchorImpressionUpgradeResultTipsData(heroId, lvBefore, lvAfter)

	ToolTipsMgr.showTips(ViewName.CharacterHeartAnchorImpressionUpgradeResultTips, info)
end

function showCharacterHeartAnchorBreakResultTips(heroId, skinId, curLv, exitFunc, exitHandler)
	local info = {
		heroId = heroId,
		skinId = skinId,
		curLv = curLv,
		exitFunc = exitFunc,
		exitHandler = exitHandler
	}

	ToolTipsMgr.showTips(ViewName.CharacterHeartAnchorBreakResultTipsView, info)
end

function showCharacterHeartAnchorCarryItemInfoTips(heroId, carryItemId)
	local info = ToolTipsUtil.createCharacterHeartAnchorCarryItemInfoTipsData(heroId, carryItemId)

	ToolTipsMgr.showTips(ViewName.CharacterHeartAnchorCarryItemInfoTips, info)
end

function showBranchUnlockTips(dungeonId, inPlotOpen)
	local info = ToolTipsUtil.createBranchUnlockTipsData(dungeonId, inPlotOpen)

	ToolTipsMgr.showTips(ViewName.BranchUnlockTipsView, info)
end

function showCommonTopToastRewardItemNotice(itemDataList, delayHide)
	local info = ToolTipsUtil.createTopToastRewardItemNoticeData(itemDataList, delayHide)

	if ViewMgr.instance:isOpen(ViewName.TopToastRewardItemNoticeView) then
		ViewMgr.instance:close(ViewName.TopToastRewardItemNoticeView, false, WindowType.WindowCloseReasonType.QuickCloseType, false)
	end

	ToolTipsMgr.showTips(ViewName.TopToastRewardItemNoticeView, info)
end

function showSkillBuffTagSideTips(skillEnhanceMO, bindGo, isPassEvent, heroId, skillId, skillEnhanceCodeLst)
	local info = ToolTipsUtil.createSkillBuffTagSideTipsData(skillEnhanceMO, bindGo, isPassEvent, heroId, skillId, skillEnhanceCodeLst)

	if info then
		if ViewMgr.instance:isOpen(ViewName.ToolTipsSkillBuffTagTipsViewPresentor) then
			ViewMgr.instance:destroy(ViewName.ToolTipsSkillBuffTagTipsViewPresentor, false, true)
		end

		ToolTipsMgr.showTips(ViewName.ToolTipsSkillBuffTagTipsViewPresentor, info)
	end
end

function showSkillBuffTagSideTipsWithCodes(buffCodes, tagCodes, bindGo, isPassEvent, forceAlign, forceTipsAlignVer)
	local info = ToolTipsUtil.createSkillBuffTagSideTipsWithCodesData(buffCodes, tagCodes, bindGo, isPassEvent, forceAlign, forceTipsAlignVer)

	if info then
		if ViewMgr.instance:isOpen(ViewName.ToolTipsSkillBuffTagTipsViewPresentor) then
			ViewMgr.instance:destroy(ViewName.ToolTipsSkillBuffTagTipsViewPresentor, false, true)
		end

		ToolTipsMgr.showTips(ViewName.ToolTipsSkillBuffTagTipsViewPresentor, info)
	end
end

function showLeaveMsgSubjectTips(context, paragraphIndex)
	local info = {
		context = context,
		paragraphIndex = paragraphIndex
	}

	ToolTipsMgr.showTips(ViewName.LeaveMsgSubjectTipsView, info)
end

function showLeaveMsgWordTips(context, paragraphIndex)
	local info = {
		context = context,
		paragraphIndex = paragraphIndex
	}

	ToolTipsMgr.showTips(ViewName.LeaveMsgWordTipsView, info)
end

function showLeaveMsgConjunctionTips(context)
	local info = {
		paragraphIndex = 2,
		context = context
	}

	ToolTipsMgr.showTips(ViewName.LeaveMsgConjunctionTipsView, info)
end

function showLeaveMsgVoiceHeroTips(context)
	local info = {
		context = context
	}

	ToolTipsMgr.showTips(ViewName.LeaveMsgVoiceHeroTipsView, info)
end

function showLeaveMsgVoiceResTips(context)
	if not context then
		return
	end

	local heroId = context:getVoiceHero() and context:getVoiceHero() or -1

	if heroId <= 0 then
		return
	end

	local info = {
		context = context
	}

	ToolTipsMgr.showTips(ViewName.LeaveMsgVoiceResTipsView, info)
end

function showLeaveMsgEmojiTips(context)
	local info = {
		context = context
	}

	ToolTipsMgr.showTips(ViewName.LeaveMsgEmojiTipsView, info)
end

function showPlayerInfoTips(bindGo, uid, playerLv, portrait, nickName)
	local info = {
		bindGo = bindGo,
		uid = uid,
		playerLv = playerLv,
		portrait = portrait,
		nickName = nickName
	}

	if ViewMgr.instance:isOpen(ViewName.ToolTipsAirWorkPlayerInfoTipsViewPresentor) then
		ViewMgr.instance:close(ViewName.ToolTipsAirWorkPlayerInfoTipsViewPresentor, false, WindowType.WindowCloseReasonType.QuickCloseType, false)
	end

	ToolTipsMgr.showTips(ViewName.ToolTipsAirWorkPlayerInfoTipsViewPresentor, info)
end

function showPlayerUpgradeShowView(info, openBlock)
	if openBlock then
		ToolTipsMgr.showTipsBlock(ViewName.PlayerUpgradeShowView2, info)
	else
		ToolTipsMgr.showTips(ViewName.PlayerUpgradeShowView2, info)
	end
end

function showTopToastAirWorkTrophyNotice(itemDataList, delayHide)
	local info = {
		itemDataList = itemDataList,
		delayHide = delayHide
	}

	if ViewMgr.instance:isOpen(ViewName.AirWorkShopTrophyTopTips) then
		ViewMgr.instance:close(ViewName.AirWorkShopTrophyTopTips, false, WindowType.WindowCloseReasonType.QuickCloseType, false)
	end

	ToolTipsMgr.showTips(ViewName.AirWorkShopTrophyTopTips, info)
end

function showAuchorBreakDesc(title, content, bindGo)
	info = {
		isPassEvent = true,
		title = title,
		content = content,
		bindGo = bindGo
	}

	if ViewMgr.instance:isOpen(ViewName.ToolTipsAnchorBreakView) then
		ViewMgr.instance:close(ViewName.ToolTipsAnchorBreakView, false, WindowType.WindowCloseReasonType.QuickCloseType, false)
	end

	ToolTipsMgr.showTips(ViewName.ToolTipsAnchorBreakView, info)
end
