--[[  AutoScript 自动脚本 
----------------------------------------------------- 
   @CreateTime:2021/4/6 14:19:18 
   @Author:Shenxintian 
   @Copyright: (LY)2021 雷焰网络 
   @Description:广告牌展示页面 C
]] 
module('game.ikon.controller.IkonController', Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

--游戏开始的回调
function gameStartCallBack(self)

end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_IKON_VIEW, self.openIkonView, self)
end

function openIkonView(self)
    if self.mIkonView == nil then
        self.mIkonView = UI.new(ikon.IkonView)
        self.mIkonView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    end
    self.mIkonView:open()
end

function onDestroyViewHandler(self)
  self.mIkonView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
  self.mIkonView = nil
end 

--注册server发来的数据
function registerMsgHandler(self)
    return {

    }
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
