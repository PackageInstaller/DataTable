local PtAwardWindow = class("PtAwardWindow")

function PtAwardWindow:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self.binder = arg_1_2
	self.scrollPanel = self._tf:Find("window/panel")
	self.UIlist = UIItemList.New(self._tf:Find("window/panel/list"), self._tf:Find("window/panel/list/item"))
	self.ptTF = self._tf:Find("window/pt")
	self.totalTxt = self._tf:Find("window/pt/Text"):GetComponent(typeof(Text))
	self.totalTitleTxt = self._tf:Find("window/pt/title"):GetComponent(typeof(Text))
	self.totalTitleIcon = self._tf:Find("window/pt/icon/image"):GetComponent(typeof(Image))
	self.closeBtn = self._tf:Find("window/top/btnBack")
	self.ptIcon = self._tf:Find("window/pt/icon")

	onButton(self.binder, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self.binder, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function PtAwardWindow:UpdateList(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	assert(#arg_4_1 == #arg_4_2)
	self.UIlist:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			local var_5_0 = GetPerceptualSize(self.resTitle)

			setText(arg_5_2:Find("title/Text"), "PHASE " .. arg_5_1 + 1)
			setText(arg_5_2:Find("target/Text"), arg_4_2[arg_5_1 + 1])

			if arg_5_2:Find("target/icon") then
				if self.resIcon == "" then
					self.resIcon = nil
				end

				if self.resIcon then
					LoadImageSpriteAsync(self.resIcon, arg_5_2:Find("target/icon"), false)
				end

				setActive(arg_5_2:Find("target/icon"), self.resIcon)
				setActive(arg_5_2:Find("target/mark"), self.resIcon)
			end

			setText(arg_5_2:Find("target/title"), self.resTitle)

			local var_5_1 = Drop.Create(arg_4_1[arg_5_1 + 1])

			updateDrop(arg_5_2:Find("award"), var_5_1, {
				hideName = true
			})
			onButton(self.binder, arg_5_2:Find("award"), function()
				self.binder:emit(BaseUI.ON_DROP, var_5_1)

				return
			end, SFX_PANEL)
			setActive(arg_5_2:Find("award/mask"), arg_5_1 + 1 <= arg_4_3)

			if not IsNil(arg_5_2:Find("mask")) then
				if arg_4_4 then
					local var_5_2 = pg.TimeMgr.GetInstance()
					local var_5_3 = arg_4_4[arg_5_1 + 1]

					setActive(arg_5_2:Find("mask"), arg_4_4[arg_5_1 + 1] > var_5_2:GetServerTime())
					setText(arg_5_2:Find("mask/Text"), i18n("unlock_date_tip", var_5_2:STimeDescS(var_5_3, "%m"), (var_5_2:STimeDescS(var_5_3, "%d"))))
				else
					setActive(arg_5_2:Find("mask"), false)
				end
			end
		end

		return
	end)
	self.UIlist:align(#arg_4_1)
	scrollTo(self.scrollPanel, 0, 1 - arg_4_3 * 166 / (#arg_4_2 * 166 + 20 - 570))

	return
end

function PtAwardWindow:Show(arg_7_1)
	self.blur = arg_7_1.blur
	self.resIcon = nil

	self:UpdateTitle(arg_7_1.type)
	self:updateResIcon(arg_7_1.resId, arg_7_1.resIcon, arg_7_1.type)
	self:UpdateList(arg_7_1.dropList, arg_7_1.targets, arg_7_1.level, arg_7_1.unlockStamps)

	self.totalTxt.text = arg_7_1.count
	self.totalTitleTxt.text = self.cntTitle

	Canvas.ForceUpdateCanvases()
	setActive(self._tf, true)

	if self.blur then
		pg.UIMgr.GetInstance():BlurPanel(self._tf)
	end

	return
end

function PtAwardWindow:UpdateTitle(arg_8_1)
	if arg_8_1 == 2 then
		self.resTitle, self.cntTitle = i18n("pt_cosume", ""), i18n("pt_total_count", i18n("pt_cosume", ""))
		self.cntTitle = string.gsub(self.cntTitle, "：", "")
	elseif arg_8_1 == 3 then
		self.resTitle, self.cntTitle = i18n("pt_ship_goal"), i18n("pt_ship_now")
	elseif arg_8_1 == 4 then
		self.resTitle, self.cntTitle = i18n("cumulative_victory_target_tip"), i18n("cumulative_victory_now_tip")
	elseif arg_8_1 == 5 then
		self.resTitle, self.cntTitle = i18n("npcfriendly_count"), i18n("npcfriendly_total_count")
	elseif arg_8_1 == 6 then
		self.resTitle, self.cntTitle = i18n("activity_yanhua_tip2"), i18n("activity_yanhua_tip3")
	else
		self.resTitle, self.cntTitle = i18n("target_get_tip"), i18n("pt_total_count", "")
		self.cntTitle = string.gsub(self.cntTitle, "：", "")
	end

	return
end

function PtAwardWindow:updateResIcon(arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3 == 2 or arg_9_3 ~= 3 and arg_9_3 ~= 4 and arg_9_3 ~= 5 and arg_9_3 ~= 6 then
		if arg_9_1 then
			self.resIcon = Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = arg_9_1
			}):getIcon()
		elseif arg_9_2 then
			self.resIcon = arg_9_2
		end

		if self.ptIcon and self.resIcon and self.resIcon ~= "" then
			setActive(self.ptIcon, true)
			LoadImageSpriteAsync(self.resIcon, self.totalTitleIcon, false)
		else
			setActive(self.ptIcon, false)
		end
	else
		setActive(self.ptIcon, false)
	end

	return
end

function PtAwardWindow:Hide()
	if self.blur then
		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	end

	setActive(self._tf, false)

	return
end

function PtAwardWindow:Dispose()
	self:Hide()
	removeOnButton(self._tf)
	removeOnButton(self.closeBtn)

	return
end

return PtAwardWindow
