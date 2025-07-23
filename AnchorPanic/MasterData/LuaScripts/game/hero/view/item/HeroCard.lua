module("hero.HeroCard", Class.impl(BaseComponent))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("hero/item/HeroCard.prefab")

function __initData(self)
    super.__initData(self)

    --一些常用的脚本
    self.mTxtLvl = nil
    self.mTxtName = nil
    self.mTxtMilitaryName = nil
    self.mTxtPower = nil
    self.mImgEleBg = nil
    self.mImgEleType = nil
    self.mImgColor = nil
    self.mTxtColor = nil
    self.mImgProfession = nil
    self.mImgBody = nil
    self.mGroupSelect = nil
    self.mImgColorBg = nil

    self.mImgResBg = nil
    self.mImgResType = nil

    --------------------------------------------- 数据源 self.m_data 为 hero.HeroConfigVo 或 hero.HeroVo ---------------------------------------------
    -- 名称
    self.mName = nil
    -- 军阶名称
    self.mMilitaryName = nil
    -- 战力
    self.mPower = nil
    -- 属性
    self.mEleType = nil
    -- 等级
    self.mLvl = nil
    -- 星级/进化等级
    self.mStarLvl = nil
    -- 是否显示状态
    self.mIsShowUseState = nil
    -- 是否显示品质
    self.mIsShowColor = nil

    -- 是否被选择
    self.mIsSelect = nil

    --是否显示关注信息
    self.mIsShowLoveInfo = nil
end

-- 通过外部传保存进来的需要重置的数据
function __reset(self)
    -- 默认不显示选择界面，为给外部显示用
    if (self.mGroupSelect and not gs.GoUtil.IsGoNull(self.mGroupSelect)) then
        self.mGroupSelect:SetActive(false)
    end

    super.__reset(self)
end

function setIsShowLoveInfo(self, isShow)
    self.mIsShowLoveInfo = isShow
    self:updateisShowLove()
end

function __updateCustomView(self)
    self:updateLvl()
    self:updateName()
    self:updateMilitaryName()
    self:updatePower()
    self:updateEleType()
    self:updateStarLvl()
    self:updateProfession()
    self:updateBody()
    self:updateColor()
    self:updateUseState()
    self:updateSelect()
    self:updateRes()

    self:setDetailVisible(true)
    self:updateisShowLove()
    self:getChildGO("mTxtLvlDec"):GetComponent(ty.Text).text = _TT(1361)
    self:getChildGO("mIsLimit"):SetActive(self:getData().isLimit == 1)
end

function setDetailVisible(self, isShow)
    if (self.m_isLoadFinish) then
        self:getChildGO("mGroupHide"):SetActive(isShow)
    end
end

function updateRes(self)
    local heroVo = self:getData()
    local isShowRes = false
    if heroVo.__cname == hero.HeroVo.__cname then
        local resonanceCount = heroVo:getActivesSkillResonanceCount()
        if resonanceCount > 0 then
            isShowRes = true

            local mImgResType = self:getChildGO("mImgResType")
            if mImgResType and not gs.GoUtil.IsGoNull(mImgResType) then
                self.mImgResType = mImgResType:GetComponent(ty.AutoRefImage)
                self.mImgResType:SetImg(string.format("arts/ui/icon/heroResonance/progress_%s.png", resonanceCount), false)
            end
        end
    end

    self.mImgResBg = self:getChildGO("mImgResBg")
    if self.mImgResBg and not gs.GoUtil.IsGoNull(self.mImgResBg) then
        self.mImgResBg:SetActive(isShowRes)
    end
end

function setLvl(self, cusStr)
    self.mLvl = cusStr
    self:updateLvl()
end

function updateisShowLove(self)
    if (self.m_isLoadFinish) then
        if self.mIsShowLoveInfo ~= nil then
            self:getChildGO("mImgLike"):SetActive(self.mIsShowLoveInfo)
            self:getChildGO("mImgLock"):SetActive(self.mIsShowLoveInfo)
        end
    end
end

function updateLvl(self)
    if (self.m_isLoadFinish) then
        if (self.mTxtLvl == nil) then
            self.mTxtLvl = self:getChildGO("mTxtLvl"):GetComponent(ty.Text)
        end
        if (self.mLvl == nil) then
            if (self:getData().lvl) then
                -- if self:getData().lvl == 1 then
                --     self.mTxtLvl.text = "01"
                -- else
                self.mTxtLvl.text = self:getData().lvl
                --end
            else
                self.mTxtLvl.text = "1"
            end
        else
            self.mTxtLvl.text = self.mLvl
        end
    end
end

function setName(self, cusStr)
    self.mName = cusStr
    self:updateName()
end

function updateName(self)
    if (self.m_isLoadFinish) then
        if (self.mTxtName == nil) then
            self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
        end
        if (self.mName == nil) then
            self.mTxtName.text = self:getData().name
        else
            self.mTxtName.text = self.mName
        end
    end
end

function setMilitaryName(self, cusStr)
    self.mMilitaryName = cusStr
    self:updateMilitaryName()
end

function updateMilitaryName(self)
    if (self.m_isLoadFinish) then
        if (self.mTxtMilitaryName == nil) then
            self.mTxtMilitaryName = self:getChildGO("mTxtMilitaryName"):GetComponent(ty.Text)
        end
        if (self.mMilitaryName == nil) then
            if (self:getData().militaryRank ~= nil) then
                local militaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(self:getData().tid, self:getData().militaryRank)
                self.mTxtMilitaryName.text = militaryRankVo:getName()
            else
                self.mTxtMilitaryName.text = ""
            end
        else
            self.mTxtMilitaryName.text = self.mMilitaryName
        end
    end
end

function setPower(self, cusNum)
    self.mPower = cusNum
    self:updatePower()
end

function updatePower(self)
    if (self.m_isLoadFinish) then
        if (self.mTxtPower == nil) then
            self.mTxtPower = self:getChildGO("mTxtPower"):GetComponent(ty.Text)
        end
        if (self.mPower == nil) then
            if (self:getData().power ~= nil) then
                self:getChildGO("mGroupBttom"):SetActive(true)
                self.mTxtPower.text = self:getData().power
            else
                self:getChildGO("mGroupBttom"):SetActive(false)
                self.mTxtPower.text = ""
            end
        else
            self.mTxtPower.text = self.mPower
        end
    end
end

function setEleType(self, cusType)
    self.mEleType = cusType
    self:updateEleType()
end

function updateEleType(self)
    if (self.m_isLoadFinish) then
        if (self.mImgEleType == nil) then
            self.mImgEleBg = self:getChildGO("mImgEleBg")
            self.mImgEleType = self:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)
        end
        local eleType = nil
        if (self.mEleType == nil) then
            if (self:getData().eleType ~= nil and self:getData().eleType >= 0) then
                eleType = self:getData().eleType
            end
        else
            if (self.mEleType >= 0) then
                eleType = self.mEleType
            end
        end

        if (eleType ~= nil) then
            self.mImgEleBg:SetActive(true)
            self.mImgEleType:SetImg(UrlManager:getHeroEleTypeIconUrl(eleType), true)
        else
            self.mImgEleBg:SetActive(false)
        end
    end
end

function setStarLvl(self, cusStarLvl)
    self.mStarLvl = cusStarLvl
    self:updateStarLvl()
end

function updateStarLvl(self)
    if (self.m_isLoadFinish) then
        if (self.mStarLvl == nil) then
            if (hero.HeroStarManager:getHeroStarConfigVo(self:getData().tid, self:getData().evolutionLvl)) then
                self.mStarLvl = self:getData().evolutionLvl
            end
        end
        local initialStar = 0
        if (self.mStarLvl == nil or self.mStarLvl <= 0) then
            initialStar = hero.HeroManager:getHeroConfigVo(self:getData().tid):getStar()
        else
            initialStar = self.mStarLvl
        end
        for i = 1, 6 do
            self:getChildGO("mImgStar_" .. i):SetActive(i <= initialStar)
        end

    end
end

function updateProfession(self)
    if (self.m_isLoadFinish) then
        if (self.mImgProfession == nil) then
            self.mImgProfession = self:getChildGO("mImgProfession"):GetComponent(ty.AutoRefImage)
        end
        self.mImgProfession:SetImg(UrlManager:getHeroJobSmallIconUrl(self:getData().professionType), true)
    end
end

function updateBody(self)
    if (self.m_isLoadFinish) then
        if (self.mImgBody == nil) then
            self.mImgBody = self:getChildGO("mImgBody"):GetComponent(ty.AutoRefImage)
        end

        self.mImgBody:SetImg(UrlManager:getHeroSmallBodyImgUrl(self:getData():getHeroModel()), true)
    end
end

function updateColor(self)
    if (self.m_isLoadFinish) then
        if (self.mImgColorBg == nil) then
            self.mImgColorBg = self:getChildGO("mImgColorBg"):GetComponent(ty.AutoRefImage)
        end

        self:getChildGO("mFx_03_03"):SetActive(false)
        self:getChildGO("mFx_03_02"):SetActive(false)
        self:getChildGO("mFx_03_01"):SetActive(false)

        self:getChildGO("mFx_02_02"):SetActive(false)
        self:getChildGO("mFx_02_01"):SetActive(false)

        self:getChildGO("mFx_01_01"):SetActive(false)

        local color = "ffae00ff"
        local color2 = color
        if self:getData().color == 2 then
            color = "00aeffff"
            color2 = "127cffff"

            self:getChildGO("mFx_01_01"):SetActive(true)
        elseif self:getData().color == 3 then
            color = "ff83e6ff"
            color2 = color

            self:getChildGO("mFx_02_02"):SetActive(true)
            self:getChildGO("mFx_02_01"):SetActive(true)
        elseif self:getData().color == 4 then
            color = "ffae00ff"
            color2 = color

            self:getChildGO("mFx_03_03"):SetActive(true)
            self:getChildGO("mFx_03_02"):SetActive(true)
            self:getChildGO("mFx_03_01"):SetActive(true)
        end
        -- for i = 1, 6 do
        --     self:getChildGO("mImgStar_" .. i):GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor(color)
        -- end
        self:getChildGO("mImgBgColor"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor(color2)
        self.mImgColorBg.color = gs.ColorUtil.GetColor(color)
        if (self.mTxtColor == nil) then
            self.mTxtColor = self:getChildGO("mTxtColor"):GetComponent(ty.Text)
        end
        self.mTxtColor.text = hero.getColorName(self:getData().color)

    end
end

function updateSelect(self)
    if (self.m_isLoadFinish) then
        if (self.mGroupSelect == nil) then
            self.mGroupSelect = self:getChildGO("mGroupSelect")
        end
        self.mGroupSelect:SetActive(self.mIsSelect)
    end
end

function updateUseState(self)
    if (self.m_isLoadFinish) then
        local imgLockGo = self:getChildGO("mImgLock")
        imgLockGo:SetActive(false)
        if (self:getData().isLock == 1) then
            imgLockGo:SetActive(true)
        end

        local imgLikeGo = self:getChildGO("mImgLike")
        imgLikeGo:SetActive(false)
        if (self:getData().isLike == 1) then
            imgLikeGo:SetActive(true)
        end

        local textState = self:getChildGO("mTxtState"):GetComponent(ty.Text)
        local isCanUse = hero.HeroUseCodeManager:getIsCanUse(self:getData().id)
        if ((self.mIsShowUseState) and not isCanUse) then
            local tip, color = hero.HeroUseCodeManager:getTipByHeroUseCode(self:getData().id)
            textState.text = tip
            textState.color = color
            self:getChildGO("mImgStateBg"):SetActive(true)
        else
            textState.text = ""
            self:getChildGO("mImgStateBg"):SetActive(false)
        end
    end
end

-- 设置是否显示使用状态
function setShowUseState(self, isShowUseState)
    self.mIsShowUseState = isShowUseState
    self:updateUseState()
end

-- 设置是否显示品质
function setShowColor(self, isShowColor)
    self.mIsShowColor = isShowColor
    self:updateColor()
end

-- 设置是否显示品质
function setSelect(self, isSelect)
    self.mIsSelect = isSelect
    self:updateSelect()
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]
