-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueRoleDetailTips.lua

module("logic.extensions.roguelike.view.explore.RogueRoleDetailTips", package.seeall)

local DiceItem = class("DiceItem")

function DiceItem:ctor(go)
	self._go = go
	self._imgIcon = goutil.findChildComponent(go, "diceIcon", UIComponentType.Image)
end

function DiceItem:updateData(data)
	local pattern = data.pattern

	IconLoader.setSprite(self._imgIcon, IconType.DynSpriteAtlas_Dice, string.format("dice_%d", RoguelikeConst.GetPatterIcon(pattern)))
	self:setActive(true)
end

function DiceItem:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

local M = class("RogueRoleDetailTips")

function M:ctor(go)
	self._go = go.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
	self._fightPatterns = {}
	self._eventPatterns = {}
end

function M:Awake()
	self:init()
end

function M:init()
	local registry = self._viewElementsRegistry

	self._imgIcon = registry:findUIElement("run_group_role_tips_-163095932", UIComponentType.Image)
	self._txtName = registry:findUIElement("run_group_role_tips_1753570018", UIComponentType.Text)
	self._txtFeatures = registry:findUIElement("run_group_role_tips_-677350030", UIComponentType.Text)
	self._txtHp = registry:findUIElement("run_group_role_tips_-1299294476", UIComponentType.Text)
	self._txtCard = registry:findUIElement("run_group_role_tips_-1396953320", UIComponentType.Text)
	self._btnClose = UIComponentType.ButtonAdapter(registry:findUIElement("run_group_role_tips_582271652"))
	self._btnCard = UIComponentType.ButtonAdapter(registry:findUIElement("run_group_role_tips_-1710568471"))
	self._qua6Ploygon = UIPolygon.Get(registry:findUIElement("run_group_role_tips_-1848422243"))

	self._qua6Ploygon:Init(6)

	self._txtQua6List = {
		registry:findUIElement("run_group_role_tips_-534202671", UIComponentType.Text),
		registry:findUIElement("run_group_role_tips_-1335657293", UIComponentType.Text),
		registry:findUIElement("run_group_role_tips_-2128218587", UIComponentType.Text),
		registry:findUIElement("run_group_role_tips_-360634169", UIComponentType.Text),
		registry:findUIElement("run_group_role_tips_-195209737", UIComponentType.Text),
		registry:findUIElement("run_group_role_tips_-359100059", UIComponentType.Text)
	}

	self._btnClose:AddClickListener(self._clickClose, self)
	self._btnCard:AddClickListener(self._clickCard, self)

	self._txtRoleSkillContent = registry:findUIElement("run_group_role_tips_-677350030", UIComponentType.Text)
	self._animation = self._go:GetComponent(ComponentType.Animation)
end

function M:_clickClose()
	self:setActive(false)
end

function M:_clickCard()
	local actionIds = RoguelikeModel.instance:getRoleCardIds(self._roleId)

	ViewMgr.instance:open(ViewName.RogueRoleCard, 1, {
		actionIds,
		self._roleId
	})
end

function M:setActive(isActive)
	if isActive then
		goutil.setActive(self._go, isActive)
		self._animation:Play("run_group_role_tips_open")
	else
		self._animation:Play("run_group_role_tips_close")
		settimer(0.3, function()
			goutil.setActive(self._go, isActive)
		end, self, false)
	end
end

function M:setHp(hp, hpMax)
	self._txtHp.text = string.format("%d/%d", hp, hpMax)
end

function M:setCard(card, cardMax)
	if cardMax <= card then
		self._txtCard.text = string.format("<b><color=red>%d</color></b>/%d", card, cardMax)
	else
		self._txtCard.text = string.format("%d/%d", card, cardMax)
	end
end

function M:updatePatterns(roleId)
	local fightFaces = RoguelikeModel.instance:getFightFaces(roleId)
	local eventFaces = RoguelikeModel.instance:getEventFaces(roleId)

	for k, v in pairs(self._fightPatterns) do
		v:setActive(false)
	end

	for k, v in pairs(self._eventPatterns) do
		v:setActive(false)
	end

	local index = 1

	for k, v in ipairs(fightFaces) do
		for i = 1, v.num do
			local item = self._fightPatterns[index]

			if not item then
				local go = Astral.GameObjectUtil.CloneAndSetParent(self._goPatternItem, self._traFightPattern.transform, nil)

				item = DiceItem.New(go)
				self._fightPatterns[index] = item
			end

			local data = {}

			data.pattern = RoguelikeUtil.instance:convertSAttrTypeCSType(v.face)

			item:updateData(data)

			index = index + 1
		end
	end

	index = 1

	for k, v in ipairs(eventFaces) do
		for i = 1, v.num do
			local item = self._eventPatterns[index]

			if not item then
				local go = Astral.GameObjectUtil.CloneAndSetParent(self._goPatternItem, self._traEventPattern.transform, nil)

				item = DiceItem.New(go)
				self._eventPatterns[index] = item
			end

			local data = {}

			data.pattern = RoguelikeUtil.instance:convertSAttrTypeCSType(v.face)

			item:updateData(data)

			index = index + 1
		end
	end
end

function M:updateData(data)
	local roleId = data.roleId

	self._roleId = roleId

	self:setHeadIcon(roleId)

	local heroData = HeroDepotModel.instance:getHeroInfoByID(roleId)
	local heroCO = PastInfoConfig.instance:getCharacterInfo(roleId)

	self._txtName.text = heroCO.name

	local level = 0

	if heroData then
		level = heroData:getLevel()
	end

	self._level = level

	self:setHp(data.hp, data.hpMax)
	self:setCard(data.card, data.cardMax)

	local qua6List = {}
	local roleMo = RogueMgr.instance:getModel():getRoleMoByRoleId(roleId)
	local txtState = ""
	local stateCount = 0

	if roleMo ~= nil then
		for i = 1, 6 do
			table.insert(qua6List, roleMo.roleProp:getPropertyLevel(i))
		end

		local negativeCo = RoguelikeConfig.instance:getNegativeSanCoBySan(roleMo.roleProp:getSan())

		if negativeCo then
			local effectIds = negativeCo.effects
			local tempDesc = string.format(lang("tip_r_de_san_effect"), roleMo.roleProp:getSan())

			for k, v in pairs(effectIds) do
				local effectCo = RoguelikeConfig.instance:getEffectById(v)

				if effectCo then
					tempDesc = tempDesc .. effectCo.description .. " "
					stateCount = stateCount + 1
				end
			end

			txtState = tempDesc
		end
	end

	function getRealIndex(idx)
		if idx == 1 then
			return 2
		elseif idx == 2 then
			return 1
		elseif idx == 3 then
			return 0
		elseif idx == 4 then
			return 5
		elseif idx == 5 then
			return 4
		elseif idx == 6 then
			return 3
		end
	end

	for index = 1, #qua6List do
		local value = qua6List[index]

		self._qua6Ploygon:InitPolygon(getRealIndex(index), CharacterCOUtil.qua2Ratio(value))

		self._txtQua6List[index].text = value

		TextUtils.SetColor(self._txtQua6List[index], CharacterCOUtil.qua2Color(value))
	end

	local temps = RoguelikeModel.instance:getRoleTemps(roleId)

	if temps ~= nil and #temps > 0 then
		for k, v in ipairs(temps) do
			local type = v.type
			local effect = v.effect
			local id = v.id

			if id == -1 then
				local prop = type == 1 and RoguelikeConst.ROLE_PROP.POWER or RoguelikeConst.ROLE_PROP.AGILE
				local map = RoguelikeConst.PROP_LANG_MAP[prop]
				local formatText = stateCount == 0 and lang("tip_r_rectify_effect") or "\n" .. lang("tip_r_rectify_effect")

				txtState = txtState .. string.format(formatText, map.name, "")
				stateCount = stateCount + 1
			elseif type == 1 then
				local monsterCo = RoguelikeConfig.instance:getRoguelikeMonsterById(id)
				local effectCo = RoguelikeConfig.instance:getEffectById(effect)
				local formatText = stateCount == 0 and lang("tip_r_monster_effect") or "\n" .. lang("tip_r_monster_effect")

				txtState = txtState .. string.format(formatText, monsterCo.name, effectCo.description)
				stateCount = stateCount + 1
			else
				local eventCo = RoguelikeConfig.instance:getRoguelikeEventById(id)
				local effectCo = RoguelikeConfig.instance:getEffectById(effect)

				if effectCo ~= nil and eventCo ~= nil then
					local formatText = stateCount == 0 and lang("tip_r_event_effect") or "\n" .. lang("tip_r_event_effect")

					txtState = txtState .. string.format(formatText, eventCo.name, effectCo.description)
					stateCount = stateCount + 1
				end
			end
		end
	end

	local roleCo = RoguelikeConfig.instance:getRoguelikeRoleById(roleId)
	local skillIds = {}
	local hadSkill = skillIds and #skillIds > 0
	local skillDesc = ""

	for k, v in pairs(skillIds) do
		local effectCo = RoguelikeConfig.instance:getEffectById(v)

		if effectCo then
			skillDesc = skillDesc .. effectCo.description .. "\n"
		end
	end

	local isUnlock = RoguelikeConfig.instance:getRoguelikeRoleSkillUnlock(roleId) and RoguelikeModel.instance:getSkillOpen(roleId)

	if not RoguelikeConst.IsGuideFinish() then
		isUnlock = true
	end

	self._txtRoleSkillContent.text = hadSkill and isUnlock and StringUtil.replaceAllGraphicText2(skillDesc) or lang("tip_r_role_skill")
end

function M:setHeadIcon(roleId)
	local characterCO = CharacterConfig.instance:getCfgInfoByID(roleId)
	local modelCO = ModelConfig.instance:getModelConfig(characterCO.modelId)

	IconLoader.setSprite(self._imgIcon, IconType.RoleHeadIcon, modelCO.headIconName)
end

function M:OnDestroy()
	self._imgIcon = nil
	self._txtName = nil
	self._txtHp = nil
	self._qua6Ploygon = nil
	self._txtQua6List = nil

	self._btnClose:RemoveClickListener()
	self._btnCard:RemoveClickListener()

	self._btnClose = nil
end

return M
