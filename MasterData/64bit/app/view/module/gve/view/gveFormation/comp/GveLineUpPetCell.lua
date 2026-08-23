local var_0_0 = g.core.common.Path
local var_0_1 = g.core.const.ConstMgr.PetConst
local var_0_2 = g.core.model.User.gveDataMgr
local GveLineUpPetCell = class("GveLineUpPetCell", require("app.fairyGUI.gve.UI_GveLineUpPetCell"))

function GveLineUpPetCell:ctor()
	self._formationData = var_0_2:getGveFormationData()
	self._petStruct = nil

	self.getSharedTrans(self, "enter_right", "CommonShortCellList", self)
	self.m_petIconLoader:addClickListener(handler(self, self._onClickPetIcon))
	self.m_starComp:initStar({
		num = 0,
		gap = 0,
		index = 3,
		style = 1,
		max = var_0_1.STAR_MAX
	})
end

function GveLineUpPetCell:_onClickPetIcon()
	if self._petStruct then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.pet.view.infoPop.PetInfoPop").new({
			petAdvId = self._petStruct:getAdvanceId()
		}), {
			hideContinue = true,
			touchDisappear = true
		})
	end
end

function GveLineUpPetCell:_updateViewByStruct(arg_3_1)
	local var_3_0 = arg_3_1:getCfg()

	self.m_qualityBgLoader:setURL(var_0_0:getBaseIconQualityBg(arg_3_1:getQuality()))
	self.m_petIconLoader:setURL((var_0_0:getPetIcon(var_3_0.resource)))
	self.m_nameText:setText(var_3_0.name)

	local var_3_1 = arg_3_1:getBigSmallStage()

	if var_3_1 > 0 then
		self.m_stageText:setText("+" .. var_3_1)
	else
		self.m_stageText:setText("")
	end

	self.m_starComp:setStarNum(arg_3_1:getStarNum())
end

function GveLineUpPetCell:updateCellByGvePop(arg_4_1)
	self._petStruct = arg_4_1.petData

	self:_updateViewByStruct(arg_4_1.petData)

	if self._formationData:checkPetIsLineUp(arg_4_1.petData:getSid()) then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

function GveLineUpPetCell:updateCell(arg_5_1, arg_5_2)
	self._petStruct = arg_5_1

	self:_updateViewByStruct(arg_5_1)

	if arg_5_2.formationStruct:isPetLineUp(arg_5_1:getSid()) then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

return GveLineUpPetCell
