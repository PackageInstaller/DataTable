-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/petshow/AceteamstargodView.lua

module("logic.extensions.aceteam.view.petshow.AceteamstargodView", package.seeall)

local AceteamstargodView = class("AceteamstargodView", ViewComponent)
local TriggerTime = 0.5

function AceteamstargodView:ctor()
	AceteamstargodView.super.ctor(self)
end

function AceteamstargodView:unbindEvents()
	AceteamstargodView.super.unbindEvents(self)

	for i, v in ipairs(self._onkeyList) do
		local btnOneKey = goutil.findChild(v, "btnOneKey")

		GameUtil.rmClickHandler(btnOneKey)

		local customInput = UICustomInput.Get(v)

		customInput:RemoveListener()
	end

	for k, longPress in pairs(self._btnLongPressMap) do
		longPress:dispose()
	end
end

function AceteamstargodView:bindEvents()
	AceteamstargodView.super.bindEvents(self)

	for i, v in ipairs(self._onkeyList) do
		local btnOneKey = goutil.findChild(v, "btnOneKey")

		GameUtil.addClickHandler(btnOneKey, GameUtil.handler(self._onClickOneKey, self, i))

		local customInput = UICustomInput.Get(v)

		customInput:AddListener(self._onCustomInputCallback, self)
	end
end

function AceteamstargodView:buildUI()
	AceteamstargodView.super.buildUI(self)

	self.items = {}

	for i = 1, 4 do
		local cell = self:getGo("equipRoot_" .. i)

		table.insert(self.items, cell)
	end

	self.tablecell = self:getGo("tablecell")
	self.tableview = self:getGo("tableview")
	self.scrollList = ScrollerList.create(self.tableview, self.tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self._lineGoList = {}
	self._lineGo = self:getGo("tableview/Nego_Viewport/Nego_Content/lines/line")
	self._lineConGo = self:getGo("tableview/Nego_Viewport/Nego_Content/lines")
	self._txtPower = goutil.findChildTextComponent(self.mainGO, "power/txtPower")
	self._btnLongPressMap = {}
	self._onkeyList = {}

	for i = 1, 4 do
		local onekey = self:getGo("topOnekey/onekey_" .. i)

		table.insert(self._onkeyList, onekey)
		GameUtil.SetActive(onekey, false)
	end
end

function AceteamstargodView:onExit()
	AceteamstargodView.super.onExit(self)
	self.scrollList:dispose()

	for k, handler in pairs(self._slotEffectHandler) do
		if handler then
			UIEffectManager.instance:stopEffect(handler)
		end
	end

	self._slotEffectHandler = nil

	GlobalDispatcher:removeListener(GlobalNotify.PM_ACETEAM_GETINFO, self.onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_ACETEAM_PETCHANGE, self.onRefreshUI, self)
end

function AceteamstargodView:onEnter()
	AceteamstargodView.super.onEnter(self)

	self._slotEffectHandler = {}

	GlobalDispatcher:addListener(GlobalNotify.PM_ACETEAM_GETINFO, self.onRefreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_ACETEAM_PETCHANGE, self.onRefreshUI, self)
	self:_updateView()
end

function AceteamstargodView:onRefreshUI()
	self:_updateView()
end

function AceteamstargodView:_updateView()
	self.petMo = AceTeamModel.instance:getCurrPetMo()

	if self.petMo then
		self:_updateEquip()
	end
end

function AceteamstargodView:_getSlotDatasKV()
	local slotDatasKV = {}
	local petMo = self.petMo

	if petMo then
		local slotDatas = petMo:getStarGodPlusSlots()

		for i, v in ipairs(slotDatas) do
			slotDatasKV[v.slot] = v
		end
	end

	return slotDatasKV
end

function AceteamstargodView:_updateEquip()
	local slotDatasKV = self:_getSlotDatasKV()

	for i, cell in ipairs(self.items) do
		local item = goutil.findChild(cell, "cell")
		local iconGo = goutil.findChild(item, "icon")
		local effectGo = goutil.findChild(item, "effect")
		local raycast = goutil.findChild(item, "raycast")
		local btn = GameUtil.asBtn(item)
		local lockGo = goutil.findChild(item, "lock")
		local addGo = goutil.findChild(item, "add")
		local nameText = goutil.findChildTextComponent(item, "nameText")
		local lvText = goutil.findChildTextComponent(item, "lvText")
		local lockTip = goutil.findChildTextComponent(lockGo, "lockTip")
		local nameTextColorChange = nameText.gameObject:GetComponent(ComponentType.UITextColorChange)
		local redDotGo = goutil.findChild(item, "red_point")
		local btnChange = goutil.findChild(item, "btnChange")
		local btnStrengthen = goutil.findChild(item, "btnStrengthen")
		local progress = goutil.findChildImageComponent(item, "btnStrengthen/progress")

		GameUtil.SetActive(progress, false)

		local slotData = slotDatasKV[i]

		GameUtil.addClickHandler(btnChange, GameUtil.handler(self.onClickChange, self, slotData))

		if not self._btnLongPressMap[btnStrengthen] then
			local longPress = BtnLongPressHelper.New()

			self._btnLongPressMap[btnStrengthen] = self._btnLongPressMap[btnStrengthen]

			self._btnLongPressMap[btnStrengthen]:dispose()
			self._btnLongPressMap[btnStrengthen]:reInit(btnStrengthen)
			self._btnLongPressMap[btnStrengthen]:addClickHandler(GameUtil.handler(self.onClickStrengthen, self, slotData))
			self._btnLongPressMap[btnStrengthen]:addPressHandler(GameUtil.handler(self._onBtnPressStartInTakeOff, self, progress), GameUtil.handler(self._onBtnPressEndInTakeOff, self, progress), GameUtil.handler(self._onBtnPressUpdateInTakeOff, self, progress))
			self._btnLongPressMap[btnStrengthen]:onPressTimeHandler(TriggerTime, GameUtil.handler(self._onBtnPressUpdateTimeOverOnce, self, slotData, progress, i))

			local isLock = false
			local isEquip = true

			goutil.setActive(lockGo, isLock)
			goutil.setActive(addGo, not isEquip and not isLock)
			goutil.setActive(iconGo, isEquip)

			lockTip.text = ""

			goutil.setActive(effectGo, false)
			goutil.setActive(redDotGo, false)

			if isLock or not isEquip then
				lvText.text = ""
				nameText.text = ""
			else
				local lv = StargodplusModel.instance:getSlotLv(slotData.slot, slotData.exp)
				local cfg = StargodplusConfig.instance:getFillerCfg(slotData.fillerDefineId)
				local name = ""

				if cfg then
					if not cfg.quality then
						local quality = 0

						name = cfg.name or ""

						nameTextColorChange:SetState(quality)
						MaterialMgr.setIcon(iconGo, MatType.StarGodPlus, slotData.fillerDefineId)
						goutil.setActive(effectGo, quality >= 3)

						local handler = self._slotEffectHandler[i]

						if handler then
							UIEffectManager.instance:stopEffect(handler)
						end

						if handler then
							handler:setParent(effectGo.transform)
							handler:setScale(1)
							handler:setLocalPos(0, 0, 0)
						end

						self._slotEffectHandler[i] = handler
					end
				end

				nameText.text = name
				lvText.text = "Lv." .. lv
			end
		end
	end

	self:_updateAttr()
end

function AceteamstargodView:onClickChange(slotData)
	UIStateManager.instance:push(ViewName.ActstargodchangeView, slotData.slot)
end

function AceteamstargodView:_onBtnPressStartInTakeOff(progress)
	progress.fillAmount = 0

	GameUtil.SetActive(progress, true)
end

function AceteamstargodView:_onBtnPressEndInTakeOff(progress, pressTime)
	progress.fillAmount = 0

	GameUtil.SetActive(progress, false)
end

function AceteamstargodView:_onBtnPressUpdateInTakeOff(progress, deltaTime, pressTime)
	progress.fillAmount = Mathf.Min(pressTime / TriggerTime, 1)
end

function AceteamstargodView:_onBtnPressUpdateTimeOverOnce(slotData, progress, idx)
	progress.fillAmount = 0

	GameUtil.SetActive(progress, false)

	local list = AceTeamConfig.instance:getStargodCfgList()
	local lv = StargodplusModel.instance:getSlotLv(slotData.slot, slotData.exp)
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
		self._tempSlotData = slotData

		local onekey = self._onkeyList[idx]

		GameUtil.SetActive(onekey, true)

		if onekey then
			local txtOneKeyCost = goutil.findChildTextComponent(onekey, "txtOneKeyCost")
			local txtBtnOneKey = goutil.findChildTextComponent(onekey, "btnOneKey/txtBtnOneKey")

			txtOneKeyCost.text = langPara("消耗：%s/%s积分", costPoint, totalPoint)
			txtBtnOneKey.text = langPara("强化到%s级", lastV.level)
		end
	else
		TipsFacade.instance:openCommonTips(lang("aceteamstargodview__2"))
	end
end

function AceteamstargodView:_onCustomInputCallback(hover)
	if not hover then
		for i, v in ipairs(self._onkeyList) do
			GameUtil.SetActive(v, false)
		end
	end
end

function AceteamstargodView:_onClickOneKey(idx)
	local slotData = self._tempSlotData
	local petMo = AceTeamModel.instance:getCurrPetMo()
	local onekey = self._onkeyList[idx]

	GameUtil.SetActive(onekey, false)

	local lv = StargodplusModel.instance:getSlotLv(slotData.slot, slotData.exp)
	local costPoint = self._costPoint
	local lastV = self._lastV
	local content = langPara("aceteamstargodview__1", costPoint, lv, lastV.level)

	TipsFacade.instance:openPopupCostMatViewNew(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT, costPoint, content, function()
		AceTeamController.instance:sendStarGodLvlup(self.petMo.petId, slotData.slot, lastV.level)
	end)
end

function AceteamstargodView:onClickStrengthen(slotData)
	local list = AceTeamConfig.instance:getStargodCfgList()
	local lv = StargodplusModel.instance:getSlotLv(slotData.slot, slotData.exp)

	for i, v in ipairs(list) do
		if lv < v.level then
			local content = langPara("aceteamstargodview__1", v.point, lv, v.level)

			if list[i + 1] ~= nil then
				local obj = list[i + 1]

				content = content .. langPara("aceteamawakeview__5", v.level, obj.level, obj.point)
			end

			local key = "AceteamstargodView_TOG"

			if not GameUtil.getUserDayData(key) then
				local function funcTog()
					GameUtil.saveUserDayData(key, true)
					AceTeamController.instance:sendStarGodLvlup(self.petMo.petId, slotData.slot)
				end

				local togText = lang("今日不再提示")

				TipsFacade.instance:openPopupWindowWithTog(lang("tip"), content, function()
					AceTeamController.instance:sendStarGodLvlup(self.petMo.petId, slotData.slot)
				end, function()
					return
				end, funcTog, nil, nil, togText, UnityEngine.TextAnchor.MiddleCenter)
			elseif MaterialModel.instance:getMaterialsNumber(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT) >= v.point then
				AceTeamController.instance:sendStarGodLvlup(self.petMo.petId, slotData.slot)
			else
				local na = MaterialMgr.getMaterialsName(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT)

				TipsFacade.instance:openCommonTips(langPara("%s数量不足，需要数量：%s", na, v.point))
			end

			return
		end
	end

	TipsFacade.instance:openCommonTips(lang("aceteamstargodview__2"))
end

function AceteamstargodView:_updateAttr()
	self._curViewDatas = StargodplusModel:getPetAttrsByPetMo(self.petMo) or {}

	local linesLen = math.ceil(#self._curViewDatas / 2)

	for i = 1, linesLen do
		local go = self._lineGoList[i]

		if not go then
			go = goutil.cloneAndSetParent(self._lineGo, self._lineConGo.transform)
			self._lineGoList[i] = go
		end

		goutil.setActive(go, true)
		GameUtil.setAnchoredPos(go, 0, -i * 40)
	end

	for i = linesLen + 1, #self._lineGoList do
		goutil.setActive(self._lineGoList[i], false)
	end

	local tempList = {}

	for i, v in ipairs(self._curViewDatas) do
		tempList[v.id] = v.value
	end

	self._txtPower.text = AttrMo.calcFightPowerByAttrs(tempList)

	self.scrollList:reloadData(self._curViewDatas)
end

function AceteamstargodView:_updateCell(view, cell, data, tag)
	local iconChange = goutil.findChild(cell.gameObject, "attr"):GetComponent(ComponentType.UIImageSpriteChange)
	local nameText = goutil.findChildTextComponent(cell.gameObject, "nameText")
	local valueText = goutil.findChildTextComponent(cell.gameObject, "valueText")
	local name, value = GameUtil.getPropertyInfo(data.id, data.value)

	iconChange:SetState(data.id - 1)

	valueText.text = value
	nameText.text = data.id == GameEnum.AttrType.OriginalVigour and name .. lang("aceteamstargodview__3") or name
end

function AceteamstargodView:clearCell(cell)
	return
end

return AceteamstargodView
