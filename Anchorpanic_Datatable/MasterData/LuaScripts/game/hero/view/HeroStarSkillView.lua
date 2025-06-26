module('hero.HeroStarSkillView', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath('hero/tab/HeroStarSkillView.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1117, 520)
    self:setTxtTitle("特殊技能")
end

function initData(self)
end

function configUI(self)
    self.mSkillScroller = self:getChildGO("mSkillScroller"):GetComponent(ty.LyScroller)
    self.mSkillScroller:SetItemRender(hero.HeroStarUpItem)
end

function initViewText(self)

end

function addAllUIEvent(self)

end

function active(self, args)
    super.active(self, args)
    self.mCurHeroId = args.curHeroId
    self.mHeroTid = args.heroTid
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    if self.mSkillScroller then
        self.mSkillScroller:CleanAllItem() 
    end
end

function updateView(self)
    local heroVo = nil
    if self.mCurHeroId then 
        heroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    else
        heroVo = hero.HeroManager:getHeroConfigVo(self.mHeroTid)
    end
    local starDic = hero.HeroStarManager:getHeroStarDic(heroVo.tid)
    local unlockSkill = {}
    local lockSkill = {}
    for k, v in pairs(starDic) do
        if self.mHeroTid then 
            if v.passiveSkillId > 0 then
                table.insert(lockSkill, { star = 0, currentStar = v.star, skillId = v.passiveSkillId, heroTid = self.mHeroTid })
            end
        else
            if v.star > heroVo.evolutionLvl then
                if v.passiveSkillId > 0 then
                    table.insert(lockSkill, { star = heroVo.evolutionLvl, currentStar = v.star, skillId = v.passiveSkillId, heroId = self.mCurHeroId })
                end
            else
                if v.passiveSkillId > 0 then
                    table.insert(unlockSkill, { star = heroVo.evolutionLvl, currentStar = v.star, skillId = v.passiveSkillId, heroId = self.mCurHeroId })
                end
            end
        end
    end

    for i = 1, #lockSkill do
        table.insert(unlockSkill, lockSkill[i])
    end
    self.mSkillScroller.DataProvider = unlockSkill
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]