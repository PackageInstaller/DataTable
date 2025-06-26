module("formation.FormationClimbTowerPanel", Class.impl(formation.FormationPanel))

function __onClickBtnControlHandler(self)
    local count = self:getManager():getSelectFilterHeroCount(self.m_teamId)
    if (count <= 0) then
        gs.Message.Show(_TT(1284))
        gs.Message.Show(_TT(29119))
    else
        local function run()
            local data = self:getManager():getData()
            dup.DupClimbTowerManager.isInTowerFight = true
            -- 可能会有援助的怪物，必要同步
            self:getManager():dispatchEvent(self:getManager().REQ_FORMATION_HERO_LIST, {})
            -- 设置出战队列
            self:getManager():dispatchEvent(self:getManager().REQ_SET_FIGHT_TEAM, {
                teamId = self.m_teamId
            })
            -- 放在CALL_FUN_REASON前面，防止会自动弹出其他界面音乐，导致回调打开的界面音乐被顶掉
            self:forceClose()
            -- 回调外部
            self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
            -- 可能会有援助的怪物，通知后端进入战斗后需要撤下，必要同步
            self:rsyncFormationList(true)
        end

        local recommandFight = self:getDupVo().suggestLevel[2] -- 推荐等级
        if (recommandFight == nil or recommandFight <= 0) then
            run()
        else
            local fight = self:getFormationAvgLv()
            if (fight >= recommandFight) then
                run()
            else
                UIFactory:alertMessge(_TT(1366), true, function()
                    run()
                end, _TT(1), nil, true, function()
                end, _TT(2), _TT(5), nil, RemindConst.FORMATION_FIGHT)
            end
        end
    end
end

return _M