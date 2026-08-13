class = var_0_10000

local var_0_0 = var_0_10000("NewStoryRecordPanel")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4
local var_0_6 = 5
local var_0_7 = 10

function var_0_0.GetUIName(arg_1_0)
	return "NewStoryRecordUI"
end

function var_0_0.Ctor(arg_2_0)
	arg_2_0.state = var_0_1

	return
end

function var_0_0.Load(arg_3_0)
	arg_3_0.state = var_0_2
	arg_3_0.parentTF = arg_3_0:GetParent()
	ResourceMgr = var_1

	local var_3_0 = var_1.Inst
	local var_3_1 = var_1.getAssetAsync
	local var_3_2 = "ui/" .. arg_3_0:GetUIName()
	local var_3_3 = ""

	UnityEngine = var_1_10006

	var_3_1(var_3_0, var_3_2, var_3_3, var_1_10006.Events.UnityAction_UnityEngine_Object(function(arg_4_0)
		Object = var_2_10001

		local var_4_0 = var_2_10001.Instantiate(arg_4_0, arg_3_0.parentTF)
		local var_4_1 = arg_3_0

		if var_2.IsLoading(var_4_1) then
			arg_3_0.state = var_0_3

			local var_4_2 = arg_3_0

			var_2.Init(var_4_2, var_4_0)
		end

		return
	end), true, true)

	return
end

function var_0_0.GetParent(arg_5_0)
	pg = var_1_10001

	return var_1_10001.NewStoryMgr.GetInstance().frontTr
end

function var_0_0.IsEmptyOrUnload(arg_6_0)
	return arg_6_0.state == var_0_1 or arg_6_0.state == var_0_6
end

function var_0_0.IsLoading(arg_7_0)
	return arg_7_0.state == var_0_2
end

function var_0_0.IsShowing(arg_8_0)
	return arg_8_0.state == var_0_4
end

function var_0_0.CanOpen(arg_9_0)
	return arg_9_0.state == var_0_1 or arg_9_0.state == var_0_5 or arg_9_0.state == var_0_6
end

function var_0_0.Init(arg_10_0, arg_10_1)
	arg_10_0._go = arg_10_1
	arg_10_0._tf = arg_10_1.transform

	local var_10_0 = arg_10_0._tf
	local var_10_1 = var_2.GetComponent

	typeof = var_1_10005
	Animation = var_1_10007
	arg_10_0.pageAnim = var_10_1(var_10_0, var_1_10005(var_1_10007))

	local var_10_2 = arg_10_0._tf
	local var_10_3 = var_2.GetComponent

	typeof = var_5
	DftAniEvent = var_1_10007
	arg_10_0.pageAniEvent = var_10_3(var_10_2, var_5(var_1_10007))

	local var_10_4 = arg_10_0._tf

	arg_10_0.container = var_2.Find(var_10_4, "content")

	local var_10_5 = arg_10_0._tf

	arg_10_0.tpl = var_2.Find(var_10_5, "content/tpl")
	GetOrAddComponent = var_2

	local var_10_6 = arg_10_0._tf

	typeof = var_5
	CanvasGroup = var_1_10007
	arg_10_0.cg = var_2(var_10_6, var_5(var_1_10007))
	arg_10_0.tplPools = {
		arg_10_0.tpl
	}

	local var_10_7 = arg_10_0._tf

	arg_10_0.closeBtn = var_2.Find(var_10_7, "adapt/close")

	local var_10_8 = arg_10_0._tf
	local var_10_9 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_10_0.bgImage = var_10_9(var_10_8, var_5(var_1_10007))

	local var_10_10 = arg_10_0._tf
	local var_10_11 = var_2.GetComponent

	typeof = var_5
	ScrollRect = var_1_10007
	arg_10_0.scrollrect = var_10_11(var_10_10, var_5(var_1_10007))

	local var_10_12 = arg_10_0._tf
	local var_10_13 = var_2.Find(var_10_12, "content")
	local var_10_14 = var_2.GetComponent

	typeof = var_5
	ContentSizeFitter = var_1_10007
	arg_10_0.contentSizeFitter = var_10_14(var_10_13, var_5(var_1_10007))
	onButton = var_2

	local var_10_15
	local var_10_16 = arg_10_0.closeBtn

	local function var_10_17()
		setButtonEnabled = var_2_10000

		var_2_10000(arg_10_0.closeBtn, false)

		local var_11_0 = arg_10_0

		var_0.Hide(var_11_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_10_15, var_10_16, var_10_17, var_1_10007)

	arg_10_0.state = var_0_4

	arg_10_0:UpdateAll()

	return
end

function var_0_0.UpdateAll(arg_12_0)
	local var_12_0 = arg_12_0.cg

	var_12_0.blocksRaycasts = false
	seriesAsync = var_12_0

	var_12_0({
		function(arg_13_0)
			arg_12_0.cg.alpha = 0

			local var_13_0 = arg_12_0

			var_1.UpdateList(var_13_0, arg_13_0)

			return
		end,
		function(arg_14_0)
			onNextTick = var_2_10001

			var_2_10001(arg_14_0)

			return
		end,
		function(arg_15_0)
			arg_12_0.cg.alpha = 1

			local var_15_0 = arg_12_0

			var_1.PlayAnimation(var_15_0, arg_15_0)

			return
		end
	}, function()
		arg_12_0.cg.blocksRaycasts = true

		local var_16_0 = arg_12_0

		var_0.BlurPanel(var_16_0)

		return
	end)

	return
end

local function var_0_8(arg_17_0)
	setActive = var_1_10001

	var_1_10001(arg_17_0._tf, true)

	setButtonEnabled = var_1_10001

	var_1_10001(arg_17_0.closeBtn, true)

	local var_17_0 = arg_17_0.pageAniEvent

	var_1.SetEndEvent(var_17_0, function()
		local var_18_0 = arg_17_0.pageAniEvent

		var_0.SetEndEvent(var_18_0, nil)

		return
	end)

	local var_17_1 = arg_17_0.pageAnim

	var_1.Play(var_17_1, "anim_storyrecordUI_record_in")

	arg_17_0.state = var_0_4

	arg_17_0:UpdateAll()

	return
end

function var_0_0.Show(arg_19_0, arg_19_1)
	arg_19_0.recorder = arg_19_1
	arg_19_0.displays = arg_19_1:GetContentList()

	if arg_19_0:IsEmptyOrUnload() then
		arg_19_0:Load()
	elseif arg_19_0:IsLoading() then
		-- block empty
	else
		var_0_8(arg_19_0)
	end

	return
end

local function var_0_9(arg_20_0)
	local var_20_0
	local var_20_1 = false

	if #arg_20_0.tplPools <= 0 then
		Object = var_3
		var_20_0 = var_3.Instantiate(arg_20_0.tpl, arg_20_0.tpl.parent)
	else
		var_20_1 = true
		table = var_3
		var_20_0 = var_3.remove(arg_20_0.tplPools, 1)
	end

	GetOrAddComponent = var_3

	local var_20_2 = var_20_0

	typeof = var_1_10006
	CanvasGroup = var_1_10008
	var_3(var_20_2, var_1_10006(var_1_10008)).alpha = 1

	return var_20_0, var_20_1
end

local function var_0_10(arg_21_0, arg_21_1)
	setActive = var_1_10002

	var_1_10002(arg_21_1, false)

	GetOrAddComponent = var_1_10002

	local var_21_0 = arg_21_1

	typeof = var_5
	CanvasGroup = var_1_10007
	var_1_10002(var_21_0, var_5(var_1_10007)).alpha = 1

	if #arg_21_0.tplPools >= 5 and arg_21_1 ~= arg_21_0.tpl then
		Object = var_2

		var_2.Destroy(arg_21_1.gameObject)
	else
		table = var_2

		var_2.insert(arg_21_0.tplPools, arg_21_1)
	end

	return
end

function var_0_0.UpdateList(arg_22_0, arg_22_1)
	if not arg_22_0:IsShowing() then
		return
	end

	local var_22_0 = arg_22_0.displays
	local var_22_1 = {}
	local var_22_2 = 1

	arg_22_0.usingTpls = {}

	local var_22_3

	if not (#var_22_0 < var_0_7) or not #var_22_0 then
		var_22_3 = var_0_7
	end

	ipairs = var_6

	for iter_22_0, iter_22_1 in var_6(var_22_0) do
		local var_22_4 = #var_22_0

		table = var_1_10012

		var_1_10012.insert(var_22_1, function(arg_23_0)
			local var_23_0, var_23_1 = var_0_9(arg_22_0)

			if not var_23_1 then
				var_22_2 = var_22_2 + 1
			end

			local var_23_2 = arg_22_0

			var_3.UpdateRecord(var_23_2, var_23_0, iter_22_1)

			table = var_3

			var_3.insert(arg_22_0.usingTpls, var_23_0)

			tf = var_3

			local var_23_3 = var_3(var_23_0)

			var_3.SetAsLastSibling(var_23_3)

			if var_22_2 % 5 == 0 then
				var_22_2 = 1
				onNextTick = var_3

				var_3(arg_23_0)
			else
				arg_23_0()
			end

			local var_23_4 = var_23_0
			local var_23_5 = var_23_0.GetComponent

			typeof = var_6
			Animation = var_2_10008

			local var_23_6 = var_23_5(var_23_4, var_6(var_2_10008))

			if iter_22_0 + var_22_3 <= var_22_4 then
				setActive = var_4

				var_4(var_23_0, true)
				var_23_6:Play("anim_storyrecordUI_tql_reset")
			else
				GetOrAddComponent = var_4

				local var_23_7 = var_23_0

				typeof = var_7
				CanvasGroup = var_2_10009

				local var_23_8 = var_4(var_23_7, var_7(var_2_10009))

				var_23_8.alpha = 0
				setActive = var_23_8

				var_23_8(var_23_0, true)
			end

			return
		end)
	end

	table = var_6

	var_6.insert(var_22_1, function(arg_24_0)
		onDelayTick = var_2_10001

		var_2_10001(function()
			arg_22_0.contentSizeFitter.enabled = false

			local var_25_0 = arg_22_0.contentSizeFitter

			var_25_0.enabled = true
			scrollToBottom = var_25_0

			var_25_0(arg_22_0._tf)
			arg_24_0()

			return
		end, 0.05)

		return
	end)

	seriesAsync = var_6

	var_6(var_22_1, arg_22_1)

	return
end

function var_0_0.PlayAnimation(arg_26_0, arg_26_1)
	local var_26_0

	if not (#arg_26_0.displays < var_0_7) or not #var_2 then
		var_26_0 = var_0_7
	end

	local var_26_1 = {}

	for iter_26_0 = 1, var_26_0 do
		table = var_1_10009

		var_1_10009.insert(var_26_1, function(arg_27_0)
			local var_27_0 = #arg_26_0.usingTpls - var_26_0 + iter_26_0
			local var_27_1 = arg_26_0.usingTpls[var_27_0]
			local var_27_2 = var_2.GetComponent

			typeof = var_2_10006
			Animation = var_2_10008

			local var_27_3 = var_27_2(var_27_1, var_2_10006(var_2_10008))

			var_3.Play(var_27_3, "anim_storyrecordUI_tpl_in")

			onDelayTick = var_3

			var_3(function()
				arg_27_0()

				return
			end, 0.033)

			return
		end)
	end

	seriesAsync = var_5

	var_5(var_26_1)
	arg_26_1()

	return
end

function var_0_0.UpdateIcon(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_1.icon

	GetImageSpriteFromAtlasAsync = var_1_10004

	var_1_10004("SquareIcon/" .. var_29_0, "", arg_29_2:Find("Image"))

	return
end

function var_0_0.UpdateRecord(arg_30_0, arg_30_1, arg_30_2)
	GetOrAddComponent = var_1_10003

	local var_30_0 = arg_30_1

	typeof = var_1_10006
	CanvasGroup = var_1_10008
	var_1_10003(var_30_0, var_1_10006(var_1_10008)).alpha = 1

	local var_30_1 = arg_30_1
	local var_30_2 = arg_30_1.Find(var_30_1, "icon")

	setActive = var_4

	var_4(var_30_2, arg_30_2.icon)

	if arg_30_2.icon then
		arg_30_0:UpdateIcon(arg_30_2, var_30_2)
	end

	local var_30_3

	if arg_30_2.name and arg_30_2.nameColor then
		string = var_30_3
		var_30_3 = var_30_3.gsub(arg_30_2.nameColor, "#", "")

		local var_30_4 = arg_30_1:Find("name")

		var_30_1 = var_30_1.GetComponent
		typeof = var_8
		Outline = var_1_10010
		var_30_1 = var_30_1(var_30_4, var_8(var_1_10010))
		Color = var_6
		var_30_1.effectColor = var_6.NewHex(var_30_3)
		setText = var_6

		local var_30_5 = arg_30_1:Find("name")

		setColorStr = var_1_10009

		var_6(var_30_5, var_1_10009(arg_30_2.name, arg_30_2.nameColor))
	else
		setText = var_30_3

		local var_30_6 = arg_30_1:Find("name")
		local var_30_7

		if not arg_30_2.name then
			var_30_7 = ""
		end

		var_30_3(var_30_6, var_30_7)
	end

	local var_30_8 = arg_30_2.list

	UIItemList = var_30_1

	local var_30_9 = var_30_1.New(arg_30_1:Find("content"), arg_30_1:Find("content/Text"))

	var_5.make(var_30_9, function(arg_31_0, arg_31_1, arg_31_2)
		UIItemList = var_2_10003

		if arg_31_0 == var_2_10003.EventUpdate then
			setText = var_3

			var_3(arg_31_2, var_30_8[arg_31_1 + 1])
		end

		return
	end)
	var_5:align(#var_30_8)

	setActive = var_6

	local var_30_10 = arg_30_1

	var_6(arg_30_1.Find(var_30_10, "player"), arg_30_2.icon == nil and arg_30_2.isPlayer)

	local var_30_11 = arg_30_2.icon == nil and arg_30_2.name == nil
	local var_30_12 = var_5.container
	local var_30_13 = var_7.GetComponent

	typeof = var_30_10
	UnityEngine = var_1_10012

	local var_30_14 = var_30_13(var_30_12, var_30_10(var_1_10012.UI.HorizontalOrVerticalLayoutGroup))

	UnityEngine = var_8

	local var_30_15 = var_8.RectOffset.New()

	var_30_15.left = 170
	var_30_15.right = 0
	var_30_15.top = var_30_11 and 25 or 90
	var_30_15.bottom = var_30_11 and 25 or 50
	var_30_14.padding = var_30_15

	return
end

function var_0_0.OnHide(arg_32_0)
	arg_32_0:Clear()
	arg_32_0:UnblurPanel()

	setActive = var_1

	var_1(arg_32_0._tf, false)

	setButtonEnabled = var_1

	var_1(arg_32_0.closeBtn, true)

	arg_32_0.state = var_0_5

	return
end

function var_0_0.Hide(arg_33_0)
	if arg_33_0:IsShowing() then
		local var_33_0 = arg_33_0.pageAniEvent

		var_1.SetEndEvent(var_33_0, nil)

		local var_33_1 = arg_33_0.pageAniEvent

		var_1.SetEndEvent(var_33_1, function()
			local var_34_0 = arg_33_0

			var_0.OnHide(var_34_0)

			return
		end)

		local var_33_2 = arg_33_0.pageAnim

		var_1.Play(var_33_2, "anim_storyrecordUI_record_out")
	end

	return
end

function var_0_0.BlurPanel(arg_35_0)
	setParent = var_1_10001
	pg = var_1_10003

	local var_35_0 = var_1_10003.NewStoryMgr.GetInstance()._tf

	pg = var_1_10004

	var_1_10001(var_35_0, var_1_10004.UIMgr.GetInstance().UIMain)

	pg = var_1_10001

	local var_35_1 = var_1_10001.UIMgr.GetInstance().OverlayMain

	arg_35_0.hideNodes = {}

	for iter_35_0 = 1, var_35_1.childCount do
		local var_35_2 = var_35_1:GetChild(iter_35_0 - 1)

		isActive = var_1_10007

		if var_1_10007(var_35_2) then
			table = var_1_10007

			var_1_10007.insert(arg_35_0.hideNodes, var_35_2)

			setActive = var_1_10007

			var_1_10007(var_35_2, false)
		end
	end

	pg = var_2

	local var_35_3 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_35_3, arg_35_0._tf)

	return
end

function var_0_0.UnblurPanel(arg_36_0)
	setParent = var_1_10001
	pg = var_1_10003

	local var_36_0 = var_1_10003.NewStoryMgr.GetInstance()._tf

	pg = var_1_10004

	var_1_10001(var_36_0, var_1_10004.UIMgr.GetInstance().OverlayToast)

	if arg_36_0.hideNodes and #arg_36_0.hideNodes > 0 then
		ipairs = var_1

		for iter_36_0, iter_36_1 in var_1(arg_36_0.hideNodes) do
			setActive = var_1_10006

			var_1_10006(iter_36_1, true)
		end
	end

	arg_36_0.hideNodes = {}
	pg = var_1

	local var_36_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_36_1, arg_36_0._tf, arg_36_0.parentTF)

	return
end

function var_0_0.Clear(arg_37_0)
	ipairs = var_1_10001

	for iter_37_0, iter_37_1 in var_1_10001(arg_37_0.usingTpls) do
		var_0_10(arg_37_0, iter_37_1)
	end

	arg_37_0.usingTpls = {}

	return
end

function var_0_0.Unload(arg_38_0)
	if arg_38_0.state > var_0_2 then
		arg_38_0.state = var_0_6
		IsNil = var_1

		if not var_1(arg_38_0.closeBtn) then
			removeOnButton = var_1

			var_1(arg_38_0.closeBtn)
		end

		Object = var_1

		var_1.Destroy(arg_38_0._go)

		arg_38_0._go = nil
		arg_38_0._tf = nil
		arg_38_0.container = nil
		arg_38_0.tpl = nil
	end

	return
end

function var_0_0.Dispose(arg_39_0)
	arg_39_0:Hide()
	arg_39_0:Unload()

	return
end

return var_0_0
