-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RogueJudgeCardContainer.lua

module("logic.extensions.roguelike.view.widgets.RogueJudgeCardContainer", package.seeall)

local kShowCardItemIndex = {
	{
		3
	},
	{
		3,
		4
	},
	{
		2,
		3,
		4
	},
	{
		2,
		3,
		4,
		5
	},
	{
		1,
		2,
		3,
		4,
		5
	},
	{
		1,
		2,
		3,
		4,
		5,
		6
	}
}
local M = class("RogueJudgeCardContainer")

function M:ctor(container)
	local go = container.gameObject

	self._go = go
	self._traCardParent = go.transform
	self._cardItems = {}
	self._traCardDanShu = goutil.findChild(go, "danShu").transform
	self._traCardShuangShu = goutil.findChild(go, "shuangShu").transform

	self:_initCardContainer()
end

function M:setCardPrefab(prefab)
	if goutil.isNil(prefab) then
		return
	end

	self._goCardPrefab = prefab

	prefab.transform:SetParent(self._go.transform, false)
	goutil.setActive(prefab, false)
end

function M:_initCardContainer()
	self._traDanShuContainer = {}
	self._traShuangeShuContainer = {}

	for i = 1, self._traCardDanShu.childCount do
		table.insert(self._traDanShuContainer, self._traCardDanShu:GetChild(i - 1))
	end

	for i = 1, self._traCardShuangShu.childCount do
		table.insert(self._traShuangeShuContainer, self._traCardShuangShu:GetChild(i - 1))
	end

	goutil.setActive(self._traCardDanShu.gameObject, true)
	goutil.setActive(self._traCardShuangShu.gameObject, true)
end

function M:_setJudgeCardPos(go, index, totalCount)
	local isDanShu = math.fmod(totalCount, 2) ~= 0
	local parent = isDanShu and self._traDanShuContainer or self._traShuangeShuContainer
	local showIndex = kShowCardItemIndex[totalCount][index]

	go.transform:SetParent(parent[showIndex], false)
end

function M:updateData(data)
	for k, v in pairs(self._cardItems) do
		v:setActive(false)
	end

	local index = data.index
	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()
	local roleProp = allRoles[index].roleProp
	local roleId = roleProp:getRoleId()

	for k, v in pairs(self._cardItems) do
		v:setActive(false)
	end

	local roleCo = RoguelikeConfig.instance:getRoguelikeRoleById(roleId)
	local actionIds = roleProp:getCardIds()

	if not roleCo then
		printError("找不到角色", roleId)
	end

	self._cardIds = actionIds

	local qua6List = {}

	qua6List = {}

	for i = 1, 6 do
		table.insert(qua6List, roleProp:getPropertyLevel(i))
	end

	self._qua6List = qua6List

	for i = 1, #actionIds do
		local item = self._cardItems[i]
		local co = RoguelikeConfig.instance:getRoleActionById(actionIds[i])
		local cardData = {}

		if roleProp ~= nil then
			local cardEntries = RogueMgr.instance:getRogueFlow().judgeModel:getSelectCardEntries(actionIds[i], roleProp, i)

			cardData.cardEntries = cardEntries
		end

		cardData.name = co.name
		cardData.co = co

		local pattern = RoguelikeUtil.instance:convertCAttrType2SType(co.attr)
		local attrLevel = CharacterCOUtil.qua2Score(qua6List[co.attr])
		local attrText = string.format("<color=#%s>%s</color>", RoguelikeConst.ATTR_COLOR[qua6List[co.attr]], attrLevel)

		cardData.attr = RoguelikeConst.AttrType2Name[pattern]
		cardData.attrLevel = qua6List[co.attr]
		cardData.effect = RoguePredictionUtil.instance:predictionRoleActionRang(nil, nil, co, qua6List[co.attr], cardData.cardEntries)
		cardData.pattern = co.attr
		cardData.slotCount = RoguelikeUtil.instance:getCardSlotCount(qua6List[co.attr])
		cardData.throwDiceText = string.format("投掷%sx%d", RoguelikeConst.GetAttrGraphic(pattern, 20), qua6List[co.attr])

		if not item then
			local go = goutil.clone(self._goCardPrefab)

			item = Astral.LuaComponentContainer.Add(go, RogueJudgeCard)
			self._cardItems[i] = item
		end

		local index2 = i

		function cardData.selectCallback()
			self:onCardSelect(index2)
		end

		item:updateData(cardData)
		self:_setJudgeCardPos(item:getGo(), i, #actionIds)
	end
end

function M:onCardSelect(index)
	if self._cardSelectCallback then
		self._cardSelectCallback(index)
	end
end

function M:setCardSelectCallback(callback)
	self._cardSelectCallback = callback
end

return M
