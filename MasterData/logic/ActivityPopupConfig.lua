-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/config/ActivityPopupConfig.lua

module("logic.extensions.activitypopup.config.ActivityPopupConfig", package.seeall)

local ActivityPopupConfig = class("ActivityPopupConfig", BaseConfig)

function ActivityPopupConfig:onInit()
	ActivityPopupConfig.super.onInit(self)

	self._activityPopupCfg = nil
	self._campaignCfg = nil
	self._sortCampaignCfg = nil
	self._activityPopupJumpCfg = nil
end

function ActivityPopupConfig:getNames()
	return {
		"activitypopup",
		"campaign",
		"activitypopup_jump",
		"activity_auto_popup",
		"longyan_xixi_skin",
		"pay_auto_show_mall",
		"pay_auto_show_tab_mall",
		"platform_info",
		"longyan_xixi_multiple_skin",
		"longyan_xixi_common"
	}
end

function ActivityPopupConfig:handleConfig(name, content)
	if name == "activitypopup" then
		self._activityPopupCfg = content
	elseif name == "campaign" then
		self._campaignCfg = content
		self._sortCampaignCfg = {}

		for k, v in pairs(content.dataList) do
			table.insert(self._sortCampaignCfg, v)
		end

		table.sort(self._sortCampaignCfg, function(a, b)
			return a.id < b.id
		end)
	elseif name == "activitypopup_jump" then
		self._activityPopupJumpCfg = content
	elseif name == "activity_auto_popup" then
		self.activity_auto_popupCfg = content
	elseif name == "platform_info" then
		self.platform_info_cfg = content

		self:_dealPlatFormMap(content)
	elseif name == "longyan_xixi_skin" then
		self.longyan_xixi_skinCfg = content
	elseif name == "pay_auto_show_mall" then
		self.pay_auto_show_mallCfg = content
	elseif name == "pay_auto_show_tab_mall" then
		self.pay_auto_show_mall_tabCfg = content
	elseif name == "longyan_xixi_multiple_skin" then
		self.longyan_xixi_multiple_skinCfg = content
	elseif name == "longyan_xixi_common" then
		self.longyan_xixi_commonCfg = content
	end
end

function ActivityPopupConfig:getLyxxCommonValue(key)
	local obj = self.longyan_xixi_commonCfg[key]

	if obj then
		return obj.value
	end

	return ""
end

function ActivityPopupConfig:getPayAutoShowCfg(actid)
	local tab = {}

	for i, v in ipairs(self.pay_auto_show_mallCfg) do
		if v.activityType == actid then
			table.insert(tab, v)
		end
	end

	return tab
end

function ActivityPopupConfig:getPayAutoTabShowCfg()
	return self.pay_auto_show_mall_tabCfg.dataList
end

function ActivityPopupConfig:getLyXxCfg(pid)
	return self.longyan_xixi_skinCfg[pid]
end

function ActivityPopupConfig:getPlatformCfg(pid, cid)
	local list = self.platform_info_cfg[pid]

	if list then
		return list[cid]
	end
end

function ActivityPopupConfig:getPlatformCfgByPlatformId(pid)
	return self._PlatformMap[pid]
end

function ActivityPopupConfig:_dealPlatFormMap(content)
	self._PlatformMap = {}

	if content then
		for i, v in ipairs(content.dataList or {}) do
			if self._PlatformMap[v.platformId] == nil then
				self._PlatformMap[v.platformId] = v
			elseif self._PlatformMap[v.platformId].type ~= v.type then
				printError(">>>>>>>>>>>>>>>>>>存在主ID 类型不一致情况", v.platformId, v.channelId, v.type)
			end
		end
	end
end

function ActivityPopupConfig:getAutoCfg()
	return self.activity_auto_popupCfg.dataList
end

function ActivityPopupConfig:getAutoCfgById(id)
	if self.activity_auto_popupCfg == nil or checknumber(id) <= 0 then
		return
	end

	return self.activity_auto_popupCfg[id]
end

function ActivityPopupConfig:getCfgById(id)
	return self._activityPopupCfg[id]
end

function ActivityPopupConfig:getCfgs()
	return self._activityPopupCfg
end

function ActivityPopupConfig:getCfgByEffectType(effectType)
	local list = {}

	for i, v in ipairs(self._sortCampaignCfg) do
		if v.effect == effectType then
			table.insert(list, v)
		end
	end

	return list
end

function ActivityPopupConfig:_getStartAndEndTime(cfg)
	if not cfg then
		return nil
	end

	local timeStr = string.split(cfg.limitType, "|")[2]
	local times = string.split(timeStr, ",")
	local startTime = times[1]
	local endTime = times[2]

	return startTime, endTime
end

function ActivityPopupConfig:getActivityPopupJumpCfgs(id)
	return self._activityPopupJumpCfg[id]
end

function ActivityPopupConfig:getCampaignCfg(id)
	return self._campaignCfg[id]
end

function ActivityPopupConfig:getLyXxMSkinCfg(funcId)
	for _, cfg in ipairs(self.longyan_xixi_multiple_skinCfg) do
		if cfg.funcId == funcId then
			return cfg
		end
	end

	return nil
end

ActivityPopupConfig.instance = ActivityPopupConfig.New()

return ActivityPopupConfig
