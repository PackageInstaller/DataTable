local var_0_0 = singletonClass("DynamicPortraitPool")
local var_0_1 = "Widget/System/Portrait/Head/"
local var_0_2 = "Widget/System/Portrait/Frame/"
local var_0_3 = "Widget/System/Chat/Bubbles/"
local var_0_4 = "Widget/System/PlayerProfileBg/profileBg_s/PPBCode_s_"
local var_0_5 = 10

function var_0_0:Ctor()
	self:Init()
	RegistChangeSceneClearHandler(function()
		self:ClearAll()
	end)
end

function var_0_0:Init()
	self.root = Asset.Instantiate("Widget/Pooled/UIPooled")
	self.poolRoot = self.root.transform:Find("Canvas/UIPooled")
	self.headPoolRoot = self.poolRoot:Find("headPool")
	self.framePoolRoot = self.poolRoot:Find("framePool")
	self.bubblePoolRoot = self.poolRoot:Find("bubblePool")
	self.cardBgPoolRoot = self.poolRoot:Find("cardBgPool")
	self.headPool = {}
	self.headCounter = 0
	self.framePool = {}
	self.frameCounter = 0
	self.bubblePool = {}
	self.bubbleCounter = 0
	self.cardBgPool = {}
	self.cardBgCounter = 0
end

function var_0_0:GetHead(arg_4_1, arg_4_2)
	local var_4_0 = true
	local var_4_1 = self.headPool[arg_4_1]

	if self.headPool[arg_4_1] == nil then
		self.headPool[arg_4_1] = {
			refCounter = 0
		}
		var_4_1 = self.headPool[arg_4_1]
	end

	if isNil(var_4_1.obj) then
		var_4_0 = false
		var_4_1.obj = Asset.Instantiate(var_0_1 .. arg_4_1)

		if isNil(var_4_1.obj) then
			return nil
		else
			var_4_1.obj.transform:SetParent(self.headPoolRoot)

			var_4_1.obj.transform.localScale = Vector3.one
			var_4_1.obj.transform.localPosition = Vector3.zero
		end
	end

	var_4_1.refCounter = var_4_1.refCounter + 1

	if var_4_1.refCounter == 1 and not var_4_0 then
		self.headCounter = self.headCounter + 1
	end

	local var_4_2 = GameObject.Instantiate(var_4_1.obj, arg_4_2)

	var_4_2.transform.localScale = Vector3.one
	var_4_2.transform.localPosition = Vector3.zero

	return var_4_2
end

function var_0_0:GetFrame(arg_5_1, arg_5_2)
	local var_5_0 = true
	local var_5_1 = self.framePool[arg_5_1]

	if self.framePool[arg_5_1] == nil then
		self.framePool[arg_5_1] = {
			refCounter = 0
		}
		var_5_1 = self.framePool[arg_5_1]
	end

	if isNil(var_5_1.obj) then
		var_5_0 = false
		var_5_1.obj = Asset.Instantiate(var_0_2 .. arg_5_1)

		if isNil(var_5_1.obj) then
			return nil
		else
			var_5_1.obj.transform:SetParent(self.framePoolRoot)

			var_5_1.obj.transform.localScale = Vector3.one
			var_5_1.obj.transform.localPosition = Vector3.zero
		end
	end

	var_5_1.refCounter = var_5_1.refCounter + 1

	if var_5_1.refCounter == 1 and not var_5_0 then
		self.frameCounter = self.frameCounter + 1
	end

	local var_5_2 = GameObject.Instantiate(var_5_1.obj, arg_5_2)

	var_5_2.transform.localScale = Vector3.one
	var_5_2.transform.localPosition = Vector3.zero

	return var_5_2
end

function var_0_0:GetBubble(arg_6_1, arg_6_2)
	local var_6_0 = true
	local var_6_1 = self.bubblePool[arg_6_1]

	if self.bubblePool[arg_6_1] == nil then
		self.bubblePool[arg_6_1] = {
			refCounter = 0
		}
		var_6_1 = self.bubblePool[arg_6_1]
	end

	if isNil(var_6_1.obj) then
		var_6_0 = false
		var_6_1.obj = Asset.Instantiate(var_0_3 .. arg_6_1)

		if isNil(var_6_1.obj) then
			return nil
		else
			var_6_1.obj.transform:SetParent(self.bubblePoolRoot)

			var_6_1.obj.transform.localScale = Vector3.one
			var_6_1.obj.transform.localPosition = Vector3.zero
			var_6_1.obj.transform.offsetMin = Vector2.New(0, 0)
			var_6_1.obj.transform.offsetMax = Vector2.New(0, 0)
		end
	end

	var_6_1.refCounter = var_6_1.refCounter + 1

	if var_6_1.refCounter == 1 and not var_6_0 then
		self.bubbleCounter = self.bubbleCounter + 1
	end

	local var_6_2 = GameObject.Instantiate(var_6_1.obj, arg_6_2)

	var_6_2.transform.localScale = Vector3.one
	var_6_2.transform.localPosition = Vector3.zero
	var_6_1.obj.transform.offsetMin = Vector2.New(0, 0)
	var_6_1.obj.transform.offsetMax = Vector2.New(0, 0)

	return var_6_2
end

function var_0_0:ReturnHead(arg_7_1, arg_7_2)
	if not isNil(arg_7_2) then
		GameObject.Destroy(arg_7_2)
	end

	local var_7_0 = self.headPool[arg_7_1]

	var_7_0.refCounter = self.headPool[arg_7_1].refCounter - 1

	if var_7_0.refCounter <= 0 then
		var_7_0.refCounter = 0

		if self.headCounter + 1 > var_0_5 then
			for iter_7_0, iter_7_1 in pairs(self.headPool) do
				if iter_7_1.refCounter == 0 then
					if not isNil(iter_7_1.obj) then
						GameObject.Destroy(iter_7_1.obj)
					end

					Asset.Unload(var_0_1 .. iter_7_0)

					iter_7_1.obj = nil
					self.headCounter = self.headCounter - 1
				end
			end
		end
	end
end

function var_0_0:ReturnFrame(arg_8_1, arg_8_2)
	if not isNil(arg_8_2) then
		GameObject.Destroy(arg_8_2)
	end

	local var_8_0 = self.framePool[arg_8_1]

	var_8_0.refCounter = self.framePool[arg_8_1].refCounter - 1

	if var_8_0.refCounter <= 0 then
		var_8_0.refCounter = 0

		if self.frameCounter + 1 > var_0_5 then
			for iter_8_0, iter_8_1 in pairs(self.framePool) do
				if iter_8_1.refCounter == 0 then
					if not isNil(iter_8_1.obj) then
						GameObject.Destroy(iter_8_1.obj)
					end

					Asset.Unload(var_0_2 .. iter_8_0)

					iter_8_1.obj = nil
					self.frameCounter = self.frameCounter - 1
				end
			end
		end
	end
end

function var_0_0:ReturnBubble(arg_9_1, arg_9_2)
	if not isNil(arg_9_2) then
		GameObject.Destroy(arg_9_2)
	end

	local var_9_0 = self.bubblePool[arg_9_1]

	var_9_0.refCounter = self.bubblePool[arg_9_1].refCounter - 1

	if var_9_0.refCounter <= 0 then
		var_9_0.refCounter = 0

		if self.bubbleCounter + 1 > var_0_5 then
			for iter_9_0, iter_9_1 in pairs(self.bubblePool) do
				if iter_9_1.refCounter == 0 then
					if not isNil(iter_9_1.obj) then
						GameObject.Destroy(iter_9_1.obj)
					end

					Asset.Unload(var_0_3 .. iter_9_0)

					iter_9_1.obj = nil
					self.bubbleCounter = self.bubbleCounter - 1
				end
			end
		end
	end
end

function var_0_0:GetCardBg(arg_10_1, arg_10_2)
	local var_10_0 = true
	local var_10_1 = self.cardBgPool[arg_10_1]

	if self.cardBgPool[arg_10_1] == nil then
		self.cardBgPool[arg_10_1] = {
			refCounter = 0
		}
		var_10_1 = self.cardBgPool[arg_10_1]
	end

	if isNil(var_10_1.obj) then
		var_10_0 = false
		var_10_1.obj = Asset.Instantiate(var_0_4 .. arg_10_1 .. "b")

		if isNil(var_10_1.obj) then
			return nil
		else
			var_10_1.obj.transform:SetParent(self.cardBgPoolRoot)

			var_10_1.obj.transform.localScale = Vector3.one
			var_10_1.obj.transform.localPosition = Vector3.zero
		end
	end

	var_10_1.refCounter = var_10_1.refCounter + 1

	if var_10_1.refCounter == 1 and not var_10_0 then
		self.cardBgCounter = self.cardBgCounter + 1
	end

	local var_10_2 = GameObject.Instantiate(var_10_1.obj, arg_10_2)

	var_10_2.transform.localScale = Vector3.one
	var_10_2.transform.localPosition = Vector3.zero

	return var_10_2
end

function var_0_0:ReturnCardBg(arg_11_1, arg_11_2)
	if not isNil(arg_11_2) then
		GameObject.Destroy(arg_11_2)
	end

	local var_11_0 = self.cardBgPool[arg_11_1]

	var_11_0.refCounter = self.cardBgPool[arg_11_1].refCounter - 1

	if var_11_0.refCounter <= 0 then
		var_11_0.refCounter = 0

		if self.cardBgCounter + 1 > var_0_5 then
			for iter_11_0, iter_11_1 in pairs(self.cardBgPool) do
				if iter_11_1.refCounter == 0 then
					if not isNil(iter_11_1.obj) then
						GameObject.Destroy(iter_11_1.obj)
					end

					Asset.Unload(var_0_4 .. iter_11_0)

					iter_11_1.obj = nil
					self.cardBgCounter = self.cardBgCounter - 1
				end
			end
		end
	end
end

function var_0_0:ClearAll()
	for iter_12_0, iter_12_1 in pairs(self.headPool) do
		if not isNil(iter_12_1.obj) or iter_12_1.refCounter > 0 then
			Asset.Unload(var_0_1 .. iter_12_0)

			if not isNil(iter_12_1.obj) then
				GameObject.Destroy(iter_12_1.obj)
			end

			iter_12_1.obj = nil
		end
	end

	for iter_12_2, iter_12_3 in pairs(self.framePool) do
		if not isNil(iter_12_3.obj) or iter_12_3.refCounter > 0 then
			Asset.Unload(var_0_2 .. iter_12_2)

			if not isNil(iter_12_3.obj) then
				GameObject.Destroy(iter_12_3.obj)
			end

			iter_12_3.obj = nil
		end
	end

	for iter_12_4, iter_12_5 in pairs(self.bubblePool) do
		if not isNil(iter_12_5.obj) or iter_12_5.refCounter > 0 then
			Asset.Unload(var_0_3 .. iter_12_4)

			if not isNil(iter_12_5.obj) then
				GameObject.Destroy(iter_12_5.obj)
			end

			iter_12_5.obj = nil
		end
	end

	self.headPool = {}
	self.headCounter = 0
	self.framePool = {}
	self.frameCounter = 0
	self.bubblePool = {}
	self.bubbleCounter = 0
	self.cardBgPool = {}
	self.cardBgCounter = 0
end

return var_0_0
