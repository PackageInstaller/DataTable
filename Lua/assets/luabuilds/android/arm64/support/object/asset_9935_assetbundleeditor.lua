pg = pg or {}

local AssetBundle = class("AssetBundle", pg.AssetBundle)

pg.AssetBundleEditor = AssetBundle

function AssetBundle:Load(arg_1_1, arg_1_2, arg_1_3)
	assert(not self.ab)

	self.abs = {}

	if arg_1_1 then
		onNextTick(function()
			existCall(arg_1_3, self)

			return
		end)
	else
		existCall(arg_1_3, self)

		return self
	end

	return
end

function AssetBundle:LoadAssetSync(arg_3_1, ...)
	arg_3_1 = self:ChangeAssetName(arg_3_1)

	return ResourceMgr.Inst:getAssetSync(self.path, arg_3_1, ...)
end

function AssetBundle:LoadAssetAsync(arg_4_1, arg_4_2, arg_4_3, ...)
	arg_4_1 = self:ChangeAssetName(arg_4_1)

	return ResourceMgr.Inst:getAssetAsync(self.path, arg_4_1, arg_4_2, UnityEngine.Events.UnityAction_UnityEngine_Object(arg_4_3), ...)
end

function AssetBundle:GetAllAssetNames()
	return table.CArrayToArray(ReflectionHelp.RefCallMethod(typeof(ResourceMgr), "GetAssetBundleAllAssetNames", ResourceMgr.Inst, {
		typeof("System.String")
	}, {
		self.path
	}))
end

return
