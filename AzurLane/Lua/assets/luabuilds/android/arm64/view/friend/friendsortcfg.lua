return {
	SORT_TAG = {
		{
			spr = "sort_login",
			tag = i18n("word_default"),
			func = function(arg_1_0, arg_1_1)
				table.sort(arg_1_0, function(arg_2_0, arg_2_1)
					if arg_2_0.unreadCount == arg_2_1.unreadCount then
						if arg_2_0.online == arg_2_1.online then
							if arg_2_0.preOnLineTime == arg_2_1.preOnLineTime then
								return arg_2_0.id < arg_2_1.id
							elseif arg_1_1 then
								return arg_2_0.preOnLineTime < arg_2_1.preOnLineTime
							else
								return arg_2_0.preOnLineTime > arg_2_1.preOnLineTime
							end
						elseif arg_1_1 then
							return arg_2_0.online < arg_2_1.online
						else
							return arg_2_0.online > arg_2_1.online
						end
					else
						return arg_2_0.unreadCount > arg_2_1.unreadCount
					end

					return
				end)

				return
			end
		},
		{
			spr = "sort_star",
			tag = i18n("word_star"),
			func = function(arg_3_0, arg_3_1)
				local var_3_0 = pg.ship_data_statistics

				table.sort(arg_3_0, function(arg_4_0, arg_4_1)
					if var_3_0[arg_4_0.icon].star == var_3_0[arg_4_1.icon].star then
						if arg_4_0.level == arg_4_1.level then
							return arg_4_0.id < arg_4_1.id
						elseif arg_3_1 then
							return arg_4_0.level < arg_4_1.level
						else
							return arg_4_0.level > arg_4_1.level
						end
					elseif arg_3_1 then
						return var_3_0[arg_4_0.icon].star < var_3_0[arg_4_1.icon].star
					else
						return var_3_0[arg_4_0.icon].star > var_3_0[arg_4_1.icon].star
					end

					return
				end)

				return
			end
		},
		{
			spr = "sort_lv",
			tag = i18n("word_level"),
			func = function(arg_5_0, arg_5_1)
				table.sort(arg_5_0, function(arg_6_0, arg_6_1)
					if arg_6_0.level == arg_6_1.level then
						return arg_6_0.id < arg_6_1.id
					elseif arg_5_1 then
						return arg_6_0.level < arg_6_1.level
					else
						return arg_6_0.level > arg_6_1.level
					end

					return
				end)

				return
			end
		}
	}
}
