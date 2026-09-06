-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/petshow/AceteamHolyStripeTipView.lua

module("logic.extensions.aceteam.view.petshow.AceteamHolyStripeTipView", package.seeall)

local AceteamHolyStripeTipView = class("AceteamHolyStripeTipView", ViewComponent)
local TriggerTime = 0.5

function AceteamHolyStripeTipView:ctor()
	AceteamHolyStripeTipView.super.ctor(self)
end

function AceteamHolyStripeTipView:buildUI()
	AceteamHolyStripeTipView.super.buildUI(self)

	self._Nego_Content = goutil.findChild(self.mainGO, "content")
	self._adjustPosition = self._Nego_Content:GetComponent("UIAdjustPosition")
	self._customInput = UICustomInput.Get(self._Nego_Content)
	self._Mask = self:getGo("Mask")
	self._topAttr = self:getGo("content/top/attr")
	self._topIcon = self:getGo("content/top/item")
	self._itemName = self:getTxt("content/top/txtName")
	self._itemPos = self:getTxt("content/top/txtPos")
	self._isEquip = self:getGo("content/top/showSignGo")
	self._titleCell = self:getGo("content/info/txtBase")
	self._attrCell = self:getGo("content/info/cuilingItem")
	self._attrsGo = self:getGo("content/info/attrs")
	self._attrScrollerList = ScrollerList.create(self._attrsGo, {
		self._titleCell,
		self._attrCell
	}, GameUtil.handler(self._updateAttrCell, self), GameUtil.handler(self._clearAttrCell, self))
	self._suitDesc = self:getTxt("content/info/suitDesc/Viewport/txt")
	self._suitCell = self:getGo("content/info/suititem")
	self._suitGo = self:getGo("content/info/suitDesc")
	self._suitScrollerList = ScrollerList.create(self._suitGo, self._suitCell, GameUtil.handler(self._upadateSuitCell, self), GameUtil.handler(self._clearSuitCell, self))
	self._strengthenBtn = self:getBtn("content/btnStrengthen")
	self._strengthenTipTxt = self:getTxt("content/btnStrengthen/tip/txtNum")
	self._strengthenTipImg = self:getGo("content/btnStrengthen/tip/img")
	self._btnOneKey = self:getGo("content/btnOneKey")
	self._progress = self:getImg("content/btnStrengthen/progress")

	GameUtil.SetActive(self._progress, false)
end

function AceteamHolyStripeTipView:bindEvents()
	AceteamHolyStripeTipView.super.bindEvents(self)
	self._strengthenBtn:AddClickListener(self._onClickStrengthenBtn, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onBtnPressUpdateTimeOverOnce, self)
	GameUtil.addClickHandler(self._Mask, self.close, self)
end

function AceteamHolyStripeTipView:unbindEvents()
	AceteamHolyStripeTipView.super.unbindEvents(self)
	self._strengthenBtn:RemoveClickListener()
	self._customInput:RemoveListener()
	GameUtil.rmClickHandler(self._btnOneKey)
	GameUtil.rmClickHandler(self._Mask)
end

function AceteamHolyStripeTipView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.PM_ACETEAM_HOLYSTRIPE_LEVELUP, self._PM_AceTeamHolyStripeLevelUpRes, self)

	local params = self:getOpenParam()

	self._positionId = checknumber(params[1])
	self._level = checknumber(params[2])
	self._suitId = checknumber(params[3])
	self._isHolyStripeEquip = params[4]

	self._attrScrollerList:regGetTagByIdx(GameUtil.handler(self._getCellTag, self))
	self:_refreshUI()
end

function AceteamHolyStripeTipView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.PM_ACETEAM_HOLYSTRIPE_LEVELUP, self._PM_AceTeamHolyStripeLevelUpRes, self)
	AceteamHolyStripeTipView.super.onExit()
	MaterialMgr.resetAll(self._topIcon)
	MaterialMgr.resetAll(self._strengthenTipImg)
	self._attrScrollerList:dispose()
	self._suitScrollerList:dispose()
end

function AceteamHolyStripeTipView:_refreshUI()
	self._holyStripeSuitCfg = AceTeamConfig.instance:getHolyStripeSuitCfg(self._suitId)
	self._holyStripeCfg = HolyStripeConfig.instance:getHolyStripeCfg(self._holyStripeSuitCfg.cfgIds[self._positionId])

	if self._level == 0 then
		self._level = 1
	end

	self._holyStripeAttrCfg = AceTeamConfig.instance:getHolyStripeCfg(self._positionId, self._level)

	if self._holyStripeCfg == nil then
		self:close()

		return
	end

	self:_refreshTop()
	self:_refreshAttr()
	self:_refreshSuit()
	self:_refreshBtn()
end

function AceteamHolyStripeTipView:_refreshTop()
	local _, color
	local var_8_0, var_8_1 = PetEquipController.instance:GetQualityStrByNum(self._holyStripeCfg.quality)

	_ = var_8_0
	self._itemName.text = langPara("<color=%s>%s</color>%s", var_8_1, self._holyStripeCfg.name, (self._holyStripeAttrCfg.showLevel > 0 or nil) and "+" .. self._holyStripeAttrCfg.showLevel)
	self._itemPos.text = langPara("部位：%d号位", self._holyStripeCfg.positionType)

	MaterialMgr.resetAll(self._topIcon)

	local proxy = MaterialMgr.setCellByCfg("24:" .. self._holyStripeCfg.id, self._topIcon)

	if proxy then
		proxy.binder:setNumStr("")
	end

	goutil.setActive(self._isEquip, self._isHolyStripeEquip or false)
end

function AceteamHolyStripeTipView:_refreshAttr()
	local attrs = {}

	table.insert(attrs, {
		tag = "title",
		type = 1
	})

	local baseArrtCfg = AceTeamConfig.instance:getHolyStripeCfg(self._positionId, 1)
	local mainBaseAttrParams = string.split(baseArrtCfg.mianAttrDesc, "#")
	local mainAttrParams = string.split(self._holyStripeAttrCfg.mianAttrDesc, "#")

	for i, v in ipairs(mainAttrParams) do
		table.insert(attrs, {
			tag = "attr",
			type = 1,
			attr = v,
			attrIdx = i,
			baseAttr = mainBaseAttrParams[i]
		})
	end

	table.insert(attrs, {
		tag = "title",
		type = 2
	})

	local subAttrParmas = string.split(self._holyStripeAttrCfg.subAttrDesc, "#")

	for i, v in ipairs(subAttrParmas) do
		table.insert(attrs, {
			tag = "attr",
			type = 2,
			attr = v,
			attrIdx = i
		})
	end

	local locklist = HolyStripeConfig.instance:getUnlockLvs()
	local lockIdx = #subAttrParmas + 1

	for i = 1, #locklist do
		if self._holyStripeAttrCfg.showLevel < checknumber(locklist[i]) then
			table.insert(attrs, {
				tag = "lock",
				type = 3,
				attrIdx = lockIdx,
				unlockLv = locklist[i]
			})

			lockIdx = lockIdx + 1
		end
	end

	local nextCfg = AceTeamConfig.instance:getHolyStripeCfg(self._positionId, self._level + 1)

	if nextCfg ~= nil then
		-- block empty
	end

	self._attrScrollerList:reloadData(attrs)
end

function AceteamHolyStripeTipView:_refreshSuit()
	local suitCfg = HolyStripeConfig.instance:getSuitCfgBySuitType(self._holyStripeCfg.suitType)
	local suitEffect = {}

	for i, v in ipairs(suitCfg) do
		if v.num == 4 then
			table.insert(suitEffect, {
				num = v.num,
				doc = v.doc
			})
		end
	end

	self._suitScrollerList:reloadData(suitEffect)

	self._suitDesc.text = self._holyStripeSuitCfg.suitDesc
end

function AceteamHolyStripeTipView:_refreshBtn()
	MaterialMgr.resetAll(self._strengthenTipImg)
	MaterialMgr.setIcon(self._strengthenTipImg, MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT)

	local nextAttrCfg = AceTeamConfig.instance:getHolyStripeCfg(self._positionId, self._level + 1)

	if nextAttrCfg then
		self._strengthenTipTxt.text = nextAttrCfg.point

		GameUtil.SetActive(self._strengthenBtn, true)
		GameUtil.SetActive(self._btnOneKey, true)
	else
		GameUtil.SetActive(self._strengthenBtn, false)
		GameUtil.SetActive(self._btnOneKey, false)
	end
end

function AceteamHolyStripeTipView:_updateAttrCell(view, cell, data, tag)
	local go = cell.gameObject

	if tag == 1 then
		local titleTxt = go:GetComponent(goutil.Type_UIText)

		titleTxt.text = data.type == 1 and "基础属性" or "淬灵属性"
	else
		local propertyNameTxt = goutil.findChildTextComponent(go, "txtName")
		local propertyVal = goutil.findChildTextComponent(go, "txtNum")
		local propertyIcon = goutil.findChildComponent(go, "attr", "UIImageSpriteChange")
		local colorChange = go:GetComponent("UIImageColorChange")
		local lockGo = goutil.findChild(go, "lock")
		local lockTxt = goutil.findChildTextComponent(go, "lock/txtDesc")

		if colorChange then
			colorChange:SetState((data.attrIdx - 1) % 2)
		end

		if data.type == 3 and data.unlockLv then
			GameUtil.SetActive(propertyNameTxt, false)
			GameUtil.SetActive(propertyVal, false)
			GameUtil.SetActive(propertyIcon, false)
			GameUtil.SetActive(lockGo, true)

			lockTxt.text = langPara("强化+%d解锁", data.unlockLv)

			return
		else
			GameUtil.SetActive(propertyNameTxt, true)
			GameUtil.SetActive(propertyVal, true)
			GameUtil.SetActive(propertyIcon, true)
			GameUtil.SetActive(lockGo, false)
		end

		local propertyName, attrVal

		propertyName, attrVal = FightingPowerFormula.instance:getAttrNameValue(data.attr)

		local propertyType = FightingPowerFormula.instance:getAttrTypeByName(propertyName)

		propertyNameTxt.text = propertyName

		propertyIcon:SetState(propertyType - 1)

		local exProperty = ""

		if data.type == 1 and not string.nilorempty(data.baseAttr) then
			local _, baseVal = FightingPowerFormula.instance:getAttrNameValue(data.baseAttr)

			if baseVal < attrVal then
				local dif = attrVal - baseVal

				exProperty = dif > 0 and dif < 1 and langPara("<color=#33B56FFF>(+%s%%)</color>", dif * 100) or langPara("<color=#33B56FFF>(+%s)</color>", dif)
				attrVal = baseVal
			end
		end

		propertyVal.text = attrVal > 0 and attrVal < 1 and langPara("%s%%", attrVal * 100) .. exProperty or langPara("%s", attrVal) .. exProperty
	end
end

function AceteamHolyStripeTipView:_clearAttrCell(cell)
	return
end

function AceteamHolyStripeTipView:_getCellTag(data, idx)
	if data.tag == "title" then
		return 1
	else
		return 2
	end

	return 1
end

function AceteamHolyStripeTipView:_upadateSuitCell(view, cell, data, tag)
	local go = cell.gameObject
	local suitType = goutil.findChildTextComponent(go, "suitType")
	local doc = goutil.findChildTextComponent(go, "doc")

	suitType.text = langPara("%d件：", data.num)
	doc.text = data.doc
end

function AceteamHolyStripeTipView:_clearSuitCell(cell)
	return
end

function AceteamHolyStripeTipView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

function AceteamHolyStripeTipView:_onBtnPressStartInTakeOff()
	self._progress.fillAmount = 0

	GameUtil.SetActive(self._progress, true)
end

function AceteamHolyStripeTipView:_onBtnPressEndInTakeOff(pressTime)
	GameUtil.SetActive(self._progress, false)
end

function AceteamHolyStripeTipView:_onBtnPressUpdateInTakeOff(deltaTime, pressTime)
	self._progress.fillAmount = Mathf.Min(pressTime / TriggerTime, 1)
end

function AceteamHolyStripeTipView:_onBtnPressUpdateTimeOverOnce(pressTime)
	local list = AceTeamConfig.instance:getHolyStripeListCfg(self._positionId)
	local lv = self._level
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
		local content = langPara("确认消耗<color=#C54949>%s</color>战队积分\n将灵纹由<color=#C54949>Lv%s</color>升级到<color=#C54949>Lv%s</color>吗？", costPoint, self._holyStripeAttrCfg.showLevel, lastV.showLevel)

		TipsFacade.instance:openPopupCostMatViewNew(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT, costPoint, content, function()
			local petMo = AceTeamModel.instance:getCurrPetMo()

			if petMo then
				local petId = petMo:getId()

				AceTeamController.instance:sendHolyStripeLvlup(petId, self._positionId, lastV.level)
			end
		end)
	else
		FloatWordMgr.instance:show(lang("不可升级~"))
	end
end

function AceteamHolyStripeTipView:_onClickStrengthenBtn()
	local nextAttrCfg = AceTeamConfig.instance:getHolyStripeCfg(self._positionId, self._level + 1)
	local nextNextAttrCfg = AceTeamConfig.instance:getHolyStripeCfg(self._positionId, self._level + 2)

	if nextAttrCfg then
		local petMo = AceTeamModel.instance:getCurrPetMo()
		local desc = langPara("确认消耗<color=#C54949>%s</color>战队积分\n将灵纹由<color=#C54949>Lv%s</color>升级到<color=#C54949>Lv%s</color>吗？", nextAttrCfg.point, self._holyStripeAttrCfg.showLevel, nextAttrCfg.showLevel)
		local togText = lang("今日不再提示")

		self._customInput:RemoveListener()

		local function func1()
			self:_sureStrengthen()
			self._customInput:AddListener(self._onCustomInputCallback, self)
		end

		local function funcTog()
			AceTeamModel.instance:setHolyStripeStrengthTip(true)
		end

		local function func2()
			self._customInput:AddListener(self._onCustomInputCallback, self)
		end

		if nextAttrCfg.point <= AceTeamModel.instance:getPointNum() then
			if AceTeamModel.instance:getHolyStripeStrengthTip() then
				func1()
			else
				TipsFacade.instance:openPopupWindowWithTog(lang("tip"), desc .. ((nextNextAttrCfg or nil) and langPara("\n下一次<color=#C54949>Lv%s</color>升级到<color=#C54949>Lv%s</color>需消耗<color=#C54949>%s</color>战队积分", nextAttrCfg.showLevel, nextNextAttrCfg.showLevel, nextNextAttrCfg.point)), func1, func2, funcTog, nil, nil, togText)
			end
		else
			self._customInput:AddListener(self._onCustomInputCallback, self)
			FloatWordMgr.instance:show(lang("战队积分不足"))
		end
	end
end

function AceteamHolyStripeTipView:_sureStrengthen()
	local petMo = AceTeamModel.instance:getCurrPetMo()

	if petMo then
		local petId = petMo:getId()

		AceTeamController.instance:sendHolyStripeLvlup(petId, self._positionId)
	end
end

function AceteamHolyStripeTipView:_PM_AceTeamHolyStripeLevelUpRes()
	TipsFacade.instance:openCommonTips(lang("灵纹升级成功"))

	self._level = self._level + 1

	self:_refreshUI()
end

return AceteamHolyStripeTipView
