--[[ 
-----------------------------------------------------
@filename       : FormationCodeHopeManager
@Description    : 代号·希望副本备战
@date           : 2021-05-12 17:00:15
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]

module("formation.FormationCodeHopeManager", Class.impl("game.formation.normal.manager.FormationManager"))

-- 此类为了派发事件到对应的控制器，或修改对应继承而来的方法

-- 获取出战中的队列id
-- function getFightTeamId2(self,type, dataId)
--     dataId = dataId or 1
--     -- 服务器返回来的只有一个，是非出战状态，需客户端特殊处理
--     local allTeamIdList = formation.getTeamIdListByType(type, dataId)
--     if (not table.empty(allTeamIdList)) then
--         return allTeamIdList[1]
--     end
-- end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
