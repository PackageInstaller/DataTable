local var_0_0 = g.core.model.User.hlTrainData
local HLTrainConst = require("app.view.module.homeLandTrain.const.HLTrainConst")
local HLTrainMainPart = class("HLTrainMainPart", require("app.fairyGUI.homeLandTrain.UI_HLTrainMainPart"))

function HLTrainMainPart:ctor()
	self._roomCellDict = nil

	self:_initDefaultData()

	if HLTrainConst.NEED_BLOCK then
		self:_addBg(HLTrainConst.BG_BLOCK)
	else
		self:_addBg("bg/homeland/bg_xljd.jpg")
	end
end

function HLTrainMainPart:_initDefaultData()
	self._roomCellDict = {}

	for iter_2_0, iter_2_1 in ipairs((var_0_0:getAllRoomAdvIds())) do
		self._roomCellDict[iter_2_1] = self["m_roomCell" .. iter_2_0]
	end
end

function HLTrainMainPart:_addBg(arg_3_1)
	local var_3_0 = fgui.GLoader:create()

	var_3_0:setURL(arg_3_1)
	var_3_0:setAutoSize(true)
	self:addChildAt(var_3_0, 0)
	var_3_0:setPivot(0.5, 0.5, true)
	var_3_0:setPosition(display.width / 2, display.height / 2)

	return var_3_0
end

function HLTrainMainPart:refreshAllRoomCell(arg_4_1)
	for iter_4_0, iter_4_1 in pairs(self._roomCellDict) do
		iter_4_1:refreshCell(iter_4_0)
	end

	if arg_4_1 then
		self._roomCellDict[arg_4_1.adv_id]:checkUpgradeEff()
	end
end

function HLTrainMainPart:onRefreshRoomCell(arg_5_1)
	self._roomCellDict[arg_5_1]:onRefreshRoomRole(arg_5_1)
end

function HLTrainMainPart:onOpenTrainRoom(arg_6_1)
	self:setChildIndex(self._roomCellDict[arg_6_1], 100)
end

return HLTrainMainPart
