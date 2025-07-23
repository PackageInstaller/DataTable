-- bug缓存类型标记
web.BUG_CACHE_TYPE = {
    WEB = "WEB",
    SOCKET = "SOCKET",
    LOGIN = "LOGIN",
    DEBUG = "DEBUG",

    UPDATE_DOWN_LOAD = "UPDATE_DOWN_LOAD",
}

-- 添加bug缓存
web.ADD_BUG_CACHE = function(tag, content)
    if(tag ~= nil and content ~= nil)then
        if(not web.WEB_REPORT_BUG_CACHE)then
            web.WEB_REPORT_BUG_CACHE = {}
        end
        local tagDic = web.WEB_REPORT_BUG_CACHE
        local contentList = tagDic[tag]
        if(not contentList)then
            contentList = {}
            tagDic[tag] = contentList
        end
        local result = table.indexof(contentList, content)
        if(result == false)then
            table.insert(contentList, content)
            return true
        end
    end
    return false
end

-- 删除bug缓存
web.DEL_BUG_CACHE = function(tag, content)
    if(not tag)then
        return
    end
    if(web.WEB_REPORT_BUG_CACHE)then
        local tagDic = web.WEB_REPORT_BUG_CACHE
        if(content)then
            local contentList = tagDic[tag]
            if(contentList)then
                local result = table.indexof(contentList, content)
                if(result ~= false)then
                    table.remove(contentList, result)
                end
            end
        else
            tagDic[tag] = nil
        end
    end
end

-- 获取bug缓存列表
web.GET_BUG_CACHE = function(tag)
    if(not tag)then
        return
    end
    if(web.WEB_REPORT_BUG_CACHE)then
        local tagDic = web.WEB_REPORT_BUG_CACHE
        return tagDic[tag]
    end
end

-- 删除所有bug缓存
web.DEL_ALL_BUG_CACHE = function(tag, content)
    web.WEB_REPORT_BUG_CACHE = {}
end

-- 设置上报步骤时间戳缓存
web.SET_REPORT_STEP_TIME_CACHE = function(stepValue, time)
    if(not web.WEB_REPORT_STEP_TIME_CACHE)then
        web.WEB_REPORT_STEP_TIME_CACHE = {}
    end
    if(stepValue ~= nil and time ~= nil)then
        -- 更新当前步骤的前一步骤记录
        web.UPDATE_PREV_STEP_VALUE(stepValue)
        -- 缓存当前步骤的时间戳
        web.WEB_REPORT_STEP_TIME_CACHE[stepValue] = time
        -- Debug:log_error("上报步骤时间戳缓存", string.format("成功设置步骤 %s 时间戳: %s", stepValue, time))
    end
end

-- 更新当前步骤的前一步骤记录
web.UPDATE_PREV_STEP_VALUE = function(nowValue)
    -- -- 直接遍历求全部步骤的各自对应前一步骤
    -- if(not web.WEB_REPORT_STEP_PREV_CACHE)then
    --     web.WEB_REPORT_STEP_PREV_CACHE = {}
    --     for nowStep, nowValue in pairs(web.REPORT_STEP)do
    --         local prevStep = web.WEB_REPORT_STEP_PREV_CACHE[nowStep]
    --         for searchStep, searchValue in pairs(web.REPORT_STEP)do
    --             if(nowStep ~= searchStep)then
    --                 if(prevStep == nil)then
    --                     if(searchValue < nowValue)then
    --                         prevStep = searchStep
    --                     end
    --                 else
    --                     if(searchValue < nowValue and searchValue > web.REPORT_STEP[prevStep])then
    --                         prevStep = searchStep
    --                     end
    --                 end
    --             end
    --         end
    --         web.WEB_REPORT_STEP_PREV_CACHE[nowStep] = prevStep
    --     end
    -- end
    if(not web.WEB_REPORT_STEP_VALUE_PREV_CACHE)then
        web.WEB_REPORT_STEP_VALUE_PREV_CACHE = {}
    end
    local prevValue = web.WEB_REPORT_STEP_VALUE_PREV_CACHE[nowValue]
    if(not prevValue)then
        for searchStep, searchValue in pairs(web.REPORT_STEP)do
            if(nowValue ~= searchValue)then
                if(prevValue == nil)then
                    if(searchValue < nowValue)then
                        -- 检验否合法性，理应在当前步骤就已经缓存
                        if(web.WEB_REPORT_STEP_TIME_CACHE[searchValue])then
                            prevValue = searchValue
                        end
                    end
                else
                    if(searchValue < nowValue and searchValue > prevValue)then
                        -- 检验否合法性，理应在当前步骤就已经缓存
                        if(web.WEB_REPORT_STEP_TIME_CACHE[searchValue])then
                            prevValue = searchValue
                        end
                    end
                end
            end
        end
        web.WEB_REPORT_STEP_VALUE_PREV_CACHE[nowValue] = prevValue
    end
end

-- 获取上报步骤时间戳缓存
web.GET_REPORT_STEP_TIME_CACHE = function(stepValue)
    if(web.WEB_REPORT_STEP_TIME_CACHE)then
        return web.WEB_REPORT_STEP_TIME_CACHE[stepValue] or 0
    end
    return 0
end

-- 获取上报步骤时间戳与前一步骤时间戳的相隔时长
web.GET_REPORT_STEP_PREV_TIMES = function(stepValue)
    local deltaTime = 0
    if(stepValue <= web.REPORT_STEP.UNITY_INIT_FINISH)then
        return 0
    else
        local prevStepValue = web.WEB_REPORT_STEP_VALUE_PREV_CACHE[stepValue]
        if(web.GET_REPORT_STEP_TIME_CACHE(prevStepValue) > 0)then
            deltaTime = web.GET_REPORT_STEP_TIME_CACHE(stepValue) - web.GET_REPORT_STEP_TIME_CACHE(prevStepValue)
        end
    end
    -- Debug:log_error("上报步骤时间戳缓存", string.format("步骤 %s 与前一步骤 %s 的间隔时间为: %s", stepValue, prevStepValue, deltaTime))
    return deltaTime
end

-- 客户端类型（加载不同web配置）
web.NET_TYPE = {
    -- 内网
    INNER = 'inner',
    -- 外网测试
    OUTER_TEST = 'outer_test',
    -- 外网正式
    OUTER_RELEASE = 'outer_release',
}

-- 设备运行平台类型（和游戏配置一致）
web.DEVICE_TYPE = {
    WINDOWS = 'windows',
    ANDROID = 'android',
    IOS = 'ios',
}

-- 设备平台类型（和web写死一致 0：通用 1：安卓 2：ios 3：pc，发给后端用到的同此)
web.GetDeviceCode = function(deviceType)
    if(deviceType == web.DEVICE_TYPE.WINDOWS)then
        return 3
    elseif(deviceType == web.DEVICE_TYPE.ANDROID)then
        return 1
    elseif(deviceType == web.DEVICE_TYPE.IOS)then
        return 2
    else
        return 0
    end
end

web.MODE_TYPE = {
    DEBUG = 'debug',
    RELEASE = 'release',
}

-- 相关节点的异常提示码
web.TIP_CODE = {
    -- 获取推荐服网络异常
    RECOMMEND_SERVER_NET_ERROR = 0,
    -- 获取CDN网络异常
    CDN_NET_ERROR = 1,
    -- 获取登录Token网络异常
    LOGIN_TOKEN_NET_ERROR = 2,
    -- CDN异常
    CDN_ERROR = 3,
    -- 获取游戏服登录token异常
    GAME_LOGIN_TOKEN_ERROR = 4,
    -- 获取推荐服异常
    RECOMMEND_ERROR = 5,
    -- 登录时获取推荐服异常
    LOGIN_RECOMMEND_ERROR = 6,
    -- 获取cdn资源更新类型异常
    CDN_UPDATE_TYPE_ERROR = 7
}

-- 获取游戏服登录Token异常子码
web.GAME_LOGIN_TOKEN_SUB_CODE = {
    -- 正常
    NORMAL = 1,
    -- 返回内容为空
    JSON_EMPTY = 2,
    -- 返回内容解析失败或者没有指定字段
    PARSE_FAIL = 3,
    -- 返回状态为0
    STATUS_ZERO = 4,
    -- 指定的字段都找不到
    ALL_FIELD_EMPTY = 5,
    -- 内容为Html
    HTML_CONTENT = 6
}

-- 获取推荐服异常子码
web.RECOMMEND_SUB_CODE = {
    -- 正常
    NORMAL = 1,
    -- 返回内容为空
    JSON_EMPTY = 2,
    -- 返回内容解析失败或者没有指定字段
    PARSE_FAIL = 3,
    -- 返回状态为0
    STATUS_ZERO = 4,
    -- 返回来服务器列表为空
    SERVER_LIST_EMPTY = 5,
    -- 内容为Html
    HTML_CONTENT = 6
}

-- 获取cdn资源更新类型异常子码
web.CDN_UPDATE_TYPE_SUB_CODE = {
    -- 正常
    NORMAL = 1,
    -- 返回内容为空
    JSON_EMPTY = 2,
    -- 返回内容解析失败或者没有指定字段
    PARSE_FAIL = 3,
    -- 返回状态为0
    STATUS_ZERO = 4,
    -- 指定的字段都找不到
    ALL_FIELD_EMPTY = 5,
    -- 内容为Html
    HTML_CONTENT = 6
}

web.REPORT_STEP = {
    -- Unity初始化完毕
    UNITY_INIT_FINISH = 20,
    -- 游戏开始请求资源密钥
    START_REQ_AB_KEY = 21,
    -- 游戏开始进入初始逻辑
    START = 22,
    -- 进入更新界面
    OPEN_UPDATE_RES_VIEW = 30,

    -- 请求CDN地址
    REQ_CDN_URL = 50,
    -- CDN地址返回数据解析
    CDN_URL_PARSE = 60,
    -- CDN地址获取成功
    GET_CDN_URL_SUC = 70,

    -- 更新模块初始化
    UPDATE_MODEL_INIT = 80,
    -- 读取客户端版本配置
    READ_CLIENT_VERSION = 90,
    -- 读取CDN版本配置
    READ_CDN_VERSION = 100,
    -- 版本号比较
    COMPARE_VERSION = 110,
    -- 读取资源配置
    READ_ASSETS_FILE = 120,
    -- 资源差异对比完毕
    COMPARE_ASSETS_FINISH = 130,
    -- 资源更新完毕
    DOWNLOAD_ASSETS_FINISH = 140,
    -- 保存客户端版本配置完毕
    SAVE_VERSION_FINISH = 150,
    -- 更新模块检查完毕
    UPDATE_MODULE_FINISH = 160,

    -- 开始预加载资源
    PRE_LOAD_ASSETS = 170,
    -- 预加载资源成功
    PRE_LOAD_ASSETS_SUC = 180,
    -- 开始预加载场景
    PRE_LOAD_SCENE = 190,
    -- 预加载场景成功
    PRE_LOAD_SCENE_SUC = 200,

    -- 准备打开登录界面
    READY_OPEN_LOGIN_VIEW = 210,
    -- 登录界面资源加载成功
    LOAD_LOGIN_VIEW_SUC = 220,
    -- 进入登录界面成功
    SHOW_LOGIN_VIEW_SUC = 230,

    -- 请求SDK账号登录
    REQ_SDK_ACCOUNT_LOGIN = 240,
    -- SDK账号返回数据解析
    SDK_ACCOUNT_DATA_PARSE = 250,
    -- SDK账号登录成功
    SDK_ACCOUNT_LOGIN_SUC = 260,

    -- 请求游戏服登录token
    REQ_GAME_LOGIN_TOKEN = 270,
    -- 游戏服登录token返回数据解析
    GAME_LOGIN_TOKEN_PARSE = 280,
    -- 游戏服登录token获取成功
    GET_GAME_LOGIN_TOKEN_SUC = 290,

    -- 请求游戏推荐服
    REQ_RECOMMENT_SERVER_LIST = 300,
    -- 游戏推荐服返回数据解析
    RECOMMENT_SERVER_LIST_PARSE = 310,
    -- 游戏推荐服获取成功
    GET_RECOMMENT_SERVER_LIST_SUC = 320,

    -- 点击开始游戏
    CLICK_START_BTN = 330,
    -- socket连接成功
    SOCKET_CONNECT_SUC = 340,
    -- 游戏服登录成功
    SERVER_LOGIN_SUC = 350,
    -- 通知服务器角色进入游戏
    NOTIFY_ENTER_GAME = 360,
    --开始游戏
    GAME_START = 370
}

-- 通用参数统计接口类型（和后台对应）
web.GENERIC_ARGS_REPORT_TYPE = {
    -- 冷启动
    COLD_STAR_UP = 2,
    -- 选择画质
    QUALITY_SELECTION = 3,
    -- 自动配置画质
    AUTO_CONFIG_QUALITY = 4,
    -- 显示登录界面完整内容
    FULL_ACTIVE_LOGIN_VIEW = 5,
    -- 超过3s没有点击登录
    FULL_ACTIVE_LOGIN_VIEW_STAY_TIME_OUT = 6,
    -- 点击登录1（正常登录）
    CLICK_LOGIN_1 = 7,
    -- 点击登录2（游戏内退出到游戏外重新sdk登录）
    CLICK_LOGIN_2 = 8,
    -- 点击登录3（sdk被中断重新sdk登录）
    CLICK_LOGIN_3 = 9,
    -- 渠道包玩家在热更界面选择是否热更全部资源的比例
    CHANNEL_SELECT_ALL_UPDATE = 10
}

-- 执行实时消息发送（该方法流程里不能加打印，避免死循环了）
web.sendRealTimeContent = function(content)
    local url, parasmDic = web.getUploadRealTimeUrl(content)
    local correctCall = function(self, webData, jsonObj)
        -- 这里不能加打印，避免死循环了
    end
    local errorCall = function(self, errorData, jsonObj)
        -- 这里不能加打印，避免死循环了
    end
    WebInterfaceUtil:postAsyncLoop(url, parasmDic, correctCall, errorCall, web.WebManager, 1)
end

web.DEBUG_LOG_COLLECT_TYPE = {
    NONE = "NONE",
    -- 自动实时上报
    AUTO_REAL_TIME_UPLOAD = "AUTO_REAL_TIME_UPLOAD",
    -- 开启详细下载日志打印
    OPEN_DETAIL_DOWNLOAD_LOG = "OPEN_DETAIL_DOWNLOAD_LOG",
    -- 手动上报
    MANUAL_FILE_UPLOAD = "MANUAL_FILE_UPLOAD",
    -- 内网包开启log界面
    PRIVATE_INNER_DEBUG_LOG_SHOW = "PRIVATE_INNER_DEBUG_LOG_SHOW",
}
web.setLogCollectType = function(type)
	if(type == web.DEBUG_LOG_COLLECT_TYPE.AUTO_REAL_TIME_UPLOAD)then
        -- CS.Lylibs.LogManager.waitMS = 1000
        CS.Lylibs.LogManager.Instance.OnLogsFallback = web.sendRealTimeContent
    else
        CS.Lylibs.LogManager.Instance.OnLogsFallback = nil
    end
    StorageUtil:saveString0('DEBUG_LOG_COLLECT_TYPE', type)
end
web.getLogCollectType = function()
    local temp = StorageUtil:getString0('DEBUG_LOG_COLLECT_TYPE')
    if(temp == "")then
        temp = web.DEBUG_LOG_COLLECT_TYPE.NONE
    end
    return temp
end

--[[ 替换语言包自动生成，请勿修改！
]]
