--[[   
     战斗UI boss血条
]]
module('fightUI.FightBossHeadAreaView', Class.impl('lib.component.BaseNode'))

function ctor(self)
    super.ctor(self)

    self.mLiveVo = nil
    self.m_buffIcons = {}
    self.m_otherIcons = {}

    self.mWeaknessDic = {}
    self.mHpSectionHash = {}
    self.mBerserkInfoList = {}
end

function initData(self, rootGo)
    super.initData(self, rootGo)

    self.mTxtBossName = self:getChildGO("mTxtBossName"):GetComponent(ty.Text)
    self.mImgBossHeadIcon = self:getChildGO("mImgBossHeadIcon"):GetComponent(ty.AutoRefImage)

    self.mImgBossHpBar = self:getChildGO("mImgBossHpBar"):GetComponent(ty.Image)
    self.mImgBossHpInsBar = self:getChildGO("mImgBossHpInsBar"):GetComponent(ty.Image)

    self.mImgBossStunBar = self:getChildGO("mImgBossStunBar"):GetComponent(ty.Image)
    self.mImgBossStunBar2 = self:getChildGO("mImgBossStunBar2"):GetComponent(ty.Image)

    self.mImgBossShieldBg = self:getChildGO("mImgBossShieldBg")
    self.mImgBossShieldBar = self:getChildGO("mImgBossShieldBar"):GetComponent(ty.Image)

    self.mImgBossStateBg = self:getChildGO("mImgBossStateBg")
    self.mImgBossShieldBar = self:getChildGO("mImgBossShieldBar"):GetComponent(ty.Image)
    self.mGroupBossStateSection = self:getChildTrans("mGroupBossStateSection")

    self.mGroupBossBuff = self:getChildTrans("mGroupBossBuff")
    self.mGroupBossWeak = self:getChildTrans("mGroupBossWeak")

    self.mGroupBossHpSection = self:getChildTrans("mGroupBossHpSection")
end

-- 设置boss id
function setBossLiveId(self, liveId)
    self.mLiveId = liveId

    self.mLiveVo = fight.SceneManager:getThing(self.mLiveId)
    if not self.mLiveVo then
        return
    end
    self.mLiveVo:addEventListener(fight.LivethingVo.EVENT_HEAD_AREA_UPDATE, self.onHeadAreaUpdate, self)

    self.mTxtBossName.text = self.mLiveVo:getOrgData().name

    self:updateBossInfo()
    self:updateBar()
    self:updateBossHeadIcon()
    self:updateWeak()
    self:createHpSection()
end

function onHeadAreaUpdate(self)
    self:updateBar()
end

-- 更新boss特殊机制
function updateBossInfo(self)
    if self.mLiveVo:getAtt(AttConst.SHIELD_MAX) <= 0 then
        self.mImgBossShieldBg:SetActiveLocal(false)
    else
        self.mImgBossShieldBg:SetActiveLocal(true)
    end
    if self.mLiveVo:getAtt(AttConst.BERSERK_NUM) <= 0 then
        self.mImgBossStateBg:SetActiveLocal(false)
    else
        self.mImgBossStateBg:SetActiveLocal(true)
    end

    self:updateBerserkInfo()
end


-- 更新血条
function updateBar(self)
    if not self.mLiveVo then
        return
    end

    if self.mFadeHpTween then
        self.mFadeHpTween:Kill()
        self.mFadeHpTween = nil
    end
    if not self.mHpRate then
        self.mHpRate = self.mLiveVo:getAtt(AttConst.HP) * 1 / self.mLiveVo:getAtt(AttConst.HP_MAX)
    end
    self.mFadeHpTween = gs.DoTweenUtil.DoTweenFadeFloat(self.mHpRate, self.mLiveVo:getAtt(AttConst.HP) * 1 / self.mLiveVo:getAtt(AttConst.HP_MAX), 1, function(val)
        self.mImgBossHpInsBar.fillAmount = val
        self.mHpRate = val
        
    end, function()
        -- self.mHpRate = self.mLiveVo:getAtt(AttConst.HP) * 1 / self.mLiveVo:getAtt(AttConst.HP_MAX)
        -- 
        --
            
        -- else
            
        -- end
        if self.mLiveVo:getAtt(AttConst.HP) <= 0 then
            local bType = fight.FightManager:getBattleType()
            if bType == PreFightBattleType.Disaster or bType == PreFightBattleType.Disater_imitate then
                self.mImgBossHpInsBar.fillAmount = 0
                self.mHpRate = 0
            else
                self:setVisibleByScale(false)
            end
        end
    end)

    self.mImgBossHpBar.fillAmount = self.mLiveVo:getAtt(AttConst.HP) * 1 / self.mLiveVo:getAtt(AttConst.HP_MAX)

    self.mImgBossShieldBar.fillAmount = self.mLiveVo:getAtt(AttConst.SHIELD) * 1 / self.mLiveVo:getAtt(AttConst.SHIELD_MAX)

    if self.mLiveVo:getAtt(AttConst.STUN_RESUME) > 0 then
        self.mImgBossStunBar.gameObject:SetActiveLocal(false)
        self.mImgBossStunBar2.gameObject:SetActiveLocal(true)
        self.mImgBossStunBar2.fillAmount = self.mLiveVo:getAtt(AttConst.STUN_RESUME) * 1 / self.mLiveVo:getAtt(AttConst.STUN_MAX)
    else
        self.mImgBossStunBar.gameObject:SetActiveLocal(true)
        self.mImgBossStunBar2.gameObject:SetActiveLocal(false)
        self.mImgBossStunBar.fillAmount = self.mLiveVo:getAtt(AttConst.STUN) * 1 / self.mLiveVo:getAtt(AttConst.STUN_MAX)
    end

    self:updateBossInfo()
    self:updateBuffIcon()
    self:updateHpSection(self.mLiveVo:getAtt(AttConst.HP), self.mLiveVo:getAtt(AttConst.HP_MAX))
end

-- 更新狂暴累积格子
function updateBerserkInfo(self)
    self:recoverBerserkInfoList()
    local num = self.mLiveVo:getAtt(AttConst.BERSERK_NUM)
    for i = 1, num do
        local item = SimpleInsItem:create(self:getChildGO("GroupBossStateSectionItem"), self.mGroupBossStateSection, "FIghtBossHeadAreaViewBossStateSectionItem")
        table.insert(self.mBerserkInfoList, item)
    end
end

-- 回收狂暴累积图标
function recoverBerserkInfoList(self)
    for i, v in ipairs(self.mBerserkInfoList) do
        v:poolRecover()
    end
    self.mBerserkInfoList = {}
end


-- 更新boss头像
function updateBossHeadIcon(self)
    if self.mLiveVo:getRaceType() == 0 then
        self.mImgBossHeadIcon:SetImg(UrlManager:getHeroHeadShadow(self.mLiveVo:getModelID()), true)
    else
        local orgData = self.mLiveVo:getOrgData()
        if orgData then
            if orgData.shadow_head then
                self.mImgBossHeadIcon:SetImg(UrlManager:getMonBossShadow(self.mLiveVo:getBaseModelId()), true)
            end
        end
    end
end

-- 更新弱点格子
function updateWeak(self)
    self:recoverWeakList()
    if self.mLiveVo:getRaceType() == 1 then
        local monsterVo = self.mLiveVo:getOrgData()
        for i = 1, #monsterVo.weak_point do
            local item = SimpleInsItem:create(self:getChildGO("GroupBossWeakItem"), self.mGroupBossWeak, "FIghtBossHeadAreaViewWeakItem")
            item:getChildGO("mImgWeak"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getHeroEleTypeIconUrl2(monsterVo.weak_point[i]), false)
            item:getChildGO("mImgWeak_01"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getHeroEleTypeIconUrl2(monsterVo.weak_point[i]), false)
            self.mWeaknessDic[monsterVo.weak_point[i]] = item
        end
    end
end

-- 回收弱点图标
function recoverWeakList(self)
    for i, v in pairs(self.mWeaknessDic) do
        v:poolRecover()
    end
    self.mWeaknessDic = {}
end

-- 弱点打击提示效果
function showWeakBreak(self, type, liveId)
    if not self.mLiveVo or self.mLiveVo.id ~= liveId then
        return
    end

    local item = self.mWeaknessDic[type]
    if item then
        -- item:getTrans():SetSiblingIndex(1)
        local anim = item:getGo():GetComponent(ty.Animator)
        if anim then
            anim:SetTrigger("show")
        end
        -- TweenFactory:scaleTo01(item:getChildTrans("mImgWeak"), 1, 3, 0.15, nil, function()
        --     TweenFactory:scaleTo01(item:getChildTrans("mImgWeak"), 3, 1, 0.15)
        -- end)
    end
end

-- 更新buff图标
function updateBuffIcon(self)
    local tmpIcons = self.m_buffIcons
    self.m_buffIcons = {}
    local tmpOtherIcons = self.m_otherIcons
    self.m_otherIcons = {}
    local buffQueue = BuffHandler:getAllBuff(self.mLiveVo:getLiveID())
    if buffQueue then
        for i, v in ipairs(buffQueue) do
            local buffRo = Buff.BuffRoMgr:getBuffRo(v:getRefID())
            if buffRo then
                local buffIcon = buffRo:getIcon()
                -- 没有图标不显示
                if buffIcon and buffRo:getBuff_show() then
                    local tIcon = tmpIcons[1]
                    if not tIcon then
                        tIcon = fightUI.FightBuffIcon.new()
                        tIcon:setup(UrlManager:getUIPrefabPath("fight/liveui/FightBuffIcon.prefab"))
                        tIcon:addOnParent(self.mGroupBossBuff)
                    else
                        table.remove(tmpIcons, 1)
                    end
                    tIcon:setIcon(UrlManager:getBuffIconUrl(buffIcon))

                    local bdata = self.mLiveVo:getBuffData(v:getRefID())
                    tIcon:setTxtData(bdata[1], bdata[2])
                    table.insert(self.m_buffIcons, tIcon)
                end
            end
        end
    end
    for _, v in ipairs(tmpIcons) do
        v:destroy()
    end
    for _, go in ipairs(tmpOtherIcons) do
        gs.GameObject.Destroy(go)
    end
end

-- 更新血条阶段
function createHpSection(self)
    self:recoverHpSectionList()
    if self.mLiveVo:getRaceType() == 1 then
        local monsterVo = self.mLiveVo:getRaceVo()
        for i = 1, #monsterVo.hpSection do
            local rate = monsterVo.hpSection[i]
            local item = SimpleInsItem:create(self:getChildGO("GroupBossHpSectionItem"), self.mGroupBossHpSection, "FightBossHeadAreaViewBossHpSectionItem")
            gs.TransQuick:LPosX(item:getTrans(), self.mGroupBossHpSection.rect.width * (rate / 100))
            self.mHpSectionHash[rate] = item
        end
    end
end

-- 回收血条阶段
function recoverHpSectionList(self)
    for k, v in pairs(self.mHpSectionHash) do
        v:poolRecover()
    end
    self.mHpSectionHash = {}
end

-- 更新血条阶段
function updateHpSection(self, hp, hpMax)
    if self.mLiveVo:getRaceType() == 1 then
        local monsterVo = self.mLiveVo:getRaceVo()
        for i = 1, #monsterVo.hpSection do
            local rate = monsterVo.hpSection[i]
            if (1 - (hp / hpMax)) >= (rate / 100) then
                local item = self.mHpSectionHash[rate]
                if item then
                    item:poolRecover()
                    self.mHpSectionHash[rate] = nil
                end
            else
                -- 需要分段但是没有，就重新创建（可能是换boss血量恢复）
                local item = self.mHpSectionHash[rate]
                if not item then
                    self:createHpSection()
                end
            end
        end
    end
end



function removeSelf(self)
    super.removeSelf(self)
    if self.mLiveVo then
        self.mLiveVo:removeEventListener(fight.LivethingVo.EVENT_HEAD_AREA_UPDATE, self.onHeadAreaUpdate, self)
        self.mLiveVo = nil
    end

    self:recoverWeakList()
    self:recoverHpSectionList()
    self:recoverBerserkInfoList()
end

function destroy(self, isAuto)
    super.destroy(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]