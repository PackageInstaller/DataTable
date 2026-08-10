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

function var_0_0.CacheReduxView(arg_2_0, arg_2_1)
	local var_2_0 = true
	local var_2_1 = table.indexof(arg_2_0.cachedReduxViewList_, arg_2_1)

	if var_2_0 and arg_2_1:Cacheable() and not var_2_1 then
		arg_2_0.reduxViewDic_[arg_2_1.routeName_] = arg_2_1

		table.insert(arg_2_0.cachedReduxViewList_, arg_2_1)

		if arg_2_1.gameObject_ then
			SetActive(arg_2_1.gameObject_, false)
		end
	else
		arg_2_0:RemoveView(arg_2_1)
	end

	arg_2_0:CheckReduxViewQueueFull()
end

function var_0_0.RemoveView(arg_3_0, arg_3_1)
	local var_3_0 = table.indexof(arg_3_0.cachedReduxViewList_, arg_3_1)

	if var_3_0 then
		arg_3_0:RemoveViewAt(var_3_0)
	else
		local var_3_1 = table.indexof(arg_3_0.reduxViewList_, arg_3_1)

		if var_3_1 then
			table.remove(arg_3_0.reduxViewList_, var_3_1)
		end

		arg_3_1:OnUnload()

		arg_3_0.currentDisposeCounter_ = arg_3_0.currentDisposeCounter_ + 1
	end
end

function var_0_0.RemoveViewAt(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.cachedReduxViewList_[arg_4_1]
	local var_4_1 = var_4_0.routeName_

	var_4_0:OnUnload()
	table.remove(arg_4_0.cachedReduxViewList_, arg_4_1)
	arg_4_0:PrintViewList("RemoveViewAt, ")

	if arg_4_0.reduxViewDic_[var_4_1] then
		arg_4_0.reduxViewDic_[var_4_1] = nil
	end

	local var_4_2 = table.indexof(arg_4_0.reduxViewList_, var_4_0)

	if var_4_2 then
		table.remove(arg_4_0.reduxViewList_, var_4_2)

		arg_4_0.currentDisposeCounter_ = arg_4_0.currentDisposeCounter_ + 1
	end
end

function var_0_0.GetReduxView(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.reduxViewDic_[arg_5_1]
	local var_5_1 = true

	if var_5_0 ~= nil then
		var_5_1 = false

		local var_5_2 = table.indexof(arg_5_0.reduxViewList_, var_5_0)

		if var_5_2 then
			table.remove(arg_5_0.reduxViewList_, var_5_2)
			table.insert(arg_5_0.reduxViewList_, var_5_0)
		end

		arg_5_0:PrintViewList()

		if var_5_0.gameObject_ then
			SetActive(var_5_0.gameObject_, true)
			var_5_0.gameObject_.transform:SetAsLastSibling()
		end

		arg_5_0.reduxViewDic_[arg_5_1] = nil

		local var_5_3 = table.indexof(arg_5_0.cachedReduxViewList_, var_5_0)

		if var_5_3 then
			table.remove(arg_5_0.cachedReduxViewList_, var_5_3)
		end
	else
		var_5_0 = arg_5_2.component.New()

		var_5_0:SetRouteName(arg_5_1)
		table.insert(arg_5_0.reduxViewList_, var_5_0)
		arg_5_0:PrintViewList()
	end

	return var_5_0, var_5_1
end

function var_0_0.CheckReduxViewQueueFull(arg_6_0)
	while #arg_6_0.cachedReduxViewList_ > var_0_1 do
		arg_6_0:RemoveViewAt(1)
	end
end

function var_0_0.TryClearUnusedResource(arg_7_0)
	if arg_7_0.currentDisposeCounter_ > var_0_2 then
		Resources.UnloadUnusedAssets()

		arg_7_0.currentDisposeCounter_ = 0
	end
end

function var_0_0.ClearCacheViews(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.reduxViewDic_) do
		iter_8_1:OnUnload()
	end

	arg_8_0:TryClearUnusedResource()

	arg_8_0.reduxViewDic_ = {}
	arg_8_0.reduxViewList_ = {}
	arg_8_0.cachedReduxViewList_ = {}
	arg_8_0.currentDisposeCounter_ = 0
end

function var_0_0.OnMainHomeViewTop(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.reduxViewDic_) do
		iter_9_1:OnMainHomeViewTop()
	end

	arg_9_0:TryClearUnusedResource()
end

function var_0_0.OnManagedObjCtor(arg_10_0, arg_10_1)
	if not arg_10_0.isCheckMemoryLeak_ then
		return
	end

	if not arg_10_0.existReduxViewDic_ then
		arg_10_0.existReduxViewDic_ = {}
		arg_10_0.existReduxViewList_ = {}
	end

	table.insert(arg_10_0.existReduxViewList_, arg_10_1)

	arg_10_0.existReduxViewDic_[tostring(arg_10_1)] = arg_10_1
end

function var_0_0.OnManagedObjDisposed(arg_11_0, arg_11_1)
	if not arg_11_0.isCheckMemoryLeak_ then
		return
	end

	if not arg_11_0.existReduxViewDic_ then
		arg_11_0.existReduxViewDic_ = {}
		arg_11_0.existReduxViewList_ = {}
	end

	local var_11_0 = tostring(arg_11_1)

	if arg_11_0.existReduxViewDic_[var_11_0] then
		arg_11_0.existReduxViewDic_[var_11_0] = nil
	end

	local var_11_1 = table.indexof(arg_11_0.existReduxViewList_, arg_11_1)

	if var_11_1 then
		table.remove(arg_11_0.existReduxViewList_, var_11_1)
	end
end

function var_0_0.PrintExistingObjectInfo(arg_12_0)
	if not arg_12_0.isCheckMemoryLeak_ then
		return
	end

	local var_12_0 = "#ff0000"

	if arg_12_0.existReduxViewList_ ~= nil and #arg_12_0.existReduxViewList_ > 0 then
		local var_12_1 = "<color=" .. var_12_0 .. ">UI系统结束时，未被Dispose的ReduxView数量：" .. #arg_12_0.existReduxViewList_ .. " : "

		for iter_12_0 = 1, #arg_12_0.existReduxViewList_ do
			var_12_1 = var_12_1 .. arg_12_0.existReduxViewList_[iter_12_0].class.__cname .. (iter_12_0 == #arg_12_0.existReduxViewList_ and "" or ",")
		end

		local var_12_2 = var_12_1 .. "请优先按规范销毁对象</color>"

		CustomLog.LogError(var_12_2)
	else
		print("<color=#00ff00>对象已清理完全</color>")
	end
end

function var_0_0.PrintViewList(arg_13_0, arg_13_1)
	return
end

return var_0_0
