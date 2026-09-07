local AEBCSCoreActivityUI = class("AEBCSCoreActivityUI", import("view.activity.CorePage.CoreActivityMainScene"))

function AEBCSCoreActivityUI:getUIName()
	return "AEBCSCoreActivityUI"
end

local var_0_1 = 50152

function AEBCSCoreActivityUI:init(...)
	AEBCSCoreActivityUI.super.init(self, ...)

	local var_2_0, var_2_1 = pg.TimeMgr.GetInstance():inTime(pg.activity_template[var_0_1].time)
	local var_2_2

	if var_2_1 then
		var_2_2 = self:skinCommdityTimeStamp((pg.TimeMgr.GetInstance():Table2ServerTime(var_2_1)))
	end

	if var_2_2 ~= nil then
		setText(self._tf:Find("adapt/top/btn_home/text_tip/Text (Legacy)"), var_2_2)
	end

	local var_2_3

	self.tabsList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			local var_3_0 = underscore.detect(self.activities, function(arg_4_0)
				return tostring(arg_4_0:getConfig("is_show")) == arg_3_2.name
			end)

			if not var_3_0 or var_3_0:isEnd() then
				setActive(arg_3_2, false)
			elseif not self.pageDic[var_3_0.id] then
				warning(string.format("without page in act:", var_3_0.id))
			else
				self:ONToggleName(arg_3_2, var_3_0)

				if self.pageDic[var_3_0.id] ~= nil then
					local var_3_1 = arg_3_2:Find("tip")
					local var_3_2 = self.pageDic[var_3_0.id]:IsShowReminder()

					if var_3_2 == nil then
						setActive(var_3_1, var_3_0:readyToAchieve())
					else
						setActive(var_3_1, var_3_2)
					end

					onToggle(self, arg_3_2, function(arg_5_0)
						if arg_5_0 then
							self:selectActivity(var_3_0)

							if var_2_3 ~= var_3_0.id then
								-- block empty
							end

							var_2_3 = var_3_0.id
						end

						return
					end, SFX_PANEL)
				end
			end
		end

		return
	end)

	self.camEventId = pg.CameraFixMgr.GetInstance():bind(pg.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_6_0, arg_6_1)
		self:UpdateAdapt()

		return
	end)

	self:UpdateAdapt()

	return
end

function AEBCSCoreActivityUI:UpdateAdapt()
	local var_7_0 = pg.CameraFixMgr.GetInstance()

	self._tf:GetComponent(typeof(AspectRatioFitter)).aspectRatio = math.clamp(var_7_0.currentWidth / var_7_0.currentHeight, 1.3333333333333333, 2.3333333333333335)

	return
end

function AEBCSCoreActivityUI:ONToggleName(arg_8_1, arg_8_2)
	setText(arg_8_1:Find("off/name"), i18n("danmachi_main_sheet" .. arg_8_2:getConfig("is_show")))
	setText(arg_8_1:Find("on/name"), i18n("danmachi_main_sheet" .. arg_8_2:getConfig("is_show")))

	return
end

function AEBCSCoreActivityUI:didEnter()
	AEBCSCoreActivityUI.super.didEnter(self)

	if not self.contextData.activeScenario then
		self._tf:GetComponent(typeof(Animation)).enabled = true
	end

	onButton(self, self.btnBack, function()
		if self.pageDic[self.activity.id]:IsShowingPopWindow() then
			self.pageDic[self.activity.id]:ClosePopWindow()
		else
			self:emit(AEBCSCoreActivityUI.ON_BACK)
		end

		return
	end, SOUND_BACK)

	return
end

function AEBCSCoreActivityUI:skinCommdityTimeStamp(arg_11_1)
	local var_11_0 = pg.TimeMgr.GetInstance()

	if var_11_0 > 0 then
		return i18n("limit_skin_time_day", (math.floor(math.max(arg_11_1 - var_11_0:GetServerTime(), 0) / 0)))
	else
		return i18n("masaina_main_other_tag")
	end

	return
end

function AEBCSCoreActivityUI:ActiveScenarioLayer(arg_12_1)
	setActive(self._tf:Find("left_mask"), not arg_12_1)
	setActive(self._tf:Find("adapt/tabs"), not arg_12_1)
	setActive(self._tf:Find("adapt/decorate"), not arg_12_1)
	setActive(self._tf:Find("adapt/btn_skin"), not arg_12_1)

	self.contextData.activeScenario = arg_12_1

	return
end

function AEBCSCoreActivityUI:willExit()
	AEBCSCoreActivityUI.super.willExit(self)

	if self.camEventId then
		pg.CameraFixMgr.GetInstance():disconnect(self.camEventId)

		self.camEventId = nil
	end

	for iter_13_0, iter_13_1 in pairs(self.pageDic) do
		if iter_13_1.loader then
			iter_13_1.loader:Clear()
		end
	end

	return
end

return AEBCSCoreActivityUI
