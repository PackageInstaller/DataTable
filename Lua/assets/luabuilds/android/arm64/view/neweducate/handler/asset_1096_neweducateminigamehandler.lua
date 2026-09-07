local NewEducateMinigameHandler = class("NewEducateMinigameHandler")

function NewEducateMinigameHandler:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.games = {}
	self.view = arg_1_2

	return
end

function NewEducateMinigameHandler:Play(arg_2_1, arg_2_2)
	setActive(self._go, true)

	self.config = pg.child2_minigame[arg_2_1]

	if not self.games[self.config.view_name] then
		self.games[self.config.view_name] = _G[self.config.view_name].New(self._tf)

		self.games[self.config.view_name]:RegisterView(self.view)
	end

	self.games[self.config.view_name]:ExecuteAction("Show", arg_2_1, function(arg_3_0)
		arg_2_2((self:GetNextId(arg_3_0)))

		return
	end)

	return
end

function NewEducateMinigameHandler:GetNextId(arg_4_1)
	if type(arg_4_1) ~= "number" then
		arg_4_1 = 0
	end

	local var_4_0 = self.config.result_data

	for iter_4_0, iter_4_1 in ipairs(self.config.result_data) do
		if arg_4_1 >= iter_4_1[1][1] and arg_4_1 >= iter_4_1[1][2] then
			return iter_4_1[2][1]
		end
	end

	return var_4_0[#var_4_0][2][1]
end

function NewEducateMinigameHandler:Reset()
	setActive(self._go, false)

	return
end

function NewEducateMinigameHandler:Destroy()
	for iter_6_0, iter_6_1 in pairs(self.games) do
		iter_6_1:Destroy()
	end

	return
end

return NewEducateMinigameHandler
