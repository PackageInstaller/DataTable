local OathBubbleContent = class("OathBubbleContent", ReduxView)

function OathBubbleContent:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.bubbleList = {}
	self.bubblePool = {}

	self:AddListeners()
end

function OathBubbleContent:AddListeners()
	return
end

function OathBubbleContent:GetBubbleItem()
	if #self.bubblePool > 0 then
		return table.remove(self.bubblePool)
	else
		return Object.Instantiate(self.bubbleObj_, self.bubbleContent_)
	end
end

function OathBubbleContent:AddOptionsBubble(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	local var_4_0 = self:GetBubbleItem()

	SetActive(var_4_0, true)

	self.bubbleList[arg_4_1] = OathOptionsBubbleItem.New(var_4_0)

	self.bubbleList[arg_4_1]:SetData({
		id = arg_4_1,
		tipsKey = arg_4_2,
		icon = arg_4_3,
		order = arg_4_4,
		clickCallback = arg_4_5,
		isFinish = arg_4_6 or false
	})
end

function OathBubbleContent:RemoveOptionsBubble(arg_5_1)
	if self.bubbleList[arg_5_1] then
		self.bubbleList[arg_5_1]:Remove()
		SetActive(self.bubbleList[arg_5_1].gameObject_, false)
		table.insert(self.bubblePool, self.bubbleList[arg_5_1].gameObject_)

		self.bubbleList[arg_5_1] = nil
	end
end

function OathBubbleContent:OnExit()
	return
end

function OathBubbleContent:Dispose()
	if self.bubbleList then
		for iter_7_0, iter_7_1 in pairs(self.bubbleList) do
			iter_7_1:Dispose()
		end

		self.bubbleList = nil
	end

	OathBubbleContent.super.Dispose(self)
end

return OathBubbleContent
