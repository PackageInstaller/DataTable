module("hero.HeroPassiveSkillItem", Class.impl(BaseComponent))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("hero/item/HeroPassiveSkillItem.prefab")

function __initData(self)
    super.__initData(self)

    --一些常用的
    self.m_imgIcon = nil
    self.m_textTip = nil
    self.mTxtName = nil
    self.m_goMask = nil
    self.m_goLock = nil
    self.m_rectLock = nil

    self.m_clickEnable = true
    self:setClickEnable(self.m_clickEnable)

    --------------------------------------------- 数据源 self.m_data 为 星级和英雄id ---------------------------------------------
end

-- 设置data
function setData(self, cusStarLvl, cusHeroId, cusIsAsyn)
    self:__reset()
    if (cusStarLvl and cusHeroId) then
        self.m_data = {}
        self.m_data.heroId = cusHeroId
        self.m_data.evolutionLvl = cusStarLvl

        if (cusIsAsyn == nil) then
            cusIsAsyn = true
        end
        if (cusIsAsyn) then
            if (self.m_isLoadFinish) then
                self:__updateView()
            else
                self:__preLoad(cusIsAsyn)
            end
        else
            self:__preLoad(cusIsAsyn)
            self:__updateView()
        end
    end
end

function __updateCustomView(self)
    self:__initScript()
    self:__updateContent()
end

function __initScript(self)
    self.m_imgIcon = self.m_childGos["ImgIcon"]:GetComponent(ty.AutoRefImage)
    self.m_textTip = self.m_childGos["TextTip"]:GetComponent(ty.Text)
    self.mTxtName = self.m_childGos["TextName"]:GetComponent(ty.Text)
    self.m_goMask = self.m_childGos["ImgMask"]
    self.m_goLock = self.m_childGos["ImgLock"]
    self.m_rectLock = self.m_goLock:GetComponent(ty.RectTransform)
end

-- 点击触发默认处理
function __onDefaultClickHandler(self)
    local heroVo = hero.HeroManager:getHeroVo(self:getData().heroId)
    local skillId = hero.HeroStarManager:getHeroStarConfigVo(heroVo.tid, self:getData().evolutionLvl).passiveSkillId
    TipsFactory:skillTips(nil, skillId, heroVo)
end

function __updateContent(self)
    local heroVo = hero.HeroManager:getHeroVo(self:getData().heroId)
    local skillId = hero.HeroStarManager:getHeroStarConfigVo(heroVo.tid, self:getData().evolutionLvl).passiveSkillId
    local skillVo = fight.SkillManager:getSkillRo(skillId)

    if (heroVo.evolutionLvl >= self:getData().evolutionLvl) then
        self.m_childGos["TextTip"]:SetActive(false)
        self.m_childGos["TextName"]:SetActive(true)
        self.m_goMask:SetActive(false)
        self.m_goLock:SetActive(false)
        self.m_imgIcon.color = gs.ColorUtil.GetColor(ColorUtil.PURE_WHITE_NUM)
    else
        self.m_childGos["TextTip"]:SetActive(true)
        self.m_childGos["TextName"]:SetActive(false)
        self.m_goMask:SetActive(true)
        self.m_goLock:SetActive(true)
        self.m_imgIcon.color = gs.ColorUtil.GetColor("FFFFFF33")
    end

    self.m_imgIcon:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), true)
    self.m_textTip.text = string.substitute(_TT(1067), self:getData().evolutionLvl) --self:getData().evolutionLvl .. "星解锁"
    self.mTxtName.text = skillVo:getName()
end

function hideBottomText(self)
    if(self.m_textTip and self.mTxtName)then
        self.m_textTip.text = ""
        self.mTxtName.text = ""
    end
end

function setScale(self, scale)
    super.setScale(self, scale)
    local temp = 1 / scale
    gs.TransQuick:Scale(self.m_rectLock, temp, temp, temp)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
