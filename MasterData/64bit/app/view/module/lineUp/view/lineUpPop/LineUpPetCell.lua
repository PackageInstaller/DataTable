local var_0_0 = g.core.const.ConstMgr.PetConst
local var_0_1 = g.core.common.Path
local LineUpPetCell = class("LineUpPetCell", require("app.fairyGUI.lineUp.UI_LineUpPetCell"))

function LineUpPetCell:ctor()
	self._petStruct = nil

	self.getSharedTrans(self, "listCrosbandBUiRightIn_cell", "LineUpRightList", self)
	self.m_petIconLoader:addClickListener(handler(self, self._onClickPetIcon))
	self.m_starComp:initStar({
		num = 0,
		gap = 0,
		index = 3,
		style = 1,
		max = var_0_0.STAR_MAX
	})
end

function LineUpPetCell:_onClickPetIcon(arg_2_1)
	if self._petStruct then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.pet.view.infoPop.PetInfoPop").new({
			petStruct = self._petStruct
		}), {
			withoutAni = true
		})
	end

	arg_2_1:stopPropagation()
end

function LineUpPetCell:updateCell(arg_3_1)
	self._petStruct = arg_3_1

	local var_3_0 = arg_3_1:getCfg()

	self.m_qualityBgLoader:setURL((var_0_1:getBaseIconQualityBg(var_3_0.quality)))
	self.m_petIconLoader:setURL((var_0_1:getPetIcon(var_3_0.resource)))
	self.m_nameTxt:setText(var_3_0.name)
	self.m_levelTxt:setText(g.core.lang:get(200017, {
		level = arg_3_1:getLevel()
	}))

	local var_3_1 = arg_3_1:getBigSmallStage()

	if var_3_1 > 0 then
		self.m_stageTxt:setText("+" .. var_3_1)
	else
		self.m_stageTxt:setText("")
	end

	self.m_starComp:setStarNum(arg_3_1:getStarNum())

	if arg_3_1:isLineup() then
		self.m_lineupController:setSelectedIndex(1)
	else
		self.m_lineupController:setSelectedIndex(0)
	end
end

return LineUpPetCell
