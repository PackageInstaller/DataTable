local BagNewSelectRewardsCell = class("BagNewSelectRewardsCell", require("app.fairyGUI.bagNew.UI_BagNewSelectRewardsCell"))
local var_0_1 = g.core.lang
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.common.Path
local var_0_4 = g.core.config.knight_info
local var_0_5 = g.core.config.fragment_info
local var_0_6 = g.core.model.User
local var_0_7 = g.core.const.ConstMgr
local var_0_8 = g.core.const.ConstMgr.ShopConst
local var_0_9 = g.core.config

function BagNewSelectRewardsCell:ctor()
	return
end

function BagNewSelectRewardsCell:updateCell(arg_2_1)
	arg_2_1.hideSkin = true
	arg_2_1.changeControllers = true

	if var_0_6.shopData:isBigTypeItemAlreadyHave(arg_2_1) then
		if var_0_6.shopData:isBigTypeItemAlreadyMaxStar(arg_2_1) then
			arg_2_1.iconTagType = var_0_7.BASE_CONST.ICON_TAG_TYPE.MAX_STAR or var_0_7.BASE_CONST.ICON_TAG_TYPE.HAVE
		end
	end

	self.m_baseItem:updateIcon(arg_2_1)

	local var_2_0, var_2_1, var_2_2 = var_0_6.shopData:getFragNumInfo(arg_2_1)

	self.m_haveTxt:setVisible(var_2_0)

	if var_2_0 then
		if var_2_2 > 0 then
			self.m_haveTxt:setText(var_0_1:get(1089, {
				num1 = var_0_1:getFormatNumText(var_2_1),
				num2 = var_0_1:getFormatNumText(var_2_2)
			}))
		else
			self.m_haveTxt:setText(var_0_1:get(1090, {
				num = var_0_1:getFormatNumText(var_2_1)
			}))
		end
	end

	local var_2_3 = var_0_2:convert(arg_2_1)

	if not var_2_3 then
		return
	end

	local var_2_4

	if var_2_3.type == var_0_2.TYPE_FRAGMENT then
		local var_2_5 = var_0_5.get(var_2_3.value)

		if var_2_5.fragment_type == var_0_2.TYPE_KNIGHT then
			var_2_4 = var_0_3:getCampURL(var_0_4.get(var_2_5.fragment_value).group, 1)
		end
	elseif var_2_3.type == var_0_2.TYPE_KNIGHT then
		var_2_4 = var_0_3:getCampURL(var_0_4.get(var_2_3.value).group, 1)
	end

	if var_2_4 then
		self.m_flagGroup:setVisible(true)
		self.m_group:setURL(var_2_4)
	else
		self.m_flagGroup:setVisible(false)
	end
end

function BagNewSelectRewardsCell:_isLineUp(arg_3_1)
	if not arg_3_1 then
		return false
	end

	self:updateRecommandData()

	local var_3_0 = false
	local var_3_1 = arg_3_1.type
	local var_3_2 = arg_3_1.value

	if arg_3_1.type == var_0_2.TYPE_FRAGMENT then
		local var_3_3 = var_0_9.fragment_info.get(arg_3_1.value)

		var_3_1 = var_3_3.fragment_type
		var_3_2 = var_3_3.fragment_value
	end

	if var_3_1 == var_0_2.TYPE_KNIGHT then
		if self._knightFragRecommandMap[var_3_2] == var_0_8.RECOMMAND_TYPE.KNIGHT_LINE_UP then
			var_3_0 = true
		end
	elseif var_3_1 == var_0_2.TYPE_UNITETOKEN and self._uniteTokenFragRecommandMap[var_3_2] == var_0_8.RECOMMAND_TYPE.UNITETOKEN_LINE_UP then
		var_3_0 = true
	end

	return var_3_0
end

function BagNewSelectRewardsCell:updateRecommandData()
	self:_updateKnightRecommandData()
	self:_updateUniteTokenRecommandData()
end

function BagNewSelectRewardsCell:_updateKnightRecommandData()
	self._knightFragRecommandMap = {}

	local function var_5_0(arg_6_0, arg_6_1)
		if not self._knightFragRecommandMap[arg_6_0] or arg_6_1 < self._knightFragRecommandMap[arg_6_0] then
			self._knightFragRecommandMap[arg_6_0] = arg_6_1
		end
	end

	local var_5_1 = var_0_6.knightsData:getFormationKnights()

	for iter_5_0 = 1, var_0_7.KNIGHT_CONST.KNIGHT_BACKUP_MAX do
		local var_5_2 = var_0_6.knightsData:getKnight({
			id = var_5_1[iter_5_0]
		})

		if var_5_2 then
			if var_5_2:isLineup() then
				var_5_0(var_5_2:getBaseInfo().advance_id, var_0_8.RECOMMAND_TYPE.KNIGHT_LINE_UP)
			end
		end
	end
end

function BagNewSelectRewardsCell:_updateUniteTokenRecommandData()
	self._uniteTokenFragRecommandMap = {}

	local function var_7_0(arg_8_0, arg_8_1)
		if not self._uniteTokenFragRecommandMap[arg_8_0] or arg_8_1 < self._uniteTokenFragRecommandMap[arg_8_0] then
			self._uniteTokenFragRecommandMap[arg_8_0] = arg_8_1
		end
	end

	for iter_7_0, iter_7_1 in ipairs((var_0_6.uniteTokenData:getTokenList())) do
		if iter_7_1:isLineup() and not iter_7_1:isMaxStarLevel() then
			var_7_0(iter_7_1:getAdvanceId(), var_0_8.RECOMMAND_TYPE.UNITETOKEN_LINE_UP)
		end
	end
end

return BagNewSelectRewardsCell
