local UIStrikeAnim = class("UIStrikeAnim", import(".UIAnim"))

UIStrikeAnim.Fields = {
	char = "table",
	aniEvent = "userdata",
	painting = "userdata",
	playing = "boolean",
	transform = "userdata",
	prefab = "string",
	onTrigger = "function",
	onStart = "function",
	onEnd = "function",
	skelegraph = "userdata",
	shipVO = "table"
}
UIStrikeAnim.EventLoaded = "UIStrikeAnim.EventLoaded"

function UIStrikeAnim:Setup(arg_1_1, arg_1_2)
	self.prefab = arg_1_1
	self.shipVO = arg_1_2

	return
end

function UIStrikeAnim:LoadBack()
	if self.transform and self.painting and self.char then
		self:Init()
		self:DispatchEvent(UIStrikeAnim.EventLoaded)
	end

	return
end

function UIStrikeAnim:Load()
	local var_3_0 = self.prefab
	local var_3_1 = PoolMgr.GetInstance()

	var_3_1:GetUI(self.prefab, true, function(arg_4_0)
		if var_3_0 == self.prefab then
			self.transform = arg_4_0.transform

			self:LoadBack()
		else
			var_3_1:ReturnUI(var_3_0, arg_4_0)
		end

		return
	end)
	self:ReloadShip(self.shipVO)

	return
end

function UIStrikeAnim:ReloadShip(arg_5_1)
	self.shipVO = arg_5_1
	self.aniEvent = nil
	self.painting = nil
	self.char = nil

	PoolMgr.GetInstance().GetInstance():GetPainting(arg_5_1:getPainting(), true, function(arg_6_0)
		self.painting = arg_6_0

		ShipExpressionHelper.SetExpression(self.painting, arg_5_1:getPainting())
		self:LoadBack()

		return
	end)

	self.char = SpineAnimChar.New()

	self.char:SetPaint(arg_5_1:getPrefab())
	self.char:Load(true, function(arg_7_0)
		self.char = arg_7_0

		self.char:SetLocalScale(Vector3.one)
		self:LoadBack()

		return
	end)

	return
end

function UIStrikeAnim:UnloadShipVO()
	retPaintingPrefab(self.transform:Find("mask/painting"), self.shipVO:getPainting())
	self.char:Dispose()

	self.shipVO = nil
	self.painting = nil
	self.char = nil

	return
end

function UIStrikeAnim:Play(arg_9_1)
	self.playing = true

	function self.onStart(arg_10_0)
		self.char:SetAction("attack", 0)

		self.skelegraph.freeze = true

		return
	end

	function self.onTrigger(arg_11_0)
		self.skelegraph.freeze = false

		self.char:SetActionCallBack(function(arg_12_0)
			if arg_12_0 == "action" then
				-- block empty
			elseif arg_12_0 == "finish" then
				self.skelegraph.freeze = true
			end

			return
		end)

		return
	end

	self.onEnd = arg_9_1

	self:Update()

	return
end

function UIStrikeAnim:Stop()
	self.playing = false

	self:Update()

	if self.skelegraph then
		self.skelegraph.freeze = false
	end

	self:UnloadShipVO()

	return
end

function UIStrikeAnim:Init()
	setActive(self.transform, false)

	local var_14_0 = self.transform:Find("ship")

	setParent(self.painting, self.transform:Find("mask/painting"):Find("fitter"), false)
	self.char:SetParent(var_14_0)
	setActive(var_14_0, false)
	setActive(self.transform:Find("torpedo"), false)

	self.skelegraph = self.char:GetSkeletonGraphic()
	self.aniEvent = self.transform:GetComponent("DftAniEvent")

	self:Update()

	return
end

return UIStrikeAnim
