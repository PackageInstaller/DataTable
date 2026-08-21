-- chunkname: @IQIGame\\UI\\LoopMapUI\\LoopMapBaseCell.lua

LoopMapBaseCell = classF()

local LoopMapCellViewClass = require("IQIGame.UI.LoopMapUI.LoopMapCellView")

function LoopMapBaseCell:ctor(param)
	self.gameObject = param.gameObject
	self.row = param.row
	self.column = param.column
	self.gameObject.name = self.row .. "_" .. self.column
	self.objInstanceID = self.gameObject:GetInstanceID()
	self.isAddInList = false
	self.isPowerOn = false
	self.connectList = {}
	self.view = LoopMapCellViewClass.New(self.gameObject)

	LuaUtility.SetGameObjectShow(self.view.normalCell, false)
	LuaUtility.SetGameObjectShow(self.view.convertCell, false)
end

function LoopMapBaseCell:GetType()
	return self.type
end

function LoopMapBaseCell:OnDragging()
	return
end

function LoopMapBaseCell:OnProcessing()
	self.isPowerOn = true

	return true
end

function LoopMapBaseCell:AddOrSetConnect(lineIndex, input, output)
	if not self.connectList[lineIndex] then
		self.connectList[lineIndex] = {}
		self.connectList[lineIndex].input = Constant.LoopMapDirection.Null
		self.connectList[lineIndex].output = Constant.LoopMapDirection.Null
	end

	self.connectList[lineIndex].lineIndex = lineIndex

	if input then
		self.connectList[lineIndex].input = input
	end

	if output then
		self.connectList[lineIndex].output = output
	end
end

function LoopMapBaseCell:IsNeedAddInLineList()
	return not self.isAddInList
end

function LoopMapBaseCell:SetIsAddInList(value)
	self.isAddInList = value
end

function LoopMapBaseCell:GetInstanceID()
	return self.objInstanceID
end

function LoopMapBaseCell:GetIsPowerOn()
	return self.isPowerOn
end

function LoopMapBaseCell:RevertState()
	self:SetIsAddInList(false)

	self.connectList = {}
	self.isPowerOn = false
end

function LoopMapBaseCell:OnDestroy()
	self.view:OnDestroy()
	GameObject.Destroy(self.gameObject)

	self.view = nil
	self.gameObject = nil
	self.connectList = {}
end
