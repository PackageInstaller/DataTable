module('fightUI.FightSoulView', Class.impl('lib.component.BaseNode'))

function ctor(self)
    super.ctor(self)
    self.m_buffIcons = {}
    self.mWeaknessList = {}
end

function initData(self, rootGo)
    super.initData(self, rootGo)
    self.m_liveID = nil
    self.m_barBgGo = self:getChildGO('BarBg')
    self.m_soulBar = self:getChildGO('SoulBar'):GetComponent(ty.Image)
    self.m_soulTxt = self:getChildGO('SoulTxt'):GetComponent(ty.Text)
    self.m_iconBg = self:getChildGO('iconBg'):GetComponent(ty.AutoRefImage)
    self.m_nameTxt = self:getChildGO('NameTxt'):GetComponent(ty.Text)

    self.m_bigRoleImg = self:getChildGO('BigRoleIconImg'):GetComponent(ty.AutoRefImage)
    self.animator = self.m_go:GetComponent(ty.Animator)
    self.animatCall = self.m_go:GetComponent(ty.AnimatCall)
    self.animatCall:AddFrameEventCall("showNewHero", function()
        self:showHeroLive()
    end)

    self.heroEfx = self:getChildGO("hero")
    self.monsterEfx = self:getChildGO("monster")


    self.mGroupRole = self:getChildGO("mGroupRole")
    self.mGroupMon = self:getChildGO("mGroupMon")

    self.mImgLocal = self:getChildGO("mImgLocal"):GetComponent(ty.AutoRefImage)

    self.mRoleHpBarGO = self:getChildGO("mRoleHpBar")
    self.mRoleHpInsBarGO = self:getChildGO("mRoleHpInsBar")
    self.mRoleHpBar = self.mRoleHpBarGO:GetComponent(ty.ProgressBarHp)

    self.mRoleShieldBarGO = self:getChildGO("mRoleShieldBar")
    self.mRoleShieldBarBgGO = self:getChildGO("mRoleShieldBarBg")
    self.mRoleShieldBar = self.mRoleShieldBarGO:GetComponent(ty.Image)


    self.mMonHpBarGO = self:getChildGO("mMonHpBar")
    self.mMonHpInsBarGO = self:getChildGO("mMonHpInsBar")
    self.mMonHpBar = self.mMonHpBarGO:GetComponent(ty.ProgressBarHp)

    self.mMonShieldBarGO = self:getChildGO("mMonShieldBar")
    self.mMonShieldBarBgGO = self:getChildGO("mMonShieldBarBg")
    self.mMonShieldBar = self.mMonShieldBarGO:GetComponent(ty.Image)

    self.mMonStunBarBg = self:getChildGO("mMonStunBarBg")
    self.mMonStunBarGO = self:getChildGO("mMonStunBar")
    self.mMonStunBar = self.mMonStunBarGO:GetComponent(ty.Image)

    self.mMonStunBar2GO = self:getChildGO("mMonStunBar2")
    self.mMonStunBar2 = self.mMonStunBar2GO:GetComponent(ty.Image)


    self.mGroupBuff = self:getChildTrans("mGroupBuff")

    self.mGroupWeak = self:getChildTrans("mGroupWeak")
end

function setHeroLiveID(self, liveID)
    self.animator:SetTrigger("show")
    self.m_liveID = liveID

    self.m_liveVo = fight.SceneManager:getThing(self.m_liveID)
    if not self.m_liveVo then
        return
    end

    self.m_nameTxt.text = self.m_liveVo:getOrgData().name

    if self.m_liveVo:isAttacker() == 1 then
        self.mGroupRole:SetActiveLocal(true)
        self.mGroupMon:SetActiveLocal(false)
    else
        self.mGroupRole:SetActiveLocal(false)
        self.mGroupMon:SetActiveLocal(true)
    end
    -- self:updateBar()
    -- self:updateWeak()
end

function showHeroLive(self)
    local showId = self.m_liveID
    local roleIDList = fight.FightManager:getCurRoleList()
    if roleIDList[1] ~= showId then
        -- 当前出手和时间轴不一致，以时间轴为准，鹿灵需求
        showId = roleIDList[1]
        self.m_liveVo = fight.SceneManager:getThing(showId)
    end

    if not self.m_liveVo then
        self.m_liveVo = fight.SceneManager:getThing(self.m_liveID)
    end
    if self.m_liveVo then
        if self.m_liveVo:getRaceType() == 0 then
            self.heroEfx:SetActive(true)
            self.monsterEfx:SetActive(false)
        else
            self.heroEfx:SetActive(false)
            self.monsterEfx:SetActive(true)
        end

        if self.m_liveVo:isAttacker() == 1 then
            self.m_iconBg:SetImg(UrlManager:getFightUIPath("fight_icon_7.png"), true)
        else
            self.m_iconBg:SetImg(UrlManager:getFightUIPath("fight_icon_8.png"), true)
        end

        if self.m_liveVo:getRaceType() == 0 then
            self.m_bigRoleImg:SetImg(UrlManager:getHeroHeadShadow(self.m_liveVo:getModelID()), true)
        else
            local orgData = self.m_liveVo:getOrgData()
            if orgData then
                if orgData.shadow_head then
                    self.m_bigRoleImg:SetImg(UrlManager:getIconPath(orgData.shadow_head), true)
                end
            end
        end

    end
end

function updateSoul(self)
    if not self.m_liveVo then
        self.m_liveVo = fight.SceneManager:getThing(self.m_liveID)
    end
    if self.m_liveVo then
        -- if self.m_liveVo:isAttacker()~=1 then
        -- 	self.m_barBgGo:SetActiveLocal(false)
        -- 	self.m_soulTxt.gameObject:SetActiveLocal(false)
        -- else
        local curSoul = self.m_liveVo:getAtt(AttConst.SKILL_SOUL) or 0
        self.m_soulBar.fillAmount = curSoul / fight.FightDef.MAX_POWER
        -- self.m_soulTxt.text = tostring(curSoul)--  string.format("%02d",curSoul)
        self.m_soulTxt.text = string.format("%s/" .. fight.FightDef.MAX_POWER, curSoul)
        -- self.m_barBgGo:SetActiveLocal(true)
        -- self.m_soulTxt.gameObject:SetActiveLocal(true)
        -- end
        return self.m_liveVo
    end
end

function updateBar(self)
    if not self.m_liveVo then
        return
    end
    self.mRoleHpBar:SetValue(self.m_liveVo:getAtt(AttConst.HP), self.m_liveVo:getAtt(AttConst.HP_MAX), true, 0.7)
    self.mMonHpBar:SetValue(self.m_liveVo:getAtt(AttConst.HP), self.m_liveVo:getAtt(AttConst.HP_MAX), true, 0.7)

    if self.m_liveVo:getAtt(AttConst.STUN_MAX) <= 0 then
        self.mMonStunBarGO:SetActiveLocal(false)
        self.mMonStunBar2GO:SetActiveLocal(false)
        self.mMonStunBarBg:SetActiveLocal(false)
    else
        self.mMonStunBarBg:SetActiveLocal(true)
        if self.m_liveVo:getAtt(AttConst.STUN_RESUME) > 0 then
            self.mMonStunBarGO:SetActiveLocal(false)
            self.mMonStunBar2GO:SetActiveLocal(true)
            self.mMonStunBar2.fillAmount = self.m_liveVo:getAtt(AttConst.STUN_RESUME) * 1 / self.m_liveVo:getAtt(AttConst.STUN_MAX)
        else
            self.mMonStunBarGO:SetActiveLocal(true)
            self.mMonStunBar2GO:SetActiveLocal(false)
            self.mMonStunBar.fillAmount = self.m_liveVo:getAtt(AttConst.STUN) * 1 / self.m_liveVo:getAtt(AttConst.STUN_MAX)
        end
    end

    if (self.m_liveVo:getAtt(AttConst.SHIELD) > 0) then
        self.mRoleShieldBarBgGO:SetActiveLocal(true)
        self.mMonShieldBarBgGO:SetActiveLocal(true)

        gs.TransQuick:SizeDelta01(self.mRoleShieldBarGO.transform, 206 * (self.m_liveVo:getAtt(AttConst.SHIELD) * 1 / self.m_liveVo:getAtt(AttConst.SHIELD_MAX)))
        gs.TransQuick:SizeDelta01(self.mMonShieldBarGO.transform, 206 * (self.m_liveVo:getAtt(AttConst.SHIELD) * 1 / self.m_liveVo:getAtt(AttConst.SHIELD_MAX)))
    else
        self.mRoleShieldBarBgGO:SetActiveLocal(false)
        self.mMonShieldBarBgGO:SetActiveLocal(false)
    end

    self:updateBuffIcon()
end

function updateBuffIcon(self)
    local tmpIcons = self.m_buffIcons
    self.m_buffIcons = {}

    local buffQueue = BuffHandler:getAllBuff(self.m_liveVo:getLiveID())
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
                        tIcon:addOnParent(self.mGroupBuff)
                    else
                        table.remove(tmpIcons, 1)
                    end
                    tIcon:setIcon(UrlManager:getBuffIconUrl(buffIcon))

                    local bdata = self.m_liveVo:getBuffData(v:getRefID())
                    tIcon:setTxtData(bdata[1], bdata[2])
                    table.insert(self.m_buffIcons, tIcon)
                end
            end
        end
    end
    for _, v in ipairs(tmpIcons) do
        v:destroy()
    end
end

-- 更新弱点格子
function updateWeak(self)
    if not self.m_liveVo then
        self.m_liveVo = fight.SceneManager:getThing(self.m_liveID)
    end

    self:recoverWeakList()
    if self.m_liveVo:getRaceType() == 1 then
        local monsterVo = self.m_liveVo:getOrgData()
        for i = 1, #monsterVo.weak_point do
            local item = SimpleInsItem:create(self:getChildGO("GroupWeakItem"), self.mGroupWeak, "FightSoulViewWeakItem")
            item:getChildGO("mImgWeak"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getHeroEleTypeIconUrl2(monsterVo.weak_point[i]), false)
            table.insert(self.mWeaknessList, item)
        end
    end
end

-- 回收弱点图标
function recoverWeakList(self)
    for i, v in ipairs(self.mWeaknessList) do
        v:poolRecover()
    end
    self.mWeaknessList = {}
end

function removeSelf(self)
    super.removeSelf(self)
    self:recoverWeakList()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]