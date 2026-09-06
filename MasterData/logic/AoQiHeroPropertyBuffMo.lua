-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/model/buffMo/AoQiHeroPropertyBuffMo.lua

module("logic.extensions.aoqihero.model.buffMo.AoQiHeroPropertyBuffMo", package.seeall)

local AoQiHeroPropertyBuffMo = class("AoQiHeroPropertyBuffMo", AoQiHeroBuffMo)

function AoQiHeroPropertyBuffMo:ctor()
	AoQiHeroPropertyBuffMo.super.ctor(self)

	self.buffType = AoQiHeroConst.BuffPropertyChange
	self.proertyType = 0
	self.changeValue = 0
	self.isChangeHp = false
end

function AoQiHeroPropertyBuffMo:initDataByCfg(cfg)
	AoQiHeroPropertyBuffMo.super.initDataByCfg(self, cfg)

	local attrName, value = FightingPowerFormula.instance:getAttrNameValue(cfg.buffParams)

	self.proertyType = FightingPowerFormula.instance:getAttrTypeByName(attrName)
	self.changeValue = value

	if self.proertyType == GameEnum.AttrType.Hp or self.proertyType == GameEnum.AttrType.HpRate then
		self.isChangeHp = true
	end
end

function AoQiHeroPropertyBuffMo:onAddBuffBefore()
	if self.isChangeHp == true then
		local petMo = AoQiHeroEntityMgr.instance:getPet(self.targetId)

		self._tempHpRate = petMo.curHp / petMo:getMaxHp()
	end
end

function AoQiHeroPropertyBuffMo:onAddBuff()
	if self.isChangeHp == true then
		local petMo = AoQiHeroEntityMgr.instance:getPet(self.targetId)

		petMo:checkMaxHp()

		petMo.curHp = math.floor(petMo:getMaxHp() * self._tempHpRate)
		self._tempHpRate = nil
	end
end

function AoQiHeroPropertyBuffMo:onRemoveBefore()
	if self.isChangeHp == true then
		local petMo = AoQiHeroEntityMgr.instance:getPet(self.targetId)

		self._tempHpRate = petMo.curHp / petMo:getMaxHp()
	end
end

function AoQiHeroPropertyBuffMo:onRemoveBuff()
	if self.isChangeHp == true then
		local petMo = AoQiHeroEntityMgr.instance:getPet(self.targetId)

		petMo:checkMaxHp()

		petMo.curHp = math.ceil(petMo:getMaxHp() * self._tempHpRate)
		self._tempHpRate = nil
	end
end

return AoQiHeroPropertyBuffMo
