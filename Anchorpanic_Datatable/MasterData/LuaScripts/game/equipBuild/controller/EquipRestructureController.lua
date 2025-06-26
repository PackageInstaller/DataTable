module("equipBuild.EquipRestructureController", Class.impl(Controller))

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
    -- 请求装备重构
    GameDispatcher:addEventListener(EventName.REQ_EQUIP_RESTRUCTURE, self.__onReqEquipRestructureHandler, self)
    -- 确认装备重构（首次重构不需要确认）
    GameDispatcher:addEventListener(EventName.REQ_EQUIP_CONFIRM_RESCTUCTURE, self.__onReqEquipConfirmRestructureHandler, self)
    -- 打开装备重构详细信息面板
    GameDispatcher:addEventListener(EventName.OPEN_EQUIP_RESTRUCTURE_DETAIL_PANEL, self.__onOpenEquipRestructureDetailHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 英雄装备重构 13029
        SC_EQUIP_RECONSTRUCT = self.__onResEquipRestructureHandler,
        --- *s2c* 英雄装备重构确认 13033
        SC_EQUIP_RECONSTRUCT_CONFIRM = self.__onResEquipConfirmRestructureHandler,
    }
end

---------------------------------------------------------------请求------------------------------------------------------------------
-- 请求装备重构
function __onReqEquipRestructureHandler(self, args)
    --- *c2s* 英雄装备重构 13028
    SOCKET_SEND(Protocol.CS_EQUIP_RECONSTRUCT, {hero_id = args.heroId, equip_id = args.equipId, cost_id = args.costId})
end

-- 确认装备重构（首次重构不需要确认）
function __onReqEquipConfirmRestructureHandler(self, args)
    --- *c2s* 英雄装备重构确认 13032
    SOCKET_SEND(Protocol.CS_EQUIP_RECONSTRUCT_CONFIRM, {})
end
---------------------------------------------------------------响应------------------------------------------------------------------
-- 英雄装备重构
function __onResEquipRestructureHandler(self, msg)
    -- msg.result
    -- msg.hero_id
    -- msg.equip_id
    if(msg.result <= 0)then
        gs.Message.Show(_TT(71421))
    else
        local heroId = msg.hero_id
        local equipId = msg.equip_id
        local nuclearAttr = msg.nuclear_attr
        local skillEffect = msg.skill_effect

        local selectEquipVo = equipBuild.EquipBuildManager:getEquipVo(equipId, heroId)
        local oldEquipVo = selectEquipVo:clone()
        local curEquipVo = selectEquipVo:clone()
		curEquipVo:setNuclearAttr(nuclearAttr)
		curEquipVo:setSkillEffect(skillEffect)

        local function onShowRestructureSucPanelHandler(args)
            if self.m_restructureSucPanel == nil then
                self.m_restructureSucPanel = equipBuild.EquipRestructureSucPanel.new()
                local function onSucPanelDestroyHandler(self)
                    self.m_restructureSucPanel:removeEventListener(View.EVENT_VIEW_DESTROY, onSucPanelDestroyHandler, self)
                    self.m_restructureSucPanel = nil
                end
                self.m_restructureSucPanel:addEventListener(View.EVENT_VIEW_DESTROY, onSucPanelDestroyHandler, self)
            end
            self.m_restructureSucPanel:open({oldEquipVo = args.oldEquipVo, curEquipVo = args.curEquipVo})
        end
        onShowRestructureSucPanelHandler({oldEquipVo = oldEquipVo, curEquipVo = curEquipVo})

        local function attrUpdate(self, args)
            selectEquipVo:removeEventListener(selectEquipVo.UPDATE_EQUIP_DETAIL_DATA, attrUpdate, self)
            GameDispatcher:dispatchEvent(EventName.UPDATE_EQUIP_RESTRUCTURE, {heroId = heroId, equipId = equipId})
        end
        -- 后端确保先发结果再发装备属性更新
        selectEquipVo:removeEventListener(selectEquipVo.UPDATE_EQUIP_DETAIL_DATA, attrUpdate, self)
        selectEquipVo:addEventListener(selectEquipVo.UPDATE_EQUIP_DETAIL_DATA, attrUpdate, self)
    end
end

-- 英雄装备重构确认结果
function __onResEquipConfirmRestructureHandler(self, msg)
    if(msg.result <= 0)then
        gs.Message.Show(_TT(71422))
    else
    end
end

------------------------------------------------------------------------ 打开英雄装备重构详细信息界面 ------------------------------------------------------------------------
function __onOpenEquipRestructureDetailHandler(self, args)
    if self.m_restructureDetailPanel == nil then
        self.m_restructureDetailPanel = equipBuild.EquipRestructureDetailPanel.new()
        self.m_restructureDetailPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRestructureDetailPanelHandler, self)
    end
    self.m_restructureDetailPanel:open(args.equipVo)
end

function onDestroyRestructureDetailPanelHandler(self)
    self.m_restructureDetailPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRestructureDetailPanelHandler, self)
    self.m_restructureDetailPanel = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(71422):	"装备重构失败"
	语言包: _TT(71421):	"装备重构预览失败"
]]
