module("hero.HeroSkillItem", Class.impl(BaseComponent))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("hero/item/HeroSkillItem.prefab")

function __initData(self)
    super.__initData(self)

    --一些常用的
    self.m_imgIcon = nil
    self.m_imgSignIcon = nil

    self.m_clickEnable = true
    self:setClickEnable(self.m_clickEnable)

    --------------------------------------------- 数据源 self.m_data 为 英雄id 和 技能id ---------------------------------------------
end

-- 设置data
function setData(self, cusHeroId, cusSkillId, cusIsAsyn)
    self:__reset()
    if (cusHeroId and cusSkillId) then
        self.m_data = {}
        self.m_data.heroId = cusHeroId
        self.m_data.skillId = cusSkillId

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
    self.m_imgSignIcon = self.m_childGos["ImgSignIcon"]:GetComponent(ty.AutoRefImage)
end

function __updateContent(self)
    self.m_childGos["ImgBg"]:SetActive(false)
    self.m_childGos["TextTip"]:SetActive(false)
    self.m_childGos["TextName"]:SetActive(false)

    local heroVo = hero.HeroManager:getHeroVo(self.m_data.heroId)
    local skillVo = fight.SkillManager:getSkillRo(self.m_data.skillId)
    local skillType = skillVo:getType()
    if (skillType == fight.FightDef.SKILL_TYPE_FINAL_SKILL) then
        self.m_childGos["ImgSignIcon"]:SetActive(true)
        self.m_imgSignIcon:SetImg(UrlManager:getPackPath("icon/skill/skill_icon_final.png"), false)
    elseif (skillType == fight.FightDef.SKILL_TYPE_AOYI_SKILL) then
        self.m_childGos["ImgSignIcon"]:SetActive(true)
        self.m_imgSignIcon:SetImg(UrlManager:getPackPath("icon/skill/skill_icon_aoyi.png"), false)
    else
        self.m_childGos["ImgSignIcon"]:SetActive(false)
    end
    self.m_imgIcon:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), false)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
