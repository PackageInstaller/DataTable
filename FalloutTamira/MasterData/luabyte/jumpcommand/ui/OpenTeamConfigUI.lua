local M = BaseClass("OpenTeamConfigUI", BaseJumpCommand)
local EBattleStyle = EnumConst.EBattleStyle

function M:Execute(args)
    local handler = TeamConfMgr:GetInstance():OpenTeamConfUI(args[4], args[5],args[6],args[7],args[8])
    handler.onShow = self.onComplete
    return true
end

return M
