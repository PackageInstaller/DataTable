-- 获取参数拼接字符串
web.__getContactParams = function(sourceStr, addKey, addValue)
    return sourceStr .. addKey .. "=" .. (addValue or "")
end

-- 获取时间戳(秒)
web.__getTime = function()
    return os.time()
    -- local socket = require "socket"
    -- return math.floor(socket.gettime())
end

-- 地址编码
web.__urlEncode = function(s)
    local s = string.gsub(s, "([^%w%.%- ])",
        function(c)
            return string.format("%%%02X", string.byte(c))
        end
    )
    return string.gsub(s, " ", "+")
end

-- 地址解码
web.__urlDecode = function(s)
    local s = string.gsub(s, "%%(%x%x)",
        function(h)
            return string.char(tonumber(h, 16))
        end
    )
    return s
end

-- 通过请求方式获取地址格式
web.__getUrlByReqType = function(isPost, url, data, key, time)
    local encodeData = web.__urlEncode(data)
    local time = time or web.__getTime()
    local sign = CS.Lylibs.MD5Util.GetMD5ByString(data .. time .. key)

    -- local tip = string.format("url=%s，data=%s，key=%s，time=%s，encodeData=%s，sign=%s", url, data, key, time, encodeData, sign)
    -- web.WebController:reqBug(web.BUG_CACHE_TYPE.WEB, (isPost and "[POST] " or "[GET] ") .. tip, false)

    if(isPost)then
        local parasmDic = {}
        parasmDic["data"] = encodeData
        parasmDic["time"] = time
        parasmDic["sign"] = sign
        return url, parasmDic
    else
        url = web.__getContactParams(url, "data", encodeData)
        url = web.__getContactParams(url, "&time", time)
        url = web.__getContactParams(url, "&sign", sign)
        return url
    end
end

web.__getConfig = function()
    return web.WebManager:getWebConfig()
end

-- 渠道cdn资源更新类型
web.getChannelUpdateTypeUrl = function()
    local time = web.__getTime()
    local data = ""
    data = web.__getContactParams(data, "version", web.WebManager.game_version_name)-- 当前游戏客户端版本
    data = web.__getContactParams(data, "&devOS", web.WebManager.dev_os)-- 设备ID 1:android 2:ios
    data = web.__getContactParams(data, "&pf_id", web.WebManager.pf_id)-- 平台id
    data = web.__getContactParams(data, "&channel_id", web.WebManager.channel_id)
    data = web.__getContactParams(data, "&devVer", CS.UnityEngine.SystemInfo.operatingSystem)-- 设备型号 如5.0（移动设备上获取不到）
    data = web.__getContactParams(data, "&device", CS.UnityEngine.SystemInfo.deviceModel)-- 设备硬件型号 如huawei P9.1
    data = web.__getContactParams(data, "&cpu", gs.SdkManager:GetCpuName())-- 设备CPU
    data = web.__getContactParams(data, "&gpu", CS.UnityEngine.SystemInfo.graphicsDeviceName)-- 设备GPU
    data = web.__getContactParams(data, "&deviceId", sdk.SdkManager:getUniqueId())-- 设备产品编号
    data = web.__getContactParams(data, "&uuid", sdk.SdkManager:getUniqueId())-- 设备标识ID
    data = web.__getContactParams(data, "&deviceTime", time)-- 客户端时间
    data = web.__getContactParams(data, "&systemMemorySize", (gs.SdkManager:GetMemorySize("SystemTotalMemory") / 1024).."GB")-- 系统内存大小
    return web.__getUrlByReqType(true, web.__getConfig().check_channel_update_type .. "?", data, web.__getConfig().common_key, time)
end

-- 通用参数统计
web.getReportGenericArgsUrl = function(type, genericArgs)
    local time = web.__getTime()
    local data = ""
    data = web.__getContactParams(data, "version", web.WebManager.game_version_name)-- 当前游戏客户端版本
    data = web.__getContactParams(data, "&devOS", web.WebManager.dev_os)-- 设备ID 1:android 2:ios
    data = web.__getContactParams(data, "&pf_id", web.WebManager.pf_id)-- 平台id
    data = web.__getContactParams(data, "&channel_id", web.WebManager.channel_id)
    data = web.__getContactParams(data, "&devVer", CS.UnityEngine.SystemInfo.operatingSystem)-- 设备型号 如5.0（移动设备上获取不到）
    data = web.__getContactParams(data, "&device", CS.UnityEngine.SystemInfo.deviceModel)-- 设备硬件型号 如huawei P9.1
    data = web.__getContactParams(data, "&cpu", gs.SdkManager:GetCpuName())-- 设备CPU
    data = web.__getContactParams(data, "&gpu", CS.UnityEngine.SystemInfo.graphicsDeviceName)-- 设备GPU
    data = web.__getContactParams(data, "&deviceId", sdk.SdkManager:getUniqueId())-- 设备产品编号
    data = web.__getContactParams(data, "&uuid", sdk.SdkManager:getUniqueId())-- 设备标识ID
    data = web.__getContactParams(data, "&genericArgs", tostring(genericArgs))-- 通用字符串参数
    data = web.__getContactParams(data, "&type", type)-- 类型
    data = web.__getContactParams(data, "&deviceTime", time)-- 客户端时间
    data = web.__getContactParams(data, "&systemMemorySize", (gs.SdkManager:GetMemorySize("SystemTotalMemory") / 1024).."GB")-- 系统内存大小
    return web.__getUrlByReqType(true, web.__getConfig().generic_args_url .. "?", data, web.__getConfig().common_key, time)
end

-- 获取指定服或推荐服列表
web.getRecommendServerInfoUrl = function()
    local data = ""
    data = web.__getContactParams(data, "pf_id", web.WebManager.pf_id)
    data = web.__getContactParams(data, "&channel_id", web.WebManager.channel_id)
    data = web.__getContactParams(data, "&sub_channel_id", web.WebManager.sub_channel_id)
    local lastServerInfoStr = web.WebManager:getWebServerStorage()
    if (lastServerInfoStr and lastServerInfoStr ~= "") then
        local storageServerVo = web.WebServerVo.new()
        local isSuc = storageServerVo:toTable(lastServerInfoStr)
        if(isSuc)then
            data = web.__getContactParams(data, "&srv_id", storageServerVo.server_id)-- 如果已有上次缓存服务器数据则直接获取指定的最新服务器数据
            print(string.format("存在有服务器缓存数据，设置获取指定推荐服：%s", lastServerInfoStr))
        end
    end
    data = web.__getContactParams(data, "&user_name", web.WebManager.web_account_id or "")-- 平台账号id，获取推荐服时必填
    data = web.__getContactParams(data, "&dev_os", web.WebManager.dev_os)

    -- cdn大位版本号：用于避免线上版本和审核版本拿到相同的cdn地址和服务器列表（审核版本在审核期间需要单独使用最新的cdn和服务器列表，审核通过后后台会统一返回线上玩家最新的cdn和服务器列表）
    local bigCode = string.split(web.WebManager.game_version_name, ".")[1] or web.WebManager.game_version_name
    data = web.__getContactParams(data, "&game_version", bigCode)

    -- 额外再补上这两个参数，一起由后台控制是否审核版本
    local sdkInfo = sdk.SdkManager:getSdkInfo()
    if(sdkInfo)then
        data = web.__getContactParams(data, "&package_name", sdkInfo.packageName)
        data = web.__getContactParams(data, "&sdk_version", sdkInfo.versionCode)
    end
    return web.__getUrlByReqType(true, web.__getConfig().recommand_server_info .. "?", data, web.__getConfig().common_key)
end

-- 获取登录公告
web.getLoginNoticeUrl = function()
    local data = ""
    data = web.__getContactParams(data, "pf_id", web.WebManager.pf_id)
    data = web.__getContactParams(data, "&channel_id", web.WebManager.channel_id)
    data = web.__getContactParams(data, "&sub_channel_id", web.WebManager.sub_channel_id)
    local isLastSuc = false
    local lastServerInfoStr = web.WebManager:getWebServerStorage()
    if (lastServerInfoStr and lastServerInfoStr ~= "") then
        local storageServerVo = web.WebServerVo.new()
        isLastSuc = storageServerVo:toTable(lastServerInfoStr)
        if(isLastSuc)then
            data = web.__getContactParams(data, "&is_grayscale", storageServerVo.is_grayscale)-- 如果已有上次缓存服务器数据则直接获取指定的最新服务器数据的是否灰度
            data = web.__getContactParams(data, "&is_merge", storageServerVo.is_merge)-- 如果已有上次缓存服务器数据则直接获取指定的最新服务器数据的是否合服
            print(string.format("存在有服务器缓存数据，设置灰度和合服参数：%s", lastServerInfoStr))
        end
    end
    if(not isLastSuc)then
        data = web.__getContactParams(data, "&is_grayscale", web.WebManager.is_grayscale)-- 是否灰度
        data = web.__getContactParams(data, "&is_merge", web.WebManager.is_merge)-- 是否合服
    end
    return web.__getUrlByReqType(true, web.__getConfig().bulletin_list_url .. "?", data, web.__getConfig().common_key)
end

-- 上报步骤统计
web.getReportStepUrl = function(step, time)
    local versionName = web.WebManager.game_version_name
    if(download and download.ResDownLoadManager)then
        local serverVersion = download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.VersionKey)
        versionName = download.ResDownLoadManager:getVersionStr(serverVersion)
    end

    local data = ""
    data = web.__getContactParams(data, "version", versionName)-- 当前游戏客户端版本
    data = web.__getContactParams(data, "&devOS", web.WebManager.dev_os)-- 设备ID 1:android 2:ios
    data = web.__getContactParams(data, "&devVer", CS.UnityEngine.SystemInfo.operatingSystem)-- 设备型号 如5.0（移动设备上获取不到）
    data = web.__getContactParams(data, "&device", CS.UnityEngine.SystemInfo.deviceModel)-- 设备硬件型号 如huawei P9.1
    data = web.__getContactParams(data, "&deviceId", sdk.SdkManager:getUniqueId())-- 设备产品编号
    data = web.__getContactParams(data, "&uuid", sdk.SdkManager:getUniqueId())-- 设备标识ID
    data = web.__getContactParams(data, "&mobile", "")-- 手机号码
    data = web.__getContactParams(data, "&pf_id", web.WebManager.pf_id)
    data = web.__getContactParams(data, "&channel_id", web.WebManager.channel_id)
    data = web.__getContactParams(data, "&srv_id", web.WebManager.server_id or "")
    data = web.__getContactParams(data, "&account_id", web.WebManager.web_account_id or "")
    data = web.__getContactParams(data, "&player_id", (role and role.RoleManager) and role.RoleManager:getRoleVo().playerId or "")
    -- local ip = CS.Lylibs.DeviceInfoMgr.GetIP("ip4")
    local ip = web.WebManager.web_ip
    data = web.__getContactParams(data, "&ip", ip ~= "" and ip or "0.0.0.0")
    data = web.__getContactParams(data, "&step", step)
    data = web.__getContactParams(data, "&deviceTime", time)-- 客户端时间
    data = web.__getContactParams(data, "&costTime", web.GET_REPORT_STEP_PREV_TIMES(step))-- 当前步骤与上一步骤的耗时间隔
    return web.__getUrlByReqType(true, web.__getConfig().report_step_url .. "?", data, web.__getConfig().common_key, time)
end

-- -- 上报步骤加载时长统计，待实现
-- web.getReportStepLoadingTimeUrl = function()
--     local data = ""
--     data = web.__getContactParams(data, , )
--     return web.__getUrlByReqType(true, web.__getConfig().report_step_loading_time_url .. "?", data, web.__getConfig().common_key)
-- end

-- bug统计
web.getBugUrl = function(content)
    local time = web.__getTime()
    local data = ""
    data = web.__getContactParams(data, "version", web.WebManager.game_version_name)-- 当前游戏客户端版本
    data = web.__getContactParams(data, "&devOS", web.WebManager.dev_os)-- 设备ID 1:android 2:ios
    data = web.__getContactParams(data, "&mobile", "")-- 手机号码
    data = web.__getContactParams(data, "&pf_id", web.WebManager.pf_id)
    data = web.__getContactParams(data, "&channel_id", web.WebManager.channel_id)
    data = web.__getContactParams(data, "&srv_id", web.WebManager.server_id or "")
    data = web.__getContactParams(data, "&accountId", web.WebManager.web_account_id or "")
    data = web.__getContactParams(data, "&accountName", web.WebManager.web_account_id or "")
    data = web.__getContactParams(data, "&device", CS.UnityEngine.SystemInfo.deviceModel)-- 设备硬件型号 如huawei P9.1
    data = web.__getContactParams(data, "&playerId", role and role.RoleManager:getRoleVo().playerId or "")
    data = web.__getContactParams(data, "&playerName", role and role.RoleManager:getRoleVo():getPlayerName() or "")
    data = web.__getContactParams(data, "&level", role and role.RoleManager:getRoleVo():getPlayerLvl() or 0)
    data = web.__getContactParams(data, "&deviceTime", time)-- 客户端时间
    data = web.__getContactParams(data, "&content", sdk.SdkManager:getUniqueId() .. "->" .. content)
    return web.__getUrlByReqType(true, web.__getConfig().bug_url .. "?", data, web.__getConfig().common_key, time)
end

-- 获取QQ客服
web.getQQServiceUrl = function()
    local data = ""
    -- data = web.__getContactParams(data, "g", 12)
    data = web.__getContactParams(data, "pf_id", web.WebManager.pf_id)
    data = web.__getContactParams(data, "&channel_id", web.WebManager.channel_id)
    return web.__getUrlByReqType(true, web.__getConfig().qq_service_url .. "?", data, web.__getConfig().common_key)
end

-- -- 获取VIP客服，待实现
-- web.getVipServiceUrl = function()
--     local data = ""
--     data = web.__getContactParams(data, , )
--     return web.__getUrlByReqType(true, web.__getConfig().vip_service_url .. "?", data, web.__getConfig().common_key)
-- end

-- 获取游戏服登录token
web.getGameLoginTokenUrl = function(isYingYongBao)
    local data = ""
    data = web.__getContactParams(data, "sid", web.WebManager.sdk_account_author_token)
    data = web.__getContactParams(data, "&pf_id", web.WebManager.pf_id)
    data = web.__getContactParams(data, "&channel_id", web.WebManager.channel_id)
    data = web.__getContactParams(data, "&account_id", web.WebManager.sdk_account_id)
    data = web.__getContactParams(data, "&adult", web.WebManager.adult)
    data = web.__getContactParams(data, "&ext_info", web.WebManager.ext_info)
    data = web.__getContactParams(data, "&pgid", web.WebManager.pgid or 0)
    data = web.__getContactParams(data, "&uuid", sdk.SdkManager:getUniqueId())-- 设备标识ID
    -- 是否应用宝
    if(isYingYongBao)then
        data = web.__getContactParams(data, "&openid", "")
        data = web.__getContactParams(data, "&openkey", "")
        data = web.__getContactParams(data, "&accesstoken", "")
    end
    return web.__getUrlByReqType(true, web.__getConfig().token_url .. "?", data, web.__getConfig().common_key)
end

-- 请求订单充值
web.getRechargeOrderUrl = function(itemId, money, moneyType)
    local data = ""
    data = web.__getContactParams(data, "devOS", web.WebManager.dev_os)
    data = web.__getContactParams(data, "&pf_id", web.WebManager.pf_id)
    data = web.__getContactParams(data, "&channel", "")-- 渠道标识
    data = web.__getContactParams(data, "&channel_id", web.WebManager.channel_id or 0)
    data = web.__getContactParams(data, "&srv_id", web.WebManager.server_id or "")-- 服务器id
    data = web.__getContactParams(data, "&account_id", web.WebManager.web_account_id or "")
    data = web.__getContactParams(data, "&player_id", role and role.RoleManager:getRoleVo().playerId or "")
    data = web.__getContactParams(data, "&player_name", role and role.RoleManager:getRoleVo():getPlayerName() or "")
    data = web.__getContactParams(data, "&level", role.role and RoleManager:getRoleVo():getPlayerLvl() or 0)
    data = web.__getContactParams(data, "&itemId", itemId or "")-- 商品id
    data = web.__getContactParams(data, "&money", money or -1)-- 充值额(元)，需由分转换成元
    data = web.__getContactParams(data, "&moneyType", moneyType or 1)-- 货币类型 默认1：人民币
    data = web.__getContactParams(data, "&pgid", web.WebManager.pgid or 0)-- 游戏参数
    local url = web.__getConfig().recharge_order_url .. web.WebManager.pf_id .. "?"
    return web.__getUrlByReqType(false, url, data, web.__getConfig().common_key)
end

-- 获取ip地址
web.getIPUrl = function()
    local data = ""
    return web.__getUrlByReqType(true, web.__getConfig().get_ip .. "?", data, web.__getConfig().common_key)
end

-- 获取资源密钥地址
web.getABKeyUrl = function()
    local data = ""
    data = web.__getContactParams(data, "pf_id", web.WebManager.pf_id)
    data = web.__getContactParams(data, "&channel_id", web.WebManager.channel_id)
    return web.__getUrlByReqType(true, web.__getConfig().get_ab_key .. "?", data, web.__getConfig().common_key)
end

-- 文件实时上传地址
web.getUploadRealTimeUrl = function(content)
    local time = web.__getTime()
    local data = ""
    data = web.__getContactParams(data, "version", web.WebManager.game_version_name)-- 当前游戏客户端版本
    data = web.__getContactParams(data, "&devOS", web.WebManager.dev_os)-- 设备ID 1:android 2:ios
    data = web.__getContactParams(data, "&mobile", "")-- 手机号码
    data = web.__getContactParams(data, "&pf_id", web.WebManager.pf_id)
    data = web.__getContactParams(data, "&channel_id", web.WebManager.channel_id)
    data = web.__getContactParams(data, "&srv_id", web.WebManager.server_id or "")
    data = web.__getContactParams(data, "&accountId", web.WebManager.web_account_id or "")
    data = web.__getContactParams(data, "&accountName", web.WebManager.web_account_id or "")
    data = web.__getContactParams(data, "&device", CS.UnityEngine.SystemInfo.deviceModel)-- 设备硬件型号 如huawei P9.1
    data = web.__getContactParams(data, "&playerId", role and role.RoleManager and role.RoleManager:getRoleVo().playerId or "")
    data = web.__getContactParams(data, "&playerName", role and role.RoleManager and role.RoleManager:getRoleVo():getPlayerName() or "")
    data = web.__getContactParams(data, "&level", role and role.RoleManager and role.RoleManager:getRoleVo():getPlayerLvl() or 0)
    data = web.__getContactParams(data, "&deviceTime", time)-- 客户端时间
    data = web.__getContactParams(data, "&uuid", sdk.SdkManager:getUniqueId())-- uuid
    data = web.__getContactParams(data, "&content", content)
    return web.__getUrlByReqType(true, web.__getConfig().upload_real_time_url .. "?", data, web.__getConfig().common_key, time)
end

-- 文件上传类型地址
web.getUploadTypeUrl = function()
    local time = web.__getTime()
    local data = ""
    data = web.__getContactParams(data, "&ip", web.WebManager.web_ip or "")
    data = web.__getContactParams(data, "&ip4", CS.Lylibs.DeviceInfoMgr.GetIP("ip4") or "")
    data = web.__getContactParams(data, "&ip6", CS.Lylibs.DeviceInfoMgr.GetIP("ip6") or "")
    data = web.__getContactParams(data, "&mac", CS.Lylibs.DeviceInfoMgr.GetMac() or "")
    data = web.__getContactParams(data, "version", web.WebManager.game_version_name)-- 当前游戏客户端版本
    data = web.__getContactParams(data, "&devOS", web.WebManager.dev_os)-- 设备ID 1:android 2:ios
    data = web.__getContactParams(data, "&mobile", "")-- 手机号码
    data = web.__getContactParams(data, "&pf_id", web.WebManager.pf_id)
    data = web.__getContactParams(data, "&channel_id", web.WebManager.channel_id)
    data = web.__getContactParams(data, "&srv_id", web.WebManager.server_id or "")
    data = web.__getContactParams(data, "&accountId", web.WebManager.web_account_id or "")
    data = web.__getContactParams(data, "&accountName", web.WebManager.web_account_id or "")
    data = web.__getContactParams(data, "&device", CS.UnityEngine.SystemInfo.deviceModel)-- 设备硬件型号 如huawei P9.1
    data = web.__getContactParams(data, "&playerId", role and role.RoleManager:getRoleVo().playerId or "")
    data = web.__getContactParams(data, "&playerName", role and role.RoleManager:getRoleVo():getPlayerName() or "")
    data = web.__getContactParams(data, "&level", role and role.RoleManager:getRoleVo():getPlayerLvl() or 0)
    data = web.__getContactParams(data, "&deviceTime", time)-- 客户端时间
    data = web.__getContactParams(data, "&uuid", sdk.SdkManager:getUniqueId())-- uuid
    return web.__getUrlByReqType(true, web.__getConfig().get_upload_type_url .. "?", data, web.__getConfig().common_key, time)
end

web.tryParseJson = function(jsonStr, okFun, errFun)
    if(jsonStr == nil or jsonStr == "")then
        errFun()
    else
        local function _tryParse()
            return JsonUtil.decode(jsonStr)
        end
        local isParseOk, value = pcall(_tryParse)
        if isParseOk then
            okFun(value)
        else
            errFun(value)
        end
    end
end

-- 获取网络状态
web.getNetStatus = function()
	local isHasNetWork = true
	local isMobileNet = false
	local isWifi = false
	
    if(web.WebManager.platform == web.DEVICE_TYPE.WINDOWS)then
        isHasNetWork = gs.DeviceInfoMgr:NetConnectionStatus()
        isWifi = true
    else
        local unityEngine = CS.UnityEngine
        if(unityEngine.Application.internetReachability == unityEngine.NetworkReachability.NotReachable) then
            -- 没有网络
            isHasNetWork = false
        elseif(unityEngine.Application.internetReachability == unityEngine.NetworkReachability.ReachableViaCarrierDataNetwork) then
            -- 234G网络
            isMobileNet = true
        elseif(unityEngine.Application.internetReachability == unityEngine.NetworkReachability.ReachableViaLocalAreaNetwork) then
            -- wifi网络
            isWifi = true
        end
    end
	return isHasNetWork, isMobileNet, isWifi
end

-- 获取显示格式化版本号
web.getFormatVersion = function(prefixVersion, serverVersionStr, serverProVersion, serverArtVersion)
    local platform = ""
    if(gs.Application.platform == gs.RuntimePlatform.Android)then
        platform = "Android"
    elseif(gs.Application.platform == gs.RuntimePlatform.IPhonePlayer)then
        platform = "iOS"
    elseif(gs.Application.platform == gs.RuntimePlatform.WindowsPlayer)then
        platform = "Windows"
    end
    local prefixVersionStr = prefixVersion == "" and "" or prefixVersion .. "."
    local channelId, channelName = sdk.SdkManager:getChannelData()
    local channelIdStr = channelId == sdk.AndroidChannelId.NONE and "" or "(" .. tostring(channelId) .. ")" 
    return string.substitute("{0}{1}{2}_{3}_{4}{5}", platform, prefixVersionStr, serverVersionStr, serverProVersion, serverArtVersion, channelIdStr)
end

web.setSplashTipProcess = function(process)
    if(process == nil)then
        CS.Lylibs.Splash.Instance:SetStep("")
    else
        CS.Lylibs.Splash.Instance:SetStep(string.format("正在初始化：%s", process) .. "%")
    end
end

web.uploadFile = function(isAppendDetail, localFilePath, remoteFileNameWithoutExtension, successCall, failCall)
    local time = tostring(web.__getTime())
    local uuid = sdk.SdkManager:getUniqueId()
    local remoteServerUrl = web.__getConfig().upload_file_url
    local remoteFileName = remoteFileNameWithoutExtension ..".ly"
    local isHasNetWork, isMobileNet, isWifi = web.getNetStatus()

    local appendData = ""
    appendData = appendData .. "\n===================================================================================="
    appendData = appendData .. string.format("\n开始上传 %s 至远程机 %s：", localFilePath, remoteFileName)
    appendData = appendData .. string.format("\n%s ==> %s", "客户端版本", web.WebManager.game_version_name)
    appendData = appendData .. string.format("\n%s ==> %s", "游戏平台", web.WebManager.pf_id)
    appendData = appendData .. string.format("\n%s ==> %s", "设备平台", web.WebManager.platform)
    appendData = appendData .. string.format("\n%s ==> %s", "渠道id", web.WebManager.channel_id)
    appendData = appendData .. string.format("\n%s ==> %s", "子渠道id", web.WebManager.sub_channel_id)
    appendData = appendData .. string.format("\n%s ==> %s", "设备型号", CS.UnityEngine.SystemInfo.operatingSystem)
    appendData = appendData .. string.format("\n%s ==> %s", "设备硬件型号", CS.UnityEngine.SystemInfo.deviceModel)
    appendData = appendData .. string.format("\n%s ==> %s", "设备CPU", gs.SdkManager:GetCpuName())
    appendData = appendData .. string.format("\n%s ==> %s", "设备GPU", CS.UnityEngine.SystemInfo.graphicsDeviceName)
    appendData = appendData .. string.format("\n%s ==> %s", "UUID", sdk.SdkManager:getUniqueId())
    appendData = appendData .. string.format("\n%s ==> %s", "系统内存大小", (gs.SdkManager:GetMemorySize("SystemTotalMemory") / 1024).."GB")
    appendData = appendData .. string.format("\n%s ==> %s", "缓存服务器", web.WebManager:getWebServerStorage())
    
    appendData = appendData .. string.format("\n%s ==> %s", "id_1", web.WebManager.server_id or "")
    appendData = appendData .. string.format("\n%s ==> %s", "id_2", web.WebManager.web_account_id or "")
    appendData = appendData .. string.format("\n%s ==> %s", "id_3", web.WebManager.sdk_account_author_token or "")
    appendData = appendData .. string.format("\n%s ==> %s", "id_4", web.WebManager.sdk_account_id or "")
    appendData = appendData .. string.format("\n%s ==> %s", "是否Wifi", tostring(isWifi))

    local sdkInfo = sdk.SdkManager:getSdkInfo()
    if(sdkInfo)then
        appendData = appendData .. string.format("\n%s ==> %s", "包名", sdkInfo.packageName or "")
    end
    
    appendData = appendData .. "\n===================================================================================="
    if(isAppendDetail)then
        gs.File.AppendAllText(localFilePath, appendData)
    else
        print(appendData)
    end

    local headParamsDic = {}
    headParamsDic["ly-report-key"] = "6HNihFsuHCQsWcnwkV36eZqOexvqbQSI"
    headParamsDic["ly-report-gameid"] = "12"
    headParamsDic["ly-report-sign"] = CS.Lylibs.MD5Util.GetMD5ByString(CS.Lylibs.MD5Util.GetMD5ByString(uuid) .. time)
    headParamsDic["ly-report-time"] = time
    
    local paramsDic = {}
    paramsDic["errorFile"] = localFilePath
    paramsDic["from"] = "CLIENT"
    paramsDic["save"] = "1"
    paramsDic["uuid"] = uuid
    paramsDic["version"] = "1"

    gs.FileUtil.UploadFile(headParamsDic, paramsDic, remoteServerUrl, remoteFileName, 
    function(result, responseCode, msg)
        if(result)then
            successCall(responseCode, msg)
        else
            failCall(responseCode, msg)
        end
    end)
end

-- 获取Debug登录权限
web.getClientAuthLoginUrl = function()
    local data = ""
    -- data = web.__getContactParams(data, "g", 12)
    data = web.__getContactParams(data, "user_name", login.LoginManager.clientAuthId)
    data = web.__getContactParams(data, "&pwd", login.LoginManager.clientAuthPwd)

    local webConfig = require("game/web/config/OuterTestConfig") --固定用外测的配置
    return web.__getUrlByReqType(true, web.__getConfig().client_auth_login .. "?", data, webConfig.common_key)
end

--[[ 替换语言包自动生成，请勿修改！
]]
