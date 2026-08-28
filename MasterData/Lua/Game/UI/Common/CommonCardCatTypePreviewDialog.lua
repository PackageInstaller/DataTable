-------------------------------------------------------------------------------
-- 三方卡牌预览弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-04-06 14:53:41
-------------------------------------------------------------------------------

---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionUtils
local CardProgressionUtils = import("Game.CardProgression.CardProgressionUtils")
---@type CardConfMgr
local cardConfMgr = CardConfMgr:GetInstance()
---@type SceneManagement
local SceneManagementIns = SceneManagement:GetInstance()
---@type GachaponUtils
local GachaponUtils = import('Game.Gachapon.GachaponUtils')

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/IllustratedHandbook/IllustratedHandbookCatDetailsDialog.prefab
---@class CommonCardCatTypePreviewDialog
---@field Env                           	CommonCardCatTypePreviewDialog                
---@field controller                    	Engine.UI.UILuaDialog                   
---@field DescrParagraphText            	UnityEngine.RectTransform               @ 描述内容文本
---@field DescrContentNode              	UnityEngine.RectTransform               @ 描述内容节点
---@field DescrScrollView               	UnityEngine.RectTransform               @ 描述滚动视图
---@field TitleNameText                 	UnityEngine.RectTransform               @ 标题名字文本
---@field RightPanel                    	UnityEngine.RectTransform               @ 右侧面板根节点
local CommonCardCatTypePreviewDialog = Class("CommonCardCatTypePreviewDialog")


function CommonCardCatTypePreviewDialog:__init()
    ---@type table<integer, boolean> @ 之前的场景状态
    self.oldScenesState_ = nil
    ---@type CardProgressionControllerRole
    self.roleController_ = nil
    ---@type integer @ 之前的看板皮肤id
    self.oldRoleSkinId_ = nil
    ---@type integer @ 之前的卡牌猫种id
    self.oldCardTypeId_ = nil
    ---@type CardProgressionConstants.CameraState @ 之前的看板相机位置
    self.oldCameraState_ = nil
    ---@type CardDojo @ 之前的看板卡牌数据
    self.oldShowCardDojo_ = nil
    ---@type table @ 之前的ui相机的状态
    self.oldUICameraState_ = nil
end


function CommonCardCatTypePreviewDialog:__delete()
    self.oldScenesState_   = nil
    self.roleController_   = nil
    self.oldRoleSkinId_    = nil
    self.oldCardTypeId_    = nil
    self.oldCameraState_   = nil
    self.oldShowCardDojo_  = nil
    self.oldUICameraState_ = nil
end


function CommonCardCatTypePreviewDialog:Awake()
    -- FIXME: 由于未知原因，真机上会变成白色色块，先强制手动加载一次进行补救
    local imagePath = "UIAtlas/IllustratedHandbook/Main/illust_book_img_cat_title_bg.png"
    local imgBgTran = self.controller.transform:Find("Root/Container/RightPanel/Title/ImgBg")
    local imgBgNode = imgBgTran:GetComponent(typeof(CS.UnityEngine.UI.Image))
    GachaponUtils.LoadSpriteAsync(imgBgNode, imagePath)
end


function CommonCardCatTypePreviewDialog:OnFocus(isFocus)
    if isFocus then
        -- set uiCamera state
        CfUtils.SetUICameraProjection(false, 12)
    end
end


function CommonCardCatTypePreviewDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}

        -- save uiCamera state
        self.oldUICameraState_ = CfUtils.GetUICameraProjectionState()

        -- save scene state
        self.oldScenesState_ = SceneManagementIns:GetShowLoadedScenesState()

        ---@type CardProgressionControllerRole
        self.roleController_ = CardProgressionUtils.GetRoleControllerEnv()
        -- init scene status
        Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, false, false)  -- 人关，猫关
        Events.Broadcast(Constants.EventNames.MainHomeRoleActive, {isShowCultivate = true})
        Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusGrowSceneEventName, true)
        CoYield() -- wait event invoke

        CardProgressionUtils.RegRoleSwipeRegion(self.controller)

        -- save role skinId
        if not isNull(self.roleController_) then
            self.oldRoleSkinId_   = self.roleController_:GetCatSkinId()
            self.oldCameraState_  = self.roleController_:GetCameraState()
            self.oldShowCardDojo_ = self.roleController_:GetWeaponShowStateByDojo()
            if checkInt(self.oldRoleSkinId_) > 0 then
                local oldRoleSkinVo = cardConfMgr:GetCardSkinBySkinId(self.oldRoleSkinId_)
                local oldRoleCardVo = cardConfMgr:GetCardByRefId(oldRoleSkinVo.roleId)
                self.oldCardTypeId_ = checkInt(oldRoleCardVo.catType)
            end
        end

        -- init vars
        self:SetPreviewCatTypeId(initParams.catTypeId)
        if checkInt(initParams.cardSkinId) > 0 then
            self:SetPreviewCardSkinId(initParams.cardSkinId)
        else
            self:CheckCardSkinIdByCatTypeId_()
        end
    end)
end


function CommonCardCatTypePreviewDialog:OnFinalize()
    return CoWaitDo(function()

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
        if not isNull(self.roleController_) then
            -- local nowRoleSkinId  = self.roleController_:GetRoleSkinId()
            -- local nowCameraState = self.roleController_:GetCameraState()
            -- if self.oldRoleSkinId_ ~= nowRoleSkinId then
                -- self.roleController_:LoadRole(self.oldRoleSkinId_, false, {self.oldCameraState_, true}, false, self.oldShowCardDojo_)
            -- end
            self.roleController_:RecoveryRoleState()
        end

        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return integer
function CommonCardCatTypePreviewDialog:GetPreviewCatTypeId()
    return checkInt(self.previewCatTypeId_)
end
function CommonCardCatTypePreviewDialog:SetPreviewCatTypeId(catTypeId)
    self.previewCatTypeId_ = checkInt(catTypeId)
end


---@return integer
function CommonCardCatTypePreviewDialog:GetPreviewCardSkinId()
    return checkInt(self.previewCardSkinId_)
end
function CommonCardCatTypePreviewDialog:SetPreviewCardSkinId(cardSkinId)
    self.previewCardSkinId_ = checkInt(cardSkinId)
    self:UpdatePreviewCardCat_()
end


-------------------------------------------------
-- private

function CommonCardCatTypePreviewDialog:CheckCardSkinIdByCatTypeId_()
    ---@param cardVo CardVo
    for voIndex, cardVo in ipairs(CfUtils.GetWholeVo(AutoIds.IdSetting28, 'CardVo')) do
        if checkInt(cardVo.catType) == self:GetPreviewCatTypeId() then
            self:SetPreviewCardSkinId(cardVo.defaultSkin)
            break
        end
    end
end


function CommonCardCatTypePreviewDialog:UpdatePreviewCardCat_()
    local typeId = self:GetPreviewCatTypeId()
    local typeVo = cardConfMgr:GetCatTypeVoById(typeId)
    local skinId = self:GetPreviewCardSkinId()
    local skinVo = cardConfMgr:GetCardSkinBySkinId(skinId)

    -------------------------------------------------
    -- load cat model
    local newCameraState = CardProgressionConstants.CameraState.CultivateCatFull
    self.roleController_:LoadCat(skinId, {newCameraState, true})

    -------------------------------------------------
    -- update cat name
    CfUtils.FillText(self.TitleNameText, tostring(typeVo.name))
    -------------------------------------------------

    -- update cat descr
    CfUtils.FillText(self.DescrParagraphText, tostring(typeVo.introduction))
end


return CommonCardCatTypePreviewDialog
