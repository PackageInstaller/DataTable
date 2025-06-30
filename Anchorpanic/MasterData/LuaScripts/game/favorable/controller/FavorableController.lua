module("favorable.FavorableController", Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
end

--模块间事件监听
function listNotification(self)
    -------------------好感度界面-----------------------------
    GameDispatcher:addEventListener(EventName.OPEN_FAVORABLE_PANEL, self.onOpenFavorableHandler, self)
    ------------------好感度升级弹窗--------------------------
    GameDispatcher:addEventListener(EventName.OPEN_FAVORABLUP_VIEW, self.onOpenFavorableLevelUpHandler, self)

    GameDispatcher:addEventListener(EventName.REQ_FAVORABLE_GIVE, self.onReqFavorableGive, self)

    GameDispatcher:addEventListener(EventName.REQ_FAVORABLE_REWARD, self.reqFavorableReward, self)

    GameDispatcher:addEventListener(EventName.REQ_HERO_STORY_REWARD, self.onReqHeroStoryReward, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 战员亲密度提升等级 13111
        SC_HERO_RELATION_LEVELUP = self.onfavorableLvUpHandler,
        --- *s2c* 战员使用亲密度道具结果 13141
        SC_ITEM_ADD_RELATION_EXP = self.onHeroFavorableResHandler,
        --- *s2c* 已领取的亲密度奖励id列表 13142
        SC_RELATION_REWARD = self.onHeroFavorableRewardHandler,
        --- *s2c* 领领取亲密度奖励结果 13144
        SC_RECEIVE_RELATION_REWARD = self.onReceiveReawrdHandler,
        --- *s2c* 已领取心语集奖励lv列表 13145
        --SC_RELATION_STORY_REWARD = self.onRelationStoryRewardHandler,
        --- *s2c* 领取心语集奖励 13147
        SC_RECEIVE_STORY_REWARD = self.updateHeroStoryReward,
    }
end

function onfavorableLvUpHandler(self, msg)
    if (msg.result) then
        GameDispatcher:dispatchEvent(EventName.UPDATE_FAVORABLE)
        if self.mFavorablePanel and self.mFavorablePanel.isPop then
            favorable.FavorableManager:setIsPopUp(true)
        end
    end
end

--- *s2c* 战员使用亲密度道具结果 13141
function onHeroFavorableResHandler(self, msg)
    if (msg.result == 1) then
        GameDispatcher:dispatchEvent(EventName.UPDATE_FAVORABLE,true)
    end
end

--- *s2c* 已领取的亲密度奖励id列表 13142
function onHeroFavorableRewardHandler(self, msg)
    self.mMgr:parseHeroFavorableRwardMsg(msg)
end

--- *s2c* 领领取亲密度奖励结果 13144
function onReceiveReawrdHandler(self, msg)
    if msg.result == 1 then
        self.mMgr:parseReceiveReawrdMsg(msg)
    end
end

function onReqFavorableGive(self, args)
    SOCKET_SEND(Protocol.CS_ITEM_ADD_RELATION_EXP, { item_list = args.item_list, hero_id = args.hero_id })
end

--- *c2s* 领取亲密度奖励 13143
function reqFavorableReward(self, args)
    SOCKET_SEND(Protocol.CS_RECEIVE_RELATION_REWARD, { hero_tid = args.heroTid, id = args.id })
end


-- function onRelationStoryRewardHandler(self, msg)
--     self.mMgr:parseHeroStoryRewardMsg(msg)
-- end


function onReqHeroStoryReward(self,args)
    SOCKET_SEND(Protocol.CS_RECEIVE_STORY_REWARD, { hero_tid = args.tid, relation_lv = args.lv },Protocol.SC_RECEIVE_STORY_REWARD)
end

function updateHeroStoryReward(self,msg)
    if msg.result == 1 then
        self.mMgr:updateHeroStoryReward(msg)
    end
end

------------------------------------------------------------------------ 好感面板 ------------------------------------------------------------------------
function onOpenFavorableHandler(self, args)
    if not args then
        args = { type = 1 }
    end
    if self.mFavorablePanel == nil then
        self.mFavorablePanel = favorable.FavorablePanel.new()
        self.mFavorablePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFavorablePanel, self)
    end
    self.mFavorablePanel:open(args)
end

function onDestroyFavorablePanel(self)
    self.mFavorablePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFavorablePanel, self)
    self.mFavorablePanel = nil
end

------------------------------------------------------------------------ 好感升级面板 ------------------------------------------------------------------------
function onOpenFavorableLevelUpHandler(self, args)
    if self.mFavorableLevelUpPanel == nil then
        self.mFavorableLevelUpPanel = favorable.FavorableLevelUpPanel.new()
        self.mFavorableLevelUpPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFavorableLevelUpPanel, self)
    end
    self.mFavorableLevelUpPanel:open(args)
end

function onDestroyFavorableLevelUpPanel(self)
    self.mFavorableLevelUpPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFavorableLevelUpPanel, self)
    self.mFavorableLevelUpPanel = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(41722):	"领取成功"
]]