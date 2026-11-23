ConfigSGYMgr = {}

SGYActivity = {
    Main = "GuoBao01",
    Battle = "GuoBao02",
}

local this = {
    novelList = nil,
};

ConfigSGYMgr.Init = function()
	
end

ConfigSGYMgr.Clear = function()
    this.novelList = nil;
end


ConfigSGYMgr.GetFurnitureActives = function(type)
    local dataList = {};
    local furnitureActives = ConfigMgr.Config.FurnitureActives;
    if (furnitureActives ~= nil) then
        local furnitureActive;
        local len = #furnitureActives;
        for i = 1, len do
            furnitureActive = furnitureActives[i];
            if (furnitureActive.Type == type) then
                table.insert(dataList, furnitureActive);
            end
        end
    end
    return dataList;
end


ConfigSGYMgr.InitNovel = function(datas)
    this.novelList = {};
    for _, v in pairs(datas) do
        for _, n in pairs(v.NarrativesId) do
            table.insert(this.novelList, {id = v.Id, novel = n});
        end
    end
end


ConfigSGYMgr.GetNovelList = function()
    return this.novelList;
end


ConfigSGYMgr.HasNovel = function(id)
    local novel;
    local len = #this.novelList;
    for i = 1, len do
        novel = this.novelList[i];
        if (novel.id == id) then
            return true;
        end
    end
    return false;
end


ConfigSGYMgr.GetDungeonName = function(id)
    local dungeon = ConfigMgr.Config.dungeonMap[id];
    if (dungeon ~= nil) then
        return LuaMgr.GetLangText(dungeon.NameLan);
    end
    return "";
end