-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/model/RewardData.lua

module("logic.extensions.dungeon.model.RewardData", package.seeall)

local M = class("RewardData")

function M:ctor(data)
	self.code = data.code or 0
	self.count = data.count
	self.name = data.name or ""
	self.rewardStatus = data.rewardStatus or CommEnum.RewardEnum.CanNotGot
	self.itemSign = data.itemSign or CommEnum.BackPackItemSignTyp.None
	self.signTyp = data.signTyp or CommEnum.BackPackItemSignTyp.Get
	self.clickCallBack = data.clickCallBack or nil
	self.clickCallBackObj = data.clickCallBackObj or nil
end

function M:setCode(code)
	self.code = code
end

function M:setCount(count)
	self.count = count
end

function M:setName(name)
	self.name = name
end

function M:setRewardStatus(rewardStatus)
	self.rewardStatus = rewardStatus
end

function M:setItemSign(itemSign)
	self.itemSign = itemSign
end

function M:setSignTyp(signTyp)
	self.signTyp = signTyp
end

function M:setClickCallBack(clickCallBack)
	self.clickCallBack = clickCallBack
end

function M:setClickCallBackObj(clickCallBackObj)
	self.clickCallBackObj = clickCallBackObj
end

function M:getCode()
	return self.code
end

function M:getCount()
	return self.count
end

function M:getName()
	return self.name
end

function M:getRewardStatus()
	return self.rewardStatus
end

function M:getItemSign()
	return self.itemSign
end

function M:getSignType()
	return self.signTyp
end

function M:getClickCallBack()
	return self.clickCallBack
end

function M:getClickCallBackObj()
	return self.clickCallBackObj
end

return M
