local EducateUnlockTipLayer = class("EducateUnlockTipLayer", import("..base.EducateBaseUI"))

EducateUnlockTipLayer.UNLOCK_TYPE_SYSTEM = 1
EducateUnlockTipLayer.UNLOCK_TYPE_SITE = 2
EducateUnlockTipLayer.UNLOCK_TYPE_PLAN = 3
EducateUnlockTipLayer.UNLOCK_NEW_SECRETARY = 4

function EducateUnlockTipLayer:getUIName()
	return "EducateUnlockTip"
end

function EducateUnlockTipLayer:init()
	self.anim = self._tf:Find("anim_root"):GetComponent(typeof(Animation))
	self.animEvent = self._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	self.animEvent:SetEndEvent(function()
		self:emit(EducateUnlockTipLayer.ON_CLOSE)

		return
	end)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self._tipTF = self._tf:Find("anim_root/tip")
	self.contentTF = self._tipTF:Find("tip_bg/layout/title/name")

	setText(self._tipTF:Find("tip_bg/layout/title/unlock"), i18n("child_unlock_tip"))

	return
end

function EducateUnlockTipLayer:didEnter()
	self:setContent()

	return
end

function EducateUnlockTipLayer:setContent()
	local var_5_0 = ""

	switch(self.contextData.type, {
		[EducateUnlockTipLayer.UNLOCK_TYPE_SYSTEM] = function()
			var_5_0 = EducateTipHelper.system_tip_list[self.contextData.single]

			return
		end,
		[EducateUnlockTipLayer.UNLOCK_TYPE_SITE] = function()
			for iter_7_0, iter_7_1 in ipairs(self.contextData.list) do
				var_5_0 = var_5_0 .. pg.child_site[iter_7_1].name .. " "
			end

			return
		end,
		[EducateUnlockTipLayer.UNLOCK_TYPE_PLAN] = function()
			for iter_8_0, iter_8_1 in ipairs(self.contextData.list) do
				var_5_0 = var_5_0 .. pg.child_plan[iter_8_1].name .. " "
			end

			return
		end,
		[EducateUnlockTipLayer.UNLOCK_NEW_SECRETARY] = function()
			var_5_0 = i18n("child_unlock_new_secretary")

			return
		end
	})
	setText(self.contentTF, shortenString("", 15))

	return
end

function EducateUnlockTipLayer:saveTipRecord()
	switch(self.contextData.type, {
		[EducateUnlockTipLayer.UNLOCK_TYPE_SYSTEM] = function()
			EducateTipHelper.SaveSystemUnlockTip(self.contextData.single)

			return
		end,
		[EducateUnlockTipLayer.UNLOCK_TYPE_SITE] = function()
			for iter_12_0, iter_12_1 in ipairs(self.contextData.list) do
				EducateTipHelper.SaveSiteUnlockTipId(iter_12_1)
			end

			return
		end,
		[EducateUnlockTipLayer.UNLOCK_TYPE_PLAN] = function()
			for iter_13_0, iter_13_1 in ipairs(self.contextData.list) do
				EducateTipHelper.SavePlanUnlockTipId(iter_13_1)
			end

			return
		end
	})

	return
end

function EducateUnlockTipLayer:onBackPressed()
	return
end

function EducateUnlockTipLayer:willExit()
	self:saveTipRecord()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	if self.contextData.onExit then
		self.contextData.onExit()
	end

	return
end

return EducateUnlockTipLayer
