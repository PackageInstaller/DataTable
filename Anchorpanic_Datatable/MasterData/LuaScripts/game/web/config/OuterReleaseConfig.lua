return {

    -------------------------------------------------- server-manager-api-mdjl --------------------------------------------------
    -- 获取服务器相关信息
    ["server_info"] = "https://server-manager-api-mdjl.leiyangame.com/ApiServerInfo/getSrvInfo/g/12",
    -- 获取指定服或推荐服（没有选服界面）
    ["recommand_server_info"] = "https://server-manager-api-mdjl.leiyangame.com/ApiServer/pfRecommendSrvList/g/12",

    -------------------------------------------------- 文件上传后台 --------------------------------------------------
    -- 玩家信息手机地址（这里做个备忘）：https://web-gms-api-mdjl.leiyangame.com/Api/GameReport/collectInfo/g/12
    -- 文件上传地址
    ["upload_file_url"] = "https://report.maodiangame.com/report/file/errorMsg",
    -- 文件实时上传地址
    ["upload_real_time_url"] = "https://web-gms-api-mdjl.leiyangame.com/Api/GameReport/gameReportRealtime/g/12",
    -- 文件上传类型地址
    ["get_upload_type_url"] = "https://web-gms-api-mdjl.leiyangame.com/Api/GameReport/checkCollect/g/12",

    -------------------------------------------------- web-gms-api-mdjl --------------------------------------------------
    -- 渠道cdn资源更新类型
    ["check_channel_update_type"] = "https://web-gms-api-mdjl.leiyangame.com/Api/ClientServer/checkChannelAllUpdate/g/12",
    -- 通用参数统计
    ["generic_args_url"] = "https://web-gms-api-mdjl.leiyangame.com/ClientServer/genericArgs/g/12",

    -- 获取服务器列表
    -- ["server_list"] = "https://web-gms-api-mdjl.leiyangame.com/ApiServer/getPfSrvList/g/3",
    -- 获取登录公告多栏目
    ["bulletin_list_url"] = "https://web-gms-api-mdjl.leiyangame.com/Api/Bulletin/getLoginBulletins/g/12",
    -- 上报步骤统计
    ["report_step_url"] = "https://web-gms-api-mdjl.leiyangame.com/Api/ClientServer/loginStepLogs/g/12",
    -- -- 上报步骤加载时长统计
    -- ["report_step_loading_time_url"] = "",
    -- bug统计
    ["bug_url"] = "https://web-gms-api-mdjl.leiyangame.com/Api/ClientServer/clientBugLogs/g/12",
    -- 获取QQ客服
    ["qq_service_url"] = "https://web-gms-api-mdjl.leiyangame.com/Bulletin/getCustomerServiceQq/g/12",
    -- -- 获取VIP客服
    -- ["vip_service_url"] = "",
    
    -- 获取IP地址
    ["get_ip"] = "https://web-gms-api-mdjl.leiyangame.com/Api/IpInfo/getClientIP/g/12",

    -- 获取资源密钥（本处改动需同步发布机）
    ["get_ab_key"] = "https://web-gms-api-mdjl.leiyangame.com/WebKeyConfig/getWebKeyConfig/g/12",

    -- 客户端debug登录权限
    ["client_auth_login"] = "https://web_gms_api_test.leiyangame.com/Api/ClientServer/checkClientAuthLogin/g/12",

    -------------------------------------------------- sdk-app-mdjl --------------------------------------------------
    -- 获取token
    ["token_url"] = "https://sdk-app-mdjl.leiyangame.com/User/Login/g/12",
    -- 获取玩家账号信息
    ["player_info_url"] = "",
    -- 请求订单充值
    ["recharge_order_url"] = "https://sdk-app-mdjl.leiyangame.com/Pay/order/g/12/pf/",

    -- 公共key（本处改动需同步发布机）
    ["common_key"] = "*%iUsaGtnKY2",

    -------------------------------------------------- bugly sdk --------------------------------------------------
    -- bugly 是否debug模式，是则会实时上报日志
    ["bugly_is_debug"] = "0",
    -- bugly appId
    ["bugly_app_id_ios"] = "14b6287881",
    ["bugly_app_id_android"] = "5627c7ebc5",

    -------------------------------------------------- 云桶 sdk --------------------------------------------------
    -- 云桶 账户的账户标识
    ["cosxml_app_id"] = "1302431716",
    -- 云桶 所在地域
    ["cosxml_region"] = "ap-guangzhou",
    -- 云桶 名字：格式：BucketName-AppId
    ["cosxml_bucket"] = "laoqb-voice-1302431716",
    -- 云桶 SecretId
    ["cosxml_secret_id"] = "AKIDz57wWsxoRuBBuMjpfEZeU5RYQ2TFm4kQ",
    -- 云桶 SecretKey
    ["cosxml_secret_key"] = "XnmXt76rQmunSxFG2ZqsgKlyvc5JWaR6",
    -- 云桶 是否debug模式
    ["cosxml_is_debug"] = "0",
}
 
--[[ 替换语言包自动生成，请勿修改！
]]
