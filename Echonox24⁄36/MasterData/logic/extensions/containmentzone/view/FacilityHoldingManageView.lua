-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingManageView.lua

module("logic.extensions.containmentzone.view.FacilityHoldingManageView", package.seeall)

local M = class("FacilityHoldingManageView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._btnChange = self:getBtn("facility_holding_manage_view_1388083395")
	self._btnUpGrade = self:getBtn("facility_holding_manage_view_1756033809")
	self._btnDetial = self:getBtn("facility_holding_manage_view_-376525557")
	self._txtReturnBtn = self:getText("2&title_view_-788888785")
	self._txtFacilityName = self:getText("facility_holding_manage_view_1442798740")
	self._txtFacilityLv = self:getText("facility_holding_manage_view_633374811")
	self._txtSerialNumber = self:getText("facility_holding_manage_view_778606449")
	self._imgProtomerIcon = self:getImage("facility_holding_manage_view_531315320")
	self._txtProtomerName = self:getText("facility_holding_manage_view_549977329")
	self._goPrototypeGroup = self:getGo("facility_holding_manage_view_-509025481")
	self._goPrototypeItem = self:getGo("facility_holding_manage_view_1163294503")
	self._txtDesc = self:getText("facility_holding_manage_view_466556514")
	self._txtYieldBase = self:getText("facility_holding_manage_view_-1089015985")
	self._goYieldBlue = self:getGo("facility_holding_manage_view_1337580578")
	self._txtYieldBlue = self:getText("facility_holding_manage_view_186078152")
	self._goYieldRed = self:getGo("facility_holding_manage_view_789072702")
	self._txtYieldRed = self:getText("facility_holding_manage_view_1657683854")
	self._txtMoodBase = self:getText("facility_holding_manage_view_1102746378")
	self._goMoodBlue = self:getGo("facility_holding_manage_view_540856019")
	self._txtMoodBlue = self:getText("facility_holding_manage_view_1580846084")
	self._goScrollReward = self:getScrollRect("facility_holding_manage_view_418290601")
	self._goRewardItem = self:getGo("0&rewards_detail_item_2141037416")
	self._loopListHelper = LoopListHelper.New(self._goScrollReward)

	self._loopListHelper:InitListView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	self._guiAnimation = nil
	self._btnChange = nil
	self._btnUpGrade = nil
	self._btnDetial = nil
	self._txtReturnBtn = nil
	self._txtFacilityName = nil
	self._txtFacilityLv = nil
	self._txtSerialNumber = nil
	self._imgProtomerIcon = nil
	self._txtProtomerName = nil
	self._goPrototypeGroup = nil
	self._goPrototypeItem = nil
	self._txtDesc = nil
	self._txtYieldBase = nil
	self._goYieldBlue = nil
	self._txtYieldBlue = nil
	self._goYieldRed = nil
	self._txtYieldRed = nil
	self._txtMoodBase = nil
	self._goMoodBlue = nil
	self._txtMoodBlue = nil
	self._goScrollReward = nil
	self._goRewardItem = nil

	self._loopListHelper:Dispose()

	self._loopListHelper = nil
end

function M:bindEvents()
	self._btnChange:AddClickListener(self._onClickChange, self)
	self._btnUpGrade:AddClickListener(self._onClickUpGrade, self)
	self._btnDetial:AddClickListener(self._onClickDetial, self)
end

function M:unbindEvents()
	self._btnChange:RemoveClickListener()
	self._btnUpGrade:RemoveClickListener()
	self._btnDetial:RemoveClickListener()
end

function M:onEnter()
	self._cellItem = {}

	GlobalDispatcher:addEventListener(EventType.HOUSE_HOLDROOM_INFO_CHANGE, self._handleHouseHoldRoomInfoChange, self)

	local info = self:getFirstParam()

	self.protomerId = info.protomerId

	if self.protomerId == nil then
		printError("请通过Facade提供的API，传入原体ID后打开")
		self:close()

		return
	end

	local protomerInfo = ProtomerModel.instance:getProtomerInfo(self.protomerId)

	self.roomId = protomerInfo:getRoomId()
	self.level = protomerInfo:getModuleUpGradeCount()

	self:_updateProtomerShow(self.protomerId)
	self:_updateRoomShow(self.protomerId, self.roomId, self.level)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
end

function M:onExit()
	self.protomerId = nil
	self.roomId = nil
	self._rewards = nil

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("close")

	for key, value in pairs(self._cellItem or {}) do
		value:onExit()
	end

	self._cellItem = nil

	self._loopListHelper:ClearCells()
	GlobalDispatcher:removeEventListener(EventType.HOUSE_HOLDROOM_INFO_CHANGE, self._handleHouseHoldRoomInfoChange, self)
end

function M:_handleHouseHoldRoomInfoChange()
	local newRoomId = ProtomerModel.instance:getProtomerRoomId(self.protomerId)

	if newRoomId == 0 then
		self:close()

		return
	end

	if newRoomId ~= self.roomId then
		self.roomId = newRoomId

		self:_updateRoomShow(self.protomerId, self.roomId, self.level)
	end
end

function M:_onClickChange()
	local defaultSelectTabIndex = self.roomId > 1100 and self.roomId - 1100 or self.roomId

	ContainmentFacade.instance:openHoldingChangeView(defaultSelectTabIndex)
end

function M:_onClickUpGrade()
	ContainmentFacade.instance:openProtomerUpgradeView(self.protomerId)
end

function M:_onClickDetial()
	if self.protomerId then
		ContainmentFacade.instance:openPrototypeInfoView(self.protomerId)
	end
end

function M:_updateRoomShow(protomerId, roomId, level)
	local roomInfo = ContainmentModel.instance:getRoomInfoById(roomId)
	local cfgProtomerInfo = ContainmentConfig.instance:getProtomerInfoById(protomerId)

	self._txtReturnBtn.text = roomInfo:getRoomIDName()
	self._txtFacilityName.text = cfgProtomerInfo.roomname
	self._txtFacilityLv.text = string.format("Lv.%d", level)
end

function M:_updateProtomerShow(protomerId)
	local protomerMo = ProtomerModel.instance:getProtomerInfo(protomerId)

	self._txtProtomerName.text = protomerMo:getProtomerName()

	self:_setIcon(protomerId)

	self._txtSerialNumber.text = protomerMo:getProtomerSerialNumShow()

	self:_updatePrototype(protomerMo:getProtomerPrototypeTableLst())

	self._txtDesc.text = protomerMo:getProtomerDesc()

	local roomId = protomerMo:getRoomId()

	if roomId > 0 then
		local second_base = ContainmentUtil.getProtomerProductivitySecond(roomId, protomerId, true)

		self:_setYieldBase(second_base)

		local second_withHero = ContainmentUtil.getProtomerProductivitySecond(roomId, protomerId, false)
		local blueVal = math.floor((second_base - second_withHero) / second_base * 100)

		blueVal = blueVal * -1

		self:_setYieldBlue(false)
		self:_setYieldRed(blueVal ~= 0, string.format("%d%%", blueVal))
	else
		self:_setYieldBase(ContainmentUtil.getProtomerProductivitySecond(self.roomId, protomerId, true))
		self:_setYieldBlue(false)
		self:_setYieldRed(false)
	end

	local moodCostBase = ContainmentUtil.getDefaultMoodCost()

	self:_setMoodBase(string.format("%0.1f", moodCostBase))

	local roomMo = ContainmentModel.instance:getRoomInfoById(self.roomId)

	if roomMo and roomMo:getHeroId() > 0 then
		local MoodBlueVal = ContainmentUtil.getRoomHeroMoodSkillMinus(roomMo:getHeroId())

		MoodBlueVal = MoodBlueVal * -1

		self:_setMoodBlue(MoodBlueVal ~= 0, string.format("%d%%", MoodBlueVal))
	else
		self:_setMoodBlue(false)
	end

	self:_updateRewardShow(protomerId)
end

function M:_updatePrototype(tablePrototypeLst)
	local count = #tablePrototypeLst

	while count > self._goPrototypeGroup.transform.childCount do
		goutil.cloneAndSetParent(self._goPrototypeItem, self._goPrototypeGroup.transform)
	end

	for i = 0, self._goPrototypeGroup.transform.childCount - 1 do
		local tmpGo = self._goPrototypeGroup.transform:GetChild(i).gameObject
		local show = i < #tablePrototypeLst

		if show then
			local prototypeIconUrl = tablePrototypeLst[i + 1].icon
			local prototypeName = tablePrototypeLst[i + 1].name
			local imgIcon = goutil.findChildImageComponent(tmpGo, "Image (4)")
			local txtIcon = goutil.findChildTextComponent(tmpGo, "Text1 (1)")

			IconLoader.setSprite(imgIcon, IconType.DynSpriteAtlas_Room, prototypeIconUrl)

			txtIcon.text = prototypeName
		end

		goutil.setActive(tmpGo, show)
	end
end

function M:_setIcon(protomerId)
	ContainmentUtil.setProtomerDynIcon(self._imgProtomerIcon, protomerId)
end

function M:_updateRewardShow(protomerId)
	local len = 0
	local cfg = ContainmentConfig.instance:getProtomerCoById(protomerId)
	local rewardCO = RewardConfig.instance:getRewardCfgByCode(cfg.goodsReward)

	self._rewards = {}

	table.insert(self._rewards, {
		echo = true,
		count = 0,
		itemId = cfg.echoReward
	})

	for i, v in ipairs(rewardCO.reward and rewardCO.reward or {}) do
		if not v.pool then
			table.insert(self._rewards, {
				echo = false,
				count = v.number,
				itemId = v.code
			})
		end
	end

	self._loopListHelper:SetListItemCount(#self._rewards, true)
	self._loopListHelper:RefreshAllShownItem()
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local data = self._rewards[curIndex]
	local itemData = ItemUtil.createItemData({
		itemId = data.itemId
	})

	itemData:setCount(data.count)

	local item = self._loopListHelper:NewListViewItem("backpack_item")
	local shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, HoldRewardItemCell)

	shower:setCellData(itemData, curIndex)
	shower:setNumShow(false)
	shower:setHandler(self)

	local signTyp = data.echo and CommEnum.BackPackItemSignTyp.Probability or CommEnum.BackPackItemSignTyp.None

	shower:setSignShow(signTyp)
	shower:setIsShowTips(true)
	shower:setShowSelectedEffect(false)
	shower:setIsShowTipsPassEvent(false)

	self._cellItem[item.gameObject:GetInstanceID()] = shower

	return item
end

function M:onRewardItemSelect(cellRewardItem)
	local instanceId = cellRewardItem:getMainGo():GetInstanceID()

	for key, value in pairs(self._cellItem or {}) do
		if key ~= instanceId then
			value:setItemSelect(false)
		end
	end
end

function M:_setYieldBase(sencond)
	local hour = sencond / 60 / 60

	self._txtYieldBase.text = string.format(lang("tip_xx_hour"), hour)
end

function M:_setYieldBlue(show, content)
	if show then
		self._txtYieldBlue.text = content
	end

	goutil.setActive(self._goYieldBlue, show)
end

function M:_setYieldRed(show, content)
	if show then
		self._txtYieldRed.text = content
	end

	goutil.setActive(self._goYieldRed, show)
end

function M:_setMoodBase(content)
	self._txtMoodBase.text = content
end

function M:_setMoodBlue(show, content)
	if show then
		self._txtMoodBlue.text = content
	end

	goutil.setActive(self._goMoodBlue, show)
end

return M
