local SailingShip3CoreActivityUI = class("SailingShip3CoreActivityUI", import("view.activity.CorePage.CoreActivityMainScene"))

function SailingShip3CoreActivityUI:getUIName()
	return "SailingShip3CoreActivityUI"
end

function SailingShip3CoreActivityUI:loadingQueue()
	local var_2_0 = "play_jjufengyuziyouqundao_fullscreen_" .. getProxy(PlayerProxy):getPlayerId()

	if PlayerPrefs.GetInt(var_2_0, 0) == 1 then
		return nil
	else
		return function(arg_3_0)
			pg.SceneAnimMgr.GetInstance():CommonSceneChange("jufengyuziyouqundao_fullscreen", function(arg_4_0)
				return arg_3_0(function()
					PlayerPrefs.SetInt(var_2_0, 1)
					existCall(arg_4_0)

					return
				end)
			end)

			return
		end
	end

	return
end

function SailingShip3CoreActivityUI:init(...)
	SailingShip3CoreActivityUI.super.init(self, ...)

	local var_6_0

	setText(self._tf:Find("adapt/top/btn_back/back"), i18n("word_back"))
	self.tabsList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			local var_7_0 = underscore.detect(self.activities, function(arg_8_0)
				return tostring(arg_8_0:getConfig("is_show")) == arg_7_2.name
			end)

			if not var_7_0 or var_7_0:isEnd() then
				setActive(arg_7_2, false)
			elseif not self.pageDic[var_7_0.id] then
				warning(string.format("without page in act:", var_7_0.id))
			else
				self:ONToggleName(arg_7_2, var_7_0)

				if self.pageDic[var_7_0.id] ~= nil then
					local var_7_1 = arg_7_2:Find("tip")
					local var_7_2 = self.pageDic[var_7_0.id]:IsShowReminder()

					if var_7_2 == nil then
						setActive(var_7_1, var_7_0:readyToAchieve())
					else
						setActive(var_7_1, var_7_2)
					end

					onToggle(self, arg_7_2, function(arg_9_0)
						if arg_9_0 then
							if var_6_0 ~= var_7_0.id then
								self:selectActivity(var_7_0)
								self:OnplayAnimation(arg_7_2)
							end

							var_6_0 = var_7_0.id
						end

						return
					end, SFX_PANEL)
				end
			end
		end

		return
	end)

	self.camEventId = pg.CameraFixMgr.GetInstance():bind(pg.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_10_0, arg_10_1)
		self:UpdateAdapt()

		return
	end)

	self:UpdateAdapt()

	return
end

function SailingShip3CoreActivityUI:UpdateAdapt()
	local var_11_0 = 2.3333333333333335
	local var_11_1 = pg.CameraFixMgr.GetInstance()

	self._tf:GetComponent(typeof(AspectRatioFitter)).aspectRatio = math.clamp(var_11_1.currentWidth / var_11_1.currentHeight, 1.3333333333333333, 2.3333333333333335)

	setSizeDelta(self._tf:Find("adapt"), {
		x = 0,
		y = 0
	})
	SetComponentEnabled(self._tf:Find("adapt"), "NotchAdapt", NotchAdapt.CheckNotchRatio == math.clamp(NotchAdapt.CheckNotchRatio, 1.3333333333333333, var_11_0))

	return
end

function SailingShip3CoreActivityUI:ONToggleName(arg_12_1, arg_12_2)
	setText(arg_12_1:Find("off/name"), i18n("fengfanV3_20251023_Sidebar" .. arg_12_2:getConfig("is_show")))
	setText(arg_12_1:Find("on/name"), i18n("fengfanV3_20251023_Sidebar" .. arg_12_2:getConfig("is_show")))

	return
end

function SailingShip3CoreActivityUI:OnplayAnimation(arg_13_1)
	quickPlayAnimation(arg_13_1, "Anim_SailingShip3SkinActUI_tabs_on_click")

	return
end

function SailingShip3CoreActivityUI:didEnter()
	SailingShip3CoreActivityUI.super.didEnter(self)

	if not self.contextData.activeScenario then
		self._tf:GetComponent(typeof(Animation)).enabled = true
	end

	onButton(self, self.btnBack, function()
		if self.pageDic[self.activity.id]:IsShowingPopWindow() then
			self.pageDic[self.activity.id]:ClosePopWindow()
		else
			self:emit(SailingShip3CoreActivityUI.ON_BACK)
		end

		return
	end, SOUND_BACK)

	return
end

function SailingShip3CoreActivityUI:willExit()
	SailingShip3CoreActivityUI.super.willExit(self)

	if self.camEventId then
		pg.CameraFixMgr.GetInstance():disconnect(self.camEventId)

		self.camEventId = nil
	end

	return
end

return SailingShip3CoreActivityUI
