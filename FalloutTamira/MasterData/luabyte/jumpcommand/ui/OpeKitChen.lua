local M = BaseClass("OpeKitChen", BaseJumpCommand)

function M:Execute(args)
    local roomData = OtakuRoomDataMgr:GetInstance():RoomDatasByRoomType(OtakuType.OtakuRoomType.EST_Kitchen)
    if not roomData or not roomData[1] then
        return false
    end

    self:ShowUI(UIDefine.UIKitChen, roomData[1], args[4])
    return true
end

return M
