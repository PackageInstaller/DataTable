-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assistancebox/model/AssistanceBoxModel.lua

module("logic.extensions.assistancebox.model.AssistanceBoxModel", package.seeall)

local AssistanceBoxModel = class("AssistanceBoxModel", BaseModel)

function AssistanceBoxModel:ctor()
	AssistanceBoxModel.super.ctor(self)
end

function AssistanceBoxModel:onInit()
	self:onReset()
end

function AssistanceBoxModel:onReset()
	self.todayGainPrizeCount = 0
	self.myInfo = nil
	self.otherInfo = nil
	self.records = nil
	self.isCanPop = false
	self.sendInviteTime = 0
end

function AssistanceBoxModel:onGetInfo(msg)
	self.todayGainPrizeCount = msg.todayGainPrizeCount
	self.myInfo = GameUtil.pbToTable(msg.info)
end

function AssistanceBoxModel:onGetMyRecord(msg)
	self.records = GameUtil.pbToTable(msg.records)
end

function AssistanceBoxModel:onGetOtherBoxInfo(msg)
	self.otherInfo = GameUtil.pbToTable(msg.info)
end

function AssistanceBoxModel:onBoxHelp(msg)
	self.todayGainPrizeCount = msg.todayGainPrizeCount
end

function AssistanceBoxModel:getCurBoxEndTime()
	if RedPointModel.instance:isActive(RedPointModel.ID_HOLY_STRIPE_ASSISTANCE_BOX) then
		local info = RedPointModel.instance:getRedPoingInfo(RedPointModel.ID_HOLY_STRIPE_ASSISTANCE_BOX)

		return math.floor(info.endTime / 1000)
	else
		return 0
	end
end

function AssistanceBoxModel:popView()
	self.isCanPop = false
end

function AssistanceBoxModel:resetView()
	self.isCanPop = true
end

function AssistanceBoxModel:hasBox()
	if self.myInfo then
		return true
	else
		return false
	end
end

function AssistanceBoxModel:getSendTime()
	return self.sendInviteTime
end

function AssistanceBoxModel:setSendTime()
	self.sendInviteTime = ServerTime.now()
end

AssistanceBoxModel.instance = AssistanceBoxModel.New()

return AssistanceBoxModel
