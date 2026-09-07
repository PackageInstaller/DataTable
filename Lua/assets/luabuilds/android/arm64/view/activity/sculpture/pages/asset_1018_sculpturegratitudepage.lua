local SculptureGratitudePage = class("SculptureGratitudePage", import("view.base.BaseSubView"))

function SculptureGratitudePage:getUIName()
	return "SculptureGratitudeUI"
end

function SculptureGratitudePage:OnLoaded()
	self.backBtn = self._tf:Find("back")
	self.roleImg = self._tf:Find("char/Image")
	self.container = self._tf:Find("frame/gift")
	self.awards = self._tf:Find("frame/awards")
	self.giftBg = self._tf:Find("frame/Image")
	self.wordTxtScr = self._tf:Find("frame/scrollrect")
	self.wordTxt = self._tf:Find("frame/scrollrect/content/Text"):GetComponent(typeof(Text))
	self.typer = self._tf:Find("frame/scrollrect/content/Text"):GetComponent(typeof(Typewriter))
	self.uilist = UIItemList.New(self._tf:Find("frame/awards"), self._tf:Find("frame/awards/tpl"))
	self.arrLeft = self._tf:Find("frame/arr")
	self.arrRight = self._tf:Find("frame/arr (1)")

	return
end

function SculptureGratitudePage:OnInit()
	return
end

function SculptureGratitudePage:Show(arg_4_1, arg_4_2, arg_4_3)
	self:Clear()
	setText(self._tf:Find("tip"), i18n("sculpture_gratitude_tip"))
	SculptureGratitudePage.super.Show(self)
	setActive(self.giftBg, true)
	setAnchoredPosition(self.arrLeft, {
		x = 338
	})
	setAnchoredPosition(self.arrRight, {
		x = 675
	})

	if arg_4_3 then
		arg_4_3()
	end

	self.id = arg_4_1
	self.activity = arg_4_2

	self:SetScrollTxt(arg_4_2:getDataConfig(self.id, "words"))
	seriesAsync({
		function(arg_5_0)
			self:LoadChar(arg_5_0)

			return
		end,
		function(arg_6_0)
			self:LoadSculpture(arg_6_0)

			return
		end
	}, function()
		self:RegisterEvent()

		return
	end)
	pg.BgmMgr.GetInstance():Push(self.__cname, "story-richang-8")

	return
end

function SculptureGratitudePage:Flush(arg_8_1)
	self.activity = arg_8_1

	local var_8_0 = self.activity:GetSculptureState(self.id)

	if var_8_0 == SculptureActivity.STATE_FINSIH then
		self:Clear()

		local var_8_1, var_8_2, var_8_3 = self:State2CharNameAndActionName(var_8_0)

		self:UpdateRole(var_8_1, var_8_2, var_8_3)
		setActive(self.container, false)
		setActive(self.awards, true)
		self:InitAwards()
		self:SetScrollTxt(arg_8_1:getDataConfig(self.id, "thankwords"))
		setText(self._tf:Find("tip"), "")
		setActive(self.giftBg, false)
		setAnchoredPosition(self.arrLeft, {
			x = 260
		})
		setAnchoredPosition(self.arrRight, {
			x = 745
		})
	end

	return
end

function SculptureGratitudePage:SetScrollTxt(arg_9_1)
	self.typer:setSpeed(31)

	self.wordTxt.text = HXSet.hxLan(arg_9_1)

	self.typer:setSpeed(0.06)

	function self.typer.endFunc()
		self:RemoveTimer()

		return
	end

	self.typer:Play()
	self:RemoveTimer()

	self.timer = Timer.New(function()
		scrollToBottom(self.wordTxtScr)

		return
	end, 0.1, -1)

	self.timer:Start()

	return
end

function SculptureGratitudePage:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function SculptureGratitudePage:InitAwards()
	local var_13_0 = self.activity:getDataConfig(self.id, "reward_display")

	self.uilist:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			local var_14_0 = {
				type = var_13_0[arg_14_1 + 1][1],
				id = var_13_0[arg_14_1 + 1][2],
				count = var_13_0[arg_14_1 + 1][3]
			}

			updateDrop(arg_14_2, var_14_0)
			onButton(self, arg_14_2, function()
				self:emit(BaseUI.ON_DROP, var_14_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.uilist:align(#var_13_0)

	return
end

function SculptureGratitudePage:LoadChar(arg_16_1)
	local var_16_0, var_16_1, var_16_2 = self:State2CharNameAndActionName((self.activity:GetSculptureState(self.id)))

	self:UpdateRole(var_16_0, var_16_1, var_16_2, arg_16_1)

	return
end

function SculptureGratitudePage:State2CharNameAndActionName(arg_17_1)
	local var_17_0 = self.activity:GetResorceName(self.id)

	if arg_17_1 == SculptureActivity.STATE_FINSIH then
		return var_17_0, "gift_get_", "take_wait_"
	else
		return var_17_0, "gift_wait_"
	end

	return
end

function SculptureGratitudePage:LoadSculpture(arg_18_1)
	ResourceMgr.Inst:getAssetAsync("ui/" .. self.activity:GetResorceName(self.id) .. "_puzzle_whole", "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_19_0)
		local var_19_0 = Object.Instantiate(arg_19_0, self.container)

		var_19_0.transform.localScale = self.activity:GetScale(self.id)

		self:InitSculpture(var_19_0.transform)

		self.puzzle = var_19_0

		arg_18_1()

		return
	end), true, true)

	return
end

function SculptureGratitudePage:InitSculpture(arg_20_1)
	local var_20_0 = GetOrAddComponent(arg_20_1, typeof(EventTriggerListener))
	local var_20_1

	var_20_0:AddBeginDragFunc(function()
		arg_20_1:SetAsLastSibling()

		var_20_1 = arg_20_1.localPosition

		return
	end)
	var_20_0:AddDragFunc(function(arg_22_0, arg_22_1)
		arg_20_1.localPosition = Screen2Local(arg_20_1.parent, arg_22_1.position)

		return
	end)
	var_20_0:AddDragEndFunc(function(arg_23_0, arg_23_1)
		if getBounds(self.roleImg.gameObject.transform):Intersects((getBounds(arg_20_1))) then
			arg_20_1.localPosition = TrPosition2LocalPos(self.roleImg.gameObject.transform.parent, arg_20_1.parent, self.roleImg.gameObject.transform.localPosition)

			self:emit(SculptureMediator.ON_FINSIH_SCULPTURE, self.id)
		else
			arg_20_1.localPosition = var_20_1
		end

		return
	end)

	return
end

function SculptureGratitudePage:UpdateRole(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	if self.charName == arg_24_1 then
		return
	end

	self:ClearChar()
	PoolMgr.GetInstance():GetSpineChar("takegift_" .. arg_24_1, true, function(arg_25_0)
		arg_25_0.transform:SetParent(self.roleImg.gameObject.transform.parent)

		arg_25_0.transform.localScale = Vector3(1, 1, 0)
		arg_25_0.transform.localPosition = Vector3(0, 0, 0)

		local var_25_0 = arg_25_0:GetComponent(typeof(SpineAnimUI))

		var_25_0:SetAction(arg_24_2 .. arg_24_1, 0)

		if arg_24_3 then
			var_25_0:SetActionCallBack(function(arg_26_0)
				if arg_26_0 == "finish" then
					var_25_0:SetActionCallBack(nil)
					var_25_0:SetAction(arg_24_3 .. arg_24_1, 0)
				end

				return
			end)
		end

		self.spineAnimUI = var_25_0
		self.charGo = arg_25_0

		if arg_24_4 then
			arg_24_4()
		end

		return
	end)

	self.charName = arg_24_1

	return
end

function SculptureGratitudePage:ClearChar()
	if self.charName and self.charGo then
		if self.spineAnimUI then
			self.spineAnimUI:SetActionCallBack(nil)

			self.spineAnimUI = nil
		end

		PoolMgr.GetInstance():ReturnSpineChar(self.charName, self.charGo)

		self.charName = nil
		self.charGo = nil
	end

	return
end

function SculptureGratitudePage:RegisterEvent()
	onButton(self, self.backBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function SculptureGratitudePage:Clear()
	if self.puzzle then
		ClearEventTrigger((self.puzzle:GetComponent(typeof(EventTriggerListener))))
		Object.Destroy(self.puzzle.gameObject)

		self.puzzle = nil
	end

	self:ClearChar()
	setActive(self.container, true)
	setActive(self.awards, false)

	return
end

function SculptureGratitudePage:Hide()
	SculptureGratitudePage.super.Hide(self)
	pg.BgmMgr.GetInstance():Pop(self.__cname)
	self:RemoveTimer()

	return
end

function SculptureGratitudePage:OnDestroy()
	self:Clear()

	return
end

return SculptureGratitudePage
