-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/thinking/ThinkingInfoView.lua

module("logic.extensions.charactersystem.view.thinking.ThinkingInfoView", package.seeall)

local M = class("ThinkingInfoView", ViewComponent)
local kMaxSkillCount = 6

function M:buildUI()
	self._rectTrThinkingRoot = self:getUIComponent("thought_info_view_-1703496141", UIComponentType.RectTransform)
	self._originX = self._rectTrThinkingRoot.gameObject.transform.localPosition.x
	self._cellCenterThoughtItem = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self._rectTrThinkingRoot.gameObject, "thought_item").gameObject, ThinkingItemView)
	self._cellSkillLst = {}

	for i = 1, kMaxSkillCount do
		local go = goutil.findChild(self._rectTrThinkingRoot.gameObject, "thought_skill_item" .. i)

		table.insert(self._cellSkillLst, Astral.SimpleLuaComponentContainer.Add(go, ThinkingSkillItemView))
	end

	self._txtTag1 = goutil.findChildTextComponent(self._rectTrThinkingRoot.gameObject, "tab1/txtSign")
	self._txtTag2 = goutil.findChildTextComponent(self._rectTrThinkingRoot.gameObject, "tab2/txtSign")
	self._lockStateGo = goutil.findChild(self._rectTrThinkingRoot.gameObject, "stateLock")
	self._goTips = self:getGo("thought_info_view_-1435951469")
	self._txtTipsName = self:getText("thought_info_view_-1767996340")
	self._goTipsSkillRoot = self:getGo("thought_info_view_-1688939909")
	self._cellTipsSkill = Astral.SimpleLuaComponentContainer.Add(self:getGo("thought_info_view_723226362").transform:GetChild(0).gameObject, ThinkingSkillItemView)
	self._txtTipsSkillLevelPre = self:getText("thought_info_view_-273352026")
	self._txtTipsSkillLevelAfter = self:getText("thought_info_view_-1760137597")
	self._txtTipsSkillName = self:getText("thought_info_view_-937435167")
	self._txtTipsSkillDesc = self:getUIComponent("thought_info_view_1458956354", UIComponentType.TextMeshProUGUI)
	self._btnSkillDesc = self:getBtn("thought_info_view_112891440")
	self._goTipsCostRoot = self:getGo("thought_info_view_-162028902")
	self._rectCostContent = self:getUIComponent("thought_info_view_-162028902", UIComponentType.RectTransform)
	self._btnLeft = Astral.SimpleLuaComponentContainer.Add(self:getGo("btn_left_-1571983320"), CommButton)
	self._btnMiddle = Astral.SimpleLuaComponentContainer.Add(self:getGo("btn_middle_-31477526"), CommButton)
	self._btnRight = Astral.SimpleLuaComponentContainer.Add(self:getGo("btn_right_1251431307"), CommButton)
	self._lockThinkingGo = self:getGo("thought_info_view_-251013243")

	local roleCombatGo = self:getGo("15&role_combat_-1916846192")

	self._roleCombatCell = Astral.SimpleLuaComponentContainer.Add(roleCombatGo, RoleCombatCell)
	self._thinkingName = goutil.findChildTextComponent(roleCombatGo, "roleName")
	self._numGo = goutil.findChild(roleCombatGo, "objNum")
	self._signGroupTrs = goutil.findChild(roleCombatGo, "sign_group").transform
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._animation = self._lockStateGo:GetComponent(ComponentType.Animation)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._cellCenterThoughtItem:setClickCallback(self._onClickCenterThinkingItemCell, self)

	for _, cell in pairs(self._cellSkillLst or {}) do
		cell:setClickCallback(self._onClickCenterSkillItemCell, self)
	end

	self._btnLeft:AddClickListener(self._onClickWearOrOff, self)
	self._btnMiddle:AddClickListener(self._onClickActiveOrChange, self)
	self._btnRight:AddClickListener(self._onClickUpgrade, self)
	self._cellTipsSkill:setClickCallback(self._onClickTipsSkillItemCell, self)
	self._btnSkillDesc:AddClickListener(self._onClickSkillDesc, self)
end

function M:unbindEvents()
	self._cellCenterThoughtItem:setClickCallback(nil, nil)

	for _, cell in pairs(self._cellSkillLst or {}) do
		cell:setClickCallback(nil, nil)
	end

	self._btnLeft:RemoveClickListener()
	self._btnMiddle:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._cellTipsSkill:setClickCallback(nil, nil)
	self._btnSkillDesc:RemoveClickListener()
end

function M:onEnter()
	local info = self:getFirstParam()
	local thinkingId = info and info.thinkingId or 0

	thinkingId = thinkingId or 0

	if thinkingId <= 0 then
		self:close()

		return
	end

	self._isRefreshFMsg = false
	self._initStateLock = true
	self._isFromTotalPreview = info.isFromTotalPreview
	self._thinkingId = thinkingId

	self:setEvent(true)

	self._lockSkillMap = {}

	local skillId = info and info.skillId or false

	if skillId and skillId > 0 then
		self._selectedThinking = false
		self._selectedSkillId = skillId
	else
		self._selectedThinking = true
		self._selectedSkillId = nil
	end

	Astral.TransformUtil.SetLocalPosX(self._rectTrThinkingRoot.gameObject.transform, 0)
	self:refreshSelect()
	self:refreshView()

	local aniName = self:_isThinkingLock() and "open_statelock" or "open_unlock"

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName(aniName)
end

function M:onExit()
	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.GAIN_ITEM_ADD_EVENT, self._handleGainItemAdd, self)
		GlobalDispatcher:addEventListener(EventType.THINKING_REFRESH, self._handleThinkingRefresh, self)
		GlobalDispatcher:addEventListener(EventType.THINKING_HERO_REFRESH, self._handleThinkingRefresh, self)
		GlobalDispatcher:addEventListener(EventType.THINKING_GET_USING, self._handleGetUsing, self)
	else
		GlobalDispatcher:removeEventListener(EventType.GAIN_ITEM_ADD_EVENT, self._handleGainItemAdd, self)
		GlobalDispatcher:removeEventListener(EventType.THINKING_REFRESH, self._handleThinkingRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.THINKING_HERO_REFRESH, self._handleThinkingRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.THINKING_GET_USING, self._handleGetUsing, self)
	end
end

function M:_handleGainItemAdd(e, params)
	self:refreshTips()
end

function M:_handleThinkingRefresh()
	self._isRefreshFMsg = true

	self:refreshView()
	self:refreshSelect()
end

function M:_handleGetUsing()
	self._animation:Play("thought_info_view_open")
end

function M:_onClickCenterThinkingItemCell()
	if self:_isThinkingLock() then
		local heroData = self:getHeroData()

		ViewMgr.instance:open(ViewName.ThinkingUnLockView, {
			heroData = heroData,
			thinkingId = self._thinkingId
		})
	end

	self._selectedThinking = true
	self._selectedSkillId = nil

	self:refreshSelect()
end

function M:_onClickCenterSkillItemCell(skillId)
	skillId = skillId or 0

	if skillId <= 0 then
		ToolTipsMgr.showCharacterTopToast(lang("tip_thought_or_skill_not_online"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	self._selectedThinking = false
	self._selectedSkillId = skillId

	self:refreshSelect()
end

function M:_onClickTipsSkillItemCell(skillId)
	skillId = skillId or 0

	if skillId <= 0 then
		return
	end

	local skillInfo = ToolTipsMgr.getSkillTipsInfo()

	skillInfo.heroId = self:getHeroId()
	skillInfo.skillId = skillId
	skillInfo.hangGO = self._cellTipsSkill:getMainGo()

	ToolTipsMgr.showCharacterSysSkillTips(skillInfo)
end

function M:_onClickUpgrade(isActive)
	local thinkingId = self._thinkingId
	local thinkingMO = ThinkingModel.instance:getMoById(thinkingId)

	if not self._selectedThinking then
		local skillId = self._selectedSkillId

		skillId = skillId or 0

		if skillId <= 0 then
			return
		end

		if thinkingMO:isMaxLevelSkill(skillId) then
			ToolTipsMgr.showCharacterTopToast(lang("tip_thought_skill_upgrade_fail_by_max_level"), CommEnum.CharacterTopToastIcon.Fail, 1)

			return
		end

		if not isActive then
			ViewMgr.instance:open(ViewName.ThinkingUpgradeView, {
				skillId = self._selectedSkillId,
				thinkingId = self._thinkingId
			})

			return
		end

		local costItem = ThinkingConfig.instance:getSkillActiveCost(skillId, thinkingMO:getSkillLevel(skillId) + 1)

		if self:_getCostEnough(costItem) then
			ThinkingAgent.instance:sendThinkingSkillUpgradeRequest(thinkingId, skillId)
		end
	end
end

function M:_onClickActiveOrChange()
	local heroData = self:getHeroData()
	local thinkingItemData = heroData:getThinkingItemData()
	local usingThinkingSkillId = thinkingItemData:getWearingSkillId()
	local thinkingId = self._thinkingId
	local thinkingMO = ThinkingModel.instance:getMoById(thinkingId)
	local skillId = self._selectedSkillId
	local isUsing = skillId == usingThinkingSkillId
	local skillLevel = thinkingMO:getSkillLevel(skillId)
	local isLockSkill = skillLevel <= 0

	if self._isFromTotalPreview then
		self:_onClickUpgrade(isLockSkill)
	elseif isLockSkill then
		self:_onClickUpgrade(true)
	elseif not isUsing then
		self:_onClickWearOrOff()
	else
		self:back()
		ThinkingModel.instance:setShowChangeState(true)
	end
end

function M:_onClickWearOrOff()
	local heroData = self:getHeroData()
	local thinkingId = self._thinkingId
	local thinkingItemData = heroData:getThinkingItemData()
	local usingThinkingId = thinkingItemData:getThinkingMoId()
	local usingThinkingSkillId = thinkingItemData:getWearingSkillId()

	if not self._selectedThinking then
		local skillId = self._selectedSkillId

		skillId = skillId or 0

		if skillId <= 0 then
			return
		end

		if usingThinkingId == thinkingId and skillId == usingThinkingSkillId then
			self:back()
			ThinkingModel.instance:setShowChangeState(true)

			return
		end

		ThinkingAgent.instance:sendWearThinkingRequest(heroData:getId(), thinkingId, skillId)
	end
end

function M:_getCostEnough(costItemLst)
	local itemEnough = true

	for _, itemData in ipairs(costItemLst) do
		if itemEnough and not ItemUtil.isItemEnough(itemData:getItemId(), itemData:getCount()) then
			itemEnough = false
		end
	end

	if not itemEnough then
		ToolTipsMgr.showCharacterTopToast(lang("tip_lack_of_material"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return false
	end

	return true
end

function M:getHeroId()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false

	if heroData then
		return heroData:getId()
	end

	return nil
end

function M:getHeroData(heroId)
	heroId = heroId or self:getHeroId()

	local data = HeroDepotModel.instance:getHeroInfoByID(heroId)

	if not data then
		printError(string.format("无法找到角色[%s]的数据", heroId))
	end

	return data
end

function M:_isThinkingLock()
	if self._isFromTotalPreview then
		return false
	end

	local heroData = self:getHeroData()
	local thinkingItemData = heroData:getThinkingItemData()
	local isLock = not thinkingItemData:isThinkingUnlocked(self._thinkingId)

	return isLock
end

function M:refreshSelect()
	self._cellCenterThoughtItem:setSelected(self._selectedThinking)

	for _, cell in ipairs(self._cellSkillLst) do
		cell:setSelected(cell:getSkillId() == self._selectedSkillId)
	end

	self:refreshTips()
end

function M:refreshView()
	local thinkingId = self._thinkingId
	local thinkingMO = ThinkingModel.instance:getMoById(thinkingId)
	local cell = self._cellCenterThoughtItem

	cell:refreshView(thinkingId)
	cell:setLockVisible(self:_isThinkingLock())
	cell:setIsUsing(false)
	cell:setActiveFlagVisible(false)

	if self._initStateLock then
		goutil.setActive(self._lockStateGo, self:_isThinkingLock())

		self._initStateLock = false
	end

	local cfgThought = ThinkingConfig.instance:getThinkingCO(thinkingId)
	local heroData = self:getHeroData()
	local thinkingItemData = heroData:getThinkingItemData()
	local usingThinkingSkillId = thinkingItemData:getWearingSkillId()

	self._txtTag1.text = cfgThought.tags[1]
	self._txtTag2.text = cfgThought.tags[2]

	goutil.setActive(self._txtTag2.transform.parent.gameObject, #cfgThought.tags > 1)

	local skillIds = cfgThought.skills or {}

	skillIds = skillIds or {}

	for index, skillCell in ipairs(self._cellSkillLst) do
		local skillId = skillIds[index] or -1
		local isExist = skillId > 0
		local skillLevel = 0
		local isMaxLevel = true

		if isExist then
			skillLevel = thinkingMO:getSkillLevel(skillId)
			isMaxLevel = thinkingMO:isMaxLevelSkill(skillId)
		end

		local isLockSkill = skillLevel <= 0
		local lockStateChange = self._lockSkillMap[skillId] ~= nil and self._lockSkillMap[skillId] ~= isLockSkill
		local isUsing = skillId == usingThinkingSkillId

		self._lockSkillMap[skillId] = isLockSkill

		skillCell:refreshView(skillId, skillLevel, isLockSkill or self:_isThinkingLock(), lockStateChange, isMaxLevel)
		skillCell:setSelected(false)
		skillCell:setAtPresentVisible(false)
		skillCell:setLevelRootVisible(isExist)

		if not self._isFromTotalPreview and isUsing then
			skillCell:setAtPresentVisible(isUsing)

			if not self._isRefreshFMsg then
				skillCell:_onClick()
			end
		end
	end

	goutil.setActive(self._numGo, not self._isFromTotalPreview)

	if self._isFromTotalPreview then
		self._thinkingName.text = thinkingMO:getName()

		local tags = cfgThought.tags

		if #tags > 0 then
			while self._signGroupTrs.childCount < #tags do
				goutil.cloneAndSetParent(self._signGroupTrs:GetChild(0).gameObject, self._signGroupTrs)
			end

			for i = 0, self._signGroupTrs.childCount - 1 do
				local go = self._signGroupTrs:GetChild(i).gameObject
				local txtSign = goutil.findChildTextComponent(go, "txtSign")

				txtSign.text = tags[i + 1]
			end
		end
	else
		local heroData = self:getHeroData()

		self._roleCombatCell:updateHeroData(heroData)

		self._thinkingName.text = ""
	end
end

function M:refreshTips()
	goutil.setActive(self._goTips, not self._selectedThinking)
	goutil.setActive(self._goTipsSkillRoot, not self._selectedThinking)

	local targetX = self._selectedThinking and 0 or self._originX

	self._rectTrThinkingRoot.gameObject.transform:DOLocalMoveX(targetX, 0.25):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)

	if self._selectedThinking then
		-- block empty
	else
		self:_refreshTipsThinkingSkill()
	end
end

function M:_refreshTipsThinkingSkill()
	local thinkingId = self._thinkingId
	local thinkingMO = ThinkingModel.instance:getMoById(thinkingId)
	local skillId = self._selectedSkillId
	local skillLevel = thinkingMO:getSkillLevel(skillId)
	local isMaxLevel = thinkingMO:isMaxLevelSkill(skillId)
	local isLockSkill = skillLevel <= 0
	local heroData = self:getHeroData()
	local thinkingItemData = heroData:getThinkingItemData()
	local usingThinkingSkillId = thinkingItemData:getWearingSkillId()
	local isUsing = skillId == usingThinkingSkillId

	self._txtTipsSkillLevelPre.text = string.format("Lv.%s", skillLevel)
	self._txtTipsSkillLevelAfter.text = "MAX"

	goutil.setActive(self._txtTipsSkillLevelPre.gameObject, not isLockSkill)
	goutil.setActive(self._txtTipsSkillLevelAfter.gameObject, not isLockSkill and isMaxLevel)

	local skillName, skillDesc, skillIcon = thinkingMO:getSkillData(skillId, skillLevel)

	self._txtTipsName.text = thinkingMO:getName()
	self._txtTipsSkillName.text = skillName
	self._txtTipsSkillDesc.text = skillDesc

	self._cellTipsSkill:refreshView(skillId, skillLevel + 1, false)
	self._cellTipsSkill:setLock(isLockSkill)

	local isThinkingLock = self:_isThinkingLock()

	goutil.setActive(self._lockThinkingGo, isThinkingLock)
	self._btnLeft:setActive(not isLockSkill and not isMaxLevel and not self._isFromTotalPreview and not isThinkingLock)
	self._btnMiddle:setActive((isLockSkill or isMaxLevel or self._isFromTotalPreview) and not isThinkingLock)
	self._btnRight:setActive(not isLockSkill and not isMaxLevel and not self._isFromTotalPreview and not isThinkingLock)
	self._btnLeft:setText(isUsing and lang("tip_echo_btn_replace") or lang("tip_r_equip_bring"))

	local textStr = ""

	if isLockSkill then
		textStr = lang("tip_activate")
	elseif self._isFromTotalPreview then
		textStr = isMaxLevel and lang("tip_r_equip_max_txt") or lang("tip_thought_skill_btn_upgrade")
	else
		textStr = isUsing and lang("tip_echo_btn_replace") or lang("tip_r_equip_bring")
	end

	self._btnMiddle:setText(textStr)
	self._btnRight:setText(lang("tip_thought_skill_btn_upgrade"))
	goutil.setActive(self._goTipsCostRoot, not isMaxLevel and isLockSkill)

	if not isMaxLevel then
		local costItem = ThinkingConfig.instance:getSkillActiveCost(skillId, skillLevel + 1)

		goutil.setActive(self._goTipsCostRoot, #costItem > 0 and isLockSkill)

		if #costItem > 0 then
			while self._rectCostContent.childCount < #costItem do
				goutil.cloneAndSetParent(self._rectCostContent:GetChild(0).gameObject, self._rectCostContent)
			end

			for i = 0, self._rectCostContent.childCount - 1 do
				local go = self._rectCostContent:GetChild(i).gameObject
				local _data = costItem[i + 1]

				if _data then
					local myCount = ItemModel.instance:getItemCountByItemId(_data:getItemId())
					local strNum = myCount >= _data:getCount() and string.format("%s/%s", myCount, _data:getCount()) or string.format("<color=#ca3535>%s</color>/%s", myCount, _data:getCount())
					local itemCell = Astral.SimpleLuaComponentContainer.Add(go, ItemCell)

					itemCell:updateData(_data)
					itemCell:setShowTipsPassEvent(false)
					itemCell:setShowSelectedEffect(false)
					itemCell:getComponent("num"):setVisible(true)
					itemCell:getComponent("num"):setNumBgNodeVisible(false)
					itemCell:getComponent("num"):setCostTextActive(true)
					itemCell:getComponent("num"):setCostText(strNum)
					itemCell:getComponent("num"):setCountTextActive(false)
				end

				goutil.setActive(go, _data)
			end
		end
	end
end

function M:_onClickSkillDesc()
	local thinkingId = self._thinkingId
	local thinkingMO = ThinkingModel.instance:getMoById(thinkingId)
	local skillId = self._selectedSkillId
	local skillLevel = thinkingMO:getSkillLevel(skillId)
	local skillEnhanceMO = thinkingMO:getSkillEnhanceMO(skillId, skillLevel)

	if skillEnhanceMO then
		skillEnhanceMO:rebuild()

		local bindGo = self._btnSkillDesc.gameObject
		local isPassEvent = true

		ToolTipsMgr.showSkillBuffTagSideTips(skillEnhanceMO, bindGo, isPassEvent)
	end
end

return M
