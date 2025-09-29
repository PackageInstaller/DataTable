-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/relationship/HandbookRelationshipEntryView.lua

module("logic.extensions.playerinfo.view.handbook.relationship.HandbookRelationshipEntryView", package.seeall)

local M = class("HandbookRelationshipEntryView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:getSubPageTyp()
	return CommEnum.HandBookSubView.RelationShip
end

function M:buildUI()
	self._btnReturn = UIComponentType.ButtonAdapter(self:getGo("0&title_view_-878360263"))
	self._btnCampLst = {}
	self._btnCampLst[GameEnum.CampEnum.OAD] = self:getBtn("handbook_relationship_entry_view_-762048704")
	self._btnCampLst[GameEnum.CampEnum.TreeOfEden] = self:getBtn("handbook_relationship_entry_view_-550929509")
	self._btnCampLst[GameEnum.CampEnum.BrotherhoodOfTruth] = self:getBtn("handbook_relationship_entry_view_-1118579678")
	self._btnCampLst[GameEnum.CampEnum.SilverDawnAssociation] = self:getBtn("handbook_relationship_entry_view_-1412692468")
	self._btnCampLst[GameEnum.CampEnum.Noah] = self:getBtn("handbook_relationship_entry_view_-1758938614")
	self._btnCampLst[GameEnum.CampEnum.StarrySkyChurch] = self:getBtn("handbook_relationship_entry_view_-840414432")
	self._btnCampLst[GameEnum.CampEnum.WaterDroplets] = self:getBtn("handbook_relationship_entry_view_-64867835")
	self._goCampNewSignLst = {}
	self._goCampNewSignLst[GameEnum.CampEnum.OAD] = self:getGo("handbook_relationship_entry_view_-1961816768")
	self._goCampNewSignLst[GameEnum.CampEnum.TreeOfEden] = self:getGo("handbook_relationship_entry_view_-1070782465")
	self._goCampNewSignLst[GameEnum.CampEnum.BrotherhoodOfTruth] = self:getGo("handbook_relationship_entry_view_212842302")
	self._goCampNewSignLst[GameEnum.CampEnum.SilverDawnAssociation] = self:getGo("handbook_relationship_entry_view_1073487953")
	self._goCampNewSignLst[GameEnum.CampEnum.Noah] = self:getGo("handbook_relationship_entry_view_1602036755")
	self._goCampNewSignLst[GameEnum.CampEnum.StarrySkyChurch] = self:getGo("handbook_relationship_entry_view_-1703036994")
	self._goCampNewSignLst[GameEnum.CampEnum.WaterDroplets] = self:getGo("handbook_relationship_entry_view_2079089681")
end

function M:destroyUI()
	self._btnReturn = nil
	self._btnCampLst = nil
	self._goCampNewSignLst = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)

	for camp, btn in pairs(self._btnCampLst or {}) do
		btn:AddClickListener(function()
			self:_onClickCamp(camp)
		end, self)
	end
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()

	for camp, btn in pairs(self._btnCampLst or {}) do
		btn:RemoveClickListener()
	end
end

function M:onEnter()
	self:_setEvent(true)
	self:refreshNewSign()
end

function M:onExit()
	self:_setEvent(false)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.HANDBOOK_UNREAD_INFO_CHANGE, self._handleHandbookUnreadInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HANDBOOK_UNREAD_INFO_CHANGE, self._handleHandbookUnreadInfoChange, self)
	end
end

function M:_onClickReturn()
	self:close()
end

function M:_onClickCamp(camp)
	local info = {
		camp = camp
	}

	self:test_PrintCampNew(camp)
	ViewMgr.instance:open(ViewName.HandbookRelationInCampView, info)
end

function M:_handleHandbookUnreadInfoChange(e)
	self:refreshNewSign()
end

function M:refreshNewSign()
	for CampEnum, obj in pairs(self._goCampNewSignLst) do
		local isNew = self:_isCampHasNewInfo(CampEnum)

		goutil.setActive(obj, isNew)
	end
end

function M:_isCampHasNewInfo(campEnum)
	local count = 0
	local idsMap_hero = GalleryModel.instance:getTypUnReadNewIds(GameEnum.UnlockTypeEnum.Hero)

	for heroId, _ in pairs(idsMap_hero) do
		local cfgCharacter = CharacterConfig.instance:getCharacterItemInfo(heroId)

		if cfgCharacter then
			if cfgCharacter.camp == campEnum then
				count = count + 1
			end
		else
			printError(string.format("无法找到角色[%s]的配置", heroId))
		end
	end

	local idsMap_relation = GalleryModel.instance:getTypUnReadNewIds(GameEnum.UnlockTypeEnum.HeroRelation)

	for relationId, _ in pairs(idsMap_relation) do
		local cfgRelation = HandbookConfig.instance:getConfigByKey(ConfigName.HeroRelation, relationId)
		local heroId = cfgRelation.heroId
		local cfgCharacter = CharacterConfig.instance:getCharacterItemInfo(heroId)

		if cfgCharacter then
			if cfgCharacter.camp == campEnum then
				count = count + 1
			end
		else
			printError(string.format("无法找到角色[%s]的配置", heroId))
		end
	end

	return count > 0
end

function M:test_PrintCampNew(campEnum)
	if Astral.OSDef.isEditor then
		printWarn("未读信息：阵营 ", campEnum)

		local count = 0
		local idsMap_hero = GalleryModel.instance:getTypUnReadNewIds(GameEnum.UnlockTypeEnum.Hero)

		for heroId, _ in pairs(idsMap_hero) do
			local cfgCharacter = CharacterConfig.instance:getCharacterItemInfo(heroId)

			if cfgCharacter then
				if cfgCharacter.camp == campEnum then
					count = count + 1

					printWarn(string.format("角色[%s]解锁未读", heroId))
				end
			else
				printError(string.format("无法找到角色[%s]的配置", heroId))
			end
		end

		printWarn(string.format("----共有[%s]个角色解锁未读", count))

		local key = GalleryModel.instance:getUnReadNewInfoStoreKey(GameEnum.UnlockTypeEnum.HeroRelation)
		local str = Astral.LocalStorage.Instance:GetString(key, "#")

		printWarn(string.format("所有关系网未读缓存: %s", str))

		count = 0

		local idsMap_relation = GalleryModel.instance:getTypUnReadNewIds(GameEnum.UnlockTypeEnum.HeroRelation)

		for relationId, _ in pairs(idsMap_relation) do
			local cfgRelation = HandbookConfig.instance:getConfigByKey(ConfigName.HeroRelation, relationId)
			local heroId = cfgRelation.heroId
			local cfgCharacter = CharacterConfig.instance:getCharacterItemInfo(heroId)

			if cfgCharacter then
				if cfgCharacter.camp == campEnum then
					count = count + 1

					printWarn(string.format("关系[%s]主体角色是[%s]属于阵营[%s], 该解锁未读", relationId, heroId, campEnum))
				end
			else
				printError(string.format("无法找到角色[%s]的配置", heroId))
			end
		end

		printWarn(string.format("----共有[%s]个关系解锁未读", count))
	end
end

return M
