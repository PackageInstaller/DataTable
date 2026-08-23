local KnightTissueSubComp = class("KnightTissueSubComp", require("app.fairyGUI.knightTissue.UI_KnightTissueSubComp"))
local var_0_1 = g.core.model.User.knightsData
local var_0_2 = g.core.const.ConstMgr.KnightTissueConst
local var_0_3 = g.core.common.Path

function KnightTissueSubComp:ctor()
	self._knightId = 0

	self.m_iconTypeController:setSelectedIndex(var_0_2.TISSUE_CTRL_STATE.NOCFG)
	self:addClickListener(handler(self, self._onClickKnightTissCell))
end

function KnightTissueSubComp:updateKnightIcon(arg_2_1)
	self._knightId = arg_2_1
	self._knight = var_0_1:getKnight({
		advance_id = self._knightId
	})

	if self._knight then
		self.m_iconTypeController:setSelectedIndex(var_0_2.TISSUE_CTRL_STATE.NORMAL)

		local var_2_0 = self._knight:getBaseInfo()

		self.m_knightLoader:setURL(var_0_3:getKnightPicRes(self._knight:getResInfo().painted_id))
		self.m_qualityLoader:setURL(g.core.common.Path:getHandBookTitleQuality(var_2_0.quality))
		self.m_knightNameTxt:setText(var_2_0.name)

		if self._knight:isOwn() and self._knight:isPut() then
			self.m_knightLoader:setGloaderColor(false, cc.vec3(0.49, 0.49, 0.49))
		else
			self.m_knightLoader:setGloaderColor(true, cc.vec3(0.49, 0.49, 0.49))
			self.m_iconTypeController:setSelectedIndex(var_0_2.TISSUE_CTRL_STATE.NOCFG)
		end
	elseif self._knightId == 1 then
		self.m_unOpenLoader:setURL("pic/knightTissue/tissuePic/unOpen.png")
		self.m_iconTypeController:setSelectedIndex(var_0_2.TISSUE_CTRL_STATE.UNKNOW)
	end
end

function KnightTissueSubComp:_onClickKnightTissCell()
	if self.m_iconTypeController:getSelectedIndex() ~= 2 and self._knight then
		g.core.common.GlobalFunc.pushInfoPop({
			type = 4,
			value = self._knight:getBaseInfo().id
		})
	end
end

return KnightTissueSubComp
