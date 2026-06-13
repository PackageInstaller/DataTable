local RoleDevelopModule = BaseClass("RoleDevelopModule", require("Framework.Module.BaseGameModule"))
local M = RoleDevelopModule
local EInteractActionBehaviorType =EnumConst.EInteractActionBehaviorType
local rotateSpeed = 10
local MAX_SHOW_GIRL_CACHE_COUNT = 5 --缓存战员数量
local REMOVE_GIRL_COUNT = 3 -- 达到缓存数量之后，一次性删除的个数

function M:__init()
    self._isFirstTime = true
end

function M:OnEnter(id, index)
    IRoleActionMgr:Reset()
    M.super.OnEnter(self)
    self._isFirstTime = true
    self._camerMoveHandler = EventMgr:AddListener(UIMessageNames.ROLE_DEVELOP_CAMERA_MOVE, Bind(self, self._OnCamerMove))
    
    self.m_CurGeneIndex = 0
    self.m_OldGeneScale = 0.84285
    self.m_Slider = { 1, 0.82, 0.67, 0.5, 0.33, 0.15, 0 }
    self._curHeroId = 0
    self._lastGenrateRoleTime = 0
    self._canDrag = false
    self.showGirlTab = {}
    self.geneArr = {}
    
    
    self.selectHeroId = id
    self.index = index
    
    if self:GetCurSceneName() ~= "Display02" then
        self:LoadScene("Display02", Bind(self, self._LoadSceneComplete))
    else
        --防止点击顶站导航直接再跳到养成里面，同一帧既删UI又显示UI，会造成BUG 
        --TimerManager:GetInstance():GetTimer(0.1,self._LoadSceneComplete,self,true):Start()
        self:_LoadSceneComplete(self:GetViewAndCtrl("Display02"))
    end
    
    GameHelper.DoPlayerAction(PlayerAction.OpenHero)
end

function M:_LoadSceneComplete(_, ctrl)
    ctrl:ChangeDisplay("Display02")
    self._view = ctrl:GetHolder("Display02")
    self._geneSpinMat = self._view.geneSpinMat
    self:CreateDirector(self._view.CameraNode)
    RoleBehaviorCtrl:GetInstance():RemoveAllGirls()
    --30 是写死的FOV
    self:GetCameraDirector():CameraTranslation(0, 0, 1.39, 3.831, 8, -180, 0, 30)
    self:ShowUIAsyn()
end

function M:ShowUIAsyn()
    self:Ready()
    self.geneLst = {}
    
    if self.index == 7  then 
        self:SetGeneSpin(false)
        UIContextMgr:GetInstance():Show("RoleFashionUI", self.selectHeroId, false)
    elseif self.index == 8 then
        self:SetGeneSpin(false)
        UIContextMgr:GetInstance():Show("RoleFashionUI", self.selectHeroId, true)
    else
        UIContextMgr:GetInstance():Show(UIDefine.RoleDevelopMain, self.selectHeroId, self.index)
    end
end

function M:_FadeInCamera()
end

function M:_OnCamerMove(duration, x, y, z, vx, vy, vz)
    if self._isFirstTime then
        duration = 0
    end
    
    self._isFirstTime = false
    
    if self.cameraDirector then
        --30是写死的FOV
        self.cameraDirector:CameraTranslation(duration, x, y, z, vx, vy, vz, 30)
    end
end

function M:OnExit()
    UIContextMgr:GetInstance():Close("RoleDevelopUI")
    UIContextMgr:GetInstance():Close(UIDefine.UIRoleLevelUp)
    UIContextMgr:GetInstance():Close("RolePreviewPop")
    --UIContextMgr:GetInstance():Close(UIDefine.UIRoleCore)
    UIContextMgr:GetInstance():Close("RoleProfileUI")
    UIContextMgr:GetInstance():Close("RoleSkillUI")
    UIContextMgr:GetInstance():Close("RoleAwakeShow")
    --UIContextMgr:GetInstance():Close("GeneDetailUI")
    UIContextMgr:GetInstance():Close("RoleDevelopMain")
    UIContextMgr:GetInstance():Close("RoleStoryPop")
    UIContextMgr:GetInstance():Close("RoleSkillDetailUI")
    UIContextMgr:GetInstance():Close("UIGeneDetail")
    UIContextMgr:GetInstance():Close("UIRoleGene")
    UIContextMgr:GetInstance():Close("RoleFashionUI")
    
    EventMgr:RemoveListener(UIMessageNames.ROLE_DEVELOP_CAMERA_MOVE, self._camerMoveHandler)

    self.showGirl = nil
    
    for heroId, girl in pairs(self.showGirlTab) do
        RoleBehaviorCtrl:GetInstance():RemoveGirl(heroId, RoleUse.Delveop)
        --GameUtil.DestroyGo(fsm.gameObject)
    end
    
    ResourceManager:GetInstance():RemoveUnusedAssets()
    self.showGirlTab = nil
    
    M.super.OnExit(self)
end

--隐藏当前模型
function M:HideHero()
    self.isHideHero = true
    if self.showGirl ~= nil then
        self.showGirl:Hide()
        self.showGirl = nil
    end
end

---isEnter :是否需要入场动画
function M:_RefreshModel(heroId, withWeapon, isEnter, isSkinId, istemplate)
    --正在加载过程中
    if self.isLoadHero then
        return
    end
    self.isHideHero = nil
    if self.showGirl ~= nil then
        self.showGirl:Hide()
    end
    if not self._view then
        return
    end
    local skinId = heroId
    local herodata
    if not isSkinId then
        herodata = IHeroDataMgr:GetMyHeroDataById(heroId)
        local fashion = 0
        if herodata then
            fashion = herodata:GetFashion()
        end
        skinId = GameHelper.HeroId2SkinId(heroId, fashion)
    end

    if self.showGirlTab and self.showGirlTab[skinId] ~= nil then
        self.showGirl = self.showGirlTab[skinId]
        self:ShowWeapon(withWeapon, isEnter, skinId)
    else
        local CommonShowCtrlWithCustom = require("RoleBehavior.Ctrls.CommonShowCtrlWithCustom")
        local function createCallBack(showGril)
            -- --已经切换到主界面
            if not self._view then
                return
            end
            self.showGirl = showGril
            
            self.showGirl.transform:SetParent(self._view.showGirlRoot, false)
            self.showGirlTab[skinId] = self.showGirl
            self.showGirl:SetCanTouch(false)
            if table.count(self.showGirlTab) >= MAX_SHOW_GIRL_CACHE_COUNT then
                local heroIdList = {}

                for id, _ in pairs(self.showGirlTab) do
                    if id ~= skinId and #heroIdList <= REMOVE_GIRL_COUNT then
                        table.insert(heroIdList, id)
                    end
                end

                for _, hid in ipairs(heroIdList) do
                    -- body
                    RoleBehaviorCtrl:GetInstance():RemoveGirl(hid)
                    self.showGirlTab[hid] = nil
                end

                ResourceManager:GetInstance():RemoveUnusedAssets()
            end
            self:ShowWeapon(withWeapon, isEnter, skinId)
            self.isLoadHero = nil
            if self.isHideHero then
                self:HideHero()
                return
            end
        end
        self.isLoadHero = true
        -- 异步创建高模
        if isSkinId then
            RoleBehaviorCtrl:GetInstance():CreateGirlBySkinIdAsync(heroId, withWeapon, CommonShowCtrlWithCustom, RoleUse.Delveop, istemplate and 4 or 2, createCallBack, EInteractActionBehaviorType.Enter_Develop, EInteractActionBehaviorType.Develop_StandBy, 1)
        else
            if herodata ~= nil and herodata:IsAwake() then
                RoleBehaviorCtrl:GetInstance():CreateGirlAsync(heroId, withWeapon, CommonShowCtrlWithCustom, RoleUse.Delveop, istemplate and 3 or 2, createCallBack, EInteractActionBehaviorType.Enter_Develop, EInteractActionBehaviorType.Develop_StandBy, 3)
            else
                RoleBehaviorCtrl:GetInstance():CreateGirlAsync(heroId, withWeapon, CommonShowCtrlWithCustom, RoleUse.Delveop, istemplate and 1 or 2, createCallBack, EInteractActionBehaviorType.Enter_Develop, EInteractActionBehaviorType.Develop_StandBy, 1)
            end
        end
    end

end

-- 创建完成后创建武器
function M:ShowWeapon(withWeapon, isEnter, skinId)
    local defaultState = RoleStateName.None
    local needPlay = false
    if not isEnter then
        needPlay = true
        defaultState = RoleStateName.Idle
    end
    self.showGirl:ShowWeapon(withWeapon)
    self.showGirlTab[skinId]:Show(defaultState, needPlay)
    self._lastGenrateRoleTime = Time.realtimeSinceStartup
end

--顯示角色模型，並且播放指定timelineId
function M:ShowHeroModel(heroId, withWeapon, isEnter, isSkinId,istemplate)
    if not heroId then
        return 
    end
    
    if self.showGirl and self._curHeroId == heroId then
        return 
    end
    
    --默認持有武器
    if withWeapon == nil then
        withWeapon = true
    end

    if isSkinId == nil then
        isSkinId = false
    end
    
    if heroId > 0 then
        self:_RefreshModel(heroId, withWeapon, isEnter, isSkinId,istemplate)
    end
    
    self._curHeroId = heroId
end

--歸位模型
function M:ResetModel()
    self.showGirl.transform.localEulerAngles = Vector3.zero
end

--是否可以拖動
function M:SetDrag(canDrag)
    self._canDrag = canDrag
end

--關閉核心3D圈
function M:CloseCoreCircle()
    --self._view.CircleUI.gameObject:SetActive(false)
end

--修改基因中心转动的模型材质
function M:ModifyGeneSpin(maxSlot)
    if IsNull(self._geneSpinMat) then
        return 
    end
    
    maxSlot = maxSlot + 1
    local values = { 0.65, 0.474, 0.416, 0.358, 0.295, 0 }
    
    if maxSlot > #values then
        maxSlot = #values
    end
    
    local v = values[maxSlot]
    local ShaderTool = CS.GameX.Art.ShaderTool
    ShaderTool.LoadPropertyBlock(self._geneSpinMat);
    ShaderTool.PropertyBlock:SetVector(CS.GameX.Art.ShaderProperty.MaskTexST.ID, CS.UnityEngine.Vector4(0.91, 0.3, 0, v));
    ShaderTool.SavePropertyBlock(self._geneSpinMat);
end

function M:SetGeneSpin(isActive)
    self._view.geneSpin:SetActive(isActive)
end

function M:SetGeneBallInfo(starArr, nameArr, starLen)
    local len = starLen - 1
    
    for i = 1, #self.geneLst do
        if i <= #starArr then
            local isUnlock = starArr[i] > 0
            local fill = starArr[i] / len
            self.geneLst[i]:SetGeneBallInfo(isUnlock, nameArr[i], starArr[i], fill)
        end
    end
end

function M:_CalculateAttr(tab)
    local AttrTab = {}
    
    for key, value in pairs(tab) do
        for index, v in ipairs(value.attributeType) do
            if AttrTab[v] == nil then
                AttrTab[v] = value.attributeValue[index]
            else
                AttrTab[v] = AttrTab[v] + value.attributeValue[index]
            end
        end
    end
    return AttrTab
end

function M:ClearSceneBg()
    self._view.tfbg:SetActive(false)
end

function M:SetSceneBg()
    self._view.tfbg:SetActive(true)
end

--设置场景中的阵营
function M:SetFaction(faction)
    self._view.factionScene:SetFactionMat(faction)
end

--设置核心效果
function M:SetCoreEffectState(state)
    self._view.tfCoreEffect:SetActive(state)
end

local StoryStageNum = {
    2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014
}

M.StoryStageNum = StoryStageNum

function M:IsLoadHero()
    return self.isLoadHero
end

return RoleDevelopModule


