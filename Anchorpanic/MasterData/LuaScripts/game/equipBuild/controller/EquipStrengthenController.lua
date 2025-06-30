module("equipBuild.EquipStrengthenController", Class.impl(Controller))

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
    -- 请求装备强化
    GameDispatcher:addEventListener(EventName.REQ_EQUIP_STRENGTHEN, self.__onReqEquipStrenghtenHandler, self)
    -- 请求装备突破
    GameDispatcher:addEventListener(EventName.REQ_EQUIP_BREAKUP, self.__onReqEquipBrakUpHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_EQUIP_STRENGTHEN_UP_VIEW, self.__onOpenEquipStrengthenViewHandler, self)
    
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 英雄装备强化 13021
        SC_EQUIP_STRENGTH = self.__onResEquipStrengthenHandler,
        --- *s2c* 英雄装备突破 13023
        SC_EQUIP_BREAKUP = self.__onResEquipBreakUpHandler,
    }
end

---------------------------------------------------------------请求------------------------------------------------------------------
-- 请求装备强化
function __onReqEquipStrenghtenHandler(self, args)
    --- *c2s* 英雄装备强化 13020
    local list = {}
    for i, v in ipairs(args.costList) do
        local pt_item_num = { item_id = v.id, num = v.count }
        table.insert(list, pt_item_num)
    end
    SOCKET_SEND(Protocol.CS_EQUIP_STRENGTH, { hero_id = args.heroId, equip_id = args.equipId, cost_list = list },Protocol.SC_EQUIP_STRENGTH)
end

-- 请求装备突破
function __onReqEquipBrakUpHandler(self, args)
    --- *c2s* 英雄装备突破 13022
    SOCKET_SEND(Protocol.CS_EQUIP_BREAKUP, { hero_id = args.heroId, equip_id = args.equipId },Protocol.SC_EQUIP_BREAKUP)
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 英雄装备强化
function __onResEquipStrengthenHandler(self, msg)
    local equipPos = msg.equip_pos
    if (equipPos ~= PropsEquipSubType.SLOT_7) then
        if msg.result <= 0 then
            gs.Message.Show(_TT(4371))
        else
            local strengthenLvl = msg.strength_lv
            local strengthenExp = msg.strength_exp
            local curEquipVo = equipBuild.EquipStrengthenManager:getOpenEquipVo()
            if curEquipVo then
                local oldEquipVo = curEquipVo:clone()
                local function attrUpdate(self, args)
                    curEquipVo:removeEventListener(curEquipVo.UPDATE_EQUIP_DETAIL_DATA, attrUpdate, self)
    
                    curEquipVo.strengthenLvl = strengthenLvl
                    curEquipVo.strengthenExp = strengthenExp
    
                    if (oldEquipVo.strengthenLvl == curEquipVo.strengthenLvl) then
                        gs.Message.Show(_TT(4372))
                    else
                        self:onEquipStrengthenSucPanel({
                            oldEquipVo = oldEquipVo,
                            curEquipVo = curEquipVo,
                            isBreakUp = false
                        })
                    end
    
                    GameDispatcher:dispatchEvent(EventName.UPDATE_EQUIP_STRENGTHEN_PANEL, {
                        oldEquipVo = oldEquipVo,
                        curEquipVo = curEquipVo
                    })
    
                end
                curEquipVo:addEventListener(curEquipVo.UPDATE_EQUIP_DETAIL_DATA, attrUpdate, self)
            end
        end
    end
end

-- 英雄装备突破
function __onResEquipBreakUpHandler(self, msg)
    local equipPos = msg.equip_pos
    -- 是否手环
    if(equipPos == PropsEquipSubType.SLOT_7)then
        -- 手环的放在BraceletsStrengthenController处理
    else
        if (msg.result <= 0) then
            gs.Message.Show(_TT(71425))
        else
            local tuPoRank = msg.breakup_rank
            local heroId = msg.hero_id
            local equipId = msg.equip_id
            local curEquipVo = equipBuild.EquipBuildManager:getEquipVo(equipId, heroId)
            local oldEquipVo = curEquipVo:clone()
            local function attrUpdate(self, args)
                curEquipVo:removeEventListener(curEquipVo.UPDATE_EQUIP_DETAIL_DATA, attrUpdate, self)
                self:__onOpenBreakUpSucPanelHandler({ oldEquipVo = oldEquipVo })
                -- curEquipVo.tuPoRank = tuPoRank
                -- self:onEquipStrengthenSucPanel({
                --     oldEquipVo = oldEquipVo,
                --     curEquipVo = curEquipVo,
                --     isBreakUp = false
                -- })
                GameDispatcher:dispatchEvent(EventName.UPDATE_EQUIP_BREAKUP_PANEL, { heroId = heroId, equipId = equipId })
            end
            -- 后端确保先发结果再发装备属性更新
            curEquipVo:addEventListener(curEquipVo.UPDATE_EQUIP_DETAIL_DATA, attrUpdate, self)
            curEquipVo.tuPoRank = tuPoRank
        end
    end
end

--------------------------------------- 打开英雄装备突破成功界面 --------------------------------------------
function __onOpenBreakUpSucPanelHandler(self, args)

    local oldEquipVo = args.oldEquipVo
    local curEquipVo = equipBuild.EquipBuildManager:getEquipVo(oldEquipVo.id, oldEquipVo.heroId)
    function onDestroyBreakUpSucPanelHandler()
        self.m_breakUpSucPanel:removeEventListener(View.EVENT_VIEW_DESTROY, onDestroyBreakUpSucPanelHandler, self)
        self.m_breakUpSucPanel = nil
    end

    if self.m_breakUpSucPanel == nil then
        self.m_breakUpSucPanel = equipBuild.EquipBreakUpSucPanel.new()
        self.m_breakUpSucPanel:addEventListener(View.EVENT_VIEW_DESTROY, onDestroyBreakUpSucPanelHandler, self)
    end
    self.m_breakUpSucPanel:open({ oldEquipVo = oldEquipVo, curEquipVo = curEquipVo })
end

function __onOpenUnlockAttrPanelHandler(self,args)
    if self.m_unlockAttrPanel == nil then
        self.m_unlockAttrPanel = equipBuild.EquipBreakUpSucUnlockAttrPanel.new()
        self.m_unlockAttrPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEUnlockAttrPanelHandler, self)
    end
    self.m_unlockAttrPanel:open(args)
end

function onDestroyEUnlockAttrPanelHandler(self)
    self.m_unlockAttrPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEUnlockAttrPanelHandler, self)
    self.m_unlockAttrPanel = nil
end



--------------------------------------- 打开英雄装备强化界面 ------------------------------------------------
function __onOpenEquipStrengthenViewHandler(self, args)
    if self.mStrengthenUpView == nil then
        self.mStrengthenUpView = equipBuild.EquipStrengthenUpView.new()
        self.mStrengthenUpView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStrengthenUpViewHandler, self)
    end
    self.mStrengthenUpView:open(args)
end

function onDestroyStrengthenUpViewHandler(self)
    self.mStrengthenUpView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStrengthenUpViewHandler, self)
    self.mStrengthenUpView = nil
end

function onEquipStrengthenSucPanel(self, args)
    if self.mEquipStrengthenSucPanel == nil then
        self.mEquipStrengthenSucPanel = equipBuild.EquipStrengthenSucPanel.new()
        self.mEquipStrengthenSucPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStrengthenSucPanelHandler, self)
    end
    self.mEquipStrengthenSucPanel:open(args)
end

function onDestroyStrengthenSucPanelHandler(self)
    self.mEquipStrengthenSucPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStrengthenSucPanelHandler, self)
    self.mEquipStrengthenSucPanel = nil
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(71425):	"装备突破失败"
	语言包: _TT(71424):	"强化成功"
	语言包: _TT(71423):	"装备强化失败"
]]
