--[[
-----------------------------------------------------
@filename       : FormationGuildBossImitateController
@Description    : 地图探索副本
@date           : 2023-10-23 16:07:28
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("formation.FormationGuildBossImitateController", Class.impl("game.formation.normal.controller.FormationController"))

---------------------------------------------------------------固定需要-----------------------------------------------------------------
function getManager(self)
    return formation.FormationGuildBossImitateManager
end

--屏蔽，由父类一次性请求
function gameStartCallBack(self)
end

--屏蔽，由父类一次性注册
-- function registerMsgHandler(self)
-- end

---------------------------------------------------------------按需重写----------------------------------------------------------------

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
