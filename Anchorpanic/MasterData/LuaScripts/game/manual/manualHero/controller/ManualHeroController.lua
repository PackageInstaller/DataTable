--[[ 
-----------------------------------------------------
@filename       : ManualHeroController
@Description    : 故事控制器
@date           : 2023-3-27 17:41:00
@Author         : Shuai 
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualHeroController", Class.impl(manual.ManualController))

--模块间事件监听
function listNotification(self)
    --打开战员界面
    GameDispatcher:addEventListener(EventName.REQ_MANUALHERO_READ, self.updateRead, self)
end

function registerMsgHandler(self)
    return { }
end

function updateRead(self, camp)
    manual.ManualHeroManager:reqUpdateNew(camp)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]