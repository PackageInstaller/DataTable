-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/new/EchoItemMainSubViewDetailNode.lua

module("logic.extensions.charactersystem.view.carrier.new.EchoItemMainSubViewDetailNode", package.seeall)

local M = class("EchoItemMainSubViewDetailNode")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
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
	local registry = self:getRegistry()

	self._nodeRoot = registry:findUIElement("echo_view_copy_1484903821")
	self._txtName = registry:findUIElement("echo_view_copy_-616088668", UIComponentType.Text)
	self._imgIcon = registry:findUIElement("echo_view_copy_-854764670", UIComponentType.Image)
	self._animationIcon = registry:findUIElement("echo_view_copy_-854764670", ComponentType.Animation)
	self._goIconHeroRoot = registry:findUIElement("echo_view_copy_925539817")
	self._imgIconHero = registry:findUIElement("echo_view_copy_624943980", UIComponentType.Image)
	self._btnLock = UIComponentType.ButtonAdapter(registry:findUIElement("echo_view_copy_-201963580"))
	self._goMarkLock = registry:findUIElement("echo_view_copy_-803231024")
	self._goMarkUnLock = registry:findUIElement("echo_view_copy_-431260667")
	self._breakPointView = Astral.LuaComponentContainer.Add(goutil.findChild(self._nodeRoot, "node/scroll/view/content/content1/break_point").gameObject, EchoItemBreakPointView)
	self._baseAttrLst = {}

	table.insert(self._baseAttrLst, {
		root = registry:findUIElement("echo_view_copy_1657684133"),
		txtName = registry:findUIElement("echo_view_copy_1047902505", UIComponentType.Text),
		txtAttr = registry:findUIElement("echo_view_copy_1102185199", UIComponentType.Text)
	})
	table.insert(self._baseAttrLst, {
		root = registry:findUIElement("echo_view_copy_1855644399"),
		txtName = registry:findUIElement("echo_view_copy_1235435861", UIComponentType.Text),
		txtAttr = registry:findUIElement("echo_view_copy_805061494", UIComponentType.Text)
	})
	table.insert(self._baseAttrLst, {
		root = registry:findUIElement("echo_view_1068043504"),
		txtName = registry:findUIElement("echo_view_-64226074", UIComponentType.Text),
		txtAttr = registry:findUIElement("echo_view_-2096774438", UIComponentType.Text)
	})
	table.insert(self._baseAttrLst, {
		root = registry:findUIElement("echo_view_-866808734"),
		txtName = registry:findUIElement("echo_view_982091046", UIComponentType.Text),
		txtAttr = registry:findUIElement("echo_view_-1080947617", UIComponentType.Text)
	})

	self._descRootTrs = registry:findUIElement("echo_view_1653846132", UIComponentType.RectTransform)
	self._txtCareerFlag = registry:findUIElement("echo_view_655264976", UIComponentType.TextMeshProUGUI)
	self._txtCareer = registry:findUIElement("echo_view_-1282648195", UIComponentType.TextMeshProUGUI)
	self._btnDesc = UIComponentType.ButtonAdapter(registry:findUIElement("echo_view_copy_1093084892"))
	self._attributeRoot = registry:findUIElement("echo_view_copy_2035566952", UIComponentType.RectTransform)
	self._attrViewList = {}

	for i = 1, self._attributeRoot.childCount - 1 do
		local view = Astral.SimpleLuaComponentContainer.Add(self._attributeRoot:GetChild(i).gameObject, EchoItemBreakAttrViewNew)

		view:setIndex(i + 1)
		table.insert(self._attrViewList, view)
	end

	self._scroll = registry:findUIElement("echo_view_copy_-1009112133", UIComponentType.ScrollRect)
	self._goEchoBreakItemRoot = registry:findUIElement("echo_view_copy_1945030916")
	self._goEchoBreakItemBgAdd = goutil.findChild(self._goEchoBreakItemRoot, "imgAdd").gameObject
	self._btnEchoBreakItem = UIComponentType.ButtonAdapter(registry:findUIElement("echo_view_copy_1335323517"))

	local goEchoBreakItem = goutil.findChild(self._goEchoBreakItemRoot, "backpack_item").gameObject

	self._cellEchoBreakItemCost = Astral.SimpleLuaComponentContainer.Add(goEchoBreakItem, EchoItemSelectItemCellNew)
	self._txtEchoBreakNeedNum = self._cellEchoBreakItemCost:findUIElement("backpack_item_977509436", UIComponentType.Text)

	goutil.setActive(self._txtEchoBreakNeedNum.gameObject, true)

	self._btnDisboard = UIComponentType.ButtonAdapter(goutil.findChild(self._nodeRoot, "node/content3/btnDisboard"))
	self._btnChange = UIComponentType.ButtonAdapter(goutil.findChild(self._nodeRoot, "node/content3/btnChange"))
	self._txtBtnChange = goutil.findChildTextComponent(self._btnChange.gameObject, "normal/Text1")
	self._btnBreak = UIComponentType.ButtonAdapter(goutil.findChild(self._nodeRoot, "node/content3/btnBreak"))
	self._btnConfirmBreak = UIComponentType.ButtonAdapter(goutil.findChild(self._nodeRoot, "node/content3/btnConfirmBreak"))
	self._globalTouchTrigger = Astral.UIGlobalTouchTrigger.Get(self._btnEchoBreakItem.gameObject)
	self._goMask = registry:findUIElement("echo_view_copy_1839703911")
	self._goBreakCostRoot = goutil.findChild(self._nodeRoot, "node/content3/com_price").gameObject
	self._costCell = PrefabReferenceUtil.createCurrencyCostLuaCell(self._goBreakCostRoot)
	self._levelMaxGo = registry:findUIElement("echo_view_-1088047173")
end

function M:destroyUI()
	self._isEnter = nil

	self:setEvent(false)

	self._handler = nil
end

function M:bindEvents()
	self._btnLock:AddClickListener(self._onClickLock, self)
	self._btnEchoBreakItem:AddClickListener(self._onClickEchoBreakItem, self)
	self._btnDisboard:AddClickListener(self._onClickDisboard, self)
	self._btnChange:AddClickListener(self._onClickChange, self)
	self._btnBreak:AddClickListener(self._onClickChangeBreakPage, self)
	self._btnConfirmBreak:AddClickListener(self._onClickConfirmBreak, self)
	self._btnDesc:AddClickListener(self._onClickDesc, self)
	self._globalTouchTrigger:AddIgnoreTargetListener(self._onGlobalClick, self)
end

function M:unbindEvents()
	self._btnLock:RemoveClickListener()
	self._btnEchoBreakItem:RemoveClickListener()
	self._btnDisboard:RemoveClickListener()
	self._btnChange:RemoveClickListener()
	self._btnBreak:RemoveClickListener()
	self._btnConfirmBreak:RemoveClickListener()
	self._btnDesc:RemoveClickListener()
	self._globalTouchTrigger:RemoveIgnoreTargetListener()
end

function M:onEnter()
	self._isEnter = true

	self:setEvent(true)
end

function M:onExit()
	self._isEnter = false

	self:setEvent(false)
end

function M:setHandler(handler)
	self._handler = handler
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ECHO_ITEM_INFO_REFRESH, self._handleEchoItemInfoRefresh, self)
		GlobalDispatcher:addEventListener(EventType.ECHO_ITEM_ON_SET_SELECT, self._handleEchoItemOnSetSelect, self)
		GlobalDispatcher:addEventListener(EventType.ECHO_ITEM_COST_FOR_BREAK_SELECT, self._handleEchoCostForBreakSelect, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ECHO_ITEM_INFO_REFRESH, self._handleEchoItemInfoRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.ECHO_ITEM_ON_SET_SELECT, self._handleEchoItemOnSetSelect, self)
		GlobalDispatcher:removeEventListener(EventType.ECHO_ITEM_COST_FOR_BREAK_SELECT, self._handleEchoCostForBreakSelect, self)
	end
end

function M:_handleEchoItemInfoRefresh(e, isUpgrade)
	if not self._isEnter then
		return
	end

	if not EchoItemMainController.instance:getSelectedEchoItem() then
		return
	end

	self:refreshBaseInfo(false, isUpgrade)
	self:refreshBtnStatus()
	self:setVisible(true)
end

function M:_handleEchoItemOnSetSelect(e, echoItemData)
	if not self._isEnter then
		return
	end

	self:refreshBaseInfo()
	self:refreshBtnStatus()

	local visible = false

	if echoItemData then
		visible = true
	end

	self:setVisible(visible)
end

function M:_handleEchoCostForBreakSelect(e, echoItemDataList)
	if not self._isEnter then
		return
	end

	self:refreshBtnStatus()
	self:setVisible(true)
end

function M:setVisible(visible)
	goutil.setActive(self._nodeRoot, visible)
end

function M:_onClickLock()
	local echoItemData = EchoItemMainController.instance:getSelectedEchoItem()

	if not echoItemData then
		return
	end

	local uuid = echoItemData:getUuid()
	local isLock = echoItemData:getIsLock()
	local seId = CriwareAudioEnum.ui_shoumiren_canxiangsuoding

	CriwareAudioFacade.instance:playOnceSEbyId(seId, nil, nil, nil)

	if not isLock then
		EchoItemAgent.instance:sendLockEchoItemRequest(uuid, true)
	else
		local dialog = Dialog.showMessage(lang("tip_sure_unlock"), lang("tip_ask_unlock"))

		dialog:setConfirmListener(function()
			EchoItemAgent.instance:sendLockEchoItemRequest(uuid, false)
		end, self)
	end
end

function M:_onClickEchoBreakItem()
	if self:getPageType() ~= EchoItemMainViewNew.SubViewType.Break then
		if enableLog then
			printWarn("当前页面pageType不是break,不响应操作")
		end

		return
	end

	local echoItemData = EchoItemMainController.instance:getSelectedEchoItem()

	if not echoItemData then
		if enableLog then
			printWarn("未选择残响,不响应操作")
		end

		return
	end

	EchoItemMainController.instance:updateAvailableEchoItem()

	local echoLst = EchoItemMainController.instance:getAvailableEchoItem():getMoList()
	local count = echoLst and #echoLst or 0

	if count == 0 then
		ToolTipsMgr.showCharacterTopToast(lang("tip_echo_no_same_name_echo"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	GlobalDispatcher:dispatchEvent(EventType.ECHO_SET_BREAK_COST_LST_SHOW)
end

function M:_onClickDisboard()
	local echoItemData = EchoItemMainController.instance:getSelectedEchoItem()

	if not echoItemData then
		if enableLog then
			printWarn("未选择残响,不响应Disboard操作")
		end

		return
	end

	EchoItemAgent.instance:sendWearEchoItemRequest(echoItemData:getUuid(), 0)
end

function M:_onClickChange()
	local echoItemData = EchoItemMainController.instance:getSelectedEchoItem()

	if not echoItemData then
		if enableLog then
			printWarn("未选择残响,不响应Change操作")
		end

		return
	end

	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false

	if not heroData then
		if enableLog then
			printWarn("HeroDepotModel,无定位角色，不响应Change操作")
		end

		return
	end

	local career = echoItemData:getCareer()

	if career ~= 0 and career ~= heroData:getCareer() then
		ToolTipsMgr.showCharacterTopToast(langF("tip_echo_equip_fail_by_career_limit", heroData:getName()), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	local uuid = echoItemData:getUuid()

	local function confirmCallback()
		local heroId = heroData:getId()

		EchoItemAgent.instance:sendWearEchoItemRequest(uuid, heroId)
		CriwareAudioFacade.instance:playVoiceByAudioId(CharacterInfoEnum.VoiceResKey.xiedai, heroId)
	end

	if echoItemData:getHeroId() > 0 then
		local heroMO = HeroDepotModel.instance:getHeroInfoByID(echoItemData:getHeroId())
		local str = string.format(lang("tip_echo_has_equip"), heroMO:getName())
		local dialog = Dialog.showMessage(lang("tip_sure_equip_echo"), str)

		dialog:setConfirmListener(confirmCallback, self)
	else
		confirmCallback()
	end
end

function M:_onClickChangeBreakPage()
	local echoItemData = EchoItemMainController.instance:getSelectedEchoItem()

	if not echoItemData then
		if enableLog then
			printWarn("未选择残响,不响应Change操作")
		end

		return
	end

	if echoItemData:getIsMaxLevel() then
		ToolTipsMgr.showCharacterTopToast(lang("tip_max_not_break_through"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	GlobalDispatcher:dispatchEvent(EventType.ECHO_ITEM_MAIN_CHANGE_PAGE_REQ, EchoItemMainViewNew.SubViewType.Break)
end

function M:_onClickConfirmBreak()
	local curTime = os.clock()

	if self._clickTime and curTime - self._clickTime < 0.3 then
		return
	end

	self._clickTime = curTime

	if self:getPageType() ~= EchoItemMainViewNew.SubViewType.Break then
		if enableLog then
			printWarn("当前页面pageType不是break,不响应操作")
		end

		return
	end

	local echoItemData = EchoItemMainController.instance:getSelectedEchoItem()

	if not echoItemData then
		if enableLog then
			printWarn("未选择残响,不响应Change操作")
		end

		return
	end

	if echoItemData:getIsMaxLevel() then
		ToolTipsMgr.showCharacterTopToast(lang("tip_max_not_break_through"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	local cost = echoItemData:getCost()

	if not cost then
		printError(string.format("无法找到echoItemDataCost,id[%s] level[%s]", echoItemData:getId(), echoItemData:getLevel()))

		return
	end

	local code = cost.code
	local itemCo = BackpackConfig.instance:getItemInfoByItemId(code)
	local myCount = ItemModel.instance:getItemCountByItemId(code)

	if myCount < cost.count then
		ToolTipsMgr.showCharacterTopToast(string.format(lang("tip_num_not_enough"), itemCo.name), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	local lenCostForBreak = EchoItemMainController.instance:getCostEchoItemForBreakSelectedCount()
	local needCount = EchoItemConfig.instance:getUpgradeNeedCount(echoItemData:getLevel() + 1, echoItemData:getQuality())

	if lenCostForBreak == 0 then
		ToolTipsMgr.showCharacterTopToast(lang("tip_echo_break_fail_by_material_req"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	if lenCostForBreak < needCount then
		ToolTipsMgr.showCharacterTopToast(lang("tip_echo_break_cost_num_not_enough"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	local listInPreinstall = EchoItemMainController.instance:getCostEchoItemForBreakInPreinstallList()

	if #listInPreinstall > 0 then
		local temp = listInPreinstall

		ViewMgr.instance:open(ViewName.CharacterPreinstallNoticeView, 1, temp, self, lang("tip_character_preinstall_notice_break"))
	else
		self:_confirmCallbackPreinstall()
	end
end

function M:_confirmCallbackPreinstall()
	local echoItemData = EchoItemMainController.instance:getSelectedEchoItem()

	local function confirmCallback()
		local target = echoItemData:getUuid()
		local uuidList = EchoItemMainController.instance:getCostEchoItemForBreakUuidList()

		EchoItemAgent.instance:sendUpgradeEchoItemRequest(target, uuidList)
	end

	if EchoItemMainController.instance:getCostEchoItemForBreakIsHightLevel() then
		local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_echo_break_cost_is_highlevel_toast"))

		dialog:setConfirmListener(confirmCallback, self)
	else
		confirmCallback()
	end
end

function M:isOpenPrinstallNoticView(uuid)
	local temp = CharacterPreinstallController.instance:getItemList(uuid)

	if temp then
		return true
	end

	return false
end

function M:_onClickDesc()
	local echoItemData = EchoItemMainController.instance:getSelectedEchoItem()

	if not echoItemData then
		if enableLog then
			printWarn("未选择残响,不响应Change操作")
		end

		return
	end

	local skillEnhanceMO = echoItemData:getSkillEnhanceMO()
	local bindGo = self._btnDesc.gameObject
	local isPassEvent = true

	ToolTipsMgr.showSkillBuffTagSideTips(skillEnhanceMO, bindGo, isPassEvent)
end

function M:getPageType()
	return self._pageTyp
end

function M:onPageTypChange(typ)
	self._pageTyp = typ

	local needShow = typ == EchoItemMainViewNew.SubViewType.Change or typ == EchoItemMainViewNew.SubViewType.Break

	if not EchoItemController.instance:hasEchoCanEquip(false) and typ == EchoItemMainViewNew.SubViewType.Change and not EchoItemMainController.instance:getSelectedEchoItem() then
		if enableLog then
			printWarn("角色无可装备残响，隐藏右侧")
		end

		needShow = false
	end

	goutil.setActive(self._attributeRoot.gameObject, typ == EchoItemMainViewNew.SubViewType.Change)
	goutil.setActive(self._goEchoBreakItemRoot, typ == EchoItemMainViewNew.SubViewType.Break)

	self._scroll.verticalNormalizedPosition = typ == EchoItemMainViewNew.SubViewType.Break and 0 or 1

	local height = typ == EchoItemMainViewNew.SubViewType.Break and 308 or 472.5

	goutil.setHeight(self._scroll.transform, height)
	self:refreshBaseInfo()
	self:refreshBtnStatus()
	self:setVisible(needShow)

	if needShow then
		-- block empty
	end
end

function M:refreshBtnStatus()
	if self:getPageType() == EchoItemMainViewNew.SubViewType.Change then
		goutil.setActive(self._btnConfirmBreak.gameObject, false)
		goutil.setActive(self._goBreakCostRoot, false)
		goutil.setActive(self._btnBreak.gameObject, true)

		local curEquipEcho = EchoItemController.instance:getCurHeroEchoItem()
		local selectEquip = self:_isSameEcho(EchoItemMainController.instance:getSelectedEchoItem(), curEquipEcho)

		goutil.setActive(self._btnDisboard.gameObject, selectEquip)
		goutil.setActive(self._btnChange.gameObject, not selectEquip)

		self._txtBtnChange.text = curEquipEcho and lang("tip_echo_btn_replace") or lang("tip_echo_equip")

		goutil.setActive(self._levelMaxGo, false)
	elseif self:getPageType() == EchoItemMainViewNew.SubViewType.Break then
		local selectedItemData = EchoItemMainController.instance:getSelectedEchoItem()
		local isMaxLv = selectedItemData:getIsMaxLevel()
		local selectedCostNum = EchoItemMainController.instance:getCostEchoItemForBreakSelectedCount()
		local needCount = selectedItemData:getUpgradeNeedCount()
		local showCostItem = false

		if selectedCostNum > 0 then
			self._cellEchoBreakItemCost:updateData(ItemUtil.createItemData({
				itemId = selectedItemData:getItemId()
			}))
			self._cellEchoBreakItemCost:onSelect(false, self:getPageType())

			showCostItem = true
		end

		local costStr
		local cost = EchoItemMainController.instance:getSelectedEchoItem():getCost()

		if cost then
			self._costCell:updateData(cost.code)

			local myCount = ItemModel.instance:getItemCountByItemId(cost.code)

			costStr = myCount >= cost.count and cost.count or string.format("<color=#ff3e48>%s</color>", cost.count)
		end

		self._costCell:setCostCount(costStr)
		self._cellEchoBreakItemCost:setVisible(showCostItem)

		self._txtEchoBreakNeedNum.text = needCount <= selectedCostNum and string.format("%s/%s", selectedCostNum, needCount) or string.format("<color=#ff3e48>%s</color>/%s", selectedCostNum, needCount)

		goutil.setActive(self._btnConfirmBreak.gameObject, true)
		goutil.setActive(self._btnBreak.gameObject, false)
		goutil.setActive(self._btnDisboard.gameObject, false)
		goutil.setActive(self._btnChange.gameObject, false)
		goutil.setActive(self._btnEchoBreakItem.gameObject, not isMaxLv)
		goutil.setActive(self._btnConfirmBreak.gameObject, not isMaxLv)
		goutil.setActive(self._goBreakCostRoot, not isMaxLv)
		goutil.setActive(self._goEchoBreakItemBgAdd, not isMaxLv)
		goutil.setActive(self._levelMaxGo, isMaxLv)
	end
end

function M:refreshBaseInfo(showBreakPointUpgradeAnim, isUpgrade)
	local echoItemData = EchoItemMainController.instance:getSelectedEchoItem()

	if not echoItemData then
		return
	end

	if not showBreakPointUpgradeAnim and EchoItemMainController.instance:getIsUpgradingEcho() then
		if Astral.OSDef.isEditor then
			printWarn("正在升级残响，不刷新右侧面板显示", debug.traceback())
		end

		return
	end

	local isLock = echoItemData:getIsLock()
	local quality = echoItemData:getQuality()
	local career = echoItemData:getCareer()
	local heroId = echoItemData:getHeroId()
	local echoMaxLv = echoItemData:getMaxLevel()

	self._txtName.text = echoItemData:getName()

	IconLoader.setSprite(self._imgIcon, IconType.EchoItemIcon, echoItemData:getIcon())
	goutil.setActive(self._goMarkLock, isLock)
	goutil.setActive(self._goMarkUnLock, not isLock)

	if heroId > 0 then
		local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)
		local modelCO = heroMO and ModelConfig.instance:getModelConfig(heroMO:getModelId()) or nil

		if modelCO then
			IconLoader.setSprite(self._imgIconHero, IconType.RoleHeadIcon, modelCO.headIconName)
		end
	end

	goutil.setActive(self._goIconHeroRoot, heroId > 0)
	self._breakPointView:setEchoItemLevel(echoItemData:getLevel(), echoMaxLv)

	if showBreakPointUpgradeAnim then
		self._breakPointView:playUpgradeAnim(echoItemData:getLevel())
	else
		self._breakPointView:resetAnim(echoItemData:getLevel())
	end

	local attLst = echoItemData:getAttr()
	local attCount = #attLst

	for index, comps in ipairs(self._baseAttrLst) do
		local data = attLst[index]
		local show = data ~= nil

		if show then
			local cfg = AttributeDefineConfig.instance:getAttributePartDefineCO(data.id)

			comps.txtName.text = cfg and cfg.name or ""

			local offsetNumStr = data.num

			if data.num < 1 then
				offsetNumStr = string.format("+%s", data.num * 100) .. "%"
			end

			comps.txtAttr.text = offsetNumStr
		end

		goutil.setActive(comps.root, show)
	end

	local tagIds = HeroDepotModel.instance:getCurViewPageHeroTags()
	local skillEnhanceMO = echoItemData:getSkillEnhanceMO()
	local descStr = skillEnhanceMO and skillEnhanceMO:getDescriptionTagHighLight(tagIds) or ""
	local campIcon = CommEnum.Career2TmpResName[career] or ""
	local lines = string.split(descStr, "\n")

	self._txtCareerFlag.text = string.format("<size=24>%s</size>", campIcon)
	self._txtCareer.text = string.format("%s", CommEnum.Career2Name[career])

	goutil.setActive(self._txtCareerFlag.gameObject.transform.parent.gameObject, campIcon ~= "")
	goutil.setActive(self._descRootTrs.gameObject, descStr ~= "")

	if #lines > 0 then
		while self._descRootTrs.childCount - 1 < #lines do
			local textGo = goutil.cloneAndSetParent(self._descRootTrs:GetChild(1).gameObject, self._descRootTrs)

			textGo.transform:SetSiblingIndex(1)
		end

		for i = 1, self._descRootTrs.childCount - 1 do
			local go = self._descRootTrs:GetChild(i).gameObject
			local txtDesc = go:GetComponent(UIComponentType.TMPText)

			txtDesc.text = lines[i]

			goutil.setActive(go, i <= #lines)
		end
	end

	for index, attrView in ipairs(self._attrViewList) do
		local showLevel = index + 1
		local isBreak = showLevel <= echoItemData:getLevel()
		local colorAttr = false
		local colorSkill = false
		local descSplit = false
		local data = {
			echoItemId = echoItemData:getId(),
			level = echoItemData:getLevel(),
			descSplit = descSplit,
			desc = EchoItemConfig.instance:getAttrDesc(echoItemData:getId(), showLevel, colorAttr, colorSkill, descSplit, tagIds),
			itemData = echoItemData,
			showLevel = showLevel
		}

		attrView:setData(data, echoMaxLv)
	end

	if isUpgrade then
		local params = {}

		params.type = CommEnum.MultiFunctionDataType.EchoBreak
		params.data = {}
		params.data.echoItemData = echoItemData
		params.data.showAttrs = self._baseAttrLst
		params.data.changeAttrs = attLst

		ViewMgr.instance:open(ViewName.MultiFuntionView, params)
		TipsBlockController.instance:setBlockMark(TipsBlockUtil.BlockMark.EchoUpgrade, false)
	end
end

function M:_isSameEcho(echoDataA, echoDataB)
	if echoDataA == nil or echoDataB == nil then
		return false
	end

	return echoDataA:getUuid() == echoDataB:getUuid()
end

function M:_playIconAnimation(name)
	if string.nilorempty(name) then
		return
	end

	self._animationIcon:Stop()
	self._animationIcon:Play(name)
end

function M:_resetIconAnimation(name)
	self:_playIconAnimation(name)
	self._animationIcon:Stop()
	AnimationUtils.ResetToLastFrame(self._animationIcon)
end

function M:hideLock()
	goutil.setActive(self._btnLock.gameObject, false)
	goutil.setActive(self._goMarkLock, false)
	goutil.setActive(self._goMarkUnLock, false)
end

function M:_onGlobalClick(screenX, screenY)
	if not self._pos then
		self._pos = Vector3.New(screenX, screenY, 0)
	else
		self._pos:Set(screenX, screenY, 0)
	end

	local isInUI = GameUtils.isInUIRange(self._pos, self._btnConfirmBreak.transform)

	if self._btnConfirmBreak.gameObject.activeSelf and isInUI then
		self:_onClickConfirmBreak()
	end
end

return M
