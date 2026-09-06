-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/petshow/AceteamequipView.lua

module("logic.extensions.aceteam.view.petshow.AceteamequipView", package.seeall)

local AceteamequipView = class("AceteamequipView", ViewComponent)
local TriggerTime = 0.5

function AceteamequipView:ctor()
	AceteamequipView.super.ctor(self)

	self.equipItemList = nil
	self.equipInfoList = nil
	self.decorationInfo = nil
	self.isRedPoint = false
end

function AceteamequipView:buildUI()
	AceteamequipView.super.buildUI(self)

	local bgGo = self:getGo("viewBgGo")
	local equipAllGo = goutil.findChild(bgGo, "equipAll")

	self.takeOffBtnGo = goutil.findChild(bgGo, "takeOffBtn")
	self.wearAllBtnGo = goutil.findChild(bgGo, "wearAllBtn")
	self.waRedPointGo = goutil.findChild(self.wearAllBtnGo, "waRedPoint")

	self.waRedPointGo:SetActive(false)

	self.allPowerGo = goutil.findChild(bgGo, "allPowerGo")
	self.powerTxt = goutil.findChildTextComponent(self.allPowerGo, "powerTxt")
	self.items = {}
	self.equipItemList = {}

	for index = 1, 6 do
		local go = self:getGo("viewBgGo/equipAll/equip_" .. index)

		table.insert(self.items, go)
	end

	self._btnLongPressMap = {}
	self._onkeyList = {}

	for i = 1, 4 do
		local onekey = self:getGo("viewBgGo/topOnekey/onekey_" .. i)

		table.insert(self._onkeyList, onekey)
		GameUtil.SetActive(onekey, false)
	end
end

function AceteamequipView:bindEvents()
	AceteamequipView.super.bindEvents(self)
	GameUtil.asBtn(self.takeOffBtnGo):AddClickListener(self.OnClickTakeoffBtn, self)
	GameUtil.asBtn(self.wearAllBtnGo):AddClickListener(self.OnClickWearAllBtn, self)

	for i, v in ipairs(self._onkeyList) do
		local btnOneKey = goutil.findChild(v, "btnOneKey")

		GameUtil.addClickHandler(btnOneKey, GameUtil.handler(self._onClickOneKey, self, i))

		local customInput = UICustomInput.Get(v)

		customInput:AddListener(self._onCustomInputCallback, self)
	end

	for k, longPress in pairs(self._btnLongPressMap) do
		longPress:dispose()
	end
end

function AceteamequipView:onEnter()
	AceteamequipView.super.onEnter(self)

	self.isRedPoint = false

	GlobalDispatcher:addListener(GlobalNotify.PM_ACETEAM_GETINFO, self.onRefreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_ACETEAM_PETCHANGE, self.onRefreshUI, self)
	self:onRefreshUI()
end

function AceteamequipView:unbindEvents()
	AceteamequipView.super.unbindEvents(self)
	GameUtil.asBtn(self.takeOffBtnGo):RemoveClickListener()
	GameUtil.asBtn(self.wearAllBtnGo):RemoveClickListener()

	for i, v in ipairs(self._onkeyList) do
		local btnOneKey = goutil.findChild(v, "btnOneKey")

		GameUtil.rmClickHandler(btnOneKey)

		local customInput = UICustomInput.Get(v)

		customInput:RemoveListener()
	end
end

function AceteamequipView:onExit()
	AceteamequipView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_ACETEAM_GETINFO, self.onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_ACETEAM_PETCHANGE, self.onRefreshUI, self)
end

function AceteamequipView:destroyUI()
	AceteamequipView.super.destroyUI(self)

	self.equipItemList = nil
	self.equipInfoList = nil
	self.decorationInfo = nil
end

function AceteamequipView:onRefreshUI()
	local petMo = AceTeamModel.instance:getCurrPetMo()
	local equipments = petMo.equipments

	self.powerTxt.text = FightingPowerFormula.instance:getEquipFightingPower(petMo.raceId, petMo.curFaceId, equipments)

	for i, cell in ipairs(self.items) do
		local stateSpt = goutil.findChild(cell, "stateSpt")
		local btnStrengthen = goutil.findChild(cell, "btnStrengthen")
		local progress = goutil.findChildImageComponent(cell, "btnStrengthen/progress")

		GameUtil.SetActive(progress, false)
		MaterialMgr.resetAll(cell)

		local equip = equipments[i]

		if equip then
			GameUtil.SetActive(stateSpt, false)
			GameUtil.SetActive(btnStrengthen, true)

			if not self._btnLongPressMap[btnStrengthen] then
				local longPress = BtnLongPressHelper.New()

				self._btnLongPressMap[btnStrengthen] = self._btnLongPressMap[btnStrengthen]

				self._btnLongPressMap[btnStrengthen]:dispose()
				self._btnLongPressMap[btnStrengthen]:reInit(btnStrengthen)
				self._btnLongPressMap[btnStrengthen]:addClickHandler(GameUtil.handler(self.onClickStrength, self, equip))
				self._btnLongPressMap[btnStrengthen]:addPressHandler(GameUtil.handler(self._onBtnPressStartInTakeOff, self, progress), GameUtil.handler(self._onBtnPressEndInTakeOff, self, progress), GameUtil.handler(self._onBtnPressUpdateInTakeOff, self, progress))
				self._btnLongPressMap[btnStrengthen]:onPressTimeHandler(TriggerTime, GameUtil.handler(self._onBtnPressUpdateTimeOverOnce, self, equip, progress, i))

				local proxy = MaterialMgr.setCell(MatType.Equipment, equip.defineId, cell)

				if proxy then
					proxy.binder:setLvl(equip.lv)
				end

				local petCfg = MaterialMgr.getMatCfg(MatType.Pet, petMo.raceId)
				local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petMo.curFaceId)
				local obj = AceTeamConfig.instance:getEquipCfg(firstJobIdx, equip.positionId, equip.levelExt + 1)

				GameUtil.SetActive(btnStrengthen, obj and obj.defineId > 0)
			end
		else
			GameUtil.SetActive(stateSpt, true)
			GameUtil.SetActive(btnStrengthen, false)
		end
	end
end

function AceteamequipView:_onBtnPressStartInTakeOff(progress)
	progress.fillAmount = 0

	GameUtil.SetActive(progress, true)
end

function AceteamequipView:_onBtnPressEndInTakeOff(progress, pressTime)
	GameUtil.SetActive(progress, false)
end

function AceteamequipView:_onBtnPressUpdateInTakeOff(progress, deltaTime, pressTime)
	progress.fillAmount = Mathf.Min(pressTime / TriggerTime, 1)
end

function AceteamequipView:_onBtnPressUpdateTimeOverOnce(equip, progress, idx)
	progress.fillAmount = 0

	GameUtil.SetActive(progress, false)

	local petMo = AceTeamModel.instance:getCurrPetMo()
	local petCfg = MaterialMgr.getMatCfg(MatType.Pet, petMo.raceId)
	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petMo.curFaceId)
	local list = AceTeamConfig.instance:getEquipPosCfgList(firstJobIdx, equip.positionId)
	local lv = equip.levelExt
	local totalPoint = MaterialModel.instance:getMaterialsNumber(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT)
	local costPoint = 0
	local lastV

	for i, v in ipairs(list) do
		if lv < v.level then
			if totalPoint >= costPoint + v.point then
				costPoint = costPoint + v.point
				lastV = v
			else
				break
			end
		end
	end

	if lastV then
		self._costPoint = costPoint
		self._lastV = lastV
		self._tempEquip = equip

		local onekey = self._onkeyList[idx]

		GameUtil.SetActive(onekey, true)

		if onekey then
			local txtOneKeyCost = goutil.findChildTextComponent(onekey, "txtOneKeyCost")
			local txtBtnOneKey = goutil.findChildTextComponent(onekey, "btnOneKey/txtBtnOneKey")

			txtOneKeyCost.text = langPara("消耗：%s/%s积分", costPoint, totalPoint)
			txtBtnOneKey.text = langPara("升到%s级", lastV.level)
		end
	else
		TipsFacade.instance:openCommonTips(lang("aceteamequipview__2"))
	end
end

function AceteamequipView:_onCustomInputCallback(hover)
	if not hover then
		for i, v in ipairs(self._onkeyList) do
			GameUtil.SetActive(v, false)
		end
	end
end

function AceteamequipView:_onClickOneKey(idx)
	local equip = self._tempEquip
	local petMo = AceTeamModel.instance:getCurrPetMo()
	local onekey = self._onkeyList[idx]

	GameUtil.SetActive(onekey, false)

	local lv = equip.levelExt
	local costPoint = self._costPoint
	local lastV = self._lastV
	local content = langPara("aceteamequipview__1", costPoint, lv, lastV.level)

	TipsFacade.instance:openPopupCostMatViewNew(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT, costPoint, content, function()
		AceTeamController.instance:sendEquipLvlup(petMo.petId, equip.positionId, lastV.level)
	end)
end

function AceteamequipView:onClickStrength(equip)
	print(">>>>>>>>>>> onClickStrength")

	local petMo = AceTeamModel.instance:getCurrPetMo()
	local petCfg = MaterialMgr.getMatCfg(MatType.Pet, petMo.raceId)
	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petMo.curFaceId)
	local list = AceTeamConfig.instance:getEquipPosCfgList(firstJobIdx, equip.positionId)
	local lv = equip.levelExt

	for i, v in ipairs(list) do
		if lv < v.level then
			local content = langPara("aceteamequipview__1", v.point, lv, v.level)

			if list[i + 1] ~= nil then
				local obj = list[i + 1]

				content = content .. langPara("aceteamawakeview__5", v.level, obj.level, obj.point)
			end

			local key = "AceteamequipView_TOG"

			if not GameUtil.getUserDayData(key) then
				local function funcTog()
					GameUtil.saveUserDayData(key, true)
					AceTeamController.instance:sendEquipLvlup(petMo.petId, equip.positionId)
				end

				local togText = lang("今日不再提示")

				TipsFacade.instance:openPopupWindowWithTog(lang("tip"), content, function()
					AceTeamController.instance:sendEquipLvlup(petMo.petId, equip.positionId)
				end, function()
					return
				end, funcTog, nil, nil, togText, UnityEngine.TextAnchor.MiddleCenter)
			elseif MaterialModel.instance:getMaterialsNumber(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT) >= v.point then
				AceTeamController.instance:sendEquipLvlup(petMo.petId, equip.positionId)
			else
				local na = MaterialMgr.getMaterialsName(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT)

				TipsFacade.instance:openCommonTips(langPara("%s数量不足，需要数量：%s", na, v.point))
			end

			return
		end
	end

	TipsFacade.instance:openCommonTips(lang("aceteamequipview__2"))
end

function AceteamequipView:OnClickTakeoffBtn()
	return
end

function AceteamequipView:OnClickWearAllBtn()
	return
end

return AceteamequipView
