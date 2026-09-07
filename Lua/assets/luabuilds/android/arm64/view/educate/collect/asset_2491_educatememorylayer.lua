local EducateMemoryLayer = class("EducateMemoryLayer", import(".EducateCollectLayerTemplate"))
local var_0_1 = {
	frame_1 = "frame1",
	frame_5 = "frame3",
	frame_3 = "frame2",
	frame_4 = "frame3",
	frame_2 = "frame3"
}

function EducateMemoryLayer:getUIName()
	return "EducateMemoryUI"
end

function EducateMemoryLayer:initConfig()
	self.config = pg.child_memory

	return
end

function EducateMemoryLayer:didEnter()
	setText(self.windowTF:Find("tip"), i18n("child_buy_memory_tip"))
	setText(self.performTF:Find("review_btn/Text"), i18n("child_btn_review"))

	self.addPrice = pg.gameset.child_cg_add_price.key_value
	self.maxPrice = pg.gameset.child_cg_max_price.key_value

	self:Flush()

	return
end

function EducateMemoryLayer:SetData()
	local var_4_0 = getProxy(EducateProxy)

	self.memories = var_4_0:GetMemories()
	self.gameCnt = var_4_0:GetGameCnt()
	self.bugCnt = var_4_0:GetMemoryBuyCnt()

	return
end

function EducateMemoryLayer:Flush()
	self:SetData()
	setText(self.curCntTF, #self.memories)
	setText(self.allCntTF, "/" .. #self.config.all)
	self:updatePage()

	return
end

function EducateMemoryLayer:updateItem(arg_6_1, arg_6_2)
	GetImageSpriteFromAtlasAsync("ui/educatememoryui_atlas", var_0_1[arg_6_2.name] .. "_" .. arg_6_1.sp_bg, arg_6_2)
	LoadImageSpriteAsync("bg/" .. arg_6_1.pic, arg_6_2:Find("icon/Image"))
	setText(arg_6_2:Find("unlock/name"), arg_6_1.desc)
	setText(arg_6_2:Find("lock/name"), arg_6_1.lock_name)
	setText(arg_6_2:Find("lock/desc/Text"), arg_6_1.unlock_desc)

	local var_6_0 = table.contains(self.memories, arg_6_1.id)

	setActive(arg_6_2:Find("icon/lock"), not var_6_0)
	setActive(arg_6_2:Find("lock"), not var_6_0)
	setActive(arg_6_2:Find("unlock"), var_6_0)

	if var_6_0 then
		setActive(arg_6_2:Find("unlock/new"), EducateTipHelper.IsShowNewTip(EducateTipHelper.NEW_MEMORY, arg_6_1.id))
		onButton(self, arg_6_2, function()
			self:showPerformWindow(arg_6_1)

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_6_2)

		local var_6_1 = arg_6_2:Find("lock/unlock_btn")

		setActive(var_6_1, self.gameCnt > 1)
		onButton(self, var_6_1, function()
			self:OnClickBuyBtn(arg_6_1)

			return
		end, SFX_PANEL)
	end

	return
end

function EducateMemoryLayer:showPerformWindow(arg_9_1)
	EducateTipHelper.ClearNewTip(EducateTipHelper.NEW_MEMORY, arg_9_1.id)

	local var_9_0 = self.performTF:Find("Image")

	LoadImageSpriteAsync("bg/" .. arg_9_1.pic, var_9_0)
	setActive(self.performTF, true)
	onButton(self, var_9_0, function()
		setActive(self.performTF, false)

		return
	end, SFX_PANEL)
	onButton(self, self.performTF:Find("review_btn"), function()
		pg.PerformMgr.GetInstance():PlayOne(arg_9_1.performance)

		return
	end, SFX_PANEL)

	return
end

function EducateMemoryLayer:OnClickBuyBtn(arg_12_1)
	local var_12_0 = math.min(self.maxPrice, arg_12_1.child_cg_basic_price + self.bugCnt * self.addPrice)

	self:emit(EducateBaseUI.EDUCATE_ON_MSG_TIP, {
		content = i18n("child_cg_buy", var_12_0, arg_12_1.lock_name),
		onYes = function()
			self:emit(EducateCollectMediatorTemplate.UNLOCK, {
				type = EducateBuyCollectCommand.TYPE.MEMORY,
				id = arg_12_1.id,
				cost = var_12_0
			})

			return
		end
	})

	return
end

function EducateMemoryLayer:playAnimChange()
	self.anim:Stop()
	self.anim:Play("anim_educate_memory_change")

	return
end

function EducateMemoryLayer:playAnimClose()
	self.anim:Play("anim_educate_memory_out")

	return
end

return EducateMemoryLayer
