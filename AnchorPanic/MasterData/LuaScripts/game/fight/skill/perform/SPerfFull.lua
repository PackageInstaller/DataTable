--[[
****************************************************************************
Brief  :SPerfFull 子弹类技能轨迹
Author :James Ou
Date   :2020-03-11
****************************************************************************
]]
module("SPerfFull", Class.impl(SPerfBase))
-------------------------------

function onStart(self, travel,...)
	if super.onStart(self, travel, ...) then
		local caster = travel:getCaster()
		if caster then
			local v3 = caster:getCurPos()
			local magicParticle = gs.ParticleMgr:Get("Flame Enchant.prefab")
			magicParticle:SetParent(caster:getTrans())
			magicParticle:SetRemoveTime(3)
			magicParticle:SetAutoRecover(true)
			gs.TransQuick:Pos(magicParticle.transform, v3.x, v3.y, v3.z)
		end
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
