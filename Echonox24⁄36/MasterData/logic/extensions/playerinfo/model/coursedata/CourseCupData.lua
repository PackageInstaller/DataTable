-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/model/coursedata/CourseCupData.lua

module("logic.extensions.playerinfo.model.coursedata.CourseCupData", package.seeall)

local M = class("CourseCupData")

function M:ctor()
	self.mo = nil
	self.sortIndex = 0
end

function M.buildFromMsg(msg)
	local data = CourseCupData.New()
	local cfg = MonumentConfig.instance:getMonumentCfgById(msg.id)

	data.mo = MonumentMO.New(cfg)

	data.mo:setIsFinish(true)
	data.mo:setRate(msg.rate)
	data.mo:setObtTime(msg.time)

	return data
end

function M.buildFromDepot(mo)
	local data = CourseCupData.New()

	data.mo = mo

	return data
end

function M:getId()
	return self.mo:getId()
end

return M
