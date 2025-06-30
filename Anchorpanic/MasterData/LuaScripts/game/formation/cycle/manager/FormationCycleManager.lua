module("formation.FormationCycleManager", Class.impl("game.formation.normal.manager.FormationManager"))

-- 此类为了派发事件到对应的控制器，或修改对应继承而来的方法

-- function getFightTeamId2(self, type, dataId)
--     dataId = dataId or 1
--      -- 服务器返回来的只有一个，是非出战状态，需客户端特殊处理
--      local allTeamIdList = formation.getTeamIdListByType(type, dataId)
--      if (not table.empty(allTeamIdList)) then
--          return allTeamIdList[1]
--      end
-- end

--getFightTeamId


return _M