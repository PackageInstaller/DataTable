local EducateEndingLayer = class("EducateEndingLayer", import(".EducateCollectLayerTemplate"))
local var_0_1 = {
	frame_1 = "frame1",
	frame_5 = "frame3",
	frame_3 = "frame2",
	frame_4 = "frame3",
	frame_2 = "frame2"
}

function EducateEndingLayer:getUIName()
	return "EducateEndingUI"
end

function EducateEndingLayer:initConfig()
	self.config = pg.child_ending

	return
end

function EducateEndingLayer:didEnter()
	setText(self.windowTF:Find("tip"), i18n("child_buy_ending_tip"))
	setText(self.performTF:Find("review_btn/Text"), i18n("child_btn_review"))

	self.tpl = self.windowTF:Find("condition_tpl")
	self.addPrice = pg.gameset.child_cg_add_price.key_value
	self.maxPrice = pg.gameset.child_cg_max_price.key_value

	self:Flush()

	return
end

function EducateEndingLayer:SetData()
	local var_4_0 = getProxy(EducateProxy)

	self.endings = var_4_0:GetAllEndings()
	self.completeEndings = var_4_0:GetCompleteEndings()
	self.char = var_4_0:GetCharData()
	self.gameCnt = var_4_0:GetGameCnt()
	self.bugCnt = var_4_0:GetEndingBuyCnt()

	return
end

function EducateEndingLayer:Flush()
	self:SetData()
	setText(self.curCntTF, #self.endings)
	setText(self.allCntTF, "/" .. #self.config.all)
	self:updatePage()

	return
end

function EducateEndingLayer:updateItem(arg_6_1, arg_6_2)
	GetImageSpriteFromAtlasAsync("ui/educateendingui_atlas", var_0_1[arg_6_2.name] .. "_" .. arg_6_1.sp_bg, arg_6_2)
	LoadImageSpriteAsync("bg/" .. arg_6_1.pic, arg_6_2:Find("icon/Image"))
	setText(arg_6_2:Find("unlock/name"), arg_6_1.name)
	setText(arg_6_2:Find("lock/name"), arg_6_1.lock_name)

	local var_6_0 = table.contains(self.endings, arg_6_1.id)

	setActive(arg_6_2:Find("icon/lock"), not var_6_0)
	setActive(arg_6_2:Find("unlock"), var_6_0)
	setActive(arg_6_2:Find("lock"), not var_6_0)

	if var_6_0 then
		onButton(self, arg_6_2, function()
			self:showPerformWindow(arg_6_1)

			return
		end, SFX_PANEL)
		setActive(arg_6_2:Find("unlock/complete"), table.contains(self.completeEndings, arg_6_1.id))
	else
		removeOnButton(arg_6_2)

		local var_6_1 = arg_6_2:Find("lock/desc/conditions")

		self:updateConditions(arg_6_1.condition, var_6_1)
		setActive(var_6_1, #arg_6_1.condition > 0)

		local var_6_2 = arg_6_2:Find("lock/desc/Text")

		setText(var_6_2, arg_6_1.unlock_desc)
		setActive(var_6_2, arg_6_1.unlock_desc ~= "")

		local var_6_3 = arg_6_2:Find("lock/unlock_btn")

		setActive(var_6_3, self.gameCnt > 1)
		onButton(self, var_6_3, function()
			self:OnClickBuyBtn(arg_6_1)

			return
		end, SFX_PANEL)
	end

	return
end

function EducateEndingLayer:updateConditions(arg_9_1, arg_9_2)
	local var_9_0 = 0

	for iter_9_0 = 1, #arg_9_1 do
		local var_9_1 = arg_9_1[iter_9_0]

		if arg_9_1[iter_9_0][1] == EducateConst.DROP_TYPE_ATTR then
			var_9_0 = var_9_0 + 1

			local var_9_2 = iter_9_0 <= arg_9_2.childCount and arg_9_2:GetChild(iter_9_0 - 1) or cloneTplTo(self.tpl, arg_9_2)
			local var_9_3 = false
			local var_9_4 = ""

			if var_9_1[3] then
				var_9_3 = self.char:GetAttrById(var_9_1[2]) >= var_9_1[3]
				var_9_4 = pg.child_attr[var_9_1[2]].name .. " > " .. var_9_1[3]
			else
				var_9_3 = self.char:GetPersonalityId() == var_9_1[2]
				var_9_4 = i18n("child_nature_title") .. pg.child_attr[var_9_1[2]].name
			end

			setActive(var_9_2:Find("icon/unlock"), var_9_3)
			setTextColor(var_9_2:Find("Text"), Color.NewHex(var_9_3 and "F59F48" or "FFFFFF"))
			setText(var_9_2:Find("Text"), var_9_4)
		end
	end

	for iter_9_1 = 1, arg_9_2.childCount do
		setActive(arg_9_2:GetChild(iter_9_1 - 1), iter_9_1 <= var_9_0)
	end

	return
end

function EducateEndingLayer:showPerformWindow(arg_10_1)
	local var_10_0 = self.performTF:Find("Image")

	LoadImageSpriteAsync("bg/" .. arg_10_1.pic, var_10_0)
	setActive(self.performTF, true)
	onButton(self, var_10_0, function()
		setActive(self.performTF, false)

		return
	end, SFX_PANEL)
	onButton(self, self.performTF:Find("review_btn"), function()
		pg.PerformMgr.GetInstance():PlayGroup(arg_10_1.performance)

		return
	end, SFX_PANEL)

	return
end

function EducateEndingLayer:OnClickBuyBtn(arg_13_1)
	local var_13_0 = math.min(self.maxPrice, arg_13_1.child_cg_basic_price + self.bugCnt * self.addPrice)

	self:emit(EducateBaseUI.EDUCATE_ON_MSG_TIP, {
		content = i18n("child_cg_buy", var_13_0, arg_13_1.lock_name),
		onYes = function()
			self:emit(EducateCollectMediatorTemplate.UNLOCK, {
				type = EducateBuyCollectCommand.TYPE.ENDING,
				id = arg_13_1.id,
				cost = var_13_0
			})

			return
		end
	})

	return
end

function EducateEndingLayer:playAnimChange()
	self.anim:Stop()
	self.anim:Play("anim_educate_ending_change")

	return
end

function EducateEndingLayer:playAnimClose()
	self.anim:Play("anim_educate_ending_out")

	return
end

return EducateEndingLayer
