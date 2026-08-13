class = var_0_10000

local var_0_0 = var_0_10000("ChangeSkinLink")

var_0_0.L2D_SAVE_TEMPLATE_DISPOSE = {
	705022,
	705023,
	107102,
	107103
}
var_0_0.L2D_PARAMETER_DIC = {}
var_0_0.L2D_TYPE = 1
var_0_0.SPINE_TYPE = 2
var_0_0.change_parameter_link_skin = 1
var_0_0.change_parameter_link_slot = 2

function var_0_0.GetSaveL2dData(arg_1_0, arg_1_1)
	local var_1_0 = {}
	local var_1_1 = {}

	pg = var_1_10004

	if var_1_10004.ship_skin_template[arg_1_1].ship_l2d_id then
		pg = var_4

		if #var_4.ship_skin_template[arg_1_1].ship_l2d_id > 0 then
			pg = var_4
			var_1_1 = var_4.ship_skin_template[arg_1_1].ship_l2d_id
		end
	end

	ipairs = var_4

	for iter_1_0, iter_1_1 in var_4(var_1_1) do
		pg = var_1_10009

		if var_1_10009.ship_l2d[iter_1_1] then
			pg = var_1_10009

			if var_1_10009.ship_l2d[iter_1_1].parameter and #var_1_10009 > 0 then
				Live2dConst = var_10
				var_1_0[var_1_10009] = var_10.GetDragData(iter_1_1, arg_1_1, arg_1_0)
			end
		else
			print = var_1_10009

			var_1_10009(iter_1_1 == "not exit dragId")
		end
	end

	return var_1_0
end

var_0_0.CHANGE_SKIN_LINK_DATA = {
	[499024] = {
		link_id = 499023,
		type = var_0_0.SPINE_TYPE,
		link_type = var_0_0.L2D_TYPE,
		relations = {
			{
				skeleton_skin = "1",
				type = var_0_0.change_parameter_link_skin,
				link_parameter = {
					{
						num = 0,
						name = "touch_drag1",
						match = true
					}
				}
			},
			{
				skeleton_skin = "2",
				type = var_0_0.change_parameter_link_skin,
				link_parameter = {
					{
						num = 1,
						name = "touch_drag1",
						match = true
					}
				}
			}
		}
	},
	[107103] = {
		link_id = 107102,
		type = var_0_0.SPINE_TYPE,
		link_type = var_0_0.L2D_TYPE,
		relations = {
			{
				skeleton_skin = "1",
				type = var_0_0.change_parameter_link_skin,
				link_parameter = {
					{
						num = 1,
						name = "touch_drag1",
						match = true
					},
					{
						num = 1,
						name = "touch_drag2",
						match = true
					}
				}
			},
			{
				skeleton_skin = "2",
				type = var_0_0.change_parameter_link_skin,
				link_parameter = {
					{
						num = 0,
						name = "touch_drag1",
						match = true
					},
					{
						num = 0,
						name = "touch_drag1",
						match = true
					}
				}
			},
			{
				skeleton_skin = "3",
				type = var_0_0.change_parameter_link_skin,
				link_parameter = {
					{
						num = 1,
						name = "touch_drag1",
						match = true
					},
					{
						num = 0,
						name = "touch_drag2",
						match = true
					}
				}
			}
		}
	},
	[705023] = {
		link_id = 705022,
		type = var_0_0.SPINE_TYPE,
		link_type = var_0_0.L2D_TYPE,
		relations = {
			{
				type = var_0_0.change_parameter_link_slot,
				link_parameter = {
					{
						num = 0,
						name = "touch_drag7",
						match = true
					},
					{
						num = 0,
						name = "touch_drag1",
						match = true
					},
					{
						num = 0,
						name = "touch_drag2",
						match = true
					}
				},
				slot_list = {
					{
						"shenti_3",
						"ab_sync_0_shenti_3"
					},
					{
						"shenti_3_2",
						"ab_sync_0_shenti_3_2"
					},
					{
						"zuodatui_1",
						"ab_sync_0_zuodatui_1"
					},
					{
						"zuodatui_1_2",
						"ab_sync_0_zuodatui_1_2"
					},
					{
						"shenti_1",
						"ab_sync_0_shenti_1"
					},
					{
						"shenti_1_2",
						"ab_sync_0_shenti_1_2"
					},
					{
						"zuoxiong_1_3",
						"ab_sync_0_zuoxiong_1_2"
					},
					{
						"zuoxiong_2",
						"ab_sync_0_zuoxiong_1"
					},
					{
						"zuidabi_3_3",
						"ab_sync_0_zuidabi_3_2"
					},
					{
						"zuidabi_4",
						"ab_sync_0_zuidabi_3"
					},
					{
						"youxiong_1",
						"ab_sync_0_youxiong_1"
					},
					{
						"youxiong_1_2",
						"ab_sync_0_youxiong_1_2"
					},
					{
						"zuidabi_3_4",
						"ab_sync_0_zuidabi_3_2"
					},
					{
						"zuidabi_7",
						"ab_sync_0_zuidabi_3"
					},
					{
						"zuoxiong_1",
						"ab_sync_0_zuoxiong_1"
					},
					{
						"zuoxiong_1_2",
						"ab_sync_0_zuoxiong_1_2"
					},
					{
						"zuidabi_3",
						"ab_sync_0_zuidabi_3"
					},
					{
						"zuidabi_3_2",
						"ab_sync_0_zuidabi_3_2"
					},
					{
						"shenti_3_3",
						"ab_sync_0_shenti_3_2"
					},
					{
						"shenti_6",
						"ab_sync_0_shenti_3"
					},
					{
						"zuodatui_1_3",
						"ab_sync_0_zuodatui_1_2"
					},
					{
						"zuodatui_6",
						"ab_sync_0_zuodatui_1"
					},
					{
						"shenti_1_3",
						"ab_sync_0_shenti_1_2"
					},
					{
						"shenti_4",
						"ab_sync_0_shenti_1"
					},
					{
						"youxiong_1_3",
						"ab_sync_0_youxiong_1_2"
					},
					{
						"youxiong_2",
						"ab_sync_0_youxiong_1"
					},
					{
						"youbi_2",
						"ab_sync_0_youbi_2"
					},
					{
						"2_datuiL_2",
						"2_ab_sync_0_datuiL_2"
					},
					{
						"2_shenti_2",
						"2_ab_sync_0_shenti_2"
					},
					{
						"2_datuiR_2",
						"2_ab_sync_0_datuiR_2"
					},
					{
						"2_shoubiR_1",
						"2_ab_sync_0_shoubiR_1"
					}
				}
			},
			{
				type = var_0_0.change_parameter_link_slot,
				link_parameter = {
					{
						num = 1,
						name = "touch_drag7",
						match = true
					},
					{
						num = 0,
						name = "touch_drag1",
						match = true
					},
					{
						num = 0,
						name = "touch_drag2",
						match = true
					}
				},
				slot_list = {
					{
						"shenti_3",
						"ab_sync_0_1_shenti_3"
					},
					{
						"shenti_3_2",
						"ab_sync_0_1_shenti_3_2"
					},
					{
						"zuodatui_1",
						"ab_sync_0_1_zuodatui_1"
					},
					{
						"zuodatui_1_2",
						"ab_sync_0_1_zuodatui_1_2"
					},
					{
						"shenti_1",
						"ab_sync_0_1_shenti_1"
					},
					{
						"shenti_1_2",
						"ab_sync_0_1_shenti_1_2"
					},
					{
						"zuoxiong_1_3",
						"ab_sync_0_1_zuoxiong_1_2"
					},
					{
						"zuoxiong_2",
						"ab_sync_0_1_zuoxiong_1"
					},
					{
						"zuidabi_3_3",
						"ab_sync_0_1_zuidabi_3_2"
					},
					{
						"zuidabi_4",
						"ab_sync_0_1_zuidabi_3"
					},
					{
						"youxiong_1",
						"ab_sync_0_1_youxiong_1"
					},
					{
						"youxiong_1_2",
						"ab_sync_0_1_youxiong_1_2"
					},
					{
						"zuidabi_3_4",
						"ab_sync_0_1_zuidabi_3_2"
					},
					{
						"zuidabi_7",
						"ab_sync_0_1_zuidabi_3"
					},
					{
						"zuoxiong_1",
						"ab_sync_0_1_zuoxiong_1"
					},
					{
						"zuoxiong_1_2",
						"ab_sync_0_1_zuoxiong_1_2"
					},
					{
						"zuidabi_3",
						"ab_sync_0_1_zuidabi_3"
					},
					{
						"zuidabi_3_2",
						"ab_sync_0_1_zuidabi_3_2"
					},
					{
						"shenti_3_3",
						"ab_sync_0_1_shenti_3_2"
					},
					{
						"shenti_6",
						"ab_sync_0_1_shenti_3"
					},
					{
						"zuodatui_1_3",
						"ab_sync_0_1_zuodatui_1_2"
					},
					{
						"zuodatui_6",
						"ab_sync_0_1_zuodatui_1"
					},
					{
						"shenti_1_3",
						"ab_sync_0_1_shenti_1_2"
					},
					{
						"shenti_4",
						"ab_sync_0_1_shenti_1"
					},
					{
						"youxiong_1_3",
						"ab_sync_0_1_youxiong_1_2"
					},
					{
						"youxiong_2",
						"ab_sync_0_1_youxiong_1"
					},
					{
						"youbi_2",
						"ab_sync_0_1_youbi_2"
					},
					{
						"2_datuiL_2",
						"2_ab_sync_0_1_datuiL_2"
					},
					{
						"2_shenti_2",
						"2_ab_sync_0_1_shenti_2"
					},
					{
						"2_datuiR_2",
						"2_ab_sync_0_1_datuiR_2"
					},
					{
						"2_shoubiR_1",
						"2_ab_sync_0_1_shoubiR_1"
					}
				}
			},
			{
				type = var_0_0.change_parameter_link_slot,
				link_parameter = {
					{
						num = 0,
						name = "touch_drag7",
						match = true
					},
					{
						num = 1,
						name = "touch_drag1",
						match = true
					},
					{
						num = 0,
						name = "touch_drag2",
						match = true
					}
				},
				slot_list = {
					{
						"shenti_3",
						"ab_sync_1_shenti_3"
					},
					{
						"shenti_3_2",
						"ab_sync_1_shenti_3_2"
					},
					{
						"zuodatui_1",
						"ab_sync_1_zuodatui_1"
					},
					{
						"zuodatui_1_2",
						"ab_sync_1_zuodatui_1_2"
					},
					{
						"shenti_1",
						"ab_sync_1_shenti_1"
					},
					{
						"shenti_1_2",
						"ab_sync_1_shenti_1_2"
					},
					{
						"zuoxiong_1_3",
						"ab_sync_1_zuoxiong_1_2"
					},
					{
						"zuoxiong_2",
						"ab_sync_1_zuoxiong_1"
					},
					{
						"zuidabi_3_3",
						"ab_sync_1_zuidabi_3_2"
					},
					{
						"zuidabi_4",
						"ab_sync_1_zuidabi_3"
					},
					{
						"youxiong_1",
						"ab_sync_1_youxiong_1"
					},
					{
						"youxiong_1_2",
						"ab_sync_1_youxiong_1_2"
					},
					{
						"zuidabi_3_4",
						"ab_sync_1_zuidabi_3_2"
					},
					{
						"zuidabi_7",
						"ab_sync_1_zuidabi_3"
					},
					{
						"zuoxiong_1",
						"ab_sync_1_zuoxiong_1"
					},
					{
						"zuoxiong_1_2",
						"ab_sync_1_zuoxiong_1_2"
					},
					{
						"zuidabi_3",
						"ab_sync_1_zuidabi_3"
					},
					{
						"zuidabi_3_2",
						"ab_sync_1_zuidabi_3_2"
					},
					{
						"shenti_3_3",
						"ab_sync_1_shenti_3_2"
					},
					{
						"shenti_6",
						"ab_sync_1_shenti_3"
					},
					{
						"zuodatui_1_3",
						"ab_sync_1_zuodatui_1"
					},
					{
						"zuodatui_6",
						"ab_sync_1_zuodatui_1_2"
					},
					{
						"shenti_1_3",
						"ab_sync_1_shenti_1_2"
					},
					{
						"shenti_4",
						"ab_sync_1_shenti_1"
					},
					{
						"youxiong_1_3",
						"ab_sync_1_youxiong_1_2"
					},
					{
						"youxiong_2",
						"ab_sync_1_youxiong_1"
					},
					{
						"youbi_2",
						"ab_sync_1_youbi_2"
					},
					{
						"2_datuiL_2",
						"2_ab_sync_1_datuiL_2"
					},
					{
						"2_shenti_2",
						"2_ab_sync_1_shenti_2"
					},
					{
						"2_datuiR_2",
						"2_ab_sync_1_datuiR_2"
					},
					{
						"2_shoubiR_1",
						"2_ab_sync_0_shoubiR_1"
					}
				}
			},
			{
				type = var_0_0.change_parameter_link_slot,
				link_parameter = {
					{
						num = 1,
						name = "touch_drag7",
						match = true
					},
					{
						num = 1,
						name = "touch_drag1",
						match = true
					},
					{
						num = 0,
						name = "touch_drag2",
						match = true
					}
				},
				slot_list = {
					{
						"shenti_3",
						"ab_sync_1_1_shenti_3"
					},
					{
						"shenti_3_2",
						"ab_sync_1_1_shenti_3_2"
					},
					{
						"zuodatui_1",
						"ab_sync_1_1_zuodatui_1"
					},
					{
						"zuodatui_1_2",
						"ab_sync_1_1_zuodatui_1_2"
					},
					{
						"shenti_1",
						"ab_sync_1_1_shenti_1"
					},
					{
						"shenti_1_2",
						"ab_sync_1_1_shenti_1_2"
					},
					{
						"zuoxiong_1_3",
						"ab_sync_1_1_zuoxiong_1_2"
					},
					{
						"zuoxiong_2",
						"ab_sync_1_1_zuoxiong_1"
					},
					{
						"zuidabi_3_3",
						"ab_sync_1_1_zuidabi_3_2"
					},
					{
						"zuidabi_4",
						"ab_sync_1_1_zuidabi_3"
					},
					{
						"youxiong_1",
						"ab_sync_1_1_youxiong_1"
					},
					{
						"youxiong_1_2",
						"ab_sync_1_1_youxiong_1_2"
					},
					{
						"zuidabi_3_4",
						"ab_sync_1_1_zuidabi_3_2"
					},
					{
						"zuidabi_7",
						"ab_sync_1_1_zuidabi_3"
					},
					{
						"zuoxiong_1",
						"ab_sync_1_1_zuoxiong_1"
					},
					{
						"zuoxiong_1_2",
						"ab_sync_1_1_zuoxiong_1_2"
					},
					{
						"zuidabi_3",
						"ab_sync_1_1_zuidabi_3"
					},
					{
						"zuidabi_3_2",
						"ab_sync_1_1_zuidabi_3_2"
					},
					{
						"shenti_3_3",
						"ab_sync_1_1_shenti_3_2"
					},
					{
						"shenti_6",
						"ab_sync_1_1_shenti_3"
					},
					{
						"zuodatui_1_3",
						"ab_sync_1_1_zuodatui_1_2"
					},
					{
						"zuodatui_6",
						"ab_sync_1_1_zuodatui_1"
					},
					{
						"shenti_1_3",
						"ab_sync_1_1_shenti_1_2"
					},
					{
						"shenti_4",
						"ab_sync_1_1_shenti_1"
					},
					{
						"youxiong_1_3",
						"ab_sync_1_1_youxiong_1_2"
					},
					{
						"youxiong_2",
						"ab_sync_1_1_youxiong_1"
					},
					{
						"youbi_2",
						"ab_sync_1_1_youbi_2"
					},
					{
						"2_datuiL_2",
						"2_ab_sync_1_1_datuiL_2"
					},
					{
						"2_shenti_2",
						"2_ab_sync_1_1_shenti_2"
					},
					{
						"2_datuiR_2",
						"2_ab_sync_1_1_datuiR_2"
					},
					{
						"2_shoubiR_1",
						"2_ab_sync_0_1_shoubiR_1"
					}
				}
			},
			{
				type = var_0_0.change_parameter_link_slot,
				link_parameter = {
					{
						num = 0,
						name = "touch_drag7",
						match = true
					},
					{
						num = 0,
						name = "touch_drag1",
						match = true
					},
					{
						num = 1,
						name = "touch_drag2",
						match = true
					}
				},
				slot_list = {
					{
						"shenti_3",
						"ab_sync_2_shenti_3"
					},
					{
						"shenti_3_2",
						"ab_sync_2_shenti_3_2"
					},
					{
						"zuodatui_1",
						"ab_sync_2_zuodatui_1"
					},
					{
						"zuodatui_1_2",
						"ab_sync_2_zuodatui_1_2"
					},
					{
						"shenti_1",
						"ab_sync_2_shenti_1"
					},
					{
						"shenti_1_2",
						"ab_sync_2_shenti_1_2"
					},
					{
						"zuoxiong_1_3",
						"ab_sync_2_zuoxiong_1_2"
					},
					{
						"zuoxiong_2",
						"ab_sync_2_zuoxiong_1"
					},
					{
						"zuidabi_3_3",
						"ab_sync_2_zuidabi_3_2"
					},
					{
						"zuidabi_4",
						"ab_sync_2_zuidabi_3"
					},
					{
						"youxiong_1",
						"ab_sync_2_youxiong_1"
					},
					{
						"youxiong_1_2",
						"ab_sync_2_youxiong_1_2"
					},
					{
						"zuidabi_3_4",
						"ab_sync_2_zuidabi_3_2"
					},
					{
						"zuidabi_7",
						"ab_sync_2_zuidabi_3"
					},
					{
						"zuoxiong_1",
						"ab_sync_2_zuoxiong_1"
					},
					{
						"zuoxiong_1_2",
						"ab_sync_2_zuoxiong_1_2"
					},
					{
						"zuidabi_3",
						"ab_sync_2_zuidabi_3"
					},
					{
						"zuidabi_3_2",
						"ab_sync_2_zuidabi_3_2"
					},
					{
						"shenti_3_3",
						"ab_sync_2_shenti_3_2"
					},
					{
						"shenti_6",
						"ab_sync_2_shenti_3"
					},
					{
						"zuodatui_1_3",
						"ab_sync_2_zuodatui_1"
					},
					{
						"zuodatui_6",
						"ab_sync_2_zuodatui_1_2"
					},
					{
						"shenti_1_3",
						"ab_sync_2_shenti_1_2"
					},
					{
						"shenti_4",
						"ab_sync_2_shenti_1"
					},
					{
						"youxiong_1_3",
						"ab_sync_2_youxiong_1_2"
					},
					{
						"youxiong_2",
						"ab_sync_2_youxiong_1"
					},
					{
						"youbi_2",
						"ab_sync_0_youbi_2"
					},
					{
						"2_datuiL_2",
						"2_ab_sync_2_datuiL_2"
					},
					{
						"2_shenti_2",
						"2_ab_sync_2_shenti_2"
					},
					{
						"2_datuiR_2",
						"2_ab_sync_2_datuiR_2"
					},
					{
						"2_shoubiR_1",
						"2_ab_sync_0_shoubiR_1"
					}
				}
			},
			{
				type = var_0_0.change_parameter_link_slot,
				link_parameter = {
					{
						num = 1,
						name = "touch_drag7",
						match = true
					},
					{
						num = 0,
						name = "touch_drag1",
						match = true
					},
					{
						num = 1,
						name = "touch_drag2",
						match = true
					}
				},
				slot_list = {
					{
						"shenti_3",
						"ab_sync_2_1_shenti_3"
					},
					{
						"shenti_3_2",
						"ab_sync_2_1_shenti_3_2"
					},
					{
						"zuodatui_1",
						"ab_sync_2_1_zuodatui_1"
					},
					{
						"zuodatui_1_2",
						"ab_sync_2_1_zuodatui_1_2"
					},
					{
						"shenti_1",
						"ab_sync_2_1_shenti_1"
					},
					{
						"shenti_1_2",
						"ab_sync_2_1_shenti_1_2"
					},
					{
						"zuoxiong_1_3",
						"ab_sync_2_1_zuoxiong_1_2"
					},
					{
						"zuoxiong_2",
						"ab_sync_2_1_zuoxiong_1"
					},
					{
						"zuidabi_3_3",
						"ab_sync_2_1_zuidabi_3_2"
					},
					{
						"zuidabi_4",
						"ab_sync_2_1_zuidabi_3"
					},
					{
						"youxiong_1",
						"ab_sync_2_1_youxiong_1"
					},
					{
						"youxiong_1_2",
						"ab_sync_2_1_youxiong_1_2"
					},
					{
						"zuidabi_3_4",
						"ab_sync_2_1_zuidabi_3_2"
					},
					{
						"zuidabi_7",
						"ab_sync_2_1_zuidabi_3"
					},
					{
						"zuoxiong_1",
						"ab_sync_2_1_zuoxiong_1"
					},
					{
						"zuoxiong_1_2",
						"ab_sync_2_1_zuoxiong_1_2"
					},
					{
						"zuidabi_3",
						"ab_sync_2_1_zuidabi_3"
					},
					{
						"zuidabi_3_2",
						"ab_sync_2_1_zuidabi_3_2"
					},
					{
						"shenti_3_3",
						"ab_sync_2_1_shenti_3_2"
					},
					{
						"shenti_6",
						"ab_sync_2_1_shenti_3"
					},
					{
						"zuodatui_1_3",
						"ab_sync_2_1_zuodatui_1_2"
					},
					{
						"zuodatui_6",
						"ab_sync_2_1_zuodatui_1"
					},
					{
						"shenti_1_3",
						"ab_sync_2_1_shenti_1_2"
					},
					{
						"shenti_4",
						"ab_sync_2_1_shenti_1"
					},
					{
						"youxiong_1_3",
						"ab_sync_2_1_youxiong_1_2"
					},
					{
						"youxiong_2",
						"ab_sync_2_1_youxiong_1"
					},
					{
						"youbi_2",
						"ab_sync_0_1_youbi_2"
					},
					{
						"2_datuiL_2",
						"2_ab_sync_2_1_datuiL_2"
					},
					{
						"2_shenti_2",
						"2_ab_sync_2_1_shenti_2"
					},
					{
						"2_datuiR_2",
						"2_ab_sync_2_1_datuiR_2"
					},
					{
						"2_shoubiR_1",
						"2_ab_sync_0_1_shoubiR_1"
					}
				}
			},
			{
				type = var_0_0.change_parameter_link_slot,
				link_parameter = {
					{
						num = 0,
						name = "touch_drag7",
						match = true
					},
					{
						num = 1,
						name = "touch_drag1",
						match = true
					},
					{
						num = 1,
						name = "touch_drag2",
						match = true
					}
				},
				slot_list = {
					{
						"shenti_3",
						"ab_sync_3_shenti_3"
					},
					{
						"shenti_3_2",
						"ab_sync_3_shenti_3_2"
					},
					{
						"zuodatui_1",
						"ab_sync_3_zuodatui_1"
					},
					{
						"zuodatui_1_2",
						"ab_sync_3_zuodatui_1_2"
					},
					{
						"shenti_1",
						"ab_sync_3_shenti_1"
					},
					{
						"shenti_1_2",
						"ab_sync_3_shenti_1_2"
					},
					{
						"zuoxiong_1_3",
						"ab_sync_3_zuoxiong_1_2"
					},
					{
						"zuoxiong_2",
						"ab_sync_3_zuoxiong_1"
					},
					{
						"zuidabi_3_3",
						"ab_sync_3_zuidabi_3_2"
					},
					{
						"zuidabi_4",
						"ab_sync_3_zuidabi_3"
					},
					{
						"youxiong_1",
						"ab_sync_3_youxiong_1"
					},
					{
						"youxiong_1_2",
						"ab_sync_3_youxiong_1_2"
					},
					{
						"zuidabi_3_4",
						"ab_sync_3_zuidabi_3_2"
					},
					{
						"zuidabi_7",
						"ab_sync_3_zuidabi_3"
					},
					{
						"zuoxiong_1",
						"ab_sync_3_zuoxiong_1"
					},
					{
						"zuoxiong_1_2",
						"ab_sync_3_zuoxiong_1_2"
					},
					{
						"zuidabi_3",
						"ab_sync_3_zuidabi_3"
					},
					{
						"zuidabi_3_2",
						"ab_sync_3_zuidabi_3_2"
					},
					{
						"shenti_3_3",
						"ab_sync_3_shenti_3_2"
					},
					{
						"shenti_6",
						"ab_sync_3_shenti_3"
					},
					{
						"zuodatui_1_3",
						"ab_sync_3_zuodatui_1"
					},
					{
						"zuodatui_6",
						"ab_sync_3_zuodatui_1_2"
					},
					{
						"shenti_1_3",
						"ab_sync_3_shenti_1_2"
					},
					{
						"shenti_4",
						"ab_sync_3_shenti_1"
					},
					{
						"youxiong_1_3",
						"ab_sync_3_youxiong_1_2"
					},
					{
						"youxiong_2",
						"ab_sync_3_youxiong_1"
					},
					{
						"youbi_2",
						"ab_sync_1_youbi_2"
					},
					{
						"2_datuiL_2",
						"2_ab_sync_3_datuiL_2"
					},
					{
						"2_shenti_2",
						"2_ab_sync_3_shenti_2"
					},
					{
						"2_datuiR_2",
						"2_ab_sync_3_datuiR_2"
					},
					{
						"2_shoubiR_1",
						"2_ab_sync_0_shoubiR_1"
					}
				}
			},
			{
				type = var_0_0.change_parameter_link_slot,
				link_parameter = {
					{
						num = 1,
						name = "touch_drag7",
						match = true
					},
					{
						num = 1,
						name = "touch_drag1",
						match = true
					},
					{
						num = 1,
						name = "touch_drag2",
						match = true
					}
				},
				slot_list = {
					{
						"shenti_3",
						"ab_sync_3_1_shenti_3"
					},
					{
						"shenti_3_2",
						"ab_sync_3_1_shenti_3_2"
					},
					{
						"zuodatui_1",
						"ab_sync_3_1_zuodatui_1"
					},
					{
						"zuodatui_1_2",
						"ab_sync_3_1_zuodatui_1_2"
					},
					{
						"shenti_1",
						"ab_sync_3_1_shenti_1"
					},
					{
						"shenti_1_2",
						"ab_sync_3_1_shenti_1_2"
					},
					{
						"zuoxiong_1_3",
						"ab_sync_3_1_zuoxiong_1_2"
					},
					{
						"zuoxiong_2",
						"ab_sync_3_1_zuoxiong_1"
					},
					{
						"zuidabi_3_3",
						"ab_sync_3_1_zuidabi_3_2"
					},
					{
						"zuidabi_4",
						"ab_sync_3_1_zuidabi_3"
					},
					{
						"youxiong_1",
						"ab_sync_3_1_youxiong_1"
					},
					{
						"youxiong_1_2",
						"ab_sync_3_1_youxiong_1_2"
					},
					{
						"zuidabi_3_4",
						"ab_sync_3_1_zuidabi_3_2"
					},
					{
						"zuidabi_7",
						"ab_sync_3_1_zuidabi_3"
					},
					{
						"zuoxiong_1",
						"ab_sync_3_1_zuoxiong_1"
					},
					{
						"zuoxiong_1_2",
						"ab_sync_3_1_zuoxiong_1_2"
					},
					{
						"zuidabi_3",
						"ab_sync_3_1_zuidabi_3"
					},
					{
						"zuidabi_3_2",
						"ab_sync_3_1_zuidabi_3_2"
					},
					{
						"shenti_3_3",
						"ab_sync_3_1_shenti_3_2"
					},
					{
						"shenti_6",
						"ab_sync_3_1_shenti_3"
					},
					{
						"zuodatui_1_3",
						"ab_sync_3_1_zuodatui_1"
					},
					{
						"zuodatui_6",
						"ab_sync_3_1_zuodatui_1_2"
					},
					{
						"shenti_1_3",
						"ab_sync_3_1_shenti_1_2"
					},
					{
						"shenti_4",
						"ab_sync_3_1_shenti_1"
					},
					{
						"youxiong_1_3",
						"ab_sync_3_1_youxiong_1_2"
					},
					{
						"youxiong_2",
						"ab_sync_3_1_youxiong_1"
					},
					{
						"youbi_2",
						"ab_sync_1_1_youbi_2"
					},
					{
						"2_datuiL_2",
						"2_ab_sync_3_1_datuiL_2"
					},
					{
						"2_shenti_2",
						"2_ab_sync_3_1_shenti_2"
					},
					{
						"2_datuiR_2",
						"2_ab_sync_3_1_datuiR_2"
					},
					{
						"2_shoubiR_1",
						"2_ab_sync_0_1_shoubiR_1"
					}
				}
			}
		}
	}
}

return var_0_0
