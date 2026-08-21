local var_0_0 = class("Cryptolalia", import("model.vo.BaseVO"))

var_0_0.STATE_LOCK = 1
var_0_0.STATE_DOWNLOADABLE = 2
var_0_0.STATE_PLAYABLE = 3
var_0_0.STATE_DOWNLOADING = 4
var_0_0.COST_TYPE_GEM = 1
var_0_0.COST_TYPE_TICKET = 2
var_0_0.LANG_TYPE_JP = 0
var_0_0.LANG_TYPE_CH = 1

function var_0_0.GetAssetBundlePath(arg_1_0)
	return PathMgr.getAssetBundle((var_0_0.BuildCpkPath(arg_1_0)))
end

function var_0_0.GetSubtitleAssetBundlePath(arg_2_0)
	return PathMgr.getAssetBundle((var_0_0.BuildSubtitlePath(arg_2_0)))
end

function var_0_0.BuildCpkPath(arg_3_0)
	return "originsource/cipher/" .. string.lower(arg_3_0) .. ".cpk"
end

function var_0_0.BuildSubtitlePath(arg_4_0)
	return "originsource/cipher/" .. string.lower(arg_4_0) .. ".txt"
end

function var_0_0.Ctor(arg_5_0, arg_5_1)
	arg_5_0.id = arg_5_1.id
	arg_5_0.configId = arg_5_1.id
	arg_5_0.lock = true
	arg_5_0.sizes = {}

	return
end

function var_0_0.GetState(arg_6_0, arg_6_1)
	if not arg_6_0:IsLock() then
		if arg_6_0:IsDownloadRes(arg_6_1) then
			return var_0_0.STATE_PLAYABLE
		else
			return var_0_0.STATE_DOWNLOADABLE
		end
	else
		return var_0_0.STATE_LOCK
	end

	return
end

function var_0_0.IsEmpty(arg_7_0)
	return arg_7_0 == nil or arg_7_0 == ""
end

function var_0_0.GetDefaultLangType(arg_8_0)
	if PLATFORM_CODE == PLATFORM_CH or PLATFORM_CHT then
		if not var_0_0.IsEmpty(arg_8_0:GetCnCpkName()) then
			return var_0_0.LANG_TYPE_CH
		end

		if not var_0_0.IsEmpty(arg_8_0:GetJpCpkName()) then
			return var_0_0.LANG_TYPE_JP
		end
	else
		if not var_0_0.IsEmpty(arg_8_0:GetJpCpkName()) then
			return var_0_0.LANG_TYPE_JP
		end

		if not var_0_0.IsEmpty(arg_8_0:GetCnCpkName()) then
			return var_0_0.LANG_TYPE_CH
		end
	end

	return
end

function var_0_0.IsDownloadableState(arg_9_0, arg_9_1)
	return arg_9_0:GetState(arg_9_1) == var_0_0.STATE_DOWNLOADABLE
end

function var_0_0.IsPlayableState(arg_10_0, arg_10_1)
	return arg_10_0:GetState(arg_10_1) == var_0_0.STATE_PLAYABLE
end

function var_0_0.IsDownloadRes(arg_11_0, arg_11_1)
	return pg.CipherGroupMgr.GetInstance():isCipherExist((var_0_0.BuildCpkPath((arg_11_0:GetCpkName(arg_11_1)))))
end

function var_0_0.IsDownloadAllRes(arg_12_0)
	if arg_12_0:IsMultiVersion() then
		return arg_12_0:IsDownloadRes(var_0_0.LANG_TYPE_CH) and arg_12_0:IsDownloadRes(var_0_0.LANG_TYPE_JP)
	elseif arg_12_0:OnlyChVersion() then
		return arg_12_0:IsDownloadRes(var_0_0.LANG_TYPE_CH)
	elseif arg_12_0:OnlyJpVersion() then
		return arg_12_0:IsDownloadRes(var_0_0.LANG_TYPE_JP)
	end

	return
end

function var_0_0.IsLockState(arg_13_0, arg_13_1)
	return arg_13_0:GetState(arg_13_1) == var_0_0.STATE_LOCK
end

function var_0_0.Unlock(arg_14_0)
	arg_14_0.lock = false

	return
end

function var_0_0.IsLock(arg_15_0)
	return arg_15_0.lock
end

function var_0_0.bindConfigTable(arg_16_0)
	return pg.soundstory_template
end

function var_0_0.GetName(arg_17_0)
	return arg_17_0:getConfig("name")
end

function var_0_0.GetDescription(arg_18_0)
	return arg_18_0:getConfig("overview")
end

function var_0_0.GetCnCvAuthor(arg_19_0)
	return arg_19_0:getConfig("CV_CN")
end

function var_0_0.GetJpCvAuthor(arg_20_0)
	return arg_20_0:getConfig("CV_JP")
end

function var_0_0.GetCvAuthor(arg_21_0, arg_21_1)
	if arg_21_1 == var_0_0.LANG_TYPE_CH then
		return arg_21_0:GetCnCvAuthor()
	elseif arg_21_1 == var_0_0.LANG_TYPE_JP then
		return arg_21_0:GetJpCvAuthor()
	end

	return
end

function var_0_0.GetShipGroupId(arg_22_0)
	return arg_22_0:getConfig("ship_id")
end

function var_0_0.IsSameGroup(arg_23_0, arg_23_1)
	return arg_23_0:GetShipGroupId() == arg_23_1
end

function var_0_0.GetShipName(arg_24_0)
	return (HXSet.hxLan(ShipGroup.getDefaultShipConfig((arg_24_0:GetShipGroupId())).name))
end

function var_0_0.ShipIcon(arg_25_0)
	return pg.ship_skin_template[ShipGroup.getDefaultShipConfig((arg_25_0:GetShipGroupId())).skin_id].prefab
end

function var_0_0.GetCnAudition(arg_26_0)
	return arg_26_0:getConfig("audition_resource_CN")
end

function var_0_0.GetJpAudition(arg_27_0)
	return arg_27_0:getConfig("audition_resource_JP")
end

function var_0_0.GetAudition(arg_28_0, arg_28_1)
	if arg_28_1 == var_0_0.LANG_TYPE_CH then
		return arg_28_0:GetCnAudition()
	elseif arg_28_1 == var_0_0.LANG_TYPE_JP then
		return arg_28_0:GetJpAudition()
	end

	return
end

function var_0_0.GetAuditionVoice(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:GetAudition(arg_29_1)

	if arg_29_1 == var_0_0.LANG_TYPE_CH then
		return var_29_0 .. "-CN"
	elseif arg_29_1 == var_0_0.LANG_TYPE_JP then
		return var_29_0 .. "-JP"
	end

	return
end

function var_0_0.GetAuditionTitle(arg_30_0)
	return arg_30_0:getConfig("audition_text")
end

function var_0_0.GetCnCpkName(arg_31_0)
	return arg_31_0:getConfig("story_resource_CN")
end

function var_0_0.GetJpCpkName(arg_32_0)
	return arg_32_0:getConfig("story_resource_JP")
end

function var_0_0.GetCpkName(arg_33_0, arg_33_1)
	if arg_33_1 == var_0_0.LANG_TYPE_CH then
		return arg_33_0:GetCnCpkName()
	elseif arg_33_1 == var_0_0.LANG_TYPE_JP then
		return arg_33_0:GetJpCpkName()
	end

	return
end

function var_0_0.IsMultiVersion(arg_34_0)
	return not var_0_0.IsEmpty(arg_34_0:GetCnCpkName()) and not var_0_0.IsEmpty(arg_34_0:GetJpCpkName())
end

function var_0_0.OnlyChVersion(arg_35_0)
	return not var_0_0.IsEmpty(arg_35_0:GetCnCpkName()) and var_0_0.IsEmpty(arg_35_0:GetJpCpkName())
end

function var_0_0.OnlyJpVersion(arg_36_0)
	return not var_0_0.IsEmpty(arg_36_0:GetJpCpkName()) and var_0_0.IsEmpty(arg_36_0:GetCnCpkName())
end

function var_0_0.ExistLang(arg_37_0, arg_37_1)
	return not var_0_0.IsEmpty((arg_37_0:GetCpkName(arg_37_1)))
end

function var_0_0.GetIcon(arg_38_0)
	return arg_38_0:getConfig("story_pic")
end

function var_0_0.GetCost(arg_39_0, arg_39_1)
	return arg_39_0:GetCostList()[arg_39_1]
end

function var_0_0.GetCostList(arg_40_0)
	local var_40_0 = arg_40_0:getConfig("cost" .. var_0_0.COST_TYPE_GEM)
	local var_40_1 = arg_40_0:getConfig("cost" .. var_0_0.COST_TYPE_TICKET)

	return {
		[var_0_0.COST_TYPE_GEM] = {
			type = var_40_0[1],
			id = var_40_0[2],
			count = var_40_0[3]
		},
		[var_0_0.COST_TYPE_TICKET] = {
			type = var_40_1[1],
			id = var_40_1[2],
			count = var_40_1[3]
		}
	}
end

function var_0_0.InTime(arg_41_0)
	return pg.TimeMgr.GetInstance():inTime((arg_41_0:getConfig("time")))
end

function var_0_0.IsExpired(arg_42_0)
	return not arg_42_0:InTime()
end

function var_0_0.GetSortIndex(arg_43_0)
	return arg_43_0:getConfig("order")
end

function var_0_0.IsForever(arg_44_0)
	local var_44_0 = arg_44_0:getConfig("time")

	return type(var_44_0) == "string" and var_44_0 == "always"
end

function var_0_0.GetExpiredTimeStr(arg_45_0)
	if arg_45_0:InTime() and not arg_45_0:IsForever() then
		local var_45_0 = pg.TimeMgr.GetInstance():parseTimeFromConfig(arg_45_0:getConfig("time")[3]) - pg.TimeMgr.GetInstance():GetServerTime()

		return var_45_0 <= 0 and "" or skinTimeStamp(var_45_0)
	else
		return ""
	end

	return
end

local function var_0_1(arg_46_0)
	local var_46_0 = io.open(arg_46_0, "rb")

	if var_46_0 then
		var_46_0:close()

		return (var_46_0:seek("end"))
	else
		return nil
	end

	return
end

function var_0_0.ExistLocalFile(arg_47_0, arg_47_1)
	return PathMgr.FileExists((var_0_0.GetAssetBundlePath((arg_47_0:GetCpkName(arg_47_1)))))
end

function var_0_0.ExistLocalSubtitleFile(arg_48_0, arg_48_1)
	return PathMgr.FileExists((var_0_0.GetSubtitleAssetBundlePath((arg_48_0:GetCpkName(arg_48_1)))))
end

function var_0_0.GetResSize(arg_49_0, arg_49_1)
	if not arg_49_0:IsDownloadRes(arg_49_1) then
		return ""
	end

	if not arg_49_0.sizes[arg_49_1] and arg_49_0:ExistLocalFile(arg_49_1) then
		local var_49_0 = arg_49_0:GetCpkName(arg_49_1)
		local var_49_1 = 0

		if arg_49_0:ExistLocalSubtitleFile(arg_49_1) then
			var_49_1 = var_0_1((var_0_0.GetSubtitleAssetBundlePath(var_49_0)))
		end

		arg_49_0.sizes[arg_49_1] = HashUtil.BytesToString(var_0_1((var_0_0.GetAssetBundlePath(var_49_0))) + var_49_1)
	end

	return arg_49_0.sizes[arg_49_1] or 0
end

function var_0_0.GetCaptionsColor(arg_50_0)
	return arg_50_0:getConfig("captions_color")
end

return var_0_0
