-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bulletscreen/config/BulletScreenConfig.lua

module("logic.extensions.bulletscreen.config.BulletScreenConfig", package.seeall)

local BulletScreenConfig = class("BulletScreenConfig", BaseConfig)

function BulletScreenConfig:onInit()
	self._bullets = {}
end

function BulletScreenConfig:getNames()
	return {
		"bullet_screen_formation",
		"bullet_screen_battle",
		"bullet_screen_plotcg"
	}
end

function BulletScreenConfig:handleConfig(name, content)
	if name == "bullet_screen_formation" then
		self._bullets[GameEnum.BulletScene.Formation] = self:parseContent(content)
	elseif name == "bullet_screen_battle" then
		self._bullets[GameEnum.BulletScene.InBattle] = self:parseContent(content)
	elseif name == "bullet_screen_plotcg" then
		self._storyHashMap = self:parseStoryContent(content)
	end
end

function BulletScreenConfig:parseContent(content)
	local t = {}

	for id, cfg in pairs(content) do
		if checknumber(id) > 0 then
			local key = cfg.key

			t[key] = t[key] or {}

			table.insert(t[key], cfg)
		end
	end

	return t
end

function BulletScreenConfig:parseStoryContent(content)
	local hashMap = {}

	for _, v in ipairs(content.dataList) do
		local key = checknumber(v.key)

		hashMap[key] = hashMap[key] or {}
		hashMap[key].maxStoryId = hashMap[key].maxStoryId or 0
		hashMap[key].maxStoryId = math.max(hashMap[key].maxStoryId, v.story_id)

		local story_id = hashMap[key].maxStoryId

		hashMap[key][story_id] = hashMap[key][story_id] or {}

		local list = hashMap[key][story_id]

		table.insert(list, v)
	end

	return hashMap
end

function BulletScreenConfig:getCfgList(enum, key)
	if enum == GameEnum.BulletScene.PlotCG then
		local arr = string.split(key, "_")
		local id = checknumber(arr[1])
		local story_id = checknumber(arr[2])

		if self._storyHashMap and self._storyHashMap[id] then
			return self._storyHashMap[id][story_id] or {}
		end

		return {}
	elseif self._bullets[enum] then
		return self._bullets[enum][key] or {}
	end

	return {}
end

function BulletScreenConfig:getStoryMaxStoryId(id)
	if self._storyHashMap and self._storyHashMap[id] then
		return checknumber(self._storyHashMap[id].maxStoryId)
	end

	return 0
end

BulletScreenConfig.instance = BulletScreenConfig.New()

return BulletScreenConfig
