local var_0_0 = g.core.model.User.petHandBookData
local var_0_1 = g.core.const.ConstMgr.PetHandBookConst
local var_0_3 = g.core.common.Path
local PetHandBookMainCell = class("PetHandBookMainCell", require("app.fairyGUI.petHandBook.UI_PetHandBookMainCell"))

function PetHandBookMainCell:ctor()
	self._advId = 0
	self._cellState = 0
	self._id = nil
	self._pet = nil

	self:addClickListener(handler(self, self._onTouchClick))
	self.getSharedTrans(self, "enter_left", "CommonCardCellList", self)
end

function PetHandBookMainCell:updateCell(arg_2_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			advId = arg_2_1.advId
		}
	})

	self._pet = arg_2_1.petStruct
	self._id = arg_2_1.handBookId

	local var_2_0 = self._pet:getCfg()

	self._advId = var_2_0.advance_id
	self._cellState = var_0_0:getPetStateByAdvId(self._advId)

	self:setData({
		level = arg_2_1.level,
		name = var_2_0.name,
		quality = var_2_0.quality,
		resId = var_2_0.resource
	})
end

function PetHandBookMainCell:setData(arg_3_1)
	self.m_nameTxt:setText(arg_3_1.name)
	self.m_levelTxt:setText(arg_3_1.level)
	self.m_qualityIcon:setURL(var_0_3:getPetHandbookQualityFrame(arg_3_1.quality))
	self.m_qualityBg:setURL(var_0_3:getPetHandbookQualityBg(arg_3_1.quality))

	if self.m_upEffHolder then
		self.m_upEffHolder:removeAllEffect()
	end

	if self.m_downEffHolder then
		self.m_downEffHolder:removeAllEffect()
	end

	self.m_petLoader:setURL((g.core.common.Path:getPetPictorialBook(arg_3_1.resId)))

	local var_3_0 = var_0_0:getPetStateByAdvId(self._advId)

	if var_3_0 == var_0_1.CELL_STATE.CAN_ACTIVATE then
		self.m_petLoader:setGloaderColor(true, cc.vec3(0.64, 0.64, 0.64))
		self:playCanUpgradeEff()
	elseif var_3_0 == var_0_1.CELL_STATE.CAN_NOT_ACTIVATE then
		self.m_petLoader:setGloaderColor(true, cc.vec3(0.64, 0.64, 0.64))
	elseif var_3_0 == var_0_1.CELL_STATE.CAN_STAR_UP then
		self.m_petLoader:setGloaderColor(false, cc.vec3(0, 0, 0))
		self:playCanUpgradeEff()
	elseif var_3_0 == var_0_1.CELL_STATE.ACTIVATED_NORMAL then
		self.m_petLoader:setGloaderColor(false, cc.vec3(0, 0, 0))
	end
end

function PetHandBookMainCell:playCanUpgradeEff()
	local var_4_0 = "eff_ui_petHandBook_point_" .. self._pet:getCfg().quality + 1

	self.m_upEffHolder:addEffectSpine({
		isLoop = true,
		anim = "playUp",
		name = var_4_0,
		eventHandler = handler(self, self.onSpineHandler)
	})
	self.m_downEffHolder:addEffectSpine({
		isLoop = true,
		anim = "playDown",
		name = var_4_0,
		eventHandler = handler(self, self.onSpineHandler)
	})
end

function PetHandBookMainCell:playUpgradeEff()
	self.m_activateEffHolder:addEffectSpine({
		name = "eff_ui_handbook_upgrade",
		isLoop = false,
		eventHandler = handler(self, self.onSpineHandler)
	})
end

function PetHandBookMainCell:onSpineHandler(arg_6_1)
	if arg_6_1.type == "complete" then
		if self._animEndCall then
			self._animEndCall()
		end

		self._animEndCall = nil
	end
end

function PetHandBookMainCell:_onTouchClick()
	self._cellState = var_0_0:getPetStateByAdvId(self._advId)

	if self._cellState == var_0_1.CELL_STATE.CAN_NOT_ACTIVATE then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.petHandbook.view.PetHandBookPreviewPop").new({
			state = self._cellState,
			advId = self._advId
		}), {
			touchDisappear = true
		})

		return
	end

	if self._cellState == var_0_1.CELL_STATE.ACTIVATED_NORMAL then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.petHandbook.view.PetHandBookPreviewPop").new({
			state = self._cellState,
			advId = self._advId
		}), {
			touchDisappear = true
		})

		return
	end

	if self._cellState == var_0_1.CELL_STATE.CAN_ACTIVATE then
		g.core.network.GameNetProxy:send_C2S_Pet_HandbookActivate({
			id = self._advId
		})
	else
		g.core.network.GameNetProxy:send_C2S_Pet_HandbookUpgrade({
			id = self._id
		})
	end
end

return PetHandBookMainCell
