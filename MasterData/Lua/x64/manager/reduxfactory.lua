local var_0_0 = singletonClass("ReduxFactory")
local var_0_1 = 10
local var_0_2 = 10

function var_0_0.Ctor(arg_1_0)
	if UnityEngine.SystemInfo.systemMemorySize < 4000 then
		var_0_1 = 6
	end

	if UnityEngine.SystemInfo.systemMemorySize < 4000 then
		var_0_2 = 6
	end

	arg_1_0.reduxViewDic_ = {}
	arg_1_0.cachedReduxViewList_ = {}
	arg_1_0.reduxViewList_ = {}
	arg_1_0.isCheckMemoryLeak_ = true
	arg_1_0.currentDisposeCounter_ = 0
end

function var_0_0:CacheReduxView(arg_2_1)
	if true and arg_2_1:Cacheable() and not table.indexof(self.cachedReduxViewList_, arg_2_1) then
		self.reduxViewDic_[arg_2_1.routeName_] = arg_2_1

		table.insert(self.cachedReduxViewList_, arg_2_1)

		if arg_2_1.gameObject_ then
			SetActive(arg_2_1.gameObject_, false)
		end
	else
		self:RemoveView(arg_2_1)
	end

	self:CheckReduxViewQueueFull()
end

function var_0_0:RemoveView(arg_3_1)
	local var_3_0 = table.indexof(self.cachedReduxViewList_, arg_3_1)

	if var_3_0 then
		self:RemoveViewAt(var_3_0)
	else
		local var_3_1 = table.indexof(self.reduxViewList_, arg_3_1)

		if var_3_1 then
			table.remove(self.reduxViewList_, var_3_1)
		end

		arg_3_1:OnUnload()

		self.currentDisposeCounter_ = self.currentDisposeCounter_ + 1
	end
end

function var_0_0:RemoveViewAt(arg_4_1)
	self.cachedReduxViewList_[arg_4_1]:OnUnload()
	table.remove(self.cachedReduxViewList_, arg_4_1)
	self:PrintViewList("RemoveViewAt, ")

	if self.reduxViewDic_[self.cachedReduxViewList_[arg_4_1].routeName_] then
		self.reduxViewDic_[self.cachedReduxViewList_[arg_4_1].routeName_] = nil
	end

	local var_4_0 = table.indexof(self.reduxViewList_, self.cachedReduxViewList_[arg_4_1])

	if var_4_0 then
		table.remove(self.reduxViewList_, var_4_0)

		self.currentDisposeCounter_ = self.currentDisposeCounter_ + 1
	end
end

function var_0_0:GetReduxView(arg_5_1, arg_5_2)
	local var_5_0 = self.reduxViewDic_[arg_5_1]
	local var_5_1 = true

	if self.reduxViewDic_[arg_5_1] ~= nil then
		var_5_1 = false

		local var_5_2 = table.indexof(self.reduxViewList_, var_5_0)

		if var_5_2 then
			table.remove(self.reduxViewList_, var_5_2)
			table.insert(self.reduxViewList_, var_5_0)
		end

		self:PrintViewList()

		if var_5_0.gameObject_ then
			SetActive(var_5_0.gameObject_, true)
			var_5_0.gameObject_.transform:SetAsLastSibling()
		end

		self.reduxViewDic_[arg_5_1] = nil

		local var_5_3 = table.indexof(self.cachedReduxViewList_, var_5_0)

		if var_5_3 then
			table.remove(self.cachedReduxViewList_, var_5_3)
		end
	else
		var_5_0 = arg_5_2.component.New()

		var_5_0:SetRouteName(arg_5_1)
		table.insert(self.reduxViewList_, var_5_0)
		self:PrintViewList()
	end

	return var_5_0, var_5_1
end

function var_0_0:CheckReduxViewQueueFull()
	while #self.cachedReduxViewList_ > var_0_1 do
		self:RemoveViewAt(1)
	end
end

function var_0_0:TryClearUnusedResource()
	if self.currentDisposeCounter_ > var_0_2 then
		Resources.UnloadUnusedAssets()

		self.currentDisposeCounter_ = 0
	end
end

function var_0_0:ClearCacheViews()
	for iter_8_0, iter_8_1 in pairs(self.reduxViewDic_) do
		iter_8_1:OnUnload()
	end

	self:TryClearUnusedResource()

	self.reduxViewDic_ = {}
	self.reduxViewList_ = {}
	self.cachedReduxViewList_ = {}
	self.currentDisposeCounter_ = 0
end

function var_0_0:OnMainHomeViewTop()
	for iter_9_0, iter_9_1 in pairs(self.reduxViewDic_) do
		iter_9_1:OnMainHomeViewTop()
	end

	self:TryClearUnusedResource()
end

function var_0_0:OnManagedObjCtor(arg_10_1)
	if not self.isCheckMemoryLeak_ then
		return
	end

	if not self.existReduxViewDic_ then
		self.existReduxViewDic_ = {}
		self.existReduxViewList_ = {}
	end

	table.insert(self.existReduxViewList_, arg_10_1)

	self.existReduxViewDic_[tostring(arg_10_1)] = arg_10_1
end

function var_0_0:OnManagedObjDisposed(arg_11_1)
	if not self.isCheckMemoryLeak_ then
		return
	end

	if not self.existReduxViewDic_ then
		self.existReduxViewDic_ = {}
		self.existReduxViewList_ = {}
	end

	local var_11_0 = tostring(arg_11_1)

	if self.existReduxViewDic_[var_11_0] then
		self.existReduxViewDic_[var_11_0] = nil
	end

	local var_11_1 = table.indexof(self.existReduxViewList_, arg_11_1)

	if var_11_1 then
		table.remove(self.existReduxViewList_, var_11_1)
	end
end

function var_0_0:PrintExistingObjectInfo()
	if not self.isCheckMemoryLeak_ then
		return
	end

	if self.existReduxViewList_ ~= nil and #self.existReduxViewList_ > 0 then
		local var_12_0 = "<color=" .. "#ff0000" .. ">UI系统结束时，未被Dispose的ReduxView数量：" .. #self.existReduxViewList_ .. " : "

		for iter_12_0 = 1, #self.existReduxViewList_ do
			var_12_0 = var_12_0 .. self.existReduxViewList_[iter_12_0].class.__cname .. (iter_12_0 == #self.existReduxViewList_ and "" or ",")
		end

		CustomLog.LogError(var_12_0 .. "请优先按规范销毁对象</color>")
	else
		print("<color=#00ff00>对象已清理完全</color>")
	end
end

function var_0_0.PrintViewList(arg_13_0, arg_13_1)
	return
end

return var_0_0
