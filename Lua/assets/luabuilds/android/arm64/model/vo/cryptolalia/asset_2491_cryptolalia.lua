local Cryptolalia = class("Cryptolalia", import("model.vo.BaseVO"))

Cryptolalia.STATE_LOCK = 1
Cryptolalia.STATE_DOWNLOADABLE = 2
Cryptolalia.STATE_PLAYABLE = 3
Cryptolalia.STATE_DOWNLOADING = 4
Cryptolalia.COST_TYPE_GEM = 1
Cryptolalia.COST_TYPE_TICKET = 2
Cryptolalia.LANG_TYPE_JP = 0
Cryptolalia.LANG_TYPE_CH = 1

function Cryptolalia:GetAssetBundlePath()
	return PathMgr.getAssetBundle((Cryptolalia.BuildCpkPath(self)))
end

function Cryptolalia:GetSubtitleAssetBundlePath()
	return PathMgr.getAssetBundle((Cryptolalia.BuildSubtitlePath(self)))
end

function Cryptolalia:BuildCpkPath()
	return "originsource/cipher/" .. string.lower(self) .. ".cpk"
end

function Cryptolalia:BuildSubtitlePath()
	return "originsource/cipher/" .. string.lower(self) .. ".txt"
end

function Cryptolalia:Ctor(arg_5_1)
	self.id = arg_5_1.id
	self.configId = arg_5_1.id
	self.lock = true
	self.sizes = {}

	return
end

function Cryptolalia:GetState(arg_6_1)
	if not self:IsLock() then
		if self:IsDownloadRes(arg_6_1) then
			return Cryptolalia.STATE_PLAYABLE
		else
			return Cryptolalia.STATE_DOWNLOADABLE
		end
	else
		return Cryptolalia.STATE_LOCK
	end

	return
end

function Cryptolalia:IsEmpty()
	return self == nil or self == ""
end

function Cryptolalia:GetDefaultLangType()
	if PLATFORM_CODE == PLATFORM_CH or PLATFORM_CHT then
		if not Cryptolalia.IsEmpty(self:GetCnCpkName()) then
			return Cryptolalia.LANG_TYPE_CH
		end

		if not Cryptolalia.IsEmpty(self:GetJpCpkName()) then
			return Cryptolalia.LANG_TYPE_JP
		end
	else
		if not Cryptolalia.IsEmpty(self:GetJpCpkName()) then
			return Cryptolalia.LANG_TYPE_JP
		end

		if not Cryptolalia.IsEmpty(self:GetCnCpkName()) then
			return Cryptolalia.LANG_TYPE_CH
		end
	end

	return
end

function Cryptolalia:IsDownloadableState(arg_9_1)
	return self:GetState(arg_9_1) == Cryptolalia.STATE_DOWNLOADABLE
end

function Cryptolalia:IsPlayableState(arg_10_1)
	return self:GetState(arg_10_1) == Cryptolalia.STATE_PLAYABLE
end

function Cryptolalia:IsDownloadRes(arg_11_1)
	return pg.CipherGroupMgr.GetInstance():isCipherExist((Cryptolalia.BuildCpkPath((self:GetCpkName(arg_11_1)))))
end

function Cryptolalia:IsDownloadAllRes()
	if self:IsMultiVersion() then
		return self:IsDownloadRes(Cryptolalia.LANG_TYPE_CH) and self:IsDownloadRes(Cryptolalia.LANG_TYPE_JP)
	elseif self:OnlyChVersion() then
		return self:IsDownloadRes(Cryptolalia.LANG_TYPE_CH)
	elseif self:OnlyJpVersion() then
		return self:IsDownloadRes(Cryptolalia.LANG_TYPE_JP)
	end

	return
end

function Cryptolalia:IsLockState(arg_13_1)
	return self:GetState(arg_13_1) == Cryptolalia.STATE_LOCK
end

function Cryptolalia:Unlock()
	self.lock = false

	return
end

function Cryptolalia:IsLock()
	return self.lock
end

function Cryptolalia:bindConfigTable()
	return pg.soundstory_template
end

function Cryptolalia:GetName()
	return self:getConfig("name")
end

function Cryptolalia:GetDescription()
	return self:getConfig("overview")
end

function Cryptolalia:GetCnCvAuthor()
	return self:getConfig("CV_CN")
end

function Cryptolalia:GetJpCvAuthor()
	return self:getConfig("CV_JP")
end

function Cryptolalia:GetCvAuthor(arg_21_1)
	if arg_21_1 == Cryptolalia.LANG_TYPE_CH then
		return self:GetCnCvAuthor()
	elseif arg_21_1 == Cryptolalia.LANG_TYPE_JP then
		return self:GetJpCvAuthor()
	end

	return
end

function Cryptolalia:GetShipGroupId()
	return self:getConfig("ship_id")
end

function Cryptolalia:IsSameGroup(arg_23_1)
	return self:GetShipGroupId() == arg_23_1
end

function Cryptolalia:GetShipName()
	return (HXSet.hxLan(ShipGroup.getDefaultShipConfig((self:GetShipGroupId())).name))
end

function Cryptolalia:ShipIcon()
	return pg.ship_skin_template[ShipGroup.getDefaultShipConfig((self:GetShipGroupId())).skin_id].prefab
end

function Cryptolalia:GetCnAudition()
	return self:getConfig("audition_resource_CN")
end

function Cryptolalia:GetJpAudition()
	return self:getConfig("audition_resource_JP")
end

function Cryptolalia:GetAudition(arg_28_1)
	if arg_28_1 == Cryptolalia.LANG_TYPE_CH then
		return self:GetCnAudition()
	elseif arg_28_1 == Cryptolalia.LANG_TYPE_JP then
		return self:GetJpAudition()
	end

	return
end

function Cryptolalia:GetAuditionVoice(arg_29_1)
	local var_29_0 = self:GetAudition(arg_29_1)

	if arg_29_1 == Cryptolalia.LANG_TYPE_CH then
		return var_29_0 .. "-CN"
	elseif arg_29_1 == Cryptolalia.LANG_TYPE_JP then
		return var_29_0 .. "-JP"
	end

	return
end

function Cryptolalia:GetAuditionTitle()
	return self:getConfig("audition_text")
end

function Cryptolalia:GetCnCpkName()
	return self:getConfig("story_resource_CN")
end

function Cryptolalia:GetJpCpkName()
	return self:getConfig("story_resource_JP")
end

function Cryptolalia:GetCpkName(arg_33_1)
	if arg_33_1 == Cryptolalia.LANG_TYPE_CH then
		return self:GetCnCpkName()
	elseif arg_33_1 == Cryptolalia.LANG_TYPE_JP then
		return self:GetJpCpkName()
	end

	return
end

function Cryptolalia:IsMultiVersion()
	return not Cryptolalia.IsEmpty(self:GetCnCpkName()) and not Cryptolalia.IsEmpty(self:GetJpCpkName())
end

function Cryptolalia:OnlyChVersion()
	return not Cryptolalia.IsEmpty(self:GetCnCpkName()) and Cryptolalia.IsEmpty(self:GetJpCpkName())
end

function Cryptolalia:OnlyJpVersion()
	return not Cryptolalia.IsEmpty(self:GetJpCpkName()) and Cryptolalia.IsEmpty(self:GetCnCpkName())
end

function Cryptolalia:ExistLang(arg_37_1)
	return not Cryptolalia.IsEmpty((self:GetCpkName(arg_37_1)))
end

function Cryptolalia:GetIcon()
	return self:getConfig("story_pic")
end

function Cryptolalia:GetCost(arg_39_1)
	return self:GetCostList()[arg_39_1]
end

function Cryptolalia:GetCostList()
	local var_40_0 = self:getConfig("cost" .. Cryptolalia.COST_TYPE_GEM)
	local var_40_1 = self:getConfig("cost" .. Cryptolalia.COST_TYPE_TICKET)

	return {
		[Cryptolalia.COST_TYPE_GEM] = {
			type = var_40_0[1],
			id = var_40_0[2],
			count = var_40_0[3]
		},
		[Cryptolalia.COST_TYPE_TICKET] = {
			type = var_40_1[1],
			id = var_40_1[2],
			count = var_40_1[3]
		}
	}
end

function Cryptolalia:InTime()
	return pg.TimeMgr.GetInstance():inTime((self:getConfig("time")))
end

function Cryptolalia:IsExpired()
	return not self:InTime()
end

function Cryptolalia:GetSortIndex()
	return self:getConfig("order")
end

function Cryptolalia:IsForever()
	local var_44_0 = self:getConfig("time")

	return type(var_44_0) == "string" and var_44_0 == "always"
end

function Cryptolalia:GetExpiredTimeStr()
	if self:InTime() and not self:IsForever() then
		local var_45_0 = pg.TimeMgr.GetInstance():parseTimeFromConfig(self:getConfig("time")[3]) - pg.TimeMgr.GetInstance():GetServerTime()

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

function Cryptolalia:ExistLocalFile(arg_47_1)
	return PathMgr.FileExists((Cryptolalia.GetAssetBundlePath((self:GetCpkName(arg_47_1)))))
end

function Cryptolalia:ExistLocalSubtitleFile(arg_48_1)
	return PathMgr.FileExists((Cryptolalia.GetSubtitleAssetBundlePath((self:GetCpkName(arg_48_1)))))
end

function Cryptolalia:GetResSize(arg_49_1)
	if not self:IsDownloadRes(arg_49_1) then
		return ""
	end

	if not self.sizes[arg_49_1] and self:ExistLocalFile(arg_49_1) then
		local var_49_0 = self:GetCpkName(arg_49_1)

		self.sizes[arg_49_1] = HashUtil.BytesToString(var_0_1((Cryptolalia.GetAssetBundlePath(var_49_0))) + ((self:ExistLocalSubtitleFile(arg_49_1) or nil) and var_0_1((Cryptolalia.GetSubtitleAssetBundlePath(var_49_0)))))
	end

	return self.sizes[arg_49_1] or 0
end

function Cryptolalia:GetCaptionsColor()
	return self:getConfig("captions_color")
end

return Cryptolalia
