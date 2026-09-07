local AttachmentSpineAnimationCell = class("AttachmentSpineAnimationCell", import(".StaticCellView"))

AttachmentSpineAnimationCell.SDPosition = Vector2(0, -15)
AttachmentSpineAnimationCell.SDScale = Vector3(0.4, 0.4, 0.4)

function AttachmentSpineAnimationCell:Ctor(arg_1_1)
	AttachmentSpineAnimationCell.super.Ctor(self, arg_1_1)

	self.name = nil
	self.model = nil
	self.AnimIndex = nil
	self.group = {}
	self.timer = nil

	return
end

function AttachmentSpineAnimationCell:GetOrder()
	return ChapterConst.CellPriorityAttachment
end

function AttachmentSpineAnimationCell:Set(arg_3_1)
	if self.name == arg_3_1 then
		return
	end

	self:ClearLoader()
	table.clear(self.group)

	self.name = arg_3_1

	if IsNil(self.go) then
		self:PrepareBase("SD")
		self:OverrideCanvas()
		self:ResetCanvasOrder()
	end

	self:GetLoader():GetSpine(arg_3_1, function(arg_4_0)
		self.spineChar = arg_4_0
		self.model = arg_4_0:GetModel()

		arg_4_0:SetParent(self.go)
		arg_4_0:SetAnchoredPosition(self.SDPosition)
		arg_4_0:SetLocalScale(self.SDScale)
		self:PlayAction(self.AnimIndex)

		return
	end, "SD")

	return
end

function AttachmentSpineAnimationCell:SetRoutine(arg_5_1)
	table.clear(self.group)

	self.AnimIndex = nil

	for iter_5_0, iter_5_1 in ipairs(arg_5_1 or {}) do
		self.group[iter_5_0] = iter_5_1
	end

	if #self.group < 1 then
		table.insert(self.group, {
			action = "default",
			duration = 9999
		})
	end

	self:PlayAction(math.min(#self.group, 1))

	return
end

function AttachmentSpineAnimationCell:PlayAction(arg_6_1)
	if not arg_6_1 or arg_6_1 <= 0 or arg_6_1 > #self.group or self.AnimIndexPlaying == arg_6_1 then
		return
	end

	self.AnimIndex = arg_6_1

	if not self.loader or self.loader:GetLoadingRP("SD") or not self.spineChar then
		return
	end

	local var_6_0 = self.group[arg_6_1]

	self:ClearTimer()

	self.timer = Timer.New(function()
		arg_6_1 = arg_6_1 + 1

		if arg_6_1 > #self.group then
			arg_6_1 = math.min(#self.group, 1)
		end

		self:PlayAction(arg_6_1)

		return
	end, var_6_0.duration)

	self.spineChar:SetAction(var_6_0.action, 0)
	self.timer:Start()

	self.AnimIndexPlaying = arg_6_1

	return
end

function AttachmentSpineAnimationCell:ClearTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function AttachmentSpineAnimationCell:Clear()
	self:ClearTimer()

	self.name = nil

	AttachmentSpineAnimationCell.super.Clear(self)

	return
end

return AttachmentSpineAnimationCell
