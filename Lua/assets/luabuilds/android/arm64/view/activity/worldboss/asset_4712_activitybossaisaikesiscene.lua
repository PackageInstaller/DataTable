local ActivityBossAisaikesiScene = class("ActivityBossAisaikesiScene", import(".ActivityBossSceneTemplate"))

ActivityBossAisaikesiScene.ASKSRemasterStage = 1201204

function ActivityBossAisaikesiScene:getUIName()
	return "ActivityBossAisaikesiUI"
end

function ActivityBossAisaikesiScene:init()
	ActivityBossAisaikesiScene.super.init(self)

	self.loader = AutoLoader.New()

	return
end

function ActivityBossAisaikesiScene:didEnter()
	ActivityBossAisaikesiScene.super.didEnter(self)

	local var_3_0 = 0

	onButton(self, self.mainTF:Find("logo"), function()
		var_3_0 = var_3_0 + 1

		if var_3_0 >= 10 then
			self:RemasterSuffering()

			var_3_0 = 0

			return
		end

		pg.TipsMgr.GetInstance():ShowTips(10 - var_3_0)

		return
	end)

	return
end

function ActivityBossAisaikesiScene:UpdatePage()
	ActivityBossAisaikesiScene.super.UpdatePage(self)

	return
end

function ActivityBossAisaikesiScene:EnterAnim()
	local function var_6_0()
		ActivityBossAisaikesiScene.super.EnterAnim(self)
		self.loader:GetPrefab("ui/ASKS_Loop", "", function(arg_8_0)
			setParent(arg_8_0, self.mainTF)
			setAnchoredPosition(arg_8_0, {
				x = -154.7,
				y = -120.9
			})
			tf(arg_8_0):SetAsFirstSibling()

			self.raidarAnim = arg_8_0

			setActive(arg_8_0, true)

			return
		end)

		return
	end

	if not self.contextData.showAni then
		var_6_0()

		return
	end

	self.contextData.showAni = nil

	local var_6_1 = self.mainTF:Find("logo")

	setActive(var_6_1, false)

	local var_6_2

	local function var_6_3()
		setActive(var_6_1, true)
		setActive(var_6_2, false)
		self.loader:ReturnPrefab(var_6_2)

		return
	end

	self.loader:GetPrefab("ui/asks", "asks", function(arg_10_0)
		setParent(arg_10_0, self._tf)

		var_6_2 = arg_10_0

		local var_10_0
		local var_10_1 = arg_10_0:GetComponent("DftAniEvent")

		var_10_1:SetEndEvent(var_6_3)
		var_10_1:SetTriggerEvent(function()
			var_6_0()

			var_10_0 = true

			return
		end)
		onButton(self, arg_10_0, function()
			local var_12_0 = var_10_0

			if not var_10_0 then
				var_12_0 = var_6_0()
				var_12_0 = var_12_0 or true
			end

			var_10_0 = var_12_0

			var_6_3()

			return
		end)

		return
	end)

	return
end

function ActivityBossAisaikesiScene:RemasterSuffering()
	local var_13_0 = GameObject.New("Mask")
	local var_13_1 = var_13_0:AddComponent(typeof(RectTransform))

	var_13_1.anchorMin = Vector2.zero
	var_13_1.anchorMax = Vector2.one

	local var_13_2 = var_13_0:AddComponent(typeof(Image))

	var_13_2.color = Color.New(0, 0, 0, 1)
	var_13_2.raycastTarget = false

	var_13_1:SetParent(self._tf)
	pg.NewStoryMgr.GetInstance():Play("AISAIKESICAIDAN", function()
		self:emit(self.contextData.mediatorClass.ON_PERFORM_COMBAT, self.ASKSRemasterStage)

		return
	end)

	return
end

function ActivityBossAisaikesiScene:willExit()
	self.loader:Clear()
	ActivityBossAisaikesiScene.super.willExit(self)

	return
end

return ActivityBossAisaikesiScene
