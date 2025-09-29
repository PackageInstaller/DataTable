-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/layout/AirWorkLayoutOverView.lua

module("logic.extensions.airworkshop.flow.defflow.view.layout.AirWorkLayoutOverView", package.seeall)

local M = class("AirWorkLayoutOverView", AirWorkMapBaseView)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	M.super.buildUI(self)

	self._mapRootGo = self:getGo("air_workshop_overview_tips_-1236083249")
	self._btnClose = self:getBtn("air_workshop_overview_tips_-170231369")
	self._toggle = self:getUIComponent("air_workshop_overview_tips_1131262218", UIComponentType.SpaceXToggle)
	self._panelRoleGo = self:getGo("air_workshop_overview_tips_-1244272932")
	self._panelBuildingGo = self:getGo("air_workshop_overview_tips_891373907")
	self._panelMessageGo = self:getGo("air_workshop_overview_tips_-2044471580")
	self._messageGo = self:getGo("air_workshop_overview_tips_796598862")
	self._msgConditionGo = self:getGo("air_workshop_overview_tips_-24203309")
	self._msgTimeGo = self:getGo("air_workshop_overview_tips_848934604")
	self._txtCondition = self:getText("air_workshop_overview_tips_-1587396091")
	self._txtTime = self:getText("air_workshop_overview_tips_1640012302")
	self._txtMsgContent = self:getUIComponent("air_workshop_overview_tips_-1387585284", UIComponentType.TextMeshProUGUI)
	self._imgEmoji = self:getImage("air_workshop_overview_tips_645620957")

	self:createMap()
end

function M:bindEvents()
	M.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._toggle:AddListener(self._onToggle, self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._toggle:RemoveListener()
end

function M:_addEvents(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.AIRWORKSHOP_LAYOUT_CHANGE, self._modifyData, self)
		GlobalDispatcher:addEventListener(LeaveMsgEventType.ON_EDIT_MSG_SAVE, self._refreshMsg, self)
	else
		GlobalDispatcher:removeEventListener(EventType.AIRWORKSHOP_LAYOUT_CHANGE, self._modifyData, self)
		GlobalDispatcher:removeEventListener(LeaveMsgEventType.ON_EDIT_MSG_SAVE, self._refreshMsg, self)
	end
end

function M:onEnter()
	self:_addEvents(true)

	local currModel = AirWorkShopDefMgr.instance:getModel()

	self._mapData = currModel:getModiedMapMO()

	self:_setMapData()

	self._toggle.IsOn = false
end

function M:onExitFinished()
	self:_addEvents(false)
	M.super.onExitFinished(self)
	self:_hideRightPanel()
end

function M:destroyUI()
	M.super.destroyUI(self)
end

function M:_hideRightPanel()
	goutil.setActive(self._panelRoleGo, false)
	goutil.setActive(self._panelBuildingGo, false)
	goutil.setActive(self._panelMessageGo, false)
	goutil.setActive(self._messageGo, false)
end

function M:_refreshMsg()
	if self._curClickIndex then
		self:_onGridClick(self._curClickIndex)
	end
end

function M:_onGridClick(index)
	M.super.onGridClick(self, index)

	self._curClickIndex = index

	local showType = self._mapGridsDataType[index]
	local isShowPanelRole = self:_isRoleType(showType)
	local isShowPanelBuilding = self:_isBuildingType(showType)
	local isShowPanelMessage = self:_isMsgBuildingType(showType)
	local hasMsg = self:_isMessageType(index)
	local x, y = AirWorkShopUtil.convertToXY(index)

	if self._isCheckMessage and not hasMsg then
		return
	end

	goutil.setActive(self._panelRoleGo, isShowPanelRole)
	goutil.setActive(self._panelBuildingGo, isShowPanelBuilding)
	goutil.setActive(self._panelMessageGo, isShowPanelMessage)

	local data = self:_getGridData(index, showType)

	if isShowPanelRole then
		local panelView = Astral.LuaComponentContainer.Add(self._panelRoleGo, AirWorkLayoutRolePanel)

		panelView:updateData(data, index)
	end

	if isShowPanelBuilding then
		local panelView = Astral.LuaComponentContainer.Add(self._panelBuildingGo, AirWorkLayoutBuildingPanel)

		panelView:updateData(data, index)
	end

	if isShowPanelMessage then
		local panelView = Astral.LuaComponentContainer.Add(self._panelMessageGo, AirWorkLayoutMessagePanel)

		panelView:updateData(data, index)
	end

	goutil.setActive(self._messageGo, hasMsg)
	goutil.setActive(self._msgConditionGo, showType == AirWorkShopEnum.UnitType.Ambush)

	local messageMO = data and data:getMsgMO() or false

	if messageMO then
		local triggerCondition = messageMO:getCondition()
		local triggerParam = messageMO:getParams()
		local curMsgMO = messageMO:getLeaveMsgMO()
		local leaveMsgMO = curMsgMO:deepCopy()
		local subject1 = leaveMsgMO:getMsgTabContent(1, LeaveMsgEnum.MsgPartType.Subject)
		local word1 = leaveMsgMO:getMsgTabContent(1, LeaveMsgEnum.MsgPartType.Word)
		local conjunction = leaveMsgMO:getMsgTabContent(2, LeaveMsgEnum.MsgPartType.Joiner)
		local subject2 = leaveMsgMO:getMsgTabContent(2, LeaveMsgEnum.MsgPartType.Subject)
		local word2 = leaveMsgMO:getMsgTabContent(2, LeaveMsgEnum.MsgPartType.Word)
		local voiceId = leaveMsgMO:getVoice()
		local heroId = leaveMsgMO:getVoiceHero()
		local heroName = "..."

		if heroId > 0 then
			heroId = heroId < 2000000 and heroId + 2000000 or heroId
			heroName = ContainmentUtil.getHeroName(heroId)
		end

		local voiceName = "..."

		if voiceId > 0 then
			local audioId = voiceId % 1000
			local cfg = CharacterAudioConfig.instance:getCharacterAudioCOByHeroIdAndAudioId(heroId, audioId)

			voiceName = cfg and cfg.audioName or voiceName
		end

		local airMsgCO = AirWorkShopConfig.instance:getMessageConditionCO(triggerCondition)

		self._txtMsgContent.text = string.format("%s %s %s %s %s\n%s %s", subject1, word1, conjunction, subject2, word2, heroName, voiceName)

		if airMsgCO then
			if airMsgCO.limit then
				self._txtTime.text = string.format(airMsgCO.descStr, triggerParam)
			else
				self._txtTime.text = airMsgCO.descStr
			end
		end

		if leaveMsgMO then
			local emoji = leaveMsgMO:getEmoji() or false

			self:_updateEmoji(emoji)
		end
	end
end

function M:_updateEmoji(emoji)
	if emoji and emoji > 0 then
		local cfg = ChatConfig.instance:getConfigByKey(ConfigName.ChatEmoji, emoji)

		if cfg then
			goutil.setActive(self._imgEmoji.gameObject, true)
			IconLoader.setSprite(self._imgEmoji, IconType.ChatEmoji, cfg.icon)
		else
			goutil.setActive(self._imgEmoji.gameObject, false)
		end
	else
		goutil.setActive(self._imgEmoji.gameObject, false)
	end
end

function M:_isRoleType(showType)
	local isShowPanelRole = showType == AirWorkShopEnum.UnitType.Hero or showType == AirWorkShopEnum.UnitType.Ambush

	return isShowPanelRole
end

function M:_isMessageType(index)
	local isShowPanelMessage = self:hasMessage(index)

	return isShowPanelMessage
end

function M:_isBuildingType(showType)
	local isShowPanelBuilding = showType == AirWorkShopEnum.UnitType.Building or showType == AirWorkShopEnum.UnitType.GroundBuilding or showType == AirWorkShopEnum.UnitType.MountainBuilding

	return isShowPanelBuilding
end

function M:_isMsgBuildingType(showType)
	local isShowPanelMsgBuilding = showType == AirWorkShopEnum.UnitType.SpecialBuilding

	return isShowPanelMsgBuilding
end

function M:_getGridData(index, type)
	local x, y = AirWorkShopUtil.convertToXY(index)

	if self:_isBuildingType(type) or self:_isMsgBuildingType(type) then
		for i, v in ipairs(self._mapData:getBuildingList()) do
			local x1, y1 = v:getPosition()

			if x == x1 and y == y1 then
				return v
			end
		end
	end

	if self:_isRoleType(type) then
		if type == AirWorkShopEnum.UnitType.Hero then
			for i, v in ipairs(self._mapData:getHeroMOList()) do
				local x1, y1 = v:getPosition()

				if x == x1 and y == y1 then
					return v
				end
			end
		end

		if type == AirWorkShopEnum.UnitType.Ambush then
			for i, v in ipairs(self._mapData:getAmbushMOList()) do
				local x1, y1 = v:getPosition()

				if x == x1 and y == y1 then
					return v
				end
			end
		end
	end
end

function M:_modifyData(e, data)
	self:_hideRightPanel()

	local unitMgr = AirWorkShopDefMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(data:getEntityId())

	AirWorkShopDefSceneUtil.requestRemoveEntity(unit)
	self:refreshMap()
end

function M:_onToggle(toggle, isOn)
	self._isCheckMessage = isOn

	self:_hideRightPanel()
	self:lookMessage(isOn)
end

function M:_onClickClose()
	self:close()
end

return M
