--[[
-----------------------------------------------------
@filename       : DormitoryController
@Description    : 宿舍UI控制器
@date           : 2021-07-20 17:42:06
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dormitory.controller.DormitoryController', Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

--游戏开始的回调
function gameStartCallBack(self)

end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.ENTER_DORMITORY_SCENE, self.onEnterDormitory, self)
    GameDispatcher:addEventListener(EventName.OPEN_SETTLED_HERO_VIEW, self.onOpenSettledHeroView, self)
    GameDispatcher:addEventListener(EventName.OPEN_EDITORSAVE_VIEW, self.onOpenEditorSaveSuitView, self)

    GameDispatcher:addEventListener(EventName.OPEN_DORMITORYINFO_PANEL, self.onOpenDormitoryInfoPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_DORMITORYLIVE_PANEL, self.onOpenDormitoryLivePanel, self)

    GameDispatcher:addEventListener(EventName.ENTER_DORMITORY_SCENE_SUCCSE, self.onOpenDormitoryMainUI, self)
    GameDispatcher:addEventListener(EventName.SVAE_DORMITORY_CHANGE, self.onReqSaveFurniture, self)
    GameDispatcher:addEventListener(EventName.REQ_DORMITORY_INFO, self.onReqDormitoryInfo, self)
    GameDispatcher:addEventListener(EventName.DORMITORY_SAVE_SETTLED_HERO, self.onSettledHeroList, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_DORMITORY_INFO = self.onDormitoryInfoMsg,
        SC_PUT_FURNITURE = self.onPutFurnitureMsg,
        -- SC_SETTLED_HERO = self.onSettledHeroMsg,
    }
end

---------------------------消息交互------------------------------------
--- *c2s* 请求宿舍面板信息 24076
function onReqDormitoryInfo(self, dormitory_id)
    dormitory_id = dormitory_id or dormitory.DormitoryManager:getRoomId()
    SOCKET_SEND(Protocol.CS_DORMITORY_INFO, {dormitory_id = dormitory_id})
end

--- *c2s* 摆放家具 24072
function onReqSaveFurniture(self)
    local furniture_list = self.mMgr:getFurnitureListByDormitory()
    local moveInfoFurnitureList = self.mMgr:getMoveInfoList()

    local furnitureList = {}
    for id, info in pairs(moveInfoFurnitureList) do
        local isCanAdd = true
        for _, furnitureVo in pairs(furniture_list) do
            if furnitureVo.id == info.id and info.move == 2 then
                if furnitureVo.row == info.put_info.row and furnitureVo.col == info.put_info.columns then
                    isCanAdd = false
                    break
                else
                    info.move = 0
                end
            end
        end

        if isCanAdd then
            table.insert(furnitureList, info)
        end
    end
    if table.empty(furnitureList) then
        self:onPutFurnitureMsg({result = 1})
        return
    end

    local cmd = {}
    cmd.dormitory_id = dormitory.DormitoryManager:getRoomId()
    cmd.furniture_list = furnitureList
    SOCKET_SEND(Protocol.CS_PUT_FURNITURE, cmd)
end

--- *s2c* 宿舍面板信息返回 24077
function onDormitoryInfoMsg(self, msg)
    self.mMgr:parseDormitoryInfoMsg(msg)
end

--- *s2c* 摆放家具返回 24073
function onPutFurnitureMsg(self, msg)
    if msg.result == 1 then
        self.mMgr:resetMoveInfoList()
        self.mMgr:clearPropsList(true)
        self.mMgr:clearAllFurniture()
        gs.Message.Show2(_TT(49712))
        self:onReqDormitoryInfo()

        GameDispatcher:dispatchEvent(EventName.SAVA_DORMITORT_FINISH)
    else
        gs.Message.Show2(_TT(49713))
    end
end

-- --- *s2c* 入驻战员 24075
-- function onSettledHeroMsg(self, msg)
--     self.mMgr:parseSettledHeroMsg(msg)
-- end

---------------------------逻辑相关------------------------------------
---  入驻战员
function onSettledHeroList(self)
    local cmd = {}
    cmd.build_id = dormitory.DormitoryManager:getRoomId()
    cmd.hero_list = {}
    for k, v in pairs(self.mMgr:getSelectHeroDic()) do
        table.insert(cmd.hero_list, {hero_tid = k, pos = v})
    end

    GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_HEROLIST, cmd)
end

function onEnterDormitory(self, roomId)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_DORMITORY, true) == false then
        return
    end
    dormitory.DormitoryManager:setRoomId(roomId)
    buildBase.BuildBaseManager:setNowBuildId(roomId)
    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.DORMITORY)
end

-- 战员被提起表现通知ui层
function onLiveThingBring(self, fillValue, active, tran)
    if self.mDormitoryUI then
        self.mDormitoryUI:onLiveThingBring(fillValue, active, tran)
    end
end

---------------------------UI相关--------------------------------------
-- 打开宿舍UI
function onOpenDormitoryMainUI(self)
    -- if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_DORMITORY, true) == false then
    --     return
    -- end
    if self.mDormitoryUI == nil then
        self.mDormitoryUI = UI.new(dormitory.DormitoryMainUI)
        self.mDormitoryUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDupPanelHandler, self)
    end
    self.mDormitoryUI:open(dormitory.DormitoryManager:getRoomId())
end

-- ui销毁
function onDestroyDupPanelHandler(self)
    self.mDormitoryUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDupPanelHandler, self)
    self.mDormitoryUI = nil
end

-- 打开套装编辑界面
function onOpenEditorSaveSuitView(self, args)
    if self.mDormitoryEditorSaveSuitView == nil then
        self.mDormitoryEditorSaveSuitView = UI.new(dormitory.DormitoryEditorSaveSuitView)
        self.mDormitoryEditorSaveSuitView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEditorSaveSuitHandler, self)
    end
    self.mDormitoryEditorSaveSuitView:open(args)
end

-- ui销毁
function onDestroyEditorSaveSuitHandler(self)
    self.mDormitoryEditorSaveSuitView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEditorSaveSuitHandler, self)
    self.mDormitoryEditorSaveSuitView = nil
end

-- 打开宿舍入住战员选择界面
function onOpenSettledHeroView(self, args)
    if self.mDSettledHeroView == nil then
        self.mDSettledHeroView = UI.new(dormitory.DormitorySettledHeroView)
        self.mDSettledHeroView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySettledHeroHandler, self)
    end
    self.mDSettledHeroView:open(args)
end

-- ui销毁
function onDestroySettledHeroHandler(self)
    self.mDSettledHeroView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySettledHeroHandler, self)
    self.mDSettledHeroView = nil
end

-- 打开宿舍信息界面
function onOpenDormitoryInfoPanel(self, args)
    if self.mDormitoryInfoPanel == nil then
        self.mDormitoryInfoPanel = UI.new(dormitory.DormitoryInfoPanel)
        self.mDormitoryInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDromitoryInfoHandler, self)
    end
    self.mDormitoryInfoPanel:open(args)
end

-- ui销毁
function onDestroyDromitoryInfoHandler(self)
    self.mDormitoryInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDromitoryInfoHandler, self)
    self.mDormitoryInfoPanel = nil
end

-- 打开宿舍站员入住信息界面
function onOpenDormitoryLivePanel(self, args)
    if self.mDormitoryLivePanel == nil then
        self.mDormitoryLivePanel = UI.new(dormitory.DormitoryLivePanel)
        self.mDormitoryLivePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDormitoryLiveHandler, self)
    end
    self.mDormitoryLivePanel:open(args)
end

-- ui销毁
function onDestroyDormitoryLiveHandler(self)
    self.mDormitoryLivePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDormitoryLiveHandler, self)
    self.mDormitoryLivePanel = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
语言包: _TT(49713):"保存失败"
语言包: _TT(49712):"保存成功"
]]
