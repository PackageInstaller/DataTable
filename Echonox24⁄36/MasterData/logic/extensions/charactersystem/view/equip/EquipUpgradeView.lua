-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipUpgradeView.lua

module("logic.extensions.charactersystem.view.equip.EquipUpgradeView", package.seeall)

local M = class("EquipUpgradeView", ViewComponent)

function M:buildUI()
	self._btnClose = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "universal_second_tips_common_bg/content/btnClose"))
	self._btnCancel = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "content/btnCancel"))
	self._btnConfirm = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "content/btnReset"))
	self.go_com_price = goutil.findChild(self.mainGO, "content/com_price").gameObject
	self._costCell = PrefabReferenceUtil.createCurrencyCostLuaCell(self.go_com_price)
	self._txtPreLv = self:getText("level_up_common_tips_1908741033")
	self._txtNextLv = self:getText("level_up_common_tips_1516035504")
	self._txtMaxLv = self:getText("level_up_common_tips_1990578856")
	self._txtAddExp = self:getText("level_up_common_tips_403238794")
	self._txtExp = self:getText("level_up_common_tips_1432980014")
	self._imgExpBar = self:getImage("level_up_common_tips_229089551")
	self._imgExpAdd = self:getImage("level_up_common_tips_678972865")
	self._btnLvMinus = self:getBtn("level_up_common_tips_-533860720")
	self._btnLvAdd = self:getBtn("level_up_common_tips_1589440179")
	self._sliderLv = UIComponentType.SliderAdapter(self:getGo("level_up_common_tips_434785636"))
	self._loopList = LoopListHelper.New(self:getGo("level_up_common_tips_-1170110971"))

	self._loopList:InitListView(0, self._onCellUpdate, self)

	self._btnSkill1Up = self:getBtn("3&btn_skill_bonus_280624854")
	self._btnSkill1Down = self:getBtn("3&btn_skill_bonus_-1720983089")
	self._btnSkill2Up = self:getBtn("4&btn_skill_bonus_280624854")
	self._btnSkill2Down = self:getBtn("4&btn_skill_bonus_-1720983089")

	goutil.setActive(self._btnSkill1Up.gameObject, AchievementModel.instance:isGetSkill(CommEnum.CharacterSkillType.Type2))
	goutil.setActive(self._btnSkill1Down.gameObject, false)
	goutil.setActive(self._btnSkill2Up.gameObject, false)
	goutil.setActive(self._btnSkill2Down.gameObject, false)
end

function M:destroyUI()
	self._loopList:Dispose()

	self._loopList = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	self._btnLvMinus:AddClickListener(self._onClickLvMinus, self)
	self._btnLvAdd:AddClickListener(self._onClickLvAdd, self)
	self._sliderLv:AddOnValueChanged(self._onLvSliderValChanged, self)
	self._btnSkill1Up:AddClickListener(self._onOpenSkillSmallTips1, self)
	GlobalDispatcher:addEventListener(EventType.EQUIP_LV_UP_SUCESS, self._onLvUp, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._btnLvMinus:RemoveClickListener()
	self._btnLvAdd:RemoveClickListener()
	self._sliderLv:RemoveOnValueChanged()
	self._btnSkill1Up:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.EQUIP_LV_UP_SUCESS, self._onLvUp, self)
end

function M:onEnter()
	self._equip = EquipIntensifyModel.instance:getOperatingEquip()
	self._itemIdConsume = EquipIntensifyModel.instance:getIntensityItemId()
	self._currencyId = GameEnum.CurrencyCodeEnum.LzbCode
	self._itemData = ItemUtil.createItemData({
		count = 0,
		itemId = self._itemIdConsume
	})
	self._lvMax = self._equip:getMaxLevel()
	self._sliderLv.slider.minValue = 0
	self._txtMaxLv.text = string.format("/%s MAX", self._lvMax)
	self._expCur, self._expMax = self._equip:getCurTotalExp()

	self._costCell:updateData(self._currencyId)
	self:_refreshItemData()
	self._sliderLv:SetValue(1)
	self:_refreshView()
end

function M:onExit()
	self._loopList:ClearCells()
end

function M:_refreshItemData()
	self._itemHas = ItemModel.instance:getItemCountByItemId(self._itemIdConsume)
	self._goldHas = ItemModel.instance:getItemCountByItemId(self._currencyId)
	self._lvCanUp = EquipIntensifyModel.instance:getEquipLvUpNum(self._equip, self._itemHas, self._goldHas)

	if self._lvCanUp > 0 then
		self._sliderLv.slider.interactable = true
		self._sliderLv.slider.maxValue = self._lvCanUp
	else
		self._sliderLv.slider.interactable = false
		self._sliderLv.slider.maxValue = 1
	end
end

function M:_onClickClose()
	self:close()
end

function M:_onLvUp()
	local oldEquip = EquipIntensifyModel.instance:getEquipBeforeUpdate()
	local newEquip = EquipIntensifyModel.instance:getOperatingEquip()
	local oldUnlockHoleCount = oldEquip:getUnlockHoleCount()
	local newUnlockHoleCount = newEquip:getUnlockHoleCount()

	if oldUnlockHoleCount < newUnlockHoleCount then
		ToolTipsMgr.showCharacterTopToast(lang("tip_equip_lv_suc_hole"), CommEnum.CharacterTopToastIcon.Succ, 1)
	else
		ToolTipsMgr.showCharacterTopToast(lang("tip_equip_lv_suc"), CommEnum.CharacterTopToastIcon.Succ, 1)
	end

	self:close()

	local params = {}

	params.type = CommEnum.MultiFunctionDataType.EquipStrengthen
	params.data = false

	ViewMgr.instance:open(ViewName.MultiFuntionView, params)
end

function M:_onClickConfirm()
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_jiaoshiqidengjitisheng, nil, nil, nil)

	if self._lvCanUp < 1 then
		ToolTipsMgr.showCharacterTopToast(lang("tip_equip_lv_item_less_new"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	if self._itemHas < self._itemNeed or self._goldHas < self._goldNeed then
		ToolTipsMgr.showCharacterTopToast(lang("tip_equip_lv_item_less"), CommEnum.CharacterTopToastIcon.Fail, 1)
	else
		local cost = {}

		cost[self._itemIdConsume] = self._itemNeed

		EquipIntensifyModel.instance:backupsEquip()
		EquipmentAgent.instance:sendEquipStrengthenRequest(self._equip:getUuid(), cost)
	end
end

function M:_onClickLvMinus()
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_mubiaodengji, nil, nil, nil)

	local lvUp = self._sliderLv:GetValue()

	if lvUp > 0 then
		self._sliderLv:SetValue(lvUp - 1)
	else
		ToolTipsMgr.showCharacterTopToast(lang("tip_min_get"), CommEnum.CharacterTopToastIcon.Fail, 1)
	end
end

function M:_onClickLvAdd()
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_mubiaodengji, nil, nil, nil)

	local lvUp = self._sliderLv:GetValue()

	if lvUp < self._sliderLv.slider.maxValue then
		self._sliderLv:SetValue(lvUp + 1)
	else
		ToolTipsMgr.showCharacterTopToast(lang("tip_max_get"), CommEnum.CharacterTopToastIcon.Fail, 1)
	end
end

function M:_onLvSliderValChanged(val)
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_mubiaodengji, nil, nil, nil)
	self:_refreshView()
end

function M:_refreshView()
	self:_refreshExpView()
	self:_refreshLoopLst()
end

function M:_refreshLoopLst()
	self._loopList:SetListItemCount(1, true)
	self._loopList:RefreshAllShownItem()
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local item = self._loopList:NewListViewItem("backpack_item_1")
	local shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, ItemCell)

	shower:updateData(self._itemData)
	shower:setShowTipsPassEvent(false)
	shower:setShowSelectedEffect(false)
	shower:getComponent("num"):setNumBgNodeVisible(false)

	local color = self._itemNeed > self._itemHas and "FF5C63" or "E4E4E4"

	shower:getComponent("num"):setCostTextActive(true)
	shower:getComponent("num"):setCostText(string.format("<color=#%s>%s</color>/%s", color, TextFormatter.formatNumber(self._itemHas), self._itemNeed))
	shower:getComponent("num"):setCountTextActive(false)

	return item
end

function M:_refreshExpView()
	local lvUp = self._sliderLv:GetValue()

	self._itemNeed, self._goldNeed, self._expAdd = EquipIntensifyModel.instance:getLvConsumeInfo(lvUp)

	local lv = self._equip:getLevel()

	self._txtPreLv.text = tostring(lv)
	self._txtNextLv.text = tostring(lv + lvUp)
	self._txtAddExp.text = string.format("+%s", self._expAdd)

	local color = self._goldNeed > self._goldHas and "FF5C63" or "E4E4E4"

	self._costCell:setCostCount(self._goldNeed, color)

	local expNextLv = self._equip:getLevelUpNeedExp(lv)
	local expEquip = self._equip:getCurrentExp()

	self._imgExpBar.fillAmount = expEquip / expNextLv
	self._imgExpAdd.fillAmount = lvUp > 0 and 1 or 0
	self._txtExp.text = string.format("%s/%s", expEquip, expNextLv)
end

function M:_onOpenSkillSmallTips1()
	local param = {}

	param.obj = self._btnSkill1Up.transform.parent.gameObject
	param.skillType = CommEnum.CharacterSkillType.Type2

	ViewMgr.instance:open(ViewName.AchievementSkillSmallTips, param)
end

return M
