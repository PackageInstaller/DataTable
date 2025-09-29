-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/effect/comp/IEffectComp.lua

module("logic.battle.effect.comp.IEffectComp", package.seeall)

local IEffectComp = class("IEffectComp")

IEffectComp.unit = false
IEffectComp[BattleFunctionName.onInit] = false
IEffectComp[BattleFunctionName.onReuse] = false
IEffectComp[BattleFunctionName.onReset] = false
IEffectComp[BattleFunctionName.onDestroy] = false
IEffectComp[BattleFunctionName.onResourceLoaded] = false

return IEffectComp
