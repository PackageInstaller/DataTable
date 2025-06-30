--[[ 
-----------------------------------------------------
@filename       : NavigationConfigVo
@Description    : 导航配置
@date           : 2023-02-07 14:39:34
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.link.manager.vo.NavigationConfigVo', Class.impl())

function parseData(self, key, cusData)
    self.id = key
    self.linkId = cusData.uicode
    self.linkName = cusData.ui_code_name
    self.funcOpenId = cusData.function_id
    self.iconId = cusData.icon
end

function getLinkName(self)
    return _TT(self.linkName)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]