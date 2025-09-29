-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/util/RogueLocalStorageUtil.lua

module("logic.extensions.roguelike.util.RogueLocalStorageUtil", package.seeall)

local M = class("RogueLocalStorageUtil")
local kSelectRoleList = "RogueSelectRoleList"
local kLastEquipId = "LastEquipId"
local kReadStory = "ReadStory"

function M:savaSelectRoleList(roleIds)
	local key = kSelectRoleList .. PlayerModel.instance:getId()
	local temp = ""

	for k, v in pairs(roleIds or {}) do
		if k == 1 then
			temp = v
		else
			temp = temp .. "," .. v
		end
	end

	Astral.LocalStorage.Instance:SetString(key, temp)
end

function M:getSelectRoleList()
	local key = kSelectRoleList .. PlayerModel.instance:getId()
	local result = Astral.LocalStorage.Instance:GetString(key, "")
	local temp = {}
	local roleList = string.split(result, ",")

	for k, v in pairs(roleList or {}) do
		table.insert(temp, tonumber(v))
	end

	return temp
end

function M:saveLastEquipId(equipId)
	local key = kLastEquipId .. PlayerModel.instance:getId()

	Astral.LocalStorage.Instance:SetInt(key, equipId)
end

function M:getLastEquipId()
	local key = kLastEquipId .. PlayerModel.instance:getId()

	return Astral.LocalStorage.Instance:GetInt(key, 0)
end

function M:setReadStory(isRead)
	local key = kReadStory .. PlayerModel.instance:getId()
	local result = isRead and 1 or 0

	Astral.LocalStorage.Instance:SetInt(key, result)
end

function M:getReadStory()
	local key = kReadStory .. PlayerModel.instance:getId()

	return Astral.LocalStorage.Instance:GetInt(key, 1) == 1
end

M.instance = M.New()

return M
