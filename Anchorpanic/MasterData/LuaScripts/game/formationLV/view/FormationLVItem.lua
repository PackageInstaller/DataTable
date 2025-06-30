module("formationLV.FormationLVItem", Class.impl(BaseReuseItem))

UIRes = UrlManager:getUIPrefabPath("pet/PetItem.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构
function dtor(self)
end
--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

-- 初始化
function configUI(self)
    self.mNormal = self:getChildGO("mNormal")
    self.mPetIcon = self:getChildGO("mPetIcon"):GetComponent(ty.AutoRefImage)
    self.mUsed = self:getChildGO("mUsed")
    self.mTxtUsed = self:getChildGO("mTxtUsed"):GetComponent(ty.Text)
    self.mPetLock = self:getChildGO("mPetLock")
    self.mSelect = self:getChildGO("mSelect")
    self.mFormationLock = self:getChildGO("mFormationLock")
    self.mAdd = self:getChildGO("mAdd")
    self.mShape = self:getChildGO("mShape"):GetComponent(ty.AutoRefImage)
    self:setGuideTrans("guide_formation_add", self.UITrans)
end

function setData(self, cusParent, data)
    self:setParentTrans(cusParent, 0)
    self.mPetConfig = data
    if self.mPetConfig then
        self.mAdd:SetActive(false)
        self.mNormal:SetActive(true)
        self.mPetLock:SetActive(false)
        self.mPetIcon:SetImg(UrlManager:getIconPath(self.mPetConfig.mPetHead))
        local isUnlock = formationLV.FormationLVManager:getIsUnlock(self.mPetConfig.mId)
        self.mFormationLock:SetActive(not isUnlock)
        self:showShape(false)
        -- local isInUse = formation.FormationManager:getInUsePetList(self.mPetConfig.mId)
        -- self.mUsed:SetActive(isInUse)
    else
        self.mAdd:SetActive(true)
        self.mNormal:SetActive(false)
    end
    self:updateRed()
end

function updateRed(self)
    if (self.mPetConfig) then
        local unlock = formationLV.FormationLVManager:getIsUnlock(self.mPetConfig.mId)
        if not unlock then
            local stageUnlock = self.mPetConfig.mStage == 0 and true or battleMap.MainMapManager:isStagePass(self.mPetConfig.mStage)
            if (self.mPetConfig.mLevel <= role.RoleManager:getRoleVo():getPlayerLvl() and stageUnlock) then
                RedPointManager:add(self.UIObject.transform, nil, 43, 49)
            else
                RedPointManager:remove(self.UIObject.transform)
            end
        end
    else
        if (formationLV.FormationLVManager:getHasRed()) then
            RedPointManager:add(self.UIObject.transform, nil, 43, 49)
        else
            RedPointManager:remove(self.UIObject.transform)
        end
    end
end

function setInUse(self, showInUse, teamIndex)
    if showInUse then
        self.mTxtUsed.text = _TT(25194) -- "使用中"
        self.mUsed:SetActive(showInUse)
    elseif teamIndex and teamIndex > 0 then
        -- 其他队伍使用
        self.mTxtUsed.text = string.format("队伍%s", teamIndex)
        self.mUsed:SetActive(true)
    else
        self.mUsed:SetActive(false)
    end
end

function setSelect(self, isSelect)
    self.mSelect:SetActive(isSelect)
end

function showShape(self, isShow)
    -- if not self.mPetConfig then 
    --     return
    -- end
    if isShow then
        self.mNormal:SetActive(false)
        if self.mPetConfig then
            self.mShape:SetImg(UrlManager:getIconPath(self.mPetConfig.mPetHead))
        end
        self.mShape.gameObject:SetActive(self.mPetConfig)
    else
        self.mNormal:SetActive(true)
        self.mShape.gameObject:SetActive(false)
    end
end

function poolRecover(self)
    self.mSelect:SetActive(false)
    self.mFormationLock:SetActive(false)
    RedPointManager:remove(self.UIObject.transform)
    super.poolRecover(self)
end

return _M