-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/petshow/AceteampetskillView.lua

module("logic.extensions.aceteam.view.petshow.AceteampetskillView", package.seeall)

local AceteampetskillView = class("AceteampetskillView", ViewComponent)

AceteampetskillView.SKILL_TYPE_LEVEL = {
	"passiveSkillLv",
	"normalSkillLv",
	"ultimateSkillLv",
	nil,
	nil,
	"psychicedUltimateSkillLv",
	"psychicedNormalSkillLv"
}
AceteampetskillView.SKILL_ID = {
	"passiveSkillId",
	"normalSkillId",
	"ultSkillId",
	nil,
	nil,
	"psychicedUltSkillId",
	"psychicedNormalSkillId"
}

local SkillTypeCount = 9
local TriggerTime = 0.5

function AceteampetskillView:ctor()
	AceteampetskillView.super.ctor(self)
end

function AceteampetskillView:buildUI()
	AceteampetskillView.super.buildUI(self)

	self._stateHero = self:getGo("bom/stateHero")
	self._stateUpgrade = self:getGo("bom/stateUpgrade")
	self._stateMax = self:getGo("bom/stateMax")
	self._stateDomain = self:getGo("bom/stateDomain")
	self._statePsychiced = self:getGo("bom/statePsychiced")
	self._stateShenYao = self:getGo("bom/stateShenYao")
	self._tableGo = self:getGo("mid/tableview")
	self._itemGo = self:getGo("mid/tablecell")
	self._tableview = ScrollerList.create(self._tableGo, self._itemGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableview:regReloadFinish(GameUtil.handler(self.reloadFinish, self))
	self._tableview:regGetCellSize(GameUtil.handler(self._cellSize, self))

	self._txtSkillDetails = goutil.findChildTextComponent(self.mainGO, "mid/scrollSkillDetails/viewport/content/txtContent")
	self._goSkillDetails = self:getGo("mid/scrollSkillDetails")
	self._txtSkillHeroDetails = goutil.findChildTextComponent(self.mainGO, "mid/txtSkillHeroDetails")
	self._txtSkillDomainDetails = goutil.findChildTextComponent(self.mainGO, "mid/txtSkillDomainDetails")
	self._txtSkillPsychicedDetails = goutil.findChildTextComponent(self.mainGO, "mid/txtSkillPsychicedDetails")
	self._txtSkillDescDetails = goutil.findChildTextComponent(self.mainGO, "mid/txtSkillDescDetails")
	self._txtDetail = goutil.findChildTextComponent(self._itemGo, "anchor/txtDetail")
	self._itemSizeImmediate = goutil.findChildComponent(self._itemGo, "anchor/txtDetail", "ContentSizeImmediate")
	self.txtTip = self:getTxt("bom/stateUpgrade/txtTip")
	self.txtTipGo = self:getGo("bom/stateUpgrade/txtTip")
	self.txtTipIcon = self:getGo("bom/stateUpgrade/txtTip/icon")
	self._condition = self:getGo("bom/stateUpgrade/condition")
	self._txtCondition = goutil.findChildTextComponent(self.mainGO, "bom/stateUpgrade/condition/txt")
	self._consumeList = {}

	for i = 1, 3 do
		local single = {}

		single.go = self:getGo("bom/stateUpgrade/mats/" .. i)
		single.btn = self:getBtn("bom/stateUpgrade/mats/" .. i)
		single.txtNum = goutil.findChildTextComponent(single.go, "txtNum")
		single.itemPoint = goutil.findChild(single.go, "itemPoint")
		single.toGet = goutil.findChild(single.go, "img_add")
		single.rareIcon = goutil.findChild(single.go, "quality"):GetComponent("UIImageSpriteChange")

		table.insert(self._consumeList, single)
	end

	self._btnUpgrade = self:getBtn("bom/stateUpgrade/btn_uplv")
	self._progress = self:getImg("bom/stateUpgrade/btn_uplv/progress")
	self._btnLongPressHelper = BtnLongPressHelper.create(self._btnUpgrade)

	GameUtil.SetActive(self._progress, false)

	self._txtOneKeyCost = self:getTxt("onekey/txtOneKeyCost")
	self._txtBtnOneKey = self:getTxt("onekey/btnOneKey/txtBtnOneKey")
	self._btnOneKey = self:getGo("onekey/btnOneKey")
	self._onekey = self:getGo("onekey")

	GameUtil.SetActive(self._onekey, false)

	self._customInput = UICustomInput.Get(self._onekey)
	self._upgradeRedPoint = self:getGo("bom/stateUpgrade/btn_uplv/redPoint")

	self:_buildSkillItems()
end

function AceteampetskillView:_buildSkillItems()
	self._itemList = {}

	for i = 1, SkillTypeCount do
		local single = {}

		single.go = self:getGo("top/View/Viewport/Content/skills/item" .. i)
		single.txtName = self:getTxt("top/View/Viewport/Content/skills/item" .. i .. "/txtName")
		single.icon = self:getGo("top/View/Viewport/Content/skills/item" .. i .. "/icon")
		single.txtLevel = self:getTxt("top/View/Viewport/Content/skills/item" .. i .. "/txtLevel")
		single.select = self:getGo("top/View/Viewport/Content/skills/item" .. i .. "/select")
		single.btn = self:getBtn("top/View/Viewport/Content/skills/item" .. i)
		single.imgSkillType = goutil.findChild(single.go, "imgSkillType")
		single.redPoint = self:getGo("top/View/Viewport/Content/skills/item" .. i .. "/redPoint")

		table.insert(self._itemList, single)
	end

	self._skillItemsContent = self:getGo("top/View/Viewport/Content").transform
	self._skillItemsLayout = self:getGo("top/View/Viewport/Content/skills"):GetComponent(ComponentType.UILayoutSingleLine)
	self._skillItemsView = self:getGo("top/View"):GetComponent(ComponentType.ScrollRect)
end

function AceteampetskillView:bindEvents()
	AceteampetskillView.super.bindEvents(self)

	for i = 1, SkillTypeCount do
		self._itemList[i].btn:AddClickListener(function()
			self:_onClickSkill(i)
		end)
	end

	self._btnLongPressHelper:addClickHandler(GameUtil.handler(self._upgradeSkill, self))
	self._btnLongPressHelper:addPressHandler(GameUtil.handler(self._onBtnPressStartInTakeOff, self), GameUtil.handler(self._onBtnPressEndInTakeOff, self), GameUtil.handler(self._onBtnPressUpdateInTakeOff, self))
	self._btnLongPressHelper:onPressTimeHandler(TriggerTime, GameUtil.handler(self._onBtnPressUpdateTimeOverOnce, self))
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function AceteampetskillView:unbindEvents()
	AceteampetskillView.super.unbindEvents(self)

	for i = 1, 3 do
		self._consumeList[i].btn:RemoveClickListener()
	end

	for i = 1, SkillTypeCount do
		self._itemList[i].btn:RemoveClickListener()
	end

	self._btnUpgrade:RemoveClickListener()
	self._btnLongPressHelper:dispose()
	GameUtil.rmClickHandler(self._btnOneKey)
	self._customInput:RemoveListener()
end

function AceteampetskillView:destroyUI()
	AceteampetskillView.super.destroyUI(self)
end

function AceteampetskillView:onEnter()
	AceteampetskillView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_ACETEAM_GETINFO, self._refreshAll, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_ACETEAM_PETCHANGE, self._refreshAllAndResetPos, self)

	self._selectType = 3

	self:_refreshAll()
end

function AceteampetskillView:onEnterFinished()
	AceteampetskillView.super.onEnterFinished(self)
end

function AceteampetskillView:onExit()
	AceteampetskillView.super.onExit(self)

	for i = 1, 3 do
		MaterialMgr.resetAll(self._consumeList[i].itemPoint)
	end

	for i = 1, SkillTypeCount do
		MaterialMgr.resetAll(self._itemList[i].icon)
	end

	GlobalDispatcher:removeListener(GlobalNotify.PM_ACETEAM_GETINFO, self._refreshAll, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_ACETEAM_PETCHANGE, self._refreshAllAndResetPos, self)
	removetimer(self._finishLayout, self)
	self._tableview:dispose()
end

function AceteampetskillView:onExitFinished()
	AceteampetskillView.super.onExitFinished(self)
end

function AceteampetskillView:_cellSize(view, index)
	local height = self.heightList[index + 1]

	return 300, height
end

function AceteampetskillView:_recordHeight()
	goutil.setActive(self._itemGo, true)

	self.heightList = {}

	local mo = AceTeamModel.instance:getCurrPetMo()
	local scrollData = self:_getSkillLevelData(mo.curFaceId)

	for k, data in ipairs(scrollData) do
		self:_updateCell(nil, self._itemGo, data)

		local size = self._itemSizeImmediate:GetPreferredSize()

		table.insert(self.heightList, math.max(25, size.y + 19.5))
	end

	goutil.setActive(self._itemGo, false)
end

function AceteampetskillView:_getSkillLevelData(skinId, maxLevel)
	local scrollData = {}
	local skillInfocfg

	if self._selectType == 5 then
		local petCo = PetSkinConfig.instance:getPetSkinCfg(skinId)

		skillInfocfg = BattleConfig.instance:getDomainSkillLevels(petCo.domainSkillId)
	else
		skillInfocfg = CharacterConfig.instance:getSkillInfoById(skinId)
	end

	for k, v in pairs(skillInfocfg) do
		if maxLevel then
			if k <= maxLevel then
				table.insert(scrollData, v)
			end
		else
			table.insert(scrollData, v)
		end
	end

	table.sort(scrollData, function(a, b)
		return a.level < b.level
	end)

	return scrollData
end

function AceteampetskillView:_refreshAllAndResetPos()
	self:_refreshAll()

	self._skillItemsView.horizontalNormalizedPosition = 0
end

function AceteampetskillView:_refreshAll()
	self:_refreshSelectTab()
	self:_recordHeight()
	self:_refreshData()

	local num = -1
	local mo = AceTeamModel.instance:getCurrPetMo()
	local petCfg = MaterialMgr.getMatCfg(MatType.Pet, mo.raceId)
	local sid = petCfg.skillLevelStrategyId
	local list = AceTeamConfig.instance:getSkillCfgList(sid, self._selectType)
	local lv = self.curLevel

	for i, v in ipairs(list) do
		if lv >= v.skillLevel or v.petLevelLimit > mo.level then
			-- block empty
		else
			num = v.point

			break
		end
	end

	GameUtil.SetActive(self.txtTipGo, num > 0)

	self.txtTip.text = langPara("aceteamawakeview__10", num)

	MaterialMgr.setIcon(self.txtTipIcon, MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT)
end

function AceteampetskillView:_refreshSelectTab()
	local mo = AceTeamModel.instance:getCurrPetMo()
	local raceId = mo.raceId
	local petCo = CharacterConfig.instance:getPetCo(raceId)
	local skinCo = PetSkinConfig.instance:getPetSkinCfg(mo.curFaceId)

	self._skillIds = {}

	table.insert(self._skillIds, skinCo.passiveSkillId)
	table.insert(self._skillIds, skinCo.normalSkillId)
	table.insert(self._skillIds, skinCo.ultSkillId)
	table.insert(self._skillIds, skinCo.heroSkillId)
	table.insert(self._skillIds, skinCo.domainSkillId)
	table.insert(self._skillIds, skinCo.psychicedUltSkillId)
	table.insert(self._skillIds, skinCo.psychicedNormalSkillId)
	table.insert(self._skillIds, skinCo.psychicSkillId)
	table.insert(self._skillIds, skinCo.shenyaoSkillId)
	table.insert(self._skillIds, skinCo.carriedSkillId)
	table.insert(self._skillIds, skinCo.oracleSkillId)

	if self._selectType and self._skillIds[self._selectType] == 0 then
		for i = SkillTypeCount, 1, -1 do
			if self._skillIds[i] ~= 0 then
				self._selectType = i

				break
			end
		end
	end
end

function AceteampetskillView:_refreshData()
	local mo = AceTeamModel.instance:getCurrPetMo()

	self._petId = mo.petId

	local raceId = mo.raceId
	local petCo = CharacterConfig.instance:getPetCo(raceId)
	local petSkinCo = PetSkinConfig.instance:getPetSkinCfg(mo.curFaceId)
	local skillLevelStrategyId = petCo.skillLevelStrategyId

	if mo and petCo then
		local skillCount = 0

		for i = 1, SkillTypeCount do
			if self._skillIds[i] == 0 then
				self._itemList[i].go:SetActive(false)
			else
				skillCount = skillCount + 1

				self._itemList[i].go:SetActive(true)

				local proxy = MaterialMgr.setSkillByFaceId(self._skillIds[i], mo.curFaceId, self._itemList[i].icon)

				if proxy then
					proxy:setAutoTips(false)
				end

				local skillCfg = BattleConfig.instance:getSkillCo(self._skillIds[i])
				local level = checknumber(mo[AceteampetskillView.SKILL_TYPE_LEVEL[i]])

				if level == 0 then
					level = 1
				end

				self._itemList[i].txtName.text = skillCfg.name
				self._itemList[i].txtLevel.text = level

				goutil.setActive(self._itemList[i].select, i == self._selectType)

				local skicon = skillCfg.skillTopImg

				uGuiUtil.setSpriteToImage(self._itemList[i].imgSkillType.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getSkillIconUrl(skicon))
				goutil.setActive(self._itemList[i].redPoint, false)
			end
		end

		local skillInfocfg = CharacterConfig.instance:getSkillInfoById(mo.curFaceId)

		self.curLevel = mo[AceteampetskillView.SKILL_TYPE_LEVEL[self._selectType]] or 1

		if self.curLevel == 0 then
			self.curLevel = 1
		end

		local maxLevel = BagPetsController.instance:getPetSkillMaxLevel(mo.curFaceId, self._selectType)
		local state = self._selectType == 4 and 1 or self._selectType == 5 and 4 or self._selectType == 8 and 5 or self._selectType == 9 and 6 or self.curLevel and maxLevel > self.curLevel and 2 or 3

		goutil.setActive(self._tableGo, state ~= 1 and state ~= 5)
		goutil.setActive(self._stateHero, state == 1)
		goutil.setActive(self._stateUpgrade, state == 2)
		goutil.setActive(self._stateMax, state == 3)
		goutil.setActive(self._stateDomain, state == 4)
		goutil.setActive(self._statePsychiced, state == 5)
		goutil.setActive(self._stateShenYao, state == 6)

		if state ~= 1 and state ~= 4 and state ~= 5 and state ~= 6 then
			local skillInfocfg = CharacterConfig.instance:getSkillInfoById(mo.curFaceId)
			local skillLevelCfg = skillInfocfg[self.curLevel]
			local skillId = skillLevelCfg[AceteampetskillView.SKILL_ID[self._selectType]]
			local skillCo = BattleConfig.instance:getSkillCo(skillId)

			if skillCo then
				self._txtSkillDetails.text = skillCo.desc or ""
			end
		elseif state == 1 then
			local skillId = petSkinCo.heroSkillId
			local skillCo = BattleConfig.instance:getSkillCo(skillId)

			if skillCo then
				self._txtSkillHeroDetails.text = skillCo.desc or ""
			end
		elseif state == 5 then
			local skillId = petSkinCo.psychicSkillId
			local skillCo = BattleConfig.instance:getSkillCo(skillId)

			if skillCo then
				self._txtSkillPsychicedDetails.text = skillCo.desc or ""
			end
		elseif state == 4 then
			local skillId = petSkinCo.domainSkillId
			local skillCo = BattleConfig.instance:getSkillCo(skillId)

			if skillCo then
				self._txtSkillDomainDetails.text = skillCo.desc or ""
			end
		elseif state == 6 then
			local skillId = petSkinCo.shenyaoSkillId
			local skillCo = BattleConfig.instance:getSkillCo(skillId)

			if skillCo then
				self._txtSkillDescDetails.text = skillCo.desc or ""
			end
		end

		self._goSkillDetails.gameObject:SetActive(false)
		self._txtSkillHeroDetails.gameObject:SetActive(state == 1)
		self._txtSkillDomainDetails.gameObject:SetActive(state == 4)
		self._txtSkillPsychicedDetails.gameObject:SetActive(state == 5)
		self._txtSkillDescDetails.gameObject:SetActive(state == 6)

		if state ~= 1 and state ~= 5 then
			local scrollData = self:_getSkillLevelData(mo.curFaceId, maxLevel)

			self._tableview:reloadData(scrollData)
		end

		if state == 2 then
			local consumeCfg = CharacterConfig.instance:getSkillLevelStrategyById(skillLevelStrategyId, self._selectType, self.curLevel + 1)

			if consumeCfg then
				self._limitLevel = checknumber(consumeCfg.petLevelLimit)
				self._enoughLevel = mo.level >= self._limitLevel

				if self._limitLevel > 0 and not self._enoughLevel then
					self._txtCondition.text = langPara("aceteampetskillview__1", self._limitLevel)

					goutil.setActive(self._condition, true)
				else
					goutil.setActive(self._condition, false)
				end

				goutil.setActive(self._upgradeRedPoint, false)
			end
		end

		self:_updateSkillView(skillCount)
		self._skillItemsLayout:Layout()
	end
end

function AceteampetskillView:_updateSkillView(skillCount)
	if skillCount <= 3 then
		Framework.TransformUtil.SetAnchoredPos(self._skillItemsLayout.transform, 250, 34)

		self._skillItemsView.enabled = false
		self._skillItemsLayout.layoutOption = UILayoutSingleLine.LayoutOption.HorizontalCenter
	else
		Framework.TransformUtil.SetAnchoredPos(self._skillItemsLayout.transform, 80, 34)

		self._skillItemsView.enabled = true
		self._skillItemsLayout.layoutOption = UILayoutSingleLine.LayoutOption.LeftRight
	end

	local sizeDelta = self._skillItemsContent.sizeDelta

	sizeDelta.x = skillCount * self._skillItemsLayout.horizontalSpace + 30
	self._skillItemsContent.sizeDelta = sizeDelta
end

function AceteampetskillView:_refreshBottom()
	return
end

function AceteampetskillView:_updateCell(view, cell, data)
	if cell == nil then
		return
	end

	local go = cell.gameObject
	local txtLevel = goutil.findChildTextComponent(go, "anchor/txtLevel")
	local txtLevelColorChange = txtLevel:GetComponent(typeof(UITextColorChange))
	local txtDetail = goutil.findChildTextComponent(go, "anchor/txtDetail")
	local txtDetailColorChange = txtDetail:GetComponent(typeof(UITextColorChange))
	local mo = AceTeamModel.instance:getCurrPetMo()

	if self._selectType == 5 then
		local petCo = PetSkinConfig.instance:getPetSkinCfg(mo.curFaceId)
		local skillCfg = BattleConfig.instance:getSkillCo(petCo.domainSkillId)

		txtLevel.text = skillCfg.name .. GameUtil.toRomanNumber(data.level)
		txtDetail.text = data.desc

		if view then
			txtLevelColorChange:SetState(0)
			txtDetailColorChange:SetState(0)
		end
	else
		txtLevel.text = langPara("aceteampetskillview__2", data.level)

		local skillKey = AceteampetskillView.SKILL_ID[self._selectType]
		local skillId = data[skillKey]
		local cfg = BattleConfig.instance:getSkillCo(skillId, mo.curFaceId) or {}
		local des = cfg.desc

		if string.nilorempty(des) then
			des = "  "
		end

		txtDetail.text = langPara("%s", des)

		if view then
			txtLevelColorChange:SetState(cell.index < self.curLevel and 1 or 0)
			txtDetailColorChange:SetState(cell.index < self.curLevel and 1 or 0)
		end
	end

	if view then
		GameUtil.setHeight(go, self.heightList[cell.data])

		local line = goutil.findChild(go, "imgline")

		GameUtil.setLocalPos(line, 243, -self.heightList[cell.data], 0)
	end
end

function AceteampetskillView:_clearCell(cell)
	return
end

function AceteampetskillView:_onClickSkill(index)
	if index ~= checknumber(self._selectType) then
		self._selectType = index

		self:_refreshAll()
	end
end

function AceteampetskillView:_onBtnPressStartInTakeOff()
	self._progress.fillAmount = 0

	GameUtil.SetActive(self._progress, true)
end

function AceteampetskillView:_onBtnPressEndInTakeOff(pressTime)
	GameUtil.SetActive(self._progress, false)
end

function AceteampetskillView:_onBtnPressUpdateInTakeOff(deltaTime, pressTime)
	self._progress.fillAmount = Mathf.Min(pressTime / TriggerTime, 1)
end

function AceteampetskillView:_onBtnPressUpdateTimeOverOnce(pressTime)
	self._progress.fillAmount = 0

	GameUtil.SetActive(self._progress, false)

	local mo = AceTeamModel.instance:getCurrPetMo()
	local petCfg = MaterialMgr.getMatCfg(MatType.Pet, mo.raceId)
	local sid = petCfg.skillLevelStrategyId
	local list = AceTeamConfig.instance:getSkillCfgList(sid, self._selectType)
	local lv = self.curLevel
	local totalPoint = MaterialModel.instance:getMaterialsNumber(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT)
	local costPoint = 0
	local lastV, limitV

	for i, v in ipairs(list) do
		if lv < v.skillLevel then
			if v.petLevelLimit > mo.level then
				limitV = v

				break
			elseif totalPoint >= costPoint + v.point then
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

		GameUtil.SetActive(self._onekey, true)

		self._txtOneKeyCost.text = langPara("消耗：%s/%s积分", costPoint, totalPoint)
		self._txtBtnOneKey.text = langPara("升到%s级", lastV.skillLevel)
	elseif limitV then
		TipsFacade.instance:openCommonTips(langPara("aceteampetskillview__3", limitV.petLevelLimit))
	else
		TipsFacade.instance:openCommonTips("aceteampetskillview__5")
	end
end

function AceteampetskillView:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._onekey, false)
	end
end

function AceteampetskillView:_onClickOneKey()
	GameUtil.SetActive(self._onekey, false)

	local lv = self.curLevel
	local costPoint = self._costPoint
	local lastV = self._lastV
	local content = langPara("aceteampetskillview__4", costPoint, lv, lastV.skillLevel)

	TipsFacade.instance:openPopupCostMatViewNew(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT, costPoint, content, function()
		AceTeamController.instance:sendSkillLvlup(self._petId, self._selectType, lastV.skillLevel)
	end)
end

function AceteampetskillView:_upgradeSkill()
	local mo = AceTeamModel.instance:getCurrPetMo()
	local petCfg = MaterialMgr.getMatCfg(MatType.Pet, mo.raceId)
	local sid = petCfg.skillLevelStrategyId
	local list = AceTeamConfig.instance:getSkillCfgList(sid, self._selectType)
	local lv = self.curLevel

	for i, v in ipairs(list) do
		if lv < v.skillLevel then
			if v.petLevelLimit > mo.level then
				TipsFacade.instance:openCommonTips(langPara("aceteampetskillview__3", v.petLevelLimit))
			else
				local content = langPara("aceteampetskillview__4", v.point, lv, v.skillLevel)

				if list[i + 1] ~= nil then
					local obj = list[i + 1]

					content = content .. langPara("aceteamawakeview__5", v.skillLevel, obj.skillLevel, obj.point)
				end

				TipsFacade.instance:openPopupCostMatViewNew(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT, v.point, content, function()
					AceTeamController.instance:sendSkillLvlup(self._petId, self._selectType)
				end)

				return
			end
		end
	end

	TipsFacade.instance:openCommonTips(lang("aceteampetskillview__5"))
end

function AceteampetskillView:reloadFinish()
	if self.curLevel then
		self._tableview:MoveCellInView(self.curLevel - 1, true)
	end
end

return AceteampetskillView
