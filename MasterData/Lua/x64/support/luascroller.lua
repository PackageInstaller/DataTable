local LuaScroller = class("LuaScroller")

function LuaScroller:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.uiScrollerGo_ = arg_1_2
	self.itemClass_ = arg_1_3
	self.itemRenderer_ = arg_1_1
	self.itemOfInstanceID_ = {}
	self.itemOfIndex_ = {}

	self:InitUI()
	self:AddListeners()

	if not self.ctored_ then
		ReduxFactory.GetInstance():OnManagedObjCtor(self)
	end

	self.ctored_ = true
end

function LuaScroller:InitUI()
	self.uiScroller_ = self.uiScrollerGo_:GetComponent("UIScroller")
	self.emptyController_ = ControllerUtil.GetController(self.uiScrollerGo_.transform, "empty")
end

function LuaScroller:AddListeners()
	if self.uiScroller_ ~= nil then
		self.uiScroller_:SetItemRenderer(handler(self, self.ItemRenderer))
	end
end

function LuaScroller:RemoveListeners()
	if self.uiScroller_ ~= nil then
		self.uiScroller_:SetItemRenderer(nil)
	end
end

function LuaScroller:ItemRenderer(arg_5_1, arg_5_2)
	local var_5_0 = arg_5_2:GetInstanceID()
	local var_5_1

	if self.itemOfInstanceID_[var_5_0] then
		var_5_1 = self.itemOfInstanceID_[var_5_0]
	else
		var_5_1 = self.itemClass_.New(arg_5_2)
		self.itemOfInstanceID_[var_5_0] = var_5_1
	end

	self.itemOfIndex_[arg_5_1 + 1] = var_5_1

	if self.itemRenderer_ then
		self.itemRenderer_(arg_5_1 + 1, var_5_1)
	end
end

function LuaScroller:GetItemByIndex(arg_6_1)
	local var_6_0, var_6_1 = self:GetHeadAndTail()

	if var_6_0 == 0 then
		return
	end

	if arg_6_1 < var_6_0 or var_6_1 < arg_6_1 then
		return nil
	end

	return self.itemOfIndex_[arg_6_1]
end

function LuaScroller:RemoveTween()
	self.uiScroller_:RemoveTween()
end

function LuaScroller:GetItemList()
	local var_8_0 = {}
	local var_8_1, var_8_2 = self:GetHeadAndTail()

	if var_8_1 == 0 then
		return {}
	end

	for iter_8_0 = var_8_1, var_8_2 do
		var_8_0[iter_8_0] = self.itemOfIndex_[iter_8_0]
	end

	return var_8_0
end

function LuaScroller:GetHeadAndTail()
	local var_9_0 = self.uiScroller_:GetHeadAndTail()

	return var_9_0.x + 1, var_9_0.y + 1
end

function LuaScroller:StartScroll(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self:UpdateUIList(arg_10_1)

	arg_10_2 = arg_10_2 or 0

	local var_10_0 = arg_10_2 - 1

	self.num_ = arg_10_1

	if var_10_0 >= 0 then
		self.uiScroller_:ScrollToIndex(var_10_0, arg_10_3, arg_10_4)
	end
end

function LuaScroller:ScrollToIndex(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	arg_11_2 = arg_11_2 or false
	arg_11_3 = arg_11_3 or false
	arg_11_4 = arg_11_4 or 0.2

	self.uiScroller_:ScrollToIndex(arg_11_1 - 1, arg_11_2, arg_11_3, arg_11_4)
end

function LuaScroller:StartScrollWithoutAnimator(arg_12_1, arg_12_2)
	self.num_ = arg_12_1

	self.uiScroller_:SetNumItems(arg_12_1, true)

	if arg_12_2 then
		self.uiScroller_:SetScrolledPosition(arg_12_2)
	end
end

function LuaScroller:Refresh()
	local var_13_0, var_13_1 = self:GetHeadAndTail()

	if var_13_0 == 0 then
		return
	end

	for iter_13_0 = var_13_0, var_13_1 do
		if self.itemRenderer_ then
			if self.itemOfIndex_[iter_13_0] then
				self.itemRenderer_(iter_13_0, self.itemOfIndex_[iter_13_0])
			end
		end
	end
end

function LuaScroller:SetScrolledPosition(arg_14_1)
	self.uiScroller_:SetScrolledPosition(arg_14_1)
end

function LuaScroller:GetScrolledPosition()
	return self.uiScroller_:GetScrolledPosition()
end

function LuaScroller:StartScrollByPosition(arg_16_1, arg_16_2)
	self.num_ = arg_16_1

	self:UpdateUIList(arg_16_1)
	self:SetScrolledPosition(arg_16_2)
end

function LuaScroller:UpdateUIList(arg_17_1)
	self.uiScroller_:SetNumItems(arg_17_1)

	if self.emptyController_ ~= nil then
		self.emptyController_:SetSelectedState(arg_17_1 == 0 and "true" or "false")
	end
end

function LuaScroller:StopRender()
	if self.uiScroller_ then
		self.uiScroller_:StopRender()
	end
end

function LuaScroller:Dispose()
	self:RemoveListeners()

	if self.uiScroller_ ~= nil then
		self.uiScroller_:StopRender()

		self.uiScroller_ = nil
	end

	if self.itemOfInstanceID_ then
		for iter_19_0, iter_19_1 in pairs(self.itemOfInstanceID_) do
			iter_19_1:Dispose()
		end

		self.itemOfInstanceID_ = nil
	end

	self.pageChangeHandler_ = nil

	ReduxFactory.GetInstance():OnManagedObjDisposed(self)
end

function LuaScroller:GetNum()
	return self.num_
end

return LuaScroller
