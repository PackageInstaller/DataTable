-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\AchieveUpperSystems\\AchieveUpperSystemBase.lua

local AchieveUpperSystemBase = Class("AchieveUpperSystemBase")

function AchieveUpperSystemBase:ctor(svrData)
	self.achieveDict = {}
	self.achieveList = {}

	self:initUpperSystem(svrData)
end

function AchieveUpperSystemBase:isAchieveNeedCare(achieveId)
	return self.achieveDict[achieveId]
end

function AchieveUpperSystemBase:initUpperSystem(svrData)
	return
end

function AchieveUpperSystemBase:onAchieveQualify(achieveId)
	self:_refreshRedDotEvent()
	self:_refreshDlg()
end

function AchieveUpperSystemBase:onAchieveGot(achieveId)
	self:_refreshRedDotEvent()
	self:_refreshDlg()
end

function AchieveUpperSystemBase:onAchieveProgressChanged(achieveId)
	self:_refreshDlg()
end

function AchieveUpperSystemBase:_refreshDlg()
	return
end

function AchieveUpperSystemBase:_refreshRedDotEvent()
	return
end

return AchieveUpperSystemBase
