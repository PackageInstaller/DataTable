---@class BattleEffectPanel_Generate_mingZi2
---@field public gameObject UnityEngine.GameObject
---@field public particleSystemRenderer UnityEngine.ParticleSystemRenderer

---@class BattleEffectPanel_Generate_mingZi1
---@field public gameObject UnityEngine.GameObject
---@field public particleSystemRenderer UnityEngine.ParticleSystemRenderer

---@class BattleEffectPanel_Generate_shenHai4
---@field public gameObject UnityEngine.GameObject
---@field public particleSystemRenderer UnityEngine.ParticleSystemRenderer

---@class BattleEffectPanel_Generate_shenHai3
---@field public gameObject UnityEngine.GameObject
---@field public particleSystemRenderer UnityEngine.ParticleSystemRenderer

---@class BattleEffectPanel_Generate_shenHai2
---@field public gameObject UnityEngine.GameObject
---@field public particleSystemRenderer UnityEngine.ParticleSystemRenderer

---@class BattleEffectPanel_Generate_shenHai1
---@field public gameObject UnityEngine.GameObject
---@field public particleSystemRenderer UnityEngine.ParticleSystemRenderer

---@class BattleEffectPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public effectGroup UnityEngine.GameObject
---@field public warning1 UnityEngine.GameObject
---@field public warning2 UnityEngine.GameObject
---@field public shenHai1 BattleEffectPanel_Generate_shenHai1
---@field public shenHai2 BattleEffectPanel_Generate_shenHai2
---@field public shenHai3 BattleEffectPanel_Generate_shenHai3
---@field public shenHai4 BattleEffectPanel_Generate_shenHai4
---@field public mingZi1 BattleEffectPanel_Generate_mingZi1
---@field public mingZi2 BattleEffectPanel_Generate_mingZi2
local BattleEffectPanel = class("BattleEffectPanel", require("WndBase"))

function BattleEffectPanel:ctor(data)
end

---@private
function BattleEffectPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("BattleEffectPanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)
	self:InitGenerate__5(Root,data)
	self:InitGenerate__6(Root,data)
	self:InitGenerate__7(Root,data)
	self:InitGenerate__8(Root,data)
	self:InitGenerate__9(Root,data)
	self:InitGenerate__10(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function BattleEffectPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function BattleEffectPanel:InitGenerate__2(Root, data)
--[[
	EffectGroup
--]]
	local tmp = Root:Find("EffectGroup").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.effectGroup = tmp


end

---@private
function BattleEffectPanel:InitGenerate__3(Root, data)
--[[
	EffectGroup/Warning1
--]]
	local tmp = Root:Find("EffectGroup/Warning1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.warning1 = tmp


end

---@private
function BattleEffectPanel:InitGenerate__4(Root, data)
--[[
	EffectGroup/Warning2
--]]
	local tmp = Root:Find("EffectGroup/Warning2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.warning2 = tmp


end

---@private
function BattleEffectPanel:InitGenerate__5(Root, data)
--[[
	EffectGroup/Warning2/Effect/ShenHai1
--]]
	local tmp = Root:Find("EffectGroup/Warning2/Effect/ShenHai1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shenHai1 = tmp

	tmp.particleSystemRenderer = tmp:GetComponent(TypeInfo.ParticleSystemRenderer)


end

---@private
function BattleEffectPanel:InitGenerate__6(Root, data)
--[[
	EffectGroup/Warning2/Effect/ShenHai2
--]]
	local tmp = Root:Find("EffectGroup/Warning2/Effect/ShenHai2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shenHai2 = tmp

	tmp.particleSystemRenderer = tmp:GetComponent(TypeInfo.ParticleSystemRenderer)


end

---@private
function BattleEffectPanel:InitGenerate__7(Root, data)
--[[
	EffectGroup/Warning2/Effect/ShenHai3
--]]
	local tmp = Root:Find("EffectGroup/Warning2/Effect/ShenHai3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shenHai3 = tmp

	tmp.particleSystemRenderer = tmp:GetComponent(TypeInfo.ParticleSystemRenderer)


end

---@private
function BattleEffectPanel:InitGenerate__8(Root, data)
--[[
	EffectGroup/Warning2/Effect/ShenHai4
--]]
	local tmp = Root:Find("EffectGroup/Warning2/Effect/ShenHai4").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shenHai4 = tmp

	tmp.particleSystemRenderer = tmp:GetComponent(TypeInfo.ParticleSystemRenderer)


end

---@private
function BattleEffectPanel:InitGenerate__9(Root, data)
--[[
	EffectGroup/Warning2/Effect/MingZi1
--]]
	local tmp = Root:Find("EffectGroup/Warning2/Effect/MingZi1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mingZi1 = tmp

	tmp.particleSystemRenderer = tmp:GetComponent(TypeInfo.ParticleSystemRenderer)


end

---@private
function BattleEffectPanel:InitGenerate__10(Root, data)
--[[
	EffectGroup/Warning2/Effect/MingZi2
--]]
	local tmp = Root:Find("EffectGroup/Warning2/Effect/MingZi2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mingZi2 = tmp

	tmp.particleSystemRenderer = tmp:GetComponent(TypeInfo.ParticleSystemRenderer)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function BattleEffectPanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return BattleEffectPanel