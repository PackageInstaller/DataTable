--[[ 
-----------------------------------------------------
@filename       : LinkConfigVo
@Description    : ui跳转链接配置
@date           : 2020-11-05 19:57:45
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.link.manager.vo.LinkConfigVo', Class.impl())

function ctor(self)
    self:init()
end

function init(self)
    self.linkId = 0
    self.linkName = ""
    self.funcOpenId = 0
    self.musicID = 0
    self.uiEffect = ""
    self.code = 0
end

function parseData(self, key, cusData)
    --界面跳转ID
    self.linkId = key
    self.linkName = cusData.lang_id
    self.linkName2 = cusData.ui_code_name
    --界面开启Id
    self.funcOpenId = cusData.id
    self.musicID = cusData.music_id
    self.uiEffect = cusData.ui_effect
    self.uiType = cusData.ui_type
    self.code = cusData.code_type
end

function getLinkName(self)
    return _TT(self.linkName)
end

function getLinkName2(self)
    return _TT(self.linkName2)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]