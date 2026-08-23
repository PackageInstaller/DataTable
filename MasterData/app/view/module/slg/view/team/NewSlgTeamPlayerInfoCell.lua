local NewSlgTeamPlayerInfoCell = class("NewSlgTeamPlayerInfoCell")

function NewSlgTeamPlayerInfoCell:ctor()
	self._txtName = self:getChild("Txt_name")
	self._compDesc = self:getChild("Comp_desc")
	self._compIcon1 = self:getChild("Comp_icon1")
	self._compArmy = self:getChild("Comp_army")
	self._compIcon2 = self:getChild("Comp_icon2")
	self._compIcon3 = self:getChild("Comp_icon3")
	self._compIcon4 = self:getChild("Comp_icon4")
	self._emptyCtrlCtrl = self:getController("empty_ctrl")
	self._txtLevel = self:getChild("Txt_level")
	self._team = nil
	self._itemCompArrMap = {
		[g.core.common.Goods.TYPE_KNIGHT] = {
			self._compIcon1,
			self._compIcon2
		},
		[g.core.common.Goods.TYPE_ADVISER] = {
			self._compIcon3
		},
		[g.core.common.Goods.TYPE_BEAUTY] = {
			self._compIcon4
		}
	}
end

function NewSlgTeamPlayerInfoCell:updateCell(arg_2_1)
	self._emptyCtrlCtrl:setSelectedIndex(1)

	self._team = arg_2_1.team

	if self._team ~= nil and self._team.characters ~= nil and #self._team.characters > 0 then
		self._emptyCtrlCtrl:setSelectedIndex(0)
		self:_updateIcon()
		self:_updateArmy()
	end
end

function NewSlgTeamPlayerInfoCell:_updateIcon()
	local var_3_0 = self._team.characters or {}
	local var_3_1 = {}

	if #var_3_0 > 0 then
		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			if var_3_1[iter_3_1.tp] == nil then
				var_3_1[iter_3_1.tp] = {}
			end

			table.insert(var_3_1[iter_3_1.tp], iter_3_1)
		end
	end

	for iter_3_2, iter_3_3 in pairs(self._itemCompArrMap) do
		local var_3_2 = var_3_1[iter_3_2] or {}

		for iter_3_4, iter_3_5 in ipairs(iter_3_3) do
			iter_3_5:updateView({
				character = var_3_2[iter_3_4]
			})
		end
	end

	local var_3_3 = self._team.authority or 0

	self._compDesc:updateView({
		num = var_3_3
	})
end

function NewSlgTeamPlayerInfoCell:_updateArmy()
	local var_4_0 = self._team.troop_type or g.core.const.ConstMgr.NewSlgConst.ARMY_TYPE.QI

	self._compArmy:updateView({
		armyType = var_4_0
	})

	local var_4_1 = self._team.troop_level or 1

	self._txtLevel:setText(g.core.lang:get(428987, {
		level = var_4_1
	}))
end

return NewSlgTeamPlayerInfoCell
