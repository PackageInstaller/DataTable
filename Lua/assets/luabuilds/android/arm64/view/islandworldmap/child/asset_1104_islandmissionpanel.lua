local IslandMissionPanel = class("IslandMissionPanel")

function IslandMissionPanel:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._event = arg_1_2

	onButton(self._event, findTF(self._tf, "ad/confirm"), function()
		self:onClickConfirm()

		return
	end, SFX_CONFIRM)

	return
end

function IslandMissionPanel:setData(arg_3_1)
	self.buildType = arg_3_1

	return
end

function IslandMissionPanel:onClickConfirm()
	self:setActive(false)

	return
end

function IslandMissionPanel:setActive(arg_5_1)
	setActive(self._tf, arg_5_1)

	return
end

function IslandMissionPanel:dispose()
	return
end

return IslandMissionPanel
