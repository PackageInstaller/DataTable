flyChessCamera = class("flyChessCamera", function()
	return ccui.Layout:create()
end)

local var_0_0 = 1
local var_0_1 = 2
local var_0_2 = 3
local var_0_3 = 4

function flyChessCamera.create(arg_2_0, arg_2_1)
	local var_2_0 = flyChessCamera.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function flyChessCamera:init(arg_3_1)
	self:initAttr(arg_3_1)
end

function flyChessCamera.initAttr(arg_4_0, arg_4_1)
	arg_4_0._maxPosX = 0
	arg_4_0._minPosX = 0
	arg_4_0._maxPosY = 0
	arg_4_0._minPosY = 0
	arg_4_0._speedX = 0
	arg_4_0._speedY = 0
	arg_4_0.following = false
	arg_4_0.moving = false
	arg_4_0.scaling = false
	arg_4_0.shaking = false
end

function flyChessCamera.initUI(arg_5_0, arg_5_1)
	return
end

function flyChessCamera:initMap(arg_6_1)
	if not arg_6_1.map then
		return
	end

	self.map = arg_6_1.map

	self:addChild(self.map)
	self.map:setPosition(arg_6_1.initMapPos)
end

function flyChessCamera:initStart()
	if not initInfo.map then
		return
	end

	self.map = initInfo.map

	self:addChild(self.map)
	self.map:setPosition(initInfo.initMapPos)
end

function flyChessCamera:setStartType(arg_8_1)
	if arg_8_1 == var_0_0 then
		self.map:setAnchorPoint(0, 0)
		self:setPosition(0, 0)

		self._maxPosY = 0
		self._minPosY = math.min(GameDisplay.height - self.map:getContentSize().height, 0)
		self._maxPosX = 0
		self._minPosX = math.min(GameDisplay.width - self.map:getContentSize().width, 0)
		self.initPos = cc.p(0, 0)
	elseif arg_8_1 == var_0_1 then
		self.map:setAnchorPoint(0, 1)
		self:setPosition(0, GameDisplay.height)

		self._maxPosY = math.max(self.map:getContentSize().height - GameDisplay.height, 0)
		self._minPosY = 0
		self._maxPosX = 0
		self._minPosX = math.min(GameDisplay.width - self.map:getContentSize().width, 0)
		self.initPos = cc.p(0, GameDisplay.height)
	elseif arg_8_1 == var_0_2 then
		self.map:setAnchorPoint(1, 0)
		self:setPosition(GameDisplay.width, 0)

		self._maxPosY = 0
		self._minPosY = math.min(GameDisplay.height - self.map:getContentSize().height, 0)
		self._maxPosX = math.max(self.map:getContentSize().width - GameDisplay.width, 0)
		self._minPosX = 0
		self.initPos = cc.p(GameDisplay.width, 0)
	elseif arg_8_1 == var_0_3 then
		self.map:setAnchorPoint(1, 1)
		self:setPosition(GameDisplay.width, GameDisplay.height)

		self._maxPosY = math.max(self.map:getContentSize().height - GameDisplay.height, 0)
		self._minPosY = 0
		self._maxPosX = math.max(self.map:getContentSize().width - GameDisplay.width, 0)
		self._minPosX = 0
		self.initPos = cc.p(GameDisplay.width, GameDisplay.height)
	end
end

function flyChessCamera:followPlayer()
	if not self.player then
		return
	end

	local var_9_0 = self.map:getContentSize().width
	local var_9_1 = self.map:getContentSize().height

	self:setPosition(self.initPos.x + math.max(self._minPosX, math.min((self.player:getPositionX() - (GameDisplay.width / 2 - self:getPositionX())) / var_9_0 * var_9_0, self._maxPosX)), self.initPos.y + math.max(self._minPosY, math.min((self.player:getPositionY() - (GameDisplay.height / 2 - self:getPositionY())) / var_9_1 * var_9_1, self._maxPosY)))
end

function flyChessCamera.setStartPosition(arg_10_0)
	return
end

function flyChessCamera.attachPlayer(arg_11_0, arg_11_1)
	arg_11_0.player = arg_11_1
end

function flyChessCamera.attachPlayer(arg_12_0, arg_12_1)
	arg_12_0.player = arg_12_1
end

function flyChessCamera:update(arg_13_1)
	if self:updateActions(arg_13_1) then
		self.isrunning = true

		return
	end

	self.isrunning = false
end

function flyChessCamera:updateActions(arg_14_1)
	if self.following then
		self:updateFollowing(arg_14_1)

		return
	end
end

function flyChessCamera.moveTo(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0.moving = true
end
