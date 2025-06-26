module('dup.DupChallengeManager', Class.impl(Manager))

--构造函数
function ctor(self)
    super.ctor(self)


    local data = funcopen.FuncOpenManager:getFuncOpenData(funcopen.FuncOpenConst.FUNC_ID_CHELLENGE_TOWER)
    if data.event == 1 then

    else

    end

    self.dupList = {
        { type = DupType.DUP_CLIMB_TOWER, funcopenId = funcopen.FuncOpenConst.FUNC_ID_CHELLENGE_TOWER, name = _TT(73001) }, --'巴弥尔要塞'
        { type = DupType.DUP_CODE_HOPE, funcopenId = funcopen.FuncOpenConst.FUNC_ID_CODE_HOPE, name = _TT(73002) }, --'代号·希望'
        -- { type = DupType.DUP_IMPLIED, funcopenId = funcopen.FuncOpenConst.FUNC_ID_IMPLIED, name = _TT(73003) }, --'默示之境'
        { type = DupType.DUP_APOSTLE_WAR, funcopenId = funcopen.FuncOpenConst.FUNC_ID_APOSTLE2_WAR, name = _TT(73004) }, --'使徒之战'
        { type = DupType.DUP_MAZE, funcopenId = funcopen.FuncOpenConst.FUNC_ID_MAZE, name = _TT(73005) }, --'移动迷宫'
        { type = DupType.RogueLike,funcopenId = funcopen.FuncOpenConst.FUNC_ID_ROGUE,name = _TT(73006)},
        { type = DupType.Doundless,funcopenId = funcopen.FuncOpenConst.FUNC_ID_BOUNDLESS,name = "无限城"},
        { type = DupType.Seaded,funcopenId = funcopen.FuncOpenConst.FUNC_ID_SEADED,name = _TT(111017)},
        --{ type = 0, funcopenId = 0, name = '0' },
    }

    self:updateList()
end

function updateList(self)
    self.newDupList = {}
    for i = 1, #self.dupList do
        local data = funcopen.FuncOpenManager:getFuncOpenData(self.dupList[i].funcopenId)
        local isOpen = funcopen.FuncOpenManager:isOpen(self.dupList[i].funcopenId,false)

        if (data.event == 1 and battleMap.MainMapManager:isStagePass(data.eventDupId)) or isOpen then
            table.insert(self.newDupList,self.dupList[i])
        else

        end
    end
    return self.newDupList
end

function getNewList(self)
    local dupList = self:updateList()
    table.sort( dupList, function(d1, d2)
        if(d1 and d2) then 
            local funcId1 = funcopen.FuncOpenManager:getFuncOpenData(d1.funcopenId).dupId
            local funcId2 = funcopen.FuncOpenManager:getFuncOpenData(d2.funcopenId).dupId
            if(funcId1 == funcId2) then 
                return false
            end
            return funcId1 < funcId2
        end
        return false
    end )
    return dupList
end

-- 获取挑战副本进度
function getDupProgress(self, cusType)
    if cusType == DupType.DUP_CLIMB_TOWER then
        return dup.DupClimbTowerManager:getDupProgress()
    elseif cusType == DupType.DUP_CODE_HOPE then
        return dup.DupCodeHopeManager:getChapterProgress()
    end
    return 0, 0
end
-- 获取挑战副本是否已通关
-- function getDupIsPass(self, cusType)
--     if cusType == DupType.DUP_CLIMB_TOWER then
--         return dup.DupClimbTowerManager:getDupProgress()
--     elseif cusType == DupType.DUP_CODE_HOPE then
--         return dup.DupCodeHopeManager:getChapterProgress()
--     end
--     return 0, 0
-- end
-- 获取挑战副本信息
function getChallengeDupData(self, cusType)
    for i = 1, #self.dupList do
        if cusType == self.dupList[i].type then
            return self.dupList[i]
        end
    end
    return nil
end

function checkFlag(self)
    if dup.DupCodeHopeManager:checkFlag() then
        return true
    end
    if dup.DupApostlesWarManager:checkFlag() then
        return true
    end
    return false
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
