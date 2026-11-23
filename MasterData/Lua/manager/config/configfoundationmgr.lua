ConfigFoundationMgr = {}

local this = {
	interactionMap = {},
	furnitureList = {},
	furnitureSubclassList = {},
	roomList = {},
	roomStyleList = {},
	activityRoomList = {},
};

ConfigFoundationMgr.Init = function()
	ConfigFoundationMgr.Clear();
	this.InitInteraction();
	this.InitFurniture();
	this.InitRoomList();
	this.InitRoomStyle();
end

ConfigFoundationMgr.Clear = function()
	this.interactionMap = {};
	this.furnitureList = {};
	this.furnitureSubclassList = {};
	this.roomList = {};
	this.roomStyleList = {};
	activityRoomList = {};
end


this.InitInteraction = function()
	local config;
	local interactions = ConfigMgr.Config.interactionMap;
	local len = #interactions;
	for i = 1, len do
		config = interactions[i];
		this.interactionMap[config.Id] = config;
	end
end


ConfigFoundationMgr.GetInteractionById = function(id)
	return this.interactionMap[id];
end


ConfigFoundationMgr.GetInteractionByGroupLevel = function(group, level)
	local config;
	local interactions = ConfigMgr.Config.interactionMap;
	local len = #interactions;
	for i = 1, len do
		config = interactions[i];
		if (config.Group == group and config.Level == level) then
			return config;
		end
	end
	return nil;
end


ConfigFoundationMgr.GetFormulaWorkLoad = function(id, count)
	local formula = ConfigMgr.Config.FormulaMap[id];
	if (formula ~= nil) then
		return formula.Workload * count;
	end
	return 0;
end 


this.InitFurniture = function()
	local config;
	local interactions = ConfigMgr.Config.interactionMap;
	local len = #interactions;
	for i = 1, len do
		config = interactions[i];
		if (config.Type == 10) then
			table.insert(this.furnitureList, config);
			this.AddFurnitureSubclass(config.Subclass);
		end
	end
end


this.AddFurnitureSubclass = function(subclass)
	local len = #this.furnitureSubclassList;
	for i = 1, len do
		if (this.furnitureSubclassList[i] == subclass) then
			return;
		end
	end
	table.insert(this.furnitureSubclassList, subclass);
end


ConfigFoundationMgr.GetFurnitureSubclassList = function()
	return this.furnitureSubclassList;
end


ConfigFoundationMgr.GetFurnitures = function(subclass)
	local config;
	local furnitures = {};
	local sysTime = LuaMgr.Timestamp();
	local len = #this.furnitureList;
	for i = 1, len do
		config = this.furnitureList[i];
		if (config.Subclass == subclass and sysTime > config.StartTime) then
			table.insert(furnitures, config);
		end
	end
	return furnitures;
end


ConfigFoundationMgr.GetDefualtMusic = function()
	local foundationMusicMap = ConfigMgr.Config.FoundationMusicMap;
	for _, v in pairs(foundationMusicMap) do
		if (v.Default) then
			return v;
		end
	end
	return nil;
end


ConfigFoundationMgr.PlayBgmMusic = function()

	local musicData = DataMgr.Player.FoundationMusicData;
	if (musicData == nil or #musicData.List  <= 0) then
		local music;
		music = ConfigFoundationMgr.GetDefualtMusic();
		local path = string.format("%sBgm/%s.mp3", Path.audio_PATH, music.Resources);
		AudioMgr.Singleton:PlayBgm(path, true);
	else
		local paths = {}
		local foundationMusicMap = ConfigMgr.Config.FoundationMusicMap;
		for i, v in ipairs(musicData.List) do
			if foundationMusicMap[v]~=nil then
				local path = string.format("%sBgm/%s.mp3", Path.audio_PATH, foundationMusicMap[v].Resources);
				table.insert(paths,path)
			end
		end
		if #paths>0 then
			AudioMgr.Singleton:PlayBGMList(paths, true,musicData.Type);
		end
	end
end


ConfigFoundationMgr.GetVendingMachineDamage = function(count)
	local list = ConfigMgr.Config.VendingCumulativeList;
	if (list ~= nil) then
		local item;
		local pCount = 0;
		local len = #list;
		for i = 1, len do
			item = list[i];
			if (count < item.Id) then
				return count - pCount, item.Id - pCount;
			end
			pCount = item.Id;
		end
	end
	return 1, 1;
end


this.InitRoomList = function()
	this.roomList = {};
	this.activityRoomList = {};
	local map = ConfigMgr.Config.roomMap;
	for _, v in pairs(map) do
		if (v.CanPutFurniture) then
			if (tonumber(v.Id) > 200) then
				table.insert(this.activityRoomList, v);
			else
				table.insert(this.roomList, v);
			end
		end
	end
	table.sort(this.roomList, this.RoomListSort);
	table.sort(this.activityRoomList, this.RoomListSort);
end


this.RoomListSort = function(a, b)
	return string.lower(a.Id) < string.lower(b.Id);
end


ConfigFoundationMgr.GetRoomList = function()
	return this.roomList;
end


ConfigFoundationMgr.GetActivityRoomList = function()
	return this.activityRoomList;
end


this.InitRoomStyle = function()
	this.roomStyleList = {};
	local map = ConfigMgr.Config.RoomStyleMap;
	for _, v in pairs(map) do
		if (v.Scene ~= "") then
			table.insert(this.roomStyleList, v);
		end
	end
	table.sort(this.roomStyleList, this.ThemeSort);
end


this.ThemeSort = function(a, b)
	return string.lower(a.Id) < string.lower(b.Id);
end


ConfigFoundationMgr.GetRoomStyleList = function()
	local style;
	local sysTime = LuaMgr.Timestamp();
	local styleList = {};
	local len = #this.roomStyleList;
	for i = 1, len do
		style = this.roomStyleList[i];
		if (sysTime >= style.StartTime) then
			table.insert(styleList, style);
		end
	end
	return styleList;
end


ConfigFoundationMgr.GetStylePutList = function(putId)
	local list = {};
	local map = ConfigMgr.Config.RoomputMap;
	for _, v in pairs(map) do
		if (v.Room == putId) then
			table.insert(list, v);
		end
	end
	return list;
end


ConfigFoundationMgr.GetThemeFurnitureComfort = function(roomPutId)
	local put;
	local count;
	local config;
	local comfort = 0;
	local itemMap = {};
	local roomId = FoundationMgr.GetRoomId();
	local putList = ConfigFoundationMgr.GetStylePutList(roomPutId);
	local len = #putList;
	for i = 1, len do
		put = putList[i];
		count = itemMap[put.Furniture];
		config = ConfigFoundationMgr.GetInteractionById(put.Furniture);
		if (config ~= nil) then
			if (count == nil) then
				count = PlayerFoundationMgr.GetFurnitureItemCount(config.Furniture);
				if (count == nil) then
					count = 0;
				end
				count = count + PlayerFoundationMgr.GetPutFurnitureCount(roomId, put.Furniture);
				itemMap[put.Furniture] = count;
			end
			if (count >= 1) then
				itemMap[put.Furniture] = count - 1;
				comfort = comfort + config.Comfort;
			end
		end
	end
	return comfort;
end