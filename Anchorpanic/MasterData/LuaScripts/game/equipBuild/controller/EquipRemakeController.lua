module("equipBuild.EquipRemakeController", Class.impl(Controller))

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
    -- 请求装备改造
    GameDispatcher:addEventListener(EventName.REQ_EQUIP_REMAKE, self.__onReqEquipRemakeHandler, self)
    -- 确认装备改造（首次改造不需要确认）
    GameDispatcher:addEventListener(EventName.REQ_EQUIP_CONFIRM_REMAKE, self.__onReqEquipConfirmRemakeHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_EQUIP_REMAKE_UP_AGENT_OPT_VIEW,self.__onOpenEquipRemakeUpAgentOptViewHandler, self)
    
    GameDispatcher:addEventListener(EventName.OPEN_EQUIP_REMAKESUC_PANEL, self.__onOpenEquipRemakeSucPanelHandler, self)
    
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 英雄装备改造 13027
        SC_EQUIP_REMAKE = self.__onResEquipRemakeHandler,
        --- *s2c* 确认改造结果 13029
        SC_EQUIP_REMAKE_CONFIRM = self.__onResEquipConfirmRemakeHandler,
    }
end

---------------------------------------------------------------请求------------------------------------------------------------------
-- 请求装备改造
function __onReqEquipRemakeHandler(self, args)
    --- *c2s* 英雄装备改造 13026
    SOCKET_SEND(Protocol.CS_EQUIP_REMAKE, {hero_id = args.heroId, equip_id = args.equipId, pos = args.remakePos, cost_id = args.costId})
end

-- 确认装备改造（首次改造不需要确认）
function __onReqEquipConfirmRemakeHandler(self, args)
    Debug:log_info("","SOCKET_SEND(Protocol.CS_EQUIP_REMAKE_CONFIRM, {})")
    --- *c2s* 确认改造结果 13028
    SOCKET_SEND(Protocol.CS_EQUIP_REMAKE_CONFIRM, {})
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 英雄装备改造
function __onResEquipRemakeHandler(self, msg)
    if(msg.result <= 0)then
        gs.Message.Show(_TT(71419))
    else
        local heroId = msg.hero_id
        local equipId = msg.equip_id
        local remakePos = msg.pos
        local preRemakeAttr = msg.new_attr
        local selectEquipVo = equipBuild.EquipBuildManager:getEquipVo(equipId, heroId)
        local oldEquipVo = selectEquipVo:clone()
        local curEquipVo = selectEquipVo:clone()
        curEquipVo:setRemakeAttr(preRemakeAttr)

        local isAgentOpt = equipBuild.EquipRemakeManager:getIsAgentOpt()
        if isAgentOpt then
            GameDispatcher:dispatchEvent(EventName.UPDATE_EQUIP_REMAKE_UP_AGENT_OPT_VIEW,{oldEquipVo = oldEquipVo, curEquipVo = curEquipVo, remakePos = remakePos})
        else
            self:__onOpenEquipRemakeSucPanelHandler({oldEquipVo = oldEquipVo, curEquipVo = curEquipVo, remakePos = remakePos})
        end
        local function attrUpdate(self, args)
            selectEquipVo:removeEventListener(selectEquipVo.UPDATE_EQUIP_DETAIL_DATA, attrUpdate, self)
            GameDispatcher:dispatchEvent(EventName.UPDATE_EQUIP_REMAKE, {heroId = heroId, equipId = equipId, remakePos = remakePos})
        end
        -- 后端确保先发结果再发装备属性更新
        selectEquipVo:removeEventListener(selectEquipVo.UPDATE_EQUIP_DETAIL_DATA, attrUpdate, self)
        selectEquipVo:addEventListener(selectEquipVo.UPDATE_EQUIP_DETAIL_DATA, attrUpdate, self)
    end
end

-- 英雄装备改造确认结果
function __onResEquipConfirmRemakeHandler(self, msg)
    if(msg.result <= 0)then
        gs.Message.Show(_TT(71420))
        if (self.m_remakeSucPanel) then
            self.m_remakeSucPanel:close()
        end
    else
        Debug:log_info("","__onResEquipConfirmRemakeHandler")
        if (self.m_remakeSucPanel) then
            if equipBuild.EquipRemakeManager:getAgentSuc() then
                self.m_remakeSucPanel:showConfirmAgentSucc()
            else
                self.m_remakeSucPanel:showConfirmSucc()
            end
            
        end
    end
end

------------------------------------------------------------------------ 打开英雄装备改造成功界面 ------------------------------------------------------------------------
function __onOpenEquipRemakeSucPanelHandler(self, args)
    if self.m_remakeSucPanel == nil then
        self.m_remakeSucPanel = equipBuild.EquipRemakeSucPanel.new()
        self.m_remakeSucPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStrengthenSucPanelHandler, self)
    end
    local oldEquipVo = args.oldEquipVo
    local curEquipVo = args.curEquipVo
    local remakePos = args.remakePos
    self.m_remakeSucPanel:open({oldEquipVo = oldEquipVo, curEquipVo = curEquipVo, remakePos = remakePos})
end

function onDestroyStrengthenSucPanelHandler(self)
    self.m_remakeSucPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStrengthenSucPanelHandler, self)
    self.m_remakeSucPanel = nil
end
--------------------------------------- 打开英雄装备改造界面 ------------------------------------------------
function __onOpenEquipRemakeViewHandler(self, args)
    if self.mRemakeUpView == nil then
        self.mRemakeUpView = equipBuild.EquipRemakeUpView.new()
        self.mRemakeUpView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRemakeUpViewHandler, self)
    end
    self.mRemakeUpView:open(args)
end

function onDestroyRemakeUpViewHandler(self)
    self.mRemakeUpView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRemakeUpViewHandler, self)
    self.mRemakeUpView = nil
end


function __onOpenEquipRemakeUpAgentOptViewHandler(self,args)
    if self.mRemakeUpAgentOptView == nil then
        self.mRemakeUpAgentOptView = equipBuild.EquipRemakeUpAgentOptView.new()
        self.mRemakeUpAgentOptView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRemakeUpAgentOptViewHandler, self)
    end
    self.mRemakeUpAgentOptView:open(args)
end

function onDestroyRemakeUpAgentOptViewHandler(self)
    self.mRemakeUpAgentOptView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRemakeUpAgentOptViewHandler, self)
    self.mRemakeUpAgentOptView = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(71420):	"装备改造失败"
	语言包: _TT(71419):	"装备改造预览失败"
]]
