module('covenant.CovenantController', Class.impl(Controller))

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
    -- 打开盟约主界面
    GameDispatcher:addEventListener(EventName.OPEN_COVENANT_MAIN_PANEL,self.onOpenCovenantMainPanel,self)

    -- 打开盟约选择界面
    GameDispatcher:addEventListener(EventName.OPEN_COVENANT_SELECT_PANEL,self.onOpenCovenantSelectPanel,self)
    
    -- 打开盟约详细信息界面
    GameDispatcher:addEventListener(EventName.OPEN_COVENANT_SELECT_INFO_PANEL,self.onOpenCovenantSelectInfoPanelHandler, self)
    -- 打开盟约选择确认界面
    GameDispatcher:addEventListener(EventName.OPEN_COVENANT_SELECT_SURE_PANEL,self.onOpenCovenantSelectSurePanelHandler, self)
    -- 打开盟约选择不能变更界面                                                           
    GameDispatcher:addEventListener(EventName.OPEN_COVENANT_SELECT_NOTCHANGE_PANEL,self.onOpenCovenantSelectNotChangePanelHandler, self)

    -- 打开盟约商店界面
    GameDispatcher:addEventListener(EventName.OPEN_COVENANT_SHOP_PANEL, self.onOpenCovenantShopPanel, self)
    -- 打开盟约商店商品信息界面
    GameDispatcher:addEventListener(EventName.OPEN_COVENANT_SHOP_INFO_PANEL, self.onOpenCovenantShopInfoPanel, self)
    -- 打开盟约总部
    GameDispatcher:addEventListener(EventName.OPEN_COVENANT_HQ_PANEL,self.onOpenCovenantHQPanel,self)
  
    GameDispatcher:addEventListener(EventName.REQ_GET_PRESTIGE_AWARD, self.__onGetPrestigeStageAwardHandler,self)
    -- 请求加入盟约
    GameDispatcher:addEventListener(EventName.REQ_JOIN_FORCES,self.__onJoinForcesHandler,self)
      --请求变更盟约
    GameDispatcher:addEventListener(EventName.REQ_CHANGE_FORCES,self.__onChangeForcesHandler,self)

    -- 打开盟约助手培养界面
    GameDispatcher:addEventListener(EventName.OPEN_COVENANT_HELPER_BUILD_PANEL, self.onOpenHelperBuildPanel, self)
    -- 打开盟约助手助力英雄选择界面
    GameDispatcher:addEventListener(EventName.OPEN_COVENANT_HELP_HERO_SELECT_PANEL, self.__onOpenHelpHeroSelectPanelHandler, self)
    -- 打开盟约科技选择界面
    GameDispatcher:addEventListener(EventName.OPEN_COVENANT_SKILL_PANEL, self.__onOpenSkillPanelHandler, self)
    --请求盟约科技升级
    GameDispatcher:addEventListener(EventName.REQ_COVENANT_SKILL_UP,self.__onReqCovenantSkillUpHandler,self)
    -- 请求盟约助手信息
    GameDispatcher:addEventListener(EventName.REQ_COVENANT_HELPER_DATA, self.__onReqHelperDataHandler, self)
    -- 请求盟约助手助力英雄选择
    GameDispatcher:addEventListener(EventName.REQ_COVENANT_HELP_HERO_SELECT, self.__onReqHelpHeroSelectHandler, self)
    -- 请求盟约助手升级
    GameDispatcher:addEventListener(EventName.REQ_COVENANT_HELPER_LVL_UP, self.__onReqHelperLvlUpHandler, self)

    GameDispatcher:addEventListener(EventName.START_SHOW_FORCES_LV_UP,self.__onShowForcesLvUpHandler,self)

    GameDispatcher:addEventListener(EventName.REQ_INSTITUTE_LV_UP,self.__onReqInstituteHandler,self)

    --打开盟约任务界面
    GameDispatcher:addEventListener(EventName.OPEN_COVENANT_TASK,self.onOpenCovenantTaskHandler,self)

    GameDispatcher:addEventListener(EventName.REQ_GAIN_CONVENANT_TASK,self.onReqTaskHandler,self)

    --更新盟约红点
    --GameDispatcher:addEventListener(EventName.UPDATE_CONVENANT_RED_FLAG,self.onUpdateCovenantFlagHandler,self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        -- *s2c* 返回势力信息 21001
        SC_FORCES_PANEL = self.__onResForcesInfoHandler,
        --- *s2c* 研究所面板信息 21021
        SC_INSTITUTE_PANEL = self.__onResInstituteHandler,
        -- - *s2c* 提升声望等级 21003
        SC_UPGRADE_PRESTIGE = self.__onGainPrestigeAwardHandler,
        --- *s2c* 天赋信息 21059
        SC_TALENT_PANEL = self.__onForcesTalentHandler,
        --- *s2c* 更新天赋信息 21060
        SC_UPDATE_TALENT = self.__onForcesTalentUpdateHanlder,
        --- *s2c* 升级天赋结果 21062
        SC_UPGRADE_TALENT_RESULT = self.__onForcesTalentUpResultHandler,
        --- 升级研究所
        SC_INSTITUTE_UPGRADE = self.__onUpdateInstituteHandler,

        --- *s2c* 任务信息面板 21070
        SC_FORCES_TASK_PANEL_INFO = self.__onTaskInfoHandler,

        --- *s2c* 领取任务奖励 21072
        SC_GAIN_FORCES_TASK_AWARD = self.__onGainTaskHandler,
       
        --- *s2c* 更新任务进度 21073
        SC_UPDATE_FORCES_TASK_INFO = self.__onUpdateTaskHandler,
    }
end

------------------------------------------------------------------------ 响应 ------------------------------------------------------------------------
--- *s2c* 返回势力信息 21001
function __onResForcesInfoHandler(self,msg)
    covenant.CovenantManager:parseForcesInfo(msg)
    GameDispatcher:dispatchEvent(EventName.UPDATE_COVENANT_REDPOINT)
end

--- *s2c* 研究所面板信息 21021
function __onResInstituteHandler(self,msg)
    covenant.CovenantManager:parseInstituteInfo(msg)
end

--- *s2c* 加入势力结果返回 21004
function __onResJoinForcesHandler(self,msg)
    GameDispatcher:dispatchEvent(EventName.REQ_JOIN_RESULT,msg.result)
    if(msg.result == 1) then
        GameDispatcher:dispatchEvent(EventName.OPEN_COVENANT_MAIN_PANEL)
    end
end

--- *s2c* 更换势力结果返回 21006
function __onResChangeForcesHandler(self,msg)
    GameDispatcher:dispatchEvent(EventName.REQ_CHANGE_RESULT,msg.result)


    if(msg.result == 1) then
        GameDispatcher:dispatchEvent(EventName.OPEN_COVENANT_MAIN_PANEL)
    end
end

--- *s2c* 领取声望等阶奖励返回 21008
function __onGainPrestigeAwardHandler(self,msg)
    if(msg.result == 1) then
        logInfo("声望升级成功")
        self:openCovenantLvUpPanel(msg)
        GameDispatcher:dispatchEvent(EventName.UPDATE_COVENANT_HQ_PANEL)
    else
        logInfo("声望升级失败")
    end
end

-- 响应所有助手信息
function __onResAllHelperDataHandler(self, msg)
    covenant.CovenantManager:parseAllHelperData(msg.all_forces_helper_info)
    GameDispatcher:dispatchEvent(EventName.RES_COVENANT_HELPER_DATA, {helperId = nil})
end

-- 响应助手信息
function __onResHelperDataHandler(self, msg)
    covenant.CovenantManager:parseHelperData(msg.one_forces_helper_info[1])
    GameDispatcher:dispatchEvent(EventName.RES_COVENANT_HELPER_DATA, {helperId = msg.helper_id})
end

-- 响应助手升级结果
function __onResHelperLvlUpHandler(self, msg)
    if(msg.result == 1)then
        local helperVo = covenant.CovenantManager:getHelperVo(msg.helper_id)
        if(helperVo)then
            helperVo.lvl = msg.level
            -- gs.Message.Show("升级成功")
            GameDispatcher:dispatchEvent(EventName.RES_COVENANT_HELPER_LVL_UP, {helperId = msg.helper_id})
        else
            logError(string.format("响应助手升级结果：找不到助手id：%s", msg.helper_id))
        end
    else
        gs.Message.Show(_TT(29552))
    end
end

-- 响应助力英雄结果
function __onResHelpHeroSelectHandler(self, msg)
    if(msg.result == 1)then
        gs.Message.Show(_TT(29553))
        GameDispatcher:dispatchEvent(EventName.RES_COVENANT_HELP_HERO_SELECT, {helperId = msg.helper_id})
    else
        gs.Message.Show(_TT(29554))
    end
end

function __onForcesLvUpHandler(self,msg)
    --covenant.CovenantManager:setLevelUpInfo(msg)
    GameDispatcher:dispatchEvent(EventName.START_SHOW_FORCES_LV_UP,msg)
    --GameDispatcher:dispatchEvent(EventName.START_SHOW_FORCES_LV_UP,{forces_id = 1,pre_Lv = 1,cur_Lv = 3})
end


function __onForcesTalentHandler(self,msg)
    covenant.CovenantManager:setForcesTalentData(msg)
end

function __onForcesTalentUpdateHanlder(self,msg)
    covenant.CovenantManager:updateForcesTalentData(msg)
end

function __onForcesTalentUpResultHandler(self,msg)
    covenant.CovenantManager:talentUpdateResult(msg)
end

function __onUpdateInstituteHandler(self,msg)
    covenant.CovenantManager:updateInstitute(msg)
end

--- *s2c* 任务信息面板 21070
function __onTaskInfoHandler(self,msg)
    covenant.CovenantManager:parseTaskServerData(msg)
end

--- *s2c* 领取任务奖励 21072
function __onGainTaskHandler(self,msg)
    covenant.CovenantManager:updateTaskServerResult(msg)
end

--- *s2c* 更新任务进度 21073
function __onUpdateTaskHandler(self,msg)
    covenant.CovenantManager:updateSingleTask(msg)
end
------------------------------------------------------------------------ 请求 ------------------------------------------------------------------------

--- *c2s* 提升声望等级 21002
function __onGetPrestigeStageAwardHandler(self)
    SOCKET_SEND(Protocol.CS_UPGRADE_PRESTIGE)
end

-- 请求研究所面板
function __onReqHelperDataHandler(self, args)
    --- *c2s* 研究所面板信息 21020
    SOCKET_SEND(Protocol.CS_INSTITUTE_PANEL)
end

--请求天赋升级
function __onReqCovenantSkillUpHandler(self,args)
    SOCKET_SEND(Protocol.CS_UPGRADE_TALENT, { talent_id = args.skillId })
end

function __onReqInstituteHandler(self,args)
    SOCKET_SEND(Protocol.CS_INSTITUTE_UPGRADE)
end 

function onReqTaskHandler(self,args)
    SOCKET_SEND(Protocol.CS_GAIN_FORCES_TASK_AWARD,{task_list = args.list})
end

------------------------------------------------------------------------ 打开盟约升级顶层窗口 ------------------------------------------------------------------------
function __onShowForcesLvUpHandler(self,args)
    if self.mCovenantLvUpView == nil then
        self.mCovenantLvUpView = covenant.CovenantLvUpView.new()
    end
    self.mCovenantLvUpView:start(args)
end
------------------------------------------------------------------------ 打开盟约主界面 ------------------------------------------------------------------------
function onOpenCovenantMainPanel(self)
    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.COVENANT)

    -- self.mCovenantMainPanel = covenant.CovenantMainPanel.new()
    -- self.mCovenantMainPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainPanelHandler, self)
    -- self.mCovenantMainPanel:open()
end

function onDestroyMainPanelHandler(self)
    self.mCovenantMainPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainPanelHandler, self)
    self.mCovenantMainPanel = nil
end

------------------------------------------------------------------------ 打开盟约总部面板 ------------------------------------------------------------------------
function onOpenCovenantHQPanel(self)
    if self.mCovenantHQPanel == nil then
        self.mCovenantHQPanel = covenant.CovenantHQPanel.new()
        self.mCovenantHQPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHQPanelHandler, self)
    end
    self.mCovenantHQPanel:open()
end


function onDestroyHQPanelHandler(self)
    self.mCovenantHQPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestroyHQPanelHandler,self)
    self.mCovenantHQPanel = nil
end

------------------------------------------------------------------------ 打开盟约选择面板 ------------------------------------------------------------------------

function onOpenCovenantSelectPanel(self,isChange)
    self:onOpenCovenantMainPanel()
end


function onDestroySelectPanelHandler(self)
    self.mCovenantSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySelectPanelHandler, self)
    self.mCovenantSelectPanel = nil
end

------------------------------------------------------------------------ 打开盟约选择详细信息面板 ------------------------------------------------------------------------
function onOpenCovenantSelectInfoPanelHandler(self,args)
    local forcesId = covenant.CovenantManager:getForcesId()

    if args.showInfo == true then

    else
        if forcesId == args.id then
            gs.Message.Show(_TT(41029));
            return
        end

        local runChangeTime = covenant.CovenantManager:getChangeTime()
        local clientTime = GameManager:getClientTime()
        local reamainTime  =  runChangeTime - clientTime
    
        local isChangeOn = reamainTime < 0
    
        if isChangeOn == false then
            GameDispatcher:dispatchEvent(EventName.OPEN_COVENANT_SELECT_NOTCHANGE_PANEL)
            return
        end

    end

    if self.mCovenantSelectInfoPanel == nil then
        self.mCovenantSelectInfoPanel = covenant.CovenantSelectInfoPanel.new()
        self.mCovenantSelectInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySelectInfoPanelHandler, self)
    end
    self.mCovenantSelectInfoPanel:open(args)
    --self.mCovenantSelectInfoPanel:show(args)
end

function onDestroySelectInfoPanelHandler(self)
    self.mCovenantSelectInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySelectInfoPanelHandler, self)
    self.mCovenantSelectInfoPanel = nil
end

------------------------------------------------------------------------ 打开盟约选择确认面板 ------------------------------------------------------------------------

function onOpenCovenantSelectSurePanelHandler(self,args)
    if self.mCovenantSelectSurePanel == nil then
        self.mCovenantSelectSurePanel = covenant.CovenantSelectSurePanel.new()
        self.mCovenantSelectSurePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySelectSurePanelHandler, self)
    end
    self.mCovenantSelectSurePanel:open()
    self.mCovenantSelectSurePanel:show(args)
end

function onDestroySelectSurePanelHandler(self)
    self.mCovenantSelectSurePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySelectSurePanelHandler, self)
    self.mCovenantSelectSurePanel = nil
end

------------------------------------------------------------------------ 打开盟约选择不能变更面板 ------------------------------------------------------------------------

function onOpenCovenantSelectNotChangePanelHandler(self)
    if self.mCovenantSelectNotChangePanel == nil then
        self.mCovenantSelectNotChangePanel = covenant.CovenantSelectNotChangePanel.new()
        self.mCovenantSelectNotChangePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySelectNotChangePanelHandler, self)
    end
    self.mCovenantSelectNotChangePanel:open()
end

function onDestroySelectNotChangePanelHandler(self)
    self.mCovenantSelectNotChangePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySelectNotChangePanelHandler, self)
    self.mCovenantSelectNotChangePanel = nil
end

------------------------------------------------------------------------ 打开盟约商店面板 ------------------------------------------------------------------------
function onOpenCovenantShopPanel(self, args)
    if self.mCovenantShopPanel == nil then
        self.mCovenantShopPanel = covenant.CovenantShopPanel.new()
   
        self.mCovenantShopPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShopPanelHandler, self)
    end
  
    self.mCovenantShopPanel:open(args)
end

function onDestroyShopPanelHandler(self)
    self.mCovenantShopPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShopPanelHandler, self)
    self.mCovenantShopPanel = nil
end

------------------------------------------------------------------------ 打开盟约商店物品信息面板 ------------------------------------------------------------------------
function onOpenCovenantShopInfoPanel(self, args)
    if self.mCovenantShopInfoPanel == nil then
        self.mCovenantShopInfoPanel = covenant.CovenantShopInfoPanel.new()
   
        self.mCovenantShopInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShopInfoPanelHandler, self)
    end
  
    self.mCovenantShopInfoPanel:open(args)
end

function onDestroyShopInfoPanelHandler(self)
    self.mCovenantShopInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShopInfoPanelHandler, self)
    self.mCovenantShopInfoPanel = nil
end

------------------------------------------------------------------------ 打开盟约助手培养面板 ------------------------------------------------------------------------
function onOpenHelperBuildPanel(self, args)

    if self.mCovenantHelperBuildPanel == nil then
        self.mCovenantHelperBuildPanel = covenant.CovenantInstitutePanel.new()
        self.mCovenantHelperBuildPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHelperBuildPanelHandler, self)
    end

    self.mCovenantHelperBuildPanel:open({helperId = args.helperId})
end

-- ui销毁
function onDestroyHelperBuildPanelHandler(self)
    self.mCovenantHelperBuildPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHelperBuildPanelHandler, self)
    self.mCovenantHelperBuildPanel = nil
end

------------------------------------------------------------------------ 打开盟约助手助力英雄选择界面 ------------------------------------------------------------------------
function __onOpenHelpHeroSelectPanelHandler(self, args)
    if self.m_covenantHelpHeroSelectPanel == nil then
        self.m_covenantHelpHeroSelectPanel = covenant.CovenantHelpHeroSelectPanel.new()
        self.m_covenantHelpHeroSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHelpHeroSelectPanelHandler, self)
    end
    self.m_covenantHelpHeroSelectPanel:open(args)
end

function onDestroyHelpHeroSelectPanelHandler(self)
    self.m_covenantHelpHeroSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHelpHeroSelectPanelHandler, self)
    self.m_covenantHelpHeroSelectPanel = nil
end

------------------------------------------------------------------------ 打开盟约技能界面 ------------------------------------------------------------------------

function __onOpenSkillPanelHandler(self,args)
    if self.mSkillPanel == nil then
        self.mSkillPanel = covenant.CovenantSkillPanel.new()
        self.mSkillPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestroySkillPanelHandler,self)
    end
    self.mSkillPanel:open(args)
end

function onDestroySkillPanelHandler(self)
    self.mSkillPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestroySkillPanelHandler,self)
    self.mSkillPanel = nil
end

------------------------------------------------------------------------ 打开盟约任务界面 ------------------------------------------------------------------------
function onOpenCovenantTaskHandler(self,args)
    if self.mTaskPanel == nil then
        self.mTaskPanel = covenant.CovenantTaskTabView.new()
        self.mTaskPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestroyTaskPanelHandler,self)
    end
    self.mTaskPanel:open(args)
end

function onDestroyTaskPanelHandler(self)
    self.mTaskPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestroyTaskPanelHandler,self)
    self.mTaskPanel = nil
end

-- function onUpdateCovenantFlagHandler(self,args)
--     local isFlag = false
--     isFlag = covenant.CovenantManager:getRedFlag()
--     mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_COVENANT,isFlag)    
-- end

---------------------------------------------------打开盟约升级成功弹窗--------------------------------------------
function openCovenantLvUpPanel(self,args)
    if self.mCovenantLvUpPanel == nil then
        self.mCovenantLvUpPanel = covenant.CovenantLvUpPanel.new()
        self.mCovenantLvUpPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.destoryCovenantLvUpPanel,self)
    end
    self.mCovenantLvUpPanel:open(args)
end

function destoryCovenantLvUpPanel(self)
    self.mCovenantLvUpPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.destoryCovenantLvUpPanel,self)
    self.mCovenantLvUpPanel = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(29554):	"助力失败"
	语言包: _TT(29553):	"助力成功"
	语言包: _TT(29552):	"升级失败"
]]
