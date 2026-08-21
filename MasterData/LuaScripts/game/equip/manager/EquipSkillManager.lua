module("equip.EquipSkillManager", Class.impl(Manager))

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
	super.resetData(self)
    self:__init()
end

function __init(self)
    self.m_equipSkillBuffDic = nil
end

-- 解析装备技能buff效果值配置表
function parseEquipSkillBuffConfig(self)
    self.m_equipSkillBuffDic = {}
    local baseData = RefMgr:getData("skill_buff_show_data")
    for buffId, data in pairs(baseData) do
        local vo = equip.EquipSkillBuffConfigVo.new()
        vo:parseConfigData(buffId, data)
        if (not self.m_equipSkillBuffDic[buffId]) then
            self.m_equipSkillBuffDic[buffId] = {}
        end
        self.m_equipSkillBuffDic[buffId] = vo
    end
end

-- 根据buffid获取效果值相关信息
function getSkillBuffEffectConfigVo(self, buffId)
    if(not self.m_equipSkillBuffDic)then
        self:parseEquipSkillBuffConfig()
    end
    return self.m_equipSkillBuffDic[buffId]
end

-- 获取技能描述
function getSkillDes(self, equipVo, skillEffectData)
    local skillVo = fight.SkillManager:getSkillRo(skillEffectData.skillId)
	if (skillVo) then
		local valueList = {}
		for i = 1, #skillEffectData.buffValues do
			local buffData = skillEffectData.buffValues[i]
			local isBuffValuePercent = false
			if(equipVo.type == PropsType.EQUIP and equipVo.subType == PropsEquipSubType.SLOT_7)then
				local refineConfigVo = braceletBuild.BraceletBuildManager:getRefineConfigVo(equipVo.tid, equipVo.refineLvl)
				isBuffValuePercent = refineConfigVo:getBuffValueIsPercent(buffData.buffId)
			elseif(equipVo.type == PropsType.ORDER)then
				local orderConfigVo = covenantTalent.CovenantTalentManager:getOrderConfigVo(equipVo.tid, equipVo.refineLvl)
				isBuffValuePercent = orderConfigVo:getBuffValueIsPercent(buffData.buffId)
			else
				Debug:log_error("EquipSkillManager", "道具获取技能描述未处理对应类型逻辑")
			end
			if(isBuffValuePercent)then
				table.insert(valueList, AttConst.getPreciseDecimal(buffData.buffValue / 100, 1))
			else
				table.insert(valueList, buffData.buffValue)
			end
		end
		local des = string.substitute(skillVo:getDesc(), unpack(valueList))
		return des
    end
end

function getBraceletSkillDes(self, equipVo, skillEffectData)
	local skillVo = fight.SkillManager:getSkillRo(skillEffectData.skillId)
	if (skillVo) then
		local configVo 
			if(equipVo.type == PropsType.EQUIP and equipVo.subType == PropsEquipSubType.SLOT_7)then
				configVo= braceletBuild.BraceletBuildManager:getRefineConfigVo(equipVo.tid, equipVo.refineLvl)
			else
				Debug:log_error("EquipSkillManager", "道具获取技能描述未处理对应类型逻辑")
			end

		local des = configVo:getDesc()
		return des
    end
end

function getBraceletTipsSkillDes(self, equipVo, skillEffectData)
	local skillVo = fight.SkillManager:getSkillRo(skillEffectData.skillId)
	if (skillVo) then
		local configVo 
			if(equipVo.type == PropsType.EQUIP and equipVo.subType == PropsEquipSubType.SLOT_7)then
				configVo= braceletBuild.BraceletBuildManager:getRefineConfigVo(equipVo.tid, equipVo.refineLvl)
			else
				Debug:log_error("EquipSkillManager", "道具获取技能描述未处理对应类型逻辑")
			end

		local des = configVo:getTipsDesc()
		return des
    end
end

function getBraceletPreviewSkillDes(self, equipVo, skillEffectData)
	local skillVo = fight.SkillManager:getSkillRo(skillEffectData.skillId)
	if (skillVo) then
		
		local configVo 
			if(equipVo.type == PropsType.EQUIP and equipVo.subType == PropsEquipSubType.SLOT_7)then
				configVo= braceletBuild.BraceletBuildManager:getRefineConfigVo(equipVo.tid, equipVo.refineLvl + 1)
				
			elseif(equipVo.type == PropsType.ORDER)then
				configVo = covenantTalent.CovenantTalentManager:getOrderConfigVo(equipVo.tid, equipVo.refineLvl + 1)
			else
				Debug:log_error("EquipSkillManager", "道具获取技能描述未处理对应类型逻辑")
			end

		local des = configVo:getDesc()
		return des
    end
end



-- 获取技能的等级，单纯用于显示
function getSkillLvl(self, skillEffectData)
	local des = _TT(71418)
	return des
end

--析构函数
function dtor(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
