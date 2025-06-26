module("arenaHall.arena.view.ArenaAwardRank", Class.impl(arena.ArenaAwardSegement))
-- UIRes = UrlManager:getUIPrefabPath("arenaHall/arena/ArenaAwardTabView.prefab")
function initViewText(self)
    self.mTxtTitleLeft.text = "当前排名" --_TT(1108)--"当前"
    self.mTxtTile_01.text ="排行"
end

function getType(self)
    return  arena.ArenaAwardType.RANKAWARD
end

return _M