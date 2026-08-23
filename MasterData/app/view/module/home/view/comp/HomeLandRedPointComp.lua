local var_0_0 = g.core.const.ConstMgr.RedPointConst
local var_0_1 = g.core.model.User
local HomeLandRedPointComp = class("HomeLandRedPointComp", require("app.fairyGUI.home.UI_HomeLandRedPointComp"))

function HomeLandRedPointComp:initComp()
	self.m_hlBuildRedPointComp_1:initRedPoint({
		bgStyle = var_0_0.BuildRedPointBgStyle.BLUE,
		iconStyle = var_0_0.BuildRedPointIconStyle.BATH,
		func = handler(var_0_1.furnitureData, var_0_1.furnitureData.getNumRecommendCheckIn)
	})
	self.m_hlBuildRedPointComp_2:initRedPoint({
		bgStyle = var_0_0.BuildRedPointBgStyle.GREEN,
		iconStyle = var_0_0.BuildRedPointIconStyle.RECEIVE,
		func = handler(var_0_1.hlTrainData, var_0_1.hlTrainData.getRoomNumProduct40Percent)
	})
	self.m_hlBuildRedPointComp_3:initRedPoint({
		bgStyle = var_0_0.BuildRedPointBgStyle.RED,
		iconStyle = var_0_0.BuildRedPointIconStyle.EXCLAMATION_MARK,
		func = handler(var_0_1.hlTrainData, var_0_1.hlTrainData.getCanWorkRoomNum)
	})
end

function HomeLandRedPointComp:updateComp()
	self.m_hlBuildRedPointComp_1:refresh()
	self.m_hlBuildRedPointComp_2:refresh()
	self.m_hlBuildRedPointComp_3:refresh()
end

return HomeLandRedPointComp
