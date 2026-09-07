local EducateSiteOption = class("EducateSiteOption", import("model.vo.BaseVO"))

EducateSiteOption.TYPE_SHOP = 1
EducateSiteOption.TYPE_EVENT = 2
EducateSiteOption.TYPE_SITE = 3

function EducateSiteOption:Ctor(arg_1_1, arg_1_2)
	self.id = arg_1_1
	self.configId = self.id
	self.usedCnt = arg_1_2 or 0
	self.remainCnt = self:GetOriginalCnt() - self.usedCnt
	self.curTime = getProxy(EducateProxy):GetCurTime()

	self:initTime()
	self:initRefreshTime()

	return
end

function EducateSiteOption:bindConfigTable()
	return pg.child_site_option
end

function EducateSiteOption:initTime()
	if self:IsLimitTime() then
		self.startTime, self.endTime = EducateHelper.CfgTime2Time((self:getConfig("time_limit")))
	end

	return
end

function EducateSiteOption:initRefreshTime()
	if self:IsEventType() and self:IsCountLimit() then
		self.refreshWeeks = {}

		local var_4_0 = 9
		local var_4_1 = self:getConfig("count_limit")[2]

		table.insert(self.refreshWeeks, 9)

		while var_4_0 < 60 do
			var_4_0 = var_4_0 + var_4_1

			table.insert(self.refreshWeeks, var_4_0)
		end
	end

	return
end

function EducateSiteOption:IsShowLimit()
	return self:getConfig("is_limit") == 1 and self.remainCnt > 0
end

function EducateSiteOption:IsLimitTime()
	return #self:getConfig("time_limit") ~= 0
end

function EducateSiteOption:IsCountLimit()
	return self:getConfig("count_limit") ~= "" and #self:getConfig("count_limit") == 2
end

function EducateSiteOption:IsShow()
	if self:IsLimitTime() then
		return EducateHelper.InTime(self.curTime, self.startTime, self.endTime)
	else
		return true
	end

	return
end

function EducateSiteOption:GetType()
	return self:getConfig("type")
end

function EducateSiteOption:IsEventType()
	return self:getConfig("type") == EducateSiteOption.TYPE_EVENT
end

function EducateSiteOption:IsReplace()
	return self:getConfig("replace") ~= 0
end

function EducateSiteOption:GetCost()
	return self:getConfig("cost")
end

function EducateSiteOption:GetLinkId()
	return self:getConfig("param")[1]
end

function EducateSiteOption:GetOriginalCnt()
	return self:IsCountLimit() and self:getConfig("count_limit")[1] or 999
end

function EducateSiteOption:GetRemainCnt()
	return self.remainCnt
end

function EducateSiteOption:GetCntText()
	if not self:IsCountLimit() then
		return ""
	end

	return string.format("(%d/%d)", self.remainCnt, self:getConfig("count_limit")[1])
end

function EducateSiteOption:CanTrigger()
	return self.remainCnt > 0
end

function EducateSiteOption:ReduceCnt()
	self.remainCnt = self.remainCnt - 1

	return
end

function EducateSiteOption:IsShowPolaroid()
	if #self:getConfig("polarid_list") == 0 then
		return false
	end

	return underscore.any(self:getConfig("polarid_list"), function(arg_20_0)
		return not getProxy(EducateProxy):IsExistPolaroidByGroup(arg_20_0) and getProxy(EducateProxy):CanGetPolaroidByGroup(arg_20_0)
	end)
end

function EducateSiteOption:GetResults()
	if EducateHelper.IsShowNature() then
		return self:getConfig("result_display")
	else
		return underscore.select(self:getConfig("result_display"), function(arg_22_0)
			local var_22_0 = arg_22_0[1] == EducateConst.DROP_TYPE_ATTR and not getProxy(EducateProxy):GetCharData():IsPersonalityAttr(arg_22_0[2]) or true

			return var_22_0
		end)
	end

	return
end

function EducateSiteOption:IsResetWeek(arg_23_1)
	return table.contains(self.refreshWeeks, arg_23_1)
end

function EducateSiteOption:OnWeekUpdate(arg_24_1)
	self.curTime = arg_24_1

	self:CheckCntReset()

	return
end

function EducateSiteOption:CheckCntReset()
	if self:IsEventType() and self:IsCountLimit() and self:IsResetWeek((EducateHelper.GetWeekIdxWithTime(self.curTime))) then
		self.remainCnt = self:GetOriginalCnt()
	end

	return
end

return EducateSiteOption
