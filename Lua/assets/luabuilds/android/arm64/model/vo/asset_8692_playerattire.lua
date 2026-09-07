local PlayerAttire = class("PlayerAttire", import(".BaseVO"))

function PlayerAttire:Ctor(arg_1_1)
	self:Flush(arg_1_1)

	return
end

function PlayerAttire:Flush(arg_2_1)
	local var_2_0 = arg_2_1.display or {}

	self.icon = arg_2_1.icon or var_2_0.icon

	if arg_2_1.character then
		self.characters = underscore.map(arg_2_1.character, function(arg_3_0)
			return arg_3_0.key
		end)
		self.phantoms = underscore.map(arg_2_1.character, function(arg_4_0)
			return arg_4_0.value
		end)
		self.character = self.characters[1]
		self.phantomId = self.phantoms[1] or 0
	end

	self.skinId = arg_2_1.skin_id or var_2_0.skin or 0

	if self.skinId == 0 then
		if pg.ship_data_statistics[self.icon] then
			self.skinId = pg.ship_data_statistics[self.icon].skin_id
		end
	end

	self.remoulded = false

	if arg_2_1.remoulded and arg_2_1.remoulded == 1 or var_2_0.transform_flag and var_2_0.transform_flag == 1 then
		self.remoulded = true
	end

	if not arg_2_1.propose or arg_2_1.propose <= 0 then
		self.propose = var_2_0.marry_flag and var_2_0.marry_flag > 0
	end

	self.proposeTime = arg_2_1.propose or var_2_0.marry_flag
	self.iconFrame = arg_2_1.icon_frame or var_2_0.icon_frame or 0
	self.chatFrame = arg_2_1.chat_frame or var_2_0.chat_frame or 0
	self.iconTheme = arg_2_1.icon_theme or var_2_0.icon_theme or 0
	self.attireInfo = {}
	self.attireInfo[AttireConst.TYPE_ICON_FRAME] = self.iconFrame
	self.attireInfo[AttireConst.TYPE_CHAT_FRAME] = self.chatFrame

	return
end

function PlayerAttire:getPainting()
	return pg.ship_skin_template[self.skinId].painting
end

return PlayerAttire
