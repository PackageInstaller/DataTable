-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bargain/config/BargainConfig.lua

module("logic.extensions.bargain.config.BargainConfig", package.seeall)

local BargainConfig = class("BargainConfig", BaseConfig)

function BargainConfig:onInit()
	BargainConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function BargainConfig:getNames()
	return {
		"friend_bargain",
		"friend_bargain_goods",
		"friend_bargain_reduce"
	}
end

function BargainConfig:handleConfig(name, content)
	if name == "friend_bargain" then
		self.friend_bargain = content
	elseif name == "friend_bargain_goods" then
		self._friend_bargain_goods = content
	elseif name == "friend_bargain_reduce" then
		self._friend_bargain_reduce = content
	end
end

function BargainConfig:getCfgById(id)
	return self.friend_bargain[id]
end

function BargainConfig:getGoodsInfo(actId, goodsId)
	local actCfg = self:getCfgById(actId)
	local cfg = self._friend_bargain_goods[actCfg.goodsPlanId]

	if cfg then
		if goodsId then
			return cfg[goodsId]
		end

		return cfg
	end

	return nil
end

function BargainConfig:getReduceCfg(actId, reduceType)
	local actCfg = self:getCfgById(actId)
	local cfg = self._friend_bargain_reduce[actCfg.reducePlanId]

	if cfg then
		return cfg[reduceType]
	end
end

BargainConfig.instance = BargainConfig.New()

return BargainConfig
