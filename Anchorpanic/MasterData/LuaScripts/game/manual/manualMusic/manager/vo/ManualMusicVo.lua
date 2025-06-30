--[[ 
-----------------------------------------------------
@filename       : ManualMusicVo
@Description    : 图鉴-音乐解析
@date           : 2023-3-6 16:23:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualMusicVo", Class.impl())

function parseData(self, index, cusData)
    self.musicId = index
    self.name = cusData.name
    self.musicName = cusData.music_name
    self.unlockType = cusData.unlock_type
    self.unlockList = cusData.unlock_list
    self.icon = cusData.icon
    self.sort = cusData.sort
end

--获取名字
function getName(self)
    return self.name
end
--获取音乐预制体名称
function getMusicName(self)
    return self.musicName
end
--获取防御系数
function getIsUnlock(self)
    return manual.ManualMusicManager:getIsUnlock(self.musicId)
end
--获取图片Url
function getImgUrl(self)
    return UrlManager:getManualMusicIconUrl(self.icon)
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]