class = var_0_10000

local var_0_0 = var_0_10000("Dorm3dIconHelper")

var_0_0.CAMERA_VOLUME = 1
var_0_0.CAMERA_FRAME = 2
var_0_0.DORM_STORY = 3

function var_0_0.UpdateDorm3dIcon(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.Data2Config(arg_1_1)

	GetImageSpriteFromAtlasAsync = var_1_10003

	var_1_10003("weaponframes", var_1_0.frame, arg_1_0)

	local var_1_1 = arg_1_0:Find("icon")

	GetImageSpriteFromAtlasAsync = var_4

	var_4(var_1_0.icon, "", var_1_1)

	setText = var_4

	var_4(arg_1_0:Find("count/Text"), "x" .. var_1_0.count)

	setText = var_4

	var_4(arg_1_0:Find("name/Text"), var_1_0.name)

	return
end

function var_0_0.Data2Config(arg_2_0)
	switch = var_1_10001

	local var_2_0 = var_1_10001(arg_2_0[1], {
		[var_0_0.CAMERA_VOLUME] = function()
			pg = var_2_10000

			local var_3_0 = var_2_10000.dorm3d_camera_volume_template[arg_2_0[2]]

			return {
				name = var_3_0.name,
				icon = var_3_0.icon,
				rarity = var_3_0.rarity,
				desc = var_3_0.desc
			}
		end,
		[var_0_0.CAMERA_FRAME] = function()
			pg = var_2_10000

			local var_4_0 = var_2_10000.dorm3d_camera_photo_frame[arg_2_0[2]]

			return {
				name = var_4_0.name,
				icon = var_4_0.icon,
				rarity = var_4_0.rarity,
				desc = var_4_0.desc
			}
		end,
		[var_0_0.DORM_STORY] = function()
			pg = var_2_10000

			local var_5_0 = var_2_10000.dorm3d_recall[arg_2_0[2]]

			return {
				name = var_5_0.name,
				icon = "dorm3dicon/" .. var_5_0.image .. "_icon",
				rarity = var_5_0.rarity,
				desc = var_5_0.desc
			}
		end
	})
	local var_2_1 = "dorm3d_"

	if var_2_0.rarity then
		ItemRarity = var_3

		local var_2_2

		if not var_3.Rarity2Print(var_2_0.rarity) then
			var_2_2 = "2"
		end

		var_2_0.frame = var_2_1 .. var_2_2
		var_2_0.count = arg_2_0[3]

		return var_2_0
	end
end

function var_0_0.SplitStory(arg_6_0)
	local var_6_0 = {}
	local var_6_1

	pairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(arg_6_0) do
		if iter_6_1[1] ~= var_0_0.DORM_STORY then
			table = var_8

			var_8.insert(var_6_0, iter_6_1)
		else
			var_6_1 = iter_6_1
		end
	end

	return var_6_0, var_6_1
end

return var_0_0
