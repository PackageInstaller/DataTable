module("equipBuild.EquipBuildManager", Class.impl(Manager))

-- 当前选择的装备或英雄改变
SELECTE_CHANGE = "SELECTE_CHANGE"

--构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()
end

-- Override 重置数据
function resetData(self)
     super.resetData(self)
     self:__initData()
end

function __initData(self)
    -- 当前选择的英雄id
    self.m_heroId = nil
    -- 当前选择装备的id
    self.m_equipId = nil
    self.mSelectEquip = nil
end

function getNowSelectEquip(self)
    return self.mSelectEquip
end

function setNowSelectEquip(self, equipVo)
    self.mSelectEquip = equipVo
    if(equipVo) then 
        if read.ReadManager:isModuleRead(ReadConst.NEW_EQUIP, equipVo.id) then
            GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, {  type = ReadConst.NEW_EQUIP,id = equipVo.id })
        end
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_BRACELETS_TIPS, equipVo)
end

function setHeroId(self, heroId)
    if(heroId == self.m_heroId)then
        return
    end
    self.m_heroId = heroId
    self:dispatchEvent(self.SELECTE_CHANGE, {})
end

function getHeroId(self)
    return self.m_heroId
end

function setEquipId(self, equipId)
    if(equipId == self.m_equipId)then
        return
    end
    self.m_equipId = equipId
    self:dispatchEvent(self.SELECTE_CHANGE, {})
end

function getEquipId(self)
    return self.m_equipId
end

function getEquipVo(self, equipId, heroId)
    equipId = equipId and equipId or self.m_equipId
    heroId = heroId and heroId or self.m_heroId
    --local equipVo = nil
    --if(heroId and heroId > 0)then
    --    local heroVo = hero.HeroManager:getHeroVo(heroId)
    --    equipVo = heroVo:getEquipById(equipId)
    --else
    local equipVo = bag.BagManager:getPropsVoById(equipId)
    --end
    return equipVo
end

--析构函数
function dtor(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
