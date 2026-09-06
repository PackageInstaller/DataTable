-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccaccioclg/model/BoccaccioclgModel.lua

module("logic.extensions.boccaccioclg.view.BoccaccioclgModel", package.seeall)

local BoccaccioclgModel = class("BoccaccioclgModel", BaseModel)

function BoccaccioclgModel:ctor()
	return
end

function BoccaccioclgModel:onInit()
	self:onReset()
end

function BoccaccioclgModel:onReset()
	self._msgInfos = {}
	self._fmtMo = BoccaccioclgFmtMo.New()
end

function BoccaccioclgModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
	self._msgInfos[msg.activityId].stageList = self._msgInfos[msg.activityId].stageList or {}
end

function BoccaccioclgModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function BoccaccioclgModel:getFmtMo()
	return self._fmtMo
end

function BoccaccioclgModel:getStageInfo(activityId, stageId)
	local info = self:getInfo(activityId)

	if info then
		for i, v in ipairs(info.stageList) do
			if v.stageId == stageId then
				return v
			end
		end
	end

	return nil
end

function BoccaccioclgModel:onNotifyFightRes(msg)
	if msg.isWin then
		local activityId = msg.activityId
		local info = self:getInfo(activityId)
		local isHit = false

		for i, v in ipairs(info.stageList) do
			if v.stageId == msg.stageId then
				local oldScore = 0

				for i, v in ipairs(v.valueList) do
					oldScore = oldScore + BoccaccioclgController.instance:value2Score(activityId, v.buffType, v.value)
				end

				local newScore = 0

				for i, v in ipairs(msg.curValueList) do
					newScore = newScore + BoccaccioclgController.instance:value2Score(activityId, v.buffType, v.value)
				end

				if oldScore < newScore then
					v.valueList = GameUtil.pbToTable(msg.curValueList)
				end

				isHit = true

				break
			end
		end

		if not isHit then
			table.insert(info.stageList, {
				stageId = msg.stageId,
				valueList = GameUtil.pbToTable(msg.curValueList)
			})
		end
	end
end

BoccaccioclgModel.instance = BoccaccioclgModel.New()

return BoccaccioclgModel
