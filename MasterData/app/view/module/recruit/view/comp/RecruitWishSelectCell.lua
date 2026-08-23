local RecruitWishSelectCell = class("RecruitWishSelectCell", require("app.fairyGUI.recruit.UI_RecruitWishSelectCell"))
local PressComp = require("app.view.module.recruit.view.comp.PressComp")

function RecruitWishSelectCell:ctor()
	self._idx = -1
	self._info = nil

	PressComp.bindComp(self)
	self:setClickListener(handler(self, self._onCellItemClicked))
	self:addPressListener((handler(self, self._showDetailInfo)))
	self:setPressContinueTypeEnable(false)
end

function RecruitWishSelectCell:_additionalTouchBegin(arg_2_1, arg_2_2)
	self._beginPos = arg_2_1
end

function RecruitWishSelectCell:_showDetailInfo()
	g.core.common.GlobalFunc.pushInfoPop({
		type = self._info:getType(),
		value = self._info:getId()
	})
end

function RecruitWishSelectCell:_onCellItemClicked(arg_4_1)
	if cc.pDistanceSQ(self._beginPos, (arg_4_1:getInput():getPosition())) > 2500 then
		return
	end

	local var_4_0 = not self._info:getPos()

	if var_4_0 and not self:_checkClicked() then
		if self._info:isFullDevelop() then
			if g.core.common.Goods.TYPE_ARTIFACT == self._info:getType() then
				g.core.module.ModuleManager:tip(g.core.lang:get(108425))
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(108415))
			end
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(108043))
		end
	else
		if var_4_0 then
			self:dispatchCompEvent("updateWishInfo", {
				info = self._info
			})
		else
			self:dispatchCompEvent("updateWishInfo", {
				pos = self._info:getPos()
			})
		end

		self:updateItem(self._info, self._idx)
	end
end

function RecruitWishSelectCell:_checkClicked()
	if not self._info or self._info:isFullDevelop() then
		return false
	end

	for iter_5_0, iter_5_1 in ipairs(self._info:getPlaceHolders() or {}) do
		if iter_5_1 == false or type(iter_5_1) == "table" and not self._info:isCompleted() then
			return true
		end
	end

	return false
end

function RecruitWishSelectCell:updateItem(arg_6_1, arg_6_2)
	self._info = arg_6_1
	self._idx = arg_6_2

	self.m_item:updateIcon({
		size = -1,
		type = arg_6_1:getType(),
		value = arg_6_1:getId(),
		struct = arg_6_1:getStruct()
	})

	if g.core.common.Goods.TYPE_ARTIFACT == self._info:getType() then
		self.m_knightIcon:updateComp(self._info:getStruct():getBelongToKnightAvdIdIncludingMainRole(), arg_6_1:getQuality())
		self.m_knightIcon:setVisible(true)
		self.m_redPointComp:setId(306)
	else
		self.m_knightIcon:setVisible(false)
		self.m_redPointComp:setId(0)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			id = arg_6_1:getId()
		}
	})

	if arg_6_1:isMaxStar() then
		self.m_tipStatueController:setSelectedIndex(3)
	elseif arg_6_1:isLimitMember() then
		self.m_tipStatueController:setSelectedIndex(1)
	elseif arg_6_1:getUpValue() > 0 then
		self.m_tipStatueController:setSelectedIndex(2)
		self.m_tipText:setText("UP")
	else
		self.m_tipStatueController:setSelectedIndex(0)
	end

	if arg_6_1:getPos() then
		if arg_6_1:isCompleted() then
			self.m_stateController:setSelectedIndex(3)
		else
			self.m_stateController:setSelectedIndex(2)
		end
	elseif not arg_6_1:isOwn() then
		self.m_stateController:setSelectedIndex(1)
		self.m_starBg:setURL(g.core.common.Path:getUserIconQualityStarBg(arg_6_1:getQuality()))
	else
		self.m_stateController:setSelectedIndex(0)
	end

	if arg_6_1:getQuality() == 4 then
		self.m_colorController:setSelectedIndex(1)
	else
		self.m_colorController:setSelectedIndex(0)
	end
end

return RecruitWishSelectCell
