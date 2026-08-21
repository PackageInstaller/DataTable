-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\BattleObject\\BattleWeatherManager.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local ResBattleWeather = require("ClientData/ResBattleWeather")
local strClassName = "BattleWeatherManager"
local BattleWeatherManager = Class(strClassName)

function BattleWeatherManager:ctor(mgr, battleConfig)
	self.mgr = mgr
	self.battleDefaultWeather = battleConfig.weather
	self.battleNowWeather = nil
	self.weatherNowMaster = nil
	self.battleNowWeatherFrame = nil
	self.weatherFriendState = nil
	self.weatherEnemyState = nil
	self.weatherCamp = BattleConst.CAMP_PLAYER

	self:onWeatherEffect(nil, true)
end

function BattleWeatherManager:enterWeather(weather, lastTime, attacker)
	if self.battleNowWeather ~= weather or not attacker or attacker.id ~= self.weatherNowMaster then
		if self.battleNowWeather or self.battleDefaultWeather then
			self:onLeaveNowWeather()
		end

		if attacker then
			self.weatherNowMaster = attacker.id
		end

		self.battleNowWeather = weather

		self:onWeatherEffect(attacker)
	end

	if lastTime and lastTime > 0 then
		self.battleNowWeatherFrame = math.floor(lastTime * self.mgr.framePerSec)
	else
		self.battleNowWeatherFrame = nil
	end
end

function BattleWeatherManager:onWeatherEffect(attacker, fromInit)
	local effWeather = self.battleNowWeather or self.battleDefaultWeather
	local weatherData = ResBattleWeather[effWeather]

	if weatherData then
		self.weatherFriendState = weatherData.friend_state_id
		self.weatherEnemyState = weatherData.enemy_state_id

		if attacker then
			self.weatherCamp = attacker.camp
		else
			self.weatherCamp = BattleConst.CAMP_PLAYER
		end

		if not fromInit then
			for _, objId in ipairs(self.mgr.orderObjects) do
				local obj = self.mgr.objects[objId]

				if obj.camp == self.weatherCamp and self.weatherFriendState then
					self.mgr:addGlobalState(self.weatherFriendState, obj)
				elseif obj.camp ~= self.weatherCamp and self.weatherEnemyState then
					self.mgr:addGlobalState(self.weatherEnemyState, obj)
				end
			end
		end

		self.mgr:addOutput(BattleConst.MATRIX_EVENT_ADD_WEATHER, nil, {
			effWeather,
			attacker
		})
	end
end

function BattleWeatherManager:onLeaveNowWeather()
	for _, objId in ipairs(self.mgr.orderObjects) do
		local obj = self.mgr.objects[objId]

		if obj.camp == self.weatherCamp and self.weatherFriendState then
			self.mgr:delGlobalState(self.weatherFriendState, obj)
		elseif obj.camp ~= self.weatherCamp and self.weatherEnemyState then
			self.mgr:delGlobalState(self.weatherEnemyState, obj)
		end
	end

	self.mgr:addOutput(BattleConst.MATRIX_EVENT_DEL_WEATHER, nil, {
		self.battleNowWeather or self.battleDefaultWeather
	})

	self.battleNowWeather = nil
	self.battleNowWeatherFrame = nil
	self.weatherNowMaster = nil
	self.weatherFriendState = nil
	self.weatherEnemyState = nil
end

function BattleWeatherManager:nowWeatherTimeOut()
	if self.battleNowWeather then
		self:onLeaveNowWeather()
		self:onWeatherEffect()
	end
end

function BattleWeatherManager:nextFrame(frameNumber)
	if self.battleNowWeatherFrame then
		self.battleNowWeatherFrame = self.battleNowWeatherFrame - 1

		if self.battleNowWeatherFrame <= 0 then
			self:nowWeatherTimeOut()
		end
	end
end

return BattleWeatherManager
