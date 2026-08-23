local NewSlgPvcChariotInfoCell = class("NewSlgPvcChariotInfoCell")

function NewSlgPvcChariotInfoCell:ctor()
	self._compIcon1 = self:getChild("Comp_icon1")
	self._compIcon2 = self:getChild("Comp_icon2")
	self._compIcon3 = self:getChild("Comp_icon3")
	self._compIcon4 = self:getChild("Comp_icon4")
	self._compIcon5 = self:getChild("Comp_icon5")
	self._compIcon6 = self:getChild("Comp_icon6")
	self._alliName = self:getChild("alliNameTxt")
	self._itemCompArrMap = {
		[g.core.common.Goods.TYPE_KNIGHT] = {
			self._compIcon1,
			self._compIcon2,
			self._compIcon3,
			self._compIcon4,
			self._compIcon5,
			self._compIcon6
		}
	}
	self._compName = self:getChild("Comp_name")
	self._compArmy = self:getChild("Comp_army")
	self._txtHp = self:getChild("Txt_hp")
	self._txtAuthority = self:getChild("Txt_authority")
	self._hasElemCtr = self:getController("hasElem")
	self.m_elemBtn = self:getChild("elemBtn")
end

function NewSlgPvcChariotInfoCell:updateCell(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self._hasElemCtr:setSelectedIndex(0)

	if not arg_2_1 or not arg_2_2 then
		return
	end

	self._compName:setText(arg_2_2.name)

	if arg_2_3 then
		local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.ALLIANCE, arg_2_2.alliance_id)

		if var_2_0 then
			self._alliName:setText(var_2_0.name)
		else
			self._alliName:setText("")
		end
	else
		self._alliName:setText("")
	end

	self._compArmy:updateView({
		armyType = arg_2_1.troop_type,
		level = arg_2_1.troop_level
	})
	self._txtHp:setText(arg_2_1.troops)

	local var_2_1 = arg_2_1.characters or {}
	local var_2_2 = {}

	if #var_2_1 > 0 then
		for iter_2_0, iter_2_1 in ipairs(var_2_1) do
			if var_2_2[iter_2_1.tp] == nil then
				var_2_2[iter_2_1.tp] = {}
			end

			table.insert(var_2_2[iter_2_1.tp], iter_2_1)
		end
	end

	local var_2_3 = {}

	for iter_2_2, iter_2_3 in pairs(self._itemCompArrMap) do
		local var_2_4 = var_2_2[iter_2_2] or {}

		for iter_2_4, iter_2_5 in ipairs(iter_2_3) do
			local var_2_5 = var_2_4[iter_2_4] or {
				tp = iter_2_2
			}

			iter_2_5:updateView({
				character = var_2_5
			})

			if var_2_5 and var_2_5.base_id then
				local var_2_6 = g.core.config.knight_info.get(var_2_5.base_id).classical

				if var_2_6 ~= 0 then
					var_2_3[#var_2_3 + 1] = var_2_6
				end
			end
		end
	end

	local var_2_7 = arg_2_1.authority
	local var_2_8 = g.core.model.User.newSlgData:getTeamElementTypeAndAffectValue(var_2_3)

	if var_2_8 ~= 0 then
		self.m_elemBtn:setIcon((g.core.common.Path:getKnightElementIcon(var_2_8, "ui://newSlg_mapUI/")))
		self._hasElemCtr:setSelectedIndex(1)

		if arg_2_4 and arg_2_4.element == var_2_8 then
			local var_2_9 = math.floor(arg_2_1.base_authority * (arg_2_4.num / 1000))

			if arg_2_4.type == 1 then
				-- block empty
			elseif arg_2_4.type == 2 then
				var_2_9 = -var_2_9
			end

			var_2_7 = var_2_7 + var_2_9
		end
	end

	self._txtAuthority:setText(var_2_7)
end

return NewSlgPvcChariotInfoCell
