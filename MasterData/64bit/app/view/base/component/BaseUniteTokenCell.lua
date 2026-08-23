local BaseUniteTokenCell = class("BaseUniteTokenCell", require("app.fairyGUI.base_new.UI_BaseUniteTokenCell"))
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.config.unite_token_info

function BaseUniteTokenCell:ctor()
	self.getSharedTrans(self, "listCardAUiLeftIn", "CombineBagList", self)
end

function BaseUniteTokenCell:updateCell(arg_2_1)
	if arg_2_1.isEmptyItem then
		self:setVisible(false)

		return
	end

	self:setVisible(true)

	self._data = arg_2_1
	self._isOwn = self._data:isOwn()
	self._tokenId = self._data:getBaseId()
	self._isAwaken = self._data:isAwaken()

	self.m_qualityTopLoader:setURL(var_0_1:getCardQualityLine(self._data:getQuality() + 1))
	self.m_nameText:setText(self._data:getName())
	self.m_iconLoader:setIcon(var_0_1:getUniteTokenCardImg(self._data:getAdvanceId()))
	;(function(arg_3_0)
		self.m_nameText:setVisible(arg_3_0)
		self.m_starComp:setVisible(arg_3_0)
		self.m_level:setVisible(arg_3_0)
		self.m_lineUp:setVisible(arg_3_0)
		self.m_process:setVisible(not arg_3_0)
		self.m_centerInfo:setVisible(not arg_3_0)
	end)(self._isOwn)
	self.m_canStarUp:setVisible(false)

	if self._isOwn then
		self:_updateOwnCell()
		self.m_level:setVisible(self._data:getLevel() > 0)
		self.m_name2Txt:setVisible(false)
	else
		local var_2_0 = self._data:canCompose()

		self.m_go:setVisible(not var_2_0)
		self.m_unlock:setVisible(var_2_0)

		local var_2_1, var_2_2 = self._data:getFragmentNum()

		self.m_curTxt:setText(var_2_1)
		self.m_needTxt:setText("/" .. var_2_2)

		if var_2_2 <= var_2_1 then
			self.m_curTxt:setColor(g.core.common.Color.A8)
		else
			self.m_curTxt:setColor(g.core.common.Color.A7)
		end

		self.m_name2Txt:setVisible(true)
		self.m_name2Txt:setText(self._data:getName())

		if self.rightSpine then
			self.rightSpine:removeFromParent(true)
		end

		if self.leftSpine then
			self.leftSpine:removeFromParent(true)
		end
	end

	self.m_skillBtn:updateIcon({
		skillId = self._data:getSkillId()
	})
end

function BaseUniteTokenCell:_updateOwnCell()
	self.m_starComp:initStar({
		index = 3,
		style = 2,
		max = 5,
		gap = 0,
		num = var_0_2.get(self._tokenId).star
	})
	self.m_levelTxt:setText(self._data:getLevel())

	local var_4_0, var_4_1, var_4_2 = self._data:canStarup()
	local var_4_3 = self._data:canAwaken()

	if (var_4_3 or var_4_0 and var_4_2 > 0) and (var_4_3 and false or var_4_0 and var_4_2 > 0) then
		self.m_canStarUp:setVisible(true)
	end

	self.m_lineUp:setVisible((self._data:isLineup()))
end

function BaseUniteTokenCell:setReborn()
	self.m_canStarUp:setVisible(false)
	self.m_lineUp:setVisible(false)
	self.m_centerInfo:setVisible(false)
	self.m_process:setVisible(false)
end

return BaseUniteTokenCell
