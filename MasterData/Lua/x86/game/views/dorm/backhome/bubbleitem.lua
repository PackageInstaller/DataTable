local BubbleItem = class("BubbleItem", BaseView)

function BubbleItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.duration = 4
end

local function var_0_1(arg_2_0)
	return Time.time - arg_2_0.taskDataCtx.bubbleObj.startTime >= arg_2_0.taskDataCtx.bubbleObj.duration
end

local function var_0_2(arg_3_0, arg_3_1)
	arg_3_0.task = nil
	arg_3_0.text.text = ""

	arg_3_0.content:SetActive(false)

	if arg_3_1 then
		DormUtils.ShowCharaSpecialVfx(arg_3_1, Dorm.charaVfxActiveType)
	end
end

function BubbleItem:ShowSubtitle(arg_4_1, arg_4_2)
	self.startTime = Time.time

	if arg_4_2 then
		self.duration = arg_4_2
	end

	if self.task == nil then
		local var_4_0 = DormCharacterActionManager.frameTaskRunner:NewTask({
			bubbleObj = self
		})

		var_4_0:WaitUntil(var_0_1)
		var_4_0:SetOnComplete(function()
			var_0_2(self, arg_4_1)
		end)
		var_4_0:SetOnAbort(function()
			var_0_2(self, arg_4_1)
		end)

		self.task = var_4_0

		self.task:Start()
		DormUtils.HideCharaSpecialVfx(arg_4_1)
	end
end

local function var_0_3(arg_7_0)
	return arg_7_0 == nil or arg_7_0 == "" or IsAllSpace(arg_7_0)
end

function BubbleItem:SetData(arg_8_1)
	if isNil(self.content) then
		return
	end

	self.text.text = arg_8_1

	if not var_0_3(arg_8_1) then
		self.content:SetActive(true)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.content.transform)
	end
end

function BubbleItem:Hide()
	if self.task then
		self.task:Abort()

		self.task = nil
	end
end

function BubbleItem:IsPlaying()
	return self.task ~= nil
end

function BubbleItem:Dispose()
	BubbleItem.super.Dispose(self)

	if self.task then
		self.task:Abort()

		self.task = nil
	end

	if not isNil(self.gameObject_) then
		self.gameObject_:Destroy()
	end
end

return BubbleItem
