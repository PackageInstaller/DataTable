-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/detail/new/CharacterDetailFragmentViewNew.lua

module("logic.extensions.charactersystem.view.detail.new.CharacterDetailFragmentViewNew", package.seeall)

local M = class("CharacterDetailFragmentViewNew", CharacterMainSystemSubViewBase)

M.AttTyp = BattleExtension_pb.Attribute
M.AttPartTyp = BattleExtension_pb.AttributePart
M.AttDataTyp = {
	Resistance = 6,
	Attack = 3,
	Hp = 1,
	Defence = 5,
	Inspiration = 2,
	Ether = 4
}
M.AttDataTyp2AttrGradeIndexInCfg = {
	[M.AttDataTyp.Hp] = 1,
	[M.AttDataTyp.Inspiration] = 2,
	[M.AttDataTyp.Attack] = 3,
	[M.AttDataTyp.Defence] = 4,
	[M.AttDataTyp.Ether] = 5,
	[M.AttDataTyp.Resistance] = 6
}
M.AttDataDefine = {
	[M.AttDataTyp.Hp] = {
		att = M.AttTyp.MAX_HP,
		attPart = M.AttPartTyp.PART_MAX_HP_ADDITION
	},
	[M.AttDataTyp.Inspiration] = {
		att = M.AttTyp.INSPIRATION
	},
	[M.AttDataTyp.Attack] = {
		att = M.AttTyp.ATK_PHY,
		attPart = M.AttPartTyp.PART_ATK_PHY_ADDITION
	},
	[M.AttDataTyp.Defence] = {
		att = M.AttTyp.DEF_PHY,
		attPart = M.AttPartTyp.PART_DEF_PHY_ADDITION
	},
	[M.AttDataTyp.Ether] = {
		att = M.AttTyp.ATK_MAG,
		attPart = M.AttPartTyp.PART_ATK_MAG_ADDITION
	},
	[M.AttDataTyp.Resistance] = {
		att = M.AttTyp.DEF_MAG,
		attPart = M.AttPartTyp.PART_DEF_MAG_ADDITION
	}
}

function M:getReOpenAnimName()
	return "open2"
end

function M:getPageIndex()
	return CommEnum.CharacterSystemTab.Detail
end

function M:buildUI()
	M.super.buildUI(self)

	local mainGO = self._registry:getMainGO()

	self._goTipsModelOptimizing = goutil.findChild(mainGO, "hint").gameObject

	goutil.setActive(self._goTipsModelOptimizing, false)

	self._btnCloth = self._registry:getBtn("character_detail_panel_-438641463")
	self._btnSkinPreview = self._registry:getBtn("7&com_btn_3_437414469")
	self._textSkinPreview = self._registry:getText("7&com_btn_3_1380422008")
	self._btnPresets = self._registry:getBtn("character_detail_panel_-810569798")
	self._btnToAirtightTime = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "btnList/preview_btn_group/btnPreviewHA"))
	self._btnToNormalTime = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "btnList/preview_btn_group/btnPreviewQuit"))
	self._canvasInAirtightPreview = goutil.findChildComponent(mainGO, "preview_heartanchor_hint", ComponentType.CanvasGroup)
	self._canvasInAirtightPreview.alpha = 0

	goutil.setActive(self._canvasInAirtightPreview.gameObject, true)

	self._txtLvCur = self._registry:getText("character_detail_panel_1717236827")
	self._txtLvMax = self._registry:getText("character_detail_panel_1699488454")
	self._imgExpSlider = self._registry:getImage("character_detail_panel_1602556178")
	self._btnIncrExp = self._registry:getBtn("character_detail_panel_799334164")
	self._txtExp = self._registry:getText("character_detail_panel_-454384519")
	self._topAreaClickEffect = self._registry:getGo("7&com_tips_decorate_-46004659")
	self._clickAnimation = self._topAreaClickEffect:GetComponent(ComponentType.Animation)
	self._txtMove = self._registry:getText("character_detail_panel_461948594")
	self._txtAttackRange = self._registry:getText("character_detail_panel_-742286622")
	self._attributeCell = {}

	local _attributeRoot = self._registry:getGo("character_detail_panel_-263133239")

	for key, value in pairs(M.AttDataTyp) do
		local go = goutil.findChild(_attributeRoot, string.format("attItem_%s", value))

		self._attributeCell[value] = {
			imgS = goutil.findChild(go, "imgS"),
			txtLv = goutil.findChildTextComponent(go, "txtLevel"),
			txtVal1 = goutil.findChildTextComponent(go, "txtValue1"),
			txtVal2 = goutil.findChildTextComponent(go, "txtValue2")
		}
	end

	self._goPropertyPanel = self._registry:getGo("character_detail_panel_1880232793")
	self._txtPropertyMove = self._registry:getText("character_detail_panel_741599644")
	self._txtPropertyMove2 = self._registry:getText("character_detail_panel_-1917303253")
	self._txtPropertyShoot = self._registry:getText("character_detail_panel_1487771663")
	self._txtPropertyShoot2 = self._registry:getText("character_detail_panel_-1078472298")
	self._compsProperty = {
		[M.AttDataTyp.Hp] = {
			txtLv = self._registry:getText("character_detail_panel_-457114084"),
			txtVal1 = self._registry:getText("character_detail_panel_1870722717"),
			txtVal2 = self._registry:getText("character_detail_panel_-12472448")
		},
		[M.AttDataTyp.Inspiration] = {
			txtLv = self._registry:getText("character_detail_panel_1986626545"),
			txtVal1 = self._registry:getText("character_detail_panel_-745433020"),
			txtVal2 = self._registry:getText("character_detail_panel_-899585995")
		},
		[M.AttDataTyp.Attack] = {
			txtLv = self._registry:getText("character_detail_panel_-782804778"),
			txtVal1 = self._registry:getText("character_detail_panel_1634666983"),
			txtVal2 = self._registry:getText("character_detail_panel_-1749734031")
		},
		[M.AttDataTyp.Defence] = {
			txtLv = self._registry:getText("character_detail_panel_1210162241"),
			txtVal1 = self._registry:getText("character_detail_panel_2143262640"),
			txtVal2 = self._registry:getText("character_detail_panel_773818044")
		},
		[M.AttDataTyp.Ether] = {
			txtLv = self._registry:getText("character_detail_panel_-854262817"),
			txtVal1 = self._registry:getText("character_detail_panel_-983481647"),
			txtVal2 = self._registry:getText("character_detail_panel_1227979877")
		},
		[M.AttDataTyp.Resistance] = {
			txtLv = self._registry:getText("character_detail_panel_-1119037020"),
			txtVal1 = self._registry:getText("character_detail_panel_167686916"),
			txtVal2 = self._registry:getText("character_detail_panel_-1550758582")
		}
	}
	self._btnProperty = self._registry:getBtn("character_detail_panel_-1407988539")
	self._btnClickMask = self._registry:getBtn("empty_mask_tips_29887572")

	local passEvent = self._btnClickMask.gameObject:GetComponent(ComponentType.PassEvent)

	passEvent.isPassEvent = false
	self._imgTalentSkill = self._registry:getImage("character_detail_panel_-466338545")
	self._btnTalent = self._registry:getBtn("character_detail_panel_-466338545")
	self._goRedDotTacit = self._registry:getGo("character_detail_panel_-1787253240")
	self._btnTacit = self._registry:getBtn("character_detail_panel_1251581928")
	self._txtTacit = self._registry:getText("character_detail_panel_884190614")
	self._imgTacit = self._registry:getImage("character_detail_panel_1251581928")
	self._goTacitLock = self._registry:getGo("character_detail_panel_-288972291")

	local txtBtnTacitName = goutil.findChildComponent(self._btnTacit.gameObject, "Text1", UIComponentType.Text)

	txtBtnTacitName.text = lang("tip_tacit_entry_reshape")
	self._txtTacitName = self._registry:getText("character_detail_panel_688267203")
	self._txtTacitInfo = self._registry:getText("character_detail_panel_-451958124")
	self._goRedDotAnchorBreak = self._registry:getGo("character_detail_panel_1193385366")
	self._btnContract = self._registry:getBtn("character_detail_panel_15955028")

	local txtBtnContractName = goutil.findChildComponent(self._btnContract.gameObject, "Text1", UIComponentType.Text)

	txtBtnContractName.text = lang("tip_tacit_entry_breaklv")

	local anchorBreakRoot = self._registry:getGo("contract_break_point_80752649")

	self._anchorList = {}

	for i = 0, anchorBreakRoot.transform.childCount - 1 do
		self._anchorList[i + 1] = anchorBreakRoot.transform:GetChild(i).gameObject
	end

	self._goReshape = self._registry:getGo("character_detail_panel_-296902104")
	self._goReshapeImg1 = self._registry:getGo("character_detail_panel_-1644802452")
	self._goReshapeImg2 = self._registry:getGo("character_detail_panel_1345428360")
	self._goNotReshape = self._registry:getGo("character_detail_panel_-1701987040")
	self._txtReshapeStateBeforeTitle = self._registry:getText("character_detail_panel_340277750")
	self._txtReshapeStateAfterTitle = self._registry:getText("character_detail_panel_-565603911")

	self:_regLockStats(GameEnum.SystemEnum.RoleBreak, self._btnContract.gameObject, nil, nil)
	self:_regLockStats(GameEnum.SystemEnum.RoleUpgrade, self._btnIncrExp.gameObject, nil, nil)
	self:_regLockStats(GameEnum.SystemEnum.RoleSkin, self._btnCloth.gameObject, nil, nil)
	self:_regLockStats(GameEnum.SystemEnum.RoleModelPreview, self._btnSkinPreview.gameObject, nil, nil)
	self:_regLockStats(GameEnum.SystemEnum.HeroPreset, self._btnPresets.gameObject, nil, nil)
	self:_regLockStats(GameEnum.SystemEnum.Tacit, self._btnTacit.gameObject, nil, nil)

	self.isThisViewOpen = nil
	self._textSkinPreview.text = lang("tip_hero_skin_check_btn")
	self._btnExplain = UIComponentType.ButtonAdapter(goutil.findChild(self._goPropertyPanel, "btnExplain"))
end

function M:destroyUI()
	M.super.destroyUI(self)

	self._lockStatsGroup = nil
	self._clickAnimation = nil
end

function M:bindEvents()
	self._btnToAirtightTime:AddClickListener(self._onClickToAirtightTime, self)
	self._btnToNormalTime:AddClickListener(self._onClickToNormalTime, self)
	self._btnCloth:AddClickListener(self._onClickCloth, self)
	self._btnSkinPreview:AddClickListener(self._onClickSkinPreview, self)
	self._btnPresets:AddClickListener(self._onClickPreinstall, self)
	self._btnContract:AddClickListener(self._onClickContract, self)
	self._btnIncrExp:AddClickListener(self._onClickIncrExp, self)
	self._btnTacit:AddClickListener(self._onClickTacit, self)
	self._btnProperty:AddClickListener(self._onClickProperty, self)
	self._btnClickMask:AddClickListener(self._onClickMask, self)
	self._btnTalent:AddClickListener(self._onClickBtnTalent, self)
	self._btnExplain:AddClickListener(self._onClickExplain, self)
end

function M:unbindEvents()
	self._btnToAirtightTime:RemoveClickListener()
	self._btnToNormalTime:RemoveClickListener()
	self._btnCloth:RemoveClickListener()
	self._btnSkinPreview:RemoveClickListener()
	self._btnPresets:RemoveClickListener()
	self._btnContract:RemoveClickListener()
	self._btnIncrExp:RemoveClickListener()
	self._btnTacit:RemoveClickListener()
	self._btnProperty:RemoveClickListener()
	self._btnClickMask:RemoveClickListener()
	self._btnTalent:RemoveClickListener()
	self._btnExplain:RemoveClickListener()
end

function M:onEnter()
	M.super.onEnter(self)

	self.isThisViewOpen = true

	self:_setEvent(true)
	goutil.setActive(self._btnClickMask.gameObject, false)
	goutil.setActive(self._goPropertyPanel, false)
	self:showCharacterInfo()
	self:asyncLangText()
	self:_handleBtnActive()
	self:_handleOnSystemOpen()
	self:_refreshAirtightBtnStatus()

	local openOtherView = false

	if self.params and self.params[1] and self.params[1].openView and self.params[1].isNormal then
		openOtherView = self.params[1].openView
	end

	if openOtherView == CommEnum.CharacterSystemOpenView.Anchor then
		self:_onClickContract()
	elseif openOtherView == CommEnum.CharacterSystemOpenView.Upgrade or openOtherView == ViewName.CharacterUpgrade then
		self:_onClickIncrExp()
	elseif openOtherView == CommEnum.CharacterSystemOpenView.Tacit then
		self:_onClickTacit()
	end
end

function M:onExit()
	self:_setEvent(false)

	self.isThisViewOpen = false

	goutil.setActive(self._goTipsModelOptimizing, false)
end

function M:asyncLangText()
	self._txtReshapeStateBeforeTitle.text = lang("tip_tacit_state_before")
	self._txtReshapeStateAfterTitle.text = lang("tip_tacit_state_after")
end

function M:playGuiAni(name, isNormal)
	local __isNormal = true

	if isNormal ~= nil then
		__isNormal = isNormal
	end

	M.super.playGuiAni(self, name, isNormal)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.SKILL_ENHANCE_INFO_UPDATE, self.showCharacterInfo, self)
		GlobalDispatcher:addEventListener(EventType.REFRESH_HERO_DEPOT_DATA, self.showCharacterInfo, self)
		GlobalDispatcher:addEventListener(EventType.CHARACTER_DETAIL_STATUS_CHANGE, self._setVisible, self)
		GlobalDispatcher:addEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
		GlobalDispatcher:addEventListener(EventType.HERO_INFO_UNLOCK, self._refreshRedDot, self)
		GlobalDispatcher:addEventListener(EventType.HERO_INFO_RED_DOT_CHANGE, self._refreshRedDot, self)
		GlobalDispatcher:addEventListener(EventType.TACIT_REFRESH_TASK_VIEW, self._refreshRedDot, self)
		GlobalDispatcher:addEventListener(EventType.RED_DOT_UPDATE_EVENT, self._refreshRedDot, self)
		GlobalDispatcher:addEventListener(EventType.CHARACTER_MAIN_SYSTEM_SWITCH, self.showCharacterInfo, self)
		GlobalDispatcher:addEventListener(EventType.TACIT_TASK_INIT_EVENT, self._refreshRedDot, self)
		GlobalDispatcher:addEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SKILL_ENHANCE_INFO_UPDATE, self.showCharacterInfo, self)
		GlobalDispatcher:removeEventListener(EventType.REFRESH_HERO_DEPOT_DATA, self.showCharacterInfo, self)
		GlobalDispatcher:removeEventListener(EventType.CHARACTER_DETAIL_STATUS_CHANGE, self._setVisible, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
		GlobalDispatcher:removeEventListener(EventType.HERO_INFO_UNLOCK, self._refreshRedDot, self)
		GlobalDispatcher:removeEventListener(EventType.HERO_INFO_RED_DOT_CHANGE, self._refreshRedDot, self)
		GlobalDispatcher:removeEventListener(EventType.TACIT_REFRESH_TASK_VIEW, self._refreshRedDot, self)
		GlobalDispatcher:removeEventListener(EventType.RED_DOT_UPDATE_EVENT, self._refreshRedDot, self)
		GlobalDispatcher:removeEventListener(EventType.CHARACTER_MAIN_SYSTEM_SWITCH, self.showCharacterInfo, self)
		GlobalDispatcher:removeEventListener(EventType.TACIT_TASK_INIT_EVENT, self._refreshRedDot, self)
		GlobalDispatcher:removeEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
	end
end

function M:_setVisible(_, status)
	goutil.setActive(self.mainGO, status)
end

function M:_handleBtnActive()
	if ViewMgr.instance:isOpen(ViewName.CharacterPreview) then
		-- block empty
	end
end

function M:_handleAritightStateChange(e, isInAirtightTime, airtightEndTS)
	self:_refreshAirtightBtnStatus()
end

function M:getCurHeroData()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()

	return viewPageMo and viewPageMo.hero or false
end

function M:_onClickCloth()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleSkin, true) then
		return
	end

	local heroData = self:getCurHeroData()

	ViewMgr.instance:open(ViewName.CharacterSkinView, {
		openByMainSystem = true,
		heroId = heroData:getId(),
		skinId = heroData:getSkinId(),
		showType = HeroSkinEnum.ShowType.AllSkin
	})
end

function M:_onClickSkinPreview()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleModelPreview, true) then
		return
	end

	local heroData = self:getCurHeroData()

	ViewMgr.instance:open(ViewName.CharacterSkinView, {
		openByMainSystem = true,
		heroId = heroData:getId(),
		skinId = heroData:getSkinId(),
		showType = HeroSkinEnum.ShowType.ModelPreview
	})
end

function M:_onClickPreinstall()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.HeroPreset, true) then
		return
	end

	ViewMgr.instance:open(ViewName.CharacterPreinstallView, self:getCurHeroData():getId(), 2)
end

function M:_onClickContract()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleBreak, true) then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.CharacterPreview) then
		return
	end

	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_gongming, nil, nil, nil)
	ViewMgr.instance:open(ViewName.CharacterHeartAnchorBreakView)
end

function M:_onClickIncrExp()
	self._clickAnimation:Play("com_tips_decorate_click")
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_dengjishengji, nil, nil, nil)

	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleUpgrade, true) then
		return
	end

	settimer(0.3, function()
		ViewMgr.instance:open(ViewName.CharacterUpgrade)
	end, self, false)
end

function M:_onClickTacit()
	if ViewMgr.instance:isOpen(ViewName.CharacterPreview) then
		return
	end

	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Tacit, true) then
		return
	end

	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_yinxiang, nil, nil, nil)
	ViewMgr.instance:open(ViewName.CharacterHeartAnchorView)
end

function M:_onClickBtnTalent()
	if self._talentSkillId then
		local heroData = self:getCurHeroData()
		local characterCO = heroData:getCharacterCo()
		local awakeStatus = TacitModel.instance:isAwakeTalentSkill(characterCO.id, true)
		local heroId = heroData:getId()
		local go = goutil.findChild(self._btnTalent.gameObject, "tipsPos")
		local skillInfo = ToolTipsMgr.getSkillTipsInfo()

		skillInfo.heroId = heroId
		skillInfo.skillId = self._talentSkillId
		skillInfo.defaultShowAll = true
		skillInfo.hangGO = go
		skillInfo.awakeStatus = awakeStatus

		ToolTipsMgr.showCharacterSysSkillTips(skillInfo)
	end
end

function M:_onClickProperty()
	goutil.setActive(self._btnClickMask.gameObject, true)
	goutil.setActive(self._goPropertyPanel, true)
end

function M:_onClickMask()
	goutil.setActive(self._btnClickMask.gameObject, false)
	goutil.setActive(self._goPropertyPanel, false)
end

function M:_onClickToAirtightTime()
	AirtightRoomController.instance:setPreviewState(true)
	self:_refreshAirtightBtnStatus(0.3)
end

function M:_onClickToNormalTime()
	AirtightRoomController.instance:setPreviewState(nil)
	self:_refreshAirtightBtnStatus(0.3)
end

function M:_refreshAirtightBtnStatus(duration)
	duration = duration or 0

	local previewState = AirtightRoomModel.instance:getPreviewState()
	local inTime = AirtightRoomController.instance:getIsInAirtightTime(nil, nil, nil, false)

	goutil.setActive(self._btnToAirtightTime.gameObject, not inTime)
	goutil.setActive(self._btnToNormalTime.gameObject, inTime and previewState == true)
	MainScenePerformUtil.showCanvas(self._canvasInAirtightPreview, inTime and previewState == true, duration)
end

function M:_isVaildToImpressionTask()
	local heroData = self:getCurHeroData()
	local isVaild = true
	local cfg = TacitConfig.instance:getTacitCO(heroData:getId())

	if not cfg then
		isVaild = false
	elseif cfg.isOnLine <= 0 then
		isVaild = false
	end

	return isVaild
end

function M:_refreshRedDot()
	local heroId = self:getCurHeroData():getId()
	local impressionSysOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Tacit, false)
	local hasImpressionTask = false

	if self:_isVaildToImpressionTask() then
		for i = 1, 3 do
			if hasImpressionTask == false and TacitModel.instance:checkHasRedDot(i) then
				hasImpressionTask = true
			end
		end
	end

	hasImpressionTask = hasImpressionTask or CharacterUtil.isHeroHasTacitTaskCanReceive(heroId, true)

	local isHasNewCarry = CharacterInformationModel.instance:getIsNewCarryItem(heroId)
	local isCarryItem1New = CharacterInformationController.instance:isCarryItem1New(heroId)
	local canSublimed = CharacterUtil.isHeroCanSublimed(heroId)

	goutil.setActive(self._goRedDotTacit, impressionSysOpen and (hasImpressionTask or isHasNewCarry or isCarryItem1New or canSublimed))

	local checkSysOpen = true
	local canBrealLvUp = CharacterUtil.isHeroCanBrealLvUp(heroId, checkSysOpen)

	goutil.setActive(self._goRedDotAnchorBreak, canBrealLvUp)
end

function M:showCharacterInfo()
	local heroData = self:getCurHeroData()

	if not heroData and enableErrorLog then
		printError("cannot show charater info with null data")

		return
	end

	local characterCO = heroData:getCharacterCo()

	if characterCO then
		self:_handleTalentSkill()
	end

	self:_refreshExp()
	self:_refreshAnchorPanel()
	self:_refreshTacit()
	self:_handleAttrChange(nil, false)
	self:_refreshRedDot()
	self:_refreshModelOptimizingTips(heroData:getId())
end

function M:_refreshExp()
	local heroData = self:getCurHeroData()
	local curLevel = heroData:getLevel()
	local maxLevel = CharacterExpConfig.instance:getPowerLvAndQualityToLvLimit(heroData:getPowerLv(), heroData:getQuality())

	self._txtLvCur.text = curLevel
	self._txtLvMax.text = string.format("/%s", maxLevel)

	local upgradeExp = CharacterExpConfig.instance:getUpgradeExpByLevelAndQuality(curLevel or 1, heroData:getQuality() or 1)

	if curLevel == maxLevel then
		self._imgExpSlider.fillAmount = 1
		self._txtExp.text = "Max"
	else
		self._imgExpSlider.fillAmount = heroData:getLevelExp() / upgradeExp
		self._txtExp.text = string.format("%d/%s", heroData:getLevelExp(), upgradeExp)
	end
end

function M:_refreshAnchorPanel()
	local heroData = self:getCurHeroData()
	local curLevel = heroData:getBreakLv()

	for i, v in ipairs(self._anchorList) do
		goutil.setActive(v, i <= curLevel)
	end
end

function M:_refreshTacit()
	local showTacit = false
	local heroData = self:getCurHeroData()

	if heroData then
		local tacitCO = TacitConfig.instance:getTacitCO(heroData:getId())

		if tacitCO then
			showTacit = tacitCO.isOnLine == 1
		end
	end

	local isOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Tacit)
	local color = self._imgTacit.color

	color.a = isOpen and 1 or 0.2
	self._imgTacit.color = color

	goutil.setActive(self._goTacitLock, not isOpen)

	local maxLevel = TacitConfig.instance:getTacitMaxLevel()
	local isMaxLevel = maxLevel <= heroData:getTacit()

	self._txtTacit.text = heroData:getTacit()
end

function M:_handleAttrChange(_, state)
	local heroData = self:getCurHeroData()
	local characterCO = heroData:getCharacterCo()
	local attributeGrade = characterCO and characterCO.attributeGrade or {}

	for typ, cell in pairs(self._attributeCell) do
		local totalVal = heroData:getAttribute(M.AttDataDefine[typ].att)
		local addVal = M.AttDataDefine[typ].attPart and heroData:getAttrPartsBase(M.AttDataDefine[typ].attPart) or 0

		cell.txtLv.text = attributeGrade[M.AttDataTyp2AttrGradeIndexInCfg[typ]]

		goutil.setActive(cell.imgS, cell.txtLv.text == "S")
		goutil.setActive(cell.txtLv.gameObject, cell.txtLv.text ~= "S")
		self:_handleSingleAttr(cell.txtVal1, cell.txtVal2, state, totalVal, addVal)

		local comps = self._compsProperty[typ]

		comps.txtLv.text = attributeGrade[M.AttDataTyp2AttrGradeIndexInCfg[typ]]

		self:_handleSingleAttr(comps.txtVal1, comps.txtVal2, true, totalVal, addVal)
	end

	local baseMove = heroData:getMove()
	local totalMove = heroData:getAttribute(M.AttTyp.MOVE)
	local offsetMove = totalMove - baseMove

	self._txtMove.text = langF("tip_grid", totalMove)
	self._txtPropertyMove.text = langF("tip_grid", baseMove)

	local strAddMove

	if offsetMove > 0 then
		strAddMove = langF("tip_grid", offsetMove)
		strAddMove = string.format("+%s", strAddMove)
	elseif offsetMove < 0 then
		strAddMove = langF("tip_grid", offsetMove)
	end

	self._txtPropertyMove2.text = strAddMove

	local baseAtkRange = heroData:getNormalSkillAtkRange(false)
	local totalAtkRange = heroData:getNormalSkillAtkRange(true)
	local offsetAtkRange = totalAtkRange - baseAtkRange

	self._txtAttackRange.text = langF("tip_grid", totalAtkRange)
	self._txtPropertyShoot.text = langF("tip_grid", baseAtkRange)

	local strAddAtkRange

	if offsetAtkRange > 0 then
		strAddAtkRange = langF("tip_grid", offsetAtkRange)
		strAddAtkRange = string.format("+%s", strAddAtkRange)
	elseif offsetAtkRange < 0 then
		strAddAtkRange = langF("tip_grid", offsetAtkRange)
	end

	self._txtPropertyShoot2.text = strAddAtkRange
end

function M:_handleSingleAttr(textComp1, textComp2, state, total, add)
	add = math.floor(add)

	local text = total

	if state and add > 0 then
		textComp1.text = "" .. total - add
		textComp2.text = "+" .. add
	else
		textComp1.text = "" .. total
		textComp2.text = ""
	end
end

function M:_handleTalentSkill()
	local heroData = self:getCurHeroData()
	local characterCO = heroData:getCharacterCo()
	local awakeStatus = TacitModel.instance:isAwakeTalentSkill(characterCO.id, true)
	local talentSkills = characterCO.battleTalent

	if ViewMgr.instance:isOpen(ViewName.CharacterPreview) then
		local shared = SkillEnhanceMO.getSharedMO(talentSkills[1])
		local allEnhanceCodes = ActiveSkillConfig.instance:getEnhanceCodesOfSkill(talentSkills[1])

		if allEnhanceCodes then
			for _, enchanceId in pairs(allEnhanceCodes) do
				shared:addSkillEnhanceCode(enchanceId)
			end

			shared:rebuild()
		end

		local addShared = false

		if #talentSkills == 3 then
			addShared = SkillEnhanceMO.getSharedMO(characterCO.battleTalent[3])

			addShared:rebuild()
		end

		local skillCO = shared:getSkillCO()
		local skillId = skillCO.code
		local skillName = skillCO.name
		local backUpDesc = skillCO.normalConfig.backupDesc

		if addShared then
			local addSkillCO = addShared:getSkillCO()

			skillName = addSkillCO.name
			skillId = addSkillCO.code
			backUpDesc = addSkillCO.normalConfig.backupDesc
		end

		self._txtTacitName.text = StringUtil.randomReplaceBlackBlock(skillName)
		self._txtTacitInfo.text = TextUtils.GetPunctuationFixedText(backUpDesc, self._txtTacitInfo)

		SkillEnhanceMO.releaseSharedMO(shared)
		SkillEnhanceMO.releaseSharedMO(addShared)
	else
		local additionalSkillId = talentSkills[awakeStatus]
		local skillName = ""
		local skillEnhanceMO = SkillEnhanceModel.instance:getCharacterSkillEnhanceMO(characterCO.id, talentSkills[1])

		if skillEnhanceMO then
			local addSkillEnhanceMO = false

			if additionalSkillId then
				addSkillEnhanceMO = SkillEnhanceMO.getSharedMO(additionalSkillId)

				addSkillEnhanceMO:rebuild()
			end

			local skillCO = skillEnhanceMO:getSkillCO()
			local skillId = skillCO.code

			skillName = skillCO.name

			if addSkillEnhanceMO then
				local addSkillCO = addSkillEnhanceMO:getSkillCO()

				skillName = addSkillCO.name
				skillId = addSkillCO.code
			end

			SkillEnhanceMO.releaseSharedMO(addSkillEnhanceMO)
		end

		self._txtTacitName.text = StringUtil.randomReplaceBlackBlock(skillName)

		self:showTalentSkillInfo(characterCO, awakeStatus)
	end

	local wakeUp = heroData:getAwakeTalent()
	local skillId = talentSkills[1]

	self._talentSkillId = skillId

	if #talentSkills >= 3 then
		skillId = wakeUp and talentSkills[3] or talentSkills[2]
	end

	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId or 0)
	local iconPath = ActiveSkillCOUtil.getSkillIcon(skillCOWrapper:getSkillCO())

	if not string.nilorempty(iconPath) then
		IconLoader.setSprite(self._imgTalentSkill, IconType.SkillIcon, iconPath, function()
			self._imgTalentSkill:SetNativeSize()
		end, self)
	end

	local isAwake = awakeStatus == CommEnum.TalentSkillAwakeStatus.Unlock

	goutil.setActive(self._goReshape, isAwake)
	goutil.setActive(self._goReshapeImg1, isAwake)
	goutil.setActive(self._goReshapeImg2, isAwake)
	goutil.setActive(self._goNotReshape, not isAwake)
end

function M:showTalentSkillInfo(characterCO, awakeStatus)
	local talentSkills = characterCO.battleTalent
	local shared = SkillEnhanceModel.instance:getCharacterSkillEnhanceMO(characterCO.id, talentSkills[1])

	if shared then
		shared:rebuild()
	end

	local addShared = false

	if #talentSkills == 3 then
		local addSkill = talentSkills[awakeStatus]

		addShared = SkillEnhanceMO.getSharedMO(addSkill)

		addShared:rebuild()
	end

	local backUpDesc = shared and shared:getSkillCO().normalConfig.backupDesc or ""

	if addShared then
		backUpDesc = addShared:getSkillCO().normalConfig.backupDesc
	end

	self._txtTacitInfo.text = TextUtils.GetPunctuationFixedText(backUpDesc, self._txtTacitInfo)

	SkillEnhanceMO.releaseSharedMO(shared)
	SkillEnhanceMO.releaseSharedMO(addShared)
end

function M:_regLockStats(key, root, objNormal, objLock)
	if not self._lockStatsGroup then
		self._lockStatsGroup = {}
	end

	local data = {}

	data.root = root.gameObject
	data.normal = objNormal and objNormal.gameObject or nil
	data.lock = objLock and objLock.gameObject or nil
	self._lockStatsGroup[key] = self._lockStatsGroup[key] or {}

	table.insert(self._lockStatsGroup[key], data)
end

function M:_handleOnSystemOpen()
	for key, group in pairs(self._lockStatsGroup or {}) do
		for _, data in ipairs(group) do
			local showOnLock = SystemOpenFacade.instance:isShowOnLock(key)
			local isOpen = SystemOpenFacade.instance:isOpen(key)

			goutil.setActive(data.root, isOpen or showOnLock and not isOpen)

			if data.lock then
				goutil.setActive(data.lock, not isOpen)
			end

			if data.normal then
				goutil.setActive(data.normal, isOpen)
			end
		end
	end

	self:_refreshRedDot()
end

function M:_refreshModelOptimizingTips(heroId)
	local isOptimizing = CharacterUtil.isHeroModelOptimizing(heroId)

	goutil.setActive(self._goTipsModelOptimizing, isOptimizing)
end

function M:_onClickExplain()
	ViewMgr.instance:open(ViewName.ImageGuide, {
		CommEnum.GuideID.CharacterMain
	})
end

return M
