-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataPetDraw.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResPetGashaponDrawUp = require("ClientData/ResPetGashaponDrawUp")
local ResPetGashaponDraw = require("ClientData/ResPetGashaponDraw")
local ActivityDataPetDraw = Class("ActivityDataPetDraw", ActivityDataBase)

function ActivityDataPetDraw:ctor()
	self.serverData = {}
	self.clientData = {}
end

function ActivityDataPetDraw:updateClientData(actId)
	self.actId = actId
	self.drawDetailData = ResPetGashaponDrawUp[self.actId]
	self.replaceLibId = self.drawDetailData.lib
	self.drawData = {}
	self.skipCheckItemNew = true

	local haveNum = CurAvatar:getItemNumById(ResPetGashaponDraw[1].cost_item)

	if haveNum >= ResPetGashaponDraw[1].cost_num then
		self.skipCheckItemNew = false
	end

	CurAvatar:registerItemChangedCallBack(ResPetGashaponDraw[1].cost_item, Slot(self.CurAvatarCheckNew, self))
end

function ActivityDataPetDraw:updateMgrData(opActivityMgrItem)
	self.mgrData = opActivityMgrItem
	self.startTime = self.mgrData.time.opentime
	self.endTime = self.mgrData.time.closetime
	self.freezeTime = self.mgrData.time.freezetime
end

function ActivityDataPetDraw:updateRoleData(roleData)
	self.drawData = {
		drawRecord = roleData.pet_gashapon.drawed_record
	}

	local nextDay = ClientUtils.getTodayTimeStamp(24, 0, 0)

	self.dailyRefreshTimer = Timer.New(Slot(self.onNewDay, self), nextDay - ClientUtils.getServerTime() + 5)

	self.dailyRefreshTimer:Start()
end

function ActivityDataPetDraw:CurAvatarCheckNew(oldValue, newValue)
	if oldValue and newValue then
		if newValue <= oldValue then
			self.skipCheckItemNew = true

			return
		else
			self.skipCheckItemNew = false
		end
	end

	CurAvatar:checkPetDrawActivityNew()
end

function ActivityDataPetDraw:checkNew()
	if not self.skipCheckItemNew then
		return true
	end
end

function ActivityDataPetDraw:onNewDay()
	if ClientUtils.getServerTime() > self.endTime then
		local petPoolMainDlg = UIManager.tryGetUI("petPoolMainDlg")

		if petPoolMainDlg then
			petPoolMainDlg:showMsgAndClose()
		end

		if self.dailyRefreshTimer then
			self.dailyRefreshTimer:Stop()

			self.dailyRefreshTimer = nil
		end
	end
end

return ActivityDataPetDraw
