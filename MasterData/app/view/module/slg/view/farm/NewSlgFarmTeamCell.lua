local NewSlgFarmTeamCell = class("NewSlgFarmTeamCell")

function NewSlgFarmTeamCell:ctor()
	self._compIcon1 = self:getChild("Comp_icon1")
	self._compIcon2 = self:getChild("Comp_icon2")
	self._compIcon3 = self:getChild("Comp_icon3")
	self._compIcon4 = self:getChild("Comp_icon4")
	self._itemCompArrMap = {
		[g.core.common.Goods.TYPE_KNIGHT] = {
			self._compIcon1,
			self._compIcon2
		}
	}
	self._compName = self:getChild("Comp_name")
	self._compPlayerIcon = self:getChild("Comp_playerIcon")
	self._compArmy = self:getChild("Comp_army")
	self._txtHp = self:getChild("Txt_hp")
	self._txtAuthority = self:getChild("Txt_authority")
	self._txtArmyLevel = self:getChild("Txt_armyLevel")
	self._txtAlliance = self:getChild("Txt_alliance")
	self._txtStateDesc = self:getChild("Txt_stateDesc")
	self._imgAllianceBg = self:getChild("Img_allianceBg")
	self._isSelfCtrl = self:getController("is_self")
	self._isOccupiedCtrl = self:getController("is_occupied")
end

function NewSlgFarmTeamCell:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SCHEDULE_NOTIFY_NEW, handler(self, self._onSchedule), self)
end

function NewSlgFarmTeamCell:_onSchedule(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3.key == "NewSlgFarmTeamCell_updateSch" then
		self:_updateCountDown()
	end
end

function NewSlgFarmTeamCell:updateCell(arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_1 or not arg_4_2 or not arg_4_3 then
		return
	end

	g.utils.ToolUtils.newSlgFunc.addSchedule({
		key = "NewSlgFarmTeamCell_updateSch"
	})

	self._team = arg_4_1

	self._compName:updateQualityTxtForce({
		text = arg_4_2.name,
		quality = g.core.config.knight_info.get(arg_4_2.base_id).quality
	})
	self._compPlayerIcon:updateAsUser(arg_4_2)
	self._compPlayerIcon:setClickFunc(handler(self, function(arg_5_0)
		g.utils.ToolUtils.newSlgFunc.openTeamPlayerInfo(arg_4_2)
	end))
	self._compArmy:updateView({
		armyType = arg_4_1.troop_type
	})
	self._txtArmyLevel:setText(g.core.lang:get("LEVEL", {
		level = arg_4_1.troop_level
	}))
	self._txtAuthority:setText(arg_4_1.authority)
	self._txtHp:setText(arg_4_1.troops)

	local var_4_0 = arg_4_1.characters or {}
	local var_4_1 = {}

	if #var_4_0 > 0 then
		for iter_4_0, iter_4_1 in ipairs(var_4_0) do
			if var_4_1[iter_4_1.tp] == nil then
				var_4_1[iter_4_1.tp] = {}
			end

			table.insert(var_4_1[iter_4_1.tp], iter_4_1)
		end
	end

	for iter_4_2, iter_4_3 in pairs(self._itemCompArrMap) do
		local var_4_2 = var_4_1[iter_4_2] or {}

		for iter_4_4, iter_4_5 in ipairs(iter_4_3) do
			local var_4_3 = var_4_2[iter_4_4] or {
				tp = iter_4_2
			}

			iter_4_5:updateView({
				character = var_4_3
			})
		end
	end

	self._isSelfCtrl:setSelectedIndex(arg_4_2.id == g.core.model.User:getId() and 1 or 0)

	if arg_4_3.snapshot then
		self._txtAlliance:setText(arg_4_3.snapshot.name)
		self._isOccupiedCtrl:setSelectedIndex(g.core.config.new_slg_camp_info.get(arg_4_3.snapshot.id).color)
	end

	self:_updateCountDown()
end

function NewSlgFarmTeamCell:_updateCountDown()
	local var_6_0 = g.core.model.User.newSlgData:getTeamStateByTeam(self._team)

	if var_6_0.text2 ~= "" then
		self._txtStateDesc:setVisible(true)
		self._txtStateDesc:setText(var_6_0.text2)
	else
		self._txtStateDesc:setVisible(false)
	end
end

return NewSlgFarmTeamCell
