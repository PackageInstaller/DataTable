module('game.selectedHero.controller.SelectedHeroViewController',Class.impl(Controller))

function ctor(self)
    super.ctor(self)
end

--析构函数
function dtor(self)
end

--游戏开始的回调
function gameStartCallBack(self)

end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_SELECTEDHEROVIEW, self.onOpenSelectedHeroView, self)
    GameDispatcher:addEventListener(EventName.OPEN_SELECTEITEMVIEW, self.onOpenSelectedPropsView, self)
end

function registerMsgHandler(self)
    return{

    }
end

function onOpenSelectedHeroView(self,args)
    if self.SelectedHeroView == nil then 
        self.SelectedHeroView = UI.new(selectedHero.SelectedHeroView)
        self.SelectedHeroView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    end
    self.SelectedHeroView:open(args)
end

function onDestroyViewHandler(self)
    self.SelectedHeroView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    self.SelectedHeroView = nil
end


function onOpenSelectedPropsView(self,args)
    if self.SelectedPropsView == nil then 
        self.SelectedPropsView = UI.new(selectedHero.SelectedPropsView)
        self.SelectedPropsView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyelectedPropsViewHandler, self)
    end
    self.SelectedPropsView:open(args)
end

function onDestroyelectedPropsViewHandler(self)
    self.SelectedPropsView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyelectedPropsViewHandler, self)
    self.SelectedPropsView = nil
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
