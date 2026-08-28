---@class LadderCompetionUtils
local LadderCompetionUtils = {}

function LadderCompetionUtils.GetGradeVo(segment, subSegment)
    local tableName = AutoIds.IdSetting2561.."IDGroup"
    local key = tostring(segment).."_"..tostring(subSegment)
    local tableFile = SettingMgr:GetInstance():Get(tableName)
    ---@type TableML.TableFileRow
    local row = tableFile:GetByPrimaryKey(key, false)
    if isNotNull(row) then
        local id = row:Get("ids")
        local gradeVo  = CfUtils.GetCfVo(AutoIds.IdSetting2561, "LadderGradeVo", id)
        return gradeVo or LadderCompetionUtils.GetGradeVo(1,1)
    else
        return LadderCompetionUtils.GetGradeVo(1,1)
    end
end

--- 检查大段里面有几个小段
---@param segment any
function LadderCompetionUtils.GetSubSegmentCount(segment)
    segment = checkNumber(segment)
    local dict = {}
    local allVo = CfUtils.GetCf(AutoIds.IdSetting2561, "LadderGradeVo", true)
    if isNotNull(allVo) and table.count(checkTable(allVo)) > 0 then
        for i, vo in ipairs(allVo) do
            if isNotNull(vo) and checkNumber(vo.status) > 0 then
                local segment = checkNumber(vo.rank)
                local subSegment = checkNumber(vo.starPVP)
                dict[segment] = isNull(dict[segment]) and 1 or (dict[segment] + 1)
            end
        end
    end
    
    return dict[segment]
end

return LadderCompetionUtils