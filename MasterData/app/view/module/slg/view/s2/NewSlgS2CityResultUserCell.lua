local NewSlgS2CityResultUserCell = class("NewSlgS2CityResultUserCell", require("app.fairyGUI.newSlg.UI_NewSlgS2CityResultUserCell"))
local var_0_1 = g.core.model.User.snapShotCacheData
local var_0_2 = g.core.const.ConstMgr.SnapShotCacheConst

function NewSlgS2CityResultUserCell:ctor()
	self._user = nil
	self._txtHp = self:getChild("Txt_hp")
	self._txtAuthority = self:getChild("Txt_authority")
	self._itemCompArr = {}

	for iter_1_0 = 1, 6 do
		table.insert(self._itemCompArr, self["m_Comp_icon" .. iter_1_0])
	end
end

function NewSlgS2CityResultUserCell:updateCell(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	self._data = arg_2_1

	if not self._data.team then
		return
	end

	self._user = var_0_1:getSnapShot(var_0_2.SNAP_SHOT_KEY.USER, self._data.team.user_id)

	if self._user then
		self.m_nameTxt:setText(self._user.name)
	end

	self.m_Comp_army:updateView({
		armyType = self._data.team.troop_type,
		level = self._data.team.troop_level
	})
	self._txtAuthority:setText(self._data.team.authority)
	self._txtHp:setText(self._data.team.troops)

	local var_2_0 = {}

	var_2_0.num = self._data.kill_num or 0

	self.m_killNum:setText(g.core.lang:get(429643, var_2_0))
	self.m_killScore:setText(g.core.lang:get(429644, {
		num = self._data.kill_score
	}))
	self.m_gatherScore:setText(g.core.lang:get(429645, {
		num = self._data.gather_score
	}))

	local var_2_1 = self._data.team.characters or {}

	for iter_2_0 = 1, 6 do
		if var_2_1[iter_2_0] then
			self._itemCompArr[iter_2_0]:updateView({
				character = var_2_1[iter_2_0]
			})
		end

		self._itemCompArr[iter_2_0]:setVisible(checkbool(var_2_1[iter_2_0]))
	end
end

return NewSlgS2CityResultUserCell
