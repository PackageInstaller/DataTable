local WushAwardPreviewPop = class("WushAwardPreviewPop", require("app.fairyGUI.wush.UI_WushAwardPreviewPop"), function()
	return fgui.GComponent:create({
		resName = "WushAwardPreviewPop",
		pkgPath = "ui/wush/wush",
		pkgName = "wush"
	})
end)
local var_0_1 = g.core.config.dead_battle_floor_info

function WushAwardPreviewPop:ctor(arg_2_1)
	if arg_2_1 then
		self._floorId = arg_2_1.floorId or 1
	end

	self._floorInfo = nil

	self:getView():center(true)
	self.m_bgPanel:setTitle((var_0_1.get(self._floorId).type == 2 or nil) and (g.core.lang:get(303032) or g.core.lang:get(303031)))
end

function WushAwardPreviewPop:onLoad()
	self._floorInfo = var_0_1.get(self._floorId)

	self.m_starTxt:setText(g.core.model.User.wushData:getCurFloorStar())
	self:_updateList()
end

function WushAwardPreviewPop:_updateList()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._awardItemRenderer))
	self.m_awardList:setNumItems(3)
end

function WushAwardPreviewPop:_awardItemRenderer(arg_5_1, arg_5_2)
	arg_5_2:update({
		cellData = g.core.common.Drops:getGoodsArray(self._floorInfo["award_id_" .. arg_5_1 + 1]),
		index = arg_5_1 + 1
	})
end

return WushAwardPreviewPop
