-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/componentNew/EquipChangeDetailInfoComponentNew.lua

module("logic.extensions.charactersystem.view.equip.componentNew.EquipChangeDetailInfoComponentNew", package.seeall)

local M = class("EquipChangeDetailInfoComponentNew", EquipDetailInfoComponentNew)

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)

	self:_buildUI()

	self._wearPoint = goutil.findChild(self._btnWear.gameObject, "red_point")
	self._hideOnEmpty1 = goutil.findChild(self._mainGo, "node/top")
	self._hideOnEmpty2 = goutil.findChild(self._mainGo, "node/scroll")
end

function M:bindEvents()
	M.super.bindEvents(self)
	self._btnIntensify:AddClickListener(self._onClickDetail, self)
	self._btnWear:AddClickListener(self._onClickWear, self)
	self._btnExchange:AddClickListener(self._onClickWear, self)
	self._btnDisboard:AddClickListener(self._onClickDisboard, self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
	self._btnIntensify:RemoveClickListener()
	self._btnWear:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnDisboard:RemoveClickListener()
end

function M:openSuitAni()
	self._suitAni:Stop()
end

function M:checkSuitAni()
	self._suitAni:Stop()
end

function M:checkSuitAniOnWeard()
	self._suitAni:Stop()

	if self._curHeroEquips and self._curHeroEquips:getAvailableSuitId() then
		self._suitAni:Play("suit_jihuo")
	end
end

function M:setHeroAndPart(hero, part)
	self._heroData = hero
	self._heroId = hero:getId()
	self._curHeroEquips = hero:getHeroEquipData()
	self._curPart = part

	RedDotModel.instance:createDotView({
		dotNode = self._wearPoint,
		keyList = {
			string.format("%s_%s", RedDotType.ERedDotKey.EQUIPMENT, self._curPart)
		}
	})
end

function M:setEquipData(equip)
	M.super.setEquipData(self, equip)

	if equip:getRedPointIsNew() then
		local itemid = equip:getUuid()
		local type = GameEnum.ItemTypeEnum.EquipItemType

		BackpackAgent.instance:sendremoveRedPointRequest(type, {
			itemid
		})
	end
end

function M:refreshView()
	M.super.refreshView(self)

	if self._equipMo then
		self:setEmpty(false)
		self._btnIntensify:setActive(true)
		self:_setIsWearing()
	else
		self:setEmpty(true)
	end
end

function M:_setIsWearing()
	if not self._equipMo then
		return
	end

	local curWearingEquip = self._curHeroEquips:getEquipByPart(self._curPart)

	if curWearingEquip then
		goutil.setActive(self._btnWear.gameObject, false)

		local isSame = curWearingEquip:getUuid() == self._equipMo:getUuid()

		goutil.setActive(self._btnDisboard.gameObject, isSame)
		goutil.setActive(self._btnExchange.gameObject, not isSame)
	else
		goutil.setActive(self._btnExchange.gameObject, false)
		goutil.setActive(self._btnDisboard.gameObject, false)
		goutil.setActive(self._btnWear.gameObject, true)
	end
end

function M:_onClickDetail()
	if not self._equipMo then
		return
	end

	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_jiaoshiqiqianghua, nil, nil, nil)
	EquipIntensifyModel.instance:setOperatingEquip(self._equipMo)
	ViewMgr.instance:open(ViewName.EquipIntensifyMainNew)
end

function M:_onClickDisboard()
	if not self._equipMo then
		return
	end

	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_jiaoshiqijiechu, nil, nil, nil)
	EquipmentAgent.instance:sendEquipTakeOffRequest({
		self._equipMo:getUuid()
	})
end

function M:_onClickWear()
	if not self._equipMo then
		return
	end

	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_jiaoshiqishiyong, nil, nil, nil)

	local function _doSentRequest()
		EquipmentAgent.instance:sendEquipWearRequest(self._heroId, {
			self._equipMo:getUuid()
		})
		CriwareAudioFacade.instance:playVoiceByAudioId(CharacterInfoEnum.VoiceResKey.xiedai, self._heroId)
	end

	if self._equipMo:getIsEquip() then
		local heroId = self._equipMo:getHeroId()
		local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)
		local dialog = Dialog.showWarnMessage(lang("tip_title"), string.format(lang("t_equip_beequip_continue"), heroData:getName()))

		dialog:setConfirmListener(_doSentRequest, self)
	else
		EquipController.instance:setNeedCheckIsSuit(true)
		_doSentRequest()
	end
end

function M:_refreshDiscard()
	if not self._equipMo then
		return
	end

	local isDiscard = self._equipMo:getIsDiscard()

	goutil.setActive(self._discardRootGo, isDiscard)
end

function M:setEmpty(empty)
	goutil.setActive(self._hideOnEmpty1, not empty)
	goutil.setActive(self._hideOnEmpty2, not empty)

	if empty then
		goutil.setActive(self._btnExchange.gameObject, empty)
		self._btnIntensify:setActive(empty)
		goutil.setActive(self._btnDisboard.gameObject, not empty)
		goutil.setActive(self._btnWear.gameObject, not empty)
		goutil.setActive(self._wearPoint, false)
	end

	local btnCanvas = self._btnExchange.gameObject:GetComponent(ComponentType.CanvasGroup)

	btnCanvas.alpha = empty and 0.2 or 1

	self._btnIntensify:setActiveState(not empty)
end

function M:_refreshSuitInfo()
	if not self._equipMo then
		return
	end

	local suitId = self._equipMo:getSuitId()

	if not suitId or suitId == 0 then
		goutil.setActive(self._txtSuitName.gameObject, false)
		goutil.setActive(self._txtSuitNum.gameObject, false)

		return
	end

	goutil.setActive(self._txtSuitName.gameObject, true)
	goutil.setActive(self._txtSuitNum.gameObject, true)

	local suitData = self._equipMo:getSuitData()
	local nowHeroEquip = self._heroData:getHeroEquipData()
	local num = nowHeroEquip:getEquipNumBySuitId(suitId)
	local isSuit = num >= 3
	local color = isSuit and "8AD7F0" or "858585"
	local name = suitData:getName()

	self._txtSuitName.text = string.format("<color=#%s>%s</color>", color, name)
	self._txtSuitNum.text = string.format("<color=#%s>%d/3</color>", color, num)

	goutil.setActive(self._suitNameImg1Go, isSuit)
	goutil.setActive(self._suitNameImg2Go, not isSuit)

	local isSuitPrew = nowHeroEquip:getPreviewSuitId(self._equipMo)
	local color = isSuitPrew and "8AD7F0" or "858585"

	self:_clearDescSuitAttr()

	local suitDescList = suitData:getSuit3DescList(self._heroData:getTags(false))

	for _, descAttr in ipairs(suitDescList) do
		local itemGo = goutil.clone(self._txtSuitAttrGo)

		itemGo:SetActive(true)

		local txtSuitAttribute = goutil.addComponentOnce(itemGo, UIComponentType.TMPText)

		if txtSuitAttribute then
			txtSuitAttribute.text = string.format("<color=#%s>%s</color>", color, descAttr)
		end

		local goBtnClick = UIComponentType.ButtonAdapter(goutil.findChild(itemGo, "click"))

		goBtnClick:AddClickListener(function()
			self:_onClickSuitAttributeDyn(itemGo)
		end, self)
		goutil.addChildToParent(itemGo, self._suitContentGo)
	end

	if isSuitPrew then
		self:openSuitAni()
	end
end

return M
