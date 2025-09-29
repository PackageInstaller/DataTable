-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/view/new/CharacterHeartAnchorViewCompSublimed.lua

module("logic.extensions.characterinformation.view.new.CharacterHeartAnchorViewCompSublimed", package.seeall)

local M = class("CharacterHeartAnchorViewCompSublimed")

M.AnchorType = {
	Sublimed = 2,
	Normal = 1
}
M.DescType = {
	Before = 1,
	After = 2
}

function M:ctor(mainGo)
	self.mainGO = mainGo.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:getMainGo()
	return self.mainGO
end

function M:getRegistry()
	return self._registry
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local mainGO = self:getMainGo()
	local registry = self:getRegistry()

	self._cachePos = Vector3.New(0, 0, 0)

	goutil.setActive(registry:findUIElement("heart_anchor_course_view_1635758112"), false)

	self._txtTitleBefore = registry:findUIElement("heart_anchor_course_view_200126150", UIComponentType.TextMeshProUGUI)
	self._txtContentBefore = registry:findUIElement("heart_anchor_course_view_-1470557795", UIComponentType.TextMeshProUGUI)

	goutil.setActive(registry:findUIElement("heart_anchor_course_view_-1230558858"), false)

	self._txtTitleAfter = registry:findUIElement("heart_anchor_course_view_-239295489", UIComponentType.TextMeshProUGUI)
	self._txtContentAfter = registry:findUIElement("heart_anchor_course_view_2116920237", UIComponentType.TextMeshProUGUI)
	self._btnSumblimedAniDone = UIComponentType.ButtonAdapter(registry:findUIElement("heart_anchor_course_view_198170094"))
	self._canvasGroupBgSumblimed = registry:findUIElement("heart_anchor_course_view_340821016", ComponentType.CanvasGroup)
	self._canvasGroupBgNormal = registry:findUIElement("heart_anchor_course_view_-254867788", ComponentType.CanvasGroup)

	goutil.setActive(self._canvasGroupBgSumblimed.gameObject, false)
	goutil.setActive(self._canvasGroupBgNormal.gameObject, true)

	self._bgGoLst = {
		[M.AnchorType.Normal] = {
			registry:findUIElement("heart_anchor_course_view_-1389994159"),
			registry:findUIElement("heart_anchor_course_view_510995459")
		},
		[M.AnchorType.Sublimed] = {
			registry:findUIElement("heart_anchor_course_view_-224711220"),
			registry:findUIElement("heart_anchor_course_view_-489195634")
		}
	}

	local goBtnToSublimed = goutil.findChild(mainGO, "btnSublimed").gameObject

	self._btnToSublimed = UIComponentType.ButtonAdapter(goBtnToSublimed)
	self._goRedPointBtnSublimed = goutil.findChild(goBtnToSublimed, "new").gameObject
	self._canvasGroupBtnSublimed = goutil.addComponentOnce(goBtnToSublimed, ComponentType.CanvasGroup)

	goutil.setActive(goBtnToSublimed, true)

	self._goSublimedMark = registry:findUIElement("heart_anchor_course_view_-381787230")

	goutil.setActive(self._goSublimedMark, false)

	self._btnClickAnchorNormal = UIComponentType.ButtonAdapter(registry:findUIElement("heart_anchor_course_view_1587553603"))
	self._canvasGroupContentNormal = registry:findUIElement("heart_anchor_course_view_-1892526143", ComponentType.CanvasGroup)

	local goImpressionTips = registry:findUIElement("heart_anchor_course_view_-1199070992")

	self._canvasGroupImpressionTips = goutil.addComponentOnce(goImpressionTips, ComponentType.CanvasGroup)

	goutil.setActive(goImpressionTips, true)

	self._btnFullClick = UIComponentType.ButtonAdapter(registry:findUIElement("heart_anchor_course_view_1996512346"))
	self._scrollImpressionTips = goutil.findChildComponent(goImpressionTips, "detailScroll", UIComponentType.ScrollRect)
	self._goCannotUpgrade = registry:findUIElement("heart_anchor_course_view_1436721765")
	self._txtCannotUpgrade = goutil.findChildComponent(self._goCannotUpgrade, "btn/notClick/Text1", UIComponentType.Text)
	self._btnUpgrade = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(goImpressionTips, "btnUpgrade"), CommButton)
	self._goRedPointBtnUpgrade = goutil.findChild(goImpressionTips, "btnUpgrade/new").gameObject
	self._canvasGroupBtnUpgrade = goutil.addComponentOnce(goutil.findChild(goImpressionTips, "btnUpgrade"), ComponentType.CanvasGroup)
	self._cellItemForBreak = self:_buildCostItemCell(goutil.findChild(goImpressionTips, "backpack_item").gameObject)
	self._txtTipsTitleBefore = registry:findUIElement("heart_anchor_course_view_1272615162", UIComponentType.Text)
	self._txtTipsDescBefore = registry:findUIElement("heart_anchor_course_view_1817781361", UIComponentType.TextMeshProUGUI)
	self._btnTipsDescBefore = UIComponentType.ButtonAdapter(registry:findUIElement("heart_anchor_course_view_-624953689"))
	self._txtTipsTitleAfter = registry:findUIElement("heart_anchor_course_view_306981105", UIComponentType.Text)
	self._txtTipsDescAfter = registry:findUIElement("heart_anchor_course_view_1146087902", UIComponentType.TextMeshProUGUI)
	self._btnTipsDescAfter = UIComponentType.ButtonAdapter(registry:findUIElement("heart_anchor_course_view_-1036778647"))
	self._heartAnchor = {
		[M.AnchorType.Normal] = {
			rectTr = registry:findUIElement("heart_anchor_course_view_-1642935123", UIComponentType.RectTransform),
			icon = registry:findUIElement("heart_anchor_course_view_936979527", UIComponentType.Image)
		},
		[M.AnchorType.Sublimed] = {
			rectTr = registry:findUIElement("heart_anchor_course_view_1832232280", UIComponentType.RectTransform),
			icon = registry:findUIElement("heart_anchor_course_view_-351815129", UIComponentType.Image)
		}
	}

	local txtShapedBefore = goutil.findChildComponent(registry:findUIElement("heart_anchor_course_view_-1642935123"), "not_reshaped/Text1", UIComponentType.Text)

	txtShapedBefore.text = lang("tip_tacit_state_before")

	local txtShapedAfter = goutil.findChildComponent(registry:findUIElement("heart_anchor_course_view_1832232280"), "reshaped/Text1", UIComponentType.Text)

	txtShapedAfter.text = lang("tip_tacit_state_after")
end

function M:destroyUI()
	self:setEvent(false)
	self:setHandler(nil)
	self:_releaseTween()
	self._cellItemForBreak.btnClick:RemoveClickListener()

	self._cellItemForBreak = nil
	self.mainGO = nil

	if self._registry then
		self._registry:cleanRegistry()
	end

	self._registry = nil
	self._cachePos = nil
	self._heartAnchor = nil
end

function M:bindEvents()
	self._btnClickAnchorNormal:AddClickListener(self._onClickAnchorNormal, self)
	self._btnFullClick:AddClickListener(self._onClickFull, self)
	self._btnUpgrade:AddClickListener(self._onClickUpgrade, self)
	self._btnTipsDescBefore:AddClickListener(self._onClickTipsDescBefore, self)
	self._btnTipsDescAfter:AddClickListener(self._onClickTipsDescAfter, self)
	self._btnSumblimedAniDone:AddClickListener(self._onClickSumblimedAniDone, self)
	self._btnToSublimed:AddClickListener(self._onClickToSublimed, self)
end

function M:unbindEvents()
	self._btnClickAnchorNormal:RemoveClickListener()
	self._btnFullClick:RemoveClickListener()
	self._btnUpgrade:RemoveClickListener()
	self._btnTipsDescBefore:RemoveClickListener()
	self._btnTipsDescAfter:RemoveClickListener()
	self._btnSumblimedAniDone:RemoveClickListener()
	self._btnToSublimed:RemoveClickListener()
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:onEnter()
	self:setEvent(true)
	self:prepareDesc()
	self:refreshDesc(M.DescType.Before)
	self:refreshAnchor()
	self:_setAnchorSkillIcon()
	self:_refreshRedDot()
	self:showCanvas(self._canvasGroupContentNormal, true, 0)
	self:showCanvas(self._canvasGroupImpressionTips, false, 0)
	self:showCanvas(self._canvasGroupBtnUpgrade, false, 0)

	if CharacterInformationModel.instance:getInAnchorSublimedView() then
		settimer(0, function()
			CharacterInformationModel.instance:setInAnchorSublimedView(true)
		end, self, false)
	end
end

function M:onExit(isNormal, changePage)
	self:setEvent(false)
	self:_releaseTween()

	if isNormal and changePage then
		self:_hideBg()
	end
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.GAIN_ITEM_ADD_EVENT, self._handleGainItemAdd, self)
		GlobalDispatcher:addEventListener(EventType.TACIT_ANCHOR_SUBLIMED_VIEW_ENTER, self._handleTacitAnchorSublimedViewEnter, self)
		GlobalDispatcher:addEventListener(EventType.TACIT_ANCHOR_WAKE_UP_SUC, self._handleTacitAnchorWakeUpSuc, self)
		GlobalDispatcher:addEventListener(EventType.REFRESH_HERO_DEPOT_DATA, self._handleRefreshHeroDepotData, self)
	else
		GlobalDispatcher:removeEventListener(EventType.GAIN_ITEM_ADD_EVENT, self._handleGainItemAdd, self)
		GlobalDispatcher:removeEventListener(EventType.TACIT_ANCHOR_SUBLIMED_VIEW_ENTER, self._handleTacitAnchorSublimedViewEnter, self)
		GlobalDispatcher:removeEventListener(EventType.TACIT_ANCHOR_WAKE_UP_SUC, self._handleTacitAnchorWakeUpSuc, self)
		GlobalDispatcher:removeEventListener(EventType.REFRESH_HERO_DEPOT_DATA, self._handleRefreshHeroDepotData, self)
	end
end

function M:_handleGainItemAdd(e, params)
	self._cellItemForBreak.updateCount()
	self:_refreshRedDot()
end

function M:_handleTacitAnchorSublimedViewEnter(e, enter, isExistBySublimedFinish)
	self:showCanvas(self._canvasGroupImpressionTips, enter, 0.15)
	self:showCanvas(self._canvasGroupBtnUpgrade, enter, 0.15)
	self:showCanvas(self._canvasGroupBgSumblimed, enter, 0.1)
	self:showCanvas(self._canvasGroupBgNormal, not enter, 0.1)

	if enter then
		self:refreshImpressionTips()
	end

	self:_refreshRedDot()
end

function M:_handleTacitAnchorWakeUpSuc(e, success)
	if enableLog then
		printWarn("心锚升华(觉醒):", success)
	end

	if success then
		self:_wakeUpProcessBegin()
	end

	self:_refreshRedDot()
end

function M:_handleRefreshHeroDepotData()
	self:_refreshRedDot()
end

function M:_releaseTween()
	for _type, comps in pairs(self._heartAnchor or {}) do
		comps.rectTr:DOKill(false)
	end

	self._canvasGroupContentNormal:DOKill(false)

	for _, val in pairs(self._descCache or {}) do
		if val.skillEnhanceMO then
			SkillEnhanceMO.releaseSharedMO(val.skillEnhanceMO)
		end

		if val.addSkillEnhanceMO then
			SkillEnhanceMO.releaseSharedMO(val.addSkillEnhanceMO)
		end
	end
end

function M:getCurHeroData()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false

	if not heroData then
		return nil
	end

	local data = HeroDepotModel.instance:getHeroInfoByID(heroData:getId())

	return data
end

function M:_onClickAnchorNormal()
	self:_tryToSublimedView()
end

function M:_onClickToSublimed()
	self:_tryToSublimedView()
end

function M:_tryToSublimedView()
	local heroData = self:getCurHeroData()

	if not heroData then
		return
	end

	if heroData:getAwakeTalent() then
		return
	end

	local cfg = TacitConfig.instance:getTacitCO(heroData:getId())

	if not cfg then
		return
	end

	if cfg.isOnLine <= 0 then
		return
	end

	if CharacterInformationModel.instance:getInAnchorSublimedView() then
		return
	end

	CharacterInformationModel.instance:setInAnchorSublimedView(true)
end

function M:_onClickFull()
	CharacterInformationModel.instance:setInAnchorSublimedView(false)
end

function M:_onClickUpgrade()
	local heroData = self:getCurHeroData()

	if not heroData then
		return
	end

	if heroData:getAwakeTalent() then
		return
	end

	if not CharacterInformationModel.instance:getInAnchorSublimedView() then
		return
	end

	local heroId = heroData:getId()
	local carryItemUnlock = true

	for i = CharacterInfoEnum.UnlockTyp.CarryItem1, CharacterInfoEnum.UnlockTyp.CarryItem4 do
		if not CharacterInformationModel.instance:getUnlockPastInfo(heroId, i) then
			carryItemUnlock = false
		end
	end

	if not carryItemUnlock then
		ToolTipsMgr.showCharacterTopToast(lang("tip_tacit_toast_lack_of_carry_item"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	if not self._cellItemForBreak.getItemEnough() then
		ToolTipsMgr.showCharacterTopToast(lang("tip_lack_of_material"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	TacitAgent.instance:sendWakeupRequest(heroData:getId())
end

function M:_onClickTipsDescBefore()
	self:_showSkillBuffTagTips(self._descCache[M.DescType.Before], self._btnTipsDescBefore.gameObject)
end

function M:_onClickTipsDescAfter()
	self:_showSkillBuffTagTips(self._descCache[M.DescType.After], self._btnTipsDescAfter.gameObject)
end

function M:_showSkillBuffTagTips(descData, bindGo)
	if not descData then
		return
	end

	local skillEnhanceMO

	if descData.addSkillEnhanceMO then
		skillEnhanceMO = descData.addSkillEnhanceMO
	elseif descData.skillEnhanceMO then
		skillEnhanceMO = descData.skillEnhanceMO
	end

	if skillEnhanceMO then
		local isPassEvent = true

		ToolTipsMgr.showSkillBuffTagSideTips(skillEnhanceMO, bindGo, isPassEvent)
	end
end

function M:showCanvas(canvas, show, duration)
	if not canvas then
		return
	end

	duration = duration or 0

	if show then
		goutil.setActive(canvas.gameObject, true)
	end

	local finalAlpha = show and 1 or 0

	canvas:DOKill(false)

	if duration > 0 then
		canvas:DOFade(finalAlpha, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
	else
		canvas.alpha = finalAlpha
	end

	self:setCanvasInteractable(canvas, show)
end

function M:setCanvasInteractable(canvas, active)
	canvas.interactable = active
	canvas.blocksRaycasts = active
end

function M:_wakeUpProcessBegin()
	GlobalDispatcher:dispatchEvent(EventType.TACIT_ANCHOR_WAKE_UP_PROCESSING, true)
	self:setCanvasInteractable(self._canvasGroupContentNormal, false)
	self:setCanvasInteractable(self._canvasGroupImpressionTips, false)
	self:setCanvasInteractable(self._canvasGroupBtnUpgrade, false)

	local descData = self._descCache[M.DescType.Before]

	self._txtTitleBefore.text = descData.skillName
	self._txtContentBefore.text = string.format("%s\n%s", descData.skillDescBackUp, descData.skillDesc)
	descData = self._descCache[M.DescType.After]
	self._txtTitleAfter.text = descData.skillName
	self._txtContentAfter.text = string.format("%s\n%s", descData.skillDescBackUp, descData.skillDesc)
end

function M:onWakeUpAnimDone()
	goutil.setActive(self._btnSumblimedAniDone.gameObject, true)
end

function M:_onClickSumblimedAniDone()
	goutil.setActive(self._btnSumblimedAniDone.gameObject, false)
	self:_wakeUpProcessFinish()
end

function M:_wakeUpProcessFinish()
	self:refreshAnchor()
	self:refreshDesc(M.DescType.After)
	self:setCanvasInteractable(self._canvasGroupContentNormal, true)
	GlobalDispatcher:dispatchEvent(EventType.TACIT_ANCHOR_WAKE_UP_PROCESSING, false)

	local isExistBySublimedFinish = true

	CharacterInformationModel.instance:setInAnchorSublimedView(false, isExistBySublimedFinish)
end

function M:refreshAnchor()
	local heroData = self:getCurHeroData()
	local wakeUp = heroData:getAwakeTalent()
	local anchorType = wakeUp and M.AnchorType.Sublimed or M.AnchorType.Normal

	for _type, comps in pairs(self._heartAnchor) do
		goutil.setActive(comps.rectTr.gameObject, _type == anchorType)
	end

	goutil.setActive(self._btnToSublimed.gameObject, anchorType == M.AnchorType.Normal)
	goutil.setActive(self._goSublimedMark, anchorType == M.AnchorType.Sublimed)
	self:_updateBg()
end

function M:_updateBg()
	local heroData = self:getCurHeroData()
	local wakeUp = heroData:getAwakeTalent()
	local anchorType = wakeUp and M.AnchorType.Sublimed or M.AnchorType.Normal

	for _type, goLst in pairs(self._bgGoLst or {}) do
		local show = _type == anchorType

		for _, go in ipairs(goLst) do
			goutil.setActive(go, show)
		end
	end
end

function M:_hideBg()
	for _type, goLst in pairs(self._bgGoLst or {}) do
		for _, go in ipairs(goLst) do
			goutil.setActive(go, false)
		end
	end
end

function M:_setAnchorSkillIcon()
	local heroData = self:getCurHeroData()
	local characterCO = heroData:getCharacterCo()
	local talentSkills = characterCO.battleTalent
	local idBefore = talentSkills[1]
	local idAfter = talentSkills[1]

	if #talentSkills >= 3 then
		idBefore = talentSkills[2]
		idAfter = talentSkills[3]
	end

	local skillCOWrapperBefore = ActiveSkillConfig.instance:getActiveSkillCOWrapper(idBefore or 0)
	local skillCOWrapperAfter = ActiveSkillConfig.instance:getActiveSkillCOWrapper(idAfter or 0)
	local iconBefore = ActiveSkillCOUtil.getSkillIcon(skillCOWrapperBefore:getSkillCO())
	local iconAfter = ActiveSkillCOUtil.getSkillIcon(skillCOWrapperAfter:getSkillCO())

	if not string.nilorempty(iconBefore) then
		local icon = self._heartAnchor[M.AnchorType.Normal].icon

		IconLoader.setSprite(icon, IconType.SkillIcon, iconBefore, function()
			icon:SetNativeSize()
		end, self)
	end

	if not string.nilorempty(iconAfter) then
		local icon = self._heartAnchor[M.AnchorType.Sublimed].icon

		IconLoader.setSprite(icon, IconType.SkillIcon, iconAfter, function()
			icon:SetNativeSize()
		end, self)
	end
end

function M:prepareDesc()
	local heroData = self:getCurHeroData()
	local heroId = heroData:getId()
	local characterCO = heroData:getCharacterCo()
	local talentSkills = characterCO.battleTalent
	local awakeStatusBefore = TacitModel.instance:isAwakeTalentSkill(heroId)
	local awakeStatusAfter = talentSkills[CommEnum.TalentSkillAwakeStatus.Unlock] and CommEnum.TalentSkillAwakeStatus.Unlock or awakeStatusBefore

	self._descCache = {}

	local skillName, skillDesc, skillDescAddEnhane, skillDescBackUp, skillIcon, skillEnhanceMO, addSkillEnhanceMO = self:getTalentSkillData(heroId, awakeStatusBefore)
	local skillName2, skillDesc2, skillDescAddEnhane2, skillDescBackUp2, skillIcon2, skillEnhanceMO2, addSkillEnhanceMO2 = self:getTalentSkillData(heroId, awakeStatusAfter)

	self._descCache[M.DescType.Before] = {
		skillName = skillName,
		skillDesc = skillDesc,
		skillDescAddEnhane = skillDescAddEnhane,
		skillDescBackUp = skillDescBackUp,
		skillIcon = skillIcon,
		skillEnhanceMO = skillEnhanceMO,
		addSkillEnhanceMO = addSkillEnhanceMO
	}
	self._descCache[M.DescType.After] = {
		skillName = skillName2,
		skillDesc = skillDesc2,
		skillDescAddEnhane = skillDescAddEnhane2,
		skillDescBackUp = skillDescBackUp2,
		skillIcon = skillIcon2,
		skillEnhanceMO = skillEnhanceMO2,
		addSkillEnhanceMO = addSkillEnhanceMO2
	}
end

function M:refreshDesc(descType)
	local descData = self._descCache[descType]
	local str = string.format("<color=#ffffff>%s:</color>  %s", descData.skillName, descData.skillDesc)
end

function M:refreshImpressionTips()
	local heroData = self:getCurHeroData()
	local heroId = heroData:getId()
	local itemId, itemCount = TacitConfig.instance:getTalentSkillWakeUpCostItem(heroId)

	self._cellItemForBreak.updateData(itemId, itemCount)

	local descData = self._descCache[M.DescType.Before]
	local str = descData.skillDescAddEnhane

	self._txtTipsTitleBefore.text = descData.skillName
	self._txtTipsDescBefore.text = str
	descData = self._descCache[M.DescType.After]
	str = descData.skillDescAddEnhane
	self._txtTipsTitleAfter.text = descData.skillName
	self._txtTipsDescAfter.text = str

	local carryItemUnlock = true

	for i = CharacterInfoEnum.UnlockTyp.CarryItem1, CharacterInfoEnum.UnlockTyp.CarryItem4 do
		if not CharacterInformationModel.instance:getUnlockPastInfo(heroId, i) then
			carryItemUnlock = false
		end
	end

	local canUpgrade = carryItemUnlock

	goutil.setActive(self._goCannotUpgrade, not canUpgrade)
	self._btnUpgrade:setActive(canUpgrade)

	if not canUpgrade then
		self._txtCannotUpgrade.text = lang("tip_tacit_toast_lack_of_carry_item")
	end

	settimer(0, function()
		local needScroll = RectTransformUtils.GetHeight(self._scrollImpressionTips.content) > RectTransformUtils.GetHeight(self._scrollImpressionTips.transform)

		self._scrollImpressionTips.enabled = needScroll
	end, self, false)
end

function M:getTalentSkillData(heroId, awakeStatus)
	local skillName = ""
	local skillDescAddEnhane = ""
	local skillDesc = ""
	local skillDescBackUp = ""
	local skillIcon = ""
	local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)
	local skillEnhanceMO
	local addSkillEnhanceMO = false

	if heroData then
		local curLevel = heroData:getBreakLv()
		local characterCO = heroData:getCharacterCo()
		local talentSkills = characterCO.battleTalent
		local additionalSkillId = talentSkills[awakeStatus]
		local skillId = characterCO.battleTalent[1]

		skillEnhanceMO = SkillEnhanceMO.New(skillId)

		if skillEnhanceMO then
			local cfgBreakAttrCO = HeroBreakConfig.instance:getAttrCO(heroId, 1)

			if cfgBreakAttrCO then
				for _breakLv, _cfg in pairs(HeroBreakConfig.instance:getBreakSkillEnhanceIds(heroId)) do
					if _breakLv <= curLevel and _cfg.skillId == skillId then
						skillEnhanceMO:addSkillEnhanceCode(_cfg.skillEnhanceId)
					end
				end
			else
				if enableLog then
					printWarn(string.format("角色[%s]没有在t_%s进行配置，读技能表模拟", heroId, ConfigName.HeroBreakAttr))
				end

				local allEnhanceCodes = ActiveSkillConfig.instance:getEnhanceCodesOfSkill(skillId)
				local myEnhanceCodes = skillEnhanceMO:getAllSkillEnhanceCode()

				for index, enhanceCode in ipairs(allEnhanceCodes) do
					local isGained = table.indexof(myEnhanceCodes, enhanceCode)

					if isGained then
						skillEnhanceMO:addSkillEnhanceCode(enhanceCode)
					end
				end
			end

			skillEnhanceMO:rebuild()

			addSkillEnhanceMO = false

			if additionalSkillId then
				addSkillEnhanceMO = SkillEnhanceMO.New(additionalSkillId)

				addSkillEnhanceMO:rebuild()
			end

			if addSkillEnhanceMO then
				local addSkillCO = addSkillEnhanceMO:getSkillCO()

				skillName = addSkillCO.name
				skillDescAddEnhane = addSkillEnhanceMO:getDescription()
				skillDesc = addSkillEnhanceMO:getDescription()
				skillDescBackUp = addSkillCO.normalConfig.backupDesc
				skillIcon = ActiveSkillCOUtil.getSkillIcon(addSkillCO)
			else
				local skillCO = skillEnhanceMO:getSkillCO()

				skillName = skillCO.name
				skillDescAddEnhane = ""
				skillDesc = skillEnhanceMO:getDescription()
				skillDescBackUp = skillCO.normalConfig.backupDesc
				skillIcon = ActiveSkillCOUtil.getSkillIcon(skillCO)
			end
		end
	end

	return skillName, skillDesc, skillDescAddEnhane, skillDescBackUp, skillIcon, skillEnhanceMO, addSkillEnhanceMO
end

function M:_buildRectCacheData(rectTrans)
	local anchoredX, anchoredY = Astral.TransformUtil.GetAnchoredPos(rectTrans, 0, 0)
	local scaleX, scaleY = RectTransformUtils.GetScale(rectTrans, 1, 1)

	return {
		anchoredX,
		anchoredY,
		scaleX,
		scaleY
	}
end

function M:_buildCostItemCell(go)
	local cell = {}

	cell.go = go
	cell.imgQuality = goutil.findChildImageComponent(go, "imgQuality")
	cell.imgIcon = goutil.findChildImageComponent(go, "imgIcon")
	cell.txtCount = goutil.findChildTextComponent(go, "txtDown")
	cell.btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click").gameObject)

	function cell.getItemEnough()
		local enough = true

		if cell.itemId and cell.itemId > 0 then
			local curNum = ItemModel.instance:getItemCountByItemId(cell.itemId)

			enough = curNum >= cell.itemCount
		end

		return enough
	end

	function cell.updateCount()
		local countStr
		local hasItem = cell.itemId and cell.itemId > 0

		if hasItem then
			local curNum = ItemModel.instance:getItemCountByItemId(cell.itemId)

			countStr = curNum >= cell.itemCount and string.format("%s/%d", MathUtil.getCoinValue(curNum), cell.itemCount) or string.format("<color=#e05959>%s</color>/%d", MathUtil.getCoinValue(curNum), cell.itemCount)

			local itemCo = BackpackConfig.instance:getItemInfoByItemId(cell.itemId)

			if itemCo then
				IconLoader.setSprite(cell.imgIcon, IconType.ItemIcon, itemCo.icon)
				IconLoader.setSprite(cell.imgQuality, IconType.Skinlib, CommEnum.Quality2ItemBg[itemCo.quality])
			end
		end

		cell.txtCount.text = countStr

		cell.setVisible(hasItem)
	end

	function cell.updateData(itemId, itemCount)
		cell.itemId = itemId
		cell.itemCount = itemCount

		cell.updateCount()
	end

	function cell.setVisible(show)
		goutil.setActive(cell.go, show)
	end

	cell.btnClick:AddClickListener(function()
		self:_onCostItemClick(cell.go, cell.itemId)
	end, self)

	return cell
end

function M:_onCostItemClick(itemGo, itemId)
	local count = ItemModel.instance:getItemCountByItemId(itemId)
	local itemData = ItemData.New({
		count = count,
		itemId = itemId
	})
	local data = ToolTipsUtil.createItemTipsData(itemData, itemGo)

	data.isPassEvent = false

	ToolTipsMgr.showTips(data.viewName, data)
end

function M:_refreshRedDot()
	local heroData = self:getCurHeroData()
	local heroId = heroData:getId()
	local canSublimed = CharacterUtil.isHeroCanSublimed(heroId)

	goutil.setActive(self._goRedPointBtnSublimed, canSublimed)
	goutil.setActive(self._goRedPointBtnUpgrade, canSublimed)
end

return M
