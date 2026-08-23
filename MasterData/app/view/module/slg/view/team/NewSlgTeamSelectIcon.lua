local NewSlgTeamSelectIcon = class("NewSlgTeamSelectIcon")

function NewSlgTeamSelectIcon:ctor()
	self._headLoader = self:getChild("headLoader")
	self._indexTxt = self:getChild("Txt_index")
	self._typeCtrl = self:getController("type")
	self._qualityLoader = self:getChild("qualityLoader")
	self._compStar = self:getChild("Comp_star")
	self._valueTxt = self:getChild("valueTxt")
	self._elementLoader = self:getChild("elementLoader")
	self._itemType = nil
	self._struct = nil
	self._teamIndex = nil
	self._teamCharacterMap = nil
	self._itemMaxType = {
		[g.core.common.Goods.TYPE_KNIGHT] = g.core.const.ConstMgr.NewSlgConst.TEAM_UP_KNIGHT_MAX,
		[g.core.common.Goods.TYPE_UNITETOKEN] = g.core.const.ConstMgr.NewSlgConst.TEAM_UP_UNITETOKEN_MAX,
		[g.core.common.Goods.TYPE_PET] = g.core.const.ConstMgr.NewSlgConst.TEAM_UP_PET_MAX
	}

	self:addClickListener(handler(self, self._onClick))
end

function NewSlgTeamSelectIcon:updateCell(arg_2_1)
	self._itemType = arg_2_1.itemType
	self._teamIndex = arg_2_1.teamIndex
	self._struct = arg_2_1.struct
	self._teamCharacterMap = arg_2_1.teamCharacterMap
	self._characters = arg_2_1.characters or {}

	self._valueTxt:setText("+" .. (arg_2_1.authority or 0) / 100 .. "%")

	local var_2_0, var_2_1 = g.core.utils.Tools.newSlgFunc.getIconPathByChapterOrStruct(nil, self._struct, self._itemType)

	self._headLoader:setURL(var_2_0)

	local var_2_2 = self._struct:getCfg()

	self._qualityLoader:setURL("ui://base_new/bg_xd_pinzhi" .. var_2_2.quality + 1 .. "_2")
	self._compStar:initStar({
		index = 3,
		style = 2,
		gap = -8,
		num = var_2_2.star
	})
	self._compStar:setVisible(var_2_2.star > 0)

	if var_2_2.classical and var_2_2.classical > 0 then
		self._elementLoader:setVisible(true)
		self._elementLoader:setURL(g.core.common.Path:getKnightElementIcon(var_2_2.classical))
	else
		self._elementLoader:setVisible(false)
	end

	self:_updateStatus()
end

function NewSlgTeamSelectIcon:_updateStatus()
	local var_3_0

	if self._teamCharacterMap then
		for iter_3_0, iter_3_1 in pairs(self._teamCharacterMap) do
			if iter_3_1[self._itemType] and iter_3_1[self._itemType][g.core.common.GlobalFunc.getSerIdByTypeAndStruct(self._itemType, self._struct)] then
				var_3_0 = iter_3_0

				break
			end
		end
	end

	self._indexTxt:setText("")

	if var_3_0 then
		if var_3_0 == self._teamIndex then
			self._typeCtrl:setSelectedIndex(1)
		else
			self._indexTxt:setText(g.core.lang:get(428817, {
				index = var_3_0
			}))
			self._typeCtrl:setSelectedIndex(2)
		end
	else
		self._typeCtrl:setSelectedIndex(0)
	end
end

function NewSlgTeamSelectIcon:_onClick()
	local var_4_0 = self._typeCtrl:getSelectedIndex()

	if var_4_0 == 0 then
		if self._characters then
			local var_4_1 = {}

			for iter_4_0, iter_4_1 in ipairs(self._characters) do
				if iter_4_1.tp == self._itemType then
					table.insert(var_4_1, iter_4_1)
				end
			end

			if #var_4_1 >= self._itemMaxType[self._itemType] then
				g.core.module.ModuleManager:tip(g.core.lang:get(428821))

				return
			end
		end

		self:_updateTeam(true)
		self._typeCtrl:setSelectedIndex(1)
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_JianDing_Selected)
	elseif var_4_0 == 1 then
		self:_updateTeam(false)
		self._typeCtrl:setSelectedIndex(0)
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_JianDing_Selected)
	elseif var_4_0 == 2 then
		g.core.module.ModuleManager:tip(g.core.lang:get(429029))

		return
	end
end

function NewSlgTeamSelectIcon:_updateTeam(arg_5_1)
	local var_5_0 = g.core.common.GlobalFunc.getSerIdByTypeAndStruct(self._itemType, self._struct)

	if arg_5_1 then
		table.insert(self._characters, {
			tp = self._itemType,
			id = var_5_0
		})

		if self._teamCharacterMap[self._teamIndex] == nil then
			self._teamCharacterMap[self._teamIndex] = {}
		end

		if self._teamCharacterMap[self._teamIndex][self._itemType] == nil then
			self._teamCharacterMap[self._teamIndex][self._itemType] = {}
		end

		self._teamCharacterMap[self._teamIndex][self._itemType][var_5_0] = true
	else
		for iter_5_0, iter_5_1 in ipairs(self._characters) do
			if iter_5_1.id == var_5_0 then
				table.remove(self._characters, iter_5_0)

				break
			end
		end

		self._teamCharacterMap[self._teamIndex][self._itemType][var_5_0] = nil
	end

	self:dispatchCompEvent("NewSlgTeamSelectIcon_refresh_tab")
end

return NewSlgTeamSelectIcon
