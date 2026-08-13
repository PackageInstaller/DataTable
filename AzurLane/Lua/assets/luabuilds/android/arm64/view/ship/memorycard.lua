class = var_0_10000

local var_0_0 = var_0_10000("MemoryCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tf = arg_1_1.transform
	findTF = var_2
	arg_1_0.lock = var_2(arg_1_0.tf, "lock")
	findTF = var_2
	arg_1_0.txCondition = var_2(arg_1_0.lock, "condition")
	findTF = var_2
	arg_1_0.normal = var_2(arg_1_0.tf, "normal")
	findTF = var_2
	arg_1_0.txTitle = var_2(arg_1_0.normal, "title")
	findTF = var_2
	arg_1_0.txSubtitle = var_2(arg_1_0.normal, "subtitle")
	findTF = var_2
	arg_1_0.group = var_2(arg_1_0.tf, "group")
	findTF = var_2
	arg_1_0.groupTitle = var_2(arg_1_0.group, "title")
	findTF = var_2
	arg_1_0.groupCount = var_2(arg_1_0.group, "count")
	findTF = var_2
	arg_1_0.itemIndexTF = var_2(arg_1_0.tf, "id")

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.isGroup = arg_2_1
	arg_2_0.info = arg_2_2

	arg_2_0:flush()

	return
end

function var_0_0.flush(arg_3_0)
	setActive = var_1_10001

	var_1_10001(arg_3_0.lock, false)

	setActive = var_1_10001

	var_1_10001(arg_3_0.normal, false)

	setActive = var_1_10001

	var_1_10001(arg_3_0.group, false)

	if arg_3_0.isGroup then
		setActive = var_1

		var_1(arg_3_0.group, true)

		setText = var_1

		var_1(arg_3_0.groupTitle, arg_3_0.info.title)

		GetImageSpriteFromAtlasAsync = var_1

		var_1("memoryicon/" .. arg_3_0.info.icon, "", arg_3_0.group)

		local var_3_0 = 0
		local var_3_1 = #arg_3_0.info.memories

		ipairs = var_3

		for iter_3_0, iter_3_1 in var_3(arg_3_0.info.memories) do
			pg = var_1_10008

			if var_1_10008.memory_template[iter_3_1].is_open ~= 1 then
				pg = var_9

				local var_3_2 = var_9.NewStoryMgr.GetInstance()

				if var_9.IsPlayed(var_3_2, var_1_10008.unlock_pre, true) then
					var_3_0 = var_3_0 + 1
				end
			end
		end

		setText = var_3

		var_3(arg_3_0.groupCount, var_3_0 .. "/" .. var_3_1)

		goto label_3_0
	end

	if arg_3_0.info.is_open ~= 1 then
		pg = var_1

		do
			local var_3_3 = var_1.NewStoryMgr.GetInstance()

			if var_1.IsPlayed(var_3_3, arg_3_0.info.unlock_pre, true) then
				setActive = var_1

				var_1(arg_3_0.normal, true)

				setText = var_1

				var_1(arg_3_0.txTitle, arg_3_0.info.title)

				setText = var_1

				var_1(arg_3_0.txSubtitle, arg_3_0.info.subtitle)

				GetImageSpriteFromAtlasAsync = var_1

				var_1("memoryicon/" .. arg_3_0.info.icon, "", arg_3_0.normal)
			else
				setActive = var_1

				var_1(arg_3_0.lock, true)

				setText = var_1

				var_1(arg_3_0.txCondition, arg_3_0.info.condition)
			end
		end

		::label_3_0::

		if arg_3_0.itemIndexTF then
			setActive = var_1

			var_1(arg_3_0.itemIndexTF, not arg_3_0.isGroup)

			if not arg_3_0.isGroup and arg_3_0.info.index then
				setText = var_1

				local var_3_4 = arg_3_0.itemIndexTF

				string = var_4

				var_1(var_3_4, var_4.format("%02u", arg_3_0.info.index))
			end
		end

		return
	end
end

function var_0_0.clear(arg_4_0)
	return
end

return var_0_0
