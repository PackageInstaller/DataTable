class = var_0_10000

local var_0_0 = "Cryptolalia"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

var_0_1.STATE_LOCK = 1
var_0_1.STATE_DOWNLOADABLE = 2
var_0_1.STATE_PLAYABLE = 3
var_0_1.STATE_DOWNLOADING = 4
var_0_1.COST_TYPE_GEM = 1
var_0_1.COST_TYPE_TICKET = 2
var_0_1.LANG_TYPE_JP = 0
var_0_1.LANG_TYPE_CH = 1

function var_0_1.GetAssetBundlePath(arg_1_0)
	local var_1_0 = var_0_1.BuildCpkPath(arg_1_0)

	PathMgr = var_1_10002

	return var_1_10002.getAssetBundle(var_1_0)
end

function var_0_1.GetSubtitleAssetBundlePath(arg_2_0)
	local var_2_0 = var_0_1.BuildSubtitlePath(arg_2_0)

	PathMgr = var_1_10002

	return var_1_10002.getAssetBundle(var_2_0)
end

function var_0_1.BuildCpkPath(arg_3_0)
	local var_3_0 = "originsource/cipher/"

	string = var_1_10002

	return var_3_0 .. var_1_10002.lower(arg_3_0) .. ".cpk"
end

function var_0_1.BuildSubtitlePath(arg_4_0)
	local var_4_0 = "originsource/cipher/"

	string = var_1_10002

	return var_4_0 .. var_1_10002.lower(arg_4_0) .. ".txt"
end

function var_0_1.Ctor(arg_5_0, arg_5_1)
	arg_5_0.id = arg_5_1.id
	arg_5_0.configId = arg_5_1.id
	arg_5_0.lock = true
	arg_5_0.sizes = {}

	return
end

function var_0_1.GetState(arg_6_0, arg_6_1)
	if not arg_6_0:IsLock() then
		if arg_6_0:IsDownloadRes(arg_6_1) then
			return var_0_1.STATE_PLAYABLE
		else
			return var_0_1.STATE_DOWNLOADABLE
		end
	else
		return var_0_1.STATE_LOCK
	end

	return
end

function var_0_1.IsEmpty(arg_7_0)
	return arg_7_0 == nil or arg_7_0 == ""
end

function var_0_1.GetDefaultLangType(arg_8_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CH = var_1_10002

	if var_1_10001 ~= var_1_10002 then
		PLATFORM_CHT = var_1_10001

		if var_1_10001 then
			if not var_0_1.IsEmpty(arg_8_0:GetCnCpkName()) then
				return var_0_1.LANG_TYPE_CH
			end

			if not var_0_1.IsEmpty(arg_8_0:GetJpCpkName()) then
				return var_0_1.LANG_TYPE_JP
			end
		else
			if not var_0_1.IsEmpty(arg_8_0:GetJpCpkName()) then
				return var_0_1.LANG_TYPE_JP
			end

			if not var_0_1.IsEmpty(arg_8_0:GetCnCpkName()) then
				return var_0_1.LANG_TYPE_CH
			end
		end

		return
	end
end

function var_0_1.IsDownloadableState(arg_9_0, arg_9_1)
	return arg_9_0:GetState(arg_9_1) == var_0_1.STATE_DOWNLOADABLE
end

function var_0_1.IsPlayableState(arg_10_0, arg_10_1)
	return arg_10_0:GetState(arg_10_1) == var_0_1.STATE_PLAYABLE
end

function var_0_1.IsDownloadRes(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.GetCpkName(var_11_0, arg_11_1)
	local var_11_2 = var_0_1.BuildCpkPath(var_11_1)

	pg = var_11_0

	local var_11_3 = var_11_0.CipherGroupMgr.GetInstance()

	return var_4.isCipherExist(var_11_3, var_11_2)
end

function var_0_1.IsDownloadAllRes(arg_12_0)
	if arg_12_0:IsMultiVersion() then
		local var_12_0

		if arg_12_0:IsDownloadRes(var_0_1.LANG_TYPE_CH) then
			var_12_0 = arg_12_0:IsDownloadRes(var_0_1.LANG_TYPE_JP)
		end

		return var_12_0
	elseif arg_12_0:OnlyChVersion() then
		return arg_12_0:IsDownloadRes(var_0_1.LANG_TYPE_CH)
	elseif arg_12_0:OnlyJpVersion() then
		return arg_12_0:IsDownloadRes(var_0_1.LANG_TYPE_JP)
	end

	return
end

function var_0_1.IsLockState(arg_13_0, arg_13_1)
	return arg_13_0:GetState(arg_13_1) == var_0_1.STATE_LOCK
end

function var_0_1.Unlock(arg_14_0)
	arg_14_0.lock = false

	return
end

function var_0_1.IsLock(arg_15_0)
	return arg_15_0.lock
end

function var_0_1.bindConfigTable(arg_16_0)
	pg = var_1_10001

	return var_1_10001.soundstory_template
end

function var_0_1.GetName(arg_17_0)
	return arg_17_0:getConfig("name")
end

function var_0_1.GetDescription(arg_18_0)
	return arg_18_0:getConfig("overview")
end

function var_0_1.GetCnCvAuthor(arg_19_0)
	return arg_19_0:getConfig("CV_CN")
end

function var_0_1.GetJpCvAuthor(arg_20_0)
	return arg_20_0:getConfig("CV_JP")
end

function var_0_1.GetCvAuthor(arg_21_0, arg_21_1)
	if arg_21_1 == var_0_1.LANG_TYPE_CH then
		return arg_21_0:GetCnCvAuthor()
	elseif arg_21_1 == var_0_1.LANG_TYPE_JP then
		return arg_21_0:GetJpCvAuthor()
	end

	return
end

function var_0_1.GetShipGroupId(arg_22_0)
	return arg_22_0:getConfig("ship_id")
end

function var_0_1.IsSameGroup(arg_23_0, arg_23_1)
	return arg_23_0:GetShipGroupId() == arg_23_1
end

function var_0_1.GetShipName(arg_24_0)
	local var_24_0 = arg_24_0
	local var_24_1 = arg_24_0.GetShipGroupId(var_24_0)

	ShipGroup = var_1_10002

	local var_24_2 = var_1_10002.getDefaultShipConfig(var_24_1)

	HXSet = var_24_0

	return (var_24_0.hxLan(var_24_2.name))
end

function var_0_1.ShipIcon(arg_25_0)
	local var_25_0 = arg_25_0
	local var_25_1 = arg_25_0.GetShipGroupId(var_25_0)

	ShipGroup = var_1_10002

	local var_25_2 = var_1_10002.getDefaultShipConfig(var_25_1)

	pg = var_25_0

	return var_25_0.ship_skin_template[var_25_2.skin_id].prefab
end

function var_0_1.GetCnAudition(arg_26_0)
	return arg_26_0:getConfig("audition_resource_CN")
end

function var_0_1.GetJpAudition(arg_27_0)
	return arg_27_0:getConfig("audition_resource_JP")
end

function var_0_1.GetAudition(arg_28_0, arg_28_1)
	if arg_28_1 == var_0_1.LANG_TYPE_CH then
		return arg_28_0:GetCnAudition()
	elseif arg_28_1 == var_0_1.LANG_TYPE_JP then
		return arg_28_0:GetJpAudition()
	end

	return
end

function var_0_1.GetAuditionVoice(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:GetAudition(arg_29_1)

	if arg_29_1 == var_0_1.LANG_TYPE_CH then
		return var_29_0 .. "-CN"
	elseif arg_29_1 == var_0_1.LANG_TYPE_JP then
		return var_29_0 .. "-JP"
	end

	return
end

function var_0_1.GetAuditionTitle(arg_30_0)
	return arg_30_0:getConfig("audition_text")
end

function var_0_1.GetCnCpkName(arg_31_0)
	return arg_31_0:getConfig("story_resource_CN")
end

function var_0_1.GetJpCpkName(arg_32_0)
	return arg_32_0:getConfig("story_resource_JP")
end

function var_0_1.GetCpkName(arg_33_0, arg_33_1)
	if arg_33_1 == var_0_1.LANG_TYPE_CH then
		return arg_33_0:GetCnCpkName()
	elseif arg_33_1 == var_0_1.LANG_TYPE_JP then
		return arg_33_0:GetJpCpkName()
	end

	return
end

function var_0_1.IsMultiVersion(arg_34_0)
	return not var_0_1.IsEmpty(arg_34_0:GetCnCpkName()) and not var_0_1.IsEmpty(arg_34_0:GetJpCpkName())
end

function var_0_1.OnlyChVersion(arg_35_0)
	return not var_0_1.IsEmpty(arg_35_0:GetCnCpkName()) and var_0_1.IsEmpty(arg_35_0:GetJpCpkName())
end

function var_0_1.OnlyJpVersion(arg_36_0)
	return not var_0_1.IsEmpty(arg_36_0:GetJpCpkName()) and var_0_1.IsEmpty(arg_36_0:GetCnCpkName())
end

function var_0_1.ExistLang(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:GetCpkName(arg_37_1)

	return not var_0_1.IsEmpty(var_37_0)
end

function var_0_1.GetIcon(arg_38_0)
	return arg_38_0:getConfig("story_pic")
end

function var_0_1.GetCost(arg_39_0, arg_39_1)
	return arg_39_0:GetCostList()[arg_39_1]
end

function var_0_1.GetCostList(arg_40_0)
	local var_40_0 = arg_40_0:getConfig("cost" .. var_0_1.COST_TYPE_GEM)
	local var_40_1 = arg_40_0:getConfig("cost" .. var_0_1.COST_TYPE_TICKET)

	return {
		[var_0_1.COST_TYPE_GEM] = {
			type = var_40_0[1],
			id = var_40_0[2],
			count = var_40_0[3]
		},
		[var_0_1.COST_TYPE_TICKET] = {
			type = var_40_1[1],
			id = var_40_1[2],
			count = var_40_1[3]
		}
	}
end

function var_0_1.InTime(arg_41_0)
	local var_41_0 = arg_41_0:getConfig("time")

	pg = var_1_10002

	local var_41_1 = var_1_10002.TimeMgr.GetInstance()

	return var_2.inTime(var_41_1, var_41_0)
end

function var_0_1.IsExpired(arg_42_0)
	return not arg_42_0:InTime()
end

function var_0_1.GetSortIndex(arg_43_0)
	return arg_43_0:getConfig("order")
end

function var_0_1.IsForever(arg_44_0)
	local var_44_0 = arg_44_0:getConfig("time")

	type = var_1_10002

	return var_1_10002(var_44_0) == "string" and var_44_0 == "always"
end

function var_0_1.GetExpiredTimeStr(arg_45_0)
	if arg_45_0:InTime() and not arg_45_0:IsForever() then
		pg = var_1

		local var_45_0 = var_1.TimeMgr.GetInstance()
		local var_45_1 = var_1.GetServerTime(var_45_0)
		local var_45_2 = arg_45_0
		local var_45_3 = arg_45_0.getConfig(var_45_2, "time")[3]

		pg = var_45_2

		local var_45_4 = var_45_2.TimeMgr.GetInstance()
		local var_45_5

		if var_4.parseTimeFromConfig(var_45_4, var_45_3) - var_45_1 <= 0 then
			var_45_5 = ""
		else
			skinTimeStamp = var_45_5
			var_45_5 = var_45_5(var_5)
		end

		return var_45_5
	else
		return ""
	end

	return
end

local function var_0_2(arg_46_0)
	io = var_1_10001

	if var_1_10001.open(arg_46_0, "rb") then
		local var_46_0 = var_1:seek("end")

		var_1:close()

		return var_46_0
	else
		return nil
	end

	return
end

function var_0_1.ExistLocalFile(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_0
	local var_47_1 = arg_47_0.GetCpkName(var_47_0, arg_47_1)
	local var_47_2 = var_0_1.GetAssetBundlePath(var_47_1)

	PathMgr = var_47_0

	return var_47_0.FileExists(var_47_2)
end

function var_0_1.ExistLocalSubtitleFile(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_0
	local var_48_1 = arg_48_0.GetCpkName(var_48_0, arg_48_1)
	local var_48_2 = var_0_1.GetSubtitleAssetBundlePath(var_48_1)

	PathMgr = var_48_0

	return var_48_0.FileExists(var_48_2)
end

function var_0_1.GetResSize(arg_49_0, arg_49_1)
	if not arg_49_0:IsDownloadRes(arg_49_1) then
		return ""
	end

	if not arg_49_0.sizes[arg_49_1] and arg_49_0:ExistLocalFile(arg_49_1) then
		local var_49_0 = arg_49_0:GetCpkName(arg_49_1)
		local var_49_1 = var_0_1.GetAssetBundlePath(var_49_0)
		local var_49_2 = var_0_2(var_49_1)
		local var_49_3 = 0

		if arg_49_0:ExistLocalSubtitleFile(arg_49_1) then
			local var_49_4 = var_0_1.GetSubtitleAssetBundlePath(var_49_0)

			var_49_3 = var_0_2(var_49_4)
		end

		local var_49_5 = arg_49_0.sizes

		HashUtil = var_1_10007
		var_49_5[arg_49_1] = var_1_10007.BytesToString(var_49_2 + var_49_3)
	end

	local var_49_6

	if not arg_49_0.sizes[arg_49_1] then
		var_49_6 = 0
	end

	return var_49_6
end

function var_0_1.GetCaptionsColor(arg_50_0)
	return arg_50_0:getConfig("captions_color")
end

return var_0_1
