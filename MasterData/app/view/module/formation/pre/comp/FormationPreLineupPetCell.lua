local var_0_0 = g.core.common.Path
local var_0_1 = g.core.const.ConstMgr.PetConst
local FormationPreLineupPetCell = class("FormationPreLineupPetCell", require("app.fairyGUI.formation.UI_FormationPreLineupPetCell"))

function FormationPreLineupPetCell:ctor()
	self._petStruct = nil

	self.getSharedTrans(self, "enter_right", "CommonShortCellList", self)
	self.m_petIconLoader:addClickListener(handler(self, self._onClickPetIcon))
	self.m_starComp:initStar({
		gap = 0,
		style = 1,
		index = 3,
		num = 0,
		max = var_0_1.STAR_MAX
	})
	self.m_knightIcon:setTouchable(false)
end

function FormationPreLineupPetCell:_onClickPetIcon()
	if self._petStruct then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.pet.view.infoPop.PetInfoPop").new({
			petAdvId = self._petStruct:getAdvanceId()
		}), {
			touchDisappear = true,
			hideContinue = true
		})
	end
end

function FormationPreLineupPetCell:updateCell(arg_3_1, arg_3_2)
	self._petStruct = arg_3_1

	local var_3_0 = arg_3_1:getCfg()

	self.m_qualityBgLoader:setURL(var_0_0:getBaseIconQualityBg(arg_3_1:getQuality()))
	self.m_petIconLoader:setURL((var_0_0:getPetIcon(var_3_0.resource)))
	self.m_nameText:setText(var_3_0.name)
	self.m_levelTxt:setText(g.core.lang:get(200017, {
		level = arg_3_1:getLevel()
	}))

	local var_3_1 = arg_3_1:getBigSmallStage()

	if var_3_1 > 0 then
		self.m_stageText:setText("+" .. var_3_1)
	else
		self.m_stageText:setText("")
	end

	self.m_starComp:setStarNum(arg_3_1:getStarNum())

	if arg_3_2.formationStruct:isPetLineUp(arg_3_1:getSid()) then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

return FormationPreLineupPetCell
