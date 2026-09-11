return {
	Inject = function(arg_1_0, arg_1_1)
		function arg_1_1:LoadActor(arg_2_1)
			if not isNil(self.blackboard) then
				return self.blackboard:LoadChar(arg_2_1)
			end

			return nil
		end

		function arg_1_1:UnloadActor(arg_3_1)
			if not isNil(self.blackboard) then
				self.blackboard:UnloadChar(arg_3_1)
			end

			return nil
		end

		function arg_1_1:EnableNoneEyeFace(arg_4_1, arg_4_2)
			self:LoadActor(arg_4_1):EnableNoneEyeFace(arg_4_2 or false)
		end
	end
}
