class = var_0_10000

local var_0_0 = var_0_10000("CutFruitGameRunningData")

function var_0_0.Ctor(arg_1_0)
	return
end

function var_0_0.SetChapterConfig(arg_2_0, arg_2_1)
	arg_2_0._chapterConfig = arg_2_1

	return
end

function var_0_0.SetCharData(arg_3_0, arg_3_1)
	if arg_3_1 then
		local var_3_0

		if not arg_3_1.char or not arg_3_1.char then
			var_3_0 = arg_3_0._char
		end

		arg_3_0._char = var_3_0

		local var_3_1

		if not arg_3_1.npc or not arg_3_1.npc then
			var_3_1 = arg_3_0._npc
		end

		arg_3_0._npc = var_3_1
	end

	return
end

function var_0_0.GetConfig(arg_4_0, arg_4_1)
	return arg_4_0._chapterConfig[arg_4_1]
end

function var_0_0.GetChar(arg_5_0)
	return arg_5_0._char
end

function var_0_0.GetNpc(arg_6_0)
	return arg_6_0._npc
end

function var_0_0.Clear(arg_7_0)
	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0._tpl = nil
	arg_8_0._tplItemPool = {}

	return
end

return var_0_0
