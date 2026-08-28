-------------------------------------------------------------------------------
-- 猫球预览界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-08-21 01:08:49
-------------------------------------------------------------------------------

---@type CatEggComponent
local catBallComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatEggComponent)
---@type CatBallUtils
local CatBallUtils = import("Game.CatBall.CatBallUtils")
---@type CardProgressionUtils
local CardProgressionUtils = import("Game.CardProgression.CardProgressionUtils")
---@type MaidCoffeeConstants
local MaidCoffeeConstants = import("Game.MaidCoffee.MaidCoffeeConstants")
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type SceneManagement
local SceneManagementIns = SceneManagement:GetInstance()

local SkillNodeEnvPath = "Game.CatBall.CatBallSkillCardNode"

local CatModelInteractionLocalRotation = Quaternion.Euler(0, 0, 0)

local CatBallCameraPosition = Vector3.New(-2.067, 0.205, 7.104)
local CatBallCameraRotation = Vector3.New(0, 154, 0)

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/IllustratedHandbook/IllustbookCatballSkillDialog.prefab
---@class CommonCatBallPreviewDialog
---@field Env                           	CommonCatBallPreviewDialog              
---@field controller                    	Engine.UI.UILuaDialog                   
---@field skillNameTxt                  	UnityEngine.RectTransform               @ 技能名字
---@field skillStateTxt                 	UnityEngine.RectTransform               @ 技能状态文本
---@field skillBgImg                    	UnityEngine.RectTransform               @ 技能背景图片
---@field skillCardNode                 	UnityEngine.RectTransform               @ 技能卡节点
---@field skillDescrTxt                 	UnityEngine.RectTransform               @ 技能描述
---@field skillTitleTxt                 	UnityEngine.RectTransform               @ 技能标题
---@field skillTypeTxt                  	UnityEngine.RectTransform               @ 技能类型
---@field catBallAttrIcon               	UnityEngine.RectTransform               @ 属性图标
---@field catBallNameTxt                	UnityEngine.RectTransform               @ 猫球名字
---@field BtnRoleNameNode               	UnityEngine.RectTransform               @ 品质节点
local CommonCatBallPreviewDialog = Class('CommonCatBallPreviewDialog')


function CommonCatBallPreviewDialog:__init()
    ---@type table<integer, boolean> @ 之前的场景状态
    self.oldScenesState_ = nil
    ---@type CardProgressionControllerRole
    self.roleController_ = nil
    ---@type table @ 之前的ui相机的状态
    self.oldUICameraState_ = nil
    ---@type CommonBtnRoleNameNode
    self.catBallNameNodeEnv_ = nil
    ---@type CatBallSkillCardNode
    self.catBallSkillNodeEnv_ = nil
    ---@type UnityEngine.Coroutine
    self.loadCatBallModelCo_ = nil
    ---@type Vector3
    self.catBallModelPos_ = nil
    ---@type string
    self.catBallModelId_ = nil
    ---@type UnityEngine.GameObject
    self.catBallModelGo_ = nil
    self.eventRotationRole_ = nil
end


function CommonCatBallPreviewDialog:__delete()
    self.oldScenesState_      = nil
    self.roleController_      = nil
    self.oldUICameraState_    = nil
    self.catBallNameNodeEnv_  = nil
    self.catBallSkillNodeEnv_ = nil
    self.loadCatBallModelCo_  = nil
    self.catBallModelId_      = nil
    self.catBallModelPos_     = nil
    self.catBallModelGo_      = nil
    self.eventRotationRole_   = nil
end


function CommonCatBallPreviewDialog:Awake()
    self.catBallNameNodeEnv_  = CfUtils.GetLuaScr(self.BtnRoleNameNode, Constants.UILuaTablePath.RoleNameNode)
    self.catBallSkillNodeEnv_ = CfUtils.GetLuaScr(self.skillCardNode, SkillNodeEnvPath)
end


function CommonCatBallPreviewDialog:OnFocus(isFocus)
    if isFocus then
        -- set uiCamera state
        CfUtils.SetUICameraProjection(false, 12)
    end
end


function CommonCatBallPreviewDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}

        local catBallPosList  = parse_strings(CatBallUtils.GetCatBallParams(9))
        self.catBallModelPos_ = Vector3.New(checkNumber(catBallPosList[1]), checkNumber(catBallPosList[2]), checkNumber(catBallPosList[3]))

        -- save uiCamera state
        self.oldUICameraState_ = CfUtils.GetUICameraProjectionState()

        -- save scene state
        self.oldScenesState_ = SceneManagementIns:GetShowLoadedScenesState()

        ---@type CardProgressionControllerRole
        self.roleController_ = CardProgressionUtils.GetRoleControllerEnv()

        -- save old role state data 
        if not isNull(self.roleController_) then
            -- self.roleController_:FreshCameraStateByParams({CardProgressionConstants.CameraState.CultivateCatFull, true})
            self.roleController_:FreshCameraStateByParams({CardProgressionConstants.CameraState.ShowRoleOnUI, CatBallCameraPosition , CatBallCameraRotation, false})
            
        end

        -- init scene status
        Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusGrowSceneEventName, true)
        Events.Broadcast(Constants.EventNames.MainHomeRoleActive, {isShowCultivate = true})
        Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, false, false)  -- 人关，猫关
        
        CoYield() -- wait event invoke

        CardProgressionUtils.RegRoleSwipeRegion(self.controller)

        self.eventRotationRole_ = Events.AddListener(CardProgressionConstants.EventNames.RotationRole, Bind(self, self.OnEventRotationRoleHandler_))

        self:SetPreviewCatBallId(initParams.catBallId)
    end)
end


function CommonCatBallPreviewDialog:OnFinalize()
    return CoWaitDo(function()
        Events.RemoveListener(CardProgressionConstants.EventNames.RotationRole, self.eventRotationRole_)

        -- recover uiCamera state
        CfUtils.SetUICameraProjectionState(self.oldUICameraState_)

        -- Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, true, false)  -- 人开，猫关
        -- Events.Broadcast(Constants.EventNames.MainHomeRoleActive, {isShowCultivate = false})
        -- Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusGrowSceneEventName, false)
        -- CoYield() -- wait event invoke

        -- recover scene state
        if next(checkTable(self.oldScenesState_)) then
            SceneManagementIns:RefreshScenesState(self.oldScenesState_)
        end

        -- recover role state
        -- if isNotNull(self.roleController_) then
        --     self.roleController_:RecoveryRoleState()
        -- end

        self:LoadCatBallModelStop_()
        self:DeleteCatBallModel_()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return integer
function CommonCatBallPreviewDialog:GetPreviewCatBallId()
    return checkInt(self.previewCatBallId_)
end
function CommonCatBallPreviewDialog:SetPreviewCatBallId(catBallId)
    self.previewCatBallId_ = checkInt(catBallId)
    self:UpdateCatBallInfo_()
    self:UpdateCatBallModel_()
end


-------------------------------------------------
-- private

function CommonCatBallPreviewDialog:UpdateCatBallInfo_()
    local catBallId = self:GetPreviewCatBallId()
    local catBallVo = CatBallUtils.GetCatBallVo(catBallId)

    -- update catBall name
    CfUtils.FillText(self.catBallNameTxt, tostring(catBallVo.name))

    -- update catBall attrIcon
    local attrIconPath = CatBallUtils.GetAttributeIcon(catBallVo.types, catBallVo.subtype)
    CfUtils.FillImage(self.catBallAttrIcon, attrIconPath)
    
    -- update catBall rare
    self.catBallNameNodeEnv_:RefreshCatBall(catBallId)

    -- update catBall type
    local catType = catBallVo.types
    CfUtils.SetUISwitchText(self.skillTypeTxt, catType == Constants.CatBallType.Operates and 2 or 1)

    -- update skill info
    local skillDesc, skillName, skillVo = CatBallUtils.GetCatBallSkillDesc(catBallId, catBallVo.starMax, catType)
    CfUtils.FillText(self.skillDescrTxt, skillDesc)
    CfUtils.FillText(self.skillNameTxt, skillName)
    -- CfUtils.FillText(self.skillTitleTxt, skillName)
    CfUtils.SetUISwitchImage(self.skillBgImg, catType)
    CfUtils.SetUISwitchText(self.skillStateTxt, catType)
    self.catBallSkillNodeEnv_:FreshCatBallSkill(skillVo, catType)
end


function CommonCatBallPreviewDialog:UpdateCatBallModel_()
    local catBallId = self:GetPreviewCatBallId()
    local catBallVo = CatBallUtils.GetCatBallVo(catBallId)
    local modelGoId = tostring(catBallVo.roleId)
    if self.catBallModelId_ == modelGoId then
        return
    end

    self:LoadCatBallModelStop_()
    self:DeleteCatBallModel_()
    self:LoadCatBallModelStart_(modelGoId, catBallVo)
end


---@param modelId integer
---@param catBallVo CatBallVo
function CommonCatBallPreviewDialog:LoadCatBallModelStart_(modelId, catBallVo)
    self.loadCatBallModelCo_ = CoStart(function()
        ---@param go UnityEngine.GameObject
        catBallComp:LoadCatModelAsync(MaidCoffeeConstants.BornType.Adult, catBallVo.catId, false, catBallVo.kind, nil, function(go)
            go.name = tostring(modelId)
            local transform = go.transform
            transform.position = self.catBallModelPos_
            transform.localRotation = CatModelInteractionLocalRotation
            -- save
            self.catBallModelId_ = modelId
            self.catBallModelGo_ = go
        end)
    end)
end


function CommonCatBallPreviewDialog:LoadCatBallModelStop_()
    if self.loadCatBallModelCo_ then
        CoStop(self.loadCatBallModelCo_)
        self.loadCatBallModelCo_ = nil
    end
end


function CommonCatBallPreviewDialog:DeleteCatBallModel_()
    if isNotNull(self.catBallModelGo_) then
        CfUtils.SafeDelete(self.catBallModelGo_, true)
        self.catBallModelGo_ = nil
    end
    self.catBallModelId_ = nil
end


-------------------------------------------------
-- hander

function CommonCatBallPreviewDialog:OnEventRotationRoleHandler_(direction)
    if isNull(self.catBallModelGo_) then return end

    local transform   = self.catBallModelGo_.transform
    local eulerAngles = Vector3.New(0, direction, 0)
    transform:Rotate(eulerAngles)
end


return CommonCatBallPreviewDialog
