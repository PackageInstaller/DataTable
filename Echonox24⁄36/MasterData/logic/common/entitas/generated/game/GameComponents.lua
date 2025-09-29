-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/generated/game/GameComponents.lua

module("logic.common.entitas.generated.game.GameComponents", package.seeall)

local make_component = require("MakeComponent")
local M = {}

M.ConsumeElixir = make_component("consumeElixir", "amount")
M.ConsumptionHistory = make_component("consumptionHistory", "entries")
M.Destroy = make_component("destroy")
M.Elixir = make_component("elixir", "amount")
M.JumpInTime = make_component("jumpInTime", "targetTick")
M.LogicSystem = make_component("logicSystem", "systems")
M.Pause = make_component("pause")
M.Tick = make_component("tick", "currentTick")

return M
