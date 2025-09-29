-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/model/BattleExternalDataModel.lua

module("logic.battle.model.BattleExternalDataModel", package.seeall)

local M = class("BattleExternalDataModel", BaseModel)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._isPreShowSkillTips = false
end

function M:isPreShowSkillTips()
	return self._isPreShowSkillTips
end

function M:setPreShowSkillTips(status)
	self._isPreShowSkillTips = status
end

M.instance = M.New()

return M
