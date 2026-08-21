return {
	Inject = function(arg_1_0, arg_1_1)
		function arg_1_1.LoadThing(arg_2_0, arg_2_1, arg_2_2)
			if not isNil(arg_2_0.blackboard) then
				return arg_2_0.blackboard:LoadThing(arg_2_1, arg_2_2)
			end

			return nil
		end

		function arg_1_1.UnloadThing(arg_3_0, arg_3_1)
			if not isNil(arg_3_0.blackboard) then
				arg_3_0.blackboard:UnloadThing(arg_3_1)
			end

			return nil
		end

		function arg_1_1.SetThingToTag(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
			local var_4_0 = arg_4_0.blackboard:GetThing(arg_4_1)
			local var_4_1 = arg_4_0.blackboard:GetPoint(arg_4_2)

			if not isNil(var_4_0) and not isNil(var_4_1) then
				var_4_0:SetTransform(var_4_1)
			end

			if arg_4_3 then
				arg_4_3()
			end
		end

		function arg_1_1.LoadThingToTag(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
			local var_5_0 = arg_5_0:LoadThing(arg_5_1, arg_5_2)
			local var_5_1 = arg_5_0.blackboard:GetPoint(arg_5_3)

			if not isNil(var_5_0) and not isNil(var_5_1) then
				var_5_0:SetTransform(var_5_1)
			end

			if arg_5_4 then
				arg_5_4()
			end
		end

		function arg_1_1.PlayThingAnimationAction(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
			local var_6_0 = arg_6_0.blackboard:GetThing(arg_6_1)

			if not isNil(var_6_0) then
				var_6_0:PlayAnimaton(arg_6_2, arg_6_3, arg_6_4, arg_6_5)
			end
		end
	end
}
