module("arenaHall.arena.view.ArenaAwardDaily ", Class.impl(arena.ArenaAwardSegement))
-- UIRes = UrlManager:getUIPrefabPath("arenaHall/arena/ArenaAwardTabView.prefab")

function initViewText(self)
    self.mTxtTitleLeft.text = "当前段位" --_TT(1108)--"当前"
    self.mTxtTile_01.text ="段位"
end

function getType(self)
    return   arena.ArenaAwardType.DAILY
end
return _M