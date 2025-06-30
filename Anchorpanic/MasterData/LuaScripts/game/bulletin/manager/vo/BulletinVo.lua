--[[ 
-----------------------------------------------------
@filename       : BulletinVo
@Description    : 游戏内公告数据
@date           : 2020-08-06 17:51:25
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.bulletin.manager.vo.BulletinVo', Class.impl())

function parseMsgData(self, cusMsg)
    self.id = cusMsg.id
    self.type = cusMsg.type
    self.name = cusMsg.name
    self.pic = cusMsg.illustration
    self.title = cusMsg.title
    self.content = cusMsg.content
    -- self.time = cusMsg.time
    self.url = cusMsg.web_url
    self.uicode = cusMsg.uicode > 0 and cusMsg.uicode or 0
    self.sort = cusMsg.sort
    -- logInfo("跳转id" .. self.uicode .. "公告名称" .. self.name)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]