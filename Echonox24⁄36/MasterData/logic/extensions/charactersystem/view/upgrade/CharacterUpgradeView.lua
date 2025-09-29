-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/upgrade/CharacterUpgradeView.lua

module("logic.extensions.charactersystem.view.upgrade.CharacterUpgradeView", package.seeall)

local M = class("CharacterUpgradeView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._isCanUpgrade = true
	self._isCanCostUpgrade = true
end

function M:buildUI()
	self._btnBg = self:getBtn("5&universal_second_tips_common_bg_-1467035629")
	self._txtTitle = goutil.findChildComponent(self.mainGO, "universal_second_tips_common_bg/content/txtTitle", UIComponentType.Text)
	self._btnClose = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "universal_second_tips_common_bg/content/btnClose"))
	self._btnCancel = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "content/btnCancel"))
	self._btnConfirm = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "content/btnReset"))
	self._goCostRoot = goutil.findChild(self.mainGO, "content/com_price").gameObject
	self._costCell = PrefabReferenceUtil.createCurrencyCostLuaCell(self._goCostRoot)
	self._btnFastAdd = self:getBtnByPath("content/btnFastAdd")
	self._txtPreLv = self:getText("level_up_common_tips_1908741033")
	self._txtAddLv = self:getText("level_up_common_tips_1516035504")
	self._txtMaxLv = self:getText("level_up_common_tips_1990578856")
	self._txtAddExp = self:getText("level_up_common_tips_403238794")
	self._txtExp = self:getText("level_up_common_tips_1432980014")
	self._imgExpBar = self:getImage("level_up_common_tips_229089551")
	self._imgExpAdd = self:getImage("level_up_common_tips_678972865")
	self._goAddExpRoot = goutil.findChild(self.mainGO, "content/content_1/layout").gameObject
	self._txtBtnConfirm = self:getText("8&btn_right_1648124116")
	self._scroll = self:getUIComponent("level_up_common_tips_-1170110971", UIComponentType.ScrollRect)
	self._loopList = LoopListHelper.New(self._scroll.gameObject)

	self._loopList:InitListView(0, self._onCellUpdate, self)

	self._btnSkill1Up = self:getBtn("3&btn_skill_bonus_280624854")
	self._btnSkill1Down = self:getBtn("3&btn_skill_bonus_-1720983089")
	self._btnSkill2Up = self:getBtn("4&btn_skill_bonus_280624854")
	self._btnSkill2Down = self:getBtn("4&btn_skill_bonus_-1720983089")

	goutil.setActive(self._btnSkill1Up.gameObject, AchievementModel.instance:isGetSkill(CommEnum.CharacterSkillType.Type1))
	goutil.setActive(self._btnSkill1Down.gameObject, false)
	goutil.setActive(self._btnSkill2Up.gameObject, false)
	goutil.setActive(self._btnSkill2Down.gameObject, AchievementModel.instance:isGetSkill(CommEnum.CharacterSkillType.Type6))
end

function M:destroyUI()
	self._isEnter = nil

	self._loopList:ClearCells()
	self._loopList:Dispose()

	self._loopList = nil
end

function M:bindEvents()
	self._btnBg:AddClickListener(self._onClickClose, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	self._btnSkill1Up:AddClickListener(self._onOpenSkillSmallTips1, self)
	self._btnSkill2Down:AddClickListener(self._onOpenSkillSmallTips2, self)
	self._btnFastAdd:AddClickListener(self._onClickFastAdd, self)
end

function M:unbindEvents()
	self._btnBg:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._btnSkill1Up:RemoveClickListener()
	self._btnSkill2Down:RemoveClickListener()
	self._btnFastAdd:RemoveClickListener()
end

function M:onEnter()
	self._isEnter = true

	self:setEvent(true)

	local info = self:getFirstParam() or {}

	self._heroId = info.heroId

	self:_prepareData()
	self:_refreshView()
	self:_refreshLoopLst()
	self._costCell:updateData(CommEnum.CurrencyCodeEnum.LzbCode)
	self:_setConfirmText()
end

function M:onExit()
	self._isEnter = false

	self:setEvent(false)
	self:_releaseExpTweener()

	self._isCanUpgrade = true
	self._isCanCostUpgrade = true

	PlayerAttributeGainTipsController.instance:unfreeze("upgrade")
end

function M:onExitFinished()
	return
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.HERO_INFO_CHANGE, self._handleAddHeroExpReply, self)
		GlobalDispatcher:addEventListener(EventType.GAIN_ITEM_ADD_EVENT, self._handleGainItemAdd, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HERO_INFO_CHANGE, self._handleAddHeroExpReply, self)
		GlobalDispatcher:removeEventListener(EventType.GAIN_ITEM_ADD_EVENT, self._handleGainItemAdd, self)
	end
end

function M:_handleAddHeroExpReply(e)
	if not self._isEnter then
		return
	end

	self:_reCalculateData(true)
	self:_refreshLoopLst()

	local heroData = self:getHeroData()

	if heroData then
		self:_playUpgradeFill(heroData:getLevel(), heroData:getLevelExp())
	end
end

function M:_handleGainItemAdd(e, params)
	if not self._isEnter then
		return
	end

	self._lzbNum = ItemModel.instance:getItemCountByItemId(CommEnum.CurrencyCodeEnum.LzbCode)
	self._hasItems = false

	for _itemId, data in pairs(self._itemUseData or {}) do
		local _count = ItemModel.instance:getItemCountByItemId(_itemId)

		self._itemUseData[_itemId].itemCount = _count

		if _count > 0 then
			self._hasItems = true
		end
	end

	self:_refreshLoopLst()
end

function M:getHeroData()
	if self._heroId then
		return HeroDepotModel.instance:getHeroInfoByID(self._heroId)
	end

	local viewPageMo = HeroDepotModel.instance:getViewPageMo()

	return viewPageMo and viewPageMo.hero or false
end

function M:_getFallBackItemLst()
	if self._fallBackItem then
		return self._fallBackItem
	end

	local itemCfgLst = BackpackConfig.instance:getItemsInfoByTS(GameEnum.ItemTypeEnum.PropItemType, GameEnum.PropSubTypeEnum.CardExpProp)

	self._fallBackItem = {}

	for _, cfg in pairs(itemCfgLst or {}) do
		table.insert(self._fallBackItem, cfg)
	end

	table.sort(self._fallBackItem, function(a, b)
		local qualityA = a.quality or 0
		local qualityB = b.quality or 0

		if qualityA ~= qualityB then
			return qualityA < qualityB
		end

		return a.id < b.id
	end)

	return self._fallBackItem
end

function M:_setConfirmText()
	local heroData = self:getHeroData()
	local level = heroData:getLevel()

	if level == self._maxLv then
		if heroData:getPowerLv() == HeroPowerConfig.instance:getMaxPowerLevel(heroData:getId()) then
			self._txtBtnConfirm.text = lang("tip_common_confirm")
		else
			self._txtBtnConfirm.text = lang("tip_character_levelup_authority")
		end
	else
		self._txtBtnConfirm.text = lang("tip_common_confirm")
	end
end

function M:_prepareData()
	self:_initAchievementSkillProfile()

	self._lzbNum = ItemModel.instance:getItemCountByItemId(CommEnum.CurrencyCodeEnum.LzbCode)
	self._itemLst = {}
	self._itemUseData = {}
	self._itemUseOrder = {}
	self._hasItems = false

	local fallBackItem = self:_getFallBackItemLst()

	for _, cfg in ipairs(fallBackItem or {}) do
		local itemId = cfg.id
		local itemCount = ItemModel.instance:getItemCountByItemId(itemId)
		local itemData = ItemUtil.createItemData({
			itemId = itemId,
			count = itemCount
		})
		local expNum = tonumber(itemData:getExtrInfo()) * (1 + self._expAddProfile)

		self._itemUseData[itemId] = {
			hasAddCount = 0,
			itemCount = itemCount,
			expNum = expNum,
			baseExpNum = tonumber(itemData:getExtrInfo()),
			totalExpNum = expNum * itemCount
		}

		table.insert(self._itemLst, itemData)
		table.insert(self._itemUseOrder, itemId)

		if itemCount > 0 then
			self._hasItems = true
		end
	end

	table.sort(self._itemUseOrder, function(itemIdA, itemIdB)
		local expA = self._itemUseData[itemIdA].baseExpNum
		local expB = self._itemUseData[itemIdB].baseExpNum

		if expA ~= expB then
			return expB < expA
		end

		return itemIdB < itemIdA
	end)

	local heroData = self:getHeroData()
	local curlevel = heroData:getLevel()

	self._minLevel = curlevel
	self._qualityStr = CharacterExpConfig.instance:qualityToQualityStr(heroData:getQuality())
	self._maxCfgLv = CharacterExpConfig.instance:getPowerLvAndQualityToLvLimit(heroData:getPowerLv(), heroData:getQuality())
	self._maxLv = self._maxCfgLv
	self._upgradeConfig = CharacterExpConfig.instance:getUpgradeCO()
	self._isPowerLvMax = heroData:getPowerLv() == HeroPowerConfig.instance:getMaxPowerLevel(heroData:getId())
	self._txtPreLv.text = heroData:getLevel()
	self._txtMaxLv.text = string.format("/%s MAX", self._maxCfgLv)
	self._expToMax = 0

	if curlevel < self._maxLv then
		for i = curlevel, self._maxLv - 1 do
			local _co = self._upgradeConfig[i]
			local needExp = _co[self._qualityStr]

			needExp = i == curlevel and needExp - heroData:getLevelExp() or needExp
			self._expToMax = self._expToMax + needExp
		end
	end
end

function M:_reCalculateData(clearAddCount)
	self._lzbNum = ItemModel.instance:getItemCountByItemId(CommEnum.CurrencyCodeEnum.LzbCode)

	local heroData = self:getHeroData()
	local curlevel = heroData:getLevel()

	self._qualityStr = CharacterExpConfig.instance:qualityToQualityStr(heroData:getQuality())
	self._maxCfgLv = CharacterExpConfig.instance:getPowerLvAndQualityToLvLimit(heroData:getPowerLv(), heroData:getQuality())
	self._maxLv = self._maxCfgLv
	self._hasItems = false

	for _itemId, _data in pairs(self._itemUseData or {}) do
		local itemCount = ItemModel.instance:getItemCountByItemId(_itemId)

		_data.itemCount = itemCount
		_data.totalExpNum = _data.expNum * itemCount

		if itemCount > 0 then
			self._hasItems = true
		end

		if clearAddCount then
			_data.hasAddCount = 0
		end
	end

	self._expToMax = 0

	if curlevel < self._maxLv then
		for i = curlevel, self._maxLv - 1 do
			local _co = self._upgradeConfig[i]
			local needExp = _co[self._qualityStr]

			needExp = i == curlevel and needExp - heroData:getLevelExp() or needExp
			self._expToMax = self._expToMax + needExp
		end
	end
end

function M:_refreshLoopLst()
	local count = self._itemLst and #self._itemLst or 0

	if self._loopList:GetLoopListView().ItemTotalCount ~= count then
		self._loopList:SetListItemCount(count, true)
	else
		self._loopList:RefreshAllShownItem()
	end

	self._scroll.enabled = count > 4
end

function M:_onClickClose()
	self:close()
end

function M:_onClickConfirm()
	if not self._hasItems then
		ToolTipsMgr.showCharacterTopToast(lang("tip_role_ugrade_item_less"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	local heroData = self:getHeroData()
	local orgLevel = heroData:getLevel()

	if orgLevel >= self._maxLv then
		if heroData:getPowerLv() == HeroPowerConfig.instance:getMaxPowerLevel(heroData:getId()) then
			ToolTipsMgr.showCharacterTopToast(lang("tip_role_reach_max_level"), CommEnum.CharacterTopToastIcon.Fail, 1)
		elseif SystemJumpController.instance:canJump(10220001, true) then
			local target = CharacterAuthorityModel.instance:getNextLevelUpIndex(heroData:getId())

			SystemJumpController.instance:jumpToCharacterSystem(heroData:getId(), CommEnum.CharacterSystemTab.Authority, target)
		end

		return
	end

	local addExp, addExpOrg, needCost = self:_getCurUseExp()

	if addExp == 0 then
		ToolTipsMgr.showCharacterTopToast(lang("tip_select_one"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	if needCost > self._lzbNum then
		ToolTipsMgr.showCharacterTopToast(lang("tip_role_ugrade_gold_less"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	local enough = true

	for _itemId, data in pairs(self._itemUseData) do
		if enough and data.itemCount < data.hasAddCount then
			enough = false
		end
	end

	if not enough then
		ToolTipsMgr.showCharacterTopToast(lang("tip_role_ugrade_item_less"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_dengjitisheng, nil, nil, nil)

	self._heroDataWhenUpgrade = {
		id = heroData:getId(),
		level = heroData:getLevel(),
		exp = heroData:getLevelExp(),
		secretValue = heroData:getAttribute(BattleExtension_pb.Attribute.FIGHTING_CAPACITY),
		hp = heroData:getAttribute(BattleExtension_pb.Attribute.MAX_HP),
		attack = heroData:getAttribute(BattleExtension_pb.Attribute.ATK_PHY),
		def = heroData:getAttribute(BattleExtension_pb.Attribute.DEF_PHY),
		atkMag = heroData:getAttribute(BattleExtension_pb.Attribute.ATK_MAG),
		defMag = heroData:getAttribute(BattleExtension_pb.Attribute.DEF_MAG),
		afflatus = heroData:getAttribute(BattleExtension_pb.Attribute.INSPIRATION)
	}

	local useItems = {}

	for _itemId, data in pairs(self._itemUseData) do
		if data.hasAddCount > 0 then
			useItems[tostring(_itemId)] = data.hasAddCount
		end
	end

	PlayerAttributeGainTipsController.instance:freeze("upgrade")
	HeroDepotAgent.instance:sendAddHeroExpRequest(heroData:getId(), useItems)
end

function M:_onClickFastAdd()
	if not self._hasItems then
		ToolTipsMgr.showCharacterTopToast(lang("tip_role_ugrade_item_less"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	local heroData = self:getHeroData()
	local orgLevel = heroData:getLevel()

	if orgLevel >= self._maxCfgLv then
		ToolTipsMgr.showCharacterTopToast(lang("tip_role_reach_max_level"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	if self._lzbNum == 0 then
		ToolTipsMgr.showCharacterTopToast(lang("tip_role_ugrade_gold_less"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	local addExp, addExpOrg, needCost = self:_getCurUseExp()

	self._curTotalExp = addExp

	if self._curTotalExp >= self._expToMax then
		FloatWordMgr.instance:show(lang("tip_quick_add_max"))

		return
	elseif needCost > self._lzbNum then
		FloatWordMgr.instance:show(lang("tip_quick_add_not_enough"))

		return
	end

	local hasCanAddItem = false
	local addNum = 0
	local isLzbEnough = true

	for _, _itemId in ipairs(self._itemUseOrder) do
		local ownNum = self._itemUseData[_itemId].itemCount

		for i = 1, ownNum - self._itemUseData[_itemId].hasAddCount do
			hasCanAddItem = true

			local canAdd, overflow, lzbEnough = self:_tryAddExp(_itemId)

			if canAdd and not overflow and lzbEnough then
				self._itemUseData[_itemId].hasAddCount = self._itemUseData[_itemId].hasAddCount + 1
				addNum = addNum + 1
			end

			if overflow or not lzbEnough then
				break
			end
		end
	end

	for i = #self._itemUseOrder, 1, -1 do
		local _itemId = self._itemUseOrder[i]
		local _ownNum = self._itemUseData[_itemId].itemCount
		local _offset = _ownNum - self._itemUseData[_itemId].hasAddCount

		for _a = 1, _offset do
			hasCanAddItem = true

			local canAdd, overflow, lzbEnough = self:_tryAddExp(_itemId)

			isLzbEnough = isLzbEnough and lzbEnough

			if canAdd and lzbEnough then
				addNum = addNum + 1
				self._itemUseData[_itemId].hasAddCount = self._itemUseData[_itemId].hasAddCount + 1
			end
		end
	end

	if not hasCanAddItem then
		local addExp, addExpOrg, needCost = self:_getCurUseExp()
		local tips = addExp > 0 and lang("tip_quick_add_all") or lang("tip_quick_add_null")

		FloatWordMgr.instance:show(tips)
	elseif addNum <= 0 and not isLzbEnough then
		FloatWordMgr.instance:show(lang("tip_quick_add_not_enough"))
	elseif addNum <= 0 then
		FloatWordMgr.instance:show(lang("tip_quick_add_all"))
	end

	self:_refreshView()
	self:_refreshLoopLst()
end

function M:_initAchievementSkillProfile()
	if self._expAddProfile or self._goldConsumeProfile then
		return
	end

	self._expAddProfile = 0
	self._goldConsumeProfile = 0

	local skillMOList = PlayerInfoFacade.instance:getAchievementSkill()

	for i, AchievementSkillMO in ipairs(skillMOList) do
		if AchievementSkillMO:getId() == 1 and AchievementSkillMO:getLevel() > 0 then
			self._expAddProfile = tonumber(AchievementSkillMO:getEffectValue()) / 100
		end

		if AchievementSkillMO:getId() == 6 and AchievementSkillMO:getLevel() > 0 then
			self._goldConsumeProfile = tonumber(AchievementSkillMO:getEffectValue()) / 100
		end
	end
end

function M:getLvNeedExp(level)
	local upgradeExp = 0

	if self._upgradeConfig[level] then
		upgradeExp = self._upgradeConfig[level][self._qualityStr]
	end

	return upgradeExp
end

function M:getLzbCostRate()
	local heroData = self:getHeroData()
	local _co = self._upgradeConfig[heroData:getLevel()]
	local _costRate = _co.goldPerExp * (1 - self._goldConsumeProfile)

	return _costRate
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local itemData = self._itemLst[curIndex]
	local itemId = itemData:getItemId()
	local useData = self._itemUseData[itemId]
	local count = useData.itemCount
	local hasAddCount = useData.hasAddCount
	local item = self._loopList:NewListViewItem("backpack_item_1")
	local hideGetWay = BattleMgr.instance:isInBattle()
	local shower = Astral.SimpleLuaComponentContainer.Get(item.gameObject, ItemCell)

	if not shower then
		shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, ItemCell)

		shower:getComponent("normal"):setClickListener(self._onItemClick, self)
	end

	shower:updateData(itemData)
	shower:setShowTipsPassEvent(false)
	shower:setShowSelectedEffect(false)
	shower:getComponent("num"):setNumBgNodeVisible(false)
	shower:getComponent("num"):setCountText(count > 0 and count or tostring(count))
	shower:setIsHideGetWay(hideGetWay)
	shower:getComponent("animation"):setAlpha(count > 0 and hasAddCount <= count and 1 or 0.5)
	self:_updateCellOperate(shower)

	return item
end

function M:_updateCellOperate(cell)
	local itemData = cell:getData()
	local itemId = itemData:getItemId()
	local useData = self._itemUseData[itemId]
	local hasAddCount = useData.hasAddCount
	local compOperate = cell:getComponent("operate")

	if not compOperate then
		cell:_addComponent("operate", LongClickComponent)

		compOperate = cell:getComponent("operate")

		compOperate:onInit()
		compOperate:setAddCallback(self._onItemAdd, self)
		compOperate:setReduceCallback(self._onItemMinus, self)
		compOperate:setBtnCutGoVisible(false)
		compOperate:setBtnCutMoreGoVisible(true)
		compOperate:setCountGoVisible(true)
	end

	compOperate:setCount(hasAddCount)
	compOperate:setImgOperateGoVisible(hasAddCount > 0)
end

function M:_onItemClick(cell)
	local itemData = cell:getData()
	local itemId = itemData:getItemId()
	local _ownNum = self._itemUseData[itemId].itemCount

	if _ownNum > 0 then
		local canAdd, overflow, lzbEnough = self:_tryAddExp(itemId)

		if not canAdd then
			ToolTipsMgr.showCharacterTopToast(lang("tip_role_reach_max_level"), CommEnum.CharacterTopToastIcon.Fail, 1)

			return
		end

		cell:getComponent("operate"):setImgOperateGoVisible(true)
		self:_onItemAdd(cell)
	else
		cell:dealSelect()
	end
end

function M:_onItemAdd(cell)
	local itemData = cell:getData()
	local itemId = itemData:getItemId()
	local useData = self._itemUseData[itemId]
	local wantedAdd = useData.hasAddCount + 1
	local enoughToAdd = wantedAdd <= useData.itemCount

	if not enoughToAdd then
		return
	end

	local canAdd, overflow, lzbEnough = self:_tryAddExp(itemId)

	if not canAdd then
		ToolTipsMgr.showCharacterTopToast(lang("tip_role_reach_max_level"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	self._itemUseData[itemId].hasAddCount = wantedAdd

	self:_updateCellOperate(cell)
	self:_refreshView()
end

function M:_onItemMinus(cell)
	local itemData = cell:getData()
	local itemId = itemData:getItemId()
	local useData = self._itemUseData[itemId]
	local wantedAdd = useData.hasAddCount - 1

	if wantedAdd < 0 then
		return
	end

	self._itemUseData[itemId].hasAddCount = wantedAdd

	self:_updateCellOperate(cell)
	self:_refreshView()
end

function M:_tryAddExp(itemId)
	local data = self._itemUseData[itemId]
	local exp = data.expNum
	local baseExpNum = data.baseExpNum
	local canAdd, overflow, lzbEnough = true, false, false

	if exp > 0 then
		local heroData = self:getHeroData()
		local level = heroData:getLevel()

		if level >= self._maxCfgLv then
			canAdd = false
			overflow = false
			lzbEnough = false
		else
			local addExp, addExpOrg, needCost = self:_getCurUseExp()
			local addCost = math.floor(baseExpNum * self:getLzbCostRate())

			canAdd = addExp <= self._expToMax
			overflow = addExp + exp > self._expToMax
			lzbEnough = self._lzbNum >= needCost + addCost
		end
	end

	return canAdd, overflow, lzbEnough
end

function M:_getCurUseExp()
	local addExp = 0
	local addExpOrg = 0
	local needCost = 0

	for itemId, data in pairs(self._itemUseData or {}) do
		if data.hasAddCount > 0 then
			addExp = addExp + data.expNum * data.hasAddCount
			addExpOrg = addExpOrg + data.baseExpNum * data.hasAddCount
		end
	end

	if addExpOrg > 0 then
		needCost = addExpOrg * self:getLzbCostRate()
		needCost = math.floor(needCost)
	end

	return addExp, addExpOrg, needCost
end

function M:_refreshView()
	local heroData = self:getHeroData()
	local level = heroData:getLevel()
	local nextLv = level
	local maxLevel = self._maxCfgLv
	local addExp, addExpOrg, needCost = self:_getCurUseExp()

	if addExp > 0 then
		local remainedExp = addExp

		for i = level, maxLevel do
			if remainedExp > 0 then
				local _co = self._upgradeConfig[i]
				local needExp = _co[self._qualityStr]

				needExp = i == level and needExp - heroData:getLevelExp() or needExp

				if needExp <= remainedExp then
					remainedExp = remainedExp - needExp
					nextLv = math.min(i + 1, maxLevel)
				else
					remainedExp = 0
				end
			end
		end
	end

	goutil.setActive(self._txtMaxLv.gameObject, nextLv == self._maxCfgLv)

	self._txtAddLv.text = level < nextLv and string.format("+%s", nextLv - level) or nil
	self._txtAddExp.text = addExp > 0 and string.format("+%s", self:_getShowExp(addExp)) or nil

	local costStr = needCost <= self._lzbNum and needCost > 0 and needCost or string.format("<color=#ff3e48>%s</color>", needCost)

	self._costCell:setCostCount(costStr)
	goutil.setActive(self._goCostRoot, needCost > 0)
	goutil.setActive(self._goAddExpRoot, addExp > 0)

	if level == self._maxLv then
		if heroData:getPowerLv() == HeroPowerConfig.instance:getMaxPowerLevel(heroData:getId()) then
			self._txtExp.text = "Max"
			self._txtBtnConfirm.text = lang("tip_common_confirm")
		else
			self._txtExp.text = lang("tip_character_level_limit_1")
			self._txtBtnConfirm.text = lang("tip_character_levelup_authority")
		end

		self._imgExpBar.fillAmount = 1
	else
		self._txtExp.text = string.format("%s/%s", heroData:getLevelExp(), self:getLvNeedExp(level))
		self._imgExpBar.fillAmount = heroData:getLevelExp() / self:getLvNeedExp(level)
	end

	local addFillAmount = 0

	addFillAmount = level < nextLv and 1 or (heroData:getLevelExp() + addExp) / self:getLvNeedExp(level)
	self._imgExpAdd.fillAmount = addFillAmount

	RectTransformUtils.ForceRebuildLayoutImmediate(self._txtAddLv.transform)
end

function M:_getShowExp(exp, numDigits)
	local _val, _decimals = math.modf(exp)

	if _decimals == 0 then
		return _val
	else
		numDigits = numDigits or 0
		numDigits = 10^numDigits

		local finalVal = MathUtil.roundingBy456(exp * numDigits)

		finalVal = finalVal ~= 0 and finalVal / numDigits or finalVal / numDigits

		return finalVal
	end
end

function M:_onOpenSkillSmallTips1()
	local param = {}

	param.obj = self._btnSkill1Up.transform.parent.gameObject
	param.skillType = CommEnum.CharacterSkillType.Type1

	ViewMgr.instance:open(ViewName.AchievementSkillSmallTips, param)
end

function M:_onOpenSkillSmallTips2()
	local param = {}

	param.obj = self._btnSkill2Down.transform.parent.gameObject
	param.skillType = CommEnum.CharacterSkillType.Type6

	ViewMgr.instance:open(ViewName.AchievementSkillSmallTips, param)
end

M.TOTAL_FILL_ANIM_TIME = 0.5

function M:_playUpgradeFill(lv, exp)
	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Anim)
	settimer(0.5, function()
		ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Anim)
	end, self, false)

	self._fillAniData = {
		oldLv = self._heroDataWhenUpgrade.level,
		oldExp = self._heroDataWhenUpgrade.exp,
		curLv = self._heroDataWhenUpgrade.level,
		curExp = self._heroDataWhenUpgrade.exp,
		targetLv = lv,
		targetExp = exp,
		offsetLv = lv - self._heroDataWhenUpgrade.level
	}

	local data = self._fillAniData
	local stepTime = M.TOTAL_FILL_ANIM_TIME

	if data.offsetLv > 0 then
		stepTime = data.targetExp > 0 and stepTime / (data.offsetLv + 1) or stepTime / data.offsetLv
	end

	self._fillAniData.stepTime = stepTime

	for _itemId, _useData in pairs(self._itemUseData) do
		local _count = ItemModel.instance:getItemCountByItemId(_itemId)

		self._itemUseData[_itemId].hasAddCount = 0
		self._itemUseData[_itemId].itemCount = _count
	end

	self:_refreshLoopLst()

	self._txtAddLv.text = nil

	self._costCell:setCostCount(0)
	goutil.setActive(self._goCostRoot, false)
	RectTransformUtils.ForceRebuildLayoutImmediate(self._txtAddLv.transform)
	self:_checkFill()
end

function M:_playUpgradeFillFinish()
	self:_releaseExpTweener()
	self:_handleGainItemAdd()
	self:_prepareData()
	self:_refreshView()

	local heroData = self:getHeroData()

	if heroData:getLevel() > self._heroDataWhenUpgrade.level then
		ViewMgr.instance:open(ViewName.CharacterUpgradeResultTips, self._heroDataWhenUpgrade, heroData)
		CriwareAudioFacade.instance:playVoiceByAudioId(CharacterInfoEnum.VoiceResKey.shengji, heroData:getId())
	end

	self._heroDataWhenUpgrade = nil
end

function M:_checkFill()
	local data = self._fillAniData
	local duration = data.stepTime

	if data.curLv == data.targetLv then
		if data.curExp ~= data.targetExp then
			local endVal = data.targetExp / self:getLvNeedExp(data.curLv)

			self:_fillExpTween(true, endVal, duration, self._playUpgradeFillFinish, self)
		else
			self:_playUpgradeFillFinish()
		end
	else
		local endVal = 1

		self:_fillExpTween(true, endVal, duration, self._onExpFillUpFinish, self)
	end
end

function M:_onExpFillUpFinish()
	self._fillAniData.curLv = self._fillAniData.curLv + 1
	self._fillAniData.curExp = 0
	self._txtPreLv.text = self._fillAniData.curLv
	self._imgExpBar.fillAmount = 0
	self._imgExpAdd.fillAmount = 0

	local needExp = self:getLvNeedExp(self._fillAniData.curLv)
	local curExp = 0

	self._txtExp.text = string.format("%s/%s", curExp, needExp)

	self:_checkFill()
end

function M:_fillExpTween(play, fillAmount, duration, finishCB, finishCBHandler)
	self:_releaseExpTweener()

	if play then
		self._expTweener = TweenNumberUtils.FloatToWithGetter(fillAmount, duration, self._getExpFillAmount, self._setExpFillAmount, self):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(function()
			if finishCB then
				if finishCBHandler then
					finishCB(finishCBHandler)
				else
					finishCB()
				end
			end
		end, self)
	end
end

function M:_releaseExpTweener()
	if self._expTweener then
		self._expTweener:Kill(false)
	end

	self._expTweener = nil
end

function M:_getExpFillAmount()
	return self._imgExpBar.fillAmount
end

function M:_setExpFillAmount(val)
	local data = self._fillAniData

	self._imgExpBar.fillAmount = val

	local needExp = self:getLvNeedExp(data.curLv)
	local curExp = math.floor(needExp * val)

	self._fillAniData.curExp = curExp
	self._txtExp.text = string.format("%s/%s", curExp, needExp)
end

return M
