-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/HouseJobHeroConditionCell.lua

module("logic.extensions.houseworker.view.HouseJobHeroConditionCell", package.seeall)

local M = class("HouseJobHeroConditionCell")
local RoomType = HouseEnum.RoomType

function M:ctor(comContainer)
	self._go = comContainer.gameObject

	self:_onInit()
end

function M:_onInit()
	self._positionPanelGoList = {}
	self._positionPanelGoList[1] = goutil.findChild(self._go, "content2")
	self._positionPanelGoList[2] = goutil.findChild(self._go, "content3")
	self._positionPanelGoList[3] = goutil.findChild(self._go, "content4")
	self._roomNameTxt = goutil.findChildTextComponent(self._go, "content1/name/txtRoomName")
	self._roomLevelTxt = goutil.findChildTextComponent(self._go, "content1/level/txtLevel")
	self._roomCapacityTxt = goutil.findChildTextComponent(self._go, "content1/txtNum")
	self._position1NameTxt = goutil.findChildTextComponent(self._go, "content2/txtCareer")
	self._position2NameTxt = goutil.findChildTextComponent(self._go, "content3/txtCareer")
	self._position3NameTxt = goutil.findChildTextComponent(self._go, "content4/txtCareer")
	self._position1Button = Astral.ButtonAdapter.Get(goutil.findChild(self._go, "content2/unlock"))
	self._position2Button = Astral.ButtonAdapter.Get(goutil.findChild(self._go, "content3/unlock"))
	self._position3Button = Astral.ButtonAdapter.Get(goutil.findChild(self._go, "content4/unlock"))
	self._lockGoList = {}
	self._unlockGoList = {}
	self._lockTxtList = {}
	self._lockGoList[1] = goutil.findChild(self._go, "content2/lock")
	self._lockGoList[2] = goutil.findChild(self._go, "content3/lock")
	self._lockGoList[3] = goutil.findChild(self._go, "content4/lock")
	self._unlockGoList[1] = goutil.findChild(self._go, "content2/unlock")
	self._unlockGoList[2] = goutil.findChild(self._go, "content3/unlock")
	self._unlockGoList[3] = goutil.findChild(self._go, "content4/unlock")
	self._lockTxtList[1] = goutil.findChildTextComponent(self._go, "content2/lock/txtLock")
	self._lockTxtList[2] = goutil.findChildTextComponent(self._go, "content3/lock/txtLock")
	self._lockTxtList[3] = goutil.findChildTextComponent(self._go, "content4/lock/txtLock")
	self._headViewList = {}
	self._headViewList[1] = Astral.LuaComponentContainer.Add(goutil.findChild(self._go, "content2/unlock/hero_adjust_item1"), HouseWorkHeadCell)
	self._headViewList[2] = Astral.LuaComponentContainer.Add(goutil.findChild(self._go, "content2/unlock/hero_adjust_item2"), HouseWorkHeadCell)
	self._headViewList[3] = Astral.LuaComponentContainer.Add(goutil.findChild(self._go, "content2/unlock/hero_adjust_item3"), HouseWorkHeadCell)
	self._headViewList[4] = Astral.LuaComponentContainer.Add(goutil.findChild(self._go, "content3/unlock/hero_adjust_item1"), HouseWorkHeadCell)
	self._headViewList[5] = Astral.LuaComponentContainer.Add(goutil.findChild(self._go, "content3/unlock/hero_adjust_item2"), HouseWorkHeadCell)
	self._headViewList[6] = Astral.LuaComponentContainer.Add(goutil.findChild(self._go, "content3/unlock/hero_adjust_item3"), HouseWorkHeadCell)
	self._headViewList[7] = Astral.LuaComponentContainer.Add(goutil.findChild(self._go, "content4/unlock/hero_adjust_item1"), HouseWorkHeadCell)
	self._headViewList[8] = Astral.LuaComponentContainer.Add(goutil.findChild(self._go, "content4/unlock/hero_adjust_item2"), HouseWorkHeadCell)
	self._headViewList[9] = Astral.LuaComponentContainer.Add(goutil.findChild(self._go, "content4/unlock/hero_adjust_item3"), HouseWorkHeadCell)
	self._mapIconImg = {
		[RoomType.Supervisor] = goutil.findChild(self._go, "content1/buildIcon/zhuguanshi"),
		[RoomType.Trading] = goutil.findChild(self._go, "content1/buildIcon/maoyizhan"),
		[RoomType.Manufacturing] = goutil.findChild(self._go, "content1/buildIcon/zhizaochang")
	}

	self:_bindEvents()
end

function M:_bindEvents()
	self._position1Button:AddClickListener(self._openPosition1, self)
	self._position2Button:AddClickListener(self._openPosition2, self)
	self._position3Button:AddClickListener(self._openPosition3, self)
end

function M:_unbindEvents()
	self._position1Button:RemoveClickListener()
	self._position2Button:RemoveClickListener()
	self._position3Button:RemoveClickListener()
end

function M:_openPosition1()
	self:_openHouseWithPosition(1)
end

function M:_openPosition2()
	self:_openHouseWithPosition(2)
end

function M:_openPosition3()
	self:_openHouseWithPosition(3)
end

function M:_openHouseWithPosition(index)
	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, self._roomIndex, index)
	end
end

function M:initByConfigData(configData, roomIndex)
	self._jobConfigDataList = configData
	self._roomIndex = roomIndex

	local zoneId = self._jobConfigDataList[1].zoneId
	local roomName = self._jobConfigDataList[1].roomName

	if self._jobConfigDataList[1].roomType == HouseEnum.RoomType.Shelter and ContainmentModel.instance:getProtomerId(zoneId) > 0 then
		roomName = ContainmentModel.instance:getRoomName(zoneId)
	end

	self._roomNameTxt.text = roomName
	self._position1NameTxt.text = self._jobConfigDataList[1].jobName

	if self._jobConfigDataList[2] then
		self._position2NameTxt.text = self._jobConfigDataList[2].jobName
	end

	if self._jobConfigDataList[3] then
		self._position3NameTxt.text = self._jobConfigDataList[3].jobName
	end
end

function M:setClickCallBack(clickCallBackFunc, clickCallBackHandler)
	self._clickCallBackFunc = clickCallBackFunc
	self._clickCallBackHandler = clickCallBackHandler
end

function M:setVisible(visible)
	goutil.setActive(self._go, visible)
end

function M:_updatePanel()
	local roomType = self._jobConfigDataList[1].roomType
	local roomId = self._jobConfigDataList[1].zoneId
	local level = HouseWorkerModel.instance:getLevelByHouseType(roomType)
	local unlockJobCount = HouseWorkerModel.instance:getUnlockJobCountByRoomType(roomType)

	if roomType == RoomType.Shelter and HouseMainUtil.isRoomNotSetting(roomId) then
		self:setVisible(false)
	else
		self:setVisible(true)
	end

	self._roomLevelTxt.text = string.format("Lv.%d", level)

	for i = 1, 3 do
		goutil.setActive(self._positionPanelGoList[i], self._jobConfigDataList[i])

		if self._jobConfigDataList[i] then
			if unlockJobCount < i then
				goutil.setActive(self._lockGoList[i], true)
				goutil.setActive(self._unlockGoList[i], false)

				local unlockLevel = HouseWorkerModel.instance:getUnlockConditionByRoomTypeAndIndex(roomType, i)

				self._lockTxtList[i].text = string.format("%s Lv.%d", self._jobConfigDataList[i].roomName, unlockLevel)
			else
				goutil.setActive(self._lockGoList[i], false)
				goutil.setActive(self._unlockGoList[i], true)
			end
		end
	end

	local count = 0
	local settledJobCount = 0

	for i, jobConfigData in ipairs(self._jobConfigDataList) do
		local scheduleList = HouseWorkerModel.instance:getScheduleByJob(jobConfigData.jobCode)

		if HouseWorkerModel.instance:getIfJobCanSettled(jobConfigData.jobCode) then
			settledJobCount = settledJobCount + 1
		end

		for j = 1, 3 do
			self._headViewList[(i - 1) * 3 + j]:updatePanel()

			if scheduleList[j] then
				self._headViewList[(i - 1) * 3 + scheduleList[j].index]:updatePanel(scheduleList[j])

				if scheduleList[j].hero > 0 then
					count = count + 1
				end
			end
		end
	end

	self._roomCapacityTxt.text = string.format("%d/%d", count, settledJobCount * 3)

	for type, icon in pairs(self._mapIconImg) do
		goutil.setActive(icon, type == roomType)
	end
end

function M:_onExit()
	self:_unbindEvents()
end

return M
