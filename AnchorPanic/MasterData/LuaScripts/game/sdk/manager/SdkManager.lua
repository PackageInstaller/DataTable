module("sdk.SdkManager", Class.impl("lib.event.EventDispatcher"))

----------------------------SDK响应-----------------------------
-- 设备分辨率变化
DEVICE_DP_CHANGE = "DEVICE_DP_CHANGE"
-- unity和sdk皆已初始化完毕
ALL_INIT_FINISH = "ALL_INIT_FINISH"
-- 登录
SDK_LOGIN = "SDK_LOGIN"
-- 切换账号
SDK_SWITCH_ACCOUNT = "SDK_SWITCH_ACCOUNT"
-- 登出
SDK_LOGOUT = "SDK_LOGOUT"
-- 退出
SDK_EXIT = "SDK_EXIT"
-- 充值回调
SDK_RECHARGE = "SDK_RECHARGE"
-- 分享结果回调
SDK_SHARE = "SDK_SHARE"

----------------------------讯飞SDK响应-----------------------------
-- 讯飞录音开始
SDK_XUNFEI_BEGIN = "SDK_XUNFEI_BEGIN"
-- 讯飞录音出错
SDK_XUNFEI_ERROR = "SDK_XUNFEI_ERROR"
-- 讯飞录音停止
SDK_XUNFEI_END = "SDK_XUNFEI_END"
-- 讯飞录音音量变化
SDK_VOLMU_CHANGE = "SDK_VOLMU_CHANGE"
-- 讯飞录音结果解析完毕
SDK_XUNFEI_RESULT = "SDK_XUNFEI_RESULT"

--构造函数
function ctor(self)
    super.ctor(self)
    self:initData()
end

function initData(self)
    -- sdk的信息数据    
    self.mSdkInfo = nil
    self.mSdkInfoStr = nil
    local deviceInfo = CS.UnityEngine.SystemInfo

    self.mIsEditor = CS.Lylibs.ApplicationUtil.IsEditorRun
    self.mXunFeiAudioReadDir = nil
    self.mXunFeiAudioWriteDir = nil

    self.mDeviceName = deviceInfo.deviceModel
    self.mCpuName = gs.SdkManager:GetCpuName()
    self.mGpuName = deviceInfo.graphicsDeviceName

    self.mIsHarmonyOs = gs.SdkManager:GetIsHarmonyOs() == "1"
    self.mHarmonyOsVersion = gs.SdkManager:GetHarmonyVersion()
    self.mIsSimulator = gs.SdkManager:GetIsSimulator() == "1"
end

-- 获取sdk节点
function getSdkTrans(self)
    local root = gs.GameObject.Find("[LAUNCH]")
    if root then
        return root.transform:Find("SDKMsg")
    end
    return nil
end

-- 检查动态添加的sdk
function checkDynamicSdk(self)
    self:checkPocoSdk()
    self:checkBuglySdk()
    self:checkXunFeiSdk()
    self:checkCosxmlSdk()
end

-- 检查UI自动化测试Poco
function checkPocoSdk(self)
    if(not web.WebManager:isReleaseApp() and web.WebManager.platform ~= web.DEVICE_TYPE.WINDOWS)then
        local sdkTrans = self:getSdkTrans()
        if(sdkTrans)then
            gs.GoUtil.AddComponent(sdkTrans.gameObject, typeof(CS.PocoManager))
        end
    end
end

-- 检查Bugly
function checkBuglySdk(self)
    if(not self.mIsEditor)then
        if(web.WebManager.platform ~= web.DEVICE_TYPE.WINDOWS)then
            print("开始初始化Bugly")
            local buglyAppId = nil
            if(web.WebManager.platform == web.DEVICE_TYPE.ANDROID)then
                buglyAppId = web.__getConfig().bugly_app_id_android
            else
                buglyAppId = web.__getConfig().bugly_app_id_ios
            end
            local isBuglyDebug = web.__getConfig().bugly_is_debug == "1"

            -- 初始化注册
            local tip1 = web.WebManager.branch_type .. "-" .. web.WebManager.platform .. "-" .. web.WebManager.net_type .. "-" .. web.WebManager.channel_id .. "-" .. web.WebManager.sub_channel_id
            local tip2 = web.getFormatVersion(web.WebManager.prefix_version_str, web.WebManager.game_version_name, web.WebManager.pro_svn_version, web.WebManager.art_svn_version)
            local version = web.WebManager.game_version_name
            local userSign = self:getUniqueId()
            local initDelay = 0

            self:buglyConfigDebugMode(isBuglyDebug)
            self:buglyConfigDefault(tip1 .. "（" .. tip2 .. "）", version, userSign, initDelay)
            self:buglyInitWithAppId(buglyAppId)
            self:buglyEnableExceptionHandler()
            print("Bugly初始化完毕")
        end
    end
end

-- 检查讯飞
function checkXunFeiSdk(self)
    if(not self.mIsEditor)then
        print("开始初始化讯飞")
        -- 开始注册讯飞相关回调
        gs.SdkManager:RegisterXunfeiLuaFunc()

        -- 设置讯飞录音文件读取路径
        self.mXunFeiAudioReadDir = gs.PathUtil.GetPersistentAssetsRPath(self:getXunFeiAudioFolder())
        -- 设置讯飞录音文件写入路径
        self.mXunFeiAudioWriteDir = gs.PathUtil.GetPersistentAssetsWPath(self:getXunFeiAudioFolder())
        -- 清理旧的语音文件
        if (gs.Directory.Exists(self.mXunFeiAudioWriteDir)) then
            gs.Directory.Delete(self.mXunFeiAudioWriteDir, true)
        end
        gs.SdkManager:SetXunFeiAudioDir(self.mXunFeiAudioWriteDir)

        print("讯飞音频读取路径：" .. self.mXunFeiAudioReadDir)
        print("讯飞音频写入路径：" .. self.mXunFeiAudioWriteDir)
        print("讯飞初始化完毕")
    end
end

-- 讯飞音频文件总目录，所有相关讯飞生成的音频文件都放到该文件夹
function getXunFeiAudioFolder(self)
    return "voice"
end

-- 获取讯飞本地音频文件可写路径
function getXunFeiAudioName(self, fileName)
    return fileName .. ".pcm"
end

-- 获取讯飞本地音频文件可读路径
function getXunFeiAudioRPath(self, fileName)
    if (fileName == nil) then
        return self.mXunFeiAudioReadDir
    else
        return self.mXunFeiAudioReadDir .. "/" .. self:getXunFeiAudioName(fileName)
    end
end

-- 获取讯飞本地音频文件可写路径
function getXunFeiAudioWPath(self, fileName)
    if (fileName == nil) then
        return self.mXunFeiAudioWriteDir
    else
        return self.mXunFeiAudioWriteDir .. "/" .. self:getXunFeiAudioName(fileName)
    end
end

-- 检查云桶
function checkCosxmlSdk(self)
    if (not self.mIsEditor) then
        local appId = web.__getConfig().cosxml_app_id
        local region = web.__getConfig().cosxml_region
        local bucket = web.__getConfig().cosxml_bucket
        local secretId = web.__getConfig().cosxml_secret_id
        local secretKey = web.__getConfig().cosxml_secret_key
        local isDebug = web.__getConfig().cosxml_is_debug == "1"
        self:cosxmlInit(appId, region, bucket, secretId, secretKey, isDebug)
    end
end

----------------------------------------------------------------------sdk请求----------------------------------------------------------------------
-- 登录（type：0 默认自动登录，1 刷新token重登）
function sdkLogin(self, isDefaultAuto)
    if self.mIsEditor then
        return
    end
    local params = {}
    params.type = isDefaultAuto and 0 or 1
    local jsonObjStr = JsonUtil.encode(params)
    gs.SdkManager:Login(jsonObjStr)
end

-- 注销账号
function destroyAccount(self)
    if self.mIsEditor then
        return
    end
    gs.SdkManager:DestroyAccount("")
end

-- 切换账号
function switchAccount(self)
    if self.mIsEditor then
        return
    end
    gs.SdkManager:SwitchAccount("")
end

-- 登出
function logout(self)
    if self.mIsEditor then
        return
    end
    gs.SdkManager:Logout("")
end

-- serverId	String	服务器id
-- serverName	String	服务器名称
-- platformUId	String	用户平台id，登录成功后获取的
-- roleId	String	角色id
-- roleName	String	角色名称
-- roleLevel	Int	角色等级
-- roleGender	Int	角色性别（0：未知，1：男性，2：女性）
-- vipLevel	Int	Vip等级
-- professionId	String	玩家职业id
-- professionName	String	玩家职业名称
-- professionRoleId	String	玩家职业称号id
-- professionRoleName	String	玩家职业称号
-- roleExp	long	角色总经验
-- roleCTime	long	角色创建时间戳
-- loginTime	long	登录区服的时间戳
-- logoutTime	long	下线的时间戳
-- onlineTime	long	本次登录在线时长
-- guildId	String	工会或帮派id
-- guildName	String	工会或帮派的名称
-- guildLevel	Int	工会或帮派等级
-- guildRoleId	String	所在工会或帮派的称号id
-- guildRoleName	String	所在工会或帮派的称号名称
-- battleStrength	Long	战斗力等衡量角色强弱的属性
-- balanceId	Int	货币id，同样货币可传相同数字。例如都传1
-- roleBalance	Long	该角色的游戏内货币余额
-- roleBalanceName	String	角色的货币名称
function __getSendSdkParamsObj(self, isRoleLvlUp)
    local params = {}
    params.server_id = web.WebManager.server_id
    params.server_name = web.WebManager.server_name
    params.server_create_time = GameManager.openTime or math.floor(web.__getTime())
    params.platform_user_id = web.WebManager.sdk_account_id
    params.role_id = role.RoleManager:getRoleVo().playerId or web.WebManager.login_account_id
    params.role_show_id = role.RoleManager:getRoleVo().showId or web.WebManager.login_account_id
    params.role_name = role.RoleManager:getRoleVo():getPlayerName() or ""
    params.role_lvl = role.RoleManager:getRoleVo():getPlayerLvl() or 0
    params.role_sex = 0
    params.vip_lvl = role.RoleManager:getRoleVo():getPlayerVipLvl() or 0
    params.profession_id = ""
    params.profession_name = ""
    params.role_exp = role.RoleManager:getRoleVo():getPlayerExp() or 0
    params.role_create_time = login.LoginManager.createRoleTime
    params.role_update_time = isRoleLvlUp and math.floor(web.__getTime()) or login.LoginManager.createRoleTime
    params.login_time = web.WebManager.web_login_time
    params.logout_time = GameManager:getClientTime() or math.floor(web.__getTime())
    params.online_time = params.logout_time - web.WebManager.web_login_time
    params.guild_id = ""
    params.guild_name = ""
    params.guild_role_id = ""
    params.guild_role_name = ""
    params.fight_num = 0
    params.money_type = MoneyType.ITIANIUM_TYPE or 0
    params.money_num = MoneyUtil.getMoneyCountByType(MoneyType.ITIANIUM_TYPE) or 0
    params.money_name = MoneyUtil.getMoneyNameByType(MoneyType.ITIANIUM_TYPE) or ""

    local friendDataList = {}
    params.friend_list = friendDataList
    local friendList = friend.FriendManager:getFriendList()
    if (friendList) then
        for i = 1, #friendList do
            local friendVo = friendList[i]
            local friendData = {}
            friendData.friend_role_id = friendVo.id
            friendData.friend_intimacy = "0"
            friendData.friend_relation_id = "6"
            friendData.friend_relation_name = "好友"
            table.insert(friendDataList, friendData)
        end
    end
    return params
end

function __getSendSdkParams(self, isRoleLvlUp)
    local jsonObjStr = JsonUtil.encode(self:__getSendSdkParamsObj(isRoleLvlUp))
    return jsonObjStr
end

-- 通知创角成功
function notifyCreateRoleSuc(self)
    if self.mIsEditor then
        return
    end
    if (login.LoginManager.isFirstCreateRole == true) then
        login.LoginManager.isFirstCreateRole = false
        gs.SdkManager:NotifyCreateRoleSuc(self:__getSendSdkParams(false))
    end
end

-- 通知角色登录服务器成功
function notifyLoginServerSuc(self)
    if self.mIsEditor then
        return
    end
    gs.SdkManager:NotifyLoginServerSuc(self:__getSendSdkParams(false))
end

-- 通知角色升级成功
function notifyRoleLvlUpSuc(self)
    if self.mIsEditor then
        return
    end
    gs.SdkManager:NotifyRoleLvlUpSuc(self:__getSendSdkParams(true))
end

-- 通知角色关卡成功信息
function notifyRoleStagePassSuc(self, chapterId, stageId)
    if self.mIsEditor then
        return
    end
    local params = self:__getSendSdkParamsObj()
    params.chapter = tostring(chapterId)
    params.mission = tostring(stageId)
    local jsonObjStr = JsonUtil.encode(params)
    self:notifyCommonSuc("10005", "角色通关", jsonObjStr)
end

-- 通知引导步骤成功信息
function notifyGuideStpeSuc(self, eventName)
    if self.mIsEditor then
        return
    end
    local params = self:__getSendSdkParamsObj()
    local jsonObjStr = JsonUtil.encode(params)
    self:notifyCommonSuc("10002", eventName, jsonObjStr)
end

-- 通用通知
function notifyCommonSuc(self, eventId, eventName, jsonObjStr)
    if self.mIsEditor then
        return
    end
    gs.SdkManager:NotifyCommonSuc(tostring(eventId), tostring(eventName), jsonObjStr)
end

--------------------------------------------------------------------------------------------------------------------------
-- 通知启动埋点信息：
-- login_req	请求登录SDK
-- login_fail	SDK登录失败
-- srv_login_token_req	开始进行登录二次验证
-- srv_login_token_suc	二次校验成功
-- srv_login_token_fail	二次校验失败
-- config_req	拉取游戏配置表
-- load_ok	游戏资源加载成功
-- load_fail	游戏资源加载失败
-- enter_game	进入游戏
function foreignNotifyStartUp(self, value)
    if self.mIsEditor then
        return
    end
    local params = {}
    params.login_step = tostring(value or "")
    local jsonObjStr = JsonUtil.encode(params)
    self:__foreignNotifyCommonSuc("", "login_data", jsonObjStr)
end

-- 通知加入公会信息
function foreignNotifyJoinGuildSuc(self, guildId)
    if self.mIsEditor then
        return
    end
    local params = self:__getSendSdkParamsObj()
    params.guild_id = tostring(guildId or "")
    local jsonObjStr = JsonUtil.encode(params)
    self:__foreignNotifyCommonSuc("", "join_guild", jsonObjStr)
end

-- 通知游玩PVP信息
-- type = 1 (常规演习进攻）
-- type = 2 (综合对抗赛进攻）
function foreignNotifyPvpInfoSuc(self, type)
    if self.mIsEditor then
        return
    end
    self:foreignNotifyCommonSuc("", "pvp_play", "type", type)
end

-- 通知每日任务活跃点信息
function foreignNotifyDailyScoreSuc(self, score)
    if self.mIsEditor then
        return
    end
    self:foreignNotifyCommonSuc("", "daily_quest", "activeness", score)
end

-- 通知通过关卡成功信息（type和FightConst保持一致）
function foreignNotifyRoleStagePassSuc(self, dupType, chapterId, stageId)
    if self.mIsEditor then
        return
    end
    -- 这里在战斗完会调用到，比较重要所以捕获
    pcall(
        function()
            local params = self:__getSendSdkParamsObj()
            params.type = tostring(dupType or "")
            params.pass_chapter = tostring(chapterId or "")
            params.pass_stage = tostring(stageId or "")
            local jsonObjStr = JsonUtil.encode(params)
            self:__foreignNotifyCommonSuc("", "pass_lv", jsonObjStr)
        end
    )
end

-- 通知充值信息
function foreignNotifyRechargeSuc(self, rechargeId)
    if self.mIsEditor then
        return
    end
    local params = self:__getSendSdkParamsObj()
    params.break_level = tostring(role.RoleManager:getRoleVo():getPlayerLvl() or 0)
    params.break_packid = tostring(rechargeId or "")
    local jsonObjStr = JsonUtil.encode(params)
    self:__foreignNotifyCommonSuc("", "break_pay", jsonObjStr)
end

-- 通知完成抽卡成功信息
function foreignNotifyRecruitSuc(self, isFirst, recruitType, recruitCount, totalRecruitCount)
    if self.mIsEditor then
        return
    end
    local params = self:__getSendSdkParamsObj()
    -- 抽卡类型
    params.draw_type = tostring(recruitType or "")
    -- 1：首次抽卡；0：非首次抽卡
    params.type = isFirst and "1" or "0"
    -- 抽卡次数
    params.number = tostring(recruitCount or "")
    -- 总抽卡次数
    params.total_num = tostring(totalRecruitCount or "")
    local jsonObjStr = JsonUtil.encode(params)
    self:__foreignNotifyCommonSuc("", "pull", jsonObjStr)
end

-- 海外渠道通用通知（单个key-value用）
function foreignNotifyCommonSuc(self, eventToken, eventName, key, value)
    if self.mIsEditor then
        return
    end
    local params = self:__getSendSdkParamsObj()
    params[key or ""] = tostring(value or "")
    local jsonObjStr = JsonUtil.encode(params)
    self:__foreignNotifyCommonSuc(eventToken, eventName, jsonObjStr)
end

-- 海外渠道通用通知（多个key-value整成json用）
function __foreignNotifyCommonSuc(self, eventToken, eventName, jsonObjStr)
    if self.mIsEditor then
        return
    end
    gs.SdkManager:ForeignNotifyCommonSuc(tostring(eventToken or ""), tostring(eventName or ""), jsonObjStr)
end

--------------------------------------------------------------------------------------------------------------------------

-- 获取当前apk是否为版署版本
-- 是则不接充值接口
-- 是则不接用户中心接口
function getIsBranch(self)
    if self.mIsEditor then
        return false
    end
    return gs.SdkManager:GetIsBranch("") == "1"
end

-- 发起sdk支付
-- gameOrderId:游戏的充值订单id，唯一值
-- gameExt:游戏的透传参数，Sdk方会在支付成功后原值传递给游戏（orderId=123#itemId=com.blby.cs1#pf_id=9#channel_id=74）
-- deliveryAddress:透传地址
-- amount:充值金额，double类型的字符串
-- productCode:充值品项的id，Sdk方运营给出商品列表
function pay(self, orderId, deliveryAddress, itemId, itemPrice, itemTitle, itemName, itemDes, isCurrencyProduct)
    if (self:getIsBranch()) then
        print("版署版本无充值")
        return
    end
    local params = {}
    -- androi、ios支付需要以下参数
    --游戏厂商订单号
    params.gameOrderId = orderId
    --游戏自定义参数
    params.gameExt = "orderId=" .. orderId .. "#itemId=" .. itemId .. "#pf_id=" .. web.WebManager.pf_id .. "#channel_id=" .. web.WebManager.channel_id
    --透传地址
    params.deliveryAddress = deliveryAddress or ""
    -- 金额.00f，单位：元（double）
    params.amount = itemPrice
    -- 完整的商品id
    params.accurateProductCode = itemId
    ----后台商品编号，即充值商品id，这里只截取"_"前的一部分
    params.productCode = string.split(itemId, "_")[1]
    -- 商品标题
    params.productTitle = itemTitle or ""
    -- 商品名称
    params.productName = itemName or ""
    -- 商品描述
    params.productDes = itemDes or ""
    -- 是否货币商品
    params.isCurrencyProduct = isCurrencyProduct and "1" or "0"

    --用户id
    params.platform_user_id = web.WebManager.sdk_account_id
    --区ID
    params.server_id = web.WebManager.server_id
    --区名称
    params.server_name = web.WebManager.server_name
    --角色ID
    params.role_id = role.RoleManager:getRoleVo().playerId or web.WebManager.login_account_id
    --角色名称
    params.role_name = role.RoleManager:getRoleVo():getPlayerName() or ""
    --角色名称
    params.role_lvl = tostring(role.RoleManager:getRoleVo():getPlayerLvl()) or ""
    --货币单位
    params.currency = "RMB"

    local jsonObjStr = JsonUtil.encode(params)
    gs.SdkManager:Pay(jsonObjStr)
end

-- 获取功能按钮是否显示
function getSdkButtonEnable(self)
    if self.mIsEditor then
        return
    end

    local sdkBtnEnableDic = {}
    -- 登录账号按钮功能
    sdkBtnEnableDic.loginBtnEnable = false
    -- 切换账号按钮功能
    sdkBtnEnableDic.switchAccountBtnEnable = false
    -- 登出账号按钮功能
    sdkBtnEnableDic.logoutBtnEnable = false
    -- 用户中心按钮功能
    sdkBtnEnableDic.settingBtnEnable = false
    -- 绑定账号按钮功能
    sdkBtnEnableDic.bindAccountBtnEnable = false
    -- 注销按钮
    sdkBtnEnableDic.destroyAccountBtnEnable = false
    -- 客服按钮
    sdkBtnEnableDic.customerBtnEnable = false
    -- 社区按钮
    sdkBtnEnableDic.communityBtnEnable = false

    local sdkButtonEnableJsonStr = gs.SdkManager:GetSdkButtonEnable("")
    local data = JsonUtil.decode(sdkButtonEnableJsonStr)
    if(data)then
        sdkBtnEnableDic.loginBtnEnable = data.loginBtnEnable == "1"
        sdkBtnEnableDic.switchAccountBtnEnable = data.switchAccountBtnEnable == "1"
        sdkBtnEnableDic.logoutBtnEnable = data.logoutBtnEnable == "1"
        sdkBtnEnableDic.settingBtnEnable = data.settingBtnEnable == "1"
        sdkBtnEnableDic.bindAccountBtnEnable = data.bindAccountBtnEnable == "1"
        sdkBtnEnableDic.destroyAccountBtnEnable = data.destroyAccountBtnEnable == "1"
        sdkBtnEnableDic.customerBtnEnable = data.customerBtnEnable == "1"
        sdkBtnEnableDic.communityBtnEnable = data.communityBtnEnable == "1"     
    else
        logInfo("获取功能按钮是否显示数据解析失败", "SdkManager")
    end

    return sdkBtnEnableDic
end

-- 启动Sdk的设置中心界面
function openSdkSettingUI(self)
    if self.mIsEditor then
        return
    end
    gs.SdkManager:OpenSdkSettingUI("")
end

-- 是否允许显示个人中心按钮
function hasUserCenter(self)
    if self.mIsEditor then
        return
    end
    return gs.SdkManager:HasUserCenter() == "1"
end

-- 启动Sdk的用户中心界面
function openSdkUserUI(self)
    if self.mIsEditor then
        return
    end
    if (self:getIsBranch()) then
        print("版属版本无用户中心界面")
        return
    end

    -- 预设邮件基础数据
    -- self:preSetEmailConfig()

    local roleInfoList = {}
    table.insert(roleInfoList, self:__getSendSdkParamsObj())
    local jsonObjStr = JsonUtil.encode(roleInfoList)
    print("启动Sdk的用户中心界面：", jsonObjStr)
    gs.SdkManager:OpenSdkUserUI(jsonObjStr)
end

-- 发起检测并请求android授权
function checkSdkAuthorize(self)
    if self.mIsEditor then
        return
    end
    gs.SdkManager:CheckSdkAuthorize("")
end

-- 发起分享
-- imgPath：要分享的图片的File地址，如果需要使用到SD卡，此处需要先申请SD卡权限
-- title：分享内容的标题
-- des：分享内容
-- linkUrl：https连接，分享出去的卡片，点击后的连接地址，运营提供
function share(self, data)
    if self.mIsEditor then
        return
    end
    local params = {}
    -- params.imgPath = 
    -- params.title = 
    -- params.des = 
    -- params.linkUrl = 
    local jsonObjStr = JsonUtil.encode(params)
    gs.SdkManager:Share(jsonObjStr)
end

-- 获取sdk的信息数据
function getSdkInfo(self)
    if self.mIsEditor then
        return nil
    end
    if(web.WebManager:isReleaseApp())then
        local sdkInfoString = gs.SdkManager:GetSdkInfo("")
        if (self.mSdkInfoStr ~= sdkInfoString) then
            local okFun = function(data)
                self.mSdkInfo = data
                self.mSdkInfoStr = sdkInfoString
                print("获取sdk信息数据解析成功：" .. CS.Lylibs.UTF8StringUtil.GetString(sdkInfoString))
            end
            local errFun = function()
                self.mSdkInfo = nil
                self.mSdkInfoStr = nil
                print("WebManager", "获取sdk信息数据解析出错：", sdkInfoString)
            end
            web.tryParseJson(sdkInfoString, okFun, errFun)
        end
    end
    return self.mSdkInfo
end

-- 接近于设备id
function getUniqueId(self)
    local id = ""
    -- 使用sdk提供的唯一id
    local sdkInfo = sdk.SdkManager:getSdkInfo()
    if (sdkInfo) then
        id = sdkInfo.uniqueId
    end
    -- sdk拿到空的话，取用自己写的方法获取id
    if(id == "")then
        id = gs.SdkManager:GetUniqueId()
    end
    return id
end

-- 跳转外部浏览器网页页面
function jumpBrowserWebView(self, webUrl)
    if self.mIsEditor then
        gs.SdkManager:LaunchUrlDetail(webUrl)
        return ""
    end
    local params = {}
    params.webUrl = webUrl
    local jsonObjStr = JsonUtil.encode(params)
    return gs.SdkManager:JumpBrowserWebView(jsonObjStr)
end

-- 打开sdk样式的网页界面（目前pc有效，安卓和ios等sdk提供接口）
function openSDKUIBrowser(self, webUrl)
    if self.mIsEditor then
        return ""
    end
    local params = {}
    params.webUrl = webUrl
    local jsonObjStr = JsonUtil.encode(params)
    return gs.SdkManager:OpenSDKUIBrowser(jsonObjStr)
end

-- 打开网页页面（左上角为锚点）
-- webIdStr：网页唯一标识字符串
function openWebView(self, webIdStr, webUrl, parentTrans, posX, posY, width, height)
    if self.mIsEditor then
        return ""
    end
    -- 保留两位小数
    posX = posX - posX % 0.01
    posY = posY - posY % 0.01
    width = width - width % 0.01
    height = height - height % 0.01
    local screenW, screenH = ScreenUtil:getScreenSize()
    local params = {}
    params.webId = webIdStr
    params.webUrl = webUrl
    params.posX = posX or 0
    params.posY = posY or 0
    params.width = width or screenW
    params.height = height or screenH
    local jsonObjStr = JsonUtil.encode(params)
    return gs.SdkManager:OpenWebView(jsonObjStr, parentTrans)
end

-- 隐藏网页页面
-- webIdStr：网页唯一标识字符串
function hideWebView(self, webIdStr)
    if self.mIsEditor then
        return ""
    end
    local params = {}
    params.webId = webIdStr
    local jsonObjStr = JsonUtil.encode(params)
    return gs.SdkManager:HideWebView(jsonObjStr)
end

-- 关闭网页页面（列表）
-- webIdStr：网页唯一标识字符串
function closeWebView(self, ...)
    if self.mIsEditor then
        return ""
    end
    local webIdListStr = ""
    local webIdList = { ... }
    for i = 1, #webIdList do
        if (i == 1) then
            webIdListStr = webIdList[i]
        else
            webIdListStr = webIdListStr .. "_" .. webIdList[i]
        end
    end
    local params = {}
    params.webIdList = webIdListStr
    local jsonObjStr = JsonUtil.encode(params)
    return gs.SdkManager:CloseWebView(jsonObjStr)
end

-- 获取是否显示一键加QQ群
function getIsShowJoinQQGroup(self)
    if self.mIsEditor then
        return
    end
    return gs.SdkManager:GetIsShowJoinQQGroup() == "1"
end

-- 调用一键加QQ群并返回结果
function getJoinQQGroup(self)
    if self.mIsEditor then
        return
    end
    return gs.SdkManager:GetJoinQQGroup() == "1"
end

-- 检测是否有权限
function checkPermission(self, permission)
    if self.mIsEditor then
        return
    end
    return gs.SdkManager:CheckPermission(permission)
end

-- 检测是否有权限，没有则请求授权
function checkAndRequestPermission(self, permission, strTitle, strMsg, strOk, strCancel, successTip, failTip)
    if self.mIsEditor then
        return
    end
    gs.SdkManager:CheckAndRequestPermission(permission, strTitle, strMsg, strOk, strCancel, successTip, failTip)
end

-- 成就上报
function reachAchievement(self, achievementId)
    if self.mIsEditor then
        return
    end
    local params = {}
    params.achievementId = achievementId
    local jsonObjStr = JsonUtil.encode(params)
    gs.SdkManager:ReachAchievement(jsonObjStr)
end

-- 预设邮件基础数据
-- email_title: 邮件标题
-- game_version: 游戏内资源版本号
-- to_recipients_list: 发送给收件人
-- cc_recipients_list: 抄送给收件人
function preSetEmailConfig(self)
    if self.mIsEditor then
        return
    end
    if(self:getIsBranch())then
        print("版属版本无用户中心界面，不需预设邮件基础数据")
        return
    end

    local emailConfig = {}
    emailConfig.email_title = _TT(10000002) --"《錨點降臨》用戶問題詢問"
    emailConfig.game_version = web.WebManager.game_version_name
    emailConfig.to_recipients_list = {"sonetapc@so-net.net.tw"}
    emailConfig.cc_recipients_list = {}
    local jsonObjStr = JsonUtil.encode(emailConfig)
    gs.SdkManager:PreSetEmailConfig(jsonObjStr)
end

-- 获取一些设备信息
function getDeviceData(self)
    return self.mDeviceName, self.mCpuName, self.mGpuName
end

-- 获取鸿蒙系统数据
function getHarmonyOsData(self)
    return self.mIsHarmonyOs, self.mHarmonyOsVersion
end

-- 获取是否模拟器系统
function getIsSimulator(self)
    return self.mIsSimulator
end

-- 获取剩余空间MB大小（单位MB，向下取整）
function getFreeDiskSpaceMB(self)
    return gs.SdkManager:GetFreeDiskSpaceMB("")
end

-----------------------------------------------------------------Bugly调用---------------------------------------------------------------------
-- 开启SDK的日志打印，发布版本请务必关闭（为true是，输出详细的Bugly SDK的Log；每一条Crash都会被立即上报；自定义日志将会在Logcat中输出）
function buglyConfigDebugMode(self, isDebug)
    gs.BuglyAgent.ConfigDebugMode(isDebug)
end

-- 初始化Bugly的appId
function buglyInitWithAppId(self, appId)
    gs.BuglyAgent.InitWithAppId(appId)
end

-- 如果确认已在对应的iOS工程或Android工程中初始化SDK，那么在脚本中只需启动C#异常捕获上报功能即可
function buglyEnableExceptionHandler(self)
    gs.BuglyAgent.EnableExceptionHandler()
end

-- 该方法在初始化之前调用
-- 渠道号：默认值为空，
-- 版本：版本默认值(Android应用默认读取AndroidManifest.xml中的android:versionName；iOS应用默认读取Info.plist文件中CFBundleShortVersionString和CFBundleVersion，拼接为CFBundleShortVersionString(CFBundleVersion)格式，例如1.0.1(10))
-- 用户标识：默认值为Unknown
-- Android初始化延时时间：默认为0，单位毫秒
function buglyConfigDefault(self, channel, version, user, delay)
    gs.BuglyAgent.ConfigDefault(channel, version, user, delay or 0)
end

-- 如果确认已在对应的iOS工程或Android工程中初始化SDK，那么在脚本中只需启动C#异常捕获上报功能即可
function buglySetUserId(self, userId)
    gs.BuglyAgent.SetUserId(userId)
end

-----------------------------------------------------------------云桶调用---------------------------------------------------------------------
-- 云桶初始化
function cosxmlInit(self, appId, region, bucket, secretId, secretKey)
    gs.COSXMLMgr:Init(appId, region, bucket, secretId, secretKey)
end

-- 云桶上传
function cosxmlPutObject(self, serverFilePath, clientFilePath, progressCall, upLoadResultCall)
    serverFilePath = "voice/" .. web.WebManager.net_type .. "/" .. serverFilePath
    return gs.COSXMLMgr:PutObject(serverFilePath, clientFilePath, progressCall, upLoadResultCall)
end

-- 云桶下载
function cosxmlGetObject(self, serverFilePath, fileDir, fileName, progressCall, downLoadResultCall)
    serverFilePath = "voice/" .. web.WebManager.net_type .. "/" .. serverFilePath
    gs.COSXMLMgr:GetObject(serverFilePath, fileDir, fileName, progressCall, downLoadResultCall)
end

-- 云桶删除资源
function cosxmlDeleteObject(self, serverFilePath)
    serverFilePath = "voice/" .. web.WebManager.net_type .. "/" .. serverFilePath
    gs.COSXMLMgr:DeleteObject(serverFilePath)
end

--------------------------------------------------------------------sdk回调----------------------------------------------------------------------
-- 登录回调
function parseLogin(self, msg)
    logInfo("sdk_login: " .. msg, "SdkManager")
    self:dispatchEvent(self.SDK_LOGIN, msg)
end

-- 切换账号回调
function parseSwitchAccount(self, msg)
    self:dispatchEvent(self.SDK_SWITCH_ACCOUNT, msg)
end

-- 登出回调
function parseLogout(self, msg)
    local data = JsonUtil.decode(msg)
    if (data) then
        self:dispatchEvent(self.SDK_LOGOUT, tonumber(data.isSuccess) == 1)
    else
        logInfo("登出回调参数解析失败", "SdkManager")
    end
end

-- 退出回调（比如防沉迷时sdk界面逻辑触发，我方执行数据保存和关闭）
function parseExit(self, msg)
    local data = JsonUtil.decode(msg)
    -- sdk：确认退出为1，再玩一玩为0
    if (data and tonumber(data.isSuccess) == 1) then
        self:dispatchEvent(self.SDK_EXIT, true)
    else
        logInfo("退出回调参数解析失败", "SdkManager")
    end
end

-- 充值回调
function parsePay(self, msg)
    local data = JsonUtil.decode(msg)
    if (data) then
        self:dispatchEvent(self.SDK_RECHARGE, data)
    else
        logInfo("充值回调参数解析失败", "SdkManager")
        self:dispatchEvent(self.SDK_RECHARGE, nil)
    end
end

-- 分享结果回调
function parseShare(self, msg)
    if (msg == 0) then
        gs.Message.Show("分享失败")
    elseif (msg == 1) then
        gs.Message.Show("分享成功")
    elseif (msg == 2) then
        gs.Message.Show("分享取消成功")
    end
    self:dispatchEvent(self.SDK_SHARE, msg)
end

-- 耳机状态回调
function headphoneState(self, msg)
    if (msg) then
        if msg == 1 or msg == "1" then -- 连上耳机
            gs.AudioManager:ChangeMixerSnapshot(0)
            print("耳机快照模式")
        else
            if gs.Application.platform == gs.RuntimePlatform.Android then
                gs.AudioManager:ChangeMixerSnapshot(1)
                print("Android扩音快照模式")
            else
                gs.AudioManager:ChangeMixerSnapshot(2)
                print("IOS扩音快照模式")
            end
        end
    else
        logInfo("耳机状态回调回调参数解析失败", "SdkManager")
    end
end

----------------------------------------------------------------------讯飞回调----------------------------------------------------------------------
-- 录音机已经准备好了，用户可以开始语音输入
function parseXunFeiBegin(self, msg)
    logInfo("录音机已经准备好了，用户可以开始语音输入", msg)
    self:dispatchEvent(self.SDK_XUNFEI_BEGIN, {})
end

-- 录音错误码
function parseXunFeiError(self, msg)
    logWarn("讯飞录音错误码：" .. msg, self.__cname)
    if (msg == "10118") then
        gs.Message.Show(_TT(10000341))
    elseif (msg == "20004") then
        gs.Message.Show(_TT(10000340))
    elseif (msg == "20006") then
        gs.Message.Show(_TT(10000339))
    elseif (msg == "22002") then
        gs.Message.Show("")
    elseif (msg == "22003") then
        gs.Message.Show("")
    end
    self:dispatchEvent(self.SDK_XUNFEI_ERROR, {})
end

-- 检测到了语音的尾端点，已经进入识别过程，不再接受语音输入
function parseXunFeiEnd(self, msg)
    logInfo("检测到了语音的尾端点，已经进入识别过程，不再接受语音输入：" .. msg, self.__cname)
    self:dispatchEvent(self.SDK_XUNFEI_END, {})
end

-- 语音解析完毕
function parseXunFeiResult(self, msg)
    local paramsList = string.split(msg, '&')
    local voiceContent = paramsList[1]
    local voicePath = paramsList[2]
    local voiceFileName = paramsList[3]

    logInfo(string.format("音频内容：%s", voiceContent), self.__cname)
    logInfo(string.format("音频路径：%s", voicePath), self.__cname)
    logInfo(string.format("音频文件名：%s", voiceFileName), self.__cname)

    self:dispatchEvent(self.SDK_XUNFEI_RESULT, { voiceContent = voiceContent, voiceFileName = voiceFileName })
end

-- 录入的音量变化
function parseXunFeiVolume(self, msg)
    local volume = msg
    -- logInfo("录入的音量变化："..volume, self.__cname)
    -- gs.Message.Show("(录入的音量变化")
    self:dispatchEvent(self.SDK_VOLMU_CHANGE, { volume = volume })
end

-- 事件回调
function parseXunFeiEvent(self, msg)
    logWarn("事件回调码：" .. msg, self.__cname)
    if (msg == "10008") then
        gs.Message.Show(_TT(10000340))
    elseif (msg == "10114") then
        gs.Message.Show(_TT(10000342))
    elseif (msg == "10118") then
        gs.Message.Show(_TT(10000340))
    elseif (msg == "20004")then
        gs.Message.Show(_TT(10000340))
    end
end

return _M


--[[ 替换语言包自动生成，请勿修改！
]]