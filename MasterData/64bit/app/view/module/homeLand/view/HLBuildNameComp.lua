local var_0_0 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_1 = g.core.const.ConstMgr.RedPointConst
local var_0_2 = {
	[g.core.const.ConstMgr.FUNCTION_TYPE.HOME_LAND_TRAIN] = 161,
	[g.core.const.ConstMgr.FUNCTION_TYPE.HOME_LAND_FAVO_MAIN] = 58,
	[g.core.const.ConstMgr.FUNCTION_TYPE.HOME_LAND_FURNITURE] = 90,
	[g.core.const.ConstMgr.FUNCTION_TYPE.HOME_LAND_TMP2] = 16,
	[g.core.const.ConstMgr.FUNCTION_TYPE.HOME_LAND_SHOWROOM] = 147,
	[g.core.const.ConstMgr.FUNCTION_TYPE.GENE] = 5000001
}
local var_0_3 = g.core.model.User
local HLBuildNameComp = class("HLBuildNameComp", require("app.fairyGUI.homeLand.UI_HLBuildNameComp"), function()
	return fgui.GComponent:create({
		pkgName = "homeLand",
		resName = "HLBuildNameComp",
		pkgPath = "ui/homeLand/homeLand"
	})
end)

function HLBuildNameComp:ctor(arg_2_1)
	self:initBuildName(arg_2_1)
end

function HLBuildNameComp:initBuildName(arg_3_1)
	self._info = arg_3_1

	if not arg_3_1 then
		return
	end

	local var_3_0 = arg_3_1.function_id

	self.m_iconLoader:setURL("ui://homeLand/" .. arg_3_1.function_id)
	self.m_nameTxt:setText(arg_3_1.name)
	self.m_subNameTxt:setText(arg_3_1.title)

	if var_3_0 and var_0_2[var_3_0] then
		self.m_redPointComp:setId(var_0_2[var_3_0])
	end

	if var_3_0 == var_0_0.HOME_LAND_FURNITURE then
		self.m_hlBuildRedPointComp_1:initRedPoint({
			bgStyle = var_0_1.BuildRedPointBgStyle.BLUE,
			iconStyle = var_0_1.BuildRedPointIconStyle.BATH,
			func = handler(var_0_3.furnitureData, var_0_3.furnitureData.getNumRecommendCheckIn)
		})
	elseif var_3_0 == var_0_0.HOME_LAND_TRAIN then
		self.m_hlBuildRedPointComp_1:initRedPoint({
			bgStyle = var_0_1.BuildRedPointBgStyle.GREEN,
			iconStyle = var_0_1.BuildRedPointIconStyle.RECEIVE,
			func = handler(var_0_3.hlTrainData, var_0_3.hlTrainData.getRoomNumProduct40Percent)
		})
		self.m_hlBuildRedPointComp_2:initRedPoint({
			bgStyle = var_0_1.BuildRedPointBgStyle.RED,
			iconStyle = var_0_1.BuildRedPointIconStyle.EXCLAMATION_MARK,
			func = handler(var_0_3.hlTrainData, var_0_3.hlTrainData.getCanWorkRoomNum)
		})
	end

	self:refreshRed()
end

function HLBuildNameComp:getFuncId()
	return self._info.function_id
end

function HLBuildNameComp:refreshRed()
	self.m_redPointComp:refresh({}, true)
	self.m_hlBuildRedPointComp_1:refresh()
	self.m_hlBuildRedPointComp_2:refresh()
end

function HLBuildNameComp:getRedPointStyle()
	return (self.m_redPointComp:getRedPointStyle())
end

return HLBuildNameComp
