

-- 讯飞的一些状态常量
sdk.XunFeiState = {
    -- 无
    None = 1,
    -- 请求开始录音
    ReqBegin = 2,
    -- 开始录音
    ResBegin = 3,
    -- 出错
    ResError = 4,
    -- 请求停止录音
    ReqEnd = 5,
    -- 请求取消录音
    ReqCancel = 6,
    -- 停止录音
    ResEnd = 7,
    -- 录音解析完毕
    ResResult = 8,
}

-- 讯飞参数的一些常量
sdk.XunFeiParam = {
    -- 录音时长：毫秒，不超过60000
    speechTimes = "30000", 
    Language = "zh_cn", 
    SampleRate = "8000", 
    Ptt = "1", 
    VadBos = "5000", 
    VadEos = "5000",
}

-- 安卓权限定义
sdk.AndroidPermission = {
    RECORD_AUDIO = "android.permission.RECORD_AUDIO",
    CAMERA = "android.permission.CAMERA",
}

-- 安卓内存警告类型，与安卓定义的一致
sdk.AndroidMemoryWarn = {
    TRIM_MEMORY_COMPLETE = 80,
    TRIM_MEMORY_MODERATE = 60,
    TRIM_MEMORY_BACKGROUND = 40,
    TRIM_MEMORY_UI_HIDDEN = 20,
    TRIM_MEMORY_RUNNING_CRITICAL = 15,
    TRIM_MEMORY_RUNNING_LOW = 10,
    TRIM_MEMORY_RUNNING_MODERATE = 5
}

sdk.AndroidChannelId = {
    -- 无
    NONE = 1,
    -- 官网包
    LEIYAN =  102,
    -- 奇虎360
    QH360 = 103,
    -- 华为
    HMS = 104,
    -- OPPO
    OPPO = 105,
    -- 联想
    LENOVO = 106,
    -- 小米
    XIAOMI = 107,
    -- 九游UC
    JYUC = 108,
    -- VIVO
    VIVO = 109,
    -- 金立
    GIONEE = 110,
    -- M4399
    M4399 = 111,
    -- 酷派
    COOLPAD = 112,
    -- 魅族
    MZ = 113,
    -- B站
    BILI = 114,
    -- 快看
    KUAIKAN = 115,
    -- 努比亚
    NUBIA = 116,
    -- 三星
    SAMSUNG = 117,
    -- 应用宝
    YYB = 118,
    -- 荣耀
    HIHONOR = 120,
    -- 木木模拟器
    MUMU = 121,
    -- 乾游
    QIANYOU = 122,
    -- 诞诞游
    DANDANYOU = 123,
    -- QUICK2
    QUICK2 = 203,
    -- QUICK3
    QUICK3 = 204,
    -- QUICK
    QUICK = 1000,
}

sdk.IosChannelId = {
    -- 无
    None = 1,
    -- 官网包
    LEIYAN = 102,
    -- Quick
    QUICK = 203
}

--[[ 替换语言包自动生成，请勿修改！
]]
