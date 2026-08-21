local var_0_0 = class("Dorm3dIconHelper")

var_0_0.CAMERA_VOLUME = 1
var_0_0.CAMERA_FRAME = 2
var_0_0.DORM_STORY = 3

function var_0_0.UpdateDorm3dIcon(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.Data2Config(arg_1_1)

	GetImageSpriteFromAtlasAsync("weaponframes", var_1_0.frame, arg_1_0)
	GetImageSpriteFromAtlasAsync(var_1_0.icon, "", (arg_1_0:Find("icon")))
	setText(arg_1_0:Find("count/Text"), "x" .. var_1_0.count)
	setText(arg_1_0:Find("name/Text"), var_1_0.name)

	return
end

function var_0_0.Data2Config(arg_2_0)
	local var_2_0 = switch(arg_2_0[1], {
		[var_0_0.CAMERA_VOLUME] = function()
			return {
				name = pg.dorm3d_camera_volume_template[arg_2_0[2]].name,
				icon = pg.dorm3d_camera_volume_template[arg_2_0[2]].icon,
				rarity = pg.dorm3d_camera_volume_template[arg_2_0[2]].rarity,
				desc = pg.dorm3d_camera_volume_template[arg_2_0[2]].desc
			}
		end,
		[var_0_0.CAMERA_FRAME] = function()
			return {
				name = pg.dorm3d_camera_photo_frame[arg_2_0[2]].name,
				icon = pg.dorm3d_camera_photo_frame[arg_2_0[2]].icon,
				rarity = pg.dorm3d_camera_photo_frame[arg_2_0[2]].rarity,
				desc = pg.dorm3d_camera_photo_frame[arg_2_0[2]].desc
			}
		end,
		[var_0_0.DORM_STORY] = function()
			return {
				name = pg.dorm3d_recall[arg_2_0[2]].name,
				icon = "dorm3dicon/" .. pg.dorm3d_recall[arg_2_0[2]].image .. "_icon",
				rarity = pg.dorm3d_recall[arg_2_0[2]].rarity,
				desc = pg.dorm3d_recall[arg_2_0[2]].desc
			}
		end
	})
	local var_2_1 = var_2_0.rarity and ItemRarity.Rarity2Print(var_2_0.rarity) or "2"

	var_2_0.frame = "dorm3d_" .. var_2_1
	var_2_0.count = arg_2_0[3]

	return var_2_0
end

function var_0_0.SplitStory(arg_6_0)
	local var_6_0

	for iter_6_0, iter_6_1 in pairs(arg_6_0) do
		if iter_6_1[1] ~= var_0_0.DORM_STORY then
			table.insert({}, iter_6_1)
		else
			var_6_0 = iter_6_1
		end
	end

	return {}, var_6_0
end

return var_0_0
