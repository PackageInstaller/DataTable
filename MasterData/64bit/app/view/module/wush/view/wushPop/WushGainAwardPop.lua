local WushGainAwardPop = class("WushGainAwardPop", require("app.fairyGUI.wush.UI_WushGainAwardPop"), function()
	return fgui.GComponent:create({
		pkgName = "wush",
		pkgPath = "ui/wush/wush",
		resName = "WushGainAwardPop"
	})
end)
local var_0_1 = g.core.config.dead_battle_floor_info

function WushGainAwardPop:ctor(arg_2_1)
	if arg_2_1 then
		self._floorId = arg_2_1.floorId or 1
	end

	self._dropId = 1

	self:getView():center(true)
	self.m_receiveBtn:addClickListener(handler(self, self._onClickReceive))
	self.m_basePanelComp:setTitle((var_0_1.get(self._floorId).type == 2 or nil) and (g.core.lang:get(303032) or g.core.lang:get(303031)))
	self.m_basePanelComp:setCtrlState("close", {
		index = 1
	})
end

function WushGainAwardPop:onLoad()
	local var_3_0 = g.core.model.User.wushData:getCurFloorStar()

	self.m_desTxt:setText(g.core.lang:get(303019, {
		star = var_3_0
	}))

	self._dropId = var_0_1.get(self._floorId)["award_id_" .. (math.floor(var_3_0 / 3) >= 1 and math.floor(var_3_0 / 3) or 1)]

	self:_updateList()
end

function WushGainAwardPop:_updateList()
	local var_4_0 = g.core.common.Drops:getGoodsArray(self._dropId)

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(function(arg_5_0, arg_5_1)
		arg_5_1:setCtrlState("name", {
			index = 2
		})
		arg_5_1:updateIcon({
			type = var_4_0[arg_5_0 + 1].type,
			value = var_4_0[arg_5_0 + 1].value,
			size = var_4_0[arg_5_0 + 1].size
		})
	end)
	self.m_awardList:setNumItems(table.nums(var_4_0))
end

function WushGainAwardPop:_onClickReceive()
	g.core.network.GameNetProxy:send_C2S_DeadBattle_BoxAward({})
	g.core.module.ModuleManager:popComponent()
end

return WushGainAwardPop
