local M = BaseClass("OpenStage", BaseJumpCommand)
local EBattleStyle = EnumConst.EBattleStyle
M.moduleId = ModuleConfig.StageModule.id

function M:Execute(args)
    local missionId, activityId, _, battleStyle, chapterfg = table.unpack(args)
    if activityId > 0 then
        ActivityCopyDataMgr:GetInstance():SetActivity(activityId)
    end
    if battleStyle and chapterfg then
        self:ChangeModule(M.moduleId, battleStyle, chapterfg)
    else
        if missionId == -1 then
            missionId = IPlayerData.missionId
        elseif missionId == -2 then
            missionId = MissionDataMgr:GetInstance():GetLastHardMissionId()
        end
        if missionId <= 0 then
            Logger.LogError(string.format("OpenStage execute 失败, mission id = %d", missionId))
            return false
        end

        battleStyle = EBattleStyle.Normal
        local missionCfg = ConfigHelper.GetCfg('mission', missionId)
        if missionCfg then
            chapterfg = ConfigHelper.GetCfg('chapter', missionCfg.chapterID)
            if chapterfg then
                if chapterfg.type == ChapterConst.EChapterType.ECT_Encounter then
                    battleStyle = EBattleStyle.Encount
                elseif chapterfg.type == ChapterConst.EChapterType.ECT_Personal then
                    battleStyle = EBattleStyle.Personal
                end
                self:ChangeModule(M.moduleId, battleStyle, chapterfg, missionId)
            else
                Logger.LogError("chapter is 空. id = " .. tostring(missionCfg.chapterID))
                return false
            end
        else
            chapterfg = ConfigHelper.GetCfg('chapter', IPlayerData:GetMyNextChapterId())
            self:ChangeModule(M.moduleId, battleStyle, chapterfg)
        end
    end
    return true
end

return M
