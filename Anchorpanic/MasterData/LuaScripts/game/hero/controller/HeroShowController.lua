--[[
-----------------------------------------------------
@filename       : HeroShowManager
@Description    : 英雄获得展示管理
@date           : 2022-2-18 14:54:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("hero.HeroShowController", Class.impl(Controller))

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
    if self.mHeroGainShowPanel then
        self.mHeroGainShowPanel:close()
        self.mHeroGainShowPanel = nil
    end
end

--析构函数
function dtor(self)
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.CHECK_HERO_GAIN_SHOW, self.onCheckHeroGainShowView, self)
    GameDispatcher:addEventListener(EventName.NEW_SHOW_AWARD_PANEL_OPEN, self.onShowAwardPanelOpen, self)
    GameDispatcher:addEventListener(EventName.CLOSE_RECRUIT_SHOW_ONE_VIEW, self.onCheckHeroGainShowView, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        -- - *s2c* 战员图鉴 13009
        SC_HERO_MANUAL = self.__onHeroShowHandler,
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 奖励界面打开了
function onShowAwardPanelOpen(self)
    hero.HeroShowManager:setAllFinishCall(ShowAwardPanel_New:getInstance():getCallFun())
    ShowAwardPanel_New:getInstance():setCallFun(function() self:onCheckHeroGainShowView() end)
end

-- 获得战员展示
function __onHeroShowHandler(self, msg)
    hero.HeroShowManager:setShowGainHeroList(msg.hero_list)

    if not fight.FightManager:getIsFighting() then
        self:onCheckHeroGainShowView()
    end
end

------------------------------------------------------------------------ 战员获得展示 ------------------------------------------------------------------------
-- 检查是否需要战员获得展示界面
function onCheckHeroGainShowView(self, args)
    --抽卡过程中不允许弹获得展示界面
    if map.MapLoader:getCurSceneType() == MAP_TYPE.RECRUIT_HERO then
        return
    end

    if self.mHeroGainShowPanel then
        self.mHeroGainShowPanel:close()
    end
    local showTidList = hero.HeroShowManager:getShowGainHeroList()
    if (#showTidList > 0) then
        local heroShowVo = table.remove(showTidList, 1)
        -- self:onShowOneHeroPanel(table.remove(showTidList, 1))
        GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_SHOW_ONE_VIEW, {heroTid = heroShowVo.heroTid, propsList = heroShowVo.propsList, isNoSkip = true})
        return
    end
    hero.HeroShowManager:runAllFinishCall()
end

-- 打开战员获得展示界面
function onShowOneHeroPanel(self, args)
    -- gs.PopPanelManager.CloseAll()
    if self.mHeroGainShowPanel == nil then
        self.mHeroGainShowPanel = recruit.HeroFirstShowView.new()
        self.mHeroGainShowPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroFirstViewHandler, self)
    end
    self.mHeroGainShowPanel:open(args)
end
function onDestroyHeroFirstViewHandler(self)
    self.mHeroGainShowPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroFirstViewHandler, self)
    self.mHeroGainShowPanel = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
