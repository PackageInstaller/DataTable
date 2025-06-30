--[[ 
    潜能总副本
    @author Zzz
]]
module('dup.DupPotencyManager', Class.impl(dup.DupDailyBaseManager))

function ctor(self)
    super.ctor(self)

    --潜能副本-火潜能副本
    self:setDupType(DupType.DUP_FIRE_POTENCY, PreFightBattleType.DupFirePotency)
    --潜能副本-冰潜能副本
    self:setDupType(DupType.DUP_ICE_POTENCY, PreFightBattleType.DupIcePotency)
    --潜能副本-电潜能副本
    self:setDupType(DupType.DUP_ELECTRIC_POTENCY, PreFightBattleType.DupElectricPotency)
    --潜能副本-虚蚀潜能副本
    self:setDupType(DupType.DUP_CAVITATION_POTENCY, PreFightBattleType.DupCavitationPotency)
    --潜能副本-生蕴潜能副本
    self:setDupType(DupType.DUP_LIFE_POTENCY, PreFightBattleType.DupLifePotency)
end

-- 战斗结算面板显示的名字
function getDupName(self, tileId)
    local dupVo = self:getDupConfigVo(tileId)
    if dupVo then
        return dupVo.name
    else
        return ""
    end
end

function getMaxStageIsOpen(self, linkVo)
    local isCanTurn = false
    local isMid = false
    local tips = ""
    if linkVo.funcOpenId >= funcopen.FuncOpenConst.FUNC_ID_DUP_HERO_STAR_UP and linkVo.funcOpenId <= funcopen.FuncOpenConst.FUNC_ID_DUP_CAVITATION_POTENCY then
        isMid = true
        local type;
        if linkVo.funcOpenId == funcopen.FuncOpenConst.FUNC_ID_DUP_ELECTRIC_POTENCY then
            type = DupType.DUP_ELECTRIC_POTENCY
        elseif linkVo.funcOpenId == funcopen.FuncOpenConst.FUNC_ID_DUP_FIRE_POTENCY then
            type = DupType.DUP_FIRE_POTENCY
        elseif linkVo.funcOpenId == funcopen.FuncOpenConst.FUNC_ID_DUP_ICE_POTENCY then
            type = DupType.DUP_ICE_POTENCY
        elseif linkVo.funcOpenId == funcopen.FuncOpenConst.FUNC_ID_DUP_LIFE_POTENCY then
            type = DupType.DUP_LIFE_POTENCY
        elseif linkVo.funcOpenId == funcopen.FuncOpenConst.FUNC_ID_DUP_CAVITATION_POTENCY then
            type = DupType.DUP_CAVITATION_POTENCY
        else
            type = DupType.DUP_HERO_STAR_UP
        end
        local stageList = dup.DupDailyMainManager:getDupDataList(type)
        local unlockNum = 0
        for i, vo in ipairs(stageList) do
            if dup.DupDailyBaseManager:getDupState(vo) <= 2 then
                unlockNum = unlockNum + 1
            end
        end
        local curIndex = math.ceil((linkVo.linkId - linkVo.funcOpenId) / 4)--4为间隔副本数量
        isCanTurn = unlockNum >= curIndex
        if (not isCanTurn) then
            if dup.DupDailyBaseManager:getDupState(stageList[curIndex]) == 3 then
                tips = _TT(53608)
            elseif dup.DupDailyBaseManager:getDupState(stageList[curIndex]) == 4 then
                tips = _TT(53612, stageList[curIndex].enterLv)
            elseif battleMap.MainMapManager:isStagePass(stageList[curIndex].enterDup) == nil then
                local stageVo = battleMap.MainMapManager:getStageVo(stageList[curIndex].enterDup)
                tips = _TT(53609, stageVo.indexName)
            end
        end
    end
    return isMid, isCanTurn, tips
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]