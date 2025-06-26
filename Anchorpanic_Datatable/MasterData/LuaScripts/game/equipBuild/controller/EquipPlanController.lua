--[[ 
-----------------------------------------------------
@filename       : EquipPlanController
@Description    : 模组方案控制器
@date           : 2023-12-6 00:00:00
@Author         : Zzz
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("equipBuild.EquipPlanController", Class.impl(Controller))

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
    -- 打开装备方案界面
    GameDispatcher:addEventListener(EventName.OPEN_EQUIP_PLANE_PANEL, self.__onOpenEquipPlanePanelHandler, self)
    -- 打开装备方案名修改界面
    GameDispatcher:addEventListener(EventName.OPEN_EQUIP_PLANE_CHANGE_NAME_PANEL, self.__onOpenEquipPlaneChangeNamePanelHandler, self)

    -- 请求获取模组方案列表信息
    GameDispatcher:addEventListener(EventName.REQ_EQUIP_PLANE_LIST_DATA, self.__onReqEquipPlanListDataHandler, self)
    -- 请求保存模组方案
    GameDispatcher:addEventListener(EventName.REQ_EQUIP_PLANE_SAVE, self.__onReqEquipPlanSaveHandler, self)
    -- 请求更改模组方案名称
    GameDispatcher:addEventListener(EventName.REQ_EQUIP_PLANE_CHANGE_NAME, self.__onReqEquipPlanChangeNameHandler, self)
    -- 请求删除模组方案
    GameDispatcher:addEventListener(EventName.REQ_EQUIP_PLANE_DELETE, self.__onReqEquipPlanDeleteHandler, self)
    -- 请求装备模组方案
    GameDispatcher:addEventListener(EventName.REQ_EQUIP_PLANE_WEAR, self.__onReqEquipPlanWearHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 获取模组方案信息 12191
        SC_GET_ALL_CHIP_PLAN = self.onEquipPlanListDataHandler, 
        --- *s2c* 保存模组方案 12193
        SC_SAVE_CHIP_PLAN = self.onEquipPlanSaveResultHandler, 
        --- *s2c* 更改模组方案名称 12195
        SC_CHANGE_CHIP_PLAN_NAME = self.onEquipPlanChangeNameResultHandler, 
        --- *s2c* 删除模组方案 12197
        SC_DELETE_CHIP_PLAN = self.onEquipPlanDeleteResultHandler, 
        --- *s2c* 装备模组方案 12199
        SC_EQUIP_CHIP_PLAN = self.onEquipPlanWearResultHandler, 
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
--- *s2c* 获取模组方案信息 12191
function onEquipPlanListDataHandler(self, msg)
    equipBuild.EquipPlanManager:parseMsgEquipPlanListData(msg)
end

--- *s2c* 保存模组方案 12193
function onEquipPlanSaveResultHandler(self, msg)
    equipBuild.EquipPlanManager:parseMsgEquipPlanSaveResult(msg)
end

--- *s2c* 更改模组方案名称 12195
function onEquipPlanChangeNameResultHandler(self, msg)
    equipBuild.EquipPlanManager:parseMsgEquipPlanChangeNameResult(msg)
end

--- *s2c* 删除模组方案 12197
function onEquipPlanDeleteResultHandler(self, msg)
    equipBuild.EquipPlanManager:parseMsgEquipPlanDeleteResult(msg)
end

--- *s2c* 装备模组方案 12199
function onEquipPlanWearResultHandler(self, msg)
    equipBuild.EquipPlanManager:parseMsgEquipPlanWearResult(msg)
end

---------------------------------------------------------------请求------------------------------------------------------------------
-- 请求获取模组方案列表信息
function __onReqEquipPlanListDataHandler(self, args)
    --- *c2s* 获取模组方案信息 12190
    SOCKET_SEND(Protocol.CS_GET_ALL_CHIP_PLAN, nil, Protocol.SC_GET_ALL_CHIP_PLAN)
end

-- 请求保存模组方案
function __onReqEquipPlanSaveHandler(self, args)
    local equipPlanMsgVo = {}
    equipPlanMsgVo.id = args.equipPlanVo.id
    equipPlanMsgVo.name = args.equipPlanName
    equipPlanMsgVo.chip_list = {}
    for pos, equipId in pairs(args.equipPlanVo.equipPosDic) do
        table.insert(equipPlanMsgVo.chip_list, {pos = pos, equip_id = equipId})
    end
    --- *c2s* 保存模组方案 12192
    SOCKET_SEND(Protocol.CS_SAVE_CHIP_PLAN, { chip_plan_info = equipPlanMsgVo}, Protocol.SC_SAVE_CHIP_PLAN)
end

-- 请求更改模组方案名称
function __onReqEquipPlanChangeNameHandler(self, args)
    --- *c2s* 更改模组方案名称 12194
    SOCKET_SEND(Protocol.CS_CHANGE_CHIP_PLAN_NAME, { chip_plan_id = args.equipPlanId, chip_plan_name = args.equipPlanName}, Protocol.SC_CHANGE_CHIP_PLAN_NAME)
end

-- 请求删除模组方案
function __onReqEquipPlanDeleteHandler(self, args)
    --- *c2s* 删除模组方案 12196
    SOCKET_SEND(Protocol.CS_DELETE_CHIP_PLAN, { chip_plan_id = args.equipPlanId}, Protocol.SC_DELETE_CHIP_PLAN)
end

-- 请求装备模组方案
function __onReqEquipPlanWearHandler(self, args)
    --- *c2s* 装备模组方案 12198
    SOCKET_SEND(Protocol.CS_EQUIP_CHIP_PLAN, { chip_plan_id = args.equipPlanId, hero_id = args.heroId}, Protocol.SC_EQUIP_CHIP_PLAN)
end

------------------------------------------------------------------------ 方案面板 ------------------------------------------------------------------------
-- 打开方案界面
function __onOpenEquipPlanePanelHandler(self, args)
    local heroId = args
    if self.mEquipPlanePanel == nil then
        self.mEquipPlanePanel = equipBuild.EquipPlanPanel.new()
        self.mEquipPlanePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEquipPlanePanelHandler, self)
    end
    self.mEquipPlanePanel:open(heroId)
end

function onDestroyEquipPlanePanelHandler(self)
    self.mEquipPlanePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEquipPlanePanelHandler, self)
    self.mEquipPlanePanel = nil
end

-- 打开方案名修改界面
function __onOpenEquipPlaneChangeNamePanelHandler(self, args)
    if self.mEquipPlanChangeNamePanel == nil then
        self.mEquipPlanChangeNamePanel = equipBuild.EquipPlanChangeNamePanel.new()
        self.mEquipPlanChangeNamePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEquipPlaneChangeNamePanelHandler, self)
    end
    self.mEquipPlanChangeNamePanel:open(args)
end

function onDestroyEquipPlaneChangeNamePanelHandler(self)
    self.mEquipPlanChangeNamePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEquipPlaneChangeNamePanelHandler, self)
    self.mEquipPlanChangeNamePanel = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
