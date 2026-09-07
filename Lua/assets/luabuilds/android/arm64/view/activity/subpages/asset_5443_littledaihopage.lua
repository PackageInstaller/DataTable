local LittleDaihoPage = class("LittleDaihoPage", import(".TemplatePage.PtTemplatePage"))

function LittleDaihoPage:OnInit()
	LittleDaihoPage.super.OnInit(self)

	self.helpBtn = self.bg:Find("help_btn")

	local var_1_0 = self.bg:Find("step_content")

	self.itemList = UIItemList.New(var_1_0, var_1_0:Find("tpl"))

	return
end

function LittleDaihoPage:OnFirstFlush()
	LittleDaihoPage.super.OnFirstFlush(self)
	onButton(self, self.getBtn, function()
		if self.inLT then
			return
		end

		local var_3_0 = {}
		local var_3_1 = self.ptData:GetAward()
		local var_3_2 = getProxy(PlayerProxy):getRawData()
		local var_3_3, var_3_4 = Task.StaticJudgeOverflow(var_3_2.gold, var_3_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, {
			{
				var_3_1.type,
				var_3_1.id,
				var_3_1.count
			}
		})

		if var_3_3 then
			table.insert(var_3_0, function(arg_4_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_3_4,
					onYes = arg_4_0
				})

				return
			end)
		end

		table.insert(var_3_0, function(arg_5_0)
			self.inLT = true

			local var_5_0 = cloneTplTo(self.itemList.container:Find("tpl"), self.itemList.container)

			setLocalScale(var_5_0, Vector2.zero)
			LeanTween.scale(var_5_0, Vector3.one, 0.6):setEase(LeanTweenType.easeInBack):setOnComplete(System.Action(arg_5_0))

			return
		end)
		table.insert(var_3_0, function(arg_6_0)
			LeanTween.delayedCall(0.2, System.Action(arg_6_0))

			return
		end)
		seriesAsync(var_3_0, function()
			self.inLT = false

			local var_7_0, var_7_1 = self.ptData:GetResProgress()

			self:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = self.ptData:GetId(),
				arg1 = var_7_1
			})

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("littleTaihou_npc")
		})

		return
	end, SFX_PANEL)

	return
end

function LittleDaihoPage:OnUpdateFlush()
	LittleDaihoPage.super.OnUpdateFlush(self)
	self.itemList:align(self.ptData:GetLevel())

	local var_9_0, var_9_1, var_9_2 = self.ptData:GetResProgress()

	setText(self.progress, (var_9_2 >= 1 and setColorStr(var_9_0, "#9F413AFF") or var_9_0) .. "/" .. var_9_1)

	return
end

return LittleDaihoPage
