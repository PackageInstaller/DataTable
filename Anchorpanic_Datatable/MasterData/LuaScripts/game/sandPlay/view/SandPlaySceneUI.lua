-- @FileName:   SandPlaySceneUI.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.view.SandPlaySceneUI', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("sandPlay/SandPlaySceneUI.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0 -- 是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)
isBlur = 0
escapeClose = 0 -- 是否能通过esc关闭窗口

-- 初始化数据
function initData(self)
    self.mNPCBubbleList = {}
    self.mNPCInfolist = {}

    self.mNPBBubbleShowTime = 2

    self:setUICode(LinkCode.SandPlay)
end

-- 初始化
function configUI(self)
    self.mBtnBack = self:getChildGO("mBtnBack")
    self.GroupItem = self:getChildTrans("GroupItem")
    self.linkItem = self:getChildGO("linkItem")
    self.minMap = self:getChildGO("minMap")
    self.mImgMap = self:getChildGO("mImgMap"):GetComponent(ty.AutoRefImage)
    self.mImgPlaySign = self:getChildTrans("mImgPlaySign")

    self.mItemNPCBubble = self:getChildGO("mItemNPCBubble")
    self.mGroupNPCBubble = self:getChildTrans("mGroupNPCBubble")

    self.mItemNPCInfo = self:getChildGO("mItemNPCInfo")
    self.mGroupNPCInfo = self:getChildTrans("mGroupNPCInfo")

    self.mItemFunc = self:getChildGO("mItemFunc")

    self.mGroupFuncList = self:getChildTrans("mGroupFuncList")

    self.mBoxNum = self:getChildGO("mBoxNum")
    self.mTextBoxNum = self:getChildGO("mTextBoxNum"):GetComponent(ty.Text)

    self.mFieldInfoGroup = self:getChildGO("mFieldInfoGroup")
    self.mTextFieldTime = self:getChildGO("mTextFieldTime"):GetComponent(ty.Text)
    self.mTextFieldName = self:getChildGO("mTextFieldName"):GetComponent(ty.Text)

    self.mBtnTeaching = self:getChildGO("mBtnTeaching")
end

function initViewText(self)
    self:setBtnLabel(self.mBtnTeaching, 95197, "农场教程")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnBack, self.onExit)
    self:addUIEvent(self.minMap, self.onOpenMapPanel)
    self:addUIEvent(self.mBtnTeaching, self.onOpenTeaching)
end

--激活
function active(self, args)
    super.active(self)

    GameDispatcher:addEventListener(EventName.SANDPLAY_NPC_SHOWBUBBLE, self.showNPCBubble, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_CAMERA_REFRESHPOS, self.onCamreRefresh, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_NPC_ADD, self.onRefreshNpc, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_TRIGGERENTER_NPC, self.onShowFunclist, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_TRIGGEREXIT_NPC, self.onHideFunclist, self)
    GameDispatcher:addEventListener(EventName.MAINACTIVITY_REDSTATE_UPDATE, self.refreshGuideRedState, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_NPC_REMOVE, self.deleteNPC, self)

    GameDispatcher:addEventListener(EventName.SANDPLAY_REMOVE_JOYSTICK, self.clearJoystick, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_ADD_JOYSTICK, self.initJoystick, self)

    GameDispatcher:addEventListener(EventName.SANDPLAY_RECEIVE_MAPEVENT_TRIGGER, self.refreshBoxNum, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_RECEIVE_MAPEVENTINFO, self.refreshBoxNum, self)

    GameDispatcher:addEventListener(EventName.SANDPLAY_HAPPYFARM_SHOW_FIELDINFO, self.onShowFieldInfo, self)

    self.mItemNPCInfo:SetActive(false)
    self.mItemNPCBubble:SetActive(false)
    self.mGroupFuncList.gameObject:SetActive(false)

    if sandPlay.SandPlayManager:getHappyFarmActivityOpenRedState() then
        self:onOpenTeaching()
        StorageUtil:saveNumber1(gstor.SANDPLAY_HAPPYFARM_OPENRED, GameManager:getClientTime())
    end

    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.HappyFarm)
    self.mBtnTeaching:SetActive(activityVo:getIsCanOpen())

    self.mSceneConfigVo = sandPlay.SandPlaySceneController:getSceneConfigVo()

    self:initMinMap()
    self:initJoystick()
    self:creatGuildItem()
    self:checkNPCBubble()

    self:onShowFunclist()

    self:initNpcInfo()
    self:refreshBoxNum()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    GameDispatcher:removeEventListener(EventName.SANDPLAY_NPC_SHOWBUBBLE, self.showNPCBubble, self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_CAMERA_REFRESHPOS, self.onCamreRefresh, self)

    GameDispatcher:removeEventListener(EventName.SANDPLAY_NPC_ADD, self.onRefreshNpc, self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_TRIGGERENTER_NPC, self.onShowFunclist, self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_TRIGGEREXIT_NPC, self.onHideFunclist, self)
    GameDispatcher:removeEventListener(EventName.MAINACTIVITY_REDSTATE_UPDATE, self.refreshGuideRedState, self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_NPC_REMOVE, self.deleteNPC, self)

    GameDispatcher:removeEventListener(EventName.SANDPLAY_REMOVE_JOYSTICK, self.clearJoystick, self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_ADD_JOYSTICK, self.initJoystick, self)

    GameDispatcher:removeEventListener(EventName.SANDPLAY_RECEIVE_MAPEVENT_TRIGGER, self.refreshBoxNum, self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_RECEIVE_MAPEVENTINFO, self.refreshBoxNum, self)

    GameDispatcher:removeEventListener(EventName.SANDPLAY_HAPPYFARM_SHOW_FIELDINFO, self.onShowFieldInfo, self)

    self:clearMinMap()
    self:clearJoystick()
    self:clearNPCBubble()
    self:clearGuildItem()
    self:clearShowNPCBubbleTimer()

    self:clearFuncList()

    self:hideFieldInfo()
end

function deleteNPC(self, npc_id)
    self:deleteNPCBubble(npc_id)
    self:deleteNPCInfo(npc_id)
end

function onShowFunclist(self)
    local playThing = sandPlay.SandPlaySceneController:getPlayerThing()
    if not playThing then
        return
    end

    local funcNPC_Id = playThing:getCurFuncNPC()
    if funcNPC_Id == nil then
        return
    end

    local npcConfig = self.mSceneConfigVo.npcList[funcNPC_Id]
    if npcConfig then
        self.mGroupFuncList.gameObject:SetActive(true)
        self:creatFuncList(npcConfig.base_config.event_ConfigVoList, npcConfig.base_config.npc_id)
    end
end

function onHideFunclist(self)
    self.mGroupFuncList.gameObject:SetActive(false)
end

function creatFuncList(self, event_list, npc_id)
    self:clearFuncList()

    for i = 1, #event_list do
        local isShow = true
        if not event_list[i].is_repeat then
            isShow = not sandPlay.SandPlayManager:getMapEventIsPass(nil, npc_id, event_list[i].event_id)
        end

        if isShow then
            local iconPath = event_list[i]:getIconPath()
            local item = SimpleInsItem:create(self.mItemFunc, self.mGroupFuncList, "SandPlaySceneUI_NPC_FuncItem_1")

            item:getChildGO("mTextLabel"):GetComponent(ty.Text).text = event_list[i].label
            item:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(iconPath)
            self:addUIEvent(item.m_go, function()
                SandPlayConst.ExecuteEvent(event_list[i], npc_id)
            end)
            table.insert(self.mFuncItemList, item)
        end
    end
end

function clearFuncList(self)
    if self.mFuncItemList then
        for _, item in pairs(self.mFuncItemList) do
            item:recover()
        end
    end

    self.mFuncItemList = {}
end

function onCamreRefresh(self)
    self:refreshNPCBubblePos()
    self:refreshNPCInfoPos()
end

function onExit(self)
    self:close()

    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
end

-- 打开教学
function onOpenTeaching(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_SANDPLAY_FISH_TEACHING_VIEW, {resList = {"happyFarm_tips_1", "happyFarm_tips_2", "happyFarm_tips_3"}, des = {98971, 98972, 98973}})
end

function onOpenMapPanel(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_SANDPLAY_MAPPANEL)
end

function refreshBoxNum(self)
    local totalNum, openNum = 0, 0

    local clientTime = GameManager:getClientTime()

    for npc_id, npcConfig in pairs(self.mSceneConfigVo.npcList) do
        for _, eventConfigVo in pairs(npcConfig.base_config.event_ConfigVoList) do
            if eventConfigVo.event_type == SandPlayConst.EventType.Treasure_Box then
                local unLock = true
                if npcConfig.show_Dt ~= 0 then
                    unLock = clientTime >= npcConfig.show_Dt
                end

                if isShow and npcConfig.hide_Dt ~= 0 then
                    unLock = clientTime < npcConfig.hide_Dt
                end

                if not table.empty(npcConfig.show_condition) and isShow then
                    unLock = SandPlayConst.NPCConditionPass(npcConfig.show_condition)
                end

                if unLock then
                    totalNum = totalNum + 1

                    if sandPlay.SandPlayManager:getMapEventIsPass(nil, npc_id, eventConfigVo.event_id) then
                        openNum = openNum + 1
                    end
                end
            end
        end
    end

    if totalNum <= 0 then
        self.mBoxNum:SetActive(false)
    else
        self.mBoxNum:SetActive(true)
        self.mTextBoxNum.text = string.format("%s/%s", openNum, totalNum)
    end
end

-------------------------------------------NPC信息
function initNpcInfo(self)
    local npcThingList = sandPlay.SandPlaySceneController:getAllNPCList()
    for npc_id, npcThing in pairs(npcThingList) do
        local npcInfo_data = npcThing:getInfoData()
        if npcInfo_data then
            self:refreshNPCInfo(npcInfo_data)
        end

        if npcThing.mData.config.base_config.type == SandPlayConst.NPC_TYPE.BREED then
            local breedThing = npcThing:getPoultryThingList(SandPlayConst.HappyFarm_Poultry_Type.Sheep)
            for _, sheepThing in pairs(breedThing) do
                local thing_data = sheepThing:getInfoData()
                if thing_data then
                    self:refreshNPCInfo(thing_data)
                end
            end
        end
    end
end

function onRefreshNpc(self, npcThing)
    local npcInfo_data = npcThing:getInfoData()
    if npcInfo_data then
        self:refreshNPCInfo(npcInfo_data)
    end
    self:refreshBoxNum()
end

function refreshNPCInfoPos(self)
    for npc_id, infoItem in pairs(self.mNPCInfolist) do
        infoItem:updatePos()
    end
end

function refreshNPCInfo(self, npcInfo_data)
    local item = self.mNPCInfolist[npcInfo_data.id]
    if item == nil then
        item = SimpleInsItem:create(self.mItemNPCInfo, self.mGroupNPCInfo, "sandPlay_SceneNPCInfo")
        self.mNPCInfolist[npcInfo_data.id] = item

        item.updatePos = function(obj)
            local followTrans = obj.data.follow_trans
            if followTrans ~= nil and not gs.GoUtil.IsTransNull(followTrans) then
                gs.CameraMgr:World2UIOffsetY(followTrans, self.mGroupNPCInfo.transform, obj.m_trans, obj.data.offset_Y)
            end
        end

        item:addUIEvent("mBtnFunc", function ()
            if item.data.funCall then
                item.data.funCall()
            end
        end)
    end

    item.data = npcInfo_data

    local isNullOrEmpty = string.NullOrEmpty(npcInfo_data.fun_name)
    local mTextNPCFunName = item:getChildGO("mTextNPCFunName")
    mTextNPCFunName:SetActive(not isNullOrEmpty)
    if not isNullOrEmpty then
        mTextNPCFunName:GetComponent(ty.Text).text = npcInfo_data.fun_name
    end

    isNullOrEmpty = string.NullOrEmpty(npcInfo_data.name)
    local mTextNPCName = item:getChildGO("mTextNPCName")
    mTextNPCName:SetActive(not isNullOrEmpty)
    if not isNullOrEmpty then
        mTextNPCName:GetComponent(ty.Text).text = npcInfo_data.name
    end

    local path = npcInfo_data.sign_path
    isNullOrEmpty = path == nil
    item:getChildGO("mNPCSign"):SetActive(not isNullOrEmpty)
    if not isNullOrEmpty then
        item:getChildGO("mImgNPCSign"):GetComponent(ty.AutoRefImage):SetImg(path)
    end

    if npcInfo_data.funCall ~= nil then
        item:getChildGO("mBtnFunc"):SetActive(true)
        item:getChildGO("mImgFunc"):GetComponent(ty.AutoRefImage):SetImg(npcInfo_data.funcPath)
    else
        item:getChildGO("mBtnFunc"):SetActive(false)
    end

    item:getChildGO("mEffect"):SetActive(npcInfo_data.is_reap)

    item:updatePos()
end

function refreshNPCSign(self, npc_id, signPath)
    if not self.mNPCInfolist then
        return
    end

    local npcInfoItem = self.mNPCInfolist[npc_id]
    if npcInfoItem then
        local isNullOrEmpty = string.NullOrEmpty(signPath)
        item:getChildGO("mNPCSign"):SetActive(not isNullOrEmpty)
        if not isNullOrEmpty then
            item:getChildGO("mImgNPCSign"):GetComponent(ty.AutoRefImage):SetImg(signPath)
        end
    end
end

function deleteNPCInfo(self, npc_id)
    if not self.mNPCInfolist then
        return
    end

    local item = self.mNPCInfolist[npc_id]
    if item then
        item:poolRecover()
        self.mNPCInfolist[npc_id] = nil
    end
end

-------------------------------------------------NCP气泡
--更新NPC气泡的位置
function refreshNPCBubblePos(self)
    for npc_id, bubbleItem in pairs(self.mNPCBubbleList) do
        bubbleItem:updatePos()
    end
end

--检测NPC气泡显示的时间
function checkNPCBubble(self)
    self.mShowBubbleTime = sysParam.SysParamManager:getValue(SysParamType.SandPlayNPCBubbleShowTime)

    self:clearShowNPCBubbleTimer()
    self.mShowBubbleTimer = self:addTimer(1, 0, self.onCheckNPCBubble)
end

function clearShowNPCBubbleTimer(self)
    if self.mShowBubbleTimer then
        LoopManager:removeTimerByIndex(self.mShowBubbleTimer)
        self.mShowBubbleTimer = nil
    end
end
--检测NPC气泡显示的时间
function onCheckNPCBubble(self)
    if not self.mNPCBubbleList then
        return
    end

    local clientTime = GameManager:getClientTime()
    for npc_id, bubbleItem in pairs(self.mNPCBubbleList) do
        if (clientTime - bubbleItem.lateShowTime) >= self.mShowBubbleTime then
            self:deleteNPCBubble(npc_id)
        end
    end
end

function showNPCBubble(self, params)
    local bubbleItem = self:getNPCBubble(params.id)
    if bubbleItem then
        bubbleItem:refreshText(params.text)
        bubbleItem:updatePos()
    end
end

function getNPCBubble(self, npc_id)
    local item = self.mNPCBubbleList[npc_id]
    if item == nil then
        item = SimpleInsItem:create(self.mItemNPCBubble, self.mGroupNPCBubble, "sandPlay_SceneNPCBubble")
        self.mNPCBubbleList[npc_id] = item

        local npcThing = sandPlay.SandPlaySceneController:getNPCThing(npc_id)
        item.thing = npcThing

        item.mTextBubble = item.m_childGos["mTextBubble"]:GetComponent(ty.Text)
        item.lateShowTime = 0

        item.refreshText = function(obj, text)
            if obj.m_go.activeSelf == false then
                obj.m_go:SetActive(true)
            end

            if self.mGroupNPCBubble.activeSelf == false then
                self.mGroupNPCBubble:SetActive(true)
            end

            obj.mTextBubble.text = text
            obj.lateShowTime = GameManager:getClientTime()
        end

        item.updatePos = function(obj)
            local followTrans = obj.thing:getTrans()
            gs.CameraMgr:World2UIOffsetY(followTrans, self.mGroupNPCBubble.transform, obj.m_trans, 1)
        end
    end
    return item
end

function deleteNPCBubble(self, npc_id)
    if self.mNPCBubbleList and self.mNPCBubbleList[npc_id] then
        self.mNPCBubbleList[npc_id]:recover()
        self.mNPCBubbleList[npc_id] = nil
    end
end

function clearNPCBubble(self)
    if self.mNPCBubbleList then
        for _, item in pairs(self.mNPCBubbleList) do
            item:recover()
        end
    end

    self.mNPCBubbleList = {}
end

------------------------------------------小地图
function initMinMap(self)
    if gs.Application.isEditor then
        sandPlay.SandPlayMinMap = require("game/sandPlay/view/SandPlayMinMap")
    end
    self.mMinMap = sandPlay.SandPlayMinMap.new()
    self.mMinMap:initData(self.minMap)
end

function clearMinMap(self)
    if self.mMinMap then
        self.mMinMap:destroy()
    end
end

-----------------------------------------摇杆
function initJoystick(self)
    if (not self.mJoyStick) then
        self.mJoyStick = sandPlay.SandPlayJoystickView.new()
        self.mJoyStick:setParentTrans(self.UITrans)
    end
end

function clearJoystick(self)
    if (self.mJoyStick) then
        self.mJoyStick:destroy()
        self.mJoyStick = nil
    end
end

---------------------------------------右上导航栏
function creatGuildItem(self)
    if not self.mSceneConfigVo then
        return
    end

    self:clearGuildItem()
    for i = 1, #self.mSceneConfigVo.guideList do
        local guildItem = SimpleInsItem:create(self.linkItem, self.GroupItem, "sandPlay_SceneGuideItem")
        self.mGuideItemList[i] = guildItem

        local data = self.mSceneConfigVo.guideList[i]
        guildItem:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(data.icon)
        guildItem:getChildGO("mTextLabel"):GetComponent(ty.Text).text = data.name

        self:addUIEvent(guildItem:getGo(), function ()
            local isOpen = false
            local lockActivity_id = nil
            for i = 1, #data.activityList do
                local activity_id = data.activityList[i]

                if activity.ActivityManager:checkIsOpenById(activity_id) then
                    isOpen = true
                    break
                else
                    lockActivity_id = activity_id
                end
            end

            if not isOpen then
                local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(lockActivity_id)
                gs.Message.Show(activityVo:getLockDec())

                return
            end

            if data.param[1] == 1 then
                local findPos = {x = data.param[2][1], y = data.param[2][2], z = data.param[2][3]}
                local _data = {param = findPos, finishCall = function ()

                end}
                GameDispatcher:dispatchEvent(EventName.SANDPLAY_PLAYERTHING_FINDPOINT, _data)
            elseif data.param[1] == 2 then
                local event_id = data.param[2][1]
                local eventConfigVo = sandPlay.SandPlayManager:getEventConfigVo(event_id)
                SandPlayConst.ExecuteEvent(eventConfigVo, SandPlayConst.UINPC_ID)
            end
        end)
    end

    self:refreshGuideRedState()
end

function clearGuildItem(self)
    if self.mGuideItemList then
        for _, item in pairs(self.mGuideItemList) do
            item:poolRecover()
        end
    end
    self.mGuideItemList = {}
end

---------------------------------------农田信息
function onShowFieldInfo(self, args)
    --{active,name,reapTime} 激活状态、名字、收获时间戳
    if self.mFieldInfo then
        if args.id == self.mFieldInfo.id then
            if not args.active then
                return
            end
        end
    end

    if not args.active or args.reapTime - GameManager:getClientTime() <= 0 then
        self:hideFieldInfo()
        return
    end

    self.mFieldInfoGroup:SetActive(true)

    self.mFieldInfo = args
    self.mTextFieldName.text = self.mFieldInfo.name

    self:showFieldInfo()

    self.mFieldInfoTimeSn = self:addTimer(1, 0, self.showFieldInfo)
end

function hideFieldInfo(self)
    self.mFieldInfo = nil
    self:clearFieldInfoTimeSn()
    self.mFieldInfoGroup:SetActive(false)
end

function showFieldInfo(self)
    local growDt = self.mFieldInfo.reapTime - GameManager:getClientTime()
    if growDt > 0 then
        self.mTextFieldTime.text = _TT(137025, TimeUtil.getFormatTimeBySeconds_1(growDt))
    else
        self:hideFieldInfo()
    end
end

function clearFieldInfoTimeSn(self)
    if self.mFieldInfoTimeSn then
        self:removeTimerByIndex(self.mFieldInfoTimeSn)
        self.mFieldInfoTimeSn = nil
    end
end

function refreshGuideRedState(self)
    if not self.mSceneConfigVo then
        return
    end

    for i = 1, #self.mSceneConfigVo.guideList do
        local data = self.mSceneConfigVo.guideList[i]

        local guildItem = self.mGuideItemList[i]
        if guildItem then
            local isShowRed = false
            for i = 1, #data.activityList do
                local activity_id = data.activityList[i]
                if MainActivityConst.getActivityRedState(activity_id) then
                    isShowRed = true
                    break
                end
            end
            if isShowRed then
                RedPointManager:add(guildItem.m_trans, nil, 16.4, 19)
            else
                RedPointManager:remove(guildItem.m_trans)
            end
        end
    end

    for i = 1, #self.mSceneConfigVo.guideList do
        local data = self.mSceneConfigVo.guideList[i]

        local guildItem = self.mGuideItemList[i]
        if guildItem then
            if data.red_id ~= 0 then
                if SandPlayConst.getGuildRedState(data.red_id) then
                    RedPointManager:add(guildItem.m_trans, nil, 16.4, 19)
                else
                    RedPointManager:remove(guildItem.m_trans)
                end
            end
        end
    end
end

return _M
