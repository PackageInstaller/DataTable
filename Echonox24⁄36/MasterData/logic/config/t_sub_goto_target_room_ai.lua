-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_sub_goto_target_room_ai.lua

module("logic.config.t_sub_goto_target_room_ai", package.seeall)

aiConfigData = {
	root = {
		repeatForever = true,
		returnSuccess = true,
		count = 1,
		type = "Repeater",
		endOnFailure = true,
		aiTag = "Repeater_1",
		children = {
			{
				useChildResult = true,
				aiTag = "Condition_2",
				type = "Condition",
				children = {
					{
						withPath = true,
						aiTag = "TargetRoomInSameRing_3",
						type = "TargetRoomInSameRing"
					},
					{
						aiTag = "Sequence_4",
						type = "Sequence",
						children = {
							{
								aiTag = "WalkToTargetRoom_5",
								type = "WalkToTargetRoom"
							},
							{
								isSucc = false,
								aiTag = "ReturnResult_6",
								type = "ReturnResult"
							}
						}
					},
					{
						aiTag = "Sequence_7",
						type = "Sequence",
						children = {
							{
								aiTag = "WalkToNearestElevator_8",
								type = "WalkToNearestElevator"
							},
							{
								aiTag = "ElevatorAction_9",
								type = "ElevatorAction"
							}
						}
					}
				}
			}
		}
	}
}
