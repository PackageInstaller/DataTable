-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/view/RankTeamItem.lua

module("logic.extensions.rank.view.RankTeamItem", package.seeall)

local M = class("RankTeamItem")

function M:ctor(compContainer)
	self._viewElementsRegistry = ViewElementsRegistry.New(compContainer.gameObject)
	self._data = nil
	self._cellWidth = nil
	self._spaceWidth = nil
	self._maxScrollWidth = nil
	self._canShowTeam = nil
end

function M:Awake()
	self.trans_content = self:findUIElement("rank_team_-342494576", UIComponentType.RectTransform)
	self.layoutGroup = self:findUIElement("rank_team_-342494576", UIComponentType.GridLayoutGroup)
	self.tr_scroll = self:findUIElement("rank_team_-2014184588", UIComponentType.RectTransform)
	self.go_hero_item = self:findUIElement("0&hero_item_1481649446")
	self.go_viewPort = self:findUIElement("rank_team_636559974")
	self._cellWidth = self.layoutGroup.cellSize.x
	self._spaceWidth = self.layoutGroup.spacing.x
	self._maxScrollWidth = self._cellWidth * 5.5 + self._spaceWidth * 5

	goutil.setActive(self.go_hero_item, false)
	GlobalDispatcher:addEventListener(EventType.RANK_SHOW_TEAM, self._onShowTeam, self)
end

function M:updateData(data)
	if not data then
		return
	end

	self._data = data

	local team = data:getTeam()

	self._canShowTeam = team and #team > 0

	local isShowItem = RankController.instance:getIsShowTeam()

	goutil.setActive(self.go_viewPort, self._canShowTeam and isShowItem)

	if not self._canShowTeam then
		return
	end

	local scrollWidth = self._cellWidth * #team + self._spaceWidth * (#team - 1)

	scrollWidth = math.min(scrollWidth, self._maxScrollWidth)

	goutil.setWidth(self.tr_scroll, scrollWidth)
	self:refreshItemScroll(team)
end

function M:refreshItemScroll(team)
	while self.trans_content.childCount < #team + 1 do
		goutil.cloneAndSetParent(self.go_hero_item, self.trans_content)
	end

	for i = 1, self.trans_content.childCount - 1 do
		local itemGo = self.trans_content:GetChild(i).gameObject
		local heroInfo = team[i]

		if heroInfo then
			local itemView = Astral.LuaComponentContainer.Add(itemGo, HeroHeadItem)

			itemView:setHeroMO(CharacterBaseData.New({
				id = heroInfo.code,
				level = heroInfo.lv,
				skills = {},
				attrs = {},
				attrParts = {}
			}))
			itemView:setHandler(self)
		end

		goutil.setActive(itemGo, heroInfo)
	end
end

function M:findUIElement(key, mtype)
	return self._viewElementsRegistry:findUIElement(key, mtype)
end

function M:onClickHeroItem(heroHeadItem)
	local heroMo = heroHeadItem:getHeroMO()
	local heroId = heroMo and heroMo:getId()
	local userId = self._data:getUserId()
	local rankId = self._data:getRankId()

	if rankId and userId and heroId then
		CharacterUtil.openRankCharacterDetailView(rankId, userId, heroId)
	end
end

function M:_onShowTeam(_, rankId)
	local curRankId = self._data:getRankId()

	if rankId ~= curRankId then
		return
	end

	local isShow = RankController.instance:getIsShowTeam()

	goutil.setActive(self.go_viewPort, self._canShowTeam and isShow)
end

function M:OnDestroy()
	GlobalDispatcher:removeEventListener(EventType.RANK_SHOW_TEAM, self._onShowTeam, self)
	self._viewElementsRegistry:cleanRegistry()

	self._viewElementsRegistry = nil
	self._data = nil
	self._cellWidth = nil
	self._spaceWidth = nil
	self._maxScrollWidth = nil
	self._canShowTeam = nil
end

return M
