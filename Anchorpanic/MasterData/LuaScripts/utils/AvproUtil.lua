--[[ 
-----------------------------------------------------
@filename       : AvproUtil
@Description    : AVProVideo 工具的一些方法封装，处理在不同环境的一些问题
@date           : 2021-05-12 17:00:26
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]

module('AvproUtil', Class.impl())

-- 获取是否正常环境
function getIsNormal(self)
    -- local isHarmonyOs, harmonyOsVersion = sdk.SdkManager:getHarmonyOsData()
    -- if(isHarmonyOs)then
        -- local versionList = string.split(harmonyOsVersion, ".")
        -- if(#versionList >= 3)then
        --     if(tonumber(versionList[1]) <= 2)then
                -- return false
        --     end
        -- end
    -- end
    return true
end

-- 一些额外的初始操作
function init(self, avproPlayer)
    if(avproPlayer and not gs.GoUtil.IsCompNull(avproPlayer))then
        avproPlayer.PlatformOptionsAndroid.videoApi = gs.MediaPlayerVideoApi.MediaPlayer
    end
end

-- 音量设置
function setVolume(self, avproPlayer, volume)
    if(avproPlayer and not gs.GoUtil.IsCompNull(avproPlayer) and self:getIsNormal())then
        avproPlayer.Control:SetVolume(volume)
    end
end

-- 静音
function muteAudio(self, avproPlayer, isMute)
    if(avproPlayer and not gs.GoUtil.IsCompNull(avproPlayer) and self:getIsNormal())then
        avproPlayer.Control:MuteAudio(isMute)
    end
end

return _M