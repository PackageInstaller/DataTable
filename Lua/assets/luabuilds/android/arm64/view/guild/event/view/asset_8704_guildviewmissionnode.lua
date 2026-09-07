local GuildViewMissionNode = class("GuildViewMissionNode")
local var_0_1 = 200
local var_0_2 = 150
local var_0_3 = 100

GuildViewMissionNode.LINE_LEFT = 1
GuildViewMissionNode.LINE_RIGHT = 2
GuildViewMissionNode.TOP_LINK = 3
GuildViewMissionNode.BOTTOM_LINK = 4
GuildViewMissionNode.CENTER_LINK = 5
GuildViewMissionNode.TOP_HRZ_LINK = 6
GuildViewMissionNode.BOTTOM_HRZ_LINK = 7

function GuildViewMissionNode:Ctor(arg_1_1)
	self._go = arg_1_1.go
	self._tf = tf(self._go)
	self.slot = arg_1_1.slot
	self.data = arg_1_1.data
	self.parent = arg_1_1.parent
	self.childs = {}
	self.offset = 0
	self.lineContainer = self._tf:Find("lines")
	self.lines = {}
	self.subLockBg = self._tf:Find("sub_lock")
	self.subUnlockBg = self._tf:Find("sub_unlock")
	self.unlockBg = self._tf:Find("unlock")
	self.lockBg = self._tf:Find("lock")
	self.nameTxt = self._tf:Find("Text"):GetComponent(typeof(Text))
	self.selected = self._tf:Find("selected")
	self.tip = self._tf:Find("tip")

	return
end

function GuildViewMissionNode:Init()
	self:UpdateStyle()
	self:CalcOffset()
	self:SetPosition()

	return
end

function GuildViewMissionNode:IsFinish()
	return self.data:IsFinish()
end

function GuildViewMissionNode:IsUnLock()
	if not self.parent then
		return true
	else
		return self:ParentIFinish() and self:IsActive()
	end

	return
end

function GuildViewMissionNode:ParentIFinish()
	if not self.parent then
		return false
	end

	return self.parent:IsFinish()
end

function GuildViewMissionNode:ParentIsFinishByServer()
	if not self.parent then
		return false
	end

	return self.parent.data:IsFinishedByServer()
end

function GuildViewMissionNode:IsActive()
	return self.data:IsActive()
end

function GuildViewMissionNode:GetParentId()
	if not self.parent then
		return 0
	end

	return self.parent.data.id
end

function GuildViewMissionNode:UpdateData(arg_9_1)
	self.data = arg_9_1

	self:UpdateStyle()
	self:UpdateLineStyle()

	for iter_9_0, iter_9_1 in ipairs(self.childs) do
		iter_9_1:UpdateStyle()
		iter_9_1:UpdateLineStyle()
	end

	return
end

function GuildViewMissionNode:UpdateStyle()
	local var_10_0 = self:IsFinish()
	local var_10_1 = not self:IsUnLock()
	local var_10_2 = self:IsMain()

	setActive(self.subLockBg, not var_10_0 and not var_10_2 and var_10_1)
	setActive(self.subUnlockBg, not var_10_0 and not var_10_2 and not var_10_1)
	setActive(self.unlockBg, not var_10_0 and var_10_2 and not var_10_1)
	setActive(self.lockBg, not var_10_0 and var_10_2 and var_10_1)

	self.nameTxt.text = var_10_1 and "" or self.data:GetName()

	self:UpdateTip()

	return
end

function GuildViewMissionNode:UpdateTip()
	setActive(self.tip, self:IsUnLock() and self.data:CanFormation() and not self:IsFinish())

	return
end

local var_0_4 = {
	"blue",
	"gray",
	"yellow"
}

function GuildViewMissionNode:UpdateLineStyle()
	local function var_12_1(arg_13_0, arg_13_1)
		if arg_13_0.gameObject.name == "line" then
			arg_13_0:GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/guildmissionui_atlas", arg_13_1 .. "_line")
		elseif arg_13_0.gameObject.name == "head" then
			arg_13_0:GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/guildmissionui_atlas", arg_13_1)
		elseif arg_13_0.gameObject.name == "adapter" then
			eachChild(arg_13_0, function(arg_14_0)
				var_12_1(arg_14_0, arg_13_1)

				return
			end)
		end

		return
	end

	local var_12_2 = self:IsFinish()

	for iter_12_0, iter_12_1 in ipairs(self.childs) do
		local var_12_3 = iter_12_1:IsMain()

		for iter_12_2, iter_12_3 in ipairs(self.lines[iter_12_1]) do
			local var_12_4

			if var_12_2 then
				var_12_4 = var_0_4[2]

				if not var_0_4[2] then
					if var_12_3 then
						var_12_4 = var_0_4[3] or var_0_4[1]
					end
				end
			end

			var_12_1(iter_12_3.tf, var_12_4)
		end
	end

	local var_12_5 = self.lines[self] or {}
	local var_12_6 = self:IsMain()

	for iter_12_4, iter_12_5 in ipairs(var_12_5) do
		var_12_1(iter_12_5.tf, iter_12_5.type == GuildViewMissionNode.LINE_LEFT and ((var_12_2 or (self.parent or nil) and self.parent:IsFinish()) and var_0_4[2] or var_12_6 and var_0_4[3] or var_0_4[1]) or var_12_2 and var_0_4[2] or var_12_6 and var_0_4[3] or var_0_4[1])
	end

	return
end

function GuildViewMissionNode:Selected(arg_15_1)
	setActive(self.selected, arg_15_1)

	return
end

function GuildViewMissionNode:CalcOffset()
	if not self.parent then
		self.offset = 0

		return
	end

	if #self.parent.childs == 2 then
		local var_16_0 = self:IsMain()
		local var_16_1 = self:GetParentOffset()
		local var_16_2 = 1
		local var_16_3 = -1
		local var_16_4 = math.abs(var_16_1 + 1)
		local var_16_5 = math.abs(var_16_1 + -1)

		if var_16_5 <= var_16_4 then
			self.offset = var_16_0 and var_16_3 or var_16_2
		elseif var_16_4 < var_16_5 then
			self.offset = var_16_0 and var_16_2 or var_16_3
		end
	elseif #self.parent.childs == 1 then
		self.offset = 0 - self.parent:GetFirstNodeOffset()
	end

	return
end

function GuildViewMissionNode:GetLocalPosition()
	if self.parent then
		local var_17_0 = self:GetOffset()
		local var_17_1 = self:IsMain() and 0 or var_0_3

		return Vector3((self.slot - 1) * (var_0_1 + self._tf.sizeDelta.x), self.parent:GetLocalPosition().y + var_17_0 * var_0_2 + (var_17_0 > 0 and var_17_1 or -var_17_1), 0)
	else
		return Vector3(0, 0, 0)
	end

	return
end

function GuildViewMissionNode:SetPosition()
	self._tf.anchoredPosition = self:GetLocalPosition()

	return
end

function GuildViewMissionNode:AddChild(arg_19_1)
	table.insert(self.childs, arg_19_1)

	return
end

function GuildViewMissionNode:GetChilds()
	return self.childs
end

function GuildViewMissionNode:HasParent()
	return self.parent ~= nil
end

function GuildViewMissionNode:HasChild()
	return #self.childs > 0
end

function GuildViewMissionNode:IsMain()
	return self.data:IsMain()
end

function GuildViewMissionNode:GetOffset()
	return self.offset
end

function GuildViewMissionNode:GetParentOffset()
	assert(self.parent)

	return self.parent:GetOffset()
end

function GuildViewMissionNode:GetFirstNodeOffset()
	local var_26_0 = 0
	local var_26_1 = self

	while self.parent ~= nil do
		var_26_0 = var_26_0 + self:GetOffset()
		var_26_1 = self.parent
	end

	return var_26_0
end

function GuildViewMissionNode:AddLine(arg_27_1, arg_27_2, arg_27_3)
	arg_27_1 = tf(arg_27_1)

	SetParent(arg_27_1, self.lineContainer)

	if arg_27_2 == GuildViewMissionNode.LINE_LEFT then
		if self:IsMain() then
			arg_27_1.anchorMax = Vector2(0, 0.5)
			arg_27_1.anchorMin = Vector2(0, 0.5)
			arg_27_1.pivot = Vector2(1, 0.5)
			arg_27_1.anchoredPosition = Vector2(0, 0)
		else
			arg_27_1.pivot = Vector2(1, 0.5)

			if self:GetOffset() > 0 then
				arg_27_1.anchorMax = Vector2(0.5, 0)
				arg_27_1.anchorMin = Vector2(0.5, 0)
				arg_27_1.eulerAngles = Vector3(0, 0, 90)
				arg_27_1.anchoredPosition = Vector2(0, 0)
			else
				arg_27_1.anchorMax = Vector2(0.5, 1)
				arg_27_1.anchorMin = Vector2(0.5, 1)
				arg_27_1.eulerAngles = Vector3(0, 0, -90)
				arg_27_1.anchoredPosition = Vector2(0, 0)
			end
		end
	elseif arg_27_2 == GuildViewMissionNode.LINE_RIGHT then
		arg_27_1.anchorMax = Vector2(1, 0.5)
		arg_27_1.anchorMin = Vector2(1, 0.5)
		arg_27_1.pivot = Vector2(0, 0.5)
		arg_27_1.anchoredPosition = Vector2(0, 0)
	elseif arg_27_2 == GuildViewMissionNode.TOP_LINK then
		arg_27_1.anchorMax = Vector2(1, 0.5)
		arg_27_1.anchorMin = Vector2(1, 0.5)
		arg_27_1.pivot = Vector2(1, 0.5)
		arg_27_1.anchoredPosition = Vector2(self.lines[self][1].tf.sizeDelta.x, 0)
		arg_27_1.eulerAngles = Vector3(0, 0, -90)

		local var_27_0 = arg_27_3:GetLocalPosition().y - self:GetLocalPosition().y

		arg_27_1.sizeDelta = arg_27_3:IsMain() and Vector2(var_27_0, arg_27_1.sizeDelta.y) or Vector2(var_27_0 - self.lines[self][1].tf.sizeDelta.x - self._tf.sizeDelta.y / 2, arg_27_1.sizeDelta.y)
	elseif arg_27_2 == GuildViewMissionNode.BOTTOM_LINK then
		arg_27_1.anchorMax = Vector2(1, 0.5)
		arg_27_1.anchorMin = Vector2(1, 0.5)
		arg_27_1.pivot = Vector2(1, 0.5)
		arg_27_1.anchoredPosition = Vector2(self.lines[self][1].tf.sizeDelta.x, 0)
		arg_27_1.eulerAngles = Vector3(0, 0, 90)

		local var_27_1 = arg_27_3:GetLocalPosition().y - self:GetLocalPosition().y

		arg_27_1.sizeDelta = arg_27_3:IsMain() and Vector2(-var_27_1, arg_27_1.sizeDelta.y) or Vector2(-var_27_1 - self.lines[self][1].tf.sizeDelta.x - self._tf.sizeDelta.y / 2, arg_27_1.sizeDelta.y)
	elseif arg_27_2 == GuildViewMissionNode.TOP_HRZ_LINK then
		arg_27_1.anchoredPosition = Vector2(self.lines[arg_27_3][1].tf.anchoredPosition.x, self.lines[arg_27_3][1].tf.sizeDelta.x + self.lines[arg_27_3][1].tf.anchoredPosition.y)

		local var_27_2 = arg_27_3:GetLocalPosition()
		local var_27_3 = self:GetLocalPosition()
		local var_27_4

		if arg_27_3:IsMain() then
			var_27_4 = var_27_2.x - var_27_3.x - 2 * self.lines[self][1].tf.sizeDelta.x - self._tf.sizeDelta.x
		else
			nextNodeLposX = var_27_2.x + self._tf.sizeDelta.x / 2
			var_27_4 = nextNodeLposX - var_27_3.x - self._tf.sizeDelta.x - self.lines[self][1].tf.sizeDelta.x
		end

		arg_27_1.sizeDelta = Vector2(var_27_4, arg_27_1.sizeDelta.y)
	elseif arg_27_2 == GuildViewMissionNode.BOTTOM_HRZ_LINK then
		arg_27_1.anchoredPosition = Vector2(self.lines[arg_27_3][1].tf.anchoredPosition.x, self.lines[arg_27_3][1].tf.anchoredPosition.y - self.lines[arg_27_3][1].tf.sizeDelta.x)

		local var_27_5 = arg_27_3:GetLocalPosition()
		local var_27_6 = self:GetLocalPosition()
		local var_27_7

		if arg_27_3:IsMain() then
			var_27_7 = var_27_5.x - var_27_6.x - 2 * self.lines[self][1].tf.sizeDelta.x - self._tf.sizeDelta.x
		else
			nextNodeLposX = var_27_5.x + self._tf.sizeDelta.x / 2
			var_27_7 = nextNodeLposX - var_27_6.x - self._tf.sizeDelta.x - self.lines[self][1].tf.sizeDelta.x
		end

		arg_27_1.sizeDelta = Vector2(var_27_7, arg_27_1.sizeDelta.y)
	elseif arg_27_2 == GuildViewMissionNode.CENTER_LINK then
		arg_27_1.anchorMax = Vector2(1, 0.5)
		arg_27_1.anchorMin = Vector2(1, 0.5)
		arg_27_1.anchoredPosition = Vector2(self.lines[self][1].tf.sizeDelta.x, 0)
		arg_27_1.sizeDelta = Vector2(arg_27_3:GetLocalPosition().x - self:GetLocalPosition().x - self._tf.sizeDelta.x - 2 * self.lines[self][1].tf.sizeDelta.x, arg_27_1.sizeDelta.y)
	end

	self.lines[arg_27_3] = self.lines[arg_27_3] or {}

	table.insert(self.lines[arg_27_3], {
		tf = arg_27_1,
		type = arg_27_2
	})

	return
end

return GuildViewMissionNode
