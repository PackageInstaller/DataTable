module("equip.EquipSuitConfigVo", Class.impl())

function ctor(self)
end

function parseConfigData(self, cusSuitId, cusData)
    self.suitId = cusSuitId
    self.name = _TT(cusData.name)
    self.englishName = _TT(cusData.english)
    self.effectDes = _TT(cusData.desc)
    self.suitSkillId_2 = cusData.suit_skill2
    self.suitSkillId_4 = cusData.suit_skill4
    self.featuresDes = _TT(cusData.features)

    self.icon = cusData.icon
end

-- 获取背包中属于当前套装的道具数量
function getSuitEquipCount(self, slotPos, isHeroWear)
    local hasCount = 0
    local equipList = bag.BagManager:getPropsListByType(PropsType.EQUIP, nil, bag.BagType.Equip)
    for i = 1, #equipList do
        local equipConfigVo = equip.EquipManager:getEquipConfigVo(equipList[i].tid)
        if (self.suitId == equipConfigVo.suitId) then
            if (slotPos == nil or slotPos == equipList[i].subType) then
                if (isHeroWear == false) then
                    if (equipList[i].heroId <= 0) then
                        hasCount = hasCount + 1
                    end
                elseif (isHeroWear == true) then
                    if (equipList[i].heroId > 0) then
                        hasCount = hasCount + 1
                    end
                else
                    hasCount = hasCount + 1
                end
            end
        end
    end

    -- if heroWear then
    -- 	local heroDic = hero.HeroManager:getHeroDic()
    --     for heroId, heroVo in pairs(heroDic) do
    -- 		if(heroVo.equipList)then
    -- 			for i, equipVo in pairs(heroVo.equipList) do
    -- 				local equipConfigVo = equip.EquipManager:getEquipConfigVo(equipVo.tid)
    -- 				if(self.suitId == equipConfigVo.suitId) then
    -- 					if(not slotPos or equipVo.subType == slotPos) then
    -- 						hasCount = hasCount + 1
    -- 					end
    -- 				end
    -- 			end
    --         end
    --     end
    -- end

    return hasCount
end

function getIsNew(self)
    return read.ReadManager:isModuleRead(ReadConst.MANUAL_CHIP, self.suitId)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]