local NewStoryRecordPanel = class("NewStoryRecordPanel")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4
local var_0_6 = 5
local var_0_7 = 10

function NewStoryRecordPanel:GetUIName()
	return "NewStoryRecordUI"
end

function NewStoryRecordPanel:Ctor()
	self.state = var_0_1

	return
end

function NewStoryRecordPanel:Load()
	self.state = var_0_2
	self.parentTF = self:GetParent()

	ResourceMgr.Inst:getAssetAsync("ui/" .. self:GetUIName(), "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_4_0)
		if self:IsLoading() then
			self.state = var_0_3

			self:Init((Object.Instantiate(arg_4_0, self.parentTF)))
		end

		return
	end), true, true)

	return
end

function NewStoryRecordPanel:GetParent()
	return pg.NewStoryMgr.GetInstance().frontTr
end

function NewStoryRecordPanel:IsEmptyOrUnload()
	return self.state == var_0_1 or self.state == var_0_6
end

function NewStoryRecordPanel:IsLoading()
	return self.state == var_0_2
end

function NewStoryRecordPanel:IsShowing()
	return self.state == var_0_4
end

function NewStoryRecordPanel:CanOpen()
	return self.state == var_0_1 or self.state == var_0_5 or self.state == var_0_6
end

function NewStoryRecordPanel:Init(arg_10_1)
	self._go = arg_10_1
	self._tf = arg_10_1.transform
	self.pageAnim = self._tf:GetComponent(typeof(Animation))
	self.pageAniEvent = self._tf:GetComponent(typeof(DftAniEvent))
	self.container = self._tf:Find("content")
	self.tpl = self._tf:Find("content/tpl")
	self.cg = GetOrAddComponent(self._tf, typeof(CanvasGroup))
	self.tplPools = {
		self.tpl
	}
	self.closeBtn = self._tf:Find("adapt/close")
	self.bgImage = self._tf:GetComponent(typeof(Image))
	self.scrollrect = self._tf:GetComponent(typeof(ScrollRect))
	self.contentSizeFitter = self._tf:Find("content"):GetComponent(typeof(ContentSizeFitter))

	onButton(nil, self.closeBtn, function()
		setButtonEnabled(self.closeBtn, false)
		self:Hide()

		return
	end, SFX_PANEL)

	self.state = var_0_4

	self:UpdateAll()

	return
end

function NewStoryRecordPanel:UpdateAll()
	self.cg.blocksRaycasts = false

	seriesAsync({
		function(arg_13_0)
			self.cg.alpha = 0

			self:UpdateList(arg_13_0)

			return
		end,
		function(arg_14_0)
			onNextTick(arg_14_0)

			return
		end,
		function(arg_15_0)
			self.cg.alpha = 1

			self:PlayAnimation(arg_15_0)

			return
		end
	}, function()
		self.cg.blocksRaycasts = true

		self:BlurPanel()

		return
	end)

	return
end

local function var_0_8(arg_17_0)
	setActive(arg_17_0._tf, true)
	setButtonEnabled(arg_17_0.closeBtn, true)
	arg_17_0.pageAniEvent:SetEndEvent(function()
		arg_17_0.pageAniEvent:SetEndEvent(nil)

		return
	end)
	arg_17_0.pageAnim:Play("anim_storyrecordUI_record_in")

	arg_17_0.state = var_0_4

	arg_17_0:UpdateAll()

	return
end

function NewStoryRecordPanel:Show(arg_19_1)
	self.recorder = arg_19_1
	self.displays = arg_19_1:GetContentList()

	if self:IsEmptyOrUnload() then
		self:Load()
	elseif self:IsLoading() then
		-- block empty
	else
		var_0_8(self)
	end

	return
end

local function var_0_9(arg_20_0)
	local var_20_0
	local var_20_1 = false

	if #arg_20_0.tplPools <= 0 then
		var_20_0 = Object.Instantiate(arg_20_0.tpl, arg_20_0.tpl.parent)
	else
		var_20_1 = true
		var_20_0 = table.remove(arg_20_0.tplPools, 1)
	end

	GetOrAddComponent(var_20_0, typeof(CanvasGroup)).alpha = 1

	return var_20_0, var_20_1
end

local function var_0_10(arg_21_0, arg_21_1)
	setActive(arg_21_1, false)

	GetOrAddComponent(arg_21_1, typeof(CanvasGroup)).alpha = 1

	if #arg_21_0.tplPools >= 5 and arg_21_1 ~= arg_21_0.tpl then
		Object.Destroy(arg_21_1.gameObject)
	else
		table.insert(arg_21_0.tplPools, arg_21_1)
	end

	return
end

function NewStoryRecordPanel:UpdateList(arg_22_1)
	if not self:IsShowing() then
		return
	end

	local var_22_0 = self.displays
	local var_22_1 = {}
	local var_22_2 = 1

	self.usingTpls = {}

	if #var_22_0 < var_0_7 then
		local var_22_3 = #var_22_0 or var_0_7
	end

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		local var_22_4 = #var_22_0

		table.insert(var_22_1, function(arg_23_0)
			local var_23_0, var_23_1 = var_0_9(self)

			if not var_23_1 then
				var_22_2 = var_22_2 + 1
			end

			self:UpdateRecord(var_23_0, iter_22_1)
			table.insert(self.usingTpls, var_23_0)
			tf(var_23_0):SetAsLastSibling()

			if var_22_2 % 5 == 0 then
				var_22_2 = 1

				onNextTick(arg_23_0)
			else
				arg_23_0()
			end

			if iter_22_0 + var_22_3 <= var_22_4 then
				setActive(var_23_0, true)
				var_23_0:GetComponent(typeof(Animation)):Play("anim_storyrecordUI_tql_reset")
			else
				GetOrAddComponent(var_23_0, typeof(CanvasGroup)).alpha = 0

				setActive(var_23_0, true)
			end

			return
		end)
	end

	table.insert(var_22_1, function(arg_24_0)
		onDelayTick(function()
			self.contentSizeFitter.enabled = false
			self.contentSizeFitter.enabled = true

			scrollToBottom(self._tf)
			arg_24_0()

			return
		end, 0.05)

		return
	end)
	seriesAsync(var_22_1, arg_22_1)

	return
end

function NewStoryRecordPanel:PlayAnimation(arg_26_1)
	local var_26_0

	if #self.displays < var_0_7 then
		var_26_0 = #self.displays or var_0_7
	end

	local var_26_1 = {}

	for iter_26_0 = 1, var_26_0 do
		table.insert(var_26_1, function(arg_27_0)
			self.usingTpls[#self.usingTpls - var_26_0 + iter_26_0]:GetComponent(typeof(Animation)):Play("anim_storyrecordUI_tpl_in")
			onDelayTick(function()
				arg_27_0()

				return
			end, 0.033)

			return
		end)
	end

	seriesAsync(var_26_1)
	arg_26_1()

	return
end

function NewStoryRecordPanel:UpdateIcon(arg_29_1, arg_29_2)
	GetImageSpriteFromAtlasAsync("SquareIcon/" .. arg_29_1.icon, "", arg_29_2:Find("Image"))

	return
end

function NewStoryRecordPanel:UpdateRecord(arg_30_1, arg_30_2)
	GetOrAddComponent(arg_30_1, typeof(CanvasGroup)).alpha = 1

	local var_30_0 = arg_30_1:Find("icon")

	setActive(var_30_0, arg_30_2.icon)

	if arg_30_2.icon then
		self:UpdateIcon(arg_30_2, var_30_0)
	end

	if arg_30_2.name and arg_30_2.nameColor then
		arg_30_1:Find("name"):GetComponent(typeof(Outline)).effectColor = Color.NewHex((string.gsub(arg_30_2.nameColor, "#", "")))

		setText(arg_30_1:Find("name"), setColorStr(arg_30_2.name, arg_30_2.nameColor))
	else
		setText(arg_30_1:Find("name"), (not arg_30_2.name or nil) and "")
	end

	local var_30_2 = arg_30_2.list
	local var_30_3 = UIItemList.New(arg_30_1:Find("content"), arg_30_1:Find("content/Text"))

	var_30_3:make(function(arg_31_0, arg_31_1, arg_31_2)
		if arg_31_0 == UIItemList.EventUpdate then
			setText(arg_31_2, var_30_2[arg_31_1 + 1])
		end

		return
	end)
	var_30_3:align(#var_30_2)
	setActive(arg_30_1:Find("player"), arg_30_2.icon == nil and arg_30_2.isPlayer)

	local var_30_4 = arg_30_2.icon == nil and arg_30_2.name == nil
	local var_30_5 = var_30_3.container:GetComponent(typeof(UnityEngine.UI.HorizontalOrVerticalLayoutGroup))
	local var_30_6 = UnityEngine.RectOffset.New()

	var_30_6.left = 170
	var_30_6.right = 0
	var_30_6.top = var_30_4 and 25 or 90
	var_30_6.bottom = var_30_4 and 25 or 50
	var_30_5.padding = var_30_6

	return
end

function NewStoryRecordPanel:OnHide()
	self:Clear()
	self:UnblurPanel()
	setActive(self._tf, false)
	setButtonEnabled(self.closeBtn, true)

	self.state = var_0_5

	return
end

function NewStoryRecordPanel:Hide()
	if self:IsShowing() then
		self.pageAniEvent:SetEndEvent(nil)
		self.pageAniEvent:SetEndEvent(function()
			self:OnHide()

			return
		end)
		self.pageAnim:Play("anim_storyrecordUI_record_out")
	end

	return
end

function NewStoryRecordPanel:BlurPanel()
	setParent(pg.NewStoryMgr.GetInstance()._tf, pg.UIMgr.GetInstance().UIMain)

	local var_35_0 = pg.UIMgr.GetInstance().OverlayMain

	self.hideNodes = {}

	for iter_35_0 = 1, var_35_0.childCount do
		local var_35_1 = var_35_0:GetChild(iter_35_0 - 1)

		if isActive(var_35_1) then
			table.insert(self.hideNodes, var_35_1)
			setActive(var_35_1, false)
		end
	end

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function NewStoryRecordPanel:UnblurPanel()
	setParent(pg.NewStoryMgr.GetInstance()._tf, pg.UIMgr.GetInstance().OverlayToast)

	if self.hideNodes and #self.hideNodes > 0 then
		for iter_36_0, iter_36_1 in ipairs(self.hideNodes) do
			setActive(iter_36_1, true)
		end
	end

	self.hideNodes = {}

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self.parentTF)

	return
end

function NewStoryRecordPanel:Clear()
	for iter_37_0, iter_37_1 in ipairs(self.usingTpls) do
		var_0_10(self, iter_37_1)
	end

	self.usingTpls = {}

	return
end

function NewStoryRecordPanel:Unload()
	if self.state > var_0_2 then
		self.state = var_0_6

		if not IsNil(self.closeBtn) then
			removeOnButton(self.closeBtn)
		end

		Object.Destroy(self._go)

		self._go = nil
		self._tf = nil
		self.container = nil
		self.tpl = nil
	end

	return
end

function NewStoryRecordPanel:Dispose()
	self:Hide()
	self:Unload()

	return
end

return NewStoryRecordPanel
