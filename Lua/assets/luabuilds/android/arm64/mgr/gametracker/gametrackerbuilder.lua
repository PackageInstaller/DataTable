local var_0_0 = class("GameTrackerBuilder")
local var_0_1 = ";"
local var_0_2 = "`"

function var_0_0.SerializedItem(arg_1_0)
	local var_1_0 = arg_1_0.int_args or {}
	local var_1_1 = table.concat(var_1_0, var_0_2)
	local var_1_2 = arg_1_0.str_args or {}
	local var_1_3 = table.concat(var_1_2, var_0_2)

	;({})[1] = arg_1_0.track_typ or ""
	;({})[2] = arg_1_0.track_time or ""
	;({})[3] = var_1_1 or ""
	;({})[4] = var_1_3 or ""

	return table.concat({}, var_0_1)
end

function var_0_0.DeSerializedItem(arg_2_0)
	local var_2_0 = string.split(arg_2_0, var_0_1)

	if #var_2_0 < 2 then
		return false
	end

	local var_2_2 = var_2_0[1] or ""
	local var_2_3 = var_2_1(var_2_2)
	local var_2_4 = var_2_0[2] or ""
	local var_2_5 = tonumber(var_2_4)

	if var_2_3 == nil or var_2_5 == nil then
		return false
	end

	local var_2_6 = var_2_0[3] or ""

	for iter_2_0, iter_2_1 in ipairs((string.split(var_2_6, var_0_2))) do
		local var_2_7 = tonumber(iter_2_1)

		if var_2_7 then
			table.insert({}, var_2_7)
		end
	end

	local var_2_8 = var_2_0[4] or ""

	;({
		track_typ = var_2_3,
		track_time = var_2_5,
		int_args = {}
	}).str_args = string.split(var_2_8, var_0_2)

	return {
		track_typ = var_2_3,
		track_time = var_2_5,
		int_args = {}
	}
end

local function var_0_3(arg_3_0, arg_3_1, arg_3_2)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		table.insert({}, tonumber(iter_3_1 .. ""))
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_2) do
		table.insert({}, tostring(iter_3_3))
	end

	return {
		track_typ = arg_3_0,
		track_time = pg.TimeMgr.GetInstance():GetServerTime(),
		int_args = {},
		str_args = {}
	}
end

function var_0_0.BuildStoryStart(arg_4_0, arg_4_1)
	return var_0_3(18, {
		1,
		arg_4_0,
		arg_4_1
	}, {})
end

function var_0_0.BuildStorySkip(arg_5_0, arg_5_1)
	return var_0_3(18, {
		2,
		arg_5_0,
		arg_5_1
	}, {})
end

function var_0_0.BuildNotice(arg_6_0)
	return var_0_3(19, {}, {
		arg_6_0
	})
end

function var_0_0.BuildStoryOption(arg_7_0, arg_7_1)
	return var_0_3(20, {
		arg_7_0
	}, {
		arg_7_1
	})
end

function var_0_0.BuildEmoji(arg_8_0)
	local var_8_0 = tonumber((arg_8_0:match("777#(%d+)#777")))

	if var_8_0 and var_8_0 > 0 then
		return var_0_3(21, {
			var_8_0
		}, {})
	else
		return var_0_3(21, {
			0
		}, {})
	end

	return
end

function var_0_0.BuildExitSilentView(arg_9_0, arg_9_1, arg_9_2)
	return var_0_3(22, {
		arg_9_0,
		arg_9_1
	}, {
		arg_9_2
	})
end

function var_0_0.BuildTouchBanner(arg_10_0)
	return var_0_3(23, {}, {
		arg_10_0
	})
end

function var_0_0.BuildSwitchPainting(arg_11_0, arg_11_1)
	return var_0_3(24, {
		arg_11_0,
		arg_11_1
	}, {})
end

function var_0_0.BuildHubGames(arg_12_0, arg_12_1, arg_12_2)
	return var_0_3(25, {
		arg_12_0,
		arg_12_1
	}, {
		arg_12_2
	})
end

function var_0_0.BuildUrRedeem(arg_13_0, arg_13_1)
	return var_0_3(26, {
		arg_13_0
	}, {
		arg_13_1
	})
end

function var_0_0.BuildUrJump(arg_14_0)
	return var_0_3(27, {}, {
		arg_14_0
	})
end

function var_0_0.BuildDorm3d(arg_15_0)
	return var_0_3(arg_15_0.track_typ, arg_15_0.int_args, arg_15_0.str_args)
end

function var_0_0.BuildNewEducate(arg_16_0)
	return var_0_3(arg_16_0.track_typ, arg_16_0.int_args, arg_16_0.str_args)
end

function var_0_0.BuildNewMainUI(arg_17_0)
	return var_0_3(28, {
		arg_17_0.isNewMainUI,
		arg_17_0.isLogin
	}, {})
end

function var_0_0.BuildGuide(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if arg_18_0 then
		return var_0_3(30, {
			arg_18_1,
			arg_18_2,
			arg_18_3
		}, {
			arg_18_4
		})
	else
		return var_0_3(29, {
			arg_18_1,
			arg_18_2,
			arg_18_3
		}, {
			arg_18_4
		})
	end

	return
end

function var_0_0.BuildPhantom(arg_19_0)
	return var_0_3(31, {
		arg_19_0
	}, {})
end

function var_0_0.BuildFushunAdventure()
	return var_0_3(35, {}, {})
end

function var_0_0.BuildAllCollection(arg_21_0, arg_21_1)
	return var_0_3(arg_21_0, {
		arg_21_1
	}, {})
end

function var_0_0.BuildIslandVisit(arg_22_0)
	if getProxy(FriendProxy):getFriend(arg_22_0) then
		return var_0_3(30046, {
			arg_22_0,
			1
		}, {})
	end

	local var_22_0 = getProxy(GuildProxy):getRawData()

	if var_22_0 and var_22_0:getMemberById(arg_22_0) then
		return var_0_3(30046, {
			arg_22_0,
			2
		}, {})
	end

	return nil
end

function var_0_0.BuildIslandVisitByCode()
	return var_0_3(30046, {
		0,
		3
	}, {})
end

function var_0_0.BuildIslandAgoraUpgrade(arg_24_0)
	return var_0_3(30010, {
		arg_24_0
	}, {})
end

function var_0_0.BuildIslandFurnitureAdd(arg_25_0, arg_25_1)
	return var_0_3(30040, {
		arg_25_0
	}, {
		arg_25_1
	})
end

function var_0_0.BuildIslandAgoraSave()
	return var_0_3(30041, {}, {})
end

function var_0_0.BuildIslandSignIn()
	return var_0_3(30006, {}, {})
end

function var_0_0.BuildIslandGetGift(arg_28_0)
	return var_0_3(30007, {
		arg_28_0
	}, {})
end

function var_0_0.BuildIslandInvitation(arg_29_0)
	if #arg_29_0 == 0 then
		return var_0_3(30008, {
			0
		}, {})
	else
		return var_0_3(30008, {
			2
		}, {})
	end

	return
end

function var_0_0.BuildIslandShareSignIn()
	return var_0_3(30008, {
		1
	}, {})
end

function var_0_0.BuildIslandUnlockMap(arg_31_0)
	return var_0_3(30004, {
		arg_31_0
	}, {})
end

function var_0_0.BuildMapExit(arg_32_0, arg_32_1)
	return var_0_3(30009, {
		arg_32_0,
		arg_32_1
	}, {})
end

function var_0_0.BuildIslandUnlockShip(arg_33_0)
	return var_0_3(30013, {
		arg_33_0
	}, {})
end

function var_0_0.BuildIslandShipUpgrade(arg_34_0, arg_34_1)
	return var_0_3(30014, {
		arg_34_0,
		arg_34_1
	}, {})
end

function var_0_0.BuildIslandShipBreakout(arg_35_0, arg_35_1)
	return var_0_3(30015, {
		arg_35_0,
		arg_35_1
	}, {})
end

function var_0_0.BuildIslandShipSkillUpgrade(arg_36_0, arg_36_1, arg_36_2)
	return var_0_3(30016, {
		arg_36_0,
		arg_36_1,
		arg_36_2
	}, {})
end

function var_0_0.BuildIslandShipAddBuff(arg_37_0, arg_37_1)
	return var_0_3(30019, {
		arg_37_0,
		arg_37_1
	}, {})
end

function var_0_0.BuildIslandShipGiveGift(arg_38_0, arg_38_1)
	return var_0_3(30020, {
		arg_38_0,
		arg_38_1
	}, {})
end

function var_0_0.BuildIslandShipAttrUpgrade(arg_39_0, arg_39_1)
	for iter_39_0, iter_39_1 in pairs(arg_39_1:GetAttrs()) do
		table.insert({}, string.format("{%s,%s}", iter_39_0, iter_39_1 - arg_39_0:GetAttr(iter_39_0)))
		table.insert({}, string.format("{%s,%s}", iter_39_0, iter_39_1))
	end

	return var_0_3(30017, {
		arg_39_0.id
	}, {
		table.concat({}, ","),
		(table.concat({}, ","))
	})
end

function var_0_0.BuildIslandShipAttrLimit(arg_40_0, arg_40_1)
	for iter_40_0, iter_40_1 in pairs(arg_40_1:GetAttrs()) do
		table.insert({}, string.format("{%s,%s,%s}", iter_40_0, arg_40_0:GetExtraAttrLimit(iter_40_0), (arg_40_1:GetExtraAttrLimit(iter_40_0))))
	end

	return var_0_3(30018, {
		arg_40_0.id
	}, {
		(table.concat({}, ","))
	})
end

function var_0_0.BuildIslandUpgrade(arg_41_0)
	return var_0_3(30003, {
		arg_41_0
	}, {})
end

function var_0_0.BuildIslandInventoryUpgrade(arg_42_0)
	return var_0_3(30011, {
		arg_42_0
	}, {})
end

function var_0_0.BuildIslandInventoryChange(arg_43_0, arg_43_1, arg_43_2)
	return var_0_3(30012, {
		arg_43_0,
		arg_43_1,
		arg_43_2
	}, {})
end

function var_0_0.BuildIslandSubmitOrder(arg_44_0, arg_44_1)
	return var_0_3(30031, {
		arg_44_0,
		arg_44_1
	}, {})
end

function var_0_0.BuildIslandGuide(arg_45_0, arg_45_1, arg_45_2)
	return var_0_3(30001, {
		arg_45_0,
		arg_45_1
	}, {
		arg_45_2
	})
end

function var_0_0.BuildIslandRestUpgrade(arg_46_0, arg_46_1)
	return var_0_3(30050, {
		arg_46_0,
		arg_46_1
	}, {})
end

function var_0_0.BuildIslandDeviceBanner(arg_47_0)
	return var_0_3(30005, {
		arg_47_0
	}, {})
end

function var_0_0.BuildIslandEnter(arg_48_0, arg_48_1)
	return var_0_3(30002, {
		arg_48_0,
		arg_48_1
	}, {})
end

function var_0_0.BuildIslandTechImmd(arg_49_0)
	return var_0_3(30034, {
		arg_49_0
	}, {})
end

function var_0_0.BuildIslandWildGather(arg_50_0)
	return var_0_3(30021, {
		arg_50_0
	}, {})
end

function var_0_0.BuildIslandWildCollect(arg_51_0)
	return var_0_3(30042, {
		arg_51_0
	}, {})
end

function var_0_0.BuildIslandGetDress(arg_52_0, arg_52_1)
	return var_0_3(30037, {
		arg_52_0,
		arg_52_1
	}, {})
end

function var_0_0.BuildIslandBindDress(arg_53_0, arg_53_1)
	return var_0_3(30038, {
		arg_53_0,
		arg_53_1
	}, {})
end

function var_0_0.BuildIslandWearDress(arg_54_0, arg_54_1)
	local var_54_0 = "["

	for iter_54_0, iter_54_1 in ipairs(arg_54_1) do
		var_54_0 = var_54_0 .. string.format("{\"type\":%d,\"id\":%d}", pg.island_dress_template[iter_54_1.dress_id].type, iter_54_1.dress_id)

		if iter_54_0 ~= #arg_54_1 then
			var_54_0 = var_54_0 .. ","
		end
	end

	return var_0_3(30039, {
		arg_54_0
	}, {
		var_54_0 .. "]"
	})
end

function var_0_0.BuildIslandStartDelegation(arg_55_0, arg_55_1, arg_55_2, arg_55_3, arg_55_4)
	return var_0_3(30022, {
		arg_55_0,
		arg_55_1,
		arg_55_2,
		arg_55_3,
		arg_55_4
	}, {})
end

function var_0_0.BuildIslandGetDelegationAward(arg_56_0, arg_56_1)
	local var_56_0 = "["

	for iter_56_0, iter_56_1 in ipairs(arg_56_1) do
		var_56_0 = var_56_0 .. string.format("{\"type\":%d,\"id\":%d,\"num\":%d}", iter_56_1.type, iter_56_1.id, iter_56_1.number)

		if iter_56_0 ~= #arg_56_1 then
			var_56_0 = var_56_0 .. ","
		end
	end

	return var_0_3(30023, {
		arg_56_0
	}, {
		var_56_0 .. "]"
	})
end

function var_0_0.BuildIslandShopBuy(arg_57_0, arg_57_1)
	return var_0_3(30035, {
		arg_57_0,
		arg_57_1
	}, {})
end

function var_0_0.BuildIslandUnlockColor(arg_58_0, arg_58_1)
	return var_0_3(30051, {
		arg_58_0,
		arg_58_1
	}, {})
end

function var_0_0.BuildActionOp(arg_59_0, arg_59_1, arg_59_2, arg_59_3, arg_59_4, arg_59_5)
	return var_0_3(30062, {
		arg_59_0,
		arg_59_1,
		arg_59_2,
		arg_59_3,
		arg_59_5,
		arg_59_4
	}, {})
end

function var_0_0.BuildIslandCloseRest(arg_60_0, arg_60_1)
	local var_60_0 = "["

	for iter_60_0, iter_60_1 in ipairs(arg_60_1) do
		var_60_0 = var_60_0 .. string.format("{\"type\":%d,\"id\":%d,\"num\":%d}", iter_60_1.type, iter_60_1.id, iter_60_1.number)

		if iter_60_0 ~= #arg_60_1 then
			var_60_0 = var_60_0 .. ","
		end
	end

	return var_0_3(30059, {
		arg_60_0
	}, {
		var_60_0 .. "]"
	})
end

function var_0_0.BuildIslandTakeThoto(arg_61_0)
	return var_0_3(30060, {
		arg_61_0
	}, {})
end

function var_0_0.BuildIslandFishingEnter(arg_62_0)
	return var_0_3(30065, {
		arg_62_0,
		0,
		0
	}, {})
end

function var_0_0.BuildIslandFishingExit(arg_63_0, arg_63_1)
	return var_0_3(30065, {
		arg_63_0,
		1,
		arg_63_1
	}, {})
end

function var_0_0.BuildIslandFishingChangeLure(arg_64_0, arg_64_1, arg_64_2)
	return var_0_3(30066, {
		arg_64_0,
		arg_64_1,
		arg_64_2
	}, {})
end

function var_0_0.BuildIslandFishingResult(arg_65_0, arg_65_1, arg_65_2, arg_65_3, arg_65_4, arg_65_5, arg_65_6, arg_65_7, arg_65_8, arg_65_9)
	return var_0_3(30067, {
		arg_65_0,
		arg_65_1,
		arg_65_2,
		arg_65_3,
		arg_65_4,
		arg_65_5,
		arg_65_6,
		arg_65_7,
		arg_65_8,
		arg_65_9
	}, {})
end

function var_0_0.BuildIslandFishingCancel(arg_66_0, arg_66_1)
	return var_0_3(30068, {
		arg_66_0,
		arg_66_1
	}, {})
end

function var_0_0.BuildJuusOfficialAccountsClick(arg_67_0)
	return var_0_3(40002, {
		arg_67_0
	}, {})
end

function var_0_0.BuildPlayRoomInvate(arg_68_0, arg_68_1, arg_68_2)
	return var_0_3(30076, {
		arg_68_1,
		arg_68_2
	}, {
		arg_68_0
	})
end

function var_0_0.BuildPlayRoomMatch(arg_69_0, arg_69_1, arg_69_2, arg_69_3, arg_69_4)
	return var_0_3(30074, {
		arg_69_1,
		arg_69_2,
		arg_69_3,
		arg_69_4
	}, {
		arg_69_0
	})
end

function var_0_0.BuildCheaterTavernGame(arg_70_0, arg_70_1)
	return var_0_3(30072, {
		arg_70_0,
		arg_70_1
	}, {})
end

function var_0_0.BuildCheaterTavernResult(arg_71_0, arg_71_1, arg_71_2, arg_71_3, arg_71_4, arg_71_5)
	return var_0_3(30073, {
		arg_71_0,
		arg_71_1,
		arg_71_2,
		arg_71_3,
		arg_71_4,
		arg_71_5
	}, {})
end

function var_0_0.BuildAuctionEnter()
	return var_0_3(50001, {}, {})
end

function var_0_0.BuildAuctionHelp()
	return var_0_3(50002, {}, {})
end

function var_0_0.BuildPreorder(arg_74_0, arg_74_1)
	return var_0_3(50003, {
		arg_74_0,
		arg_74_1
	}, {})
end

function var_0_0.BuildNameCard(arg_75_0, arg_75_1)
	return var_0_3(50004, {
		arg_75_0,
		arg_75_1
	}, {})
end

function var_0_0.BuildAuctionSettlement(arg_76_0, arg_76_1, arg_76_2, arg_76_3, arg_76_4, arg_76_5)
	return var_0_3(50005, {
		arg_76_1,
		arg_76_2,
		arg_76_3,
		arg_76_4,
		arg_76_5
	}, {
		arg_76_0
	})
end

function var_0_0.BuildAuctionMatching(arg_77_0, arg_77_1, arg_77_2)
	return var_0_3(50006, {
		arg_77_0,
		arg_77_1,
		arg_77_2
	}, {})
end

function var_0_0.BuildAuctionChooseEvent(arg_78_0, arg_78_1, arg_78_2, arg_78_3)
	return var_0_3(50007, {
		arg_78_0,
		arg_78_1,
		arg_78_2,
		arg_78_3
	}, {})
end

function var_0_0.BuildAuctionBid(arg_79_0, arg_79_1, arg_79_2, arg_79_3, arg_79_4)
	return var_0_3(50008, {
		arg_79_0,
		arg_79_1,
		arg_79_2,
		arg_79_3,
		arg_79_4
	}, {})
end

function var_0_0.BuildAuctionFinish(arg_80_0, arg_80_1, arg_80_2)
	return var_0_3(50009, {
		arg_80_0,
		arg_80_1,
		arg_80_2
	}, {})
end

function var_0_0.BuildAuctionExit(arg_81_0, arg_81_1)
	return var_0_3(50010, {
		arg_81_0,
		arg_81_1
	}, {})
end

return var_0_0
