local Dorm3dIconHelper = class("Dorm3dIconHelper")

Dorm3dIconHelper.CAMERA_VOLUME = 1
Dorm3dIconHelper.CAMERA_FRAME = 2
Dorm3dIconHelper.DORM_STORY = 3

function Dorm3dIconHelper:UpdateDorm3dIcon(arg_1_1)
	local var_1_0 = Dorm3dIconHelper.Data2Config(arg_1_1)

	GetImageSpriteFromAtlasAsync("weaponframes", var_1_0.frame, self)
	GetImageSpriteFromAtlasAsync(var_1_0.icon, "", (self:Find("icon")))
	setText(self:Find("count/Text"), "x" .. var_1_0.count)
	setText(self:Find("name/Text"), var_1_0.name)

	return
end

function Dorm3dIconHelper:Data2Config()
	local var_2_0 = switch(self[1], {
		[Dorm3dIconHelper.CAMERA_VOLUME] = function()
			return {
				name = pg.dorm3d_camera_volume_template[self[2]].name,
				icon = pg.dorm3d_camera_volume_template[self[2]].icon,
				rarity = pg.dorm3d_camera_volume_template[self[2]].rarity,
				desc = pg.dorm3d_camera_volume_template[self[2]].desc
			}
		end,
		[Dorm3dIconHelper.CAMERA_FRAME] = function()
			return {
				name = pg.dorm3d_camera_photo_frame[self[2]].name,
				icon = pg.dorm3d_camera_photo_frame[self[2]].icon,
				rarity = pg.dorm3d_camera_photo_frame[self[2]].rarity,
				desc = pg.dorm3d_camera_photo_frame[self[2]].desc
			}
		end,
		[Dorm3dIconHelper.DORM_STORY] = function()
			return {
				name = pg.dorm3d_recall[self[2]].name,
				icon = "dorm3dicon/" .. pg.dorm3d_recall[self[2]].image .. "_icon",
				rarity = pg.dorm3d_recall[self[2]].rarity,
				desc = pg.dorm3d_recall[self[2]].desc
			}
		end
	})

	var_2_0.frame = "dorm3d_" .. (var_2_0.rarity and ItemRarity.Rarity2Print(var_2_0.rarity) or "2")
	var_2_0.count = self[3]

	return var_2_0
end

function Dorm3dIconHelper:SplitStory()
	local var_6_0 = {}
	local var_6_1

	for iter_6_0, iter_6_1 in pairs(self) do
		if iter_6_1[1] ~= Dorm3dIconHelper.DORM_STORY then
			table.insert(var_6_0, iter_6_1)
		else
			var_6_1 = iter_6_1
		end
	end

	return var_6_0, var_6_1
end

return Dorm3dIconHelper
