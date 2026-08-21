return {
	Inject = function(arg_1_0, arg_1_1)
		function arg_1_1.Agent_CameraControl(arg_2_0, arg_2_1, arg_2_2)
			arg_2_0.blackboard:Agent_CameraControl(arg_2_1)

			if arg_2_2 then
				arg_2_2()
			end
		end

		function arg_1_1.Agent_PlayerPosControl(arg_3_0, arg_3_1, arg_3_2)
			arg_3_0.blackboard:Agent_PlayerPosControl(arg_3_1)

			if arg_3_2 then
				arg_3_2()
			end
		end
	end
}
