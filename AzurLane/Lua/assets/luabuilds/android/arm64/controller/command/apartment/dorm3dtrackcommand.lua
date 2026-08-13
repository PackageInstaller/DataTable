class = var_0_10000

local var_0_0 = "Dorm3dTrackCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

var_0_1.TYPE_DORM_ENTER = 1
var_0_1.TYPE_DORM_TOUCH = 2
var_0_1.TYPE_DORM_DIALOG = 3
var_0_1.TYPE_DORM_FAVOR = 4
var_0_1.TYPE_DORM_GIFT = 5
var_0_1.TYPE_DORM_FURNITURE = 6
var_0_1.TYPE_DORM_COLLECTION_ITEM = 7
var_0_1.TYPE_DORM_STORY = 8
var_0_1.TYPE_DORM_CAMERA = 9
var_0_1.TYPE_DORM_COVER = 10
var_0_1.TYPE_DORM_DOWNLOAD = 11
var_0_1.TYPE_DORM_IK_FURNITURE = 12
var_0_1.TYPE_DORM_ROOM = 13
var_0_1.TYPE_DORM_ACCOMPANY = 14
var_0_1.TYPE_DORM_MINIGAME = 15
var_0_1.TYPE_DORM_GUIDE = 16
var_0_1.TYPE_DORM_GRAPHICS = 17
var_0_1.TYPE_DORM_SKIN = 32
var_0_1.TYPE_DORM_DANCE = 33
var_0_1.TYPE_DORM_PHONE = 34

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.body

	print = var_1_10003

	local var_1_1 = "TRACK DORM3D\n"

	table = var_1_10006

	var_1_10003(var_1_1, var_1_10006.CastToString(var_1_0))

	pg = var_1_10003

	local var_1_2 = var_1_10003.ConnectionMgr.GetInstance()

	if var_3.getConnection(var_1_2) then
		pg = var_3
		var_1_2 = var_3.ConnectionMgr.GetInstance()

		if not var_3.isConnected(var_1_2) then
			return
		end

		if var_1_0.args then
			_ = var_3

			local var_1_3 = var_3.map

			_ = var_1_2

			local var_1_4

			if not var_1_3(var_1_2.range(var_1_0.args.Count), function(arg_2_0)
				local var_2_0

				if not var_1_0.args[arg_2_0] then
					var_2_0 = 0
				end

				return var_2_0
			end) then
				var_1_4 = {}
			end

			if var_1_0.strs then
				_ = var_4

				local var_1_5 = var_4.map

				_ = var_6

				local var_1_6

				if not var_1_5(var_6.range(var_1_0.strs.Count), function(arg_3_0)
					local var_3_0

					if not var_1_0.strs[arg_3_0] then
						var_3_0 = ""
					end

					return var_3_0
				end) then
					var_1_6 = {}
				end

				pg = var_1_2

				local var_1_7 = var_1_2.GameTrackerMgr.GetInstance()
				local var_1_8 = var_5.Record

				GameTrackerBuilder = var_8

				var_1_8(var_1_7, var_8.BuildDorm3d({
					track_typ = var_1_0.trackType,
					int_args = var_1_4,
					str_args = var_1_6
				}))

				return
			end
		end
	end
end

function var_0_1.BuildDataEnter(arg_4_0, arg_4_1, arg_4_2)
	return {
		trackType = var_0_1.TYPE_DORM_ENTER,
		args = {
			arg_4_0,
			arg_4_1,
			arg_4_2 or 0,
			Count = 3
		}
	}
end

function var_0_1.BuildDataTouch(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	return {
		trackType = var_0_1.TYPE_DORM_TOUCH,
		args = {
			arg_5_0,
			arg_5_1,
			arg_5_4,
			Count = 3
		},
		strs = {
			arg_5_2,
			arg_5_3,
			Count = 2
		}
	}
end

function var_0_1.BuildDataDialog(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7)
	return {
		trackType = var_0_1.TYPE_DORM_DIALOG,
		args = {
			arg_6_0,
			arg_6_1,
			arg_6_2,
			arg_6_3,
			arg_6_4,
			arg_6_7,
			Count = 6
		},
		strs = {
			arg_6_5,
			arg_6_6,
			Count = 2
		}
	}
end

function var_0_1.BuildDataFavor(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	return {
		trackType = var_0_1.TYPE_DORM_FAVOR,
		args = {
			arg_7_0,
			arg_7_1,
			arg_7_2,
			arg_7_3,
			Count = 4
		},
		strs = {
			arg_7_4,
			Count = 1
		}
	}
end

function var_0_1.BuildDataGift(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	return {
		trackType = var_0_1.TYPE_DORM_GIFT,
		args = {
			arg_8_0,
			arg_8_1,
			arg_8_2,
			Count = 3
		},
		strs = {
			arg_8_3,
			Count = 1
		}
	}
end

function var_0_1.BuildDataFurniture(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	return {
		trackType = var_0_1.TYPE_DORM_FURNITURE,
		args = {
			arg_9_0,
			arg_9_1,
			arg_9_2,
			Count = 3
		},
		strs = {
			arg_9_3,
			Count = 1
		}
	}
end

function var_0_1.BuildDataCollectionItem(arg_10_0, arg_10_1)
	return {
		trackType = var_0_1.TYPE_DORM_COLLECTION_ITEM,
		args = {
			arg_10_0,
			arg_10_1,
			Count = 2
		}
	}
end

function var_0_1.BuildDataStory(arg_11_0, arg_11_1)
	return {
		trackType = var_0_1.TYPE_DORM_STORY,
		args = {
			arg_11_0,
			Count = 1
		},
		strs = {
			arg_11_1,
			Count = 1
		}
	}
end

function var_0_1.BuildCameraMsg(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6)
	table = var_1_10007

	local var_12_0 = var_1_10007.concat

	_ = var_1_10009

	return var_12_0(var_1_10009.map({
		arg_12_0,
		arg_12_1,
		arg_12_2,
		arg_12_3,
		arg_12_4,
		arg_12_5,
		arg_12_6
	}, function(arg_13_0)
		tostring = var_2_10001

		return var_2_10001(arg_13_0)
	end), "_")
end

function var_0_1.BuildDataCamera(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	return {
		trackType = var_0_1.TYPE_DORM_CAMERA,
		args = {
			arg_14_0,
			arg_14_1,
			arg_14_2,
			Count = 3
		},
		strs = {
			arg_14_3,
			Count = 1
		}
	}
end

function var_0_1.BuildDataCover(arg_15_0, arg_15_1)
	return {
		trackType = var_0_1.TYPE_DORM_COVER,
		args = {
			arg_15_0,
			arg_15_1,
			Count = 2
		}
	}
end

function var_0_1.BuildDataDownload(arg_16_0, arg_16_1)
	return {
		trackType = var_0_1.TYPE_DORM_DOWNLOAD,
		args = {
			arg_16_0,
			arg_16_1,
			Count = 2
		}
	}
end

function var_0_1.BuildDataIKFurniture(arg_17_0, arg_17_1)
	return {
		trackType = var_0_1.TYPE_DORM_IK_FURNITURE,
		args = {
			arg_17_0,
			arg_17_1,
			Count = 2
		}
	}
end

function var_0_1.BuildDataRoom(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	return {
		trackType = var_0_1.TYPE_DORM_ROOM,
		args = {
			arg_18_0,
			arg_18_1,
			Count = 2
		},
		strs = {
			arg_18_2,
			arg_18_3,
			Count = 2
		}
	}
end

function var_0_1.BuildDataAccompany(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	return {
		trackType = var_0_1.TYPE_DORM_ACCOMPANY,
		args = {
			arg_19_0,
			arg_19_1,
			arg_19_2,
			arg_19_3,
			Count = 4
		},
		strs = {
			arg_19_4,
			Count = 1
		}
	}
end

function var_0_1.BuildDataMiniGame(arg_20_0, arg_20_1)
	return {
		trackType = var_0_1.TYPE_DORM_MINIGAME,
		args = {
			arg_20_0,
			arg_20_1,
			Count = 2
		}
	}
end

function var_0_1.BuildDataGuide(arg_21_0, arg_21_1)
	local var_21_0 = {
		trackType = var_0_1.TYPE_DORM_GUIDE,
		args = {
			arg_21_0,
			Count = 1
		}
	}
	local var_21_1 = {
		Count = 1
	}

	tostring = var_1_10004
	var_21_1[1] = var_1_10004(arg_21_1)
	var_21_0.strs = var_21_1

	return var_21_0
end

function var_0_1.BuildDataGraphics(arg_22_0)
	SystemInfo = var_1_10001

	local var_22_0 = var_1_10001.deviceModel

	return {
		trackType = var_0_1.TYPE_DORM_GRAPHICS,
		args = {
			arg_22_0,
			Count = 1
		},
		strs = {
			var_22_0,
			Count = 1
		}
	}
end

function var_0_1.BuildDataChangeSkin(arg_23_0)
	return {
		trackType = var_0_1.TYPE_DORM_SKIN,
		args = {
			arg_23_0,
			Count = 1
		}
	}
end

function var_0_1.BuildDataDance(arg_24_0, arg_24_1)
	return {
		trackType = var_0_1.TYPE_DORM_DANCE,
		args = {
			arg_24_0,
			arg_24_1,
			Count = 2
		}
	}
end

function var_0_1.BuildDataPhone(arg_25_0, arg_25_1, arg_25_2)
	return {
		trackType = var_0_1.TYPE_DORM_PHONE,
		args = {
			arg_25_0,
			arg_25_1,
			arg_25_2,
			Count = 3
		}
	}
end

return var_0_1
