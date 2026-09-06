-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assignment/model/AssignmentDetailsModel.lua

module("logic.extensions.assignmentDetails.model.AssignmentDetailsModel", package.seeall)

local AssignmentDetailsModel = class("AssignmentDetailsModel", BaseListModel)

function AssignmentDetailsModel:ctor()
	AssignmentDetailsModel.super.ctor(self)
end

function AssignmentDetailsModel:onInit()
	AssignmentDetailsModel.super.onInit(self)
end

function AssignmentDetailsModel:onReset()
	AssignmentDetailsModel.super.onReset(self)

	self._condition = nil
	self._ranks = nil
	self._assignmentDetail = nil
end

function AssignmentDetailsModel:setConditionNum(num, index)
	self._condition[index].num = num
end

function AssignmentDetailsModel:getCondition(i)
	if i == nil then
		return self._condition
	end

	return self._condition[i]
end

function AssignmentDetailsModel:getConditionCount()
	return #self._condition
end

function AssignmentDetailsModel:initRanks(member)
	for _, v in ipairs(member) do
		table.insert(self._ranks, goutil.findChildComponent(v, "", "RectTransform").anchoredPosition)
	end
end

function AssignmentDetailsModel:addRanksMember(pet, quick)
	self._ranks.num = self._ranks.num + 1

	for i = 1, self._ranks.memberMaxNum do
		if self._ranks.pets[i] == nil then
			self._ranks.pets[i] = pet
			self._ranks.quick = quick

			return i
		end
	end

	return nil
end

function AssignmentDetailsModel:removeRanksMember(petId)
	for i = 1, self._ranks.memberMaxNum do
		if self._ranks.pets[i] ~= nil and self._ranks.pets[i].petId == petId then
			self._ranks.pets[i] = nil
			self._ranks.num = self._ranks.num - 1
			self._ranks.quick = nil

			return i
		end
	end

	return -1
end

function AssignmentDetailsModel:getRanks(index)
	if index == nil then
		return self._ranks
	else
		return self._ranks.pets[index]
	end
end

function AssignmentDetailsModel:getRankNum()
	return self._ranks.num
end

function AssignmentDetailsModel:getRankMaxNum()
	return self._ranks.memberMaxNum
end

function AssignmentDetailsModel:isRankFull()
	return self._ranks.num >= self._ranks.memberMaxNum
end

function AssignmentDetailsModel:isQuick()
	return self._ranks.quick
end

function AssignmentDetailsModel:setAssignment(content, num, pets)
	self._condition = AssignmentDetailsController.instance:analysisCondition(content.detectorParam)
	self._assignmentDetail = content
	self._ranks = {
		num = num or 0,
		memberMaxNum = tonumber(content.petNum),
		pets = pets or {}
	}
end

function AssignmentDetailsModel:getAssignment()
	return self._assignmentDetail
end

function AssignmentDetailsModel:setUsablePetNum(num)
	self._usablePetNum = num
end

function AssignmentDetailsModel:getUsablePetNum()
	if self._usablePetNum then
		return self._usablePetNum
	end

	return 999
end

AssignmentDetailsModel.instance = AssignmentDetailsModel.New()

return AssignmentDetailsModel
