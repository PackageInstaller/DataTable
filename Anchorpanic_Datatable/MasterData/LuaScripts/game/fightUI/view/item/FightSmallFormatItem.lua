
module("fight.FightSmallFormatItem", Class.impl("lib.component.BaseNode"))

function initData(self, rootGo)
	super.initData(self, rootGo)

	self.mImgBg = self.m_go:GetComponent(ty.Image)

	self.mImgDead = self:getChildGO('mImgDead')
	self.mImgDead:SetActiveLocal(false)
	self.mImgAttack = self:getChildGO('mImgAttack')
	self.mImgAttack:SetActiveLocal(false)
	self.mImgTarget = self:getChildGO('mImgTarget')
	self.mImgTarget:SetActiveLocal(false)

	self.mImgNoHp = self:getChildGO("mImgNoHp")
	self.mImgNoHp:SetActiveLocal(false)
end

function setNorFlag(self, beActive)
	self.mImgDead:SetActiveLocal(not beActive)
	self.mImgAttack:SetActiveLocal(not beActive)
	self.mImgTarget:SetActiveLocal(not beActive)
	self.mImgBg.enabled = beActive
	self.mImgNoHp:SetActiveLocal(false)
end
-- 死亡记号
function setDeadFlag(self, beActive)
	self.mImgDead:SetActiveLocal(beActive)
	self.mImgAttack:SetActiveLocal(not beActive)
	self.mImgTarget:SetActiveLocal(not beActive)
	self.mImgBg.enabled = not beActive
	self.mImgNoHp:SetActiveLocal(false)
end

-- 设置攻击者状态
function setAttackFlag(self, beActive)
	self.mImgDead:SetActiveLocal(not beActive)
	self.mImgAttack:SetActiveLocal(beActive)
	self.mImgTarget:SetActiveLocal(not beActive)
	self.mImgBg.enabled = not beActive
	self.mImgNoHp:SetActiveLocal(false)
end

-- 受击者状态
function setTargetFlag(self, beActive)
	self.mImgDead:SetActiveLocal(not beActive)
	self.mImgAttack:SetActiveLocal(not beActive)
	self.mImgTarget:SetActiveLocal(beActive)
	self.mImgBg.enabled = not beActive
	self.mImgNoHp:SetActiveLocal(false)
end

--非血条怪物
function setNoHp(self,beActive,isDed)
	self.mImgDead:SetActiveLocal(not beActive)
	self.mImgAttack:SetActiveLocal(not beActive)
	self.mImgTarget:SetActiveLocal(not beActive)
	self.mImgBg.enabled = not beActive
	self.mImgNoHp:SetActiveLocal(beActive and isDed == false)
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
