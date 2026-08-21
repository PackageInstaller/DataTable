module("bootstrap.util.HotUpdateUtil", package.seeall)

local var_0_0 = {}

function var_0_0.GetUpdateUrl(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	if Astral.VersionMgr.Instance:LoadLocalVersionCode() then
		local var_1_0 = Astral.OneSDKMgr.getChannelId()
		local var_1_1 = var_0_0.GetProtocolDomain(arg_1_0)
		local var_1_2 = string.format("%s/manifest/%s/version_v5.manifest?p=%s&c1=%s&v=%s&vc=%s&pn=%s&c2=%s", var_1_1, arg_1_1, arg_1_2, arg_1_3, Astral.VersionMgr.Instance.localVersion, arg_1_4, arg_1_5, var_1_0)
		local var_1_3 = string.format("%s/manifest/%s/project_v5.manifest?p=%s&c1=%s&v=%s&vc=%s&pn=%s&c2=%s", var_1_1, arg_1_1, arg_1_2, arg_1_3, Astral.VersionMgr.Instance.localVersion, arg_1_4, arg_1_5, var_1_0)

		return var_1_2, var_1_3
	end

	return nil
end

function var_0_0.RequestRemoteVersion(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = var_0_0.GetUpdateUrl(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)

	Astral.GameUpdateHelper.Instance:RequestRemoteVersion(var_2_0)
end

function var_0_0.GetProtocolDomain(arg_3_0)
	local var_3_0 = arg_3_0

	if arg_3_0 ~= nil and string.find(arg_3_0, "http://") == nil and string.find(arg_3_0, "https://") == nil then
		var_3_0 = string.format("http://%s", arg_3_0)
	end

	return var_3_0
end

return var_0_0
