-- chunkname: @IQIGame\\UI\\Main\\MainUI_HudPanel_RoomSelectPanel.lua

local MainUI_HudPanel_RoomSelectPanel = {}
local roomItemClass = require("IQIGame/UI/Main/MainUI_HudPanel_RoomSelectPanel_RoomItem")

function MainUI_HudPanel_RoomSelectPanel.New(go, mainView)
	local o = Clone(MainUI_HudPanel_RoomSelectPanel)

	o:Initialize(go, mainView)

	return o
end

function MainUI_HudPanel_RoomSelectPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function MainUI_HudPanel_RoomSelectPanel:InitComponent()
	self.roomItemList = {}

	table.insert(self.roomItemList, roomItemClass.New(self.roomButton, self))
end

function MainUI_HudPanel_RoomSelectPanel:InitDelegate()
	return
end

function MainUI_HudPanel_RoomSelectPanel:AddListener()
	return
end

function MainUI_HudPanel_RoomSelectPanel:RemoveListener()
	return
end

function MainUI_HudPanel_RoomSelectPanel:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function MainUI_HudPanel_RoomSelectPanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function MainUI_HudPanel_RoomSelectPanel:Refresh(actionParams)
	self.data = {}

	local len = #actionParams

	for i = 1, len do
		local data = {}
		local strArray = string.split(actionParams[i])

		data.roomId = tonumber(strArray[1])

		local x = tonumber(strArray[2])
		local y = tonumber(strArray[3])
		local z = tonumber(strArray[4])

		if x and y and z then
			data.playerBornPos = Vector3.New(x, y, z)
		end

		table.insert(self.data, data)
	end

	local len = #self.data
	local index = 1

	for i = 1, len do
		local item = self:_GetRoomItem(i)

		item:Show()
		item:Refresh(self.data[i])

		index = i
	end

	for i = index + 1, #self.roomItemList do
		self.roomItemList[i]:Hide()
	end
end

function MainUI_HudPanel_RoomSelectPanel:_GetRoomItem(index)
	if not self.roomItemList[index] then
		local o = GameObject.Instantiate(self.roomButton, self.RoomBtnRoot.transform)

		self.roomItemList[index] = roomItemClass.New(o, self)
	end

	return self.roomItemList[index]
end

function MainUI_HudPanel_RoomSelectPanel:OnDestroy()
	return
end

return MainUI_HudPanel_RoomSelectPanel
