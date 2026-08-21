return {
	GetInteractBehaviour = function(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
		local var_1_0 = nullable(DormInteractSequence, arg_1_3, "name")

		return (DormCharacterInteractBehaviour.GetSequence(arg_1_1, arg_1_2, var_1_0))
	end
}
