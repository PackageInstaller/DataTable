local var_0_0 = g.core.model.User.explorationData
local var_0_1 = g.core.common.Goods
local ExplorationFormationRecycleCell = class("ExplorationFormationRecycleCell", require("app.fairyGUI.exploration.UI_ExplorationFormationRecycleCell"))

function ExplorationFormationRecycleCell:ctor()
	self._struct = nil
	self._cfg = nil
	self._type = 0
	self._formationData = var_0_0:getFormationData()
end

function ExplorationFormationRecycleCell:updateCell(arg_2_1, arg_2_2)
	self._struct = arg_2_1
	self._type = arg_2_2
	self._cfg = self._formationData:getEmbryoCfg(arg_2_2, self._struct:getQuality(), (self:getStarNum(arg_2_1, arg_2_2)))

	self.m_nameTxt:setText(self._struct:getName())
	self.m_valueComp:updateByTVS({
		type = var_0_1.TYPE_RESOURCE,
		value = var_0_1.RESOURCE.TYPE_EXPLORATION_COMMON_RESOURCE,
		size = self._cfg.sell_price
	})
	self.m_iconComp:updateIcon({
		overrideClick = true,
		type = var_0_1.TYPE_KNIGHT,
		struct = arg_2_1
	})
	self.m_iconComp:getIconComp():setAdvanceLevel(0)
	self.m_iconComp:setTouchFunc(handler(self, self._onClickIcon))
end

function ExplorationFormationRecycleCell:getStarNum(arg_3_1, arg_3_2)
	if arg_3_2 == var_0_1.TYPE_KNIGHT then
		return arg_3_1:getStarLv()
	elseif arg_3_2 == var_0_1.TYPE_ARTIFACT then
		return arg_3_1:getStar()
	elseif arg_3_2 == var_0_1.TYPE_UNITETOKEN then
		return arg_3_1:getStarLevel()
	elseif arg_3_2 == var_0_1.TYPE_PET then
		return arg_3_1:getStarNum()
	end

	return 0
end

function ExplorationFormationRecycleCell:_onClickIcon()
	if self._type == var_0_1.TYPE_KNIGHT then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
			knightStruct = self._struct
		}), {
			hideContinue = true,
			touchDisappear = true
		})
	end
end

return ExplorationFormationRecycleCell
