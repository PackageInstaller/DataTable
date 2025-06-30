module("formation.FormationElementTowerManager", Class.impl("game.formation.normal.manager.FormationManager"))

-- function getFightTeamId(self)
--     -- 服务器返回来的只有一个，是非出战状态，需客户端特殊处理
--     local allTeamIdList = self:getAllTeamIdList()
--     if (not table.empty(allTeamIdList)) then
--         return allTeamIdList[1]
--     end
-- end

-- -- 根据队列id获取阵型选择中的英雄列表
-- function getSelectFormationHeroList(self, teamId)
--     local res = super.getSelectFormationHeroList(self, teamId)
--     local lockList = {}
--     if(not dup.DupApostlesWarManager.mIsTrain) then 
--         local bossList = dup.DupApostlesWarManager:getPanelInfo().bossList
--         for i = 1, #bossList do
--             if bossList[i].id ~= self:getDataId() then 
--                 for k,v in pairs(bossList[i].lockHeroList) do
--                     table.insert(lockList, v)
--                 end
--             end
--         end
--     end
--     for i=#res,1, -1 do
--         if(table.indexof(lockList, res[i].heroId)) then 
--             LuaPoolMgr:poolRecover(res[i])
--             table.remove(res, i)
--         end
--     end
--     return res
-- end

return _M