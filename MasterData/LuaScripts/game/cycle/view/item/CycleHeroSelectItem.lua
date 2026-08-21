module("cycle.CycleHeroSelectItem", Class.impl(BaseComponent))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("cycle/item/CycleHeroSelectItem.prefab")

function __initData(self)
    super.__initData(self)

    -- 一些常用的脚本
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

    -- 是否显示关注信息
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

function __updateCustomView(self)
    self:updateLvl()
    self:updateName()

    self:updateEleType()
    self:updateStarLvl()
    self:updateProfession()
    self:updateBody()
    self:updateColor()

    self:updateSelect()

    self:updateCost()
end

function updateCost(self)
    if (self.m_isLoadFinish) then
        self.mTxtCost = self:getChildGO("mTxtCost"):GetComponent(ty.Text)

        local hopeBase = cycle.CycleManager:getColorCostByColor(self:getData().color)
        local addValue = cycle.CycleManager:getEleCost(self:getData().eleType)

        self.needHope = math.max(0, hopeBase + addValue)
        self.mTxtCost.text = self.needHope

        local hopePoint = cycle.CycleManager:getResourceInfo().hope_point
        self.mTxtCost.color = hopePoint >= self.needHope and gs.ColorUtil.GetColor("000000ff") or gs.ColorUtil.GetColor("d23627ff")
    end
end

-- 设置是否显示品质
function setSelect(self, isSelect)
    self.mIsSelect = isSelect
    self:updateSelect()
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

function setEleType(self, cusType)
    self.mEleType = cusType
    self:updateEleType()
end

function updateEleType(self)
    if (self.m_isLoadFinish) then
        if (self.mImgEleType == nil) then

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
            self.mImgEleType:SetImg(UrlManager:getHeroEleTypeIconUrl(eleType), false)
        else

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
        -- local curIntegers, curDecimals = math.modf(initialStar / 2)
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
        self.mImgProfession:SetImg(UrlManager:getHeroJobSmallIconUrl(self:getData().professionType), false)
    end
end

function updateBody(self)
    if (self.m_isLoadFinish) then
        if (self.mImgBody == nil) then
            self.mImgBody = self:getChildGO("mImgBody"):GetComponent(ty.AutoRefImage)
        end

        --mImgBody
        self.mImgBody:SetImg(UrlManager:getFormationHeadUrl(self:getData():getHeroModel()), false)
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

function updateColor(self)
    if (self.m_isLoadFinish) then
        -- if (self.mImgColor == nil) then
        --     self.mImgColor = self:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage)
        -- end
        -- self.mImgColor:SetImg(UrlManager:getHeroColorIconUrl(self:getData().color), true)

        if (self.mImgColorBg == nil) then
            self.mImgColorBg = self:getChildGO("mImgColorBg"):GetComponent(ty.AutoRefImage)
        end

        self.mImgColorBg:SetImg(UrlManager:getIconPath("cycle/cycle_color_" .. self:getData().color .. ".png"), false)

        self.mImgTopColor = self:getChildGO("mImgTopColor"):GetComponent(ty.Image)
        if self:getData().color == 2 then
            self.mImgTopColor.color = gs.ColorUtil.GetColor("2e95ffff")
        elseif self:getData().color == 3 then
            self.mImgTopColor.color = gs.ColorUtil.GetColor("ff72f1ff")
        elseif self:getData().color == 4 then
            self.mImgTopColor.color = gs.ColorUtil.GetColor("ff9e35ff")
        end



        -- if self:getData().color == 2 then 
        --     self.mImgColorBg:SetImg(UrlManager:getIconPach("common_0272.png"), false)
        --     -- self.mImgColorBg.color = gs.ColorUtil.GetColor("74c0fbff")
        -- elseif self:getData().color == 3 then 
        --     self.mImgColorBg:SetImg(UrlManager:getCommon5Path("common_0273.png"), false)
        --     -- self.mImgColorBg.color = gs.ColorUtil.GetColor("de7dd9ff")
        -- else
        --     self.mImgColorBg:SetImg(UrlManager:getCommon5Path("common_0274.png"), false)
        --     -- self.mImgColorBg.color = gs.ColorUtil.GetColor("ffbc3aff")
        -- end
        -- if (self.mTxtColor == nil) then
        --     self.mTxtColor = self:getChildGO("mTxtColor"):GetComponent(ty.Text)
        -- end
        -- self.mTxtColor.text = hero.getColorName(self:getData().color)
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
                -- end
            else
                self.mTxtLvl.text = "1"
            end
        else
            self.mTxtLvl.text = self.mLvl
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
