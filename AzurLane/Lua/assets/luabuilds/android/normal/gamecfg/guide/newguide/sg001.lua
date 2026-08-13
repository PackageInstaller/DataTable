return {
	{
		index = 1,
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S001",
				12003
			}
		}
	},
	{
		index = 2,
		end_segment = "S003",
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S002",
				12009
			},
			{
				"S002_1",
				12026
			}
		},
		getSegment = function()
			getProxy = var_1_10000
			BuildShipProxy = var_1_10001

			local var_1_0 = var_1_10000(var_1_10001)

			return var_0.getFinishCount(var_1_0) > 0 and 2 or 1
		end
	},
	{
		index = 3,
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S004",
				12103
			}
		}
	},
	{
		index = 4,
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S005",
				13102
			}
		}
	},
	{
		index = 5,
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S006",
				13104
			}
		}
	},
	{
		index = 6,
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S007",
				13104
			}
		}
	},
	{
		index = 7,
		interrupt = true,
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S008",
				40002
			}
		}
	},
	{
		index = 8,
		view = {
			"NewMainScene",
			"LevelScene"
		},
		condition = {
			arg = {
				1,
				40004
			},
			func = function(arg_2_0, arg_2_1)
				if arg_2_0 == "NewMainScene" then
					pg = var_1_10002

					return var_1_10002.SeriesGuideMgr.CODES.MAINUI, 7
				elseif arg_2_0 == "LevelScene" then
					if not arg_2_1 then
						pg = var_1_10002

						return var_1_10002.SeriesGuideMgr.CODES.CONDITION, 7
					elseif arg_2_1 then
						if arg_2_1.score > 1 then
							pg = var_2

							return var_2.SeriesGuideMgr.CODES.CONDITION, 9
						elseif arg_2_1.total_time >= 180 then
							pg = var_2

							return var_2.SeriesGuideMgr.CODES.CONDITION, 7
						else
							pg = var_2

							return var_2.SeriesGuideMgr.CODES.CONDITION, 4
						end
					end
				end

				return
			end
		}
	},
	{
		index = 9,
		end_segment = "S010",
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S009",
				13104
			}
		}
	},
	{
		index = 10,
		end_segment = "S012",
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S011",
				20006
			}
		}
	},
	{
		index = 11,
		end_segment = "S014",
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S013",
				15003
			}
		}
	},
	{
		index = 12,
		end_segment = "S016",
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S015",
				14007
			}
		}
	},
	{
		index = 13,
		end_segment = "S012",
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S011",
				20006
			}
		}
	},
	{
		index = 14,
		view = {
			"NewMainScene"
		},
		condition = {
			arg = {
				2
			},
			func = function(arg_3_0)
				local var_3_0 = arg_3_0

				if arg_3_0.getEquip(var_3_0, 2) then
					pg = var_3_0

					return var_3_0.SeriesGuideMgr.CODES.MAINUI, 15
				end

				pg = var_3_0

				return var_3_0.SeriesGuideMgr.CODES.MAINUI, 14
			end
		},
		segment = {
			{
				"S017",
				12007
			}
		}
	},
	{
		index = 15,
		end_segment = "S019",
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S018",
				14003
			}
		}
	},
	{
		index = 16,
		end_segment = "S012",
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S011",
				20006
			}
		}
	},
	{
		index = 17,
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S020",
				12003
			},
			{
				"S020_1",
				12003
			}
		},
		getSegment = function()
			getProxy = var_1_10000
			ActivityProxy = var_1_10001

			local var_4_0 = var_1_10000(var_1_10001)
			local var_4_1 = var_0.getActivityByType

			ActivityConst = var_1_10002

			local var_4_2, var_4_3

			if var_4_1(var_4_0, var_1_10002.ACTIVITY_TYPE_BUILDSHIP_1) then
				::label_4_0::

				var_4_2 = var_0
				var_4_3 = not var_0.isEnd(var_4_2)
			end

			BuildShipScene = var_4_2

			if not var_4_2.projectName then
				if var_4_3 then
					return 1
				else
					return 2
				end
			else
				BuildShipScene = var_2

				local var_4_4 = var_2.projectName

				BuildShipScene = var_1_10003

				return var_4_4 == var_1_10003.PROJECTS.HEAVY and 2 or 1
			end

			return
		end
	},
	{
		index = 18,
		end_segment = "S003",
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S002",
				12009
			},
			{
				"S002_1",
				12026
			}
		},
		getSegment = function()
			getProxy = var_1_10000
			BuildShipProxy = var_1_10001

			local var_5_0 = var_1_10000(var_1_10001)

			return var_0.getFinishCount(var_5_0) > 0 and 2 or 1
		end
	},
	{
		index = 19,
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S021",
				12103
			}
		}
	},
	{
		index = 20,
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S022",
				13102
			}
		}
	},
	{
		index = 21,
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S023",
				13104
			}
		}
	},
	{
		index = 22,
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S024",
				13104
			}
		}
	},
	{
		index = 23,
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S025",
				13104
			}
		}
	},
	{
		index = 24,
		interrupt = true,
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S026",
				40002
			}
		}
	},
	{
		index = 25,
		view = {
			"NewMainScene",
			"LevelScene"
		},
		condition = {
			arg = {
				1,
				40004
			},
			func = function(arg_6_0, arg_6_1)
				if arg_6_0 == "NewMainScene" then
					pg = var_1_10002

					return var_1_10002.SeriesGuideMgr.CODES.MAINUI, 24
				elseif arg_6_0 == "LevelScene" then
					if not arg_6_1 then
						pg = var_1_10002

						return var_1_10002.SeriesGuideMgr.CODES.CONDITION, 24
					elseif arg_6_1 then
						if arg_6_1.score > 1 then
							pg = var_2

							return var_2.SeriesGuideMgr.CODES.CONDITION, 26
						elseif arg_6_1.total_time >= 180 then
							pg = var_2

							return var_2.SeriesGuideMgr.CODES.CONDITION, 24
						else
							pg = var_2

							return var_2.SeriesGuideMgr.CODES.CONDITION, 20
						end
					end
				end

				return
			end
		}
	},
	{
		index = 26,
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S027",
				13104
			}
		}
	},
	{
		index = 27,
		interrupt = true,
		view = {
			"NewMainScene"
		},
		segment = {
			{
				"S028",
				40002
			}
		}
	},
	{
		index = 28,
		end_segment = "S029",
		view = {
			"NewMainScene",
			"LevelScene"
		},
		condition = {
			arg = {
				1,
				40004
			},
			func = function(arg_7_0, arg_7_1)
				if arg_7_0 == "NewMainScene" then
					pg = var_1_10002

					return var_1_10002.SeriesGuideMgr.CODES.MAINUI, 27
				elseif arg_7_0 == "LevelScene" then
					if not arg_7_1 then
						pg = var_1_10002

						return var_1_10002.SeriesGuideMgr.CODES.CONDITION, 27
					elseif arg_7_1 then
						if arg_7_1.score > 1 then
							pg = var_2

							return var_2.SeriesGuideMgr.CODES.CONDITION, 29
						elseif arg_7_1.total_time >= 180 then
							pg = var_2

							return var_2.SeriesGuideMgr.CODES.CONDITION, 27
						else
							pg = var_2

							return var_2.SeriesGuideMgr.CODES.CONDITION, 20
						end
					end
				end

				return
			end
		}
	}
}
