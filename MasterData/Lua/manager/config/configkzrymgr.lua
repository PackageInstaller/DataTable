ConfigKZRYMgr = {}

local this = {
  
};

ConfigKZRYMgr.Init = function()
	
end

ConfigKZRYMgr.Clear = function()
    
end


ConfigKZRYMgr.GetDungeonName = function(id)
    local dungeon = ConfigMgr.Config.dungeonMap[id];
    if (dungeon ~= nil) then
        return LuaMgr.GetLangText(dungeon.NameLan);
    end
    return "";
end