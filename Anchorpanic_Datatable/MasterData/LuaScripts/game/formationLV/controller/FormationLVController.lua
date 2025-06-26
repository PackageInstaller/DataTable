--[[ 
-----------------------------------------------------
@filename       : FormationLVController
@Description    : 毛驴
@date           : 2021-05-12 17:00:26
@Author         : lyx
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("formationLV.FormationLVController", Class.impl(Controller))


--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    -- 打开队形驴界面
    GameDispatcher:addEventListener(EventName.OPEN_FORMATIONLV_PANEL, self.onOpenFormationLVPanelHandler, self)
    -- 打开解锁成功界面
    GameDispatcher:addEventListener(EventName.OPEN_UNLOCKLV_SUCCESS, self.onOpenUnlockLVSuccessHandler, self)
    -- 请求解锁驴
    GameDispatcher:addEventListener(EventName.REQ_UNLOCKLV, self.onReqUnlockLV, self)
    --请求变更驴
    GameDispatcher:addEventListener(EventName.REQ_CHANGELV, self.onReqChangeLV, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 所有驴信息  12130
        SC_PET_PANEL = self.onResAllLV,
        --- *s2c* 解锁驴返回 12132
        SC_PET_UNLOCK = self.onResUnlockLV,
    }
end

---------------------------------RES--------------------------------------------------------
function onResAllLV(self, msg)
    formationLV.FormationLVManager:praseMsg(msg)
end

function onResUnlockLV(self, msg)
    if msg.result == 1 then 
        local id = msg.pet_id
        formationLV.FormationLVManager:unlockPet(id)
        self:onOpenUnlockLVSuccessHandler(id)
        GameDispatcher:dispatchEvent(EventName.REFLASH_FORMATION_PANEL)
    else
        gs.Message.Show("未达到解锁条件")
    end
    --formationLV.FormationLVManager:praseMsg(msg)
end

---------------------------------REQ--------------------------------------------------------

--- *s2c* 解锁驴请求 12131
function onReqUnlockLV(self, lvId)
    SOCKET_SEND(Protocol.CS_PET_UNLOCK, {pet_id = lvId}, Protocol.SC_PET_UNLOCK)
end

function onReqChangeLV(self, args)
    -- 使用阵型数据变更请求
    formation.FormationManager:setUsePetByTeamId(args.teamId, args.petId)
    GameDispatcher:dispatchEvent(EventName.REFLASH_FORMATION_PANEL)
end

---------------------------------VIEW-------------------------------------------------------
function onOpenFormationLVPanelHandler(self, args)
    if self.mFormationLVPanel == nil then
        self.mFormationLVPanel = formationLV.FormationLVPanel.new()
        self.mFormationLVPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFormationLVPanelHandler, self)
    end
    self.mFormationLVPanel:open(args)
end

function onDestroyFormationLVPanelHandler(self)
    self.mFormationLVPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFormationLVPanelHandler, self)
    self.mFormationLVPanel = nil
end

function onOpenUnlockLVSuccessHandler(self, args)
    if self.mUnlockLVPanel == nil then
        self.mUnlockLVPanel = formationLV.FormationLVUnlockSuccessPanel.new()
        self.mUnlockLVPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyUnlockLVSuccessHandler, self)
    end
    self.mUnlockLVPanel:open(args)
end

function onDestroyUnlockLVSuccessHandler(self)
    self.mUnlockLVPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyUnlockLVSuccessHandler, self)
    self.mUnlockLVPanel = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
