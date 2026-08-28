
------------ import ------------
local SceneManagementIns = SceneManagement:GetInstance()
---@type CardConfMgr
local cardConfMgr        = CardConfMgr:GetInstance()
---@type GoodsConfMgr
local goodsConfMgr       = GoodsConfMgr:GetInstance()
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
---@type CardProgressionCombatEffUtils
local CardProgressionCombatEffUtils     = import("Game.CardProgression.CardProgressionCombatEffUtils")

---@type IdolLive3D_States
local IdolLive3D_States = import('Game.IdolLive3D.IdolLive3D_States')
local IdolLive3D_Utils = import('Game.IdolLive3D.IdolLive3D_Utils')
local IdolLive3D_Loader = import('Game.IdolLive3D.IdolLive3D_Loader')
local KTool = CS.Engine.Lib.KTool

------------ import ------------


--- from: Assets/BundleResources/Prefabs/Common/CommonStylePreview.prefab > name: CommonStylePreview
---@class CommonCardStylePreviewDialog
---@field Env                           	CommonCardStylePreviewDialog            
---@field controller                    	Engine.UI.UILuaDialog                   
---@field ImgInteract                   	UnityEngine.RectTransform               	@ 0    可否互动标识
---@field TextDesc                      	UnityEngine.UI.Text                     	@ 1    
---@field ButtonGroup                   	UnityEngine.RectTransform               	@ 2    
---@field ItemAttribute                 	UnityEngine.RectTransform               	@ 3    
---@field SkinImgRare2                  	Game.Native.Common.UISwitchImage        	@ 4    
---@field TextFashionName               	UnityEngine.UI.Text                     	@ 5    
---@field RareNode                      	UnityEngine.RectTransform               	@ 6    
---@field StatusNotGet                  	UnityEngine.RectTransform               	@ 7    
---@field ImgRole                       	Engine.UI.RawImageAlterable             	@ 8    
---@field RoleRareNode                  	UnityEngine.RectTransform               	@ 9    
---@field BtnEnlarge                    	UnityEngine.RectTransform               	@ 10   
---@field ImgBrand                      	UnityEngine.RectTransform               	@ 11   
---@field ImgRareLine                   	Game.Native.Common.UISwitchImage        	@ 12   
---@field UIFX_Skin_Up                  	UnityEngine.RectTransform               	@ 13   
---@field UIFX_Skin_Down                	UnityEngine.RectTransform               	@ 14   
---@field BtnInteractive                	UnityEngine.RectTransform               	@ 15   深度互动入口按钮
local CommonCardStylePreviewDialog = Class('CommonCardStylePreviewDialog')


function CommonCardStylePreviewDialog:__init()
end


function CommonCardStylePreviewDialog:__delete()
end


function CommonCardStylePreviewDialog:Awake()
end


function CommonCardStylePreviewDialog:OnInitialize()
    return CoWaitDo(function()
        SetButtonAction(self.BtnEnlarge, Bind(self, self.OnClickBtnEnlargeAction))
        SetButtonAction(self.BtnInteractive.gameObject, Bind(self, self.OnClickBtnIdolLive3D))

        -- save scene state
        -- self.oldScenesState_ = SceneManagementIns:GetShowLoadedScenesState()

        ---@type CardProgressionControllerRole
        self._controllerEnv = CardProgressionUtils.GetRoleControllerEnv()
        -- save old role state data 
        -- if not isNull(self._controllerEnv) then
        --     self._controllerEnv:StoreRoleState()
        -- end
        
        -- init scene status
        Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, false, false)  -- 人开，猫关
        Events.Broadcast(Constants.EventNames.MainHomeRoleActive, {isShowCultivate = true})
        Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusGrowSceneEventName, true)
        
        ----因为有些场景跳转展示界面的时候  主场景的XHome是被干掉了的 接收不到上面的事件 所以加一个这个
        SceneManagement:GetInstance():SetActive(Constants.IdSceneSetting45, true)
        
        CoYield() -- wait event invoke
        
        self:InitData()

        if not isNull(self._controllerEnv) then
            self._controllerEnv:LoadRole(self._skinId, false, {CardProgressionConstants.CameraState.CultivateRoleFull, self._isIndie ~= false}, false, self._dojo, false, true)
            while not self._controllerEnv:IsLoadRoleComplete() do
                CoYield()
            end
        end

    end)
end


function CommonCardStylePreviewDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


function CommonCardStylePreviewDialog:OnFocus(isFocus)
    CfUtils.SetActive(self.controller, checkBool(isFocus))
    if isFocus then
        -- set uiCamera state
        CfUtils.SetUICameraProjection(false, 12)
    end
end


function CommonCardStylePreviewDialog:OnShow()
    return CoWaitDo(function()
        self:FreshUI()
        Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, true)
    end)
end


function CommonCardStylePreviewDialog:OnHide()
    return CoWaitDo(function()

        --if not self._isObserve and self._isIndie then
        --    --Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, true, false)  -- 人开，猫关
        --    --Events.Broadcast(Constants.EventNames.MainHomeRoleActive, {isShowCultivate = false})
        --    --Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusGrowSceneEventName, false)
        --    CoYield() -- wait event invoke
        --end

        if not self._isObserve then
            -- recover scene state
            -- if next(checkTable(self.oldScenesState_)) then
            --     SceneManagementIns:RefreshScenesState(self.oldScenesState_)
            -- end

            -- recover role state
            -- if not isNull(self._controllerEnv) then
            --     self._controllerEnv:RecoveryRoleState()
            -- end
        end
    end)
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

function CommonCardStylePreviewDialog:InitData()
    local parameters = checkTable(self.controller.Argument.parameters)
    self._isIndie    = parameters.isIndie ~= false
    
    ---@type CardDojo
    local skinId = checkInt(parameters.skinId)
    local dojo   = parameters.dojo
    self._dojo   = dojo
    self._skinId = skinId

    ---@type CardSkinVo
    local skinVo = cardConfMgr:GetCardSkinBySkinId(skinId)
    self._skinVo = skinVo

    ---@type CardVo
    local cardVo = cardConfMgr:GetCardByRefId(skinVo.roleId)
    self._cardVo = cardVo
    local isUrSkin = skinId == cardVo.urSkin
    self._cardRare = isUrSkin and Constants.RareType.UR or cardVo.rare

    ---@type GoodsVo
    local goodsVo      = goodsConfMgr:GetGoodsVoById(skinId)
    self._goodsVo      = goodsVo
    
    local skinRare = skinVo:GetRare()
    self._skinRare = skinRare

    local skinMaxLevel = skinVo.skinMaxLevel
    self._attributes = self:InitAttributes(skinMaxLevel, skinId)

    self._unlockText = self:InitUnlockText(goodsVo)

    ---@type CardSkinComponent
    local cardSkinComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardSkinComponent)
    self._isUnlock          = cardSkinComponent:IsHasSkin(skinVo.skinId)
end

function CommonCardStylePreviewDialog:InitAttributes(skinMaxLevel, skinId)
    local isShowAttr = skinMaxLevel > 0
    if not isShowAttr then
        return nil
    end

    ---@type SkinAttributeVo
    local vo = cardConfMgr:GetSkinAttributeVo(skinId, skinMaxLevel)
    local attrAddId2V = vo:GetAttributes()
    local isShow = next(attrAddId2V) ~= nil
    if isShow then
        return CardProgressionCombatEffUtils.GenerateSingleAttrTypeDataByAttrAddId2V(attrAddId2V, true)
    end
    return nil
end

--- InitUnlockText
---@param goodsVo GoodsVo
function CommonCardStylePreviewDialog:InitUnlockText(goodsVo)
    local jumpAway = goodsVo.jumpAway
    local isShowJumpAway = jumpAway ~= nil and #jumpAway > 0
    local text
    if isShowJumpAway then
        for i, v in ipairs(jumpAway) do
            local row = goodsConfMgr:GetJumpModuleRow(v)
            local functionName = GoodsUtils.GetFunctionName(row, goodsVo, i)
            text = functionName
            break
        end
    end
    return text
end

---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

function CommonCardStylePreviewDialog:FreshUI()
    --printError("FreshUI")
    ---@type CardSkinVo
    local skinVo = self._skinVo
    ---@type CardVo
    local cardVo = self._cardVo
    ---@type GoodsVo
    local goodsVo = self._goodsVo

    
    local cardRare = self._cardRare
    self:FreshRoleRareNode(cardRare, cardVo.roleId)

    CfUtils.FillImage(self.ImgRole, tostring(skinVo.cardHeadList))
    CardUtils.RefreshCardSkinEffectHead(skinVo, self.ImgRole, self.UIFX_Skin_Up, self.UIFX_Skin_Down)

    CfUtils.SetActive(self.RareNode, true)
    self.SkinImgRare2.Status = self._skinRare
    self.ImgRareLine.Status = self._skinRare

    if string.isEmpty(self._skinVo.version) then
        CfUtils.SetActive(self.ImgBrand, false)
    else
        CfUtils.SetActive(self.ImgBrand, true)
        CfUtils.FillImage(self.ImgBrand, self._skinVo.version)
    end

    self.TextFashionName.text = goodsVo.name
    
    -- 深度互动:
    self:RefreshLive3DBtn_( self._skinId )

    CfUtils.SetActive(self.StatusNotGet, not self._isUnlock)
    self:FreshAttributes()

    self:FreshBottomGroup()
end

function CommonCardStylePreviewDialog:FreshRoleRareNode(rare, cardId)
    ---@type CardProgressionRoleRareNode
    local env = CfUtils.GetLuaScr(self.RoleRareNode, CardProgressionConstants.EnvPath.CardProgressionRoleRareNode)
    if isNull(env) then return end
    env:FreshUI(rare, cardId)
    env:FreshCV()

end

function CommonCardStylePreviewDialog:FreshAttributes()
    local isShow = self._attributes ~= nil
    CfUtils.SetActive(self.ItemAttribute, isShow)
    if not isShow then return end
    
    ---@type CardProgressionAttributeGroupNode
    local env = CfUtils.GetLuaScr(self.ItemAttribute, CardProgressionConstants.EnvPath.CardProgressionAttributeGroupNode)
    if isNull(env) then return end
    env:FreshUI(self._attributes)

end

function CommonCardStylePreviewDialog:FreshBottomGroup()
    local isShow = self._unlockText ~= nil and not self._isUnlock
    CfUtils.SetActive(self.ButtonGroup, isShow)
    if isShow then
        self.TextDesc.text = self._unlockText
    end
end

---------------------------------------------------
--- logic end --
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

function CommonCardStylePreviewDialog:OnClickBtnEnlargeAction()
    local isCat = 0
    --local DOTween = CS.DG.Tweening.DOTween
    --DOTween.KillAll()
    if not isNull(self._controllerEnv) then
        self._controllerEnv:StopTimeLine()
    end
    self._isObserve = true
    CardProgressionUtils.OpenDialog(
            Constants.UITypeIds.UICultivateObserveDialog,
            { cardId = self._cardVo.roleId, cardSkin = self._skinId, isCat = isCat}, {
                UIArgs(Constants.UITypeIds.CommonStylePreView)
            })
end



function CommonCardStylePreviewDialog:RefreshLive3DBtn_( skinID_ )
    local skinId = skinID_
    local btnGray = self.BtnInteractive:Find("ImgIcon")

    ---@type CardSkinComponent
    local CardSkinComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardSkinComponent)
    local isHasSkin = CardSkinComponent:IsHasSkin(self._skinId)       -- 是否购买 皮肤

    if isNotNull(IdolLive3D_Utils.GetLive3DCardVoRow(skinId)) then -- 这个皮肤支持 深度互动
        if isHasSkin==false or IdolLive3D_Utils.IsBuyThisSkinsLive3D(skinId) == false then -- 没额外购买这个皮肤的 深度互动服务
            CfUtils.MarkGray(btnGray.gameObject, true)
        else 
            CfUtils.MarkGray(btnGray.gameObject, false)
        end
        KTool.SetActive( self.ImgInteract,                  true )
        KTool.SetActive( self.BtnInteractive.gameObject,    true )
    else 
        KTool.SetActive( self.ImgInteract,                  false )
        KTool.SetActive( self.BtnInteractive.gameObject,    false )
    end 
end


function CommonCardStylePreviewDialog:OnClickBtnIdolLive3D()
    self._isObserve = true
    ---@type CardSkinComponent
    local CardSkinComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardSkinComponent)
    local isHasSkin = CardSkinComponent:IsHasSkin(self._skinId)       -- 是否购买 皮肤
    local isBuy = IdolLive3D_Utils.IsBuyThisSkinsLive3D(self._skinId) -- 是否购买 深度互动 功能
    print("深度互动 :--" .. (isHasSkin and "有皮肤" or "没皮肤"))

    if isHasSkin ~= true then 
        --GameUtils.Toast( localize("购买皮肤后才能进入互动") ) -- 飘字

        local cardConfMgr = CardConfMgr:GetInstance()
        local skinConf = cardConfMgr:GetCardSkinBySkinId(self._skinId)
        --printError("name = " .. tostring(skinConf.name))
        GameUtils.Toast( localize("拥有_name_后,可以继续深入互动",{_name_=skinConf.name}) ) -- 飘字

        return
    end 
    
    ---
    local skinId = checkInt(self._skinId)
    IdolLive3D_Loader.TryOpenScene( skinId,  (isHasSkin==false) or (isBuy==false) )
end




---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CommonCardStylePreviewDialog
