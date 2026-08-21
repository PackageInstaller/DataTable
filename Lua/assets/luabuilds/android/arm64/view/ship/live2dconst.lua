local var_0_0 = class("Live2dConst")

var_0_0.l2d_bound_open = false
var_0_0.l2d_arm_32 = false
var_0_0.UnLoadL2dPating = nil
var_0_0.PAINTING_BGM_VOLUME = "painting_bgm_volume"

function var_0_0.SaveL2dIdle(arg_1_0, arg_1_1, arg_1_2)
	PlayerPrefs.SetInt(var_0_0.GetL2dIdleSaveName(arg_1_0, arg_1_1), arg_1_2)

	return
end

function var_0_0.SaveL2dAction(arg_2_0, arg_2_1, arg_2_2)
	PlayerPrefs.SetInt(var_0_0.GetL2dActionSaveName(arg_2_0, arg_2_1), arg_2_2)

	return
end

function var_0_0.GetL2dIdleSaveName(arg_3_0, arg_3_1)
	return "l2d_" .. tostring(arg_3_0) .. "_" .. tostring(arg_3_1) .. "_idle_index"
end

function var_0_0.GetL2dActionSaveName(arg_4_0, arg_4_1)
	return "l2d_" .. tostring(arg_4_0) .. "_" .. tostring(arg_4_1) .. "_action_id"
end

function var_0_0.GetL2dSaveData(arg_5_0, arg_5_1)
	local var_5_0 = PlayerPrefs.GetInt((var_0_0.GetL2dIdleSaveName(arg_5_0, arg_5_1)))
	local var_5_1 = PlayerPrefs.GetInt((var_0_0.GetL2dActionSaveName(arg_5_0, arg_5_1)))
end

function var_0_0.SaveDragData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	PlayerPrefs.SetFloat(var_0_0.GetDragSaveName(arg_6_0, arg_6_1, arg_6_2), arg_6_3)

	return
end

function var_0_0.GetDragData(arg_7_0, arg_7_1, arg_7_2)
	return PlayerPrefs.GetFloat((var_0_0.GetDragSaveName(arg_7_0, arg_7_1, arg_7_2)))
end

function var_0_0.GetDragSaveName(arg_8_0, arg_8_1, arg_8_2)
	return "l2d_drag_" .. tostring(arg_8_0) .. "_" .. tostring(arg_8_1) .. "_" .. tostring(arg_8_2) .. "_target"
end

function var_0_0.SetDragActionIndex(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	PlayerPrefs.SetInt(var_0_0.GetDragActionIndexName(arg_9_0, arg_9_1, arg_9_2), arg_9_3)

	return
end

function var_0_0.GetDragActionIndex(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = PlayerPrefs.GetInt((var_0_0.GetDragActionIndexName(arg_10_0, arg_10_1, arg_10_2)))

	if not var_10_0 or var_10_0 <= 0 then
		var_10_0 = 1
	end

	return var_10_0
end

function var_0_0.GetDragActionIndexName(arg_11_0, arg_11_1, arg_11_2)
	return "l2d_drag_" .. tostring(arg_11_0) .. "_" .. tostring(arg_11_1) .. "_" .. tostring(arg_11_2) .. "_action_index"
end

var_0_0.RELATION_DRAG_X = "drag_x"
var_0_0.RELATION_DRAG_Y = "drag_y"
var_0_0.RELATION_DRAG_NAME_LIST = {
	var_0_0.RELATION_DRAG_X,
	var_0_0.RELATION_DRAG_Y
}

function var_0_0.SetRelationData(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = string.gsub(string.gsub(string.gsub(var_0_0.GetRelationName(), "%$1", arg_12_0), "%$2", arg_12_1), "%$3", arg_12_2)

	for iter_12_0 = 1, #var_0_0.RELATION_DRAG_NAME_LIST do
		PlayerPrefs.SetFloat(var_12_0 .. var_0_0.RELATION_DRAG_NAME_LIST[iter_12_0], arg_12_3[var_0_0.RELATION_DRAG_NAME_LIST[iter_12_0]])
	end

	return
end

function var_0_0.GetRelationData(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = string.gsub(string.gsub(string.gsub(var_0_0.GetRelationName(), "%$1", arg_13_0), "%$2", arg_13_1), "%$3", arg_13_2)
	local var_13_1 = {}

	for iter_13_0 = 1, #var_0_0.RELATION_DRAG_NAME_LIST do
		var_13_1[var_0_0.RELATION_DRAG_NAME_LIST[iter_13_0]] = PlayerPrefs.GetFloat(var_13_0 .. var_0_0.RELATION_DRAG_NAME_LIST[iter_13_0]) ~= nil and PlayerPrefs.GetFloat(var_13_0 .. var_0_0.RELATION_DRAG_NAME_LIST[iter_13_0]) or 0
	end

	return var_13_1
end

function var_0_0.GetRelationName(arg_14_0, arg_14_1, arg_14_2)
	return "l2d_relation_$1_$2_$3_"
end

function var_0_0.ClearLive2dSave(arg_15_0, arg_15_1)
	if not arg_15_0 or not arg_15_1 then
		warning("skinId 或 shipId 不能为空")

		return
	end

	if not pg.ship_skin_template[arg_15_0] then
		warning("找不到skinId" .. tostring(arg_15_0) .. " 清理失败")

		return
	end

	if ChangeSkinLink.L2D_PARAMETER_DIC[arg_15_1] then
		ChangeSkinLink.L2D_PARAMETER_DIC[arg_15_1] = {}
	end

	local var_15_0 = pg.ship_skin_template[arg_15_0].ship_l2d_id

	if pg.ship_skin_template[arg_15_0].ship_l2d_id and #var_15_0 > 0 then
		Live2dConst.SaveL2dIdle(arg_15_0, arg_15_1, 0)
		Live2dConst.SaveL2dAction(arg_15_0, arg_15_1, 0)

		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			if pg.ship_l2d[iter_15_1] then
				local var_15_1 = pg.ship_l2d[iter_15_1].start_value or 0

				Live2dConst.SaveDragData(iter_15_1, arg_15_0, arg_15_1, var_15_1)
				Live2dConst.SetDragActionIndex(iter_15_1, arg_15_0, arg_15_1, 1)

				if pg.ship_l2d[iter_15_1].relation_parameter and pg.ship_l2d[iter_15_1].relation_parameter.list then
					local var_15_2 = string.gsub(string.gsub(string.gsub(var_0_0.GetRelationName(), "%$1", iter_15_1), "%$2", arg_15_0), "%$3", arg_15_1)

					for iter_15_2 = 1, #var_0_0.RELATION_DRAG_NAME_LIST do
						PlayerPrefs.SetFloat(var_15_2 .. var_0_0.RELATION_DRAG_NAME_LIST[iter_15_2], 0)
					end
				end
			else
				warning(tostring(iter_15_1) .. "不存在，不清理该dragid")
			end
		end
	end

	pg.TipsMgr.GetInstance():ShowTips(i18n("live2d_reset_desc"))

	return
end

function var_0_0.GetLive2DArm32MatchAble()
	if var_0_0.l2d_arm_32 then
		return true
	end

	if PermissionHelper.IsAndroid() then
		if System.IO.Directory.Exists(Application.dataPath:gsub("/base%.apk/assets$", ""):gsub("/assets$", ""):gsub("/[^/]+$", "/lib/") .. "arm") then
			return true
		else
			return false
		end
	else
		return false
	end

	return
end

function var_0_0.ShowLive2DArm32Tips()
	pg.TipsMgr.GetInstance():ShowTips(i18n("l2d_32xbanned_warning"))

	return
end

var_0_0.l2d_dirty_data = {}

function var_0_0.SetLive2dDirty(arg_18_0, arg_18_1)
	var_0_0.l2d_dirty_data[arg_18_0 .. "_" .. arg_18_1] = true

	return
end

function var_0_0.GetLive2dDirty(arg_19_0, arg_19_1, arg_19_2)
	if var_0_0.l2d_dirty_data[arg_19_0 .. "_" .. arg_19_1] then
		if arg_19_2 then
			var_0_0.l2d_dirty_data[arg_19_0 .. "_" .. arg_19_1] = false
		end

		return true
	end

	return false
end

function var_0_0.SaveL2dBgmVolume(arg_20_0, arg_20_1)
	if arg_20_0 and arg_20_1 then
		arg_20_1 = arg_20_1 > 1 and 1 or arg_20_1 < 0 and 0 or arg_20_1

		local var_20_0 = ShipSkin.IsChangeSkin(arg_20_0) and ShipSkin.GetChangeSkinNextId(arg_20_0) or nil

		if var_20_0 then
			PlayerPrefs.SetFloat(Live2dConst.PAINTING_BGM_VOLUME .. "_" .. var_20_0, arg_20_1)
		end

		PlayerPrefs.SetFloat(Live2dConst.PAINTING_BGM_VOLUME .. "_" .. arg_20_0, arg_20_1)
	end

	return
end

function var_0_0.GetPaintingBgmVolume(arg_21_0)
	local var_21_0 = 1
	local var_21_1 = PlayerPrefs.GetFloat(Live2dConst.PAINTING_BGM_VOLUME .. "_" .. arg_21_0)

	if var_21_1 ~= nil then
		var_21_0 = var_21_1
	end

	var_21_0 = var_21_0 > 1 and 1 or var_21_0 < 0 and 0 or var_21_0

	return var_21_0
end

return var_0_0
