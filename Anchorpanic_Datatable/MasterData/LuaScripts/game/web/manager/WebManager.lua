module("web.WebManager", Class.impl("lib.event.EventDispatcher"))

-- 第一个界面初始化完毕回调
FIRST_VIEW_INIT_FINISH = "FIRST_VIEW_INIT_FINISH"
-- 请求启动资源更新模块检测
REQ_MODULE_UPDATE_CHECK = "REQ_MODULE_UPDATE_CHECK"
-- 资源更新模块检测完毕回调
MODULE_UPDATE_CHECK_FINISH = "MODULE_UPDATE_CHECK_FINISH"
-- 功能模块加载完毕（返回参数进度比例）
MODULE_REQUIRE_FINISH = "MODULE_REQUIRE_FINISH"
-- 所有功能模块加载完毕
ALL_MODULE_REQUIRE_FINISH = "ALL_MODULE_REQUIRE_FINISH"
-- 请求Sdk账号登录
REQ_SDK_ACCOUNT_LOGIN = "REQ_SDK_ACCOUNT_LOGIN"
-- 请求Sdk账号登录中断
SDK_ACCOUNT_LOGIN_INTERRUPT = "SDK_ACCOUNT_LOGIN_INTERRUPT"
-- 获必需数据完毕
GAIN_ALL_DATA_FINISH = "GAIN_ALL_DATA_FINISH"

--构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()
    if(not CS.Lylibs.ApplicationUtil.IsEditorRun)then
        self:__parseGameInfo()
    end
end

--析构函数
function dtor(self)
end

----------------------------------------------------------------本地服务器数据缓存相关----------------------------------------------------------------
function addWebServerStorage(self, serverVo, key)
    local key = self:__getWebServerKey(key)
    local saveStr = serverVo:toString()
    StorageUtil:saveString0(key, saveStr)

    local allWebServerKeyStr = self:__getAllWebServerKey()
    if (string.find(allWebServerKeyStr, key) == nil) then
        allWebServerKeyStr = allWebServerKeyStr .. key
        StorageUtil:saveString0("WebServerAll", allWebServerKeyStr)
    end
end

function getWebServerStorage(self, key)
    local key = self:__getWebServerKey(key)
    return StorageUtil:getString0(key)
end

function delWebServerStorage(self, key)
    local key = self:__getWebServerKey(key)
    StorageUtil:deleteKey0(key)

    local allWebServerKeyStr = self:__getAllWebServerKey()
    if (string.find(allWebServerKeyStr, key) ~= nil) then
        allWebServerKeyStr = string.gsub(allWebServerKeyStr, key, "")
        StorageUtil:saveString0("WebServerAll", allWebServerKeyStr)
    end
end

function delAllWebServerStorage(self)
    local allWebServerKeyStr = self:__getAllWebServerKey()
    local list = string.split(allWebServerKeyStr, "WebServerVo")
    for i = 1, #list do
        StorageUtil:deleteKey0(self:__getWebServerKey(list[i]))
    end
    StorageUtil:deleteKey0("WebServerAll")
end

function __getWebServerKey(self, key)
    local key = "WebServerVo" .. (key or self.web_account_id or "")
    return key
end

function __getAllWebServerKey(self)
    local allWebServerKeyStr = StorageUtil:getString0("WebServerAll")
    allWebServerKeyStr = allWebServerKeyStr or ""
    return allWebServerKeyStr
end
----------------------------------------------------------------本地服务器数据缓存相关----------------------------------------------------------------

-- 获取web配置
function getWebConfig(self)
    if (self.net_type == web.NET_TYPE.INNER) then
        if (not self.m_webConfig) then
            self.m_webConfig = require("game/web/config/InnerConfig")
        end
    elseif (self.net_type == web.NET_TYPE.OUTER_TEST) then
        if (not self.m_webConfig) then
            self.m_webConfig = require("game/web/config/OuterTestConfig")
        end
    elseif (self.net_type == web.NET_TYPE.OUTER_RELEASE) then
        if (not self.m_webConfig) then
            self.m_webConfig = require("game/web/config/OuterReleaseConfig")
        end
    end
    return self.m_webConfig
end

-- 判断是否正式包
function isReleaseApp(self)
    return self.pf_name ~= "_Unity_Platform_Name_Debug_"
end

-- 判断是否官包
function isOfficialApp(self)
    return self.res_split_type == "Official"
end

-- 判断是否允许跳转游戏下载地址
function isAllowJumpDownLoad(self)
    return self.mode == web.MODE_TYPE.DEBUG and (self.net_type == web.NET_TYPE.INNER or self.net_type == web.NET_TYPE.OUTER_TEST)
end

-- 判断是否显示设备码
function isShowUniqueId(self)
    return self.mode == web.MODE_TYPE.DEBUG and (self.net_type == web.NET_TYPE.INNER or self.net_type == web.NET_TYPE.OUTER_TEST)
end

-- 初始数据
function __initData(self)
    --------------------------------------------------- 预加载顺序 ---------------------------------------------------
    -- 预加载类型
    -- 1：在显示登录界面之前
    -- 2：在显示登录界面之后
    -- 3：在点击登录之后
    self.preloadType = 1
    ---------------------------------------------------- 基础配置 ----------------------------------------------------
    -- 当前版署分支类型
    self.branch_type = "trunk"
    -- 当前客户端类型（内网、外网、外网测试......），主要用于加载不同的web配置
    self.net_type = web.NET_TYPE.INNER
    -- 设备运行平台
    self.platform = web.DEVICE_TYPE.WINDOWS
    -- 设备类型(0：通用 1：安卓 2：ios 3：pc)
    self.dev_os = 3
    -- 模式（目前暂时没用）
    self.mode = web.MODE_TYPE.DEBUG
    -- 对应项目svn版本
    self.pro_svn_version = ''
    -- 对应美术svn版本
    self.art_svn_version = ''
    -- 游戏版本
    self.game_version_name = '1.0.0'
    -- 游戏版本
    self.game_version = '1000000'
    -- 是否运行更新逻辑
    self.run_update_code = false
    -- 资源切分类型
    self.res_split_type = "Official"
    
    ------------------------------------------ 渠道类型对应挂钩的相关具体数据 ------------------------------------------
    -- 平台id，web给定写死 1：可以游戏，3：雷焰
    self.pf_id = 3
    -- 平台名
    self.pf_name = "_Unity_Platform_Name_Debug_"
    -- 渠道id
    self.channel_id = 3
    -- 子渠道id
    self.sub_channel_id = 3
    -- 游戏资源cdn
    self.game_cdn = ''
    -- 游戏下载链接
    self.game_url = ''

    ----------------------------------------------------- web相关 -----------------------------------------------------
    -- 服务器数据列表
    self.server_list = {}
    -- 备份的服务器数据列表
    self.backup_server_list = {}
    -- 设置当前的选择的服务器数据
    self:setServerData(nil)

    -- 游戏登录账户名称 (也就是平台的udbid)
    self.login_account_id = ""
end

-- 设置当前的选择的服务器数据
function setServerData(self, serverVo)
    -- 所在服务器id
    self.server_id = serverVo and serverVo.server_id or ""
    -- 所在服务器名字
    self.server_name = serverVo and serverVo.server_name or ""
    -- 所在服务器类型
    self.server_type = serverVo and serverVo.server_type or ""
    -- 游戏版本cdn
    -- self.game_cdn = serverVo and serverVo.game_cdn or "http://192.168.60.35:6060"
    self.game_cdn = serverVo and serverVo.game_cdn or "http://192.168.60.235:6060"
    -- 服务器ip
    self.ip = serverVo and serverVo.ip or "192.168.100.170"
    -- 服务器端口
    self.port = serverVo and serverVo.port or "8101"
    -- 是否维护中
    self.is_weihu = serverVo and serverVo.is_weihu or false
    -- 是否灰度服
    self.is_grayscale = serverVo and serverVo.is_grayscale or 0
    -- 是否合服
    self.is_merge = serverVo and serverVo.is_merge or 0
end

-- 从服务器数据列表取出数据
function getServerVo(self)
    local count = #self.server_list
    if (count > 0) then
        local index = math.random(1, count)
        return table.remove(self.server_list, index)
    else
        return nil
    end
end

-- 恢复备份的服务器列表数据
function restoreBackUpServerlist(self)
    if (self.backup_server_list and #self.backup_server_list > 0) then
        self.server_list = {}
        for _, serverVo in pairs(self.backup_server_list) do
            table.insert(self.server_list, serverVo)
        end
    end
end

-- 解析游戏配置数据和SDK信息数据
function __parseGameInfo(self)
    local gameInfo = CS.Lylibs.SDKManager.Ins:GetGameInfo()
    if (gameInfo ~= "") then
        print("获取游戏配置数据", gameInfo)
        local gameInfo = JsonUtil.decode(gameInfo)
        if (gameInfo) then
            
            -- 基础配置，需保证有值
            self.branch_type = gameInfo.branch_type
            self.platform = gameInfo.platform
            self.pro_svn_version = gameInfo.pro_svn_version
            self.art_svn_version = gameInfo.art_svn_version
            self.game_version_name = gameInfo.version_name
            self.game_version = gameInfo.version_code
            self.prefix_version_str = gameInfo.prefix_version_str
            
            self.app_des = gameInfo.des
            self.pf_id = gameInfo.pf_id
            self.pf_name = gameInfo.pf_name
            self.channel_id = gameInfo.channel_id
            self.sub_channel_id = gameInfo.sub_channel_id
            self.mode = gameInfo.mode
            self.net_type = gameInfo.net_type

            -- 限定渠道app走更新逻辑
            self.run_update_code = self:isReleaseApp() and true or gameInfo.is_run_update == "1"
            self.res_split_type = gameInfo.res_split_type
            self.game_cdn = gameInfo.game_cdn
            self.game_url = gameInfo.game_url
            self.dev_os = web.GetDeviceCode(gameInfo.platform)

            print("游戏配置数据解析成功")
        end
    end
end

-- 解析SDK账号数据
function parseSdkAccountInfo(self, data)
    if (data and data ~= "") then
        print("获取sdk账号数据", data)
        local sdkAccountInfo = JsonUtil.decode(data)
        if (sdkAccountInfo) then
            if(sdkAccountInfo.userId ~= "" and sdkAccountInfo.authorToken ~= "")then
                self.sdk_account_id = sdkAccountInfo.userId
                self.sdk_account_token = sdkAccountInfo.token -- 可能会为空字符串，目前前端无实际用途
                self.sdk_account_author_token = sdkAccountInfo.authorToken
                print("sdk账号数据解析成功")
                -- 设置Bugly的用户账号id
                sdk.SdkManager:buglySetUserId(self.sdk_account_id)
                return true
            end
        end
    end
    return false
end

-- 解析cdn资源更新类型
function parseChannelUpdateTypeData(self, webData, jsonObj)
    if(webData == "")then
        print("WebManager", string.format("获取cdn资源更新类型->出错码：%s，内容：%s", web.CDN_UPDATE_TYPE_SUB_CODE.JSON_EMPTY, webData))
        return web.CDN_UPDATE_TYPE_SUB_CODE.JSON_EMPTY
    end
    if(not jsonObj or not jsonObj.data)then
        print("WebManager", string.format("获取cdn资源更新类型->出错码：%s，内容：%s", web.CDN_UPDATE_TYPE_SUB_CODE.PARSE_FAIL, webData))
        return web.CDN_UPDATE_TYPE_SUB_CODE.PARSE_FAIL
    end
    if (jsonObj.status == 0) then
        local message = CS.Lylibs.UTF8StringUtil.GetString(jsonObj.message)
        print("WebManager", string.format("获取cdn资源更新类型->出错码：%s，内容：%s", web.CDN_UPDATE_TYPE_SUB_CODE.STATUS_ZERO, webData))
        return web.CDN_UPDATE_TYPE_SUB_CODE.STATUS_ZERO
    else
        if(jsonObj.data and jsonObj.data.force_update_type and jsonObj.data.force_update_type ~= "")then
            self.web_force_update_type = jsonObj.data.force_update_type
            print("WebManager", "获取cdn资源更新类型返回：" .. webData)
            return web.CDN_UPDATE_TYPE_SUB_CODE.NORMAL
        else
            print("WebManager", string.format("获取cdn资源更新类型->出错码：%s，内容：%s", web.CDN_UPDATE_TYPE_SUB_CODE.ALL_FIELD_EMPTY, webData))
            return web.CDN_UPDATE_TYPE_SUB_CODE.ALL_FIELD_EMPTY
        end
    end
end

-- 解析服务器列表数据
function parseRecommandServerData(self, webData, jsonObj)
    self.server_list = {}
    self.backup_server_list = {}
    if(webData == "")then
        print("WebManager", string.format("获取指定服或推荐服->出错码：%s，内容：%s", web.RECOMMEND_SUB_CODE.JSON_EMPTY, webData))
        return web.RECOMMEND_SUB_CODE.JSON_EMPTY
    end
    if(not jsonObj or not jsonObj.data)then
        print("WebManager", string.format("获取指定服或推荐服->出错码：%s，内容：%s", web.RECOMMEND_SUB_CODE.PARSE_FAIL, webData))
        return web.RECOMMEND_SUB_CODE.PARSE_FAIL
    end
    if (jsonObj.status == 0) then
        local message = CS.Lylibs.UTF8StringUtil.GetString(jsonObj.message)
        print("WebManager", string.format("获取指定服或推荐服->出错码：%s，内容：%s", web.RECOMMEND_SUB_CODE.STATUS_ZERO, webData))
        return web.RECOMMEND_SUB_CODE.STATUS_ZERO
    else
        print("WebManager", "获取指定服或推荐服返回：" .. webData)
        for srv_id, _data in pairs(jsonObj.data) do
            local serverVo = web.WebServerVo.new()
            serverVo:setData(_data)
            table.insert(self.server_list, serverVo)
            table.insert(self.backup_server_list, serverVo)
        end
        print("WebManager", "获取指定服或推荐服解析成功")
        
        if(#self.server_list <= 0)then
            print(string.format("获取指定服或推荐服->出错码：%s，内容：%s", web.RECOMMEND_SUB_CODE.SERVER_LIST_EMPTY, webData))
            return web.RECOMMEND_SUB_CODE.SERVER_LIST_EMPTY
        else
            return web.RECOMMEND_SUB_CODE.NORMAL
        end
    end
end

-- 获取当前是否维护状态
function getIsWeiHu(self)
    local storageServerVo = nil
    local storageServerVoStr = web.WebManager:getWebServerStorage()
    if (storageServerVoStr ~= nil or storageServerVoStr ~= "") then
        storageServerVo = web.WebServerVo.new()
        local isSuc = storageServerVo:toTable(storageServerVoStr)
        if (not isSuc) then
            storageServerVo = nil
        end
    end

    local findServerVo = nil
    for i = 1, #web.WebManager.backup_server_list do
        if (storageServerVo and web.WebManager.backup_server_list[i].server_id == storageServerVo.server_id) then
            findServerVo = web.WebManager.backup_server_list[i]
            break
        end
    end

    if(findServerVo)then
        return findServerVo.is_weihu
    else
        local isAllWeiHu = true
        local backupServerList = web.WebManager.backup_server_list
        for i = 1, #backupServerList do
            local serverVo = backupServerList[i]
            if (not serverVo.is_weihu) then
                isAllWeiHu = false
                break
            end
        end
        return isAllWeiHu
    end
end

-- 解析登录公告
function parseLoginNoticeData(self, webData, jsonObj)
    if(not jsonObj or not jsonObj.data)then
        print("WebManager", "获取登录公告返回出错：" .. webData)
        return
    end
    if(jsonObj.status == 0)then
        login.LoginManager:setLoginBulletinData(nil)
        local message = CS.Lylibs.UTF8StringUtil.GetString(jsonObj.message)
        print("WebManager", "获取登录公告返回出错：" .. message .. " => " .. webData)
    else
        login.LoginManager:setLoginBulletinData(jsonObj.data)
        print("WebManager", "获取登录公告返回：" .. webData)
    end
end

-- 解析游戏服登录Token
function parseGameTokenData(self, webData, jsonObj)
    if(webData == "")then
        print("WebManager", string.format("获取游戏服登录token->出错码：%s，内容：%s", web.GAME_LOGIN_TOKEN_SUB_CODE.JSON_EMPTY, webData))
        return web.GAME_LOGIN_TOKEN_SUB_CODE.JSON_EMPTY
    end
    if(not jsonObj or not jsonObj.data)then
        print("WebManager", string.format("获取游戏服登录token->出错码：%s，内容：%s", web.GAME_LOGIN_TOKEN_SUB_CODE.PARSE_FAIL, webData))
        return web.GAME_LOGIN_TOKEN_SUB_CODE.PARSE_FAIL
    end
    if (jsonObj.status == 0) then
        local message = CS.Lylibs.UTF8StringUtil.GetString(jsonObj.message)
        print("WebManager", string.format("获取游戏服登录token->出错码：%s，内容：%s", web.GAME_LOGIN_TOKEN_SUB_CODE.STATUS_ZERO, webData))
        return web.GAME_LOGIN_TOKEN_SUB_CODE.STATUS_ZERO
    else
        if(jsonObj.data and jsonObj.data.adult and jsonObj.data.account_id and jsonObj.data.time and jsonObj.data.token)then
            if(jsonObj.data.adult ~= "" and jsonObj.data.account_id ~= "" and jsonObj.data.time ~= "" and jsonObj.data.token ~= "")then
                -- 防沉迷的标识
                self.web_infant = jsonObj.data.adult
                -- 是否白名单
                -- self.web_is_white = data.data.is_white
                self.web_account_id = jsonObj.data.account_id
                self.web_login_time = jsonObj.data.time
                self.web_login_token = jsonObj.data.token --MD5({account_id}+{time}+ {SRV_KEY})
                print("WebManager", "获取游戏服登录Token返回：" .. webData)
                return web.GAME_LOGIN_TOKEN_SUB_CODE.NORMAL
            end
        end
        print(string.format("获取游戏服登录token->出错码：%s，内容：%s", web.GAME_LOGIN_TOKEN_SUB_CODE.ALL_FIELD_EMPTY, webData))
        return web.GAME_LOGIN_TOKEN_SUB_CODE.ALL_FIELD_EMPTY
    end
end

-- 解析bug结果
function parseBugData(self, webData, jsonObj)
    if(webData == "")then
        print("WebManager", "bug统计返回出错为空")
        return
    end
    if(not jsonObj or not jsonObj.data)then
        print("WebManager", "bug统计返回出错：" .. webData)
        return
    end
    if(jsonObj.status == 0)then
        print("WebManager", "bug统计返回出错：" .. CS.Lylibs.UTF8StringUtil.GetString(jsonObj.message) .. " => " .. webData)
        return
    end
    -- print("WebManager", "bug统计返回成功：" .. webData)
end

-- 解析上报步骤统计结果
function parseReportStepData(self, webData, jsonObj)
    if(webData == "")then
        print("WebManager", "上报步骤统计返回出错为空")
        return
    end
    if(not jsonObj or not jsonObj.data)then
        print("WebManager", "上报步骤统计返回出错：" .. webData)
        return
    end
    if(jsonObj.status == 0)then
        print("WebManager", "上报步骤统计返回出错：" .. CS.Lylibs.UTF8StringUtil.GetString(jsonObj.message) .. " => " .. webData)
        return
    end
    -- print("WebManager", "上报步骤统计返回成功：" .. webData)
end

-- 解析QQ客服
function parseQQServiceData(self, webData, jsonObj)
    if(webData == "")then
        print("WebManager", "获取QQ客服返回出错为空")
        return
    end
    if(not jsonObj or not jsonObj.data)then
        print("WebManager", "获取QQ客服返回出错：" .. webData)
        return
    end
    if(jsonObj.status == 0)then
        print("WebManager", "获取QQ客服返回出错：" .. CS.Lylibs.UTF8StringUtil.GetString(jsonObj.message) .. " => " .. webData)
        return
    end
    -- print("WebManager", "获取QQ客服返回成功：" .. webData)
end

-- 解析IP数据
function parseIpData(self, webData, jsonObj)
    if(webData == "")then
        print("WebManager", "获取IP数据返回出错为空")
        return
    end
    if(not jsonObj or not jsonObj.data)then
        print("WebManager", "获取IP数据返回出错：" .. webData)
        return
    end
    if(jsonObj.status == 0)then
        print("WebManager", "获取IP数据返回出错：" .. CS.Lylibs.UTF8StringUtil.GetString(jsonObj.message) .. " => " .. webData)
        return
    end
    self.web_ip = jsonObj.data.ip
    self.web_address = CS.Lylibs.UTF8StringUtil.GetString(jsonObj.data.address)
    -- print("WebManager", "获取IP数据返回成功：" .. webData)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
