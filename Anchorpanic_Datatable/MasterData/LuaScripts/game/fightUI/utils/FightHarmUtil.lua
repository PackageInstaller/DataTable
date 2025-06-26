--[[
****************************************************************************
Brief  :战斗伤害飘字处理
Author :Zzz
Date   :2020-02-28
****************************************************************************
]]
module("fightUI.HarmUtil", Class.impl())

function ctor(self)
	self.m_cameraDist = nil
	self.m_uiContainer = nil
	self:__init()
end

function __init(self)
	self.m_cameraDist = 10
	local floatView = SubLayerMgr:getLayer(gud.SLAYER_FLOAT)
	self.m_uiContainer = floatView
end

function fly(self, cusHurtType, cusWorldPos, cusContent, cusOffestPos)
	if cusOffestPos == nil then
		cusWorldPos.y = cusWorldPos.y + 0.5
	else
		cusWorldPos.x = cusWorldPos.x + cusOffestPos.x
		cusWorldPos.y = cusWorldPos.y + cusOffestPos.y
		cusWorldPos.z = cusWorldPos.z + cusOffestPos.z
	end
	local prefabName = self:__getPrefabNameByType()
	fightUI.FightFlyUtil.fly3D(self.m_uiContainer, prefabName, cusWorldPos, cusContent);
end

function __getPrefabNameByType(self, fightHurtType)
	local prefabName = "HudText.prefab"
	if fightHurtType == CalculatorType.CUT_HP then
		prefabName = "HudText.prefab"
	elseif fightHurtType == CalculatorType.CUT_MP then
		prefabName = "HudText.prefab"
	end
	return prefabName
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
