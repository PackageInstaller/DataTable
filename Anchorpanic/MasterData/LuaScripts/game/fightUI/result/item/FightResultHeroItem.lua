--[[ 
-----------------------------------------------------
@filename       : FightResultHeroItem
@Description    : 战斗结算英雄展示item
@date           : 2021-01-21 15:37:17
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('fightUI.FightResultHeroItem', Class.impl(BaseComponent))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("figthtResult/FightResultHeroItem.prefab")

function __initData(self)
    super.__initData(self)

    self.mTxtAddExp = nil
    self.mProgressBar = nil
    self.mProgressBg = nil
    self.mImgLvlUp = nil
    self.mImgFromSign = nil

    self.mHeroVo = nil
    self.mHeroHead = nil
    self.mImgHead = nil
    self.mImgColor = nil
    self.mImgHeadBg = nil
    self.mTxtFavorable = nil
    self.mGroup = nil
    -- 进化等级/星级
    self.m_starLvl = nil

    self.mActive = false
end

function __reset(self)
    super.__reset(self)

    if (self.mHeroHead) then
        self.mHeroHead:poolRecover()
        self.mHeroHead = nil
    end

    if self.mHeroVo then
        self.mHeroVo:removeEventListener(hero.HeroVo.UPDATE_DETAIL, self.__updateBasicView, self)
    end

    LoopManager:clearTimeout(self.setTimeId)

    if self.mProgressBar then
        self.mProgressBar:DOKill()
    end
end
function __updateCustomView(self)
    self:__updateBasicView()

    if (self:getData()._NAME == hero.HeroConfigVo._NAME) then
    elseif (self:getData()._NAME == hero.HeroVo._NAME) then
        self:__updateOtherView()
    end
end

-- 更新基础的信息显示
function __updateBasicView(self)
    local data = self:getData()
    local preHeroData = data.preHeroData

    -- preHeroData.heroData 回放使用的战员数据
    if not preHeroData.heroData then
        -- 正常流程
        if not preHeroData.heroId then return end
        self.mHeroVo = hero.HeroManager:getHeroVo(preHeroData.heroId)
        if not self.mHeroVo then return end

        if (self.m_isLoadFinish) then
            self:__updateExp()
            self:__updateExpProBar()
        end
    else
        -- 回看数据
    end
    -- if (self.m_isLoadFinish) then
    self:__updateHead()
    self:__showExp(not preHeroData.heroData)
    self:__updateActive()
    self:__updateFavorable()
    -- end
end

function __showExp(self, bol)
    self:getChildGO("mProgressBg"):SetActive(bol)
    self:getChildGO("mProgressBgMask"):SetActive(bol)
    self:getChildGO("mTxtAddExp"):SetActive(bol)
    if not bol then
        self:getChildGO("mImgLvlUp"):SetActive(false)
    end
end

function __updateHead(self)
    self.mHeroHead = HeroHeadGrid:poolGet()

    local data = self:getData().preHeroData
    if not data.heroData then
        self.mHeroHead:setData(self.mHeroVo)
        self.mHeroHead:setLvl(data.lvl)
        self.mHeroHead:setStarLvl(data.evolutionLvl)
    else
        self.mHeroHead:setData(data.heroData)
        self.mHeroHead:setLvl(data.heroData.lvl)
        self.mHeroHead:setStarLvl(data.heroData.evolutionLvl)
    end

    self.mHeroHead:setIsShowUseState(false)
    self.mHeroHead:setParent(self.m_childTrans["mGroupHead"])
end

function __updateExp(self)
    if not self.mTxtAddExp then
        self.mTxtAddExp = self.m_childGos["mTxtAddExp"]:GetComponent(ty.Text)
    end

    if self.mHeroVo.lvl >= self.mHeroVo:getMaxMilitaryLvl() then
        self.mTxtAddExp.text = ""
    else
        self.mTxtAddExp.text = "EXP+" .. self:getData().exp
    end
end

-- 更新好感值
function __updateFavorable(self)
    if (self.m_isLoadFinish) then
        if not self.mTxtFavorable then
            self.mTxtFavorable = self.m_childGos["mTxtFavorable"]:GetComponent(ty.Text)
        end

        local preHeroData = self:getData().preHeroData
        local maxLv = sysParam.SysParamManager:getValue(SysParamType.MAX_FAVORABLE_LV)
        if self:getData().favorableValue > 0 and preHeroData.favorableLevel and preHeroData.favorableLevel < maxLv then
            self.m_childGos["mImgFavorableBg"]:SetActive(true)
            self.mTxtFavorable.text = "+" .. self:getData().favorableValue
        else
            self.m_childGos["mImgFavorableBg"]:SetActive(false)
            self.mTxtFavorable.text = ""
        end

    end
end

function __updateExpProBar(self)
    if not self.mProgressBar then
        self.mProgressBar = self:getChildTrans("mProgressBar")
        self.mProgressBg = self:getChildTrans("mProgressBg")
    end
    if not self.mImgLvlUp then
        self.mImgLvlUp = self:getChildGO("mImgLvlUp")
    end
    self.mImgLvlUp:SetActive(false)

    self.mProMaxWidth = self.mProgressBg.sizeDelta.x
    --战员结算前数据
    local preHeroData = self:getData().preHeroData
    local maxExp = hero.HeroLvlUpManager:getHeroMaxExp(self.mHeroVo.tid, preHeroData.lvl)
    local nowExp = math.min(preHeroData.exp, maxExp)
    local temS = nowExp / maxExp
    -- if nowExp == 0 and maxExp == 0 then temS = 1 end
    -- if nowExp == 0 and maxExp > 0 then temS = 0 end
    if nowExp == 0 then
        temS = 0
    end
    gs.TransQuick:SizeDelta01(self.mProgressBar, self.mProMaxWidth * temS)

    -- 开始结算
    self.setTimeId = LoopManager:setTimeout(1, self, function()
        if not self.mProgressBar and gs.GoUtil.IsTransNull(self.mProgressBar) then
            return
        end
        local maxExp = hero.HeroLvlUpManager:getHeroMaxExp(self.mHeroVo.tid, self.mHeroVo.lvl)
        maxExp = maxExp > 0 and maxExp or preHeroData.exp
        if self.mHeroVo.lvl > preHeroData.lvl then
            -- 升级
            local mBarTween = self.mProgressBar:DOWidth(self.mProMaxWidth, 0.3)
            mBarTween:OnComplete(function()
                gs.TransQuick:SizeDelta01(self.mProgressBar, 0)
                self.mImgLvlUp:SetActive(true)
                TweenFactory:scaleTo(self.mImgLvlUp.transform, gs.VEC3_ONE * 3, gs.VEC3_ONE, 0.2)
                self.mHeroHead:setLvl(self.mHeroVo.lvl)
                -- self.mTxtLv.text = "" .. self.mHeroVo.lvl
                temS = self.mHeroVo.exp / self.mHeroVo.maxExp
                if self.mHeroVo.exp == 0 and self.mHeroVo.maxExp == 0 then temS = 1 end
                if self.mHeroVo.exp == 0 and self.mHeroVo.maxExp > 0 then temS = 0 end
                mBarTween = self.mProgressBar:DOWidth(self.mProMaxWidth * temS, 0.3)
            end)
        else
            -- 没升级
            local curExp = math.min(self.mHeroVo.exp, self.mHeroVo.maxExp) --当前经验可以存储，所以会超过最大经验
            temS = curExp / self.mHeroVo.maxExp
            -- if curExp == 0 and self.mHeroVo.maxExp == 0 then temS = 1 end
            -- if curExp == 0 and self.mHeroVo.maxExp > 0 then temS = 0 end
            if curExp == 0 then
                temS = 0
            end
            self.mProgressBar:DOWidth(self.mProMaxWidth * temS, 0.3)
        end
    end)
end

function __updateActive(self)
    if (self.m_isLoadFinish) then
        if not self.mGroup then
            self.mGroup = self:getChildGO("mGroup")
        end

        if self.mGroup then
            self.mGroup:SetActive(self.mActive)
        end
    end
end

-- 设置激活
function setActive(self, active)
    self.mActive = active
    self:__updateActive()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]