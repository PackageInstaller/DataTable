-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/manager/AirWorkManagePanel.lua

module("logic.extensions.airworkshop.flow.defflow.view.manager.AirWorkManagePanel", package.seeall)

local M = class("AirWorkManagePanel")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject.transform.parent.transform.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)

	self:_buildUI()

	self._canClick = true
end

function M:_buildUI()
	self._editTipsGo = self._registry:getGo("air_workshop_level_manage_view_-994465879")
	self._btnMask = self._registry:getBtn("8&empty_mask_tips_29887572")
	self._btnMessage = self._registry:getBtn("air_workshop_level_manage_view_1805420258")
	self._btnDetail = self._registry:getBtn("air_workshop_level_manage_view_-821886826")
	self._btnStatistic = self._registry:getBtn("air_workshop_level_manage_view_986107986")
	self._btnRecord = self._registry:getBtn("air_workshop_level_manage_view_690775047")
	self._btnClear = self._registry:getBtn("air_workshop_level_manage_view_-2001781269")
	self._btnEdit = Astral.SimpleLuaComponentContainer.Add(self._registry:findUIElement("16&btn_left_-1571983320"), CommButton)
	self._btnTest = Astral.SimpleLuaComponentContainer.Add(self._registry:findUIElement("12&btn_right_1251431307"), CommButton)
	self._goRedPointMessage = goutil.findChild(self._btnMessage.gameObject, "red_point")
	self._txtId = self._registry:getText("air_workshop_level_manage_view_746101127")
	self._txtName = self._registry:getText("air_workshop_level_manage_view_-1462008222")
	self._txtMessage = self._registry:getText("air_workshop_level_manage_view_30193884")
	self._txtLike = self._registry:getText("air_workshop_level_manage_view_906567983")
	self._txtConditDesc = self._registry:getText("air_workshop_level_manage_view_-670304085")
	self._txtScore = self._registry:getText("air_workshop_level_manage_view_2079256860")
	self._txtPlayCount = self._registry:getText("air_workshop_level_manage_view_1535878459")
	self._txtPassRate = self._registry:getText("air_workshop_level_manage_view_-1743370067")
	self._statusTestNo = self._registry:getGo("air_workshop_level_manage_view_2090507747")
	self._statusTestYes = self._registry:getGo("air_workshop_level_manage_view_-1636589573")
	self._tagGroupGo = self._registry:getGo("air_workshop_level_manage_view_-1650623363")
	self._tagGo = self._registry:getGo("air_workshop_level_manage_view_1822491036")

	goutil.addChildToParent(self._tagGo, self._tagGroupGo.transform.parent.gameObject)
	goutil.setActive(self._tagGo, false)

	local scrollRectGo = self._registry:getGo("air_workshop_level_manage_view_475555355")

	self._loopList = LoopListHelper.New(scrollRectGo)

	self._loopList:InitListView(0, self._updateCell, self)

	scrollRectGo = self._registry:getGo("air_workshop_level_manage_view_-160246509")
	self._loopList1 = LoopListHelper.New(scrollRectGo)

	self._loopList1:InitListView(0, self._updateCell1, self)
	self:_bindEvents()
end

function M:_bindEvents()
	GlobalDispatcher:addEventListener(EventType.RED_DOT_UPDATE_EVENT, self._refreshRedDot, self)
	self._btnMask:AddClickListener(self._onClickMask, self)
	self._btnDetail:AddClickListener(self._onClickDetail, self)
	self._btnStatistic:AddClickListener(self._onClickStatistic, self)
	self._btnRecord:AddClickListener(self._onClickRecord, self)
	self._btnClear:AddClickListener(self._onClickClear, self)
	self._btnEdit:AddClickListener(self._onClickEdit, self)
	self._btnTest:AddClickListener(self._onClickTest, self)
	self._btnMessage:AddClickListener(self._onClickMessage, self)
end

function M:_unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.RED_DOT_UPDATE_EVENT, self._refreshRedDot, self)
	self._btnMask:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
	self._btnStatistic:RemoveClickListener()
	self._btnRecord:RemoveClickListener()
	self._btnClear:RemoveClickListener()
	self._btnEdit:RemoveClickListener()
	self._btnTest:RemoveClickListener()
	self._btnMessage:RemoveClickListener()
end

function M:OnDestroy()
	self:_unbindEvents()

	for _, item in ipairs(self._itemViewList or {}) do
		item:unbindEvents()
	end

	removetimer(self._resetClick, self)
end

function M:_refreshRedDot()
	if not self._goRedPointMessage or goutil.isNil(self._goRedPointMessage) then
		return
	end

	local isActive = false
	local mapId = self._data:getId()
	local redPointLstFromServer = RedDotModel.instance:getRedDotDetailList(GameEnum.RedPointEnum.AirMapComment) or {}

	for _, idStr in ipairs(redPointLstFromServer) do
		if not isActive and tonumber(idStr) == tonumber(mapId) then
			isActive = true
		end
	end

	goutil.setActive(self._goRedPointMessage.gameObject, isActive)
end

function M:_onClickDetail()
	goutil.setActive(self._editTipsGo, true)
end

function M:_onClickMask()
	goutil.setActive(self._editTipsGo, false)
end

function M:_onClickStatistic()
	local params = {}

	params.mapId = self._data:getId()
	params.showTabCount = 3

	ViewMgr.instance:open(ViewName.AirWorkShopStatisticView, params)
end

function M:_onClickRecord()
	ViewMgr.instance:open(ViewName.AirWorkShopRecordView, self._data)
end

function M:_onClickClear()
	local dialog = Dialog.showWarnMessage(lang("tip_title"), lang("tip_air_workshop_manager_delete"))

	dialog:setConfirmListener(function()
		AirWorkShopDefAgent.instance:sendDeleteAirMapRequest(self._data:getId())
	end, self)
end

function M:_onClickEdit()
	AirWorkShopModel.instance:saveLastEditLevelMo(self._data)
	AirWorkShopDefMgr.instance:enter(self._data:getId())
end

function M:_onClickMessage()
	local hideEditBtn = true
	local editBtnInteractable = false

	AirWorkShopDefAgent.instance:sendReadMapCommentsRequest({
		self._data:getId()
	})
	ToolTipsMgr.showAirWorkShopMessageLogTipsView(self._data:getId(), self._data:getCover(), hideEditBtn, editBtnInteractable)
end

function M:_onClickTest()
	if not self._data:getPassTest() then
		AirWorkShopDefAgent.instance:sendTestAirMapRequest(self._data:getId())
	else
		if not self._canClick then
			FloatWordMgr.instance:show(lang("操作太快，请稍后再尝试"))

			return
		end

		self._canClick = false

		settimer(2, self._resetClick, self, false)

		if not self._data:getOnlineStatus() then
			AirWorkShopDefAgent.instance:sendModifyAirMapOnlineStateRequest(self._data:getId(), true)
		else
			AirWorkShopDefAgent.instance:sendModifyAirMapOnlineStateRequest(self._data:getId(), false)
		end
	end
end

function M:_resetClick()
	self._canClick = true
end

function M:updateData(data)
	self._data = data

	local mapMo = self._data:getMapMO()
	local statMo = self._data:getStatMO()
	local sceneCo = AirWorkShopConfig.instance:getSceneCO(mapMo:getSceneId())
	local levelCo = BattleConfig.instance:getBattleLevelCO(sceneCo.levelId)

	goutil.setActive(self._editTipsGo, false)
	goutil.setActive(self._statusTestNo, not self._data:getPassTest())
	goutil.setActive(self._statusTestYes, self._data:getPassTest())

	self._txtId.text = string.format("ID：%s", self._data:getId())
	self._txtName.text = levelCo.levelName
	self._txtScore.text = statMo:getPoint()
	self._txtPlayCount.text = statMo:getPlayCount()
	self._txtPassRate.text = statMo:getPlayCount() == 0 and "--" or string.format("%.1f", statMo:getPassRate() * 100) .. "%"
	self._txtMessage.text = statMo:getCommentCount()
	self._txtLike.text = statMo:getLikeCount()

	if not self._data:getPassTest() then
		self._btnTest:setText(lang("tip_air_workshop_manager_test"))
	elseif not self._data:getOnlineStatus() then
		self._btnTest:setText(lang("tip_air_workshop_manager_putOn"))
	else
		self._btnTest:setText(lang("tip_air_workshop_manager_putOff"))
	end

	local condition = mapMo:getCondition()

	if condition then
		local co = AirWorkShopConfig.instance:getConfigByKey(ConfigName.AirStudioWinCondition, condition.id)

		if co then
			local heroId = 0
			local posX, posY = 0, 0

			if co.type == AirWorkShopEnum.ConditionType.Kill then
				heroId = condition.params[1]
			end

			if co.type == AirWorkShopEnum.ConditionType.Move then
				posX = condition.params[1]
				posY = condition.params[2]
			end

			if heroId ~= 0 then
				local characterCo = CharacterConfig.instance:getCfgInfoByID(heroId)
				local heroInfoCo = PastInfoConfig.instance:getCharacterInfo(heroId)
				local colorStr = CommEnum.LotteryCardQualityColor[characterCo.quality]

				self._txtConditDesc.text = string.gsub(co.describe, lang("tip_air_condition_card"), string.format("<color=%s>%s</color>", colorStr, heroInfoCo.name))
			else
				self._txtConditDesc.text = lang("tip_air_condition_move")
			end
		else
			self._txtConditDesc.text = AirWorkShopConfig.instance:getStudioConst("WinDefaultDesc").strValue
		end
	else
		self._txtConditDesc.text = AirWorkShopConfig.instance:getStudioConst("WinDefaultDesc").strValue
	end

	goutil.clearChildren(self._tagGroupGo)

	local tagIdList = statMo:getTags()

	for i, v in ipairs(tagIdList) do
		local tagGo = goutil.cloneAndSetParent(self._tagGo, self._tagGroupGo.transform, "tag" .. i)

		goutil.setActive(tagGo, true)

		local tagCo = AirWorkShopConfig.instance:getConfigByKey(ConfigName.AirStudioTag, v)
		local txtName = goutil.findChildTextComponent(tagGo, "txt1")

		txtName.text = tagCo.tagName
	end

	self:_setListData()
	self:_refreshRedDot()
end

function M:_setListData()
	local mapMo = self._data:getMapMO()

	self._itemViewList = {}
	self._heroMoList = mapMo:getHeroMOList()

	local itemCount = #self._heroMoList

	self._loopList:SetListItemCount(itemCount)
	self._loopList:RefreshAllShownItem()

	self._ambushMoList = mapMo:getAmbushMOList()

	local itemCount = #self._ambushMoList

	self._loopList1:SetListItemCount(itemCount)
	self._loopList1:RefreshAllShownItem()
end

function M:_updateCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopList:NewListViewItem("hero_item")
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, HeroHeadItem)
	local heroId = self._heroMoList[curIndex]:getId()
	local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

	shower:setHeroMO(heroData)

	local level = self._heroMoList[curIndex]:getLevel()

	shower:setLevel(level)
	table.insert(self._itemViewList, shower)

	return item
end

function M:_updateCell1(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopList1:NewListViewItem("hero_item")
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, HeroHeadItem)
	local heroId = self._ambushMoList[curIndex]:getId()
	local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

	shower:setHeroMO(heroData)

	local oldLevel = self._ambushMoList[curIndex]:getLevel()

	shower:setLevel(oldLevel)
	table.insert(self._itemViewList, shower)

	return item
end

return M
