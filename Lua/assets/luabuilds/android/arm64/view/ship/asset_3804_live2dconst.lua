local Live2dConst = class("Live2dConst")

Live2dConst.l2d_bound_open = false
Live2dConst.l2d_arm_32 = false
Live2dConst.UnLoadL2dPating = nil
Live2dConst.PAINTING_BGM_VOLUME = "painting_bgm_volume"

function Live2dConst:SaveL2dIdle(arg_1_1, arg_1_2)
	PlayerPrefs.SetInt(Live2dConst.GetL2dIdleSaveName(self, arg_1_1), arg_1_2)

	return
end

function Live2dConst:SaveL2dAction(arg_2_1, arg_2_2)
	PlayerPrefs.SetInt(Live2dConst.GetL2dActionSaveName(self, arg_2_1), arg_2_2)

	return
end

function Live2dConst:GetL2dIdleSaveName(arg_3_1)
	return "l2d_" .. tostring(self) .. "_" .. tostring(arg_3_1) .. "_idle_index"
end

function Live2dConst:GetL2dActionSaveName(arg_4_1)
	return "l2d_" .. tostring(self) .. "_" .. tostring(arg_4_1) .. "_action_id"
end

function Live2dConst:GetL2dSaveData(arg_5_1)
	local var_5_0 = PlayerPrefs.GetInt((Live2dConst.GetL2dIdleSaveName(self, arg_5_1)))
	local var_5_1 = PlayerPrefs.GetInt((Live2dConst.GetL2dActionSaveName(self, arg_5_1)))
end

function Live2dConst:SaveDragData(arg_6_1, arg_6_2, arg_6_3)
	PlayerPrefs.SetFloat(Live2dConst.GetDragSaveName(self, arg_6_1, arg_6_2), arg_6_3)

	return
end

function Live2dConst:GetDragData(arg_7_1, arg_7_2)
	return PlayerPrefs.GetFloat((Live2dConst.GetDragSaveName(self, arg_7_1, arg_7_2)))
end

function Live2dConst:GetDragSaveName(arg_8_1, arg_8_2)
	return "l2d_drag_" .. tostring(self) .. "_" .. tostring(arg_8_1) .. "_" .. tostring(arg_8_2) .. "_target"
end

function Live2dConst:SetDragActionIndex(arg_9_1, arg_9_2, arg_9_3)
	PlayerPrefs.SetInt(Live2dConst.GetDragActionIndexName(self, arg_9_1, arg_9_2), arg_9_3)

	return
end

function Live2dConst:GetDragActionIndex(arg_10_1, arg_10_2)
	local var_10_0 = PlayerPrefs.GetInt((Live2dConst.GetDragActionIndexName(self, arg_10_1, arg_10_2)))

	if not var_10_0 or var_10_0 <= 0 then
		var_10_0 = 1
	end

	return var_10_0
end

function Live2dConst:GetDragActionIndexName(arg_11_1, arg_11_2)
	return "l2d_drag_" .. tostring(self) .. "_" .. tostring(arg_11_1) .. "_" .. tostring(arg_11_2) .. "_action_index"
end

Live2dConst.RELATION_DRAG_X = "drag_x"
Live2dConst.RELATION_DRAG_Y = "drag_y"
Live2dConst.RELATION_DRAG_NAME_LIST = {
	Live2dConst.RELATION_DRAG_X,
	Live2dConst.RELATION_DRAG_Y
}

function Live2dConst:SetRelationData(arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = string.gsub(string.gsub(string.gsub(Live2dConst.GetRelationName(), "%$1", self), "%$2", arg_12_1), "%$3", arg_12_2)

	for iter_12_0 = 1, #Live2dConst.RELATION_DRAG_NAME_LIST do
		PlayerPrefs.SetFloat(var_12_0 .. Live2dConst.RELATION_DRAG_NAME_LIST[iter_12_0], arg_12_3[Live2dConst.RELATION_DRAG_NAME_LIST[iter_12_0]])
	end

	return
end

function Live2dConst:GetRelationData(arg_13_1, arg_13_2)
	local var_13_0 = string.gsub(string.gsub(string.gsub(Live2dConst.GetRelationName(), "%$1", self), "%$2", arg_13_1), "%$3", arg_13_2)
	local var_13_1 = {}

	for iter_13_0 = 1, #Live2dConst.RELATION_DRAG_NAME_LIST do
		var_13_1[Live2dConst.RELATION_DRAG_NAME_LIST[iter_13_0]] = PlayerPrefs.GetFloat(var_13_0 .. Live2dConst.RELATION_DRAG_NAME_LIST[iter_13_0]) ~= nil and PlayerPrefs.GetFloat(var_13_0 .. Live2dConst.RELATION_DRAG_NAME_LIST[iter_13_0]) or 0
	end

	return var_13_1
end

function Live2dConst:GetRelationName(arg_14_1, arg_14_2)
	return "l2d_relation_$1_$2_$3_"
end

function Live2dConst:ClearLive2dSave(arg_15_1)
	if not self or not arg_15_1 then
		warning("skinId 或 shipId 不能为空")

		return
	end

	if not pg.ship_skin_template[self] then
		warning("找不到skinId" .. tostring(self) .. " 清理失败")

		return
	end

	if ChangeSkinLink.L2D_PARAMETER_DIC[arg_15_1] then
		ChangeSkinLink.L2D_PARAMETER_DIC[arg_15_1] = {}
	end

	local var_15_0 = pg.ship_skin_template[self].ship_l2d_id

	if pg.ship_skin_template[self].ship_l2d_id and #var_15_0 > 0 then
		Live2dConst.SaveL2dIdle(self, arg_15_1, 0)
		Live2dConst.SaveL2dAction(self, arg_15_1, 0)

		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			if pg.ship_l2d[iter_15_1] then
				Live2dConst.SaveDragData(iter_15_1, self, arg_15_1, pg.ship_l2d[iter_15_1].start_value or 0)
				Live2dConst.SetDragActionIndex(iter_15_1, self, arg_15_1, 1)

				if pg.ship_l2d[iter_15_1].relation_parameter and pg.ship_l2d[iter_15_1].relation_parameter.list then
					local var_15_2 = string.gsub(string.gsub(string.gsub(Live2dConst.GetRelationName(), "%$1", iter_15_1), "%$2", self), "%$3", arg_15_1)

					for iter_15_2 = 1, #Live2dConst.RELATION_DRAG_NAME_LIST do
						PlayerPrefs.SetFloat(var_15_2 .. Live2dConst.RELATION_DRAG_NAME_LIST[iter_15_2], 0)
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

function Live2dConst.GetLive2DArm32MatchAble()
	if Live2dConst.l2d_arm_32 then
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

function Live2dConst.ShowLive2DArm32Tips()
	pg.TipsMgr.GetInstance():ShowTips(i18n("l2d_32xbanned_warning"))

	return
end

Live2dConst.l2d_dirty_data = {}

function Live2dConst:SetLive2dDirty(arg_18_1)
	Live2dConst.l2d_dirty_data[self .. "_" .. arg_18_1] = true

	return
end

function Live2dConst:GetLive2dDirty(arg_19_1, arg_19_2)
	if Live2dConst.l2d_dirty_data[self .. "_" .. arg_19_1] then
		if arg_19_2 then
			Live2dConst.l2d_dirty_data[self .. "_" .. arg_19_1] = false
		end

		return true
	end

	return false
end

function Live2dConst:SaveL2dBgmVolume(arg_20_1)
	if self and arg_20_1 then
		arg_20_1 = arg_20_1 > 1 and 1 or arg_20_1 < 0 and 0 or arg_20_1

		local var_20_0 = ShipSkin.IsChangeSkin(self) and ShipSkin.GetChangeSkinNextId(self) or nil

		if var_20_0 then
			PlayerPrefs.SetFloat(Live2dConst.PAINTING_BGM_VOLUME .. "_" .. var_20_0, arg_20_1)
		end

		PlayerPrefs.SetFloat(Live2dConst.PAINTING_BGM_VOLUME .. "_" .. self, arg_20_1)
	end

	return
end

function Live2dConst:GetPaintingBgmVolume()
	local var_21_0 = 1
	local var_21_1 = PlayerPrefs.GetFloat(Live2dConst.PAINTING_BGM_VOLUME .. "_" .. self)

	if var_21_1 ~= nil then
		var_21_0 = var_21_1
	end

	var_21_0 = var_21_0 > 1 and 1 or var_21_0 < 0 and 0 or var_21_0

	return var_21_0
end

return Live2dConst
