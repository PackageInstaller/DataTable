DataMgr = {}

DataMgr.Player = {};
DataMgr.TestPlayer = {};

function DataMgr.Init()
	PlayerRhythmGameMgr.Init()
end

function DataMgr.Clear()
	DataMgr.Player = {};
	PlayerFoundationMgr.Clear();
	PlayerRhythmGameMgr.Clear();
	PlayerSkinMgr.Clear();
	PlayerQinMgr.Clear();
	PlayerGuoBaoMgr.Clear();
	PlayerSGYMgr.Clear();
	UIConfig.Clear()
end

function DataMgr.DataKeys(data)

	local jsonData = json.decode(data);
	local dataKeys = jsonData.dataKeys;
	local len = #dataKeys;
	if (len > 0) then
		for i = 1, len do
			DataMgr.Player[dataKeys[i]] = jsonData.data[dataKeys[i]];
		end
	end
	PlayerCharacterMgr.CheckCharacter();
	PlayerFoundationMgr.Init();
	PlayerSkinMgr.Init();
	PlayerVoyageMgr.CheckRedDot();
	PlayerQinMgr.Init();
	PlayerGuoBaoMgr.Init();
	PlayerSGYMgr.Init();
	DataMgr.UpdatePlayerData()
end

function DataMgr.DataPatch(data)

	local tempData;
	local len;
	local item;
	local itemData;
	local jsonData = json.decode(data);
	local dataPatch = jsonData.dataPatch;
	for k, v in pairs(dataPatch) do
		if DataMgr.Player[k]==nil then
			k = DataMgr.FirstToLower(k);
		end
		tempData = DataMgr.Player[k];
		if (tempData == nil) then
			tempData = {};
			DataMgr.Player[k] = tempData;
		end
		len = #v;
		for i = 1, len do
			item = v[i];
			tempData[item.key] = nil;
			if (item.op == "set") then
				itemData = json.decode(item.value);
				tempData[item.key] = itemData;
			end
		end
	end
	PlayerCharacterMgr.CheckCharacter();
	PlayerFoundationMgr.Init();
	PlayerVoyageMgr.CheckRedDot();
	PlayerQinMgr.Init();
	PlayerGuoBaoMgr.Init();
	PlayerSGYMgr.Init();
	DataMgr.UpdatePlayerData(dataPatch)
end

function DataMgr.TestData(data)
	local jsonData = json.decode(data);
	DataMgr.TestPlayer = jsonData.data
end

function DataMgr.FirstToUpper(str)
	return (str:gsub("^%l",string.upper));
end

function DataMgr.FirstToLower(str)
	return (str:gsub("^%u",string.lower));
end

function DataMgr.FrushPlayerData(callBack)
	local data = {}
	data.DeviceID = LuaMgr.GetToken()
	ApiMgr.Request("heartbeat",data,true,function(result)
		if callBack~=nil then
			callBack();
		end
	end,nil,true)
end 

function DataMgr.UpdatePlayerData(dataPatch)
	local itemDatas = DataMgr.Player.items
	local costItemDatas = DataMgr.Player.costitems
	if (IsNull(costItemDatas)) then return end
	
	if dataPatch ~= nil then
		for k, v in pairs(dataPatch) do
			if k == "CostItems" then
				costItemDatas = DataMgr.Player.costItems
				DataMgr.Player.costitems = DataMgr.Player.costItems
			end
		end
	end

	if costItemDatas ~= nil then
		for k, v in pairs(costItemDatas) do
			itemDatas[k] = {
				id = k,
				count0 = v.count0
			}
		end
	end
end 