ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConfig
local BattleDropsView = class("BattleDropsView")

ys.Battle.BattleDropsView = BattleDropsView
BattleDropsView.__name = "BattleDropsView"
BattleDropsView.FLOAT_DURATION = 0.4

function BattleDropsView:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self._container = arg_1_2
	self._containerTF = self._container.transform

	self:init()

	return
end

function BattleDropsView:SetActive(arg_2_1)
	setActive(self._go, arg_2_1)

	return
end

function BattleDropsView:AddCamera(arg_3_1, arg_3_2)
	self._camera = arg_3_1
	self._uiCamera = arg_3_2
	self._cameraTF = self._camera.transform
	self._cameraSrcX = self._cameraTF.localPosition.x
	self._cameraSrcZ = self._cameraTF.localPosition.z
	self._cameraXRotate = self._cameraTF.localEulerAngles.x

	return
end

function BattleDropsView:RefreshScaleRate()
	local var_4_0 = self._camera:ScreenToWorldPoint(Vector3(UnityEngine.Screen.width, UnityEngine.Screen.height, 0))

	self._xScale = UnityEngine.Screen.width / var_4_0.x
	self._yScale = UnityEngine.Screen.height / var_4_0.y

	return
end

function BattleDropsView:Update()
	if #self._resourceList == #self._resourcePool then
		return
	end

	self:updateContainerPosition()

	return
end

function BattleDropsView:init()
	self._resourceIcon = self._tf:Find("resourceIcon")
	self._resourceText = self._tf:Find("resourceText"):GetComponent(typeof(Text))
	self._resourceGO = self._containerTF:Find("spin_gold")
	self._resourceIconX = self._resourceIcon.transform.anchoredPosition.x + self._tf.rect.width / 2
	self._resourceIconY = self._resourceIcon.transform.anchoredPosition.y + self._tf.rect.height / 2
	self._itemPool = {}
	self._resourcePool = {}
	self._resourceList = {}
	self._itemCount = 0
	self._resourceCount = 0

	self:updateCountText(self._resourceText)

	self._timerList = {}

	local var_6_0 = {}

	for iter_6_0 = 1, 5 do
		table.insert(var_6_0, self:pop(self._resourcePool))
	end

	for iter_6_1 = 1, 5 do
		self:push(var_6_0[iter_6_1], self._resourcePool)
	end

	return
end

function BattleDropsView:pop(arg_7_1)
	local var_7_0

	if #arg_7_1 == 0 then
		if arg_7_1 == self._resourcePool then
			var_7_0 = Object.Instantiate(self._resourceGO, Vector3.zero, Quaternion.identity)
			self._resourceList[#self._resourceList + 1] = var_7_0
		end

		var_7_0.transform:SetParent(self._go, false)
	else
		var_7_0 = arg_7_1[#arg_7_1]
		arg_7_1[#arg_7_1] = nil
	end

	return var_7_0
end

function BattleDropsView:push(arg_8_1, arg_8_2)
	arg_8_1.transform.localScale = Vector3(0.35, 0.35, 0.35)
	arg_8_1:GetComponent(typeof(Animator)).enabled = false

	SetActive(arg_8_1, false)

	arg_8_2[#arg_8_2 + 1] = arg_8_1

	return
end

function BattleDropsView:updateCountText(arg_9_1)
	local var_9_0

	if arg_9_1 == self._resourceText then
		var_9_0 = self._resourceCount
	end

	arg_9_1.text = var_9_0 > 999 and string.format("%s%.1f%s", "x", var_9_0 / 1000, "k") or string.format("%s%d", "x", var_9_0)

	return
end

function BattleDropsView:ShowDrop(arg_10_1)
	if #self._resourceList == #self._resourcePool then
		self:updateContainerPosition()
	end

	local var_10_0 = var_0_0.Battle.BattleVariable.CameraPosToUICamera(arg_10_1.scenePos:Clone())
	local var_10_1 = Vector3(var_10_0.x, var_10_0.y, 2)
	local var_10_2, var_10_3 = math.modf(arg_10_1.drops.resourceCount / var_0_1.RESOURCE_STEP)

	if var_10_3 > 0 then
		self:makeFloatAnima(var_10_1, self._resourcePool, self._resourceIconX, self._resourceIconY, self._resourceIcon, "_resourceCount", var_10_3 * var_0_1.RESOURCE_STEP, self._resourceText, 0)
	end

	while var_10_2 > 0 do
		self:makeFloatAnima(var_10_1, self._resourcePool, self._resourceIconX, self._resourceIconY, self._resourceIcon, "_resourceCount", var_0_1.RESOURCE_STEP, self._resourceText, var_10_2)

		var_10_2 = var_10_2 - 1
	end

	return
end

function BattleDropsView:updateContainerPosition()
	self._containerTF.localPosition = Vector3(self._xScale * (self._cameraSrcX - self._cameraTF.localPosition.x), self._yScale * (self._cameraSrcZ - self._cameraTF.localPosition.z), 0)

	return
end

function BattleDropsView:makeFloatAnima(arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6, arg_12_7, arg_12_8, arg_12_9)
	local var_12_0 = self:pop(arg_12_2)
	local var_12_1 = var_12_0.transform

	SetActive(var_12_0, true)

	var_12_0.transform.position = arg_12_1
	var_12_0.transform.localPosition = var_12_0.transform.localPosition - self._containerTF.localPosition

	self:Update()
	var_12_0.transform:SetParent(self._container, false)

	local var_12_2 = math.random() * 200

	LeanTween.moveX(rtf(var_12_0), var_12_0.transform.anchoredPosition.x + (math.random() * 200 - 100), var_0_1.RESOURCE_STAY_DURATION + arg_12_9 * 0.05):setOnComplete(System.Action(function()
		LeanTween.scale(go(var_12_0), Vector3(0.2, 0.2, 1), BattleDropsView.FLOAT_DURATION)

		var_12_1.localPosition = var_12_1.localPosition + self._containerTF.localPosition

		var_12_1:SetParent(self._go, false)
		LeanTween.move(rtf(var_12_0), Vector3(arg_12_3 - var_12_1.position.x, arg_12_4 - var_12_1.position.y, 0), BattleDropsView.FLOAT_DURATION):setOnComplete(System.Action(function()
			self:push(var_12_0, arg_12_2)

			arg_12_5.transform.localScale = Vector3(0.35, 0.35, 0.35)
			self[arg_12_6] = self[arg_12_6] + arg_12_7

			self:updateCountText(arg_12_8)
			LeanTween.scale(go(arg_12_5), Vector3(0.5, 0.5, 0.5), 0.12):setEase(LeanTweenType.easeOutExpo):setOnComplete(System.Action(function()
				LeanTween.scale(go(arg_12_5), Vector3(0.35, 0.35, 0.35), 0.3)

				return
			end))

			return
		end))

		return
	end))

	local var_12_3 = var_12_2 / 200

	LeanTween.moveY(rtf(var_12_0), var_12_0.transform.anchoredPosition.y + var_12_2, 0.5 * (var_12_2 / 200)):setOnComplete(System.Action(function()
		var_12_0:GetComponent("Animator").enabled = true

		LeanTween.moveY(rtf(var_12_0), var_12_1.anchoredPosition.y - var_12_2, 1.5 * var_12_3):setEase(LeanTweenType.easeOutBounce)

		return
	end))

	return
end

function BattleDropsView:Dispose()
	for iter_17_0, iter_17_1 in pairs(self._timerList) do
		if iter_17_1 then
			pg.TimeMgr.GetInstance():RemoveBattleTimer(iter_17_0)
		end
	end

	for iter_17_2, iter_17_3 in ipairs(self._resourceList) do
		LeanTween.cancel(go(iter_17_3))
	end

	self._timerList = nil
	self._go = nil
	self._resourceIcon = nil
	self._resourceText = nil
	self._itemIcon = nil
	self._itemText = nil
	self._camera = nil
	self._uiCamera = nil

	return
end

return
