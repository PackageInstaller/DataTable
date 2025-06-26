--[[   
     战斗UI下方技能区域
]]
module('fightUI.FightSkillView', Class.impl('lib.component.BaseNode'))

function initData(self, rootGo)
    super.initData(self, rootGo)
    self.m_heroID = nil

    self.m_extraCost = 0
    self.m_mainUI = nil

    local function _skillCall(sItem, tmpVo)
        if fight.FightManager:isReplaying() then return end
        if fight.FightManager.m_stopClipSkill == true and not guide.GuideManager:getCurGuideRo() then return end
        if tmpVo then
            if tmpVo:getLock() == true then
                return
            end
            if tmpVo:cdCanUse() == 0 then
                if tmpVo:canUse(self.m_extraCost) then
                    fight.FightManager:reqUseSkill(tmpVo:skillRo():getRefID())
                    -- self.m_skill1:startCD()
                    -- self.m_skill2:startCD()
                    sItem:showClickEfx()
                else
                    if tmpVo:skillRo():getType() == fight.FightDef.SKILL_TYPE_ACTIVE_SKILL then
                        gs.Message.Show(_TT(3025))
                    else
                        gs.Message.Show(_TT(3024))
                    end
                end
            end
        end
    end

    local function _skillMaxCall(sItem, tmpVo)
        if fight.FightManager:isReplaying() then return end
        if fight.FightManager.m_stopClipSkillMax == true and not guide.GuideManager:getCurGuideRo() then return end
        if tmpVo then
            if tmpVo:getLock() == true then
                return
            end
            if tmpVo:cdCanUse() == 0 then
                if tmpVo:canUse(self.m_extraCost) then
                    fight.FightManager:reqUseSkill(tmpVo:skillRo():getRefID())
                    -- self.m_skill1:startCD()
                    -- self.m_skill2:startCD()

                    sItem:showClickEfx()
                    sItem:showSelectEfx()
                else
                    if tmpVo:skillRo():getType() == fight.FightDef.SKILL_TYPE_ACTIVE_SKILL then
                        gs.Message.Show(_TT(3025))
                    else
                        gs.Message.Show(_TT(3024))
                    end
                end
            end
        end
    end

    self.m_skill1 = fightUI.FightSkillItem.new()
    self.m_skill1:setup(UrlManager:getUIPrefabPath("fight/FightSkillItem.prefab"))
    self.m_skill1:setSkillCall(_skillCall)
    self.m_skill1:addOnParent(self:getChildTrans("SkillItem1"))
    self.m_skill2 = fightUI.FightSkillItem.new()
    self.m_skill2:setup(UrlManager:getUIPrefabPath("fight/FightSkillItem.prefab"))
    self.m_skill2:setSkillCall(_skillCall)
    self.m_skill2:addOnParent(self:getChildTrans("SkillItem2"))

    self.m_skillmax1 = fightUI.FightMaxSkillItem.new()
    self.m_skillmax1:setup(UrlManager:getUIPrefabPath("fight/FightMaxSkillItem.prefab"))
    self.m_skillmax1:setSkillCall(_skillMaxCall)
    self.m_skillmax1:addOnParent(self:getChildTrans("SkillItem3"))

    -- self.m_skillmax2 = fightUI.FightMaxSkillItem.new()
    -- self.m_skillmax2:setup(UrlManager:getUIPrefabPath("fight/FightMaxSkillItem.prefab"))
    -- self.m_skillmax2:setSkillCall(_skillMaxCall)
    -- self.m_skillmax2:addOnParent(self:getChildTrans("SkillItem4"))

    self.m_imgPowerWarn = self:getChildTrans("ImgPowerWarn")
    self.m_textPowerWarn = self:getChildGO("TextPowerWarn"):GetComponent(ty.Text)

    self.m_aoyiPowerBar = self:getChildGO("AoyiPowerBar")

    self.m_itemLst = {}
    table.insert(self.m_itemLst, { self.m_skill1, false })
    table.insert(self.m_itemLst, { self.m_skill2, false })
    -- table.insert(self.m_itemLst, {self.m_skill3, false})
    table.insert(self.m_itemLst, { self.m_skillmax1, false })
    -- table.insert(self.m_itemLst, { self.m_skillmax2, false })

    -- self.m_skill1.m_go.name = "guide_SkillItem1"
    -- self.m_skill1.m_soulBgGo.name = "guide_soulBG"
    -- self.m_skillmax1.m_go.name = "guide_SkillMaxItem"

    -- self.m_soulPro1 = self:getChildGO("SoulPro1"):GetComponent(ty.AutoRefImage)
    -- self.m_soulPro2 = self:getChildGO("SoulPro2"):GetComponent(ty.AutoRefImage)
    -- self.m_soulPro3 = self:getChildGO("SoulPro3"):GetComponent(ty.AutoRefImage)
    self:updateSoulItem()

    self:setGuideTrans("guide_SkillItem1", self.m_skill1:getTrans())
    self:setGuideTrans("guide_SkillItem2", self.m_skill2:getTrans())
    self:setGuideTrans("guide_SkillMaxItem", self.m_skillmax1:getTrans())
    self:setGuideTrans("guide_soulBG", self.m_skill1:getSoulBgTrans())

end

function hideMaxSkill(self, hide)
    for i = 3, #self.m_itemLst do
        self.m_itemLst[i][1]:setActive(not hide)
    end
    -- self:getChildGO("SkillItem1"):SetActive(not hide)
    -- self:getChildGO("SkillItem2"):SetActive(not hide)
end

function setMainUI(self, mainUI)
    self.m_mainUI = mainUI
end

function resetSkill(self)
    self.m_extraCost = 0
    for _, itemData in ipairs(self.m_itemLst) do
        itemData[1]:setState(fightUI.FightSkillItemState.EMPTY)
        itemData[1]:setIsUse(false)
    end
    local skillDatas = fight.FightManager:getHeroSkillList(self.m_heroID)
    if skillDatas then
        for _, skillTmpVo in ipairs(skillDatas) do
            -- 恢复技能额外消耗
            skillTmpVo:setExtraCost(0)
        end
    end
    RateLooper:clearTimeout(self.powerWarnTimerId)
end

function setMaxSkillCurVal(self, curVal)
    if self.m_targetVal == curVal then return end
    if self.m_targetVal == nil then
        self.m_targetVal = curVal
        self.m_cdCurVal = self.m_targetVal
        self:updateMaxSkillValState()
    else
        self.m_targetVal = curVal
        local v = 10
        self.m_tVal = (self.m_targetVal - self.m_cdCurVal) / v
        if self.m_skillCDTimeSn then
            RateLooper:removeTimerByIndex(self.m_skillCDTimeSn)
        end
        self.m_skillCDTimeSn = RateLooper:addFrame(1, v, self, self.updateMaxSkillVal)
    end
end
function setMaxSkillMaxVal(self, maxVal)
    self.m_cdMaxVal = maxVal
end

function updateMaxSkillVal(self)
    self.m_cdCurVal = self.m_cdCurVal + self.m_tVal
    if self.m_cdCurVal == self.m_targetVal then
        self:removeLooper()
    end
    self:updateMaxSkillValState()
end

function updateMaxSkillValState(self)
    local val = self.m_cdCurVal / self.m_cdMaxVal
    if val > 1 then
        val = 1
    elseif val < 0 then
        val = 0
    end
    
    if self.m_aoyiPowerBar and not gs.GoUtil.IsGoNull(self.m_aoyiPowerBar) then
        self.m_aoyiPowerBar:GetComponent(ty.Image).fillAmount = val
    end
end

function removeLooper(self)
    RateLooper:removeTimerByIndex(self.m_skillCDTimeSn)
    self.m_skillCDTimeSn = nil
    self.m_targetVal = nil
end

function setReadyLive(self, heroID)
    -- if self.m_heroID==heroID then return end
    self.m_heroID = heroID
    self.m_curHero = fight.FightManager:getHero(heroID)

    self:updateSoul()

    self:setMaxSkillMaxVal(fight.FightManager:getMaxRage(self.m_heroID))

    if heroID == nil or self.m_curHero == nil then
        --print("111111111111111", heroID, self.m_curHero)
        self:setVisibleByScale(false)
        return
    end
    local liveVo = fight.SceneManager:getThing(heroID)
    if liveVo == nil or liveVo:isAttacker() ~= 1 or liveVo:getRaceType() ~= 0 then
        --print("222222222222", heroID, liveVo)
        self:setVisibleByScale(false)
        return
    end
    if fight.FightManager:getIsAutoFight() == true and StorageUtil:getBool1(gstor.FIGHT_SHOW_UI) == true then
        --print("3333333333333333", heroID)
        self:setVisibleByScale(false)
        return
    else
        if not fight.FightManager:isReplaying() and not fight.FightManager:getIsAutoFight() then
            self:setVisibleByScale(true)
        end
    end

    for _, itemData in ipairs(self.m_itemLst) do
        itemData[2] = false
    end


    local function _setSItem(sItem, skillTmpVo)
        local skillRo = skillTmpVo:skillRo()
        local skillRefID = skillRo:getRefID()
        local side, heroId = fight.FightManager:parseUniqueID(self.m_heroID)
        sItem:setHeroID(heroId)
        sItem:setSkillID(skillRefID, self.m_heroID)
        sItem:setIcon(UrlManager:getIconPath("skill/" .. skillRo:getIcon()))
        if skillTmpVo:getLock() == true then
            sItem:setState(fightUI.FightSkillItemState.LOCK)
        else
            sItem:setState(fightUI.FightSkillItemState.NORMAL)
            if skillTmpVo:skillType() ~= 3 then
                sItem:setSoul(skillTmpVo:skillCost())
                if liveVo:getAtt(AttConst.SKILL_SOUL) < skillTmpVo:skillCost() then
                    sItem:setState(fightUI.FightSkillItemState.NO_POWER)
                end
            end

            if skillTmpVo:cdCanUse() > 0 then
                sItem:setRountTxt(string.format("%d%s", skillTmpVo:cdCanUse(), _TT(3001)))
                sItem:setState(fightUI.FightSkillItemState.SHOW_ROUND)
            end
            if sItem:getIsUse() ~= true then
                skillTmpVo:setIsUse(false)
                --if skillTmpVo:canUse(self.m_extraCost) then
                -- sItem:setEnable(true)
                --end
                sItem:setClickData(skillTmpVo)
            else
                -- sItem:setEnable(false)
                skillTmpVo:setIsUse(true)
            end
        end
    end


    -- self.m_lineGo:SetActive(false)
    local skillDatas = fight.FightManager:getHeroSkillList(heroID)
    if skillDatas then
        for _, skillTmpVo in ipairs(skillDatas) do
            local skillRo = skillTmpVo:skillRo()

            if skillRo:getType() == 1 or skillRo:getType() == 2 or skillRo:getType() == 3 then
                local posIdx = skillTmpVo:getSkillPos()
                if posIdx then
                    local itemData = self.m_itemLst[posIdx]
                    if itemData then
                        local sItem = itemData[1]
                        itemData[2] = true
                        _setSItem(sItem, skillTmpVo)
                    end
                end
            end
        end
        for _, skillTmpVo in ipairs(skillDatas) do
            local posIdx = skillTmpVo:getSkillPos()
            if posIdx == nil then
                local skillRo = skillTmpVo:skillRo()
                if skillRo:getType() == 1 then
                    local itemData = self.m_itemLst[1]
                    if itemData[2] == true then
                        itemData = self.m_itemLst[2]
                    end
                    if itemData[2] ~= true then
                        itemData[2] = true
                        local sItem = itemData[1]
                        _setSItem(sItem, skillTmpVo)
                    end
                elseif skillRo:getType() == 2 or skillRo:getType() == 3 then
                    local itemData = self.m_itemLst[3]
                    -- if itemData[2] == true then
                    --     itemData = self.m_itemLst[4]
                    -- end
                    if itemData[2] ~= true then
                        itemData[2] = true
                        local sItem = itemData[1]
                        _setSItem(sItem, skillTmpVo)
                    end
                end
            end
        end
    end
    --大招
    -- print("===========", liveVo:getAtt(AttConst.MP))
    self.m_skillmax1:setCurVal(liveVo:getAtt(AttConst.MP))
    -- self.m_skillmax2:setCurVal(liveVo:getAtt(AttConst.MP))
    self:setMaxSkillCurVal(liveVo:getAtt(AttConst.MP))
    -- self.m_skillRageTxt.text = string.format("%02d%%", liveVo:getAtt(AttConst.MP) / fight.FightManager:getMaxRage() * 100)
    for _, itemData in ipairs(self.m_itemLst) do
        if itemData[2] == false then
            itemData[1]:setState(fightUI.FightSkillItemState.EMPTY)
        end
    end

    if liveVo:getBuffData(10313) then
        self.m_skill1:setState(fightUI.FightSkillItemState.FORBID)
        self.m_skill2:setState(fightUI.FightSkillItemState.FORBID)
    end
end
-- 更新回合数
function updateRount(self, skillID)
    local sItem = nil
    for _, itemData in ipairs(self.m_itemLst) do
        if itemData[1]:getSKillID() == skillID then
            sItem = itemData[1]
            break
        end
    end

    if sItem and self.m_curHero then
        local heroID = self.m_curHero:getLiveID()
        local tmpVo = fight.FightManager:getHeroSkill(heroID, skillID)
        if tmpVo then
            if tmpVo:cdCanUse() > 0 then
                sItem:setRountTxt(string.format("%d%s", tmpVo:cdCanUse(), _TT(3001)))
                sItem:setState(fightUI.FightSkillItemState.SHOW_ROUND)
            end
        end
    end
end

function setUseSkill(self, skillID)
    local sItem = nil
    for _, itemData in ipairs(self.m_itemLst) do
        if itemData[1]:getSKillID() == skillID then
            sItem = itemData[1]
            break
        end
    end

    if sItem and not sItem:getIsUse() then
        local skillTmpVo = sItem:getClickData()
        skillTmpVo:useSkill()
        self:setReadyLive(skillTmpVo:getHeroID())
        -- sItem:setEnable(false)
        sItem:setIsUse(true)
        -- GameDispatcher:dispatchEvent(EventName.FIGHT_HERO_ATTR_UPDATE, self.m_heroID)
        if skillTmpVo:cdCanUse() > 0 then
            sItem:setRountTxt(string.format("%d%s", skillTmpVo:cdCanUse(), _TT(3001)))
            sItem:setState(fightUI.FightSkillItemState.SHOW_ROUND)
        end

        if skillTmpVo:skillType() == 3 or skillTmpVo:skillType() == 2 then
            self.m_skill1:setIsUse(true)
            self.m_skill2:setIsUse(true)
            self.m_skillmax1:setIsUse(true)
            -- self.m_skillmax2:setIsUse(true)
        end
        GameDispatcher:dispatchEvent(EventName.UPDATE_BUFF, skillTmpVo:getHeroID())
    end

end
-- 禁用普通技能
function disableNorSkill(self, desc)
    self.m_skill1:setBuffTxt(desc)
    self.m_skill2:setBuffTxt(desc)
    self.m_skill1:setState(fightUI.FightSkillItemState.PALSY)
    self.m_skill2:setState(fightUI.FightSkillItemState.PALSY)
end
-- 禁用大招
function disableUprightSkill(self, desc)
    self.m_skillmax1:setBuffTxt(desc)
    -- self.m_skillmax2:setBuffTxt(desc)
    self.m_skillmax1:setState(fightUI.FightSkillItemState.PALSY)
    -- self.m_skillmax2:setState(fightUI.FightSkillItemState.PALSY)
end

-- 添加额外的消耗
function addSkillCost(self, cost)
    self.m_extraCost = cost or 0
end

-- 改变技能消耗电量（增减值）
function changeSoul(self, soul)
    local skillDatas = fight.FightManager:getHeroSkillList(self.m_heroID)
    if skillDatas then
        for _, skillTmpVo in ipairs(skillDatas) do
            if skillTmpVo:skillType() == 1 then
                skillTmpVo:setExtraCost(soul)
            end
        end
    end
end

function destroy(self, isAuto)
    for _, itemData in ipairs(self.m_itemLst) do
        itemData[1]:destroy()
    end
    self.m_itemLst = {}
    RateLooper:removeTimerByIndex(self.m_skillCDTimeSn)
    self.m_skillCDTimeSn = nil
    self:recoverSoulItem()
    super.destroy(self)
end

-- 创建电量
function updateSoulItem(self)
    self:recoverSoulItem()
    for i = 1, 2 do
        local item = SimpleInsItem:create(self:getChildGO("SoulPro"), self:getChildTrans("SoulBarBg"), "FightSkillViewSoulPro")
        table.insert(self.soulProList, item)
    end
end


-- 回收项
function recoverSoulItem(self)
    if self.soulProList then
        for i, v in pairs(self.soulProList) do
            v:poolRecover()
        end
    end
    self.soulProList = {}
end

-- 更新电量
function updateSoul(self)
    local liveVo = fight.SceneManager:getThing(self.m_heroID)
    if liveVo then
        local curSoul = liveVo:getAtt(AttConst.SKILL_SOUL) or 0
        for i, item in ipairs(self.soulProList) do
            if curSoul >= i * 5 then
                item:getChildGO("ImgSoulHide"):SetActive(false)
                item:getChildGO("ImgSoulActive"):SetActive(true)
            else
                item:getChildGO("ImgSoulHide"):SetActive(true)
                item:getChildGO("ImgSoulActive"):SetActive(false)
            end
        end

        return liveVo
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]