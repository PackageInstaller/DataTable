pg = pg or {}

local AssetBundle = class("AssetBundle")

pg.AssetBundle = AssetBundle

function AssetBundle:Ctor(arg_1_1)
	self.path = arg_1_1

	return
end

function AssetBundle:Load(arg_2_1, arg_2_2, arg_2_3)
	assert(not self.ab)

	self.abs = {}

	if arg_2_1 then
		seriesAsync({
			function(arg_3_0)
				if not arg_2_2 then
					return arg_3_0()
				end

				parallelAsync(underscore.map(table.CArrayToArray(ResourceMgr.Inst:GetAllDependencies(self.path)), function(arg_4_0)
					return function(arg_5_0)
						AssetBundleHelper.LoadAssetBundle(arg_4_0, arg_2_1, false, function(arg_6_0)
							table.insert(self.abs, arg_6_0)
							arg_5_0()

							return
						end)

						return
					end
				end), arg_3_0)

				return
			end
		}, function()
			ResourceMgr.Inst:loadAssetBundleAsync(self.path, function(arg_8_0)
				self.ab = arg_8_0

				existCall(arg_2_3, self)

				return
			end)

			return
		end)
	else
		if arg_2_2 then
			for iter_2_0, iter_2_1 in ipairs((table.CArrayToArray(ResourceMgr.Inst:GetAllDependencies(self.path)))) do
				table.insert(self.abs, AssetBundleHelper.LoadAssetBundle(iter_2_1, arg_2_1, false, nil))
			end
		end

		self.ab = ResourceMgr.Inst:loadAssetBundleSync(self.path)

		existCall(arg_2_3, self)

		return self
	end

	return
end

function AssetBundle:LoadAssetSync(arg_9_1, ...)
	arg_9_1 = self:ChangeAssetName(arg_9_1)

	if not self.ab then
		warning(string.format("without assetbundle:%s", self.path))

		return nil
	end

	return ResourceMgr.Inst:LoadAssetSync(self.ab, arg_9_1, ...)
end

function AssetBundle:LoadAssetAsync(arg_10_1, arg_10_2, arg_10_3, ...)
	arg_10_1 = self:ChangeAssetName(arg_10_1)

	if not self.ab then
		warning(string.format("without assetbundle:%s", self.path))

		return nil
	end

	return ResourceMgr.Inst:LoadAssetAsync(self.ab, arg_10_1, arg_10_2, UnityEngine.Events.UnityAction_UnityEngine_Object(arg_10_3), ...)
end

function AssetBundle:GetAllAssetNames()
	return table.CArrayToArray(self.ab:GetAllAssetNames())
end

function AssetBundle:ChangeAssetName(arg_12_1)
	if arg_12_1 == nil or arg_12_1 == "" or string.find(arg_12_1, "/") then
		return arg_12_1 or ""
	elseif not AssetBundleHelper.bundleDic[self.path] then
		self:BuildAssetNameDic()
	end

	return AssetBundleHelper.bundleDic[self.path][string.lower(arg_12_1)] or arg_12_1
end

function AssetBundle:BuildAssetNameDic()
	if AssetBundleHelper.bundleDic[self.path] then
		return
	end

	AssetBundleHelper.BuildAssetNameDic(self.path, self:GetAllAssetNames())

	return
end

function AssetBundle:ClearDependenciesBundle()
	for iter_14_0, iter_14_1 in ipairs(self.abs) do
		iter_14_1:Dispose()
	end

	self.abs = {}

	return
end

function AssetBundle:ForceClearRef(arg_15_1)
	self:ClearDependenciesBundle()
	AssetBundleHelper.UnloadAssetBundle(self.path, arg_15_1)

	self.ab = nil

	return
end

function AssetBundle:Dispose(arg_16_1)
	if self.ab then
		self:ForceClearRef(arg_16_1)
	end

	return
end

return
