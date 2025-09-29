-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueRoleSelectView.lua

module("logic.extensions.roguelike.view.explore.RogueRoleSelectView", package.seeall)

local M = class("RogueRoleSelectView", ViewComponent)
local curSelectRoleIds = {}
local isFilterUp = false

function M:ctor()
	M.super.ctor(self)

	isFilterUp = false
end

function M:buildUI()
	self._goHeroScroll = self:getGo("rungroup_role_select_view_1500465006")
	self._goCardList1 = self:getGo("rungroup_role_select_view_1629383643")
	self._goCardList2 = self:getGo("rungroup_role_select_view_-239182465")
	self._txtName = self:getText("rungroup_role_select_view_-1893651143")
	self._txtChangeText = self:getText("rungroup_role_select_view_2114525530")
	self._txtCamp = self:getText("rungroup_role_select_view_-828463966")
	self._imgCamp = self:getImage("rungroup_role_select_view_-778858326")
	self._btnChange = self:getBtn("rungroup_role_select_view_-1509911801")
	self._btnClose = self:getBtn("10&title_view_-878360263")
	self._goLiPaiItem = goutil.findChild(self.mainGO, "run_group_lipai_item")
	self._heroScroll = LoopGridViewHelper.New(self._goHeroScroll)

	self._heroScroll:InitGridView(0, self._onHeroCellUpdate, self)

	self._curRoleLiPai = RogueRoleLiPaiItem.New(self._goLiPaiItem)
	self._cardItems = {}

	for i = 1, 3 do
		local item = Astral.LuaComponentContainer.Add(self._goCardList1.transform:GetChild(i - 1).gameObject, RogueJudgeCard)

		table.insert(self._cardItems, item)
	end

	for i = 1, 3 do
		local item = Astral.LuaComponentContainer.Add(self._goCardList2.transform:GetChild(i - 1).gameObject, RogueJudgeCard)

		table.insert(self._cardItems, item)
	end
end

function M:bindEvents()
	self._btnChange:AddClickListener(self.onClickChange, self)
	self._btnClose:AddClickListener(self.onClickClose, self)
	self._curRoleLiPai:bindEvents()
end

function M:unbindEvents()
	self._btnChange:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._curRoleLiPai:unbindEvents()
end

function M:onEnter()
	self:setEvent(true)

	local param = self:getOpenParam()

	self._targetRoleIndex = param[1]
	self._selectRoleIds = param[2]
	self._onSelectCallback = param[3]
	curSelectRoleIds = self._selectRoleIds

	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterDepot)
	self:_updateHeroData()

	if #self._heroMoList > 0 then
		self:onClickCallback(1)
	end
end

function M:onExit()
	self._lastIndex = nil
	self._inClickRole = nil

	self:setEvent(false)
	removetimer(self.delayEnableClick, self)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterDepot)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_FILTER_SELECT_ROLE, self._onSelectRoleFilter, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_FILTER_SELECT_ROLE, self._onSelectRoleFilter, self)
	end
end

function M:_onSelectRoleFilter(sender, sortData)
	isFilterUp = sortData.isUp
	self._sortData = sortData

	self:_updateHeroData()
end

function M:_onHeroCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local item = self._heroScroll:NewListViewItem("rungroup_role_item")

	Astral.TransformUtil.SetLocalScale(item.gameObject.transform, 1, 1, 1)

	local view = Astral.LuaComponentContainer.Add(item.gameObject, RogueRoleItem)
	local data = self._heroMoList[curIndex]

	view:updateData(data)

	local isSelected = data.roleId == self._curRoleId

	view:setSelect(isSelected)

	return item
end

function getRoleInList(roleId)
	for k, v in pairs(curSelectRoleIds) do
		if v == roleId then
			return 1
		end
	end

	return 0
end

function M:_updateHeroData(event, resultList)
	local _tmpHeroList = HeroDepotModel.instance:getHeroDepotData():getHeroDataList()

	self._heroMoList = CharacterUtil.SortAndFitler(CommEnum.HeroFilter.Roguelike, resultList or _tmpHeroList)

	local allRoleCo = {}

	for k, v in ipairs(self._heroMoList) do
		local roleCo = RoguelikeConfig.instance:getRoguelikeRoleById(v:getId())

		if roleCo ~= nil then
			table.insert(allRoleCo, roleCo)
		end
	end

	local sortFuns = {
		sortByAttr,
		sortByQuality
	}
	local sortFun = self._sortData ~= nil and sortFuns[self._sortData.sortType] or sortByAttr

	table.sort(allRoleCo, sortFun)

	if isFilterUp then
		local tempRoleList = {}
		local roleListIndex = 1
		local listCount = math.min(4, #allRoleCo)

		for i = 1, listCount do
			local inList = getRoleInList(allRoleCo[i].id)

			if inList then
				table.insert(tempRoleList, allRoleCo[i])

				roleListIndex = i + 1
			end
		end

		for i = #allRoleCo, roleListIndex, -1 do
			table.insert(tempRoleList, allRoleCo[i])
		end

		allRoleCo = tempRoleList
	end

	self._allRoleCo = allRoleCo
	self._heroMoList = {}

	for i = 1, #allRoleCo do
		local data = {}

		data.roleId = allRoleCo[i].id

		local level = 1
		local heroData = HeroDepotModel.instance:getHeroInfoByID(data.roleId)

		if heroData then
			level = heroData:getLevel()
		end

		data.index = i
		data.useHeadIcon = true
		data.six = allRoleCo[i].qua6
		data.level = level
		data.inSelect = getRoleInList(data.roleId) == 1

		local index = i

		function data.callback()
			self:onClickCallback(index)
		end

		table.insert(self._heroMoList, data)
	end

	self._heroScroll:SetListItemCount(#self._heroMoList)
	self._heroScroll:RefreshAllShownItem()
end

function M:onClickCallback(index)
	if self._lastIndex == index or self._inClickRole then
		return
	end

	self._inClickRole = true

	settimer(0.2, self.delayEnableClick, self, false)

	self._lastIndex = index

	local roleId = self._heroMoList[index].roleId
	local data = {}

	self._curRoleId = roleId
	data.roleId = roleId

	self:showCurRoleInfo(data)
	self._heroScroll:SetListItemCount(#self._heroMoList)
	self._heroScroll:RefreshAllShownItem()
end

function M:delayEnableClick()
	self._inClickRole = false
end

function M:showCurRoleInfo(data)
	self._curRoleLiPai:setAttackPlane()
	self._curRoleLiPai:updateData(data)

	local roleId = data.roleId
	local roleCo = RoguelikeConfig.instance:getRoguelikeRoleById(roleId)
	local actionIds = roleCo.roguelikeCards

	self._txtName.text = RoguelikeConfig.instance:getRoleName(roleId)

	local characterCO = CharacterConfig.instance:getCfgInfoByID(roleId)

	self._txtCamp.text = CommEnum.CampType2Name[characterCO.camp]

	IconLoader.setSprite(self._imgCamp, IconType.RunGroupRoleCamp, CommEnum.CampType2RgIcon[characterCO.camp])
	self:showRoleCard({
		actionIds,
		roleId
	})

	local isCurRole = roleId == curSelectRoleIds[self._targetRoleIndex]
	local isInList = curSelectRoleIds[self._targetRoleIndex] ~= nil

	self._txtChangeText.text = isCurRole and lang("退场") or isInList and lang("更换") or lang("上阵")
end

function M:showRoleCard(param)
	for k, v in pairs(self._cardItems) do
		v:setActive(false)
	end

	local actionIds = param[1]
	local roleId = param[2]

	self._selectRoleCardCallback = param[3]
	self._roleProp = param[4]

	local roleCo = RoguelikeConfig.instance:getRoguelikeRoleById(roleId)

	if not roleCo then
		printError("找不到角色", roleId)
	end

	self._cardIds = actionIds

	local qua6List = roleCo.qua6
	local roleMo

	if RogueMgr.instance:isInRogue() then
		roleMo = RogueMgr.instance:getModel():getRoleMoByRoleId(roleId)

		if roleMo ~= nil then
			qua6List = {}

			for i = 1, 6 do
				table.insert(qua6List, roleMo.roleProp:getPropertyLevel(i))
			end
		end
	end

	self._roleMo = roleMo
	self._qua6List = qua6List

	for i = 1, #actionIds do
		local index = i

		if #actionIds == 1 then
			index = 2
		elseif #actionIds == 4 and i == 4 then
			index = 5
		end

		local item = self._cardItems[index]
		local co = RoguelikeConfig.instance:getRoleActionById(actionIds[i])
		local data = {}

		data.co = co
		data.name = co.name

		local pattern = RoguelikeUtil.instance:convertCAttrType2SType(co.attr)
		local attrLevel = CharacterCOUtil.qua2Score(qua6List[co.attr])
		local attrText = string.format("<color=#%s>%s</color>", RoguelikeConst.ATTR_COLOR[qua6List[co.attr]], attrLevel)

		data.attr = RoguelikeConst.AttrType2Name[pattern]
		data.attrLevel = qua6List[co.attr]

		if roleMo ~= nil then
			local cardEntries = RogueMgr.instance:getRogueFlow().judgeModel:getSelectCardEntries(actionIds[i], roleMo.roleProp, i)

			data.cardEntries = cardEntries
		end

		data.effect = RoguePredictionUtil.instance:predictionRoleActionRang(nil, nil, co, qua6List[co.attr], data.cardEntries)
		data.pattern = co.attr
		data.isDisplay = true
		data.slotCount = RoguelikeUtil.instance:getCardSlotCount(qua6List[co.attr])
		data.throwDiceText = string.format("投掷%sx%d", RoguelikeConst.GetAttrGraphic(pattern, 20), qua6List[co.attr])

		if self._roleProp then
			data.isBan = self._roleProp:getCardSlotIsFull(i)
		end

		if not item then
			local go = self._traCardParent:GetChild(i - 1).gameObject

			item = Astral.LuaComponentContainer.Add(go, RogueJudgeCard)
			self._cardItems[i] = item
		end

		local index = i
		local attr = i

		function data.selectCallback()
			return
		end

		item:updateData(data)
	end

	goutil.setActive(self._goCards, true)
	goutil.setActive(self._goCardList2, #actionIds > 3)
end

function M:onClickChange()
	local isCurRole = self._curRoleId == curSelectRoleIds[self._targetRoleIndex]

	if isCurRole then
		self._curRoleId = nil
	end

	if self._onSelectCallback ~= nil then
		self._onSelectCallback(self._targetRoleIndex, self._curRoleId)
	end

	self:close()
end

function M:onClickClose()
	if self._onSelectCallback ~= nil then
		self._onSelectCallback(nil, nil)
	end

	self:close()
end

function getSumOfRoleSix(six)
	local count = 0

	for k, v in pairs(six or {}) do
		count = count + v
	end

	return count
end

function sortByAttr(a, b)
	local aInList = getRoleInList(a.id)
	local bInList = getRoleInList(b.id)
	local aSix = getSumOfRoleSix(a.qua6)
	local bSix = getSumOfRoleSix(b.qua6)

	if aInList ~= bInList then
		return bInList < aInList
	end

	if aSix ~= bSix then
		return bSix < aSix
	end

	local aRarity = CharacterConfig.instance:getCfgInfoByID(a.id).quality
	local bRarity = CharacterConfig.instance:getCfgInfoByID(b.id).quality

	if aRarity ~= bRarity then
		return bRarity < aRarity
	end

	return a.id > b.id
end

function sortByQuality(a, b)
	local aInList = getRoleInList(a.id)
	local bInList = getRoleInList(b.id)
	local aRarity = CharacterConfig.instance:getCfgInfoByID(a.id).quality
	local bRarity = CharacterConfig.instance:getCfgInfoByID(b.id).quality

	if aInList ~= bInList then
		return bInList < aInList
	end

	if aRarity ~= bRarity then
		return bRarity < aRarity
	end

	local aSix = getSumOfRoleSix(a.qua6)
	local bSix = getSumOfRoleSix(b.qua6)

	if aSix ~= bSix then
		return bSix < aSix
	end

	return a.id > b.id
end

function sortRoles(a, b)
	local aInList = getRoleInList(a.id)
	local bInList = getRoleInList(b.id)
	local aSix = getSumOfRoleSix(a.qua6)
	local bSix = getSumOfRoleSix(b.qua6)

	if aInList ~= bInList then
		return bInList < aInList
	end

	if aSix ~= bSix then
		return bSix < aSix
	else
		local aRarity = CharacterConfig.instance:getCfgInfoByID(a.id).quality
		local bRarity = CharacterConfig.instance:getCfgInfoByID(b.id).quality

		if aRarity ~= bRarity then
			return bRarity < aRarity
		else
			local aSix1 = a.qua6[1]
			local bSix1 = b.qua6[1]

			if aSix1 ~= bSix1 then
				return bSix1 < aSix1
			else
				local aSix2 = a.qua6[2]
				local bSix2 = b.qua6[2]

				if aSix2 ~= bSix2 then
					return bSix2 < aSix2
				else
					local aSix3 = a.qua6[3]
					local bSix3 = b.qua6[3]

					if aSix3 ~= bSix3 then
						return bSix3 < aSix3
					else
						local aSix4 = a.qua6[4]
						local bSix4 = b.qua6[4]

						if aSix4 ~= bSix4 then
							return bSix4 < aSix4
						else
							local aSix5 = a.qua6[5]
							local bSix5 = b.qua6[5]

							if aSix5 ~= bSix5 then
								return bSix5 < aSix5
							else
								local aSix6 = a.qua6[6]
								local bSix6 = b.qua6[6]

								if aSix6 ~= bSix6 then
									return aSix6 > bSix36
								else
									local aId = a.id
									local bId = b.id

									return bId < aId
								end
							end
						end
					end
				end
			end
		end
	end
end

return M
