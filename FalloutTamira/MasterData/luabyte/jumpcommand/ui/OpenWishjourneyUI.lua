local M = BaseClass("OpenWishjourneyUI", BaseJumpCommand)
M.roomType = OtakuType.OtakuRoomType.EST_Survey
M.uiName = "WishjourneyUI"

function M:Execute(args)
    local roomDatas = OtakuRoomDataMgr:GetInstance():RoomDatasByRoomType(M.roomType)
    if #roomDatas > 0 then
        self:ShowUI(M.uiName, roomDatas[1])
        return true
    end

    GameHelper.TipsById(5719) -- 未建造调查舱
    return false
end

return M
