local BasePetCardComp = class("BasePetCardComp", require("app.fairyGUI.base_new.UI_BasePetCardComp"))
local var_0_1 = g.core.module.ModuleManager
local var_0_3 = g.core.common.ModuleUnlock
local var_0_4 = g.core.const.ConstMgr
local var_0_5 = {
	canStarUp = 3,
	canCompose = 2,
	lineUp = 1,
	null = 0
}

function BasePetCardComp:ctor()
	self._cfg = nil
	self._petStruct = nil
	self._svrData = {}
	self._advId = nil

	self.getSharedTrans(self, "listCardAUiScaleIn", "CombineBagList", self)
	self:addClickListener(handler(self, self._onClick), 1)
end

function BasePetCardComp:updateCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._cfg = arg_2_1:getCfg()
	self._svrData = arg_2_1:getServerData()
	self._petStruct = arg_2_1
	self._advId = self._cfg.advance_id

	self.m_picComp:updatePic(arg_2_1)

	local var_2_0, var_2_1 = arg_2_1:getBigSmallStage()

	self.m_nameText:setText(self._cfg.name)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			advId = self._advId
		}
	})
	self.m_stateController:setSelectedIndex(var_0_5.null)

	if arg_2_1:isOwn() then
		self.m_starComp:initStar({
			index = 3,
			gap = 5,
			style = 2,
			num = arg_2_1:getStarNum()
		})
		self.m_levelText:setText("LV." .. arg_2_1:getLevel())
		self.m_isOwnController:setSelectedIndex(1)

		if arg_2_1:canStarUp() then
			self.m_stateController:setSelectedIndex(var_0_5.canStarUp)
		elseif arg_2_1:isLineup() then
			self.m_stateController:setSelectedIndex(var_0_5.lineUp)
		end

		if var_2_0 > 0 then
			self.m_hasAdvanceController:setSelectedIndex(1)
			self.m_advLevelText:setText("+" .. var_2_0)
		else
			self.m_hasAdvanceController:setSelectedIndex(0)
		end
	else
		self.m_isOwnController:setSelectedIndex(0)

		local var_2_2, var_2_3, var_2_4 = arg_2_1:isComposeEnable()

		self._canCompose = var_2_2

		if var_2_2 then
			self.m_stateController:setSelectedIndex(var_0_5.canCompose)
			self.m_fragNumText:setText(g.core.lang:get(201018, {
				num = var_2_3,
				maxNum = var_2_4
			}))
		else
			self.m_fragNumText:setText(g.core.lang:get(201017, {
				num = var_2_3,
				maxNum = var_2_4
			}))
		end
	end
end

function BasePetCardComp:setReborn()
	self.m_redPointComp:setVisible(false)
	self.m_stateController:setSelectedIndex(var_0_5.null)
end

function BasePetCardComp:_onClick()
	if not self._petStruct then
		return
	end

	local var_4_0 = self.m_stateController:getSelectedIndex()

	if var_4_0 == var_0_5.canCompose then
		g.core.network.GameNetProxy:send_C2S_Fragment_Compose({
			num = 1,
			id = self._cfg.fragment_id
		})
	elseif var_4_0 == var_0_5.canStarUp and var_0_3:isModuleUnlock(var_0_4.FUNCTION_TYPE.PET_STAR_UP) then
		var_0_1:pushModule(g.view.entrance.PET_DEVELOP, {
			devType = 2,
			petSid = self._petStruct:getSid()
		})
	elseif self._petStruct:isOwn() then
		var_0_1:pushModule(g.view.entrance.PET_DEVELOP, {
			devType = 1,
			petSid = self._petStruct:getSid()
		})
	else
		local var_4_1 = require("app.view.module.pet.view.infoPop.PetInfoPop").new

		var_0_1:pushPopup((require("app.view.module.pet.view.infoPop.PetInfoPop").new({
			petStruct = self._petStruct
		})))
	end
end

return BasePetCardComp
