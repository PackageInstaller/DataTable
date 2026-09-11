local TangramPuzzleBlackboard = class("TangramPuzzleBlackboard", ReduxView)

function TangramPuzzleBlackboard:Ctor()
	self:Reset()
end

function TangramPuzzleBlackboard:Reset()
	self.isAutoPutPuzzle_ = false
	self.isMovePuzzle_ = false
	self.moveOriginPuzzleIndex_ = -1
	self.moveTargetPuzzleIndex_ = -1
	self.isMoveImmediately_ = false
	self.isRotateRegion_ = false
	self.rotateRegionID_ = -1
	self.rotateTimes_ = 0
	self.newEditIndex_ = -1
	self.isReceivedRegionReward_ = false
	self.isOnlyRegionRewardPop_ = false
	self.receivedRegionList_ = {}
	self.rewardList_ = {}
	self.needCheckAllRightRegionType_ = false
	self.checkAllRightRegionTypeDic_ = {}
	self.allRightRegionTypeList_ = {}
	self.regionTypeAllRight_ = -1
	self.needSwitchToPlay_ = false
	self.needSwitchToEdit_ = false
	self.needSwitchToFinal_ = false
end

return TangramPuzzleBlackboard
