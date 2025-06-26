module("hero.HeroColorUpSkillItem", Class.impl(hero.HeroPassiveSkillItem))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("hero/item/HeroColorUpSkillItem.prefab")

-- -- 设置data
-- function setData(self, cusColor, cusHeroId, cusIsAsyn)
--     self:__reset()
--     if (cusColor and cusHeroId) then
--         self.m_data = {}
--         self.m_data.heroId = cusHeroId
--         self.m_data.color = cusColor

--         if (cusIsAsyn == nil) then
--             cusIsAsyn = true
--         end
--         if (cusIsAsyn) then
--             if (self.m_isLoadFinish) then
--                 self:__updateView()
--             else
--                 self:__preLoad(cusIsAsyn)
--             end
--         else
--             self:__preLoad(cusIsAsyn)
--             self:__updateView()
--         end
--     end
-- end

-- 设置data
function setData(self, skillId, cusHeroId, cusIsAsyn)
    self:__reset()
    if (skillId and cusHeroId) then
        self.m_data = {}
        self.m_data.heroId = cusHeroId
        self.m_data.skillId = skillId

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

-- 点击触发默认处理
function __onDefaultClickHandler(self)
    -- local heroVo = hero.HeroManager:getHeroVo(self:getData().heroId)
    -- local skillId = hero.HeroColorUpManager:getHeroColorUpConfigVo(heroVo.tid, self:getData().color).skillId
    -- TipsFactory:skillTips(nil, skillId, heroVo)

    local heroVo = hero.HeroManager:getHeroVo(self:getData().heroId)
    TipsFactory:skillTips(nil, self:getData().skillId, heroVo)
end

function __updateContent(self)
    -- local heroVo = hero.HeroManager:getHeroVo(self:getData().heroId)
    -- local skillId = hero.HeroColorUpManager:getHeroColorUpConfigVo(heroVo.tid, self:getData().color).skillId
    -- local skillVo = fight.SkillManager:getSkillRo(skillId)

    -- if (heroVo.color >= self:getData().color) then
    --     self.m_childGos["TextTip"]:SetActive(false)
    --     self.m_childGos["TextName"]:SetActive(true)
    --     self.m_goMask:SetActive(false)
    --     self.m_goLock:SetActive(false)
    --     self.m_imgIcon.color = gs.ColorUtil.GetColor(ColorUtil.PURE_WHITE_NUM)
    -- else
    --     self.m_childGos["TextTip"]:SetActive(true)
    --     self.m_childGos["TextName"]:SetActive(false)
    --     self.m_goMask:SetActive(true)
    --     self.m_goLock:SetActive(true)
    --     self.m_imgIcon.color = gs.ColorUtil.GetColor("FFFFFF33")
    -- end

    -- self.m_imgIcon:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), true)
    -- self.m_textTip.text = string.substitute(_TT(1067), hero.getColorName(self:getData().color)) --self:getData().color .. "解锁"
    -- self.mTxtName.text = skillVo:getName()
    
    local heroVo = hero.HeroManager:getHeroVo(self:getData().heroId)
    local skillId = self:getData().skillId
    local skillVo = fight.SkillManager:getSkillRo(skillId)
    
    self.m_childGos["TextTip"]:SetActive(false)
    self.m_childGos["TextName"]:SetActive(true)
    self.m_goMask:SetActive(false)
    self.m_goLock:SetActive(false)
    self.m_imgIcon.color = gs.ColorUtil.GetColor(ColorUtil.PURE_WHITE_NUM)

    self.m_imgIcon:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), true)
    self.m_textTip.text = string.substitute(_TT(1067), hero.getColorName(self:getData().color)) --self:getData().color .. "解锁"
    self.mTxtName.text = skillVo:getName()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
