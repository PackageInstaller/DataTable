--
-- Author:luqucheng
-- Date: 2019-12-10 18:09:07
--
local CardRecordReader = {}
local WaitForSeconds = CS.UnityEngine.WaitForSeconds
function CardRecordReader:DoRecord( record )
    --判断阵营
    local camp = record.c
    local event = BattleInfo:IsUserCamp(camp) and Constants.EventNames.BattleMyCard or Constants.EventNames.BattleEnemyCard
    if  BattleInfo:IsUserCamp(camp) then
        -- print("CardRecordReader", table.toString(record, "record"))
    end
    if BattleInfo:IsViewEnable() and record.r == Constants.RecordType.UseCard then
        Events.Broadcast(Constants.EventNames.BattleOnRoleUseCard, {roleId = record.ri})
    end
    Events.Broadcast(event, record)
    -- coroutine.yield( WaitForSeconds(0.5) )
    -- if camp == Constants.TargetCamp.Friend then
    --     print(table.toString(record, "ppppppppp1"))
    -- end
end

function CardRecordReader:DoSubRecord( record )
    self:DoRecord(record)
end


function CardRecordReader:IsCardRecord( recordType )
    local rt = Constants.RecordType
    return recordType == rt.DeleteCard
        or recordType == rt.MoveCard
        or recordType == rt.PushCard
        or recordType == rt.UnitCard
        or recordType == rt.UseCard
        or recordType == rt.SyncCard
        or recordType == rt.ChangeCard
        or recordType == rt.PushCatCard
end


return  CardRecordReader