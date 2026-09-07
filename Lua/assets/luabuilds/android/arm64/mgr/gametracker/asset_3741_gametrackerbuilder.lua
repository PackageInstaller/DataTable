local GameTrackerBuilder = class("GameTrackerBuilder")
local var_0_1 = ";"
local var_0_2 = "`"

function GameTrackerBuilder:SerializedItem()
	local var_1_2 = {}

	var_1_2[1] = self.track_typ or ""
	var_1_2[2] = self.track_time or ""
	var_1_2[3] = table.concat(self.int_args or {}, var_0_2) or ""
	var_1_2[4] = table.concat(self.str_args or {}, var_0_2) or ""

	return table.concat(var_1_2, var_0_1)
end

function GameTrackerBuilder:DeSerializedItem()
	local var_2_0 = string.split(self, var_0_1)

	if #var_2_0 < 2 then
		return false
	end

	local var_2_1 = tonumber(var_2_0[1] or "")
	local var_2_2 = tonumber(var_2_0[2] or "")

	if var_2_1 == nil or var_2_2 == nil then
		return false
	end

	local var_2_3 = var_2_0[3]
	local var_2_4

	if not var_2_0[3] then
		var_2_3 = ""
		var_2_4 = {}
	end

	for iter_2_0, iter_2_1 in ipairs((string.split(var_2_3, var_0_2))) do
		local var_2_5 = tonumber(iter_2_1)

		if var_2_5 then
			table.insert(var_2_4, var_2_5)
		end
	end

	local var_2_6 = var_2_0[4]
	local var_2_7

	if not var_2_0[4] then
		var_2_6 = ""
		var_2_7 = {
			track_typ = var_2_1,
			track_time = var_2_2,
			int_args = var_2_4
		}
	end

	var_2_7.str_args = string.split(var_2_6, var_0_2)

	return var_2_7
end

local function var_0_3(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {}
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		table.insert(var_3_0, tonumber(iter_3_1 .. ""))
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_2) do
		table.insert(var_3_1, tostring(iter_3_3))
	end

	return {
		track_typ = arg_3_0,
		track_time = pg.TimeMgr.GetInstance():GetServerTime(),
		int_args = var_3_0,
		str_args = var_3_1
	}
end

function GameTrackerBuilder:BuildStoryStart(arg_4_1)
	return var_0_3(18, {
		1,
		self,
		arg_4_1
	}, {})
end

function GameTrackerBuilder:BuildStorySkip(arg_5_1)
	return var_0_3(18, {
		2,
		self,
		arg_5_1
	}, {})
end

function GameTrackerBuilder:BuildNotice()
	return var_0_3(19, {}, {
		self
	})
end

function GameTrackerBuilder:BuildStoryOption(arg_7_1)
	return var_0_3(20, {
		self
	}, {
		arg_7_1
	})
end

function GameTrackerBuilder:BuildEmoji()
	local var_8_0 = tonumber((self:match("777#(%d+)#777")))

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

function GameTrackerBuilder:BuildExitSilentView(arg_9_1, arg_9_2)
	return var_0_3(22, {
		self,
		arg_9_1
	}, {
		arg_9_2
	})
end

function GameTrackerBuilder:BuildTouchBanner()
	return var_0_3(23, {}, {
		self
	})
end

function GameTrackerBuilder:BuildSwitchPainting(arg_11_1)
	return var_0_3(24, {
		self,
		arg_11_1
	}, {})
end

function GameTrackerBuilder:BuildHubGames(arg_12_1, arg_12_2)
	return var_0_3(25, {
		self,
		arg_12_1
	}, {
		arg_12_2
	})
end

function GameTrackerBuilder:BuildUrRedeem(arg_13_1)
	return var_0_3(26, {
		self
	}, {
		arg_13_1
	})
end

function GameTrackerBuilder:BuildUrJump()
	return var_0_3(27, {}, {
		self
	})
end

function GameTrackerBuilder:BuildDorm3d()
	return var_0_3(self.track_typ, self.int_args, self.str_args)
end

function GameTrackerBuilder:BuildNewEducate()
	return var_0_3(self.track_typ, self.int_args, self.str_args)
end

function GameTrackerBuilder:BuildNewMainUI()
	return var_0_3(28, {
		self.isNewMainUI,
		self.isLogin
	}, {})
end

function GameTrackerBuilder:BuildGuide(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if self then
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

function GameTrackerBuilder:BuildPhantom()
	return var_0_3(31, {
		self
	}, {})
end

function GameTrackerBuilder.BuildFushunAdventure()
	return var_0_3(35, {}, {})
end

function GameTrackerBuilder:BuildAllCollection(arg_21_1)
	return var_0_3(self, {
		arg_21_1
	}, {})
end

function GameTrackerBuilder:BuildIslandVisit()
	if getProxy(FriendProxy):getFriend(self) then
		return var_0_3(30046, {
			self,
			1
		}, {})
	end

	local var_22_0 = getProxy(GuildProxy):getRawData()

	if var_22_0 and var_22_0:getMemberById(self) then
		return var_0_3(30046, {
			self,
			2
		}, {})
	end

	return nil
end

function GameTrackerBuilder.BuildIslandVisitByCode()
	return var_0_3(30046, {
		0,
		3
	}, {})
end

function GameTrackerBuilder:BuildIslandAgoraUpgrade()
	return var_0_3(30010, {
		self
	}, {})
end

function GameTrackerBuilder:BuildIslandFurnitureAdd(arg_25_1)
	return var_0_3(30040, {
		self
	}, {
		arg_25_1
	})
end

function GameTrackerBuilder.BuildIslandAgoraSave()
	return var_0_3(30041, {}, {})
end

function GameTrackerBuilder.BuildIslandSignIn()
	return var_0_3(30006, {}, {})
end

function GameTrackerBuilder:BuildIslandGetGift()
	return var_0_3(30007, {
		self
	}, {})
end

function GameTrackerBuilder:BuildIslandInvitation()
	if #self == 0 then
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

function GameTrackerBuilder.BuildIslandShareSignIn()
	return var_0_3(30008, {
		1
	}, {})
end

function GameTrackerBuilder:BuildIslandUnlockMap()
	return var_0_3(30004, {
		self
	}, {})
end

function GameTrackerBuilder:BuildMapExit(arg_32_1)
	return var_0_3(30009, {
		self,
		arg_32_1
	}, {})
end

function GameTrackerBuilder:BuildIslandUnlockShip()
	return var_0_3(30013, {
		self
	}, {})
end

function GameTrackerBuilder:BuildIslandShipUpgrade(arg_34_1)
	return var_0_3(30014, {
		self,
		arg_34_1
	}, {})
end

function GameTrackerBuilder:BuildIslandShipBreakout(arg_35_1)
	return var_0_3(30015, {
		self,
		arg_35_1
	}, {})
end

function GameTrackerBuilder:BuildIslandShipSkillUpgrade(arg_36_1, arg_36_2)
	return var_0_3(30016, {
		self,
		arg_36_1,
		arg_36_2
	}, {})
end

function GameTrackerBuilder:BuildIslandShipAddBuff(arg_37_1)
	return var_0_3(30019, {
		self,
		arg_37_1
	}, {})
end

function GameTrackerBuilder:BuildIslandShipGiveGift(arg_38_1)
	return var_0_3(30020, {
		self,
		arg_38_1
	}, {})
end

function GameTrackerBuilder:BuildIslandShipAttrUpgrade(arg_39_1)
	local var_39_0 = {}
	local var_39_1 = {}

	for iter_39_0, iter_39_1 in pairs(arg_39_1:GetAttrs()) do
		table.insert(var_39_0, string.format("{%s,%s}", iter_39_0, iter_39_1 - self:GetAttr(iter_39_0)))
		table.insert(var_39_1, string.format("{%s,%s}", iter_39_0, iter_39_1))
	end

	return var_0_3(30017, {
		self.id
	}, {
		table.concat(var_39_0, ","),
		(table.concat(var_39_1, ","))
	})
end

function GameTrackerBuilder:BuildIslandShipAttrLimit(arg_40_1)
	local var_40_0 = {}

	for iter_40_0, iter_40_1 in pairs(arg_40_1:GetAttrs()) do
		table.insert(var_40_0, string.format("{%s,%s,%s}", iter_40_0, self:GetExtraAttrLimit(iter_40_0), (arg_40_1:GetExtraAttrLimit(iter_40_0))))
	end

	return var_0_3(30018, {
		self.id
	}, {
		(table.concat(var_40_0, ","))
	})
end

function GameTrackerBuilder:BuildIslandUpgrade()
	return var_0_3(30003, {
		self
	}, {})
end

function GameTrackerBuilder:BuildIslandInventoryUpgrade()
	return var_0_3(30011, {
		self
	}, {})
end

function GameTrackerBuilder:BuildIslandInventoryChange(arg_43_1, arg_43_2)
	return var_0_3(30012, {
		self,
		arg_43_1,
		arg_43_2
	}, {})
end

function GameTrackerBuilder:BuildIslandSubmitOrder(arg_44_1)
	return var_0_3(30031, {
		self,
		arg_44_1
	}, {})
end

function GameTrackerBuilder:BuildIslandGuide(arg_45_1, arg_45_2)
	return var_0_3(30001, {
		self,
		arg_45_1
	}, {
		arg_45_2
	})
end

function GameTrackerBuilder:BuildIslandRestUpgrade(arg_46_1)
	return var_0_3(30050, {
		self,
		arg_46_1
	}, {})
end

function GameTrackerBuilder:BuildIslandDeviceBanner()
	return var_0_3(30005, {
		self
	}, {})
end

function GameTrackerBuilder:BuildIslandEnter(arg_48_1)
	return var_0_3(30002, {
		self,
		arg_48_1
	}, {})
end

function GameTrackerBuilder:BuildIslandTechImmd()
	return var_0_3(30034, {
		self
	}, {})
end

function GameTrackerBuilder:BuildIslandWildGather()
	return var_0_3(30021, {
		self
	}, {})
end

function GameTrackerBuilder:BuildIslandWildCollect()
	return var_0_3(30042, {
		self
	}, {})
end

function GameTrackerBuilder:BuildIslandGetDress(arg_52_1)
	return var_0_3(30037, {
		self,
		arg_52_1
	}, {})
end

function GameTrackerBuilder:BuildIslandBindDress(arg_53_1)
	return var_0_3(30038, {
		self,
		arg_53_1
	}, {})
end

function GameTrackerBuilder:BuildIslandWearDress(arg_54_1)
	local var_54_0 = "["

	for iter_54_0, iter_54_1 in ipairs(arg_54_1) do
		var_54_0 = var_54_0 .. string.format("{\"type\":%d,\"id\":%d}", pg.island_dress_template[iter_54_1.dress_id].type, iter_54_1.dress_id)

		if iter_54_0 ~= #arg_54_1 then
			var_54_0 = var_54_0 .. ","
		end
	end

	return var_0_3(30039, {
		self
	}, {
		var_54_0 .. "]"
	})
end

function GameTrackerBuilder:BuildIslandStartDelegation(arg_55_1, arg_55_2, arg_55_3, arg_55_4)
	return var_0_3(30022, {
		self,
		arg_55_1,
		arg_55_2,
		arg_55_3,
		arg_55_4
	}, {})
end

function GameTrackerBuilder:BuildIslandGetDelegationAward(arg_56_1)
	local var_56_0 = "["

	for iter_56_0, iter_56_1 in ipairs(arg_56_1) do
		var_56_0 = var_56_0 .. string.format("{\"type\":%d,\"id\":%d,\"num\":%d}", iter_56_1.type, iter_56_1.id, iter_56_1.number)

		if iter_56_0 ~= #arg_56_1 then
			var_56_0 = var_56_0 .. ","
		end
	end

	return var_0_3(30023, {
		self
	}, {
		var_56_0 .. "]"
	})
end

function GameTrackerBuilder:BuildIslandShopBuy(arg_57_1)
	return var_0_3(30035, {
		self,
		arg_57_1
	}, {})
end

function GameTrackerBuilder:BuildIslandUnlockColor(arg_58_1)
	return var_0_3(30051, {
		self,
		arg_58_1
	}, {})
end

function GameTrackerBuilder:BuildActionOp(arg_59_1, arg_59_2, arg_59_3, arg_59_4, arg_59_5)
	return var_0_3(30062, {
		self,
		arg_59_1,
		arg_59_2,
		arg_59_3,
		arg_59_5,
		arg_59_4
	}, {})
end

function GameTrackerBuilder:BuildIslandCloseRest(arg_60_1)
	local var_60_0 = "["

	for iter_60_0, iter_60_1 in ipairs(arg_60_1) do
		var_60_0 = var_60_0 .. string.format("{\"type\":%d,\"id\":%d,\"num\":%d}", iter_60_1.type, iter_60_1.id, iter_60_1.number)

		if iter_60_0 ~= #arg_60_1 then
			var_60_0 = var_60_0 .. ","
		end
	end

	return var_0_3(30059, {
		self
	}, {
		var_60_0 .. "]"
	})
end

function GameTrackerBuilder:BuildIslandTakeThoto()
	return var_0_3(30060, {
		self
	}, {})
end

function GameTrackerBuilder:BuildIslandFishingEnter()
	return var_0_3(30065, {
		self,
		0,
		0
	}, {})
end

function GameTrackerBuilder:BuildIslandFishingExit(arg_63_1)
	return var_0_3(30065, {
		self,
		1,
		arg_63_1
	}, {})
end

function GameTrackerBuilder:BuildIslandFishingChangeLure(arg_64_1, arg_64_2)
	return var_0_3(30066, {
		self,
		arg_64_1,
		arg_64_2
	}, {})
end

function GameTrackerBuilder:BuildIslandFishingResult(arg_65_1, arg_65_2, arg_65_3, arg_65_4, arg_65_5, arg_65_6, arg_65_7, arg_65_8, arg_65_9)
	return var_0_3(30067, {
		self,
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

function GameTrackerBuilder:BuildIslandFishingCancel(arg_66_1)
	return var_0_3(30068, {
		self,
		arg_66_1
	}, {})
end

function GameTrackerBuilder:BuildJuusOfficialAccountsClick()
	return var_0_3(40002, {
		self
	}, {})
end

function GameTrackerBuilder:BuildPlayRoomInvate(arg_68_1, arg_68_2)
	return var_0_3(30076, {
		arg_68_1,
		arg_68_2
	}, {
		self
	})
end

function GameTrackerBuilder:BuildPlayRoomMatch(arg_69_1, arg_69_2, arg_69_3, arg_69_4)
	return var_0_3(30074, {
		arg_69_1,
		arg_69_2,
		arg_69_3,
		arg_69_4
	}, {
		self
	})
end

function GameTrackerBuilder:BuildCheaterTavernGame(arg_70_1)
	return var_0_3(30072, {
		self,
		arg_70_1
	}, {})
end

function GameTrackerBuilder:BuildCheaterTavernResult(arg_71_1, arg_71_2, arg_71_3, arg_71_4, arg_71_5)
	return var_0_3(30073, {
		self,
		arg_71_1,
		arg_71_2,
		arg_71_3,
		arg_71_4,
		arg_71_5
	}, {})
end

function GameTrackerBuilder.BuildAuctionEnter()
	return var_0_3(50001, {}, {})
end

function GameTrackerBuilder.BuildAuctionHelp()
	return var_0_3(50002, {}, {})
end

function GameTrackerBuilder:BuildPreorder(arg_74_1)
	return var_0_3(50003, {
		self,
		arg_74_1
	}, {})
end

function GameTrackerBuilder:BuildNameCard(arg_75_1)
	return var_0_3(50004, {
		self,
		arg_75_1
	}, {})
end

function GameTrackerBuilder:BuildAuctionSettlement(arg_76_1, arg_76_2, arg_76_3, arg_76_4, arg_76_5)
	return var_0_3(50005, {
		arg_76_1,
		arg_76_2,
		arg_76_3,
		arg_76_4,
		arg_76_5
	}, {
		self
	})
end

function GameTrackerBuilder:BuildAuctionMatching(arg_77_1, arg_77_2)
	return var_0_3(50006, {
		self,
		arg_77_1,
		arg_77_2
	}, {})
end

function GameTrackerBuilder:BuildAuctionChooseEvent(arg_78_1, arg_78_2, arg_78_3)
	return var_0_3(50007, {
		self,
		arg_78_1,
		arg_78_2,
		arg_78_3
	}, {})
end

function GameTrackerBuilder:BuildAuctionBid(arg_79_1, arg_79_2, arg_79_3, arg_79_4)
	return var_0_3(50008, {
		self,
		arg_79_1,
		arg_79_2,
		arg_79_3,
		arg_79_4
	}, {})
end

function GameTrackerBuilder:BuildAuctionFinish(arg_80_1, arg_80_2)
	return var_0_3(50009, {
		self,
		arg_80_1,
		arg_80_2
	}, {})
end

function GameTrackerBuilder:BuildAuctionExit(arg_81_1)
	return var_0_3(50010, {
		self,
		arg_81_1
	}, {})
end

return GameTrackerBuilder
