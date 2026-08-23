local var_0_0 = g.core.const.ConstMgr.SnapShotCacheConst
local var_0_1 = g.core.model.User.snapShotCacheData
local NewSlgS2DefenderInfoCell = class("NewSlgS2DefenderInfoCell", require("app.fairyGUI.newSlg.UI_NewSlgS2DefenderInfoCell"))

function NewSlgS2DefenderInfoCell:ctor()
	self._compIconArr = {}
	self._snapshot = nil

	for iter_1_0 = 1, 6 do
		table.insert(self._compIconArr, self["m_Comp_icon" .. iter_1_0])
	end
end

function NewSlgS2DefenderInfoCell:updateCell(arg_2_1, arg_2_2)
	self.m_Txt_authority:setText(arg_2_1.authority)
	self.m_Txt_hp:setText(arg_2_1.troops)
	self.m_Comp_army:updateView({
		armyType = arg_2_1.troop_type,
		level = arg_2_1.troop_level
	})

	local var_2_0 = arg_2_2 and arg_2_2 > 0

	self.m_isUserController:setSelectedIndex(arg_2_2 and arg_2_2 > 0 and 1 or 0)
	self.m_hasElemController:setSelectedIndex(0)

	if var_2_0 then
		self._snapshot = var_0_1:getSnapShot(var_0_0.SNAP_SHOT_KEY.USER, arg_2_2)

		if self._snapshot then
			self.m_nameTxt:setText((var_2_0 or nil) and (self._snapshot.name or ""))
		end

		local var_2_1 = {}
		local var_2_2 = arg_2_1.characters or {}

		for iter_2_0 = 1, 6 do
			if var_2_2[iter_2_0] then
				self._compIconArr[iter_2_0]:setVisible(true)
				self._compIconArr[iter_2_0]:updateView({
					character = var_2_2[iter_2_0]
				})

				if var_2_2[iter_2_0] and var_2_2[iter_2_0].base_id then
					local var_2_3 = g.core.config.knight_info.get(var_2_2[iter_2_0].base_id).classical

					if var_2_3 ~= 0 then
						var_2_1[#var_2_1 + 1] = var_2_3
					end
				end
			else
				self._compIconArr[iter_2_0]:setVisible(false)
			end
		end

		local var_2_4 = g.core.model.User.newSlgData:getTeamElementTypeAndAffectValue(var_2_1)

		if var_2_4 ~= 0 then
			self.m_elemBtn:setIcon((g.core.common.Path:getKnightElementIcon(var_2_4, "ui://newSlg_mapUI/")))
			self.m_hasElemController:setSelectedIndex(1)
		end
	else
		for iter_2_1 = 1, 6 do
			self._compIconArr[iter_2_1]:setVisible(false)
		end
	end
end

return NewSlgS2DefenderInfoCell
