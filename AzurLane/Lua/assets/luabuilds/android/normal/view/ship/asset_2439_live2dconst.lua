class = var_0_10000

local var_0_0 = var_0_10000("Live2dConst")

var_0_0.l2d_bound_open = false
var_0_0.l2d_arm_32 = false
var_0_0.UnLoadL2dPating = nil
var_0_0.PAINTING_BGM_VOLUME = "painting_bgm_volume"

function var_0_0.SaveL2dIdle(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.GetL2dIdleSaveName(arg_1_0, arg_1_1)

	PlayerPrefs = var_4

	var_4.SetInt(var_1_0, arg_1_2)

	return
end

function var_0_0.SaveL2dAction(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = var_0_0.GetL2dActionSaveName(arg_2_0, arg_2_1)

	PlayerPrefs = var_4

	var_4.SetInt(var_2_0, arg_2_2)

	return
end

function var_0_0.GetL2dIdleSaveName(arg_3_0, arg_3_1)
	local var_3_0 = "l2d_"

	tostring = var_1_10003

	local var_3_1 = var_1_10003(arg_3_0)
	local var_3_2 = "_"

	tostring = var_1_10005

	return var_3_0 .. var_3_1 .. var_3_2 .. var_1_10005(arg_3_1) .. "_idle_index"
end

function var_0_0.GetL2dActionSaveName(arg_4_0, arg_4_1)
	local var_4_0 = "l2d_"

	tostring = var_1_10003

	local var_4_1 = var_1_10003(arg_4_0)
	local var_4_2 = "_"

	tostring = var_1_10005

	return var_4_0 .. var_4_1 .. var_4_2 .. var_1_10005(arg_4_1) .. "_action_id"
end

function var_0_0.GetL2dSaveData(arg_5_0, arg_5_1)
	local var_5_0 = var_0_0.GetL2dIdleSaveName(arg_5_0, arg_5_1)
	local var_5_1 = var_0_0.GetL2dActionSaveName(arg_5_0, arg_5_1)

	PlayerPrefs = var_4

	local var_5_2 = var_4.GetInt(var_5_0)

	PlayerPrefs = var_5

	local var_5_3 = var_5.GetInt(var_5_1)
end

function var_0_0.SaveDragData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = var_0_0.GetDragSaveName(arg_6_0, arg_6_1, arg_6_2)

	PlayerPrefs = var_5

	var_5.SetFloat(var_6_0, arg_6_3)

	return
end

function var_0_0.GetDragData(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = var_0_0.GetDragSaveName(arg_7_0, arg_7_1, arg_7_2)

	PlayerPrefs = var_4

	return var_4.GetFloat(var_7_0)
end

function var_0_0.GetDragSaveName(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = "l2d_drag_"

	tostring = var_1_10004

	local var_8_1 = var_1_10004(arg_8_0)
	local var_8_2 = "_"

	tostring = var_1_10006

	local var_8_3 = var_1_10006(arg_8_1)
	local var_8_4 = "_"

	tostring = var_1_10008

	return var_8_0 .. var_8_1 .. var_8_2 .. var_8_3 .. var_8_4 .. var_1_10008(arg_8_2) .. "_target"
end

function var_0_0.SetDragActionIndex(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = var_0_0.GetDragActionIndexName(arg_9_0, arg_9_1, arg_9_2)

	PlayerPrefs = var_5

	var_5.SetInt(var_9_0, arg_9_3)

	return
end

function var_0_0.GetDragActionIndex(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = var_0_0.GetDragActionIndexName(arg_10_0, arg_10_1, arg_10_2)

	PlayerPrefs = var_4

	local var_10_1

	if not var_4.GetInt(var_10_0) or var_10_1 <= 0 then
		var_10_1 = 1
	end

	return var_10_1
end

function var_0_0.GetDragActionIndexName(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = "l2d_drag_"

	tostring = var_1_10004

	local var_11_1 = var_1_10004(arg_11_0)
	local var_11_2 = "_"

	tostring = var_1_10006

	local var_11_3 = var_1_10006(arg_11_1)
	local var_11_4 = "_"

	tostring = var_1_10008

	return var_11_0 .. var_11_1 .. var_11_2 .. var_11_3 .. var_11_4 .. var_1_10008(arg_11_2) .. "_action_index"
end

var_0_0.RELATION_DRAG_X = "drag_x"
var_0_0.RELATION_DRAG_Y = "drag_y"
var_0_0.RELATION_DRAG_NAME_LIST = {
	var_0_0.RELATION_DRAG_X,
	var_0_0.RELATION_DRAG_Y
}

function var_0_0.SetRelationData(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = var_0_0.GetRelationName()

	string = var_1_10005

	local var_12_1 = var_1_10005.gsub(var_12_0, "%$1", arg_12_0)

	string = var_5

	local var_12_2 = var_5.gsub(var_12_1, "%$2", arg_12_1)

	string = var_5

	local var_12_3 = var_5.gsub(var_12_2, "%$3", arg_12_2)

	for iter_12_0 = 1, #var_0_0.RELATION_DRAG_NAME_LIST do
		local var_12_4 = var_0_0.RELATION_DRAG_NAME_LIST[iter_12_0]
		local var_12_5 = var_12_3 .. var_12_4

		PlayerPrefs = var_11

		var_11.SetFloat(var_12_5, arg_12_3[var_12_4])
	end

	return
end

function var_0_0.GetRelationData(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = var_0_0.GetRelationName()

	string = var_1_10004

	local var_13_1 = var_1_10004.gsub(var_13_0, "%$1", arg_13_0)

	string = var_4

	local var_13_2 = var_4.gsub(var_13_1, "%$2", arg_13_1)

	string = var_4

	local var_13_3 = var_4.gsub(var_13_2, "%$3", arg_13_2)
	local var_13_4 = {}

	for iter_13_0 = 1, #var_0_0.RELATION_DRAG_NAME_LIST do
		local var_13_5 = var_0_0.RELATION_DRAG_NAME_LIST[iter_13_0]
		local var_13_6 = var_13_3 .. var_13_5

		PlayerPrefs = var_11

		if var_11.GetFloat(var_13_6) ~= nil then
			PlayerPrefs = var_11

			local var_13_7

			if not var_11.GetFloat(var_13_6) then
				var_13_7 = 0
			end

			var_13_4[var_13_5] = var_13_7
		end
	end

	return var_13_4
end

function var_0_0.GetRelationName(arg_14_0, arg_14_1, arg_14_2)
	return "l2d_relation_$1_$2_$3_"
end

function var_0_0.ClearLive2dSave(arg_15_0, arg_15_1)
	if not arg_15_0 or not arg_15_1 then
		warning = var_1_10002

		var_1_10002("skinId 或 shipId 不能为空")

		return
	end

	pg = var_1_10002

	if not var_1_10002.ship_skin_template[arg_15_0] then
		warning = var_2
		var_1_10003 = "找不到skinId"
		tostring = var_1_10004

		var_2(var_1_10003 .. var_1_10004(arg_15_0) .. " 清理失败")

		return
	end

	ChangeSkinLink = var_2

	local var_15_0

	if var_2.L2D_PARAMETER_DIC[arg_15_1] then
		ChangeSkinLink = var_15_0
		var_15_0 = var_15_0.L2D_PARAMETER_DIC
		var_15_0[arg_15_1] = {}
	end

	pg = var_15_0

	if var_15_0.ship_skin_template[arg_15_0].ship_l2d_id and #var_2 > 0 then
		Live2dConst = var_1_10003

		var_1_10003.SaveL2dIdle(arg_15_0, arg_15_1, 0)

		Live2dConst = var_1_10003

		var_1_10003.SaveL2dAction(arg_15_0, arg_15_1, 0)

		ipairs = var_1_10003

		for iter_15_0, iter_15_1 in var_1_10003(var_2) do
			pg = var_1_10008

			if var_1_10008.ship_l2d[iter_15_1] then
				if not var_1_10008.start_value then
					var_1_10009 = 0
				end

				Live2dConst = var_1_10010

				var_1_10010.SaveDragData(iter_15_1, arg_15_0, arg_15_1, var_1_10009)

				Live2dConst = var_1_10010

				var_1_10010.SetDragActionIndex(iter_15_1, arg_15_0, arg_15_1, 1)

				if var_1_10008.relation_parameter and var_1_10008.relation_parameter.list then
					var_1_10010 = var_0_0.GetRelationName()
					string = var_11
					var_1_10010 = var_11.gsub(var_1_10010, "%$1", iter_15_1)
					string = var_11
					var_1_10010 = var_11.gsub(var_1_10010, "%$2", arg_15_0)
					string = var_11
					var_1_10010 = var_11.gsub(var_1_10010, "%$3", arg_15_1)

					for iter_15_2 = 1, #var_0_0.RELATION_DRAG_NAME_LIST do
						local var_15_1 = var_0_0.RELATION_DRAG_NAME_LIST[iter_15_2]
						local var_15_2 = var_1_10010 .. var_15_1

						PlayerPrefs = var_17

						var_17.SetFloat(var_15_2, 0)
					end
				end
			else
				warning = var_1_10009
				tostring = var_1_10010

				var_1_10009(var_1_10010(iter_15_1) .. "不存在，不清理该dragid")
			end
		end
	end

	pg = var_1_10003

	local var_15_3 = var_1_10003.TipsMgr.GetInstance()
	local var_15_4 = var_3.ShowTips

	i18n = var_1_10005

	var_15_4(var_15_3, var_1_10005("live2d_reset_desc"))

	return
end

function var_0_0.GetLive2DArm32MatchAble()
	if var_0_0.l2d_arm_32 then
		return true
	end

	PermissionHelper = var_0

	if var_0.IsAndroid() then
		Application = var_0

		local var_16_0 = var_0.dataPath
		local var_16_1 = var_0.gsub(var_16_0, "/base%.apk/assets$", "")
		local var_16_2 = var_0.gsub(var_16_1, "/assets$", "")
		local var_16_3 = var_0.gsub(var_16_2, "/[^/]+$", "/lib/") .. "arm"

		System = var_3

		if var_3.IO.Directory.Exists(var_16_3) then
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
	pg = var_1_10000

	local var_17_0 = var_1_10000.TipsMgr.GetInstance()
	local var_17_1 = var_0.ShowTips

	i18n = var_1_10002

	var_17_1(var_17_0, var_1_10002("l2d_32xbanned_warning"))

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
		arg_20_1 = 1 < arg_20_1 and 1 or arg_20_1 < 0 and 0 or arg_20_1
		ShipSkin = var_2

		if var_2.IsChangeSkin(arg_20_0) then
			ShipSkin = var_3

			local var_20_0

			if not var_3.GetChangeSkinNextId(arg_20_0) then
				var_20_0 = nil
			end

			if var_20_0 then
				PlayerPrefs = var_1_10004
				var_1_10004 = var_1_10004.SetFloat
				Live2dConst = var_1_10005

				var_1_10004(var_1_10005.PAINTING_BGM_VOLUME .. "_" .. var_20_0, arg_20_1)
			end

			PlayerPrefs = var_1_10004

			local var_20_1 = var_1_10004.SetFloat

			Live2dConst = var_1_10005

			var_20_1(var_1_10005.PAINTING_BGM_VOLUME .. "_" .. arg_20_0, arg_20_1)

			return
		end
	end
end

function var_0_0.GetPaintingBgmVolume(arg_21_0)
	local var_21_0 = 1

	PlayerPrefs = var_1_10002

	local var_21_1 = var_1_10002.GetFloat

	Live2dConst = var_1_10003

	if var_21_1(var_1_10003.PAINTING_BGM_VOLUME .. "_" .. arg_21_0) ~= nil then
		var_21_0 = var_2
	end

	var_21_0 = var_21_0 > 1 and 1 or var_21_0 < 0 and 0 or var_21_0

	return var_21_0
end

return var_0_0
