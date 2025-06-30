--[[ 
-----------------------------------------------------
@filename       : ArenaHellLogDefenseTabView
@Description    : 巅峰竞技场防御界面
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]

module("arenaEntrance.ArenaHellLogDefenseTabView", Class.impl(arenaEntrance.ArenaLogAttackTabView))
UIRes = UrlManager:getUIPrefabPath("arenaEntrance/tab/ArenaHellLogTabView.prefab")

function getOpenType()
    return arenaEntrance.ArenaEntaceLogType.TypeDefense
end 



return _M