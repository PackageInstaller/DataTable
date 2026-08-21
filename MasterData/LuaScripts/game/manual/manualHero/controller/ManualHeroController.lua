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
     --打开战员界面
     GameDispatcher:addEventListener(EventName.OPEN_MANUALHERO_VIEW, self.onOpenManualHeroViewHandler, self)
     GameDispatcher:addEventListener(EventName.CLOSE_MANUALHERO_VIEW, self.onCloseManualHeroViewHandler, self)
     
end

function registerMsgHandler(self)
    return { }
end

function updateRead(self, camp)
    manual.ManualHeroManager:reqUpdateNew(camp)
end

function onOpenManualHeroViewHandler(self, args)
    if self.mManualHeroView == nil then
        self.mManualHeroView = manual.ManualMapHeroView.new()
        self.mManualHeroView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyManualHeroViewHandler, self)
    end
    self.mManualHeroView:open(args)
end

function onDestroyManualHeroViewHandler(self)
    self.mManualHeroView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyManualHeroViewHandler, self)
    self.mManualHeroView = nil
end

function onCloseManualHeroViewHandler(self)
    if self.mManualHeroView then
        self.mManualHeroView:close()
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]