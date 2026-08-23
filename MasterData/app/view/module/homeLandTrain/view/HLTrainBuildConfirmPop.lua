local var_0_0 = g.core.model.User
local HLTrainBuildConfirmPop = class("HLTrainBuildConfirmPop", require("app.fairyGUI.homeLandTrain.UI_HLTrainBuildConfirmPop"), function()
	return fgui.GComponent:create({
		resName = "HLTrainBuildConfirmPop",
		pkgPath = "ui/homeLandTrain/homeLandTrain",
		pkgName = "homeLandTrain"
	})
end)

function HLTrainBuildConfirmPop:ctor(arg_2_1)
	self:showAtCenter()

	self._curRoomAdvId = arg_2_1
	self._canBuilding = false

	self.m_cancelBtn:addClickListener(handler(self, self._onCancelBtnClick))
	self.m_confirmBtn:addClickListener(handler(self, self._onConfirmBtnClick))
	self:updateView()
end

function HLTrainBuildConfirmPop:onLoad()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
end

function HLTrainBuildConfirmPop:_onCancelBtnClick()
	g.core.module.ModuleManager:popComponent()
end

function HLTrainBuildConfirmPop:_onConfirmBtnClick()
	if self._canBuilding then
		g.core.network.GameNetProxy:send_C2S_HomeLandTrain_UpLevel({
			adv_id = self._curRoomAdvId
		})
		g.core.module.ModuleManager:popComponent()
	else
		local var_5_0 = var_0_0.hlTrainData:getRoomStruct(self._curRoomAdvId).refCfgBaseInfo

		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = var_5_0.unlock_consume_type,
			value = var_5_0.unlock_consume_value
		})
	end
end

function HLTrainBuildConfirmPop:updateView()
	local var_6_0 = var_0_0.hlTrainData:getRoomStruct(self._curRoomAdvId).refCfgBaseInfo

	self.m_resCostComp:updateByTVS({
		type = var_6_0.unlock_consume_type,
		value = var_6_0.unlock_consume_value,
		size = var_6_0.unlock_consume_size
	})
	self.m_nameTxt:setText((g.core.lang:get(111050, {
		name = var_6_0.name
	})))

	self._canBuilding = var_0_0.hlTrainData:isEnoughResToUnlockRoom(self._curRoomAdvId)
end

return HLTrainBuildConfirmPop
