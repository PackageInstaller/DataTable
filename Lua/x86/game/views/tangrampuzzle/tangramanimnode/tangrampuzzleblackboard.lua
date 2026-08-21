local var_0_0 = class("TangramPuzzleBlackboard", ReduxView)

function var_0_0.Ctor(arg_1_0)
	arg_1_0:Reset()
end

function var_0_0.Reset(arg_2_0)
	arg_2_0.isAutoPutPuzzle_ = false
	arg_2_0.isMovePuzzle_ = false
	arg_2_0.moveOriginPuzzleIndex_ = -1
	arg_2_0.moveTargetPuzzleIndex_ = -1
	arg_2_0.isMoveImmediately_ = false
	arg_2_0.isRotateRegion_ = false
	arg_2_0.rotateRegionID_ = -1
	arg_2_0.rotateTimes_ = 0
	arg_2_0.newEditIndex_ = -1
	arg_2_0.isReceivedRegionReward_ = false
	arg_2_0.isOnlyRegionRewardPop_ = false
	arg_2_0.receivedRegionList_ = {}
	arg_2_0.rewardList_ = {}
	arg_2_0.needCheckAllRightRegionType_ = false
	arg_2_0.checkAllRightRegionTypeDic_ = {}
	arg_2_0.allRightRegionTypeList_ = {}
	arg_2_0.regionTypeAllRight_ = -1
	arg_2_0.needSwitchToPlay_ = false
	arg_2_0.needSwitchToEdit_ = false
	arg_2_0.needSwitchToFinal_ = false
end

return var_0_0
