local var_0_0 = {}
local var_0_1 = g.core.config.knight_info
local var_0_2 = g.core.config.knight_base_info
local var_0_3 = table.concat

function var_0_0.getKnightFullPic(arg_1_0)
	return var_0_3({
		"pic/knight_painted/",
		var_0_2.get(var_0_1.get(arg_1_0).res_id).painted_id,
		".png"
	})
end

function var_0_0.getEffectPath(arg_2_0)
	return var_0_3({
		"effect/",
		arg_2_0,
		"/",
		arg_2_0
	})
end

function var_0_0.getActionPath(arg_3_0)
	return var_0_3({
		"action/",
		arg_3_0
	})
end

function var_0_0.getSpineResPath(arg_4_0)
	return var_0_3({
		arg_4_0,
		".skel"
	}), var_0_3({
		arg_4_0,
		".atlas"
	})
end

function var_0_0.getSpineJsonPath(arg_5_0)
	return var_0_3({
		arg_5_0,
		".json"
	})
end

function var_0_0.getSpineEffectPath(arg_6_0)
	return var_0_3({
		"battle/effect_spine/",
		arg_6_0,
		"/",
		arg_6_0
	})
end

function var_0_0.getSpineBuffPath(arg_7_0)
	return var_0_3({
		"battle/buff_spine/",
		arg_7_0,
		"/",
		arg_7_0
	})
end

function var_0_0.getSpineAttrPath(arg_8_0)
	return var_0_3({
		"battle/attr_spine/",
		arg_8_0,
		"/",
		arg_8_0
	})
end

function var_0_0.getSpineAttrPath(arg_9_0)
	return var_0_3({
		"battle/attr_spine/",
		arg_9_0,
		"/",
		arg_9_0
	})
end

function var_0_0.getSpineKnightPath(arg_10_0)
	return var_0_3({
		"battle/knight_spine/",
		arg_10_0,
		"/",
		arg_10_0
	})
end

function var_0_0.getSpineTweenPath(arg_11_0)
	return var_0_3({
		"battle/tween/",
		arg_11_0
	})
end

function var_0_0.getSpineEffectGroupPath(arg_12_0)
	local var_12_0 = var_0_3({
		"battle/effect_spine_group/",
		arg_12_0,
		".json"
	})

	if not cc.FileUtils:getInstance():isFileExist(var_12_0) then
		g.core.platform.BuglyProxy:error(string.format("Error! 战斗的攻击特效组文件不存在 %s", tostring(arg_12_0)))
		assert(false, "战斗的攻击特效组文件不存在:" .. arg_12_0)
	end

	return var_12_0
end

function var_0_0.getBattleDataPath(arg_13_0)
	return var_0_3({
		"/src/app/view/battle/test/",
		arg_13_0,
		".lua"
	})
end

function var_0_0.getBuffSpinePath(arg_14_0, arg_14_1)
	return var_0_3({
		"battle/buff_icon/",
		arg_14_1,
		".png"
	})
end

function var_0_0.getUniteIconPath(arg_15_0)
	if arg_15_0 then
		return var_0_3({
			"battle/unite_icon/",
			arg_15_0,
			".png"
		})
	end
end

function var_0_0.getBossIconPath(arg_16_0)
	if arg_16_0 then
		return var_0_3({
			"icon/avatar/",
			arg_16_0,
			".png"
		})
	end
end

function var_0_0.getSkillIconPath(arg_17_0)
	if arg_17_0 then
		return var_0_3({
			"icon/skill/",
			arg_17_0,
			".png"
		})
	end
end

function var_0_0.getAngerImgByQuality(arg_18_0, arg_18_1)
	arg_18_1 = arg_18_1 or 0
	arg_18_1 = arg_18_1 + 2

	if arg_18_1 >= 2 then
		return var_0_3({
			"battle/common/icon_nuqi_",
			arg_18_1,
			".png"
		})
	end

	return "battle/common/icon_nuqi_3.png"
end

function var_0_0.getWeaponEffectByName(arg_19_0, arg_19_1)
	if not arg_19_1 then
		return
	end

	return var_0_3({
		"battle/knight_weapon/",
		arg_19_1,
		"/",
		arg_19_1
	})
end

function var_0_0.getSkillIcon(arg_20_0, arg_20_1)
	if not arg_20_1 then
		return
	end

	return var_0_3({
		"icon/skill/",
		arg_20_1,
		".png"
	})
end

return var_0_0
