-- @FileName:   SandPlayConst.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-11-28 15:28:41
-- @Copyright:   (LY) 2023 雷焰网络

SandPlayConst = {}

--种子类型
SandPlayConst.HappyFarm_Seed_Type =
{
    Poultry = 1, -- 家禽
    Crop = 2, -- 作物
}

--家禽类型
SandPlayConst.HappyFarm_Poultry_Type =
{
    Chicken = 1, --鸡
    Sheep = 2, --羊
}

--农场农田状态
SandPlayConst.HappyFarm_FieldState =
{
    Waste_land = 1, --荒地
    Space_land = 2, --空地
    Dry_land = 3, --旱地
    grow_up0 = 4, --种子阶段
    grow_up1 = 5, --发芽阶段
    grow_up2 = 6, --初期阶段
    grow_up3 = 7, --中期阶
    grow_up4 = 8, --可收获
}

--碰撞标识
SandPlayConst.ColliderTag =
{
    Event = "EVENT",
    EventSkill = "EVENTSKILL",
    Player = "PLAYER",
    PlayerSkill = "PLAYERSKILL",
}

-- --寻路类型
-- SandPlayConst.FindType =
-- {
--     point = "point",
--     Npc = "Npc",
-- }

--碰撞类型
SandPlayConst.Collider_Type =
{
    None = 0,
    CapsuleCollider = 1,
    BoxCollider = 2,
    SelfCollider = 3,
    SectorCollider = 4,
}

SandPlayConst.Event_trigger_Type =
{
    Hand = 0,
    Auto = 1,
}

--动画名字
SandPlayConst.NAME_STAND = "Qstand"
SandPlayConst.NAME_MOVE = "Qmove"
SandPlayConst.NAME_DATK01 = "QDatk01"
SandPlayConst.NAME_DATK02 = "QDatk02"
SandPlayConst.NAME_DATK03 = "QDatk03"
SandPlayConst.NAME_DCHANGE = "QDchange"
SandPlayConst.NAME_DIDLE = "QDidle"
-- SandPlayConst.NAME_DMINE = "QDmine"
SandPlayConst.NAME_DMOVE = "QDmove"
SandPlayConst.NAME_DREADY = "QDready"
SandPlayConst.NAME_DSTAND = "QDstand"
SandPlayConst.NAME_DWIN01 = "QDwin01"
SandPlayConst.NAME_DWIN02 = "QDwin02"
SandPlayConst.NAME_SOW = "Qbz" --播种
SandPlayConst.NAME_REAP = "Qjm"--剪毛
SandPlayConst.NAME_CT = "Qct"--锄地
SandPlayConst.NAME_SS = "Qss"--洒水

--玩家动画列表
SandPlayConst.HERO_ACT_LIST =
{
    SandPlayConst.NAME_STAND,
    SandPlayConst.NAME_MOVE,
    SandPlayConst.NAME_DATK01,
    SandPlayConst.NAME_DATK02,
    SandPlayConst.NAME_DATK03,
    SandPlayConst.NAME_DCHANGE,
    SandPlayConst.NAME_DIDLE,
    -- SandPlayConst.NAME_DMINE,
    SandPlayConst.NAME_DMOVE,
    SandPlayConst.NAME_DREADY,
    SandPlayConst.NAME_DSTAND,
    SandPlayConst.NAME_DWIN01,
    SandPlayConst.NAME_DWIN02,

    SandPlayConst.NAME_SOW,
    SandPlayConst.NAME_REAP,
    SandPlayConst.NAME_CT,
    SandPlayConst.NAME_SS,
}

--NPC动画列表
SandPlayConst.NPC_ACT_LIST =
{
    SandPlayConst.NAME_STAND,
    SandPlayConst.NAME_MOVE
}

SandPlayConst.HERO_ACTION_STATE =
{
    STAND = "STAND",
    --自由行走
    MOVE = "MOVE",
    --寻路行走
    AI_FIND = "AI_FIND",
    --钓鱼行走
    FISH_MOVE = "FISH_MOVE",
    --钓鱼站立待机
    FISH_IDLE = "FISH_IDLE",
    --钓鱼抛竿
    FISH_DREADY = "FISH_DREADY",
    --钓鱼抛竿待机
    FISH_STAND = "FISH_STAND",
    --没钓到鱼提前收杆
    FISH_CHANGE = "FISH_CHANGE",
    --拉杆
    FISH_ATK01 = "FISH_ATK01",
    FISH_ATK02 = "FISH_ATK02",
    FISH_ATK03 = "FISH_ATK03",
    --钓到鱼胜利
    FISH_WIN01 = "FISH_WIN01",
    FISH_WIN02 = "FISH_WIN02",

    ----开心农场
    HAPPYFARM_JM = "HAPPYFARM_JM", --剪毛
    HAPPYFARM_CD = "HAPPYFARM_CD", ---锄地
    HAPPYFARM_BZ = "HAPPYFARM_BZ", --播种
    HAPPYFARM_SS = "HAPPYFARM_SS", --洒水

}

--不允许打断的状态
SandPlayConst.NoAllowForceActionState =
{
    SandPlayConst.HERO_ACTION_STATE.FISH_DREADY,
    SandPlayConst.HERO_ACTION_STATE.FISH_CHANGE,
    SandPlayConst.HERO_ACTION_STATE.FISH_WIN01,
    SandPlayConst.HERO_ACTION_STATE.FISH_WIN02,

    SandPlayConst.HERO_ACTION_STATE.HAPPYFARM_JM,
    SandPlayConst.HERO_ACTION_STATE.HAPPYFARM_CD,
    SandPlayConst.HERO_ACTION_STATE.HAPPYFARM_BZ,
    SandPlayConst.HERO_ACTION_STATE.HAPPYFARM_SS,
}

--允许恢复的状态
SandPlayConst.AllowRevertState =
{
    [SandPlayConst.HERO_ACTION_STATE.MOVE] = {reverState = SandPlayConst.HERO_ACTION_STATE.STAND},
    [SandPlayConst.HERO_ACTION_STATE.FISH_MOVE] = {reverState = SandPlayConst.HERO_ACTION_STATE.FISH_IDLE},
    [SandPlayConst.HERO_ACTION_STATE.AI_FIND] = {reverState = SandPlayConst.HERO_ACTION_STATE.STAND},

    [SandPlayConst.HERO_ACTION_STATE.FISH_DREADY] = {reverState = SandPlayConst.HERO_ACTION_STATE.FISH_STAND, isAuto = true},
    [SandPlayConst.HERO_ACTION_STATE.FISH_CHANGE] = {reverState = SandPlayConst.HERO_ACTION_STATE.FISH_IDLE, isAuto = true},

    [SandPlayConst.HERO_ACTION_STATE.FISH_WIN01] = {reverState = SandPlayConst.HERO_ACTION_STATE.FISH_WIN02},
    [SandPlayConst.HERO_ACTION_STATE.FISH_WIN02] = {reverState = SandPlayConst.HERO_ACTION_STATE.FISH_IDLE, isAuto = true},

    -- [SandPlayConst.HERO_ACTION_STATE.HAPPYFARM_JM] = {reverState = SandPlayConst.HERO_ACTION_STATE.STAND},
    -- [SandPlayConst.HERO_ACTION_STATE.HAPPYFARM_CD] = {reverState = SandPlayConst.HERO_ACTION_STATE.STAND},
    -- [SandPlayConst.HERO_ACTION_STATE.HAPPYFARM_BZ] = {reverState = SandPlayConst.HERO_ACTION_STATE.STAND},
    -- [SandPlayConst.HERO_ACTION_STATE.HAPPYFARM_SS] = {reverState = SandPlayConst.HERO_ACTION_STATE.STAND},

}

--状态对应的动画
SandPlayConst.HERO_ACTIONSTATE_ACTHASH =
{
    [SandPlayConst.HERO_ACTION_STATE.STAND] = SandPlayConst.NAME_STAND,
    [SandPlayConst.HERO_ACTION_STATE.MOVE] = SandPlayConst.NAME_MOVE,
    [SandPlayConst.HERO_ACTION_STATE.AI_FIND] = SandPlayConst.NAME_MOVE,

    [SandPlayConst.HERO_ACTION_STATE.FISH_MOVE] = SandPlayConst.NAME_DMOVE,
    [SandPlayConst.HERO_ACTION_STATE.FISH_IDLE] = SandPlayConst.NAME_DIDLE,
    [SandPlayConst.HERO_ACTION_STATE.FISH_DREADY] = SandPlayConst.NAME_DREADY,
    [SandPlayConst.HERO_ACTION_STATE.FISH_STAND] = SandPlayConst.NAME_DSTAND,
    [SandPlayConst.HERO_ACTION_STATE.FISH_CHANGE] = SandPlayConst.NAME_DCHANGE,

    [SandPlayConst.HERO_ACTION_STATE.FISH_ATK01] = SandPlayConst.NAME_DATK01,
    [SandPlayConst.HERO_ACTION_STATE.FISH_ATK02] = SandPlayConst.NAME_DATK02,
    [SandPlayConst.HERO_ACTION_STATE.FISH_ATK03] = SandPlayConst.NAME_DATK03,
    [SandPlayConst.HERO_ACTION_STATE.FISH_WIN01] = SandPlayConst.NAME_DWIN01,
    [SandPlayConst.HERO_ACTION_STATE.FISH_WIN02] = SandPlayConst.NAME_DWIN02,

    [SandPlayConst.HERO_ACTION_STATE.HAPPYFARM_JM] = SandPlayConst.NAME_REAP,
    [SandPlayConst.HERO_ACTION_STATE.HAPPYFARM_CD] = SandPlayConst.NAME_CT,
    [SandPlayConst.HERO_ACTION_STATE.HAPPYFARM_BZ] = SandPlayConst.NAME_SOW,
    [SandPlayConst.HERO_ACTION_STATE.HAPPYFARM_SS] = SandPlayConst.NAME_SS,
}

--NPC解锁隐藏条件
SandPlayConst.NPC_SHOWCONDITION_TYPE =
{
    PASSDUP = 1,
    PASSEVENT = 2,
}

SandPlayConst.NPC_TYPE =
{
    ROLE = 1, --角色
    ARTICLE = 2, --物件
    MONSTER = 3, --怪物
    TREASURE_BOX = 4, --宝箱
    TRANSMIT = 5, --传送
    DOOR = 6, --机关门
    FIELD = 8, ---农田
    BREED = 9, ---养殖
    POULTRYREAP = 10, --家禽农田收获
}

--事件类型
SandPlayConst.EventType =
{

    Talk = 1, --剧情
    Link = 2, --界面link
    Fishing = 3, --钓鱼
    Treasure_Box = 4, --宝箱
    Dup = 5, --副本
    Transmit = 6, --传送
    Door = 7, --机关门
    Field = 8, --种植
    Breed = 9, -- 养殖
    PoultryReap = 10, --家禽农田收获
}

--事件触发时的限制
SandPlayConst.Event_TriggerLimit =
{
    GAME_PAUSE = 1, --游戏暂停
    LOCK_MOVE = 2, --不可移动
    MONSTER_PAUSE = 3, --怪物暂停
    PLAYER_HID_EMODEL = 4, --主角模型隐藏
    MONSTER_HID_EMODEL = 5, --怪物模型隐藏
    CAMERA_PAUSE = 6, --相机暂停刷新
    HIT_UI = 7, --隐藏全部UI
}

---特殊NPC
SandPlayConst.UINPC_ID = 999

--特效路劲
SandPlayConst.getEffectPath = function(pathName)
    return "arts/fx/3d/sceneModule/maze/" .. pathName
end

SandPlayConst.getParticleSystemLength = function (trans)
    return 2
end

--功能导航的红点状态
SandPlayConst.getGuildRedState = function(red_id)
    local redStateDefine =
    {
        [1] = sandPlay.SandPlayManager:getHappayFarmPoultryRedState(), ---农场家禽
        [2] = sandPlay.SandPlayManager:getHappyFarmCropRedState(), ---农场农作物
        [3] = sandPlay.SandPlayManager:getHappyFarmTaskRedState(), ---农场任务
    }

    return redStateDefine[red_id]
end

---客户端主动执行事件
SandPlayConst.ExecuteEvent = function (eventConfigVo, npc_id)
    if npc_id ~= SandPlayConst.UINPC_ID then
        if eventConfigVo.isLook then
            local npcThing = sandPlay.SandPlaySceneController:getNPCThing(npc_id)
            if npcThing then
                GameDispatcher:dispatchEvent(EventName.SANDPLAY_PLAYERTHING_ROTAPOINT, npcThing:getPosition())
            end
        end
    end

    --事件触发期间的限制
    for _, limit_type in pairs(eventConfigVo.trigger_state) do
        if limit_type == SandPlayConst.Event_TriggerLimit.GAME_PAUSE then
        elseif limit_type == SandPlayConst.Event_TriggerLimit.LOCK_MOVE then
            GameDispatcher:dispatchEvent(EventName.SANDPLAY_REMOVE_JOYSTICK)
        elseif limit_type == SandPlayConst.Event_TriggerLimit.MONSTER_PAUSE then
        elseif limit_type == SandPlayConst.Event_TriggerLimit.PLAYER_HID_EMODEL then
        elseif limit_type == SandPlayConst.Event_TriggerLimit.MONSTER_HID_EMODEL then
        elseif limit_type == SandPlayConst.Event_TriggerLimit.CAMERA_PAUSE then
        elseif limit_type == SandPlayConst.Event_TriggerLimit.HIT_UI then
        end
    end

    SandPlayConst.LastExecuteEvent_Id = eventConfigVo.event_id

    if eventConfigVo.event_type == SandPlayConst.EventType.Talk then
        if eventConfigVo.talke_type == 0 then
            local storyId = eventConfigVo.event_param[1]
            storyTalk.StoryTalkManager:setCurStoryID(storyId)
            GameDispatcher:dispatchEvent(EventName.OPEN_STORY_TALK_PANEL)
        else
            gs.CameraMgr:GetUICamera().gameObject:SetActive(false)
            local c = sandPlay.SandPlaySceneController:getCamera()
            local camera_pos = eventConfigVo.camera_pos
            c:DoCusTweenAngle(camera_pos[1], camera_pos[2], camera_pos[3], camera_pos[4], camera_pos[5], camera_pos[6], camera_pos[7], function()
                local storyId = eventConfigVo.event_param[1]
                storyTalk.StoryTalkManager:setCurStoryID(storyId)
                GameDispatcher:dispatchEvent(EventName.OPEN_STORY_SAND_TALK_PANEL)
                gs.CameraMgr:GetUICamera().gameObject:SetActive(true)
                gs.CameraMgr:GetSceneCamera().gameObject:SetActive(true)
            end)
        end
    elseif eventConfigVo.event_type == SandPlayConst.EventType.Link then
        local linkId = eventConfigVo.event_param[1]
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = linkId})

    elseif eventConfigVo.event_type == SandPlayConst.EventType.Fishing then
        if not activity.ActivityManager:checkIsOpenById(activity.ActivityId.Fishing) then
            local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.Fishing)
            gs.Message.Show(activityVo:getLockDec())
            return
        end

        GameDispatcher:dispatchEvent(EventName.SANDPLAY_OPEN_FISHING, eventConfigVo)

        GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
    elseif eventConfigVo.event_type == SandPlayConst.EventType.Treasure_Box then
        if eventConfigVo.isLook then
            local npcThing = sandPlay.SandPlaySceneController:getNPCThing(npc_id)
            if npcThing then
                GameDispatcher:dispatchEvent(EventName.SANDPLAY_PLAYERTHING_ROTAPOINT, npcThing:getPosition())
            end
        end

        local npcThing = sandPlay.SandPlaySceneController:getNPCThing(npc_id)
        if npcThing then
            npcThing:getAniLenght("open", function (timeLength)
                npcThing:setTimeOut(timeLength, function (thing)
                    GameDispatcher:dispatchEvent(EventName.SANDPLAY_FISHING_ONREQ_EVENTTRIGGER, {npc_id = npc_id, event_id = eventConfigVo.event_id})
                end)
            end)
            npcThing:playAction("open")

            local path = ""
            if string.find(npcThing.mData.config.base_config.prefab_name, "modeldx_prop_01_box") then
                path = "arts/fx/3d/scene/dx_101/fx_scene_dx_101_box_01_open.prefab"
            elseif string.find(npcThing.mData.config.base_config.prefab_name, "modeldx_prop_02_box") then
                path = "arts/fx/3d/scene/dx_101/fx_scene_dx_101_box_02_open.prefab"
            elseif string.find(npcThing.mData.config.base_config.prefab_name, "modelnewyear_box_a") then
                path = "arts/fx/3d/scene/dx_101/fx_scene_newyear_box_a_open.prefab"
            elseif string.find(npcThing.mData.config.base_config.prefab_name, "modelnewyear_box_b") then
                path = "arts/fx/3d/scene/dx_101/fx_scene_newyear_box_a_open.prefab"
            end
            if not string.NullOrEmpty(path) then
                npcThing:addEffect(path)
            end
            return
        end
    elseif eventConfigVo.event_type == SandPlayConst.EventType.Dup then
        local stage_id = eventConfigVo.event_param[1]
        local dupConfigVo = sandPlay.SandPlayManager:getStageConfigVo(stage_id)
        GameDispatcher:dispatchEvent(EventName.OPEN_SANDPLAY_DUPINFOPANEL, {dupConfigVo = dupConfigVo, npc_id = npc_id, event_id = eventConfigVo.event_id})

    elseif eventConfigVo.event_type == SandPlayConst.EventType.Transmit then
        map.MapLoader:setIsForceLoad(true)

        gs.PopPanelManager.CloseAll(true)

        local map_id = eventConfigVo.event_param[1]
        local pos = {x = eventConfigVo.event_param[2][1], y = eventConfigVo.event_param[2][2], z = eventConfigVo.event_param[2][3]}
        sandPlay.SandPlayManager:setNextMapId(map_id)
        sandPlay.SandPlayManager:setPlayerThingScenePos(pos)
        GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.SANDPLAY_GAME)
    elseif eventConfigVo.event_type == SandPlayConst.EventType.Door then
        local npcThing = sandPlay.SandPlaySceneController:getNPCThing(npc_id)
        if npcThing then
            npcThing:playAction("open")
        end
    elseif eventConfigVo.event_type == SandPlayConst.EventType.Breed then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.HappyFarm_Breed, param = eventConfigVo.event_param})
    end

    if eventConfigVo.event_type ~= SandPlayConst.EventType.Dup and npc_id ~= SandPlayConst.UINPC_ID then
        GameDispatcher:dispatchEvent(EventName.SANDPLAY_FISHING_ONREQ_EVENTTRIGGER, {npc_id = npc_id, event_id = eventConfigVo.event_id})
    end
end

--事件结束执行
SandPlayConst.OverEvent = function (event_id)
    event_id = event_id or SandPlayConst.LastExecuteEvent_Id
    if event_id then
        local eventConfigVo = sandPlay.SandPlayManager:getEventConfigVo(event_id)
        for _, limit_type in pairs(eventConfigVo.trigger_state) do
            if limit_type == SandPlayConst.Event_TriggerLimit.GAME_PAUSE then
            elseif limit_type == SandPlayConst.Event_TriggerLimit.LOCK_MOVE then
                GameDispatcher:dispatchEvent(EventName.SANDPLAY_ADD_JOYSTICK)
            elseif limit_type == SandPlayConst.Event_TriggerLimit.MONSTER_PAUSE then
            elseif limit_type == SandPlayConst.Event_TriggerLimit.PLAYER_HID_EMODEL then
            elseif limit_type == SandPlayConst.Event_TriggerLimit.MONSTER_HID_EMODEL then
            elseif limit_type == SandPlayConst.Event_TriggerLimit.CAMERA_PAUSE then
            elseif limit_type == SandPlayConst.Event_TriggerLimit.HIT_UI then
            end
        end
    end

    SandPlayConst.LastExecuteEvent_Id = nil
end

--事件执行完毕回调
SandPlayConst.ResponseEvent = function (map_id, npc_id, event_id)
    if map_id ~= sandPlay.SandPlayManager:getMapId() then
        return
    end

    local eventConfigVo = sandPlay.SandPlayManager:getEventConfigVo(event_id)
    if eventConfigVo then
        if eventConfigVo.event_type == SandPlayConst.EventType.Talk then
        elseif eventConfigVo.event_type == SandPlayConst.EventType.Link then
        elseif eventConfigVo.event_type == SandPlayConst.EventType.Fishing then
        elseif eventConfigVo.event_type == SandPlayConst.EventType.Dup then
        elseif eventConfigVo.event_type == SandPlayConst.EventType.Treasure_Box then
        elseif eventConfigVo.event_type == SandPlayConst.EventType.Transmit then

        end
    end

    GameDispatcher:dispatchEvent(EventName.SANDPLAY_CHECK_NPCTHING)
    --刷新NPC的功能列表
    GameDispatcher:dispatchEvent(EventName.SANDPLAY_TRIGGERENTER_NPC)
end

--NPC条件是否达成
SandPlayConst.NPCConditionPass = function (condition)
    if condition[1] == SandPlayConst.NPC_SHOWCONDITION_TYPE.PASSDUP then
        local dup_type = condition[2]
        local dup_id = condition[3]

        return SandPlayConst.getDupPass(dup_type, dup_id)
    elseif condition[1] == SandPlayConst.NPC_SHOWCONDITION_TYPE.PASSEVENT then
        return sandPlay.SandPlayManager:getMapEventIsPass(nil, condition[2], condition[3])
    end

    return false
end

--副本是否通关
SandPlayConst.getDupPass = function (dup_type, dupId)
    if dup_type == DupType.ActiveDup then
        return mainActivity.ActiveDupManager:isStagePass(dupId) ~= nil
    end
    return false
end
