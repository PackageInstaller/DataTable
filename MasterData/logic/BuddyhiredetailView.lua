-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyhire/view/BuddyhiredetailView.lua

module("logic.extensions.buddyhire.view.BuddyhiredetailView", package.seeall)

local BuddyhiredetailView = class("BuddyhiredetailView", ViewComponent)

BuddyhiredetailView.TYPE_HIRE_IN = 1
BuddyhiredetailView.TYPE_HIRE_OUT = 2
BuddyhiredetailView.TYPE_HIRE_INFO = 3

local AttrRank = {
	GameEnum.AttrType.Hp,
	GameEnum.AttrType.Attack,
	GameEnum.AttrType.DefensePhysical,
	GameEnum.AttrType.DefenseMagic
}
local AttrName = {
	[GameEnum.AttrType.Attack] = "_attack",
	[GameEnum.AttrType.DefensePhysical] = "_physicalDefence",
	[GameEnum.AttrType.DefenseMagic] = "_magicDefence",
	[GameEnum.AttrType.Hp] = "_maxHp",
	[GameEnum.AttrType.Speed] = "_speed",
	[GameEnum.AttrType.HitRate] = "_hitRate",
	[GameEnum.AttrType.DodgeRate] = "_dodgeRate",
	[GameEnum.AttrType.StrikeRate] = "_strikeRate",
	[GameEnum.AttrType.BlockRate] = "_blockRate",
	[GameEnum.AttrType.CriticalRate] = "_criticalRate",
	[GameEnum.AttrType.AntiCriticalRate] = "_antiCriticalRate"
}

function BuddyhiredetailView:ctor()
	BuddyhiredetailView.super.ctor(self)
end

function BuddyhiredetailView:unbindEvents()
	BuddyhiredetailView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._customInput:RemoveListener()
	GameUtil.rmClickHandler(self.btnStart)
end

function BuddyhiredetailView:bindEvents()
	BuddyhiredetailView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickMore, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	GameUtil.addClickHandler(self.btnStart, self.onClickStart, self)
end

function BuddyhiredetailView:buildUI()
	BuddyhiredetailView.super.buildUI(self)

	self._Nego_Content = self:getGo("content")
	self._adjustPosition = self._Nego_Content:GetComponent("UIAdjustPosition")
	self._customInput = UICustomInput.Get(self._Nego_Content)
	self.itemCon = self:getGo("content/top/itemPet")
	self._txtName = self:getTxt("content/top/txtName")
	self._txtRare = self:getTxt("content/top/txtRare")
	self._txtPower = self:getTxt("content/top/power/txtPower")

	local _Nego_Attr = self:getGo("content/attrs/Attrs")

	self._Nego_Attr = _Nego_Attr
	self._Attrs = {}

	for k, _ in ipairs(AttrRank) do
		local go = self._viewPresentor:getResInstance(ItemAttr.ResPath)

		go.transform:SetParent(_Nego_Attr.transform, false)
		go.transform:SetAsLastSibling()

		self._Attrs[#self._Attrs + 1] = go
	end

	self._btnTip = self:getBtn("content/attrs/btnTip")
	self.awake = self:getGo("content/starGod/awake")
	self.btnAwake = self:getGo("content/starGod/awake/btnAwake")
	self.imgAwake = self:getGo("content/starGod/awake/btnAwake/imgLv")
	self.starGodPlus = {}

	for i = 1, 4 do
		local starGodCell = self:getGo("content/starGod/cell_" .. i)

		table.insert(self.starGodPlus, starGodCell)
		GameUtil.SetActive(starGodCell, false)
	end

	self:_buildSkillsView()

	self.scrollerGo = self:getGo("content/equips/tableview")
	self.cellGo = self:getGo("content/equips/tablecell")
	self.scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self.headgo = self:getGo("content/headgo")
	self.head = self:getGo("content/headgo/head")
	self.txtUserName = self:getTxt("content/headgo/txtName")
	self.txtUserLvl = self:getTxt("content/headgo/txtLvl")
	self.button = self:getGo("content/button")
	self.btnStart = self:getGo("content/button/btnStart")
	self.txtStart = self:getTxt("content/button/btnStart/Text")
end

function BuddyhiredetailView:_buildSkillsView()
	local skillCell = self:getGo("content/skillsgo/skills/Viewport/Content/cell")

	goutil.setActive(skillCell, false)

	self._skillViewContent = self:getGo("content/skillsgo/skills/Viewport/Content").transform
	self._Skills = {}

	local sortedKeys = MaterialMgr.getAllSkillsSortedKeys()

	for index, skillType in ipairs(sortedKeys) do
		local go = goutil.clone(skillCell)

		go.transform:SetParent(self._skillViewContent, false)

		self._Skills[#self._Skills + 1] = go
	end
end

function BuddyhiredetailView:_onCustomInputCallback(hover)
	CommonTipsMgr.instance:doWillClose(self, hover)
end

function BuddyhiredetailView:onExit()
	BuddyhiredetailView.super.onExit(self)
	self.scrollList:dispose()
	HeadItemController.instance:resetHeadCell(self.head)
end

function BuddyhiredetailView:onEnterFinished()
	local data = self:getFirstParam() or {}
	local goOrPos = data.goOrPos
	local pos = goOrPos
	local sizeDelta = {
		0,
		0
	}

	if goOrPos and goOrPos.gameObject then
		local rect = goOrPos.gameObject:GetComponent("RectTransform")

		if rect ~= nil then
			sizeDelta = {
				rect.sizeDelta.x,
				rect.sizeDelta.y
			}
		end

		pos = goOrPos.gameObject.transform.position

		local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

		pos = uiCamera:WorldToScreenPoint(pos)
	end

	if pos then
		Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
		self._adjustPosition:AdjustScreenPosition(pos, sizeDelta[1], sizeDelta[2])
	else
		Framework.TransformUtil.SetLocalPos(self._Nego_Content.transform, 0, 0, 0)
	end

	GameUtil.SetActive(self.mainGO, true)
end

function BuddyhiredetailView:onEnter()
	BuddyhiredetailView.super.onEnter(self)

	local data = self:getFirstParam() or {}
	local petMo = data.petMo

	self._petMo = petMo
	self.type = data.type
	self.headInfo = data.headInfo

	local proxy = MaterialMgr.setCellByData(MatType.Pet, petMo, self.itemCon)

	if proxy then
		proxy.binder:setAutoTips(false)
	end

	GameUtil.setUIImageSpriteIdx(self.imgAwake, petMo.awakeLevel)

	self._txtName.text = petMo.name
	self._txtRare.text = ConstString.PetRareLang[petMo.rare]
	self._txtPower.text = petMo:getFightingPower()

	self:_updateStarGodPlus(petMo)
	self:_updateAttrs(petMo)
	self:_updateSkill(petMo)
	self:_updateEquips(petMo)
	Framework.TransformUtil.SetAnchoredPos(self._skillViewContent, 0, 0)
	self:_updateHeadInfo(self.headInfo)
	self:_updateButton()
	GameUtil.SetActive(self.mainGO, false)
end

function BuddyhiredetailView:onClickStart()
	if self.type == BuddyhiredetailView.TYPE_HIRE_IN then
		if self.headInfo then
			BuddyHireController.instance:tryHireInPet(self._petMo, self.headInfo.userId)
		end
	elseif self.type == BuddyhiredetailView.TYPE_HIRE_OUT then
		BuddyHireController.instance:tryHireOutPet(self._petMo)
	elseif self.type == BuddyhiredetailView.TYPE_HIRE_INFO then
		-- block empty
	end

	self:close()
end

function BuddyhiredetailView:_updateButton()
	GameUtil.SetActive(self.button, false)

	if self.type == BuddyhiredetailView.TYPE_HIRE_IN then
		GameUtil.SetActive(self.button, true)

		self.txtStart.text = lang("租借")
	elseif self.type == BuddyhiredetailView.TYPE_HIRE_OUT then
		GameUtil.SetActive(self.button, true)

		self.txtStart.text = lang("出租")
	elseif self.type == BuddyhiredetailView.TYPE_HIRE_INFO then
		-- block empty
	end
end

function BuddyhiredetailView:_updateHeadInfo(headInfo)
	GameUtil.SetActive(self.headgo, false)
	GameUtil.rmClickHandler(self.headgo)

	if headInfo then
		GameUtil.SetActive(self.headgo, true)
		HeadItemController.instance:setHeadCellByInfo(self.head, headInfo)

		self.txtUserName.text = headInfo.userName
		self.txtUserLvl.text = langPara("等级：%s", headInfo.playerLv)

		GameUtil.addClickHandler(self.headgo, GameUtil.handler(function()
			FriendController.instance:showInfoView(headInfo.userId, self.headgo)
		end, self))
	end
end

function BuddyhiredetailView:_updateStarGodPlus(petMo)
	if petMo then
		local slotDatas = petMo:getStarGodPlusSlots()

		for i = 1, #self.starGodPlus do
			local cell = self.starGodPlus[i]

			GameUtil.rmClickHandler(cell)

			if slotDatas then
				if not slotDatas[i] then
					local slotData

					if slotData and slotData.fillerDefineId > 0 then
						GameUtil.SetActive(cell, true)

						local iconGo = goutil.findChild(cell, "icon")
						local effectGo = goutil.findChild(cell, "effect")
						local raycast = goutil.findChild(cell, "raycast")
						local btn = GameUtil.asBtn(cell)
						local lockGo = goutil.findChild(cell, "lock")
						local addGo = goutil.findChild(cell, "add")
						local nameText = goutil.findChildTextComponent(cell, "nameText")
						local lvText = goutil.findChildTextComponent(cell, "lvText")
						local lockTip = goutil.findChildTextComponent(lockGo, "lockTip")
						local nameTextColorChange = nameText.gameObject:GetComponent(ComponentType.UITextColorChange)
						local lv = StargodplusModel.instance:getSlotLv(slotData.slot, slotData.exp)

						lvText.text = "Lv." .. lv
						nameText.text = MaterialMgr.getMaterialsName(MatType.StarGodPlus, slotData.fillerDefineId)

						MaterialMgr.setIcon(iconGo, MatType.StarGodPlus, slotData.fillerDefineId)

						local cfg = StargodplusConfig.instance:getFillerCfg(slotData.fillerDefineId)
						local quality = checknumber(cfg.quality)

						nameTextColorChange:SetState(quality)
						GameUtil.addClickHandler(cell, GameUtil.handler(self.onClickStarGodPlusCell, self, cell, slotData))
					else
						GameUtil.SetActive(cell, false)
					end
				end
			end
		end
	end
end

function BuddyhiredetailView:onClickStarGodPlusCell(cell, slotData)
	local lv = StargodplusModel.instance:getSlotLv(slotData.slot, slotData.exp)

	CommonTipsMgr.instance:openMaterialTips(cell, MatType.StarGodPlus, slotData.fillerDefineId, lv)
end

function BuddyhiredetailView:_updateAttrs(data)
	for k, v in ipairs(AttrRank) do
		local na = AttrName[v]
		local itemAttr = ItemAttr.Get(self._Attrs[k])
		local value = data[na]

		itemAttr:SetIsRate(value > 0 and value < 1)
		itemAttr:SetValue(v, value)
	end
end

function BuddyhiredetailView:_updateSkill(data)
	local petCo = PetSkinConfig.instance:getPetSkinCfg(data.curFaceId)
	local sortedKeys = MaterialMgr.getAllSkillsSortedKeys()

	for index, skillType in ipairs(sortedKeys) do
		local v = MaterialMgr.getSkillKeyNameByType(skillType)
		local go = self._Skills[index]
		local con = goutil.findChild(go, "icon")
		local txt = goutil.findChildTextComponent(go, "txt_skillname")
		local skillId = petCo[v]
		local txtSkillLv = goutil.findChildTextComponent(go, "txt_skill_lv")
		local txtSkillType = goutil.findChildTextComponent(go, "txt_skill_type")
		local skillCfg = BattleConfig.instance:getSkillCo(skillId, data.curFaceId)

		GameUtil.asBtn(go):RemoveClickListener()
		MaterialMgr.resetAll(con)

		if skillId == 0 then
			go:SetActive(false)
		else
			go:SetActive(true)

			local proxy = MaterialMgr.setSkillByFaceId(skillId, data.curFaceId, con)

			if proxy then
				proxy:setAutoTips(false)
			end

			GameUtil.asBtn(go):AddClickListener(GameUtil.handler(self._OnClickSkill, self, skillType, skillId, go))

			txtSkillType.text = MaterialMgr.getSkillTypeName(skillId, data.curFaceId)

			local lvKey = MaterialMgr.SkillLvlKey[skillType]

			txtSkillLv.text = tostring(self._petMo[lvKey] or 1)
			txt.text = skillCfg.name
		end
	end
end

function BuddyhiredetailView:_OnClickSkill(skillType, skillId, go)
	local skillLv = 1
	local key = MaterialMgr.SkillLvlKey[skillType]

	if not string.nilorempty(key) then
		local v = MaterialMgr.getSkillKeyNameByType(skillType)

		skillLv = self._petMo[key] or 1

		local skillInfocfg = CharacterConfig.instance:getSkillInfoByLvl(self._petMo.curFaceId, skillLv)

		if skillInfocfg then
			skillId = checknumber(skillInfocfg[v])
		end
	end

	CommonTipsMgr.instance:openMaterialTips(go, MatType.Skill, skillId, self._petMo.curFaceId, skillLv, self._petMo)
end

function BuddyhiredetailView:_updateEquips(data)
	self._curViewDatas = {}

	local exclInfo = {}

	for _, v in pairs(self._petMo.equipments) do
		if v.defineId and v.lv then
			local equipInfo = EquipInfoMo.New()

			exclInfo.exclRaceId = checknumber(v.bonusRaceId)
			exclInfo.wearOnlyId = checknumber(self._petMo.petId)

			equipInfo:GetTemporaryEquip(v.defineId, v.lv, exclInfo)
			table.insert(self._curViewDatas, equipInfo)
		else
			local equip = PetEquipModel.instance:GetEquipInfo(v.id)

			if equip then
				table.insert(self._curViewDatas, equip)
			end
		end
	end

	local decoration = self._petMo.decoration

	if decoration then
		if checknumber(decoration.defineId) > 0 and decoration.lv then
			local equipInfo = EquipInfoMo.New(nil, MatType.Decoration)

			equipInfo:GetTemporaryDectn(checknumber(decoration.defineId), checknumber(decoration.lv), decoration.propertyApps)
			table.insert(self._curViewDatas, equipInfo)
		else
			local equip = PetEquipModel.instance:GetDecorationInfoByOnlyId(checknumber(decoration.id))

			if equip then
				table.insert(self._curViewDatas, equip)
			end
		end
	end

	self.scrollList:reloadData(self._curViewDatas)
end

function BuddyhiredetailView:_updateCell(view, cell, data)
	local point = goutil.findChild(cell.gameObject, "point")
	local proxy = MaterialMgr.setCellByData(data.matType, data, point)

	if data.matType == MatType.Equipment and proxy then
		proxy.binder:setBewearPetIds(self._petMo.petId, self._petMo.curFaceId)
	end
end

function BuddyhiredetailView:clearCell(cell)
	local point = goutil.findChild(cell.gameObject, "point")

	MaterialMgr.resetAll(point)
end

function BuddyhiredetailView:_onClickMore()
	local go = self._btnTip.gameObject
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	UIStateManager.instance:open(ViewName.PetAttrPopUpView, pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}, self._petMo)
end

return BuddyhiredetailView
