---------------------------------------
---{
    --- refId
    --- eventResType:  
-- }


------------ import ------------
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
------------ import ------------


------------ define ------------

local PhotoGroupIndex = {
    Map     = 1,
    Quest   = 2,
    Antique = 3,
}

------------ define ------------

--- from: Assets/BundleResources/Prefabs/SpringFestival/SpringFestivalAntiqueRestorationPopup.prefab
---@class MapDecryptionEventResultPopup
---@field Env                           	MapDecryptionEventResultPopup                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field TxtTips                       	UnityEngine.UI.Text                     
---@field TxtContent                    	Game.Native.Common.UISwitchText         
---@field AntiqueImgPhotoIcon           	Engine.UI.RawImageAlterable             
---@field PhotoGroupAntique             	UnityEngine.RectTransform               
---@field BossImgPhotoIcon              	Engine.UI.RawImageAlterable             
---@field PhotoGroupBoss                	UnityEngine.RectTransform               
---@field SceneImgPhotoIcon             	Engine.UI.RawImageAlterable             
---@field PhotoGroupScene               	UnityEngine.RectTransform               
local MapDecryptionEventResultPopup = Class('MapDecryptionEventResultPopup')


---@type Maze2DStates
local Maze2DStates = import('Game.Behaviours.Maze.Maze2DStates')


function MapDecryptionEventResultPopup:__init()
end


function MapDecryptionEventResultPopup:__delete()
    self.controller = nil
end


function MapDecryptionEventResultPopup:Awake()
    KTool.SetActive(self.PhotoGroupAntique.gameObject, false)
    KTool.SetActive(self.PhotoGroupBoss.gameObject, false)
    KTool.SetActive(self.PhotoGroupScene.gameObject, false)
end


function MapDecryptionEventResultPopup:OnFocus(focus)

end


function MapDecryptionEventResultPopup:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        --print( "tpr -- MapDecryptionEventResultPopup:OnInitialize" )
        self:FreshUI(self:InitData())
        Maze2DStates.isDialogEventResultPopupShow = true
    end))
    return coWait
end


function MapDecryptionEventResultPopup:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        --print( "tpr -- MapDecryptionEventResultPopup:OnFinalize" )
        Maze2DStates.isDialogEventResultPopupShow = false
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

function MapDecryptionEventResultPopup:InitData()
    local parameters   = self.controller.Argument.parameters -- 调用 UIModule.OpenDialog() 时传入的参数
    local data         = parameters.data
    local refId        = data.refId
    local eventResType = data.eventResType -- MapDecryptionConstants.EventResult
    local groupStage   = data.stage
    
    local EventResult = MapDecryptionConstants.EventResult
    local data = {
        picture         = nil,
        content         = nil,
        contentStatus   = 1,
        tips            = nil,
        photoGroupIndex = nil,
    }           
    if eventResType == EventResult.AntiqueRestore then
        
        ---@type MapDecryptionAntiqueRestorationVo
        local vo = MapDecryptionConfMgr:GetAntiqueRestorationsById(refId)
        ---@type MapDecryptionDecryptedMapsVo
        local mapVo = MapDecryptionConfMgr:GetDecryptedMapsById(vo.mapId)
        data.content = localize("隐藏房间已经解锁")
        data.picture = mapVo.place
        data.tips    = localize("_name_里面有房间已经解锁，好像有什么好东西", {_name_ = mapVo.name})
        data.photoGroupIndex = PhotoGroupIndex.Map

    elseif eventResType == EventResult.FindAntique then
        -- 2D迷宫内, 打赢了迷宫第一章节的 boss 战, 然后领取了之后的 "宝箱" 后, 要显示的:

        ---@type MapDecryptionAntiqueRestorationVo -- 古物修复表, 
        local vo = MapDecryptionConfMgr:GetAntiqueRestorationsById(refId) -- 比如: 900012
        ---@type MapDecryptionDecryptedMapsVo
        local mapVo = MapDecryptionConfMgr:GetDecryptedMapsById(vo.mapId)

        data.picture = mapVo.antiquePicture -- 古物图
        data.content = localize("发现_name_", {_name_ = vo.name})
        --data.tips    = localize("收集到了新的_antiqueName_，赶紧拿给_name_看下吧", {_antiqueName_ = vo.name, _name_ = "云沛"})
        ---114 -> 云沛
        local name = CardConfMgr:GetInstance():GetRolesVo(114).name
        data.tips    = localize("收集到了新的古物，赶紧拿给_name_看下吧", {_name_ = name})
        data.photoGroupIndex = PhotoGroupIndex.Antique 

        --print( "koko 宝箱, refId = " .. refId .. ", name = " .. vo.name .. ", desc = " .. vo.desc )

    elseif eventResType == EventResult.UnlockTrackQuest then
        -- 2D迷宫内, 打赢了迷宫第一章节的 boss 战时:

        local questConfMgr = QuestConfMgr:GetInstance()
        ---@type MapDecryptionQuestVo
        local vo = questConfMgr:GetQuestVoById(refId)
        data.picture = vo.picture
        data.content = localize("_name_解锁", {_name_ = vo.name})
        data.tips    = localize("新的追踪BOSS已经解锁，可以进行追踪")
        data.photoGroupIndex = PhotoGroupIndex.Quest

    elseif eventResType == EventResult.FindMap then
        -- 2D迷宫内, 第一次进入某个新的 迷宫时:

        ---@type MapDecryptionDecryptedMapsVo
        local mapVo = MapDecryptionConfMgr:GetDecryptedMapsById(refId)
        data.picture = mapVo.place
        data.content = mapVo.name
        --data.tips    = localize("_name_里面有很多好东西，进去看看吧", {_name_ = mapVo.name})
        data.tips = localize( mapVo.desc )
        data.photoGroupIndex = PhotoGroupIndex.Map


    elseif eventResType == EventResult.CompleteMapExploration then
        -- 2D迷宫内, 打穿了迷宫第一章节, 离开迷宫时:

        local stage = groupStage or 1
        data.contentStatus = 2
        ---@type MapDecryptionDecryptedMapsVo
        local mapVo = MapDecryptionConfMgr:GetDecryptedMapsById(refId)
        data.picture = mapVo.place
        data.content = localize("_name_【阶段_num_】已经完成", {_name_ = mapVo.name, _num_ = stage})
        data.tips    = localize("下次进来说不定会有新的发现")
        data.photoGroupIndex = PhotoGroupIndex.Map

    end
    return data
end

---------------------------------------------------
--- init end --
---------------------------------------------------

---------------------------------------------------
--- ui logic begin --
---------------------------------------------------

--- FreshUI
---@param data table
function MapDecryptionEventResultPopup:FreshUI(data)
    print(table.toString(data))
    local t = {
        {"PhotoGroupScene",   "SceneImgPhotoIcon"},
        {"PhotoGroupBoss",    "BossImgPhotoIcon"},
        {"PhotoGroupAntique", "AntiqueImgPhotoIcon"},
    }
    local groupNameInfo = t[data.photoGroupIndex]
    if groupNameInfo then
        local GroupNode    = self[groupNameInfo[1]]
        KTool.SetActive(GroupNode.gameObject, true)

        local ImgPhotoIcon = self[groupNameInfo[2]]
        ImgPhotoIcon:LoadSprite(data.picture)
    end


    self.TxtContent.text   = data.content
    self.TxtContent.Status = data.contentStatus
    self.TxtTips.text      = data.tips

end

---------------------------------------------------
--- ui logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------


---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------


---------------------------------------------------
--- handler end ---
---------------------------------------------------


return MapDecryptionEventResultPopup
