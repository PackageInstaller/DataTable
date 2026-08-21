-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataEquipRefine.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResEquipBaptizeMisc = require("ClientData/ResEquipBaptizeMisc")
local ActivityDataEquipRefine = Class("ActivityDataEquipRefine", ActivityDataBase)

function ActivityDataEquipRefine:ctor()
	return
end

function ActivityDataEquipRefine:updateClientData(actId)
	self.actId = actId
	self.miscData = ResEquipBaptizeMisc[1] or {}
end

function ActivityDataEquipRefine:updateRoleData(roleData)
	self.useCount = roleData.equip_baptize.count or 0
	self.remainCount = self.miscData.op_count - self.useCount

	if self.equipReformData then
		self.oldReformLockPro = self.equipReformData.lock_progress
	end

	self.equipReformData = roleData.equip_baptize.equip_baptize or {}
	self.equipMakeData = roleData.equip_baptize.equip_make or {}
end

function ActivityDataEquipRefine:checkNew()
	if self.remainCount and self.remainCount > 0 and not self.isOpenActDlg then
		return true
	end

	return false
end

function ActivityDataEquipRefine:checkReformLvUp()
	if self.oldReformLockPro then
		local maxLockLevel = self.miscData.progress_limit / self.miscData.level_progress
		local oldLockLevel = math.min(maxLockLevel, math.floor(self.oldReformLockPro / self.miscData.level_progress))
		local curLockLevel = math.min(maxLockLevel, math.floor(self.equipReformData.lock_progress / self.miscData.level_progress))

		if oldLockLevel < curLockLevel then
			UIManager.getUI("activityEquipReformLvUpDlg", true):setData(oldLockLevel, curLockLevel)
		end
	end
end

function ActivityDataEquipRefine:isEquipReform(gid)
	if self.equipReformData and self.equipReformData.gid and self.equipReformData.gid == gid then
		return true
	end

	return false
end

return ActivityDataEquipRefine
