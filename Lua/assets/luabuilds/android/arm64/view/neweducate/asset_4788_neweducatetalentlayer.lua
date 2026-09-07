local NewEducateTalentLayer = class("NewEducateTalentLayer", import("view.newEducate.base.NewEducateBaseUI"))

function NewEducateTalentLayer:getUIName()
	return "NewEducateTalentUI"
end

function NewEducateTalentLayer:init()
	self.animCom = self._tf:GetComponent(typeof(Animation))
	self.animEvent = self._tf:GetComponent(typeof(DftAniEvent))

	self.animEvent:SetTriggerEvent(function()
		self.animEvent:SetEndEvent(nil)
		self:RefreshView()

		return
	end)

	self.rootTF = self._tf:Find("root")
	self.bgTF = self.rootTF:Find("bg")

	local var_2_0 = self.rootTF:Find("window/content")

	self.uiList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))

	self.uiList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			arg_4_2.name = arg_4_1 + 1

			self:UpdateItem(self.talentList[arg_4_1 + 1], arg_4_2)
		end

		return
	end)

	return
end

function NewEducateTalentLayer:didEnter()
	self:OverlayPanel(self._tf, {
		groupDelta = 1,
		pbList = {
			self.bgTF
		}
	})
	NewEducateGuideSequence.CheckGuide(self.__cname)

	return
end

function NewEducateTalentLayer:GetRarityBg(arg_6_1)
	return switch(arg_6_1, {
		[NewEducateBuff.RARITY.BLUE] = function()
			return "bg_blue"
		end,
		[NewEducateBuff.RARITY.PURPLE] = function()
			return "bg_purple"
		end,
		[NewEducateBuff.RARITY.GOLD] = function()
			return "bg_gold"
		end,
		[NewEducateBuff.RARITY.COLOURS] = function()
			return "bg_colours"
		end
	})
end

function NewEducateTalentLayer:UpdateItem(arg_11_1, arg_11_2)
	setText(arg_11_2:Find("name/Text"), pg.child2_benefit_list[arg_11_1].name)
	setText(arg_11_2:Find("desc/Text"), pg.child2_benefit_list[arg_11_1].desc)
	LoadImageSpriteAtlasAsync("ui/neweducatetalentui_atlas", self:GetRarityBg(pg.child2_benefit_list[arg_11_1].rare), arg_11_2, true)
	LoadImageSpriteAsync("neweducateicon/" .. pg.child2_benefit_list[arg_11_1].item_icon, arg_11_2:Find("icon"), true)

	local var_11_0 = not table.contains(self.reTalentList, arg_11_1)

	setGray(arg_11_2:Find("refresh_btn"), not var_11_0)
	onButton(self, arg_11_2:Find("refresh_btn"), function()
		if self.isPlaying then
			return
		end

		if not var_11_0 then
			return
		end

		self:emit(NewEducateTalentMediator.ON_REFRESH_TALENT, arg_11_1, tonumber(arg_11_2.name))

		return
	end, SFX_PANEL)
	setText(arg_11_2:Find("refresh_btn/Text"), var_11_0 and 1 or 0)
	onButton(self, arg_11_2, function()
		if self.isPlaying then
			return
		end

		self:emit(NewEducateTalentMediator.ON_SELECT_TALENT, arg_11_1, tonumber(arg_11_2.name))

		return
	end, SFX_PANEL)

	return
end

function NewEducateTalentLayer:RefreshView()
	local var_14_0 = self.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.TALENT)

	self.talentList = var_14_0:GetTalents()
	self.reTalentList = var_14_0:GetReTalents()

	self.uiList:align(#self.talentList)

	return
end

function NewEducateTalentLayer:OnRefreshTalent(arg_15_1, arg_15_2)
	local var_15_0 = self.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.TALENT)

	self.talentList = var_15_0:GetTalents()
	self.reTalentList = var_15_0:GetReTalents()

	eachChild(self.uiList.container, function(arg_16_0)
		if tonumber(arg_16_0.name) == arg_15_1 then
			local var_16_0 = arg_16_0:GetComponent(typeof(DftAniEvent))

			var_16_0:SetTriggerEvent(function()
				var_16_0:SetTriggerEvent(nil)

				self.isPlaying = false

				self:UpdateItem(arg_15_2, arg_16_0)

				return
			end)
			arg_16_0:GetComponent(typeof(Animation)):Play("Anim_educate_talent_tpl_change")

			self.isPlaying = true
		end

		return
	end)

	return
end

function NewEducateTalentLayer:OnSelectedDone(arg_18_1)
	seriesAsync({
		function(arg_19_0)
			if #arg_18_1.drops > 0 then
				self:emit(NewEducateTalentLayer.ON_DROP, {
					items = arg_18_1.drops,
					removeFunc = function()
						arg_19_0()

						return
					end
				})
			else
				arg_19_0()
			end

			return
		end
	}, function()
		self.animEvent:SetEndEvent(function()
			self.animEvent:SetEndEvent(nil)

			self.isPlaying = false

			self:closeView()

			return
		end)
		self.animCom:Play("Anim_educate_talent_select")

		self.isPlaying = true

		eachChild(self.uiList.container, function(arg_23_0)
			if tonumber(arg_23_0.name) ~= arg_18_1.idx then
				arg_23_0:GetComponent(typeof(Animation)):Play("Anim_educate_talent_tpl_out")
			end

			return
		end)

		return
	end)

	return
end

function NewEducateTalentLayer:onBackPressed()
	return
end

function NewEducateTalentLayer:willExit()
	self:UnOverlayPanel(self._tf)
	existCall(self.contextData.onExit)

	return
end

return NewEducateTalentLayer
