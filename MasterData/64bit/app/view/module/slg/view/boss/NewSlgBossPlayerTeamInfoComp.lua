local NewSlgBossPlayerTeamInfoComp = class("NewSlgBossPlayerTeamInfoComp")

function NewSlgBossPlayerTeamInfoComp:ctor()
	self._iconComps = {}

	for iter_1_0 = 1, 6 do
		self._iconComps[iter_1_0] = self:getChild("Comp_icon" .. iter_1_0)
	end
end

function NewSlgBossPlayerTeamInfoComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self.updateUserSnapShot, self)
end

function NewSlgBossPlayerTeamInfoComp:updateView(arg_3_1)
	if not arg_3_1 then
		self:setVis(false)

		return
	end

	self._teamUser = arg_3_1

	local var_3_0 = arg_3_1.team.characters or {}

	for iter_3_0 = 1, 6 do
		if var_3_0[iter_3_0] then
			self._iconComps[iter_3_0]:updateView({
				character = var_3_0[iter_3_0]
			})
		else
			self._iconComps[iter_3_0]:updateView()
		end
	end
end

function NewSlgBossPlayerTeamInfoComp:updateUserSnapShot()
	return
end

function NewSlgBossPlayerTeamInfoComp:setVis(arg_5_1, arg_5_2)
	if arg_5_1 then
		self:setVisible(true)
		self:updateView(arg_5_2)
	else
		self:setVisible(false)
	end
end

return NewSlgBossPlayerTeamInfoComp
