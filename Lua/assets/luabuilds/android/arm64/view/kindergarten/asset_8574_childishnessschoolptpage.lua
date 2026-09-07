local ChildishnessSchoolPtPage = class("ChildishnessSchoolPtPage", import("view.base.BaseUI"))

function ChildishnessSchoolPtPage:getUIName()
	return "ChildishnessSchoolPtPage"
end

function ChildishnessSchoolPtPage:init()
	self.bg = self._tf:Find("bg")
	self.scrollPanel = self._tf:Find("window/panel")
	self.UIlist = UIItemList.New(self._tf:Find("window/panel/list"), self._tf:Find("window/panel/list/item"))
	self.ptTF = self._tf:Find("window/top/pt")
	self.totalTxt = self._tf:Find("window/top/pt/Text"):GetComponent(typeof(Text))
	self.closeBtn = self._tf:Find("window/top/btnBack")
	self.getBtn = self._tf:Find("window/btn_get")

	return
end

function ChildishnessSchoolPtPage:didEnter()
	onButton(self, self.closeBtn, function()
		self.anim:Play("anim_kinder_schoolPT_out")

		return
	end, SFX_PANEL)
	onButton(self, self.bg, function()
		self.anim:Play("anim_kinder_schoolPT_out")

		return
	end, SFX_PANEL)
	self:Show()

	self.anim = self._tf:GetComponent(typeof(Animation))
	self.animEvent = self.anim:GetComponent(typeof(DftAniEvent))

	self.animEvent:SetEndEvent(function()
		self:closeView()

		return
	end)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function ChildishnessSchoolPtPage:Show()
	self:UpdatePtData()
	self:updateResIcon(self.ptData.resId, self.ptData.resIcon, self.ptData.type)
	self:UpdateList(self.ptData.dropList, self.ptData.targets, self.ptData.level)

	self.totalTxt.text = self.ptData.count

	Canvas.ForceUpdateCanvases()

	return
end

function ChildishnessSchoolPtPage:UpdateList(arg_8_1, arg_8_2, arg_8_3)
	assert(#arg_8_1 == #arg_8_2)
	self.UIlist:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			setText(arg_9_2:Find("title/Text"), "PHASE " .. arg_9_1 + 1)
			setText(arg_9_2:Find("target/Text"), arg_8_2[arg_9_1 + 1])

			if arg_9_2:Find("target/icon") then
				if self.resIcon == "" then
					self.resIcon = nil
				end

				if self.resIcon then
					LoadImageSpriteAsync(self.resIcon, arg_9_2:Find("target/icon"), false)
				end

				setActive(arg_9_2:Find("target/icon"), self.resIcon)
			end

			local var_9_0 = Drop.Create(arg_8_1[arg_9_1 + 1])

			updateDrop(arg_9_2:Find("award/mask"), var_9_0, {
				hideName = true
			})

			if var_9_0.type == DROP_TYPE_ITEM then
				if var_9_0:getSubClass():getConfig("type") == 9 then
					setActive(arg_9_2:Find("award/specialFrame"), true)

					goto label_9_0
				end
			end

			setActive(arg_9_2:Find("award/specialFrame"), false)

			::label_9_0::

			onButton(self, arg_9_2:Find("award"), function()
				self:emit(BaseUI.ON_DROP, var_9_0)

				return
			end, SFX_PANEL)

			local var_9_1 = self.ptData:GetDroptItemState(arg_9_1 + 1)

			if var_9_1 == ActivityPtData.STATE_LOCK then
				setActive(arg_9_2:Find("mask_get"), false)
				setActive(arg_9_2:Find("mask_got"), false)
			elseif var_9_1 == ActivityPtData.STATE_CAN_GET then
				setActive(arg_9_2:Find("mask_get"), true)
				setActive(arg_9_2:Find("mask_got"), false)
			else
				setActive(arg_9_2:Find("mask_get"), false)
				setActive(arg_9_2:Find("mask_got"), true)
			end
		end

		return
	end)
	self.UIlist:align(#arg_8_1)

	local var_8_0 = self.scrollPanel:GetComponent("ScrollRect")

	scrollTo(self.scrollPanel, 0, 1 - arg_8_3 * 17 / (#arg_8_2 * 17 - 7 - 591))

	if self.ptData:CanGetAward() then
		setActive(self.getBtn, true)
		onButton(self, self.getBtn, function()
			local var_11_0 = {}
			local var_11_1 = {}

			for iter_11_0 = self.ptData:GetLevel() + 1, self.ptData:GetCurrLevel() do
				local var_11_2 = false

				for iter_11_1, iter_11_2 in pairs(var_11_1) do
					if iter_11_2[1] == arg_8_1[iter_11_0][1] and iter_11_2[2] == arg_8_1[iter_11_0][2] then
						var_11_2 = true
						iter_11_2[3] = iter_11_2[3] + arg_8_1[iter_11_0][3]

						break
					end
				end

				if not var_11_2 then
					table.insert(var_11_1, arg_8_1[iter_11_0])
				end
			end

			local var_11_3 = getProxy(PlayerProxy):getRawData()
			local var_11_4, var_11_5 = Task.StaticJudgeOverflow(var_11_3.gold, var_11_3.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, var_11_1)

			if var_11_4 then
				table.insert(var_11_0, function(arg_12_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						type = MSGBOX_TYPE_ITEM_BOX,
						content = i18n("award_max_warning"),
						items = var_11_5,
						onYes = arg_12_0
					})

					return
				end)
			end

			seriesAsync(var_11_0, function()
				self:emit(ChildishnessSchoolPtMediator.EVENT_PT_OPERATION, {
					cmd = 4,
					activity_id = self.ptData:GetId(),
					arg1 = self.ptData:GetCurrTarget()
				})

				return
			end)

			return
		end, SFX_PANEL)
	else
		setActive(self.getBtn, false)
		removeOnButton(self.getBtn)
	end

	return
end

function ChildishnessSchoolPtPage:updateResIcon(arg_14_1, arg_14_2, arg_14_3)
	if arg_14_3 == 2 or arg_14_3 ~= 3 and arg_14_3 ~= 4 and arg_14_3 ~= 5 and arg_14_3 ~= 6 then
		if arg_14_1 then
			self.resIcon = Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = arg_14_1
			}):getIcon()
		elseif arg_14_2 then
			self.resIcon = arg_14_2
		end
	end

	return
end

function ChildishnessSchoolPtPage:UpdatePtData()
	self.ptData = ActivityPtData.New((getProxy(ActivityProxy):getActivityById(ActivityConst.ALVIT_PT_ACT_ID)))

	return
end

function ChildishnessSchoolPtPage:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return ChildishnessSchoolPtPage
