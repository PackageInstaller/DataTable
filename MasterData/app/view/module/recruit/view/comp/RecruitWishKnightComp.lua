local PressComp = require("app.view.module.recruit.view.comp.PressComp")
local var_0_1 = g.core.const.ConstMgr.SpineConst
local var_0_2 = g.core.common.Color
local var_0_3 = g.core.const.ConstMgr.QUALITY_TYPE
local RecruitWishKnightComp = class("RecruitWishKnightComp", require("app.fairyGUI.recruit.UI_RecruitWishKnightComp"))

function RecruitWishKnightComp:ctor()
	self._struct = nil
	self._pos = nil

	PressComp.bindComp(self)
	self:setClickListener(handler(self, self._onCellItemClicked))
end

function RecruitWishKnightComp:updateComp(arg_2_1, arg_2_2, arg_2_3)
	self._pos = arg_2_2

	if not arg_2_1 then
		self.m_wishStateController:setSelectedIndex(0)

		return
	end

	self._struct = arg_2_1

	if arg_2_1:isCompleted() then
		self.m_wishStateController:setSelectedIndex(2)
	else
		self.m_wishStateController:setSelectedIndex(1)
	end

	local var_2_1 = arg_2_1:getQuality()

	if var_2_1 >= var_0_3.UR then
		self.m_nameText:setColor(var_0_2.A1)
	else
		self.m_nameText:setColor(var_0_2.A6)
	end

	self.m_knightPic:setIcon(g.core.common.Path:getKnightPicRes(g.core.config.knight_base_info.get(g.core.config.knight_info.get((arg_2_1:getId())).res_id).painted_id))
	self.m_nameBgLoader:setURL((g.core.common.Path:getUserIconQualityStarBg(var_2_1)))
	self.m_nameText:setText(arg_2_1:getName())
	self.m_tipText:setColor(var_0_2.Recruit_Wish[var_2_1 + 1])
end

function RecruitWishKnightComp:_onCellItemClicked()
	if not self._struct then
		-- block empty
	else
		self:dispatchCompEvent("updateWishInfo", {
			needUpdateItem = true,
			pos = self._pos
		})
	end
end

function RecruitWishKnightComp:_setAlphaRect()
	local var_4_0 = self.m_knightIcon:getContentSprite()

	if var_4_0 == nil then
		return
	end

	local var_4_1 = 110
	local var_4_2 = cc.size(300, 600)
	local var_4_3 = cc.rect(-var_4_2.width / 2, -var_4_2.height / 2, var_4_2.width, var_4_2.height - 110)

	if var_4_3 == nil then
		var_4_3 = {
			x = var_0_1.MASK_RECT.x,
			y = var_0_1.MASK_RECT.y,
			width = var_0_1.MASK_RECT.width,
			height = var_0_1.MASK_RECT.height
		}
	end

	var_4_0:showChangingRect(var_4_3, var_4_1)
end

function RecruitWishKnightComp:getStruct()
	return self._struct
end

function RecruitWishKnightComp:getWishStateIndex()
	return self.m_wishStateController:getSelectedIndex()
end

return RecruitWishKnightComp
