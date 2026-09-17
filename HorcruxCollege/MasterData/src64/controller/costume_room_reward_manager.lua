local CostumeRoomRewardManager = class("CostumeRoomRewardManager", (require("controller.base_manager")))

CostumeRoomRewardManager.MULTITON_MSG = "CostumeRoomRewardManager instancealready constructed!"

function CostumeRoomRewardManager:ctor()
	self.super.ctor(self)

	self._data = {}
end

function CostumeRoomRewardManager:requestInfo(arg_2_1)
	require("controller.costume_room_cumulative_reward_manager"):getInstance():requestInfo(function(arg_3_0)
		self:updateLayer()

		if arg_2_1 then
			arg_2_1(arg_3_0)
		end
	end)
end

function CostumeRoomRewardManager:handlerInfo(arg_4_1)
	dumpEx_3_10(arg_4_1)
end

function CostumeRoomRewardManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

return CostumeRoomRewardManager
