local SculptureDrawLinePage = class("SculptureDrawLinePage", import("view.base.BaseSubView"))

function SculptureDrawLinePage:getUIName()
	return "SculptureDrawLineUI"
end

function SculptureDrawLinePage:OnLoaded()
	self.cg = GetOrAddComponent(self._parentTf, typeof(CanvasGroup))
	self.backBtn = self._tf:Find("back")
	self.helpBtn = self._tf:Find("help")
	self.frame = self._tf:Find("frame")
	self.eventTrigger = self._tf:Find("frame"):GetComponent(typeof(EventTriggerListener))
	self.uiCam = pg.UIMgr.GetInstance().uiCamera:GetComponent("Camera")
	self.oneKeyBtn = self.frame:Find("onekey")
	self.penTpl = self.frame:Find("pen")

	setText(self._tf:Find("tip"), i18n("sculpture_drawline_tip"))

	return
end

function SculptureDrawLinePage:OnInit()
	self.points = {}
	self.index = 0

	return
end

function SculptureDrawLinePage:Show(arg_4_1, arg_4_2)
	SculptureDrawLinePage.super.Show(self)

	self.id = arg_4_1
	self.activity = arg_4_2

	seriesAsync({
		function(arg_5_0)
			self:Clear()
			self:InitLine(arg_5_0)

			return
		end,
		function(arg_6_0)
			self:InitOneKey(arg_6_0)

			return
		end,
		function(arg_7_0)
			self:InitLineRendering()
			self:RegisterEvent(arg_7_0)

			return
		end
	})
	pg.BgmMgr.GetInstance():Push(self.__cname, "bar-soft")

	return
end

function SculptureDrawLinePage:InitLine(arg_8_1)
	ResourceMgr.Inst:getAssetAsync("ui/" .. self.activity:GetResorceName(self.id) .. "_line", "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_9_0)
		self.tracker = Object.Instantiate(arg_9_0, self.frame).transform
		self.trackerCollider = self.tracker:GetComponent("EdgeCollider2D")

		arg_8_1()

		return
	end), true, true)

	return
end

function SculptureDrawLinePage:InitOneKey(arg_10_1)
	ResourceMgr.Inst:getAssetAsync("ui/" .. self.activity:GetResorceName(self.id) .. "_onekey", "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_11_0)
		self.onekeyTrack = Object.Instantiate(arg_11_0, self.frame).transform:GetComponent("EdgeCollider2D")

		arg_10_1()

		return
	end), true, true)

	return
end

function SculptureDrawLinePage:InitLineRendering()
	self.eventTrigger:AddPointDownFunc(function(arg_13_0, arg_13_1)
		self:OnPointDown(arg_13_1)

		return
	end)
	self.eventTrigger:AddPointUpFunc(function(arg_14_0, arg_14_1)
		self:OnPointUp()

		return
	end)
	self.eventTrigger:AddDragFunc(function(arg_15_0, arg_15_1)
		self.index = self.index + 1

		if self.index % 5 ~= 0 then
			return
		end

		self:OnDrag(arg_15_1)

		return
	end)

	return
end

function SculptureDrawLinePage:OnPointDown(arg_16_1)
	self.points = {}

	self:AddPoint(arg_16_1.position)

	self.pen = Object.Instantiate(self.penTpl, self.points[#self.points], Quaternion.New(0, 0, 0, 0), self.frame)

	setActive(self.pen, true)

	return
end

function SculptureDrawLinePage:OnPointUp()
	if not self.pen then
		return
	end

	if #self.points <= 2 then
		self.points = {}

		return
	end

	local var_17_0 = true

	for iter_17_0, iter_17_1 in ipairs(self.points) do
		if not self.trackerCollider:OverlapPoint(iter_17_1) then
			var_17_0 = false

			break
		end
	end

	if var_17_0 and (#self.points < 20 or Vector2.Distance(self.points[1], self.points[#self.points]) > 2) then
		var_17_0 = false
	end

	if not var_17_0 then
		self.contextData.tipPage:ExecuteAction("Show")
	else
		self:OnPass()
	end

	Object.Destroy(self.pen.gameObject)

	self.pen = nil

	return
end

function SculptureDrawLinePage:OnPass()
	self.contextData.miniMsgBox:ExecuteAction("Show", {
		model = true,
		effect = true,
		yes_text = "btn_next",
		content = i18n("sculpture_drawline_done"),
		onYes = function()
			self:emit(SculptureMediator.ON_DRAW_SCULPTURE, self.id)

			return
		end
	})

	return
end

function SculptureDrawLinePage:OnDrag(arg_20_1)
	if not self.pen then
		return
	end

	self:AddPoint(arg_20_1.position)

	self.pen.position = self.points[#self.points]

	return
end

function SculptureDrawLinePage:AddPoint(arg_21_1)
	local var_21_0 = self.uiCam:ScreenToWorldPoint(arg_21_1)

	table.insert(self.points, (Vector3(var_21_0.x, var_21_0.y, -1)))

	return
end

function SculptureDrawLinePage:RegisterEvent(arg_22_1)
	onButton(self, self.backBtn, function()
		self.contextData.miniMsgBox:ExecuteAction("Show", {
			showNo = true,
			content = i18n("sculpture_drawline_exit"),
			onYes = function()
				self:Hide()

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.oneKeyBtn, function()
		self:OnOneKey()

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.gift_act_help.tip
		})

		return
	end, SFX_PANEL)

	return
end

function SculptureDrawLinePage:OnOneKey()
	self.points = {}

	for iter_27_0, iter_27_1 in ipairs(self.onekeyTrack.points:ToTable()) do
		local var_27_0 = self.tracker:TransformPoint(iter_27_1)

		table.insert(self.points, (Vector3(var_27_0.x, var_27_0.y, -1)))
	end

	local function var_27_1(arg_28_0)
		if not self.pen then
			self.pen = Object.Instantiate(self.penTpl, arg_28_0, Quaternion.New(0, 0, 0, 0), self.frame)
		else
			self.pen.position = arg_28_0
		end

		return
	end

	local var_27_2 = {}

	for iter_27_2 = 1, #self.points do
		table.insert(var_27_2, function(arg_29_0)
			var_27_1(self.points[iter_27_2])
			onNextTick(arg_29_0)

			return
		end)
	end

	self.cg.blocksRaycasts = false

	seriesAsync(var_27_2, function()
		self:OnPass()

		self.cg.blocksRaycasts = true

		if self.pen then
			Object.Destroy(self.pen.gameObject)

			self.pen = nil
		end

		return
	end)

	return
end

function SculptureDrawLinePage:Clear()
	if not IsNil(self.tracker) then
		Object.Destroy(self.tracker.gameObject)
	end

	self.points = {}
	self.tracker = nil

	removeOnButton(self.oneKeyBtn)

	return
end

function SculptureDrawLinePage:Hide()
	SculptureDrawLinePage.super.Hide(self)
	pg.BgmMgr.GetInstance():Pop(self.__cname)
	self:Clear()

	return
end

function SculptureDrawLinePage:OnDestroy()
	self.exited = true

	return
end

return SculptureDrawLinePage
