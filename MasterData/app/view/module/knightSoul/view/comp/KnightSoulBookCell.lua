local var_0_0 = g.core.const.ConstMgr.KnightSoulConst
local var_0_1 = g.core.config.ksoul_info
local var_0_2 = g.core.model.User.bagData
local var_0_3 = g.core.const.ConstMgr.BAG_TYPE
local var_0_4 = g.core.common.Path
local KnightSoulBookCell = class("KnightSoulBookCell", require("app.fairyGUI.knightSoul.UI_KnightSoulBookCell"))

function KnightSoulBookCell:ctor()
	self._struct = nil
	self._eff = nil

	self:_initView()
end

function KnightSoulBookCell:_initView()
	self.m_starComp:initStar({
		gap = 5,
		index = 3,
		num = 0,
		scale = 0.5,
		max = var_0_0.MAX_STAR_NUM
	})
end

function KnightSoulBookCell:updateCell(arg_3_1)
	if not arg_3_1 then
		return
	end

	self._struct = arg_3_1

	local var_3_0 = arg_3_1:getStatusIndex()

	self.m_bookStatusController:setSelectedIndex(var_3_0)
	self.m_qualityBg:setURL(var_0_4:getKnightSoulBookCellBg(arg_3_1:getQuality()))
	self:setTitle(arg_3_1:getName())
	self.m_starComp:setStarNum(arg_3_1:getStarNum())
	self:setIcon(var_0_4:getKnightSoulBookPic(arg_3_1:getKnightShow(), g.core.common.Goods.TYPE_KNIGHT))

	local var_3_1 = arg_3_1:getNeedKnightSoulList()
	local var_3_2 = arg_3_1:isActivate()

	for iter_3_0 = 1, 5 do
		if var_3_1[iter_3_0] and var_3_1[iter_3_0] > 0 then
			local var_3_3 = var_0_1.get(var_3_1[iter_3_0])

			self["m_card" .. iter_3_0]:setVisible(true)

			if var_3_2 or var_0_2:getOwnNum(var_0_3.KSOUL, var_3_1[iter_3_0]) > 0 then
				self["m_card" .. iter_3_0]:setURL(var_0_4:getKnightSoulCardIcon(var_3_3.quality))
			else
				self["m_card" .. iter_3_0]:setURL(var_0_4:getKnightSoulCardIcon(0))
			end
		else
			self["m_card" .. iter_3_0]:setVisible(false)
		end
	end

	self:playUpAnim(var_3_0)
end

function KnightSoulBookCell:playUpAnim(arg_4_1)
	local var_4_0

	if arg_4_1 == var_0_0.BOOK_STATUS.STAR_UP_ABLE then
		var_4_0 = "play_up"
	elseif arg_4_1 == var_0_0.BOOK_STATUS.ACTIVATE_ABLE then
		var_4_0 = "play_act"
	end

	if var_4_0 then
		if self._eff then
			self._eff:setAnimation(0, var_4_0, true)
		else
			self._eff = self.m_eff:addEffectSpine({
				name = "eff_ui_KnightSoul_Group",
				isLoop = true,
				anim = var_4_0
			})
		end
	else
		self.m_eff:removeAllEffect()

		self._eff = nil
	end
end

return KnightSoulBookCell
