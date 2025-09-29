-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/team/view/TeamMainViewView.lua

module("logic.extensions.team.view.TeamMainViewView", package.seeall)

local M = class("TeamMainViewView", ViewComponent)
local teamHeroMaxCount = 5
local mainCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()
local panelOffsetY = 0.1

function M:buildUI()
	self._btnReturn = self:getBtn("0&title_view_-878360263")
	self._btnHome = self:getBtn("0&title_view_1398742689")
	self._teamScrollGo = self:getGo("team_main_view_-1416082541")
	self._btnNext = self:getBtn("team_main_view_-433194858")
	self._roleInfoPlane = self:getGo("team_main_view_75042140")
	self._btnFilter = self:getBtn("team_main_view_-1460866784")
	self._heroScrollGo = self:getGo("team_main_view_-2090096595")
	self._teamRoleInfoBindGo = self:getGo("team_main_view_2087482")
	self._btnRestrainHint = self:getBtn("team_main_view_-1765743202")
	self._goCampBuffIcons = {
		[3] = self:getGo("team_main_view_686258881"),
		[4] = self:getGo("team_main_view_1929143694"),
		[5] = self:getGo("team_main_view_2003994668")
	}
	self._teamNameLoopList = LoopListHelper.New(self._teamScrollGo)

	self._teamNameLoopList:InitListView(0, self._updateTeamNameCell, self)

	self._teamHeroLoopList = LoopListHelper.New(self._heroScrollGo)

	self._teamHeroLoopList:InitListView(0, self._updateHeroCell, self)

	self._curTeamIndex = 1
end

function M:destroyUI()
	self._teamNameLoopList:Dispose()

	self._teamNameLoopList = nil

	self._teamHeroLoopList:Dispose()

	self._teamHeroLoopList = nil
	self._btnReturn = nil
	self._btnHome = nil
	self._teamScrollGo = nil
	self._btnNext = nil
	self._roleInfoPlane = nil
	self._btnFilter = nil
	self._heroScrollGo = nil
	self._teamRoleInfoBindGo = nil
	self._btnRestrainHint = nil

	table.clear(self._goCampBuffIcons)

	self._goCampBuffIcons = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self._btnNext:AddClickListener(self._onClickNext, self)
	self._btnFilter:AddClickListener(self._onClickFitler, self)
	self._btnRestrainHint:AddClickListener(self._onClickRestrainHint, self)
	GlobalDispatcher:addEventListener(EventType.REFRESH_TEAM_MAIN_VIEW, self._onRefreshTeamMainView, self)
	GlobalDispatcher:addEventListener(EventType.REFRESH_TEAM_INFO, self._onRefreshTeamHero, self)
	GlobalDispatcher:addEventListener(EventType.REFRESH_HERO_LIST, self._onRefreshHeroList, self)
	GlobalDispatcher:addEventListener(EventType.TEAM_FILTER_MAIN_VIEW, self._filterHeroDepotData, self)
	TeamDispatcher:addEventListener(TeamEventType.ON_HERO_HIT, self._onHitHero, self)
	TeamDispatcher:addEventListener(TeamEventType.ON_HIDE_ROLE_TIPS, self._onHideRoleTips, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	self._btnNext:RemoveClickListener()
	self._btnFilter:RemoveClickListener()
	self._btnRestrainHint:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.REFRESH_TEAM_MAIN_VIEW, self._onRefreshTeamMainView, self)
	GlobalDispatcher:removeEventListener(EventType.REFRESH_TEAM_INFO, self._onRefreshTeamHero, self)
	GlobalDispatcher:removeEventListener(EventType.REFRESH_HERO_LIST, self._onRefreshHeroList, self)
	GlobalDispatcher:removeEventListener(EventType.TEAM_FILTER_MAIN_VIEW, self._filterHeroDepotData, self)
	TeamDispatcher:removeEventListener(TeamEventType.ON_HERO_HIT, self._onHitHero, self)
	TeamDispatcher:removeEventListener(TeamEventType.ON_HIDE_ROLE_TIPS, self._onHideRoleTips, self)
end

function M:onEnter()
	TeamMainViewFacade.instance:registerView(self)

	self._selectedCharacterId = -1
	self._isDraging = false

	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Team)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Battle)

	local teamLen = #TeamModel.instance:getTeamData():getMoList()

	self._teamNameLoopList:SetListItemCount(teamLen, true)
	self:_clickTeamCallBack(self._curTeamIndex)

	self._rolesInfo = {}

	for i = 1, 5 do
		self._rolesInfo[i] = 0
	end

	self:_initTeamHeroInfo()
end

function M:onExit()
	self._selectedCharacterId = -1
	self._isDraging = false

	TeamUnitMgr.instance:onClear()
	self._teamNameLoopList:ClearCells()
	self._teamHeroLoopList:ClearCells()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Team)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Battle)
	GlobalDispatcher:dispatchEvent(EventType.CLEAR_RECORD_DATA_EVENT, CommEnum.HeroFilter.Team)
	TeamMainViewFacade.instance:unregisterView(self)
	table.clear(self._rolesInfo)
	table.clear(self._heroList)
	table.clear(self._unitList)
end

function M:_onRefreshTeamMainView()
	self._teamNameLoopList:RefreshAllShownItem()
	self._teamHeroLoopList:RefreshAllShownItem()
end

function M:_onRefreshTeamHero()
	self._heroList = {}

	table.insertto(self._heroList, HeroDepotModel.instance:getHeroDepotData():getShowDataList():getMoList())

	local heros = TeamModel.instance:getHerosInfoByID(self._curTeamIndex)

	if heros then
		for _, v in ipairs(heros) do
			self._rolesInfo[_] = v

			for hk, hv in ipairs(self._heroList) do
				if hv.id == v then
					table.removebyvalue(self._heroList, hv)

					break
				end
			end
		end
	end

	self._heroList = CharacterUtil.SortAndFitler(CommEnum.HeroFilter.Team, self._heroList)

	TeamModel.instance:setTempTeamData(self._heroList)

	local heroCount = #self._heroList

	self._teamHeroLoopList:SetListItemCount(heroCount, false)
	self._teamHeroLoopList:RefreshAllShownItem()
	self._teamNameLoopList:RefreshAllShownItem()
end

function M:_initTeamHeroInfo()
	TeamUnitMgr.instance:onClear()

	self._unitList = {}
	self._heroList = {}

	table.insertto(self._heroList, HeroDepotModel.instance:getHeroDepotData():getShowDataList():getMoList())

	local heros = TeamModel.instance:getHerosInfoByID(self._curTeamIndex)

	if heros then
		for _, v in ipairs(heros) do
			self._rolesInfo[_] = v

			self:_createHero(_, v)

			for hk, hv in ipairs(self._heroList) do
				if hv.id == v then
					table.removebyvalue(self._heroList, hv)

					break
				end
			end
		end
	end

	self._heroList = CharacterUtil.SortAndFitler(CommEnum.HeroFilter.Team, self._heroList)

	TeamModel.instance:setTempTeamData(self._heroList)
	self:_onRefreshHeroList(nil, false, true)
end

function M:_createHero(index, heroid, placeEffect)
	if heroid > 0 then
		local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroid)

		if heroMO then
			local unit = self:_createDragUnitByIndex(heroMO, index)

			if placeEffect then
				EffectUtil.playEffect(BattleConst.PLACE_ENTITY2, unit.go)
			end

			self._unitList[index] = unit
		end
	else
		self:_setHighlight(index, false)
		self:_setCampInfo(index, nil)
		self:_setEmptyEffect(index, true)
	end
end

function M:getUnitByIndex(index)
	return self._unitList[index] or false
end

function M:_onRefreshHeroList(name, refresh, resetPos)
	if refresh then
		self._heroList = CharacterUtil.SortAndFitler(CommEnum.HeroFilter.Team, TeamModel.instance:getTempTamData())

		TeamModel.instance:setTempTeamData(self._heroList)
	end

	local heroCount = #TeamModel.instance:getTempTamData()
	local needReset = resetPos or false

	self._teamHeroLoopList:SetListItemCount(heroCount, needReset)
end

function M:getRoleInfoBind()
	return self._roleInfoPlane
end

function M:checkTeamUnlock()
	return TeamModel.instance:checkTeamStateByIndex(self._curTeamIndex)
end

function M:_saveTeamInfo()
	local name = TeamModel.instance:getTeamNameByID(self._curTeamIndex)

	TeamAgent.instance:sendSaveTeamRoleRequest(self._curTeamIndex, name, self._rolesInfo)
end

function M:_updateRolesInfo(gid, uuid)
	self._rolesInfo[gid] = uuid

	self:_saveTeamInfo()
	self:_updateCampInfo()
end

function M:_updateBottomInfo(index, heroId)
	if heroId == 0 then
		self:_setHighlight(index, false)
		self:_setCampInfo(index, nil)
		self:_setEmptyEffect(index, true)

		return
	end

	local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

	if heroMO then
		self:_setHighlight(index, self:_getQualityHdrColor(heroMO:getQuality()))
		self:_setCampInfo(index, self:_getCampStr(heroMO:getCamp()))
		self:_setEmptyEffect(index, false)
	end
end

function M:updateUnitList(index, unit)
	if self._unitList then
		self._unitList[index] = unit and unit or false
	end
end

function M:_onClickFitler()
	local _tmpList = {}

	table.insertto(_tmpList, HeroDepotModel.instance:getHeroDepotData():getShowDataList():getMoList())

	local heros = TeamModel.instance:getHerosInfoByID(self._curTeamIndex)

	if heros then
		for _, v in ipairs(heros) do
			for hk, hv in ipairs(_tmpList) do
				if hv.id == v then
					table.removebyvalue(_tmpList, hv)

					break
				end
			end
		end
	end

	ViewMgr.instance:open(ViewName.HeroFilterTipsView, {
		moduleType = CommEnum.HeroFilter.Team,
		data = _tmpList,
		confirmEvent = EventType.TEAM_FILTER_MAIN_VIEW
	})
end

function M:_onClickReturn()
	local sceneFlow = SceneFace.instance:getCurSceneFlow()

	if sceneFlow then
		SceneFace.instance:exitScene()
		SceneFace.instance:enterRoomScene()
		self:back()
	end
end

function M:_onClickHome()
	return
end

function M:_onClickRestrainHint()
	ViewMgr.instance:open(ViewName.BattleRestrainHintViewPresentor)
end

function M:_filterHeroDepotData(name, datalist)
	self._heroList = datalist

	TeamModel.instance:setTempTeamData(self._heroList)
	self:_onRefreshHeroList()
end

function M:_updateTeamNameCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._teamNameLoopList:NewListViewItem("team_name_item")
	local teamList = TeamModel.instance:getTeamData():getMoList()
	local teamInfo = teamList[curIndex]
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, TeamNameItemComponet)

	shower:setCellData(teamInfo, curIndex)
	shower:setClickTeam(self._clickTeamCallBack, self)
	shower:setSelectState(curIndex == self._curTeamIndex)

	return item
end

function M:_updateHeroCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._teamHeroLoopList:NewListViewItem("battleheroitem")
	local heroData = self._heroList[curIndex]
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, TeamHeroItemComponet)

	shower:setHandler(self)
	shower:setPassToGameObject(self._heroScrollGo)
	shower:setHeroMO(heroData, curIndex)
	shower:setEnable(true)

	return item
end

function M:_clickTeamCallBack(index)
	if self._curTeamIndex == index then
		return
	end

	self:cancelSelectedCharacter()

	self._curTeamIndex = index

	self:_initTeamHeroInfo()
	self._teamNameLoopList:RefreshAllShownItem()
	self:_updateCampInfo()
end

function M:_updateCampInfo()
	local campBuffCO = self:_judgeEffectiveCampBuffCO()
	local targetCount = campBuffCO and campBuffCO.count or false

	for count, go in pairs(self._goCampBuffIcons) do
		if count == targetCount then
			goutil.setActive(go, true)
		else
			goutil.setActive(go, false)
		end
	end
end

function M:_judgeEffectiveCampBuffCO()
	local teamCodeList = {}

	for i = 1, #self._rolesInfo do
		if self._rolesInfo[i] > 0 then
			table.insert(teamCodeList, self._rolesInfo[i])
		end
	end

	local maxCount = BattleCampAdjustmentUtil.calculateMaxSameCampCount(teamCodeList)

	return BattleConfig.instance:getCampBuffCOByCount(maxCount)
end

function M:_onClickNext()
	local len = #TeamModel.instance:getTeamData():getMoList()

	if len > self._curTeamIndex then
		self._curTeamIndex = self._curTeamIndex + 1
	end

	self:_clickTeamCallBack(self._curTeamIndex)
	self._teamNameLoopList:MoveToItemIndex(self._curTeamIndex - 1)
end

function M:onClickHeadItem(headItem)
	if self._isDraging then
		return
	end

	local heroId = headItem:getHeroId()

	ToolTipsMgr.showHeroInfoTip(heroId, false, self._teamRoleInfoBindGo)
	self:setSelectedCharacter(heroId)
end

function M:_onHitHero(key, heroId)
	if self._isDraging then
		return
	end

	ToolTipsMgr.showHeroInfoTip(heroId, false, self._teamRoleInfoBindGo)
end

function M:onBeginDragHeadItem(headItem, screenX, screenY)
	self._isDraging = true

	BattleCampAdjustmentUtil.clearOperateUnit()

	self._dragUnit = self:_createDragUnit(headItem:getHeroMO())

	self:setSelectedCharacter(headItem:getHeroId(), true)
	self:onDragHeadItem(headItem, screenX, screenY)
end

function M:_createDragUnit(heroMO, index)
	local unit = TeamUnitMgr.instance:createUnit(heroMO, index)

	return unit
end

function M:_getQualityHdrColor(quality)
	local color = {
		[GameEnum.QualityEnum.S] = {
			g = 0.16470588235294117,
			b = 0.011764705882352941,
			f = 2.5,
			r = 0.7490196078431373
		},
		[GameEnum.QualityEnum.A] = {
			g = 0,
			b = 0.7490196078431373,
			f = 2.8,
			r = 0.30980392156862746
		},
		[GameEnum.QualityEnum.B] = {
			g = 0.2196078431372549,
			b = 0.7490196078431373,
			f = 2.8,
			r = 0
		},
		[GameEnum.QualityEnum.C] = {
			g = 0.7490196078431373,
			b = 0.13333333333333333,
			f = 2.5,
			r = 0
		}
	}
	local factor = Mathf.Pow(2, color[quality].f)

	return Color.New(color[quality].r * factor, color[quality].g * factor, color[quality].b * factor)
end

function M:_createDragUnitByIndex(heroMO, index)
	local unit = self:_createDragUnit(heroMO, index)

	if index then
		local x, y, z = self:_getPositionByIndex(index)

		Astral.TransformUtil.SetPos(unit.go.transform, x, panelOffsetY, z)
		self:_setHighlight(index, self:_getQualityHdrColor(heroMO:getQuality()))
		self:_setCampInfo(index, self:_getCampStr(heroMO:getCamp()))
		self:_setEmptyEffect(index, false)
	else
		Astral.TransformUtil.SetPos(unit.go.transform, -9999, 0, 0)
	end

	return unit
end

function M:_getCampStr(campIndex)
	local tempCamp = {
		"s510_plane_zy_oad-d",
		"s510_plane_zy_ya-d",
		"s510_plane_zy_zhenli-d",
		"s510_plane_zy_bai-d",
		"s510_plane_zy_nuo-d",
		"s510_plane_zy_xing-d",
		"s510_plane_zy_shui-d"
	}

	return tempCamp[campIndex]
end

function M:setPosByIndex(unit, index)
	if not unit then
		return
	end

	local x, y, z = self:_getPositionByIndex(index)

	Astral.TransformUtil.SetPos(unit.go.transform, x, panelOffsetY, z)
end

function M:_getPositionByIndex(index)
	local scene = SceneMgr.instance:getScene(SceneType.Team)
	local posList = scene.stage:getPosList()
	local posKey = scene.stage:getPosKey()
	local curPosName = posKey .. tostring(index)

	for _, v in pairs(posList) do
		if v.name == curPosName then
			return Astral.TransformUtil.GetPos(v.transform, 0, 0, 0)
		end
	end
end

function M:_setEmptyEffect(index, active)
	local scene = SceneMgr.instance:getScene(SceneType.Team)
	local emptyList = scene.stage:getEmptyList()
	local emptyKey = scene.stage:getEmptyKey()
	local curName = emptyKey .. tostring(index)

	for _, v in pairs(emptyList) do
		if v.name == curName then
			scene.stage:setEemptyState(_, active)

			break
		end
	end
end

function M:_setHighlight(index, colorString)
	local scene = SceneMgr.instance:getScene(SceneType.Team)
	local lightList = scene.stage:getLightList()
	local lightKey = scene.stage:getLightKey()
	local curLightName = lightKey .. tostring(index)

	for _, v in pairs(lightList) do
		if v.name == curLightName then
			scene.stage:setLight(_, colorString)

			break
		end
	end
end

function M:setHighlight(index, colorString)
	self:_setHighlight(index, colorString)
end

function M:setCampInfo(index, name)
	self:_setCampInfo(index, name)
end

function M:_setCampInfo(index, name)
	local scene = SceneMgr.instance:getScene(SceneType.Team)
	local campList = scene.stage:getCampList()
	local campKey = scene.stage:getCampKey()
	local curCmapName = campKey .. tostring(index)
	local campTextureRes = false
	local campTexture

	if name then
		campTextureRes = self:getRes(GameUrl.getTeamCampUrl(name))
	end

	if campTextureRes then
		campTexture = campTextureRes:GetAsset()
	end

	for _, v in pairs(campList) do
		if v.name == curCmapName then
			scene.stage:setCamp(_, campTexture)

			break
		end
	end
end

function M:onDragHeadItem(headItem, screenX, screenY)
	local x, y, z = TeamScenePickerViewFacade.instance:testHitScreenPoint(screenX, screenY - 80)

	if not x then
		return
	end

	if self._dragUnit then
		Astral.TransformUtil.SetPos(self._dragUnit.go.transform, x, panelOffsetY, z)
	end
end

function M:onEndDragHeadItem(headItem, screenX, screenY)
	self._isDraging = false

	local characterCode = headItem:getHeroId()
	local index = self:_getPlaceUnionIndex(screenX, screenY)

	if not index then
		self:_destroyDragUnit()
		self:cancelSelectedCharacter()

		return
	end

	local targetUnit = self:getUnitByIndex(index)

	if targetUnit then
		TeamUnitGenerator.destroyUnit(targetUnit)
		self:_setHighlight(index, false)
		self:_setCampInfo(index, nil)
		self:_setEmptyEffect(index, true)
	end

	self:_destroyDragUnit()
	self:_createHero(index, characterCode, true)
	self:cancelSelectedCharacter()
	self:_updateRolesInfo(index, characterCode)
end

function M:cancelSelectedCharacter()
	if self._selectedCharacterId == -1 then
		return
	end

	self._selectedCharacterId = -1

	self:_updateScrollView()
	ViewMgr.instance:close(ViewName.RoleInfoTipsViewPresentor)
end

function M:_removeFromTeamMOList(characterCode)
	for index, heroMO in ipairs(self._heroList) do
		if characterCode == heroMO:getId() then
			table.remove(self._heroList, index)

			return index
		end
	end

	return false
end

function M:_destroyDragUnit()
	if self._dragUnit then
		TeamUnitGenerator.destroyUnit(self._dragUnit)

		self._dragUnit = false
	end
end

function M:_getPlaceUnionIndex(screenX, screenY)
	local hitObjct = TeamScenePickerViewFacade.instance:checkScreenPoint(screenX, screenY)

	if not hitObjct then
		return
	end

	local index = TeamMainViewFacade.instance:getIndexByHitGO(hitObjct)

	if index then
		return index
	end
end

function M:setSelectedCharacter(characterId, hideMainView)
	if self._selectedCharacterId == characterId then
		self:cancelSelectedCharacter()

		return
	end

	self._selectedCharacterId = characterId

	GlobalDispatcher:dispatchEvent(EventType.SELECT_TEAM_HERO_EVENT, characterId)
end

function M:_onHideRoleTips()
	if self._selectedCharacterId > 0 then
		self:cancelSelectedCharacter()
	end
end

function M:_updateScrollView()
	self._teamHeroLoopList:RefreshAllShownItem()
end

return M
