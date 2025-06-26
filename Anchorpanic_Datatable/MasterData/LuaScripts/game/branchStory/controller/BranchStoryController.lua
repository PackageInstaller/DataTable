module("branchStory.BranchStoryController", Class.impl(Controller))

--构造函数
function ctor(self)
    super.ctor(self)
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
    -- 打开支线面板
    GameDispatcher:addEventListener(EventName.OPEN_BRANCH_STORY_PANEL, self.__onOpenPanelHandler, self)
    -- 打开支线芯片特训关卡列表界面
    GameDispatcher:addEventListener(EventName.OPEN_BRANCH_EQUIP_STAGE_PANEL, self.__onOpenStageListPanelHandler, self)
    -- 请求支线芯片特训奖励领取
    GameDispatcher:addEventListener(EventName.REQ_REC_BRANCH_EQUIP_AWARD, self.__onReqRecBranchEquipAwardHandler, self)
    -- 打开战术训练城池面板
    GameDispatcher:addEventListener(EventName.OPEN_BRANCH_TACIVS_PANEL, self.__onOpenTactivsStagePanelHandler, self)
    -- 打开战场异闻面板
    GameDispatcher:addEventListener(EventName.OPEN_BRANCH_MAIN_PANEL, self.__onOpenMainStagePanelHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 芯片支线副本面板返回 18021
        SC_CHIP_BRANCH_DUP_INFO = self.__onResBranchEquipInfoHandler,
        --- *s2c* 芯片支线副本章节奖励返回 18023
        SC_CHIP_BRANCH_GAIN_CHAPTER = self.__onResBranchEquipAwardHandler,
        --- *s2c* 战术训练 18030
        SC_TACTICS_TRAINING_INFO = self.__onResTactivsHandler,

        SC_BRANCH_STORY_INFO = self.__onResMainHandler,
        --- *s2c* 战员能源训练副本面板返回 18041
        SC_POWER_TRAIN_INFO = self.__onPowerHandler
      
    }
end

-----------------------------------------------------------------------------响应---------------------------------------------------------------------------
-- 芯片支线副本面板返回
function __onResBranchEquipInfoHandler(self, msg)
    branchStory.BranchStoryManager:parseDupInfo(msg)
    GameDispatcher:dispatchEvent(EventName.UPDATE_BRANCH_STORY_PANEL, {})
end

-- 芯片支线副本章节奖励返回
function __onResBranchEquipAwardHandler(self, msg)
    if(msg.result == 1)then
        local recList = branchStory.BranchStoryManager.recAwardChapterList
        if(table.indexof(recList, msg.chapter_id) == false)then
            table.insert(recList, msg.chapter_id)
        end
        GameDispatcher:dispatchEvent(EventName.RES_REC_BRANCH_EQUIP_AWARD, {chapterId = msg.chapter_id})
    else
        gs.Message.Show(_TT(44209))
    end
end

function __onResTactivsHandler(self,msg)
    branchStory.BranchTactivsManager:parseTactivsInfo(msg)
end

function __onResMainHandler(self,msg)
    branchStory.BranchMainManager:parseMainInfo(msg)
end

function __onPowerHandler(self,msg)
    branchStory.BranchPowerManager:parsePowerInfo(msg)
end


-----------------------------------------------------------------------------请求---------------------------------------------------------------------------.
-- 芯片支线副本面板请求
function __onReqBranchEquipInfoHandler(self, args)
    --- *c2s* 芯片支线副本面板请求 18020
    SOCKET_SEND(Protocol.CS_CHIP_BRANCH_DUP_INFO)
end

-- 芯片支线副本领取章节奖励
function __onReqRecBranchEquipAwardHandler(self, args)
    --- *c2s* 芯片支线副本领取章节奖励 18022
    SOCKET_SEND(Protocol.CS_CHIP_BRANCH_GAIN_CHAPTER, {chapter_id = args.chapterId})
end

------------------------------------------------------------------------ 支线剧情面板 ------------------------------------------------------------------------
function __onOpenPanelHandler(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_BRANCH_STORY, true) == false then
        return
    end
    local type = nil
    if args and args.type then
        type = args.type
    else
        type = branchStory.BranchStoryConst.EQUIP
    end
    local data = nil
    if args and args.data then
        data = args.data
    else
        data = {}
    end
    if self.mPanel == nil then
        self.mPanel = branchStory.BranchStoryPanel.new()
        self.mPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPanelHandler, self)
    end

    self.mPanel:open({type = type, data = data})
end

function onDestroyPanelHandler(self)
    self.mPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPanelHandler, self)
    self.mPanel = nil
end

------------------------------------------------------------------------ 支线芯片特训关卡界面 ------------------------------------------------------------------------
function __onOpenStageListPanelHandler(self, args)
    if self.mStagePanel == nil then
        self.mStagePanel = branchStory.BranchEquipStageListPanel.new()
        self.mStagePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStagePanelHandler, self)
    end
    self.mStagePanel:open({chapterVo = args.chapterVo, stageVo = args.stageVo})
end

function onDestroyStagePanelHandler(self)
    self.mStagePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStagePanelHandler, self)
    self.mStagePanel = nil
end

------------------------------------------------------------------------ 战术训练关卡界面 ------------------------------------------------------------------------
function __onOpenTactivsStagePanelHandler(self,args)
    if self.mTactivsPanel == nil then
        self.mTactivsPanel = branchStory.BranchTactivsStageListPanel.new()
        self.mTactivsPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyTactivsStagePanelHandler,self)
    end
    self.mTactivsPanel:open({chapterVo = args.chapterVo, stageVo = args.stageVo ,type = args.type})
end

function onDestroyTactivsStagePanelHandler(self)
    self.mTactivsPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyTactivsStagePanelHandler,self)
    self.mTactivsPanel = nil
end

------------------------------------------------------------------------ 战场异闻界面 ------------------------------------------------------------------------
function __onOpenMainStagePanelHandler(self,args)
    if self.mMainPanel == nil then
        self.mMainPanel = branchStory.BranchMainStageListPanel.new()
        self.mMainPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainStagePanelHandler,self)
    end
    self.mMainPanel:open({chapterVo = args.chapterVo, stageVo = args.stageVo ,type = args.type})
end

function onDestroyMainStagePanelHandler(self)
    self.mMainPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainStagePanelHandler,self)
    self.mMainPanel = nil
end



return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(44209):	"领取失败"
	语言包: _TT(44209):	"领取失败"
]]
