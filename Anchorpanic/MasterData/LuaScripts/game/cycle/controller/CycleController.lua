module("game.cycle.controller.CycleController", Class.impl(Controller))

-- 构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

-- 析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

-- 游戏开始的回调
function gameStartCallBack(self)
end

-- 模块间事件监听
function listNotification(self)
    -- 顶部资源内容
    GameDispatcher:addEventListener(EventName.SHOW_CYCLE_TOP_PANEL, self.onShowCycleTopPanel, self)
    GameDispatcher:addEventListener(EventName.HIDE_CYCLE_TOP_PANEL, self.onHideCycleTopPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_CYCLE_TOP_PANEL, self.onCloseCycleTopPanel, self)

    -- 事影循回主界面
    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_MAIN_PANEL, self.onOpenCycleMainPanel, self)
    -- 事影循回难度选择
    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_LEVEL_SELECT_PANEL, self.onOpenCycleLevelSelectPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_CYCLE_LEVEL_SELECT_PANEL, self.onCloseCycleLevelSelectPanel, self)
    

    -- 事影循回BUFF选择
    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_BUFF_SELECT_PANEL, self.onOpenCycleBuffSelectPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_CYCLE_BUFF_SELECT_PANEL, self.onCloseCycleBuffSelectPanel, self)
    

    -- 事影循回招募策略选择
    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_COMBO_PANEL, self.onOpenCycleComboPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_CYCLE_COMBO_PANEL, self.onCloseCycleComboPanel, self)


    -- 事影循回招募选择
    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_RECRUIT_PANEL, self.onOpenCycleRecruitPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_CYCLE_RECRUIT_PANEL, self.onCloseCycleRecruitPanel, self)

    -- 事影循回战员招募选择
    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_HERO_SELECT_PANEL, self.onOpenCycleHeroSelectPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_CYCLE_HERO_SELECT_PANEL, self.onCloseCycleHeroSelectPanel, self)

    --打开事影循回战员招募确认界面
    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_HERO_SURE_PANEL,self.onOpenCycleHeroSurePanel,self)
    GameDispatcher:addEventListener(EventName.CLOSE_CYCLE_HERO_SURE_PANEL,self.onCloseCycleHeroSurePanel,self)
    
   
    -- 事影循回战员获取展示
    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_SHOW_ONE_PANEL, self.onOpenCycleShowOnePanel, self)
    -- 关闭事影循回所有步骤界面
    GameDispatcher:addEventListener(EventName.CLOSE_CYCLE_STEP_PANEL_ALL,self.onCloseCycleStepPanelAll,self)
    --关闭所有游戏内界面
    GameDispatcher:addEventListener(EventName.CLOSE_CYCLE_GAME_VIEW,self.onCloseCycleAllPanel,self)
    -- 事影循回地图
    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_MAP_PANEL, self.onOpenCycleMapPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_CYCLE_MAP_PANEL, self.onCloseCycleMapPanel, self)
    

    -- 事影循回事件界面
    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_EVENT_PANEL, self.onOpenCycleEventPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_CYCLE_EVENT_PANEL, self.onCloseCycleEventPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_EVENT_END_PANEL, self.onOpenCycleEventEndPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_CYCLE_EVENT_END_PANEL,self.onCloseCycleEventEndPanel,self)
    

    -- 事影循回战后界面
    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_POSTWAR_PANEL, self.onOpenCyclePostwarPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_CYCLE_POSTWAR_PANEL, self.onCloseCyclePostwarPanel, self)

    -- 事影循回战斗结算界面
    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_RESULT_WIN_PANEL, self.onOpenCycleResultWinPanel, self)

    -- 事影循回商店界面
    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_SHOP_PANEL, self.onOpenCycleShopPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_CYCLE_SHOP_PANEL, self.onCloseCycleShopPanel, self)

    -- 事影循回无限投资界面
    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_INVEST_PANEL,self.onOpenCycleInvestPanel,self)
    -- 事影循回战斗统计界面
    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_SETT_PANEL, self.onOpenCycleSettPanel, self)
    -- 事影循回战斗通关界面
    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_PASS_PANEL, self.onOpenCyclePassPanel, self)
    
    -- other
    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_LEVEL_PANEL, self.onOpenCycleLevelPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_COLLECTION_PANEL, self.onOpenCycleCollectionPanel, self)

    --收藏品奖励界面
    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_COLLECTION_AWARD_PANEL, self.onOpenCycleCollectionAwardPanel, self)
    

    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_SHOW_LAYER_PANEL, self.onOpenCycleShowLayerPanel, self)
    --事影循回任务界面
    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_TASK_PANEL, self.onOpenCycleTaskPanel, self)
    
    --GameDispatcher:addEventListener(EventName.OPEN_CYCLE_INVEST_SHOP_PANEL, self.onOpenCycleInvestShopPanel, self)
    
    --打开事影循回剧情界面
    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_STORY_PANEL,self.onOpenCycleStoryPanel,self)
    --打开事影循回领奖界面
    GameDispatcher:addEventListener(EventName.OPEN_CYCLE_STORY_AWARD_PANEL,self.onOpenCycleStoryTargetPanel,self)
    
    --更新无限城红点
    GameDispatcher:addEventListener(EventName.UPDATE_CYCLE_RED,self.onUpdateRed,self)
    ----------------------------------------------------------请求后端----------------------------------------------------------
    -- 请求后端
    GameDispatcher:addEventListener(EventName.REQ_CYCLE_STEP_INFO, self.onReqCycleStepInfoHandler, self)
    -- 触发事件
    GameDispatcher:addEventListener(EventName.REQ_CYCLE_TRIGGER_EVENT, self.onReqCycleTriggerEventInfoHandler, self)
    -- 确认事件信息
    GameDispatcher:addEventListener(EventName.REQ_CYCLE_TRIGGER_EVENT_FINISH, self.onReqCycleTriggerEventConfirmHandler,
        self)
    -- 取消事影循回
    GameDispatcher:addEventListener(EventName.REQ_ABANDON_CYCLE, self.onReqAbandonHandler, self)
    -- 请求购买商品
    GameDispatcher:addEventListener(EventName.REQ_CYCLE_SHOP_BUY, self.onReqCycleShopBuyInfoHandler, self)
    -- 请求刷新商品
    GameDispatcher:addEventListener(EventName.REQ_CYCLE_REFRESH_SHOP, self.onReqCycleRefreshShopInfoHandler, self)
    -- 请求商店招募英雄
    GameDispatcher:addEventListener(EventName.REQ_CYCLE_SHOP_RECRUIT_HERO, self.onReqCycleShopRecuitInfoHandler, self)
    -- 投资商店存钱
    GameDispatcher:addEventListener(EventName.REQ_CYCLE_DEPOSIT_COIN, self.onReqCycleDepositInfoHandler, self)
    --请求刷新任务
    GameDispatcher:addEventListener(EventName.REQ_CYCLE_TASK_REFRESH, self.onReqCycleTaskInfoHandler, self)
    --请求相应等级
    GameDispatcher:addEventListener(EventName.REQ_CYCLE_RECEIVE, self.onReqReceiveAwardHandler, self)
    --请求一键领取
    GameDispatcher:addEventListener(EventName.REQ_CYCLE_AUTO_RECEIVE, self.onReqAutoReceiveHandler, self)

    --请求领取收藏品奖励
    GameDispatcher:addEventListener(EventName.REQ_CYCLE_COLLECTION_AWARD, self.onReqCollectionAwardHandler, self)
    --请求领取剧情奖励
    GameDispatcher:addEventListener(EventName.REQ_CYCLE_STORY_AWARD, self.onReqStoryAwardHandler, self)

    
end

-- 注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_EVENT_CYCLE_RESOURCE_INFO = self.onCycleResourceInfoHandler,
        SC_EVENT_CYCLE_PREWAR_INFO = self.onCycleMapInfoHandler,
        SC_EVENT_CYCLE_LINE_INFO = self.onCycleLineInfoHandler,
        SC_EVENT_CYCLE_HISTORY_INFO = self.onCycleHistoryInfoHandler,
        SC_EVENT_CYCLE_UPDATE_CELL_INFO = self.onCellUpdateInfoHandler,
        SC_EVENT_CYCLE_HERO_LIST = self.onCycleHeroInfoHandler,
        SC_EVENT_CYCLE_COLLAGE_INFO = self.onCycleCollageInfoHandler,
        SC_EVENT_CYCLE_BUY_GOODS_RESULT = self.onCycleBuyGoodsInfoHandler,
        SC_EVENT_CYCLE_NORMAL_SHOP = self.onCycleShopInfoHandler,
        SC_EVENT_CYCLE_SETTLE_STATS = self.onCycleSettleInfoHandler,
        SC_EVENT_CYCLE_INVEST_SHOP = self.onCycleInvestInfoHandler,

        SC_EVENT_CYCLE_GAIN_LV_REWARD = self.onReceiveAwardHandler,
        SC_EVENT_CYCLE_TASK_PANEL = self.onCycleTaskInfoHandler,
        SC_UPDATE_EVENT_CYCLE_TASK_INFO = self.onUpdateTaskInfoHandler,


        SC_EVENT_CYCLE_STORY_LIST = self.onUpdateStoryInfoHandler,

        SC_EVENT_CYCLE_GAIN_COLLAGE_REWARD = self.onCollageInfoHandler,

        SC_EVENT_CYCLE_GAIN_SHOWROOM_REWARD = self.onShowRoomInfoHandler,
    }
end

------------------------------------------------------------server - local------------------------------------------------------------

-- 资源
function onCycleResourceInfoHandler(self, msg)
    cycle.CycleManager:parseResourceInfo(msg)
end

-- 地图
function onCycleMapInfoHandler(self, msg)
    cycle.CycleManager:parseCycleMapInfo(msg)
end

-- 线条
function onCycleLineInfoHandler(self, msg)
    cycle.CycleManager:parseCycleLineInfo(msg)
end

-- 历史
function onCycleHistoryInfoHandler(self, msg)
    cycle.CycleManager:parseHistoryInfo(msg)
    GameDispatcher:dispatchEvent(EventName.ON_RESPONED_RECEIVE_AWARD)
end

-- 格子更新
function onCellUpdateInfoHandler(self, msg)
    cycle.CycleManager:parseCellUpdateInfo(msg)
end

-- 战员更新
function onCycleHeroInfoHandler(self, msg)
    cycle.CycleManager:parseHeroUpdateInfo(msg)
end

-- 更新收藏品
function onCycleCollageInfoHandler(self, msg)
    cycle.CycleManager:parseCollageUpdateInfo(msg)
end

-- 够买商品
function onCycleBuyGoodsInfoHandler(self, msg)
    cycle.CycleManager:parseCycleBuyUpdateInfo(msg)
end

-- 更新商店信息
function onCycleShopInfoHandler(self, msg)
    cycle.CycleManager:parseCycleShopInfo(msg)
end

-- 结算统计
function onCycleSettleInfoHandler(self, msg)
    cycle.CycleManager:parseCycleSettleInfo(msg)
end

--投资商店信息
function onCycleInvestInfoHandler(self,msg)
    cycle.CycleManager:parseCycleInvestInfo(msg)
end

--任务信息面板
function onCycleTaskInfoHandler(self,args)
    cycle.CycleManager:parseCycleTaskInfo(args)
end

--更新任务内容
function onUpdateTaskInfoHandler(self,args)
    cycle.CycleManager:updateCycleTaskInfo(args)
end

--任务信息面板
function onReceiveAwardHandler(self,args)
     if args.result == 1 then 
      table.insert( cycle.CycleManager.mHistoryInfo.gained_lv_reward_list,args.lv)  
      GameDispatcher:dispatchEvent(EventName.ON_RESPONED_RECEIVE_AWARD)
     else 
        gs.Message.Show(_TT(27600))
     end
end

--更新剧情内容
function onUpdateStoryInfoHandler(self,args)
    cycle.CycleManager:updateStoryServerInfo(args)
end

--更新收藏品领奖情况
function onCollageInfoHandler(self,args)
    if args.result == 1 then
        cycle.CycleManager:updateCycleCollageAwardInfo(args.id)
    end
end
--更新剧情领奖情况
function onShowRoomInfoHandler(self,args)
    if args.result == 1 then
        cycle.CycleManager:updateCycleStoryAwardInfo(args.id)
    end
end

------------------------------------------------------------local - server------------------------------------------------------------
-- 请求地图数据
function onReqCycleStepInfoHandler(self, args)
    local list = {}
    for i = 1, #args.args do
        table.insert(list, args.args[1])
    end
    SOCKET_SEND(Protocol.CS_PREPARE_ENTER_EVENT_CYCLE, {
        step = args.step,
        args = list
    })
end

-- 取消事影循回
function onReqAbandonHandler(self)
    SOCKET_SEND(Protocol.CS_EVENT_CYCLE_ABANDON_EXPLORE, nil)
end

-- 触发事件
function onReqCycleTriggerEventInfoHandler(self, args)
    SOCKET_SEND(Protocol.CS_EVENT_CYCLE_TRIGGER_EVENT, {
        cell_id = args.cellId
    }, Protocol.SC_EVENT_CYCLE_UPDATE_CELL_INFO)
end

-- 确认事件信息
function onReqCycleTriggerEventConfirmHandler(self, args)
    local list = {}
    for i = 1, #args.args do
        table.insert(list, args.args[i])
    end

    SOCKET_SEND(Protocol.CS_EVENT_CYCLE_TRIGGER_CONFIRM, {
        cell_id = args.cellId,
        args = list
    })
end

-- 请求购买商品
function onReqCycleShopBuyInfoHandler(self, args)
    SOCKET_SEND(Protocol.CS_EVENT_CYCLE_BUY_GOODS, {
        goods_id = args.goodsId
    })
end

-- 请求刷新商品
function onReqCycleRefreshShopInfoHandler(self, args)
    SOCKET_SEND(Protocol.CS_EVENT_CYCLE_REFRESH_GOODS)
end

-- 请求商店招募英雄
function onReqCycleShopRecuitInfoHandler(self, args)
    SOCKET_SEND(Protocol.CS_EVENT_CYCLE_SHOP_RECRUIT_HERO, {
        hero_id = args.heroId
    })
end

-- 投资商店存钱
function onReqCycleDepositInfoHandler(self, args)
    --存
    if args.coin > 0 then
        SOCKET_SEND(Protocol.CS_EVENT_CYCLE_DEPOSIT_COIN, {
            coin = args.coin
        })
    else --取
        SOCKET_SEND(Protocol.CS_EVENT_CYCLE_WITHDRAW_COIN, {
            coin = -args.coin
        })
    end
end

--刷新任务
function onReqCycleTaskInfoHandler(self,args)
    SOCKET_SEND(Protocol.CS_EVENT_CYCLE_REFRESH_TASK, {
        task_id = args.taskId
    })
end

--领取奖励 19527
function onReqReceiveAwardHandler(self,args)
    SOCKET_SEND(Protocol.CS_EVENT_CYCLE_GAIN_LV_REWARD, {
        lv = args.level
    })
end

--一键领取奖励
function onReqAutoReceiveHandler(self)
    SOCKET_SEND(Protocol.CS_EVENT_CYCLE_GAIN_ALL_LV_REWARD)
end

--请求领取收藏品奖励
function onReqCollectionAwardHandler(self,args)
    SOCKET_SEND(Protocol.CS_EVENT_CYCLE_GAIN_COLLAGE_REWARD, {
        id = args.id
    })
end

--请求领取剧情奖励
function onReqStoryAwardHandler(self,args)
    SOCKET_SEND(Protocol.CS_EVENT_CYCLE_GAIN_SHOWROOM_REWARD, {
        id = args.id
    })
end

------------------------------------------------------------关闭所有步骤界面------------------------------------------------------------
function onCloseCycleStepPanelAll(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_LEVEL_SELECT_PANEL)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_BUFF_SELECT_PANEL)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_COMBO_PANEL)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_RECRUIT_PANEL)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_HERO_SELECT_PANEL)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_HERO_SURE_PANEL)
end

function onCloseCycleAllPanel(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_HERO_SURE_PANEL)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_HERO_SELECT_PANEL)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_POSTWAR_PANEL)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_SHOP_PANEL)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_EVENT_PANEL)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_EVENT_END_PANEL)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_RECRUIT_PANEL)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_FORMATION_PANEL)
end

------------------------------------------------------------资源界面------------------------------------------------------------
function onShowCycleTopPanel(self)
    if self.mCycleTopPanel == nil then
        self.mCycleTopPanel = cycle.CycleTopPanel.new()
        self.mCycleTopPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleTopPanel, self)
        self.mCycleTopPanel:open()
    end
    self.mCycleTopPanel:setActiveTopPanel(true)
end

function onHideCycleTopPanel(self)
    if self.mCycleTopPanel then
        cusLog("false========")
        self.mCycleTopPanel:setActiveTopPanel(false)
    end
end

function onCloseCycleTopPanel(self)
    if self.mCycleTopPanel then
        self.mCycleTopPanel:close()
    end
end

function onDestoryCycleTopPanel(self)
    self.mCycleTopPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleTopPanel, self)
    self.mCycleTopPanel = nil
end

------------------------------------------------------------主界面------------------------------------------------------------
function onOpenCycleMainPanel(self, args)
    if self.mCycleMainPanel == nil then
        self.mCycleMainPanel = cycle.CycleMainPanel.new()
        self.mCycleMainPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleMainPanelHandler, self)
    end
    self.mCycleMainPanel:open()
end

function onDestoryCycleMainPanelHandler(self)
    self.mCycleMainPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleMainPanelHandler, self)
    self.mCycleMainPanel = nil
end

------------------------------------------------------------难度选择------------------------------------------------------------

function onOpenCycleLevelSelectPanel(self, args)
    if self.mCycleLevelSelectPanel == nil then
        self.mCycleLevelSelectPanel = cycle.CycleLevelSelectPanel.new()
        self.mCycleLevelSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY,
            self.onDestoryCycleLevelSelectPanelHandler, self)
    end
    self.mCycleLevelSelectPanel:open()
end

function onCloseCycleLevelSelectPanel(self)
    if self.mCycleLevelSelectPanel then
        self.mCycleLevelSelectPanel:close()
    end
end

function onDestoryCycleLevelSelectPanelHandler(self)
    self.mCycleLevelSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleLevelSelectPanelHandler,
        self)
    self.mCycleLevelSelectPanel = nil
end

------------------------------------------------------------等级奖励------------------------------------------------------------
function onOpenCycleLevelPanel(self)
    if self.mCycleLevelPanel == nil then
        self.mCycleLevelPanel = cycle.CycleLevelPanel.new()
        self.mCycleLevelPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleLevelPanelHandler, self)
    end
    self.mCycleLevelPanel:open()
end

function onDestoryCycleLevelPanelHandler(self)
    self.mCycleLevelPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleLevelPanelHandler, self)
    self.mCycleLevelPanel = nil
end

------------------------------------------------------------buff选择界面------------------------------------------------------------
function onOpenCycleBuffSelectPanel(self, args)
    if self.mBuffSelectPanel == nil then
        self.mBuffSelectPanel = cycle.CycleBuffSelectPanel.new()
        self.mBuffSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleBuffSelectPanelHandler, self)
    end
    self.mBuffSelectPanel:open()
end

function onCloseCycleBuffSelectPanel(self)
    if self.mBuffSelectPanel then
        self.mBuffSelectPanel:close()
    end
end

function onDestoryCycleBuffSelectPanelHandler(self)
    self.mBuffSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleBuffSelectPanelHandler, self)
    self.mBuffSelectPanel = nil
end

------------------------------------------------------------招募筛选界面------------------------------------------------------------

function onOpenCycleComboPanel(self, args)
    if self.mCycleComboPanel == nil then
        self.mCycleComboPanel = cycle.CycleComboPanel.new()
        self.mCycleComboPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleComboPanelHandler, self)
    end
    self.mCycleComboPanel:open()
end

function onCloseCycleComboPanel(self)
    if self.mCycleComboPanel then
        self.mCycleComboPanel:close()
    end
end

function onDestoryCycleComboPanelHandler(self)
    self.mCycleComboPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleComboPanelHandler, self)
    self.mCycleComboPanel = nil
end

------------------------------------------------------------招募选择界面------------------------------------------------------------

function onOpenCycleRecruitPanel(self, args)
    if self.mCycleRecruitPanel == nil then
        self.mCycleRecruitPanel = cycle.CycleRecruitPanel.new()
        self.mCycleRecruitPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleRecruitPanel, self)
    end
    self.mCycleRecruitPanel:open()
end

function onCloseCycleRecruitPanel(self)
    if self.mCycleRecruitPanel then
        self.mCycleRecruitPanel:close()
    end
end

function onDestoryCycleRecruitPanel(self)
    self.mCycleRecruitPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleRecruitPanel, self)
    self.mCycleRecruitPanel = nil
end
------------------------------------------------------------战员选择界面------------------------------------------------------------

function onOpenCycleHeroSelectPanel(self)
    if self.mCycleHeroSelectPanel == nil then
        self.mCycleHeroSelectPanel = cycle.CycleHeroSelectPanel.new()
        self.mCycleHeroSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleHeroSelectPanelHandler,
            self)
    end
    self.mCycleHeroSelectPanel:open()
end

function onDestoryCycleHeroSelectPanelHandler(self)
    self.mCycleHeroSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleHeroSelectPanelHandler,
        self)
    self.mCycleHeroSelectPanel = nil
end

function onCloseCycleHeroSelectPanel(self)
    if self.mCycleHeroSelectPanel then
        self.mCycleHeroSelectPanel:close()
    end
end

------------------------------------------------------------战员选择确认界面------------------------------------------------------------
function onOpenCycleHeroSurePanel(self,args)
    if self.mCycleHeroSurePanel == nil then
        self.mCycleHeroSurePanel = cycle.CycleHeroSurePanel.new()
        self.mCycleHeroSurePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleHeroSurePanelHandler,
        self)
    end
    self.mCycleHeroSurePanel:open(args)
end

function onCloseCycleHeroSurePanel(self)
    if self.mCycleHeroSurePanel then
        self.mCycleHeroSurePanel:close()
    end
end

function onDestoryCycleHeroSurePanelHandler(self)
    self.mCycleHeroSurePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleHeroSurePanelHandler,
    self)
    self.mCycleHeroSurePanel = nil
end

------------------------------------------------------------展示招募战员展示界面------------------------------------------------------------
function onOpenCycleShowOnePanel(self, args)
    if self.mCycleShowOnePanel == nil then
        self.mCycleShowOnePanel = cycle.CycleShowOnePanel.new()
        self.mCycleShowOnePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleShowOnePanelHandler, self)
    end
    self.mCycleShowOnePanel:open(args)
end

function onDestoryCycleShowOnePanelHandler(self)
    self.mCycleShowOnePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleShowOnePanelHandler, self)
    self.mCycleShowOnePanel = nil
end
------------------------------------------------------------地图界面------------------------------------------------------------
function onOpenCycleMapPanel(self)
    if self.mCycleMapPanel == nil then
        self.mCycleMapPanel = cycle.CycleMapPanel.new()
        self.mCycleMapPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleMapPanelHandler, self)
    end
    self.mCycleMapPanel:open()
end

function onCloseCycleMapPanel(self)
    if self.mCycleMapPanel then
        self.mCycleMapPanel:close()
    end
end
function onDestoryCycleMapPanelHandler(self)
    self.mCycleMapPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleMapPanelHandler, self)
    self.mCycleMapPanel = nil
end

------------------------------------------------------------事件界面------------------------------------------------------------
function onOpenCycleEventPanel(self, args)
    if self.mCycleEventPanel == nil then
        self.mCycleEventPanel = cycle.CycleEventPanel.new()
        self.mCycleEventPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleEventPanelHandler, self)
    end
    self.mCycleEventPanel:open(args)
end

function onCloseCycleEventPanel(self)
    if self.mCycleEventPanel then
        self.mCycleEventPanel:close()
    end
end

function onDestoryCycleEventPanelHandler(self)
    self.mCycleEventPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleEventPanelHandler, self)
    self.mCycleEventPanel = nil
end

------------------------------------------------------------事件结束界面------------------------------------------------------------

function onOpenCycleEventEndPanel(self,args)
    if self.mCycleEventEndPanel == nil then
        self.mCycleEventEndPanel = cycle.CycleEventEndPanel.new()
        self.mCycleEventEndPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleEventEndPanelHandler, self)
    end
    self.mCycleEventEndPanel:open(args)
end

function onDestoryCycleEventEndPanelHandler(self)
    self.mCycleEventEndPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleEventEndPanelHandler, self)
    self.mCycleEventEndPanel = nil
end

function onCloseCycleEventEndPanel(self)
    if self.mCycleEventEndPanel then
        self.mCycleEventEndPanel:resetEndCall()
        self.mCycleEventEndPanel:close()
    end
end
------------------------------------------------------------战后界面------------------------------------------------------------
function onOpenCyclePostwarPanel(self, args)
    if self.mCyclePostwarPanel == nil then
        self.mCyclePostwarPanel = cycle.CyclePostwarPanel.new()
        self.mCyclePostwarPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCyclePostwarHandler, self)
    end
    self.mCyclePostwarPanel:open(args)
end

function onCloseCyclePostwarPanel(self)
    if self.mCyclePostwarPanel then
        self.mCyclePostwarPanel:close()
    end
end

function onDestoryCyclePostwarHandler(self)
    self.mCyclePostwarPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCyclePostwarHandler, self)
    self.mCyclePostwarPanel = nil
end
------------------------------------------------------------战中结算界面------------------------------------------------------------

function onOpenCycleResultWinPanel(self, args)
    if self.mCycleResultWinPanel == nil then
        self.mCycleResultWinPanel = cycle.CycleResultWinPanel.new()
        self.mCycleResultWinPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleResultHandler, self)
    end
    self.mCycleResultWinPanel:open(args)
end

function onDestoryCycleResultHandler(self)
    self.mCycleResultWinPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleResultHandler, self)
    self.mCycleResultWinPanel = nil
end

------------------------------------------------------------商店界面------------------------------------------------------------
function onOpenCycleShopPanel(self, args)
    if self.mCycleShopPanel == nil then
        self.mCycleShopPanel = cycle.CycleShopPanel.new()
        self.mCycleShopPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleShopHandler, self)
    end
    self.mCycleShopPanel:open(args)
end

function onCloseCycleShopPanel(self)
    if self.mCycleShopPanel then
        self.mCycleShopPanel:close()
    end
end

function onDestoryCycleShopHandler(self)
    self.mCycleShopPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleShopHandler, self)
    self.mCycleShopPanel = nil
end


------------------------------------------------------------商店内投资界面------------------------------------------------------------

function onOpenCycleInvestPanel(self,args)
    if self.mShopInvestPanel ==nil then
        self.mShopInvestPanel = cycle.CycleInvestPanel.new()
        self.mShopInvestPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleShopInvestHandler, self)
    end
    self.mShopInvestPanel:open()
end

function onDestoryCycleShopInvestHandler(self)
    self.mShopInvestPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleShopInvestHandler, self)
    self.mShopInvestPanel = nil
end


------------------------------------------------------------总结算界面------------------------------------------------------------
function onOpenCycleSettPanel(self, args)
    if self.mCycleSettPanel == nil then
        self.mCycleSettPanel = cycle.CycleSettPanel.new()
        self.mCycleSettPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleSettHandler, self)
    end
    self.mCycleSettPanel:open()
end

function onDestoryCycleSettHandler(self)
    self.mCycleSettPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleSettHandler, self)
    self.mCycleSettPanel = nil
end

------------------------------------------------------------通关界面------------------------------------------------------------
function onOpenCyclePassPanel(self, args)
    if self.mCyclePassPanel == nil then
        self.mCyclePassPanel = cycle.CyclePassPanel.new()
        self.mCyclePassPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCyclePassHandler, self)
    end
    self.mCyclePassPanel:open()
end

function onDestoryCyclePassHandler(self)
    self.mCyclePassPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCyclePassHandler, self)
    self.mCyclePassPanel = nil
end


------------------------------------------------------------收藏品界面------------------------------------------------------------

function onOpenCycleCollectionPanel(self, args)
    if not args then
        args = {}
    end
    if not args.type then
        args.type = COLLECTION_TYPE.ALL -- 页签索引
    end

    if self.mCycleCollectionPanel == nil then
        self.mCycleCollectionPanel = cycle.CycleCollectionPanel.new()
        self.mCycleCollectionPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleCollectionHandler, self)
    end
    self.mCycleCollectionPanel:open(args)
end

function onDestoryCycleCollectionHandler(self)
    self.mCycleCollectionPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleCollectionHandler, self)
    self.mCycleCollectionPanel = nil
end

------------------------------------------------------------收藏品奖励界面------------------------------------------------------------
function onOpenCycleCollectionAwardPanel(self,args)
    if self.mCycleCollectionTargetPanel == nil then
        self.mCycleCollectionTargetPanel = cycle.CycleCollectionTargetPanel.new()
        self.mCycleCollectionTargetPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleCollectionTargetHandler, self)
    end
    self.mCycleCollectionTargetPanel:open(args)
end

function onDestoryCycleCollectionTargetHandler(self)
    self.mCycleCollectionTargetPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleCollectionTargetHandler, self)
    self.mCycleCollectionTargetPanel = nil
end

------------------------------------------------------------层数展示界面------------------------------------------------------------
function onOpenCycleShowLayerPanel(self,args)
    if self.mCycleShowLayerPanel == nil then
        self.mCycleShowLayerPanel = cycle.CycleShowLayerPanel.new()
        self.mCycleShowLayerPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleShowLayerHandler, self)
    end
    self.mCycleShowLayerPanel:setCallFinish(args.callback)
    self.mCycleShowLayerPanel:open(args)
end

function onDestoryCycleShowLayerHandler(self)
    self.mCycleShowLayerPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleShowLayerHandler, self)
    self.mCycleShowLayerPanel = nil
end
------------------------------------------------------------任务界面------------------------------------------------------------

function onOpenCycleTaskPanel(self,args)
    if self.mCycleTaskPanel == nil then
        self.mCycleTaskPanel = cycle.CycleTaskPanel.new()
        self.mCycleTaskPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleTaskHandler, self)
    end
    self.mCycleTaskPanel:open(args)
end

function onDestoryCycleTaskHandler(self)
    self.mCycleTaskPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleTaskHandler, self)
    self.mCycleTaskPanel = nil
end
------------------------------------------------------------剧情界面------------------------------------------------------------

function onOpenCycleStoryPanel(self)
    if self.mCycleStoryPanel == nil then
        self.mCycleStoryPanel = cycle.CycleStoryPanel.new()
        self.mCycleStoryPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleStoryHandler, self)
    end
    self.mCycleStoryPanel:open()
end


function onDestoryCycleStoryHandler(self)
    self.mCycleStoryPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleStoryHandler, self)
    self.mCycleStoryPanel = nil
end

------------------------------------------------------------剧情奖励界面------------------------------------------------------------

function onOpenCycleStoryTargetPanel(self,args)
    if self.mCycleStoryTargetPanel == nil then
        self.mCycleStoryTargetPanel = cycle.CycleStoryTargetPanel.new()
        self.mCycleStoryTargetPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleStoryTargetHandler, self)
    end
    self.mCycleStoryTargetPanel:open()
end

function onDestoryCycleStoryTargetHandler(self)
    self.mCycleStoryTargetPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryCycleStoryTargetHandler, self)
    self.mCycleStoryTargetPanel = nil
end


------------------------------------------------------------更新红点------------------------------------------------------------

function onUpdateRed(self,args)
    local isFlag = false
    isFlag = cycle.CycleManager:getRedFlag() or cycle.CycleTalentManager:getRedFlag()
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_ADVENTURE,isFlag, funcopen.FuncOpenConst.FUNC_ID_ROGUE)    
end

------------------------------------------------------------无限投资商店界面------------------------------------------------------------
-- function onOpenCycleInvestShopPanel(self,args)
--     if self.mCycleInvestShopPanel == nil then
--         self.mCycleInvestShopPanel = cycle.CycleInvestShopPanel.new()
--         self.mCycleInvestShopPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryCycleInvestShopHandler,self)
--     end
--     self.mCycleInvestShopPanel:open(args)
-- end

-- function onDestoryCycleInvestShopHandler(self)
--     self.mCycleInvestShopPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryCycleInvestShopHandler,self)
--     self.mCycleInvestShopPanel = nil
-- end



return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27600):	"领取失败"
]]
