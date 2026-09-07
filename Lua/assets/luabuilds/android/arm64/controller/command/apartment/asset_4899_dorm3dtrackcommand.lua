local Dorm3dTrackCommand = class("Dorm3dTrackCommand", pm.SimpleCommand)

Dorm3dTrackCommand.TYPE_DORM_ENTER = 1
Dorm3dTrackCommand.TYPE_DORM_TOUCH = 2
Dorm3dTrackCommand.TYPE_DORM_DIALOG = 3
Dorm3dTrackCommand.TYPE_DORM_FAVOR = 4
Dorm3dTrackCommand.TYPE_DORM_GIFT = 5
Dorm3dTrackCommand.TYPE_DORM_FURNITURE = 6
Dorm3dTrackCommand.TYPE_DORM_COLLECTION_ITEM = 7
Dorm3dTrackCommand.TYPE_DORM_STORY = 8
Dorm3dTrackCommand.TYPE_DORM_CAMERA = 9
Dorm3dTrackCommand.TYPE_DORM_COVER = 10
Dorm3dTrackCommand.TYPE_DORM_DOWNLOAD = 11
Dorm3dTrackCommand.TYPE_DORM_IK_FURNITURE = 12
Dorm3dTrackCommand.TYPE_DORM_ROOM = 13
Dorm3dTrackCommand.TYPE_DORM_ACCOMPANY = 14
Dorm3dTrackCommand.TYPE_DORM_MINIGAME = 15
Dorm3dTrackCommand.TYPE_DORM_GUIDE = 16
Dorm3dTrackCommand.TYPE_DORM_GRAPHICS = 17
Dorm3dTrackCommand.TYPE_DORM_SKIN = 32
Dorm3dTrackCommand.TYPE_DORM_DANCE = 33
Dorm3dTrackCommand.TYPE_DORM_PHONE = 34

function Dorm3dTrackCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1.body

	print("TRACK DORM3D\n", table.CastToString(arg_1_1.body))

	if pg.ConnectionMgr.GetInstance():getConnection() then
		if not pg.ConnectionMgr.GetInstance():isConnected() then
			return
		end
	end

	local var_1_1 = arg_1_1.body.args and _.map(_.range(arg_1_1.body.args.Count), function(arg_2_0)
		return var_1_0.args[arg_2_0] or 0
	end) or {}
	local var_1_2 = arg_1_1.body.strs and _.map(_.range(arg_1_1.body.strs.Count), function(arg_3_0)
		return var_1_0.strs[arg_3_0] or ""
	end) or {}

	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildDorm3d({
		track_typ = arg_1_1.body.trackType,
		int_args = var_1_1,
		str_args = var_1_2
	}))

	return
end

function Dorm3dTrackCommand:BuildDataEnter(arg_4_1, arg_4_2)
	return {
		trackType = Dorm3dTrackCommand.TYPE_DORM_ENTER,
		args = {
			self,
			arg_4_1,
			arg_4_2 or 0,
			Count = 3
		}
	}
end

function Dorm3dTrackCommand:BuildDataTouch(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	return {
		trackType = Dorm3dTrackCommand.TYPE_DORM_TOUCH,
		args = {
			self,
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

function Dorm3dTrackCommand:BuildDataDialog(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7)
	return {
		trackType = Dorm3dTrackCommand.TYPE_DORM_DIALOG,
		args = {
			self,
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

function Dorm3dTrackCommand:BuildDataFavor(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	return {
		trackType = Dorm3dTrackCommand.TYPE_DORM_FAVOR,
		args = {
			self,
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

function Dorm3dTrackCommand:BuildDataGift(arg_8_1, arg_8_2, arg_8_3)
	return {
		trackType = Dorm3dTrackCommand.TYPE_DORM_GIFT,
		args = {
			self,
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

function Dorm3dTrackCommand:BuildDataFurniture(arg_9_1, arg_9_2, arg_9_3)
	return {
		trackType = Dorm3dTrackCommand.TYPE_DORM_FURNITURE,
		args = {
			self,
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

function Dorm3dTrackCommand:BuildDataCollectionItem(arg_10_1)
	return {
		trackType = Dorm3dTrackCommand.TYPE_DORM_COLLECTION_ITEM,
		args = {
			self,
			arg_10_1,
			Count = 2
		}
	}
end

function Dorm3dTrackCommand:BuildDataStory(arg_11_1)
	return {
		trackType = Dorm3dTrackCommand.TYPE_DORM_STORY,
		args = {
			self,
			Count = 1
		},
		strs = {
			arg_11_1,
			Count = 1
		}
	}
end

function Dorm3dTrackCommand:BuildCameraMsg(arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6)
	return table.concat(_.map({
		self,
		arg_12_1,
		arg_12_2,
		arg_12_3,
		arg_12_4,
		arg_12_5,
		arg_12_6
	}, function(arg_13_0)
		return tostring(arg_13_0)
	end), "_")
end

function Dorm3dTrackCommand:BuildDataCamera(arg_14_1, arg_14_2, arg_14_3)
	return {
		trackType = Dorm3dTrackCommand.TYPE_DORM_CAMERA,
		args = {
			self,
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

function Dorm3dTrackCommand:BuildDataCover(arg_15_1)
	return {
		trackType = Dorm3dTrackCommand.TYPE_DORM_COVER,
		args = {
			self,
			arg_15_1,
			Count = 2
		}
	}
end

function Dorm3dTrackCommand:BuildDataDownload(arg_16_1)
	return {
		trackType = Dorm3dTrackCommand.TYPE_DORM_DOWNLOAD,
		args = {
			self,
			arg_16_1,
			Count = 2
		}
	}
end

function Dorm3dTrackCommand:BuildDataIKFurniture(arg_17_1)
	return {
		trackType = Dorm3dTrackCommand.TYPE_DORM_IK_FURNITURE,
		args = {
			self,
			arg_17_1,
			Count = 2
		}
	}
end

function Dorm3dTrackCommand:BuildDataRoom(arg_18_1, arg_18_2, arg_18_3)
	return {
		trackType = Dorm3dTrackCommand.TYPE_DORM_ROOM,
		args = {
			self,
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

function Dorm3dTrackCommand:BuildDataAccompany(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	return {
		trackType = Dorm3dTrackCommand.TYPE_DORM_ACCOMPANY,
		args = {
			self,
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

function Dorm3dTrackCommand:BuildDataMiniGame(arg_20_1)
	return {
		trackType = Dorm3dTrackCommand.TYPE_DORM_MINIGAME,
		args = {
			self,
			arg_20_1,
			Count = 2
		}
	}
end

function Dorm3dTrackCommand:BuildDataGuide(arg_21_1)
	return {
		trackType = Dorm3dTrackCommand.TYPE_DORM_GUIDE,
		args = {
			self,
			Count = 1
		},
		strs = {
			tostring(arg_21_1),
			Count = 1
		}
	}
end

function Dorm3dTrackCommand:BuildDataGraphics()
	return {
		trackType = Dorm3dTrackCommand.TYPE_DORM_GRAPHICS,
		args = {
			self,
			Count = 1
		},
		strs = {
			SystemInfo.deviceModel,
			Count = 1
		}
	}
end

function Dorm3dTrackCommand:BuildDataChangeSkin()
	return {
		trackType = Dorm3dTrackCommand.TYPE_DORM_SKIN,
		args = {
			self,
			Count = 1
		}
	}
end

function Dorm3dTrackCommand:BuildDataDance(arg_24_1)
	return {
		trackType = Dorm3dTrackCommand.TYPE_DORM_DANCE,
		args = {
			self,
			arg_24_1,
			Count = 2
		}
	}
end

function Dorm3dTrackCommand:BuildDataPhone(arg_25_1, arg_25_2)
	return {
		trackType = Dorm3dTrackCommand.TYPE_DORM_PHONE,
		args = {
			self,
			arg_25_1,
			arg_25_2,
			Count = 3
		}
	}
end

return Dorm3dTrackCommand
