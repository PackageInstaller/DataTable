local M = BaseClass("OpenBossWarMainUI", BaseJumpCommand)

function M:Execute(args)
    if BossWarDataMgr:GetInstance():LockId() > 0 then return false end
    BossWarDataMgr:GetInstance():ReqBossBattleInfo(function()
        UIContextMgr:GetInstance():Show("BossWarMainUI")
    end)
    return true
end

return M
