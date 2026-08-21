--[[-----------------------------------------------------
@filename       : ChannelData
@Description    : ChannelData数据配置
@date           : 2024-10-30
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("sdk.ChannelData", Class.impl())

-- 构造函数
function ctor(self)
    -- 内网，无渠道
    self.DEFAULT = nil

    ----------------------------------------------------- iOS -----------------------------------------------------
    -- 官网包
    self.iOS_LEIYAN = 101
    -- Quick 小七
    self.iOS_QUICK_X7 = 100003
    -- Quick 信息流未知
    self.iOS_QUICK_X = 124
    -- Quick3 未知
    self.iOS_QUICK_X = 100004

    -- 冰鸟日本
    self.iOS_BN_JP = 10
    -- Sonet港澳台
    self.iOS_SONET_ZHTW = 20
    -- Neptune韩国
    self.iOS_NEPTUNE_KR = 30
    -- 乐玩北美欧盟
    self.iOS_LW_EN = 40

    ----------------------------------------------------- Android -----------------------------------------------------
    -- 最终也无法得知的未知渠道
    self.ANDROID_UNKNOW_CHANNEL = 0

    -- 官网包及子包
    self.ANDROID_GUANWANG    = 102000
    -- B站及子包
    self.ANDROID_BILI        = 114000
    -- mumu及子包
    self.ANDROID_MUMU        = 121000
    -- 乾游包及其子包
    self.ANDROID_QY            = 122000
    -- 诞诞游及其子包
    self.ANDROID_DDY            = 123000
    -- quick1及其子包
    self.ANDROID_QUICK1        = 1000000
    -- quick2及其子包
    self.ANDROID_QUICK2        = 203000
    -- quick3及其子包
    self.ANDROID_QUICK3        = 204000

    -- 日本区域及其子包
    self.ANDROID_JP            = 201000
    -- 韩国区域及其子包
    self.ANDROID_KR            = 301000
    -- 港澳台区域及其子包
    self.ANDROID_TW            = 401000
    -- 乐玩北美欧盟
    self.ANDROID_EN            = 501000

    -- leiyan>未知
    self.ANDROID_LEIYAN_UNKNOW = self.ANDROID_GUANWANG
    -- leiyan>雷焰官网包
    self.ANDROID_LEIYAN_GW    = self.ANDROID_GUANWANG + 1
    -- leiyan>tap
    self.ANDROID_LEIYAN_TAP    = self.ANDROID_GUANWANG + 2
    -- leiyan>好游快爆
    self.ANDROID_LEIYAN_HAOYOU = self.ANDROID_GUANWANG + 3
    -- leiyan>mumu模拟器
    self.ANDROID_LEIYAN_MUMU    = self.ANDROID_GUANWANG + 4
    -- leiyan>雷电模拟器
    self.ANDROID_LEIYAN_LEIDIAN = self.ANDROID_GUANWANG + 5
    -- leiyan>1399
    self.ANDROID_LEIYAN_4399    = self.ANDROID_GUANWANG + 6
    -- leiyan>mumu pc
    self.ANDROID_LEIYAN_MUMUPC = self.ANDROID_GUANWANG + 7
    -- leiyan>网易云
    self.ANDROID_LEIYAN_WANGYI = self.ANDROID_GUANWANG + 8
    -- leiyan>畅游天际
    self.ANDROID_LEIYAN_CYTJ    = self.ANDROID_GUANWANG + 9
    -- leiyan>联想
    self.ANDROID_LEIYAN_LENOVO = self.ANDROID_GUANWANG + 10
    -- leiyan>移动咪咕
    self.ANDROID_LEIYAN_MIGU    = self.ANDROID_GUANWANG + 11
    -- leiyan>233
    self.ANDROID_LEIYAN_233    = self.ANDROID_GUANWANG + 12
    -- leiyan>网易云游戏
    self.ANDROID_LEIYAN_WANGYI2 = self.ANDROID_GUANWANG + 13

    -- sdk channel>bili 未知
    self.ANDROID_BILI_UNKNOW = self.ANDROID_BILI
    -- sdk channel>bili B站包
    self.ANDROID_BILI_SDK    = self.ANDROID_BILI + 1

    -- sdk channel>mumu 未知
    self.ANDROID_MUMU_UNKNOW = self.ANDROID_MUMU
    -- sdk channel>mumu包
    self.ANDROID_MUMU_SDK    = self.ANDROID_MUMU + 1

    -- 乾游>未知
    self.ANDROID_QY_UNKNOW = self.ANDROID_QY
    -- 乾游>sdk
    self.ANDROID_QY_SDK        = self.ANDROID_QY + 1
    -- 乾游>官网
    self.ANDROID_QY_GW        = self.ANDROID_QY + 2
    -- 乾游>华为
    self.ANDROID_QY_HW        = self.ANDROID_QY + 3
    -- 乾游>oppo
    self.ANDROID_QY_OPPO        = self.ANDROID_QY + 4
    -- 乾游>小米
    self.ANDROID_QY_XM        = self.ANDROID_QY + 5
    -- 乾游>vivo
    self.ANDROID_QY_VIVO        = self.ANDROID_QY + 6
    -- 乾游>百度
    self.ANDROID_QY_BAIDU    = self.ANDROID_QY + 7
    -- 乾游>荣耀
    self.ANDROID_QY_HINOR    = self.ANDROID_QY + 8
    -- 乾游>金立
    self.ANDROID_QY_JL        = self.ANDROID_QY + 9
    -- 乾游>酷派
    self.ANDROID_QY_KP        = self.ANDROID_QY + 10
    -- 乾游>魅族
    self.ANDROID_QY_MZ        = self.ANDROID_QY + 11
    -- 乾游>360
    self.ANDROID_QY_360        = self.ANDROID_QY + 12
    -- 乾游>努比亚
    self.ANDROID_QY_LBY        = self.ANDROID_QY + 13

    -- 诞诞游>未知
    self.ANDROID_DDY_UNKNOW    = self.ANDROID_DDY
    -- 诞诞游>SDK
    self.ANDROID_DDY_SDK        = self.ANDROID_DDY + 1
    -- 诞诞游>巨量头条
    self.ANDROID_DDY_JLTT    = self.ANDROID_DDY + 2
    -- 诞诞游>快手
    self.ANDROID_DDY_KS        = self.ANDROID_DDY + 3
    -- 诞诞游>微博
    self.ANDROID_DDY_WB        = self.ANDROID_DDY + 4
    -- 诞诞游>百度
    self.ANDROID_DDY_BAIDU    = self.ANDROID_DDY + 5
    -- 诞诞游>广点通
    self.ANDROID_DDY_GDT        = self.ANDROID_DDY + 6
    -- 诞诞游>星图
    self.ANDROID_DDY_XT        = self.ANDROID_DDY + 7

    -- quick1>未知
    self.ANDROID_QUICK1_UNKNOW = self.ANDROID_QUICK1
    -- quick1>sdk
    self.ANDROID_QUICK1_GW    = self.ANDROID_QUICK1 + 1
    -- quick1>小七混服
    self.ANDROID_QUICK1_X7    = self.ANDROID_QUICK1 + 2
    -- quick1>雷电
    self.ANDROID_QUICK1_LD    = self.ANDROID_QUICK1 + 3
    -- quick1>抖音小手柄
    self.ANDROID_QUICK1_DY    = self.ANDROID_QUICK1 + 4

    -- quick2>未知
    self.ANDROID_QUICK2_UNKNOW = self.ANDROID_QUICK2
    -- quick2>sdk
    self.ANDROID_QUICK2_SDK    = self.ANDROID_QUICK2 + 1
    -- quick2>小七专服
    self.ANDROID_QUICK2_X7    = self.ANDROID_QUICK2 + 2
    -- quick2>抖音小手柄
    self.ANDROID_QUICK2_DY    = self.ANDROID_QUICK2 + 3

    -- quick3>未知
    self.ANDROID_QUICK3_UNKNOW = self.ANDROID_QUICK3
    -- quick3>官网or买量
    self.ANDROID_QUICK3_GW    = self.ANDROID_QUICK3 + 1
    -- quick3>外测包
    self.ANDROID_QUICK3_WC    = self.ANDROID_QUICK3 + 2
    -- quick3>抖音小手柄
    self.ANDROID_QUICK3_DY    = self.ANDROID_QUICK3 + 3
    -- quick3>抖音小米
    self.ANDROID_QUICK3_XM    = self.ANDROID_QUICK3 + 4

    -- jp>未知
    self.ANDROID_JP_UNKNOW    = self.ANDROID_JP
    -- jp>google包
    self.ANDROID_JP_GOOGLE    = self.ANDROID_JP + 1
    -- jp>dmm包
    self.ANDROID_JP_DMM        = self.ANDROID_JP + 2

    -- kr>未知
    self.ANDROID_KR_UNKNOW    = self.ANDROID_KR
    -- kr>google包
    self.ANDROID_KR_GOOGLE    = self.ANDROID_KR + 1
    -- kr>onestore
    self.ANDROID_KR_ONSTORE    = self.ANDROID_KR + 2

    -- tw>未知渠道
    self.ANDROID_TW_UNKNOW    = self.ANDROID_TW
    -- tw>Google包
    self.ANDROID_TW_GOOGLE    = self.ANDROID_TW + 1

    -- 北美欧盟>未知渠道
    self.ANDROID_EN_UNKNOW    = self.ANDROID_EN
    -- 北美欧盟>乐玩Google包
    self.ANDROID_EN_LW        = self.ANDROID_EN + 1
    ----------------------------------------------------- Windows -----------------------------------------------------
    -- 官网包及子包
    self.WINDOWS = 1001000

    -- PC国内官网
    self.WINDOWS_CN_GW = self.WINDOWS
    -- PC国内STEAM
    self.WINDOWS_CN_STEAM = self.WINDOWS + 1

    -- PC日本 dmm
    self.WINDOWS_JP_DMM = self.WINDOWS + 2
    -- PC韩国
    self.WINDOWS_KR_HIVE = self.WINDOWS + 3
    -- PC港澳台
    self.WINDOWS_ZHTW = self.WINDOWS + 4
    -- 乐玩北美欧盟
    self.WINDOWS_USA_LW = self.WINDOWS + 5


    -----------------------------特殊资源等级-----------------------------
    -- 全平台
    self.HAR_LEVEL_0 = nil
    -- 仅dy
    self.HAR_LEVEL_1 = 1
    -- dy+硬核
    self.HAR_LEVEL_2 = 2
end

-- 正式获取渠道类型数据
function getData(self)
    if sdk.SdkManager.mIsEditor then
        return self.DEFAULT, ""
    end
    local jsonStr = gs.SdkManager:GetChannelData("")
    if (jsonStr == nil) then
        return self.DEFAULT, ""
    else
        jsonStr = string.gsub(jsonStr, " ", "")
        if (jsonStr == "" or jsonStr == "{}") then
            return self.DEFAULT, ""
        else
            local data = JsonUtil.decode(jsonStr)
            if (data and data.channelId ~= "") then
                return tonumber(data.channelId), data.channelName or ""
            else
                logInfo("渠道类型数据解析失败", "SdkManager")
                return self.DEFAULT, ""
            end
        end
    end
end

function checkChannelText(self, str)
    local channelId, channelName = self:getData()
    if (channelId == self.ANDROID_JP_DMM or channelId == self.WINDOWS_JP_DMM) then
        if (string.find(str, "￥")) then
            str = string.gsub(str, "%s+", "")
            -- 货币符号￥和货币价格数字涉及到的富文本标签不支持嵌套，如有让策划改成单层富文本标签
            -- 这里试了匹配0个或1个或多个捕获组没效果，等有志之士专门优化下或去C#实现
            str = string.gsub(str, "￥(%s*)(%d+%.?%d*)", "%2%1￥")
            str = string.gsub(str, "￥(%s*)(<[^>]->)%s*(%d+%.?%d*)%s*(<[^>]->)", "%2%3%4%1￥")
            str = string.gsub(str, "(<[^>]->)%s*￥%s*(<[^>]->)(%s*)(%d+%.?%d*)", "%4%3%1￥%2")
            str = string.gsub(str, "(<[^>]->)%s*￥%s*(<[^>]->)(%s*)(<[^>]->)%s*(%d+%.?%d*)%s*(<[^>]->)", "%4%5%6%3%1￥%2")
        end
        str = string.gsub(str, "￥", "DMMポイント")
        str = string.gsub(str, "円", "DMMポイント")
        return str
    else
        return str
    end
end

-- 是否指定渠道
function isChannel(self, cusChannelId, isContainSubChannle)
    if sdk.SdkManager.mIsEditor then
        return false
    end
    local channelId, channelName = self:getData()
    if (cusChannelId == nil or channelId == nil) then
        return false
    end
    if (isContainSubChannle) then
        if (web.WebManager.platform == web.DEVICE_TYPE.ANDROID) then
            if (self:__getChannelRangeInteger(nil) == self:__getChannelRangeInteger(cusChannelId)) then
                return true
            end
        end
    end
    return cusChannelId == channelId
end

function __getChannelRangeInteger(self, channelId)
    if (channelId == nil) then
        local _channelId, _channelName = self:getData()
        channelId = _channelId
    end
    if (channelId == nil) then
        return nil
    end
    local inter, point = math.modf(channelId / 1000)
    return inter
end

-- 是否官网包及其子包
function isChannelGUANWANG(self)
    if sdk.SdkManager.mIsEditor then
        return false
    end
    if (web.WebManager.platform == web.DEVICE_TYPE.ANDROID) then
        if (self:__getChannelRangeInteger(nil) == self:__getChannelRangeInteger(self.ANDROID_GUANWANG)) then
            return true
        end
    elseif (web.WebManager.platform == web.DEVICE_TYPE.IOS) then
        local _channelId, _channelName = self:getData()
        return _channelId == self.iOS_LEIYAN
    elseif (web.WebManager.platform == web.DEVICE_TYPE.WINDOWS) then
        local _channelId, _channelName = self:getData()
        return _channelId == self.WINDOWS_CN_GW
    end
    return false
end

-- 是否哔哩包及其子包
function isChannelBili(self)
    if sdk.SdkManager.mIsEditor then
        return false
    end
    if (web.WebManager.platform == web.DEVICE_TYPE.ANDROID) then
        if (self:__getChannelRangeInteger(nil) == self:__getChannelRangeInteger(self.ANDROID_BILI)) then
            return true
        end
    end
    return false
end

-- 是否mumu包及其子包
function isChannelMuMu(self)
    if sdk.SdkManager.mIsEditor then
        return false
    end
    if (web.WebManager.platform == web.DEVICE_TYPE.ANDROID) then
        if (self:__getChannelRangeInteger(nil) == self:__getChannelRangeInteger(self.ANDROID_MUMU)) then
            return true
        end
    end
    return false
end

-- 是否乾游包及其子包
function isChannelQY(self)
    if sdk.SdkManager.mIsEditor then
        return false
    end
    if (web.WebManager.platform == web.DEVICE_TYPE.ANDROID) then
        if (self:__getChannelRangeInteger(nil) == self:__getChannelRangeInteger(self.ANDROID_QY)) then
            return true
        end
    end
    return false
end

-- 是否诞诞游包及其子包
function isChannelDDY(self)
    if sdk.SdkManager.mIsEditor then
        return false
    end
    if (web.WebManager.platform == web.DEVICE_TYPE.ANDROID) then
        if (self:__getChannelRangeInteger(nil) == self:__getChannelRangeInteger(self.ANDROID_DDY)) then
            return true
        end
    end
    return false
end

-- 是否quick1包及其子包
function isChannelQuick1(self)
    if sdk.SdkManager.mIsEditor then
        return false
    end
    if (web.WebManager.platform == web.DEVICE_TYPE.ANDROID) then
        if (self:__getChannelRangeInteger(nil) == self:__getChannelRangeInteger(self.ANDROID_QUICK1)) then
            return true
        end
    end
    return false
end

-- 是否quick2包及其子包
function isChannelQuick2(self)
    if sdk.SdkManager.mIsEditor then
        return false
    end
    if (web.WebManager.platform == web.DEVICE_TYPE.ANDROID) then
        if (self:__getChannelRangeInteger(nil) == self:__getChannelRangeInteger(self.ANDROID_QUICK2)) then
            return true
        end
    end
    return false
end

-- 是否quick3包及其子包
function isChannelQuick3(self)
    if sdk.SdkManager.mIsEditor then
        return false
    end
    if (web.WebManager.platform == web.DEVICE_TYPE.ANDROID) then
        if (self:__getChannelRangeInteger(nil) == self:__getChannelRangeInteger(self.ANDROID_QUICK3)) then
            return true
        end
    end
    return false
end

-- 是否渠道特殊资源
function getIsChannelHarmonious(self, level)
    if (GameManager:getIsInCommiting() or role.RoleManager:getRoleVo().location ~= 1) then
        return true
    end

    if (web.WebManager.net_type ~= web.NET_TYPE.OUTER_RELEASE and GameManager.isTestHar) then
        return true
    end

    if (level == self.HAR_LEVEL_0 and (web.WebManager.net_type == web.NET_TYPE.OUTER_RELEASE or sdk.ChannelData:getIsOuterTestDouYinBroadcast())) then
        -- 正式服统一处理
        return true
    end

    if (web.WebManager.platform == web.DEVICE_TYPE.ANDROID) then
        local channelId, channelName = self:getData()
        if level == self.HAR_LEVEL_1 and (channelId == self.ANDROID_QUICK1_DY or channelId == self.ANDROID_QUICK2_DY or channelId == self.ANDROID_QUICK3_DY) then
            return true
        end
        if level == self.HAR_LEVEL_2 and (channelId == self.ANDROID_QY_HW or channelId == self.ANDROID_QY_VIVO or channelId == self.ANDROID_QY_OPPO or channelId == self.ANDROID_QUICK1_DY or channelId == self.ANDROID_QUICK2_DY or channelId == self.ANDROID_QUICK3_DY or channelId == self.ANDROID_QUICK1_GW or channelId == self.ANDROID_QUICK3_WC) then
            return true
        end
    end
    return false
end

-- taptap特制活动
function getIsTaptapActivity(self)
    if (web.WebManager:isReleaseApp()) then
        if (web.WebManager.platform == web.DEVICE_TYPE.WINDOWS) then
            return true
        end

        local channelId, channelName = self:getData()
        if (web.WebManager.platform == web.DEVICE_TYPE.ANDROID) then
            if (self:isChannelGUANWANG()) then
                if (channelId ~= self.ANDROID_LEIYAN_HAOYOU) then
                    -- 特殊处理好游快爆没有taptap特制活动
                    return true
                end
            end
        end

        if (web.WebManager.platform == web.DEVICE_TYPE.IOS) then
            local sdkInfo = sdk.SdkManager:getSdkInfo()
            -- if (sdkInfo and (sdkInfo.packageName == "com.fxyx.mdjl.ios" or sdkInfo.packageName == "com.fxyx.mdjl.x7zfios.x7sy" or sdkInfo.packageName == "com.game.tezj")) then
            --     -- 飞行quick3不弹
            --     return false
            -- end
            if (channelId == self.iOS_LEIYAN) then
                return true
            end
        end
    end
    return false
end

-------------------------------------------------------------------- 外测 --------------------------------------------------------------------
-- 是否外测环境渠道抖音直播包
function getIsOuterTestDouYinBroadcast(self)
    if (web.WebManager.net_type == web.NET_TYPE.OUTER_TEST and web.WebManager.platform == web.DEVICE_TYPE.ANDROID) then
        local sdkInfo = sdk.SdkManager:getSdkInfo()
        if (sdkInfo and sdkInfo.packageName == "com.fxyx.mdjl") then
            return true
        end
    end
    return false
end
-------------------------------------------------------------------- 外测 --------------------------------------------------------------------

return _M