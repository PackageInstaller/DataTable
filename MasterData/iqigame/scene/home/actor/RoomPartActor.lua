-- chunkname: @IQIGame\\Scene\\Home\\Actor\\RoomPartActor.lua

local HomeActor = require("IQIGame/Scene/Home/Actor/HomeActor")
local RoomPartActor = Clone(HomeActor)

RoomPartActor.gameObject = nil

function RoomPartActor:CreateView(skinPath, parentTrans)
	self:__LoadPrefab(skinPath, parentTrans)
end

function RoomPartActor:GetPartConfig()
	return CfgHomeRoomPartTable[self.actorCid]
end

function RoomPartActor:__LoadPrefab(prefabPath, parent)
	AssetUtil.LoadAsset(self, prefabPath, function(_, _assetUrl, _asset, _duration, _userData)
		self:__OnPrefabLoadSuccess(_asset, parent)
	end, function(_assetName, _status, _errorMessage, _userData)
		logError("家园系统加载Part失败 {0} -> {1}", self.actorCid, prefabPath)
	end)
end

function RoomPartActor:__OnPrefabLoadSuccess(asset, parent)
	self.gameObject = GameObject.Instantiate(asset)
	self.gameObject.name = tostring(self.actorCid)
	self.gameObject.transform.parent = parent
	self.gameObject.transform.localPosition = Vector3.zero
	self.gameObject.transform.localScale = Vector3.one

	self:__OnInitPrefab()
end

function RoomPartActor:__OnInitPrefab()
	return
end

function RoomPartActor:__OnDispose()
	self:__RoomPartActor_OnDispose()
end

function RoomPartActor:__RoomPartActor_OnDispose()
	AssetUtil.UnloadAsset(self)

	self.gameObject = nil
end

return RoomPartActor
