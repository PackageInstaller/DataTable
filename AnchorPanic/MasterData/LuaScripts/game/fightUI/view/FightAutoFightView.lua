--[[   
     战斗UI下方自动战斗区域
]]
module('fightUI.FightAutoFightView', Class.impl('lib.component.BaseNode'))

function initData(self, rootGo)
    super.initData(self, rootGo)


    self.mGroupSelectSkill = self:getChildGO("mGroupSelectSkill")
    self.mGroupSelectSkill:SetActiveLocal(false)
    self.mSelectSkillPrevent = self:getChildGO("mSelectSkillPrevent")
    self.mSelectSkillPrevent:SetActiveLocal(false)

    self.selectItem1 = SimpleInsItem:create2(self:getChildGO("mGroupSelectSkill1"))
    self.selectItem2 = SimpleInsItem:create2(self:getChildGO("mGroupSelectSkill2"))
    self.selectItem3 = SimpleInsItem:create2(self:getChildGO("mGroupSelectSkill3"))

    local function onSelectSkill1()
        self:setSeletSkillItem(1, true)
    end
    local function onSelectSkill2()
        self:setSeletSkillItem(2, true)
    end
    local function onSelectSkill3()
        self:setSeletSkillItem(3, true)
    end

    self.selectItem3:addUIEvent(nil, onSelectSkill3)

    self.mSkill1 = fightUI.FightSkillItem.new()
    self.mSkill1:setup(UrlManager:getUIPrefabPath("fight/FightSkillItem.prefab"))
    self.mSkill1:addOnParent(self:getChildTrans("mGroupSkillNode1"))
    self.mSkill1:setSkillCall(onSelectSkill1)
    self.mSkill1:getSoulBgTrans().gameObject:SetActive(false)
    self.mSkill1:setEffGroupActive(false)
    self:setGuideTrans("guide_fight_auto_Skill_1", self.mSkill1.m_trans)

    self.mSkill2 = fightUI.FightSkillItem.new()
    self.mSkill2:setup(UrlManager:getUIPrefabPath("fight/FightSkillItem.prefab"))
    self.mSkill2:addOnParent(self:getChildTrans("mGroupSkillNode2"))
    self.mSkill2:setSkillCall(onSelectSkill2)
    self.mSkill2:getSoulBgTrans().gameObject:SetActive(false)
    self.mSkill2:setEffGroupActive(false)
    self:setGuideTrans("guide_fight_auto_Skill_2", self.mSkill2.m_trans)

    self:addOnClick(self.mSelectSkillPrevent, self.onCloseSelectSkill)

end

-- 设置自动战斗模块开启状态
function showAutoFight(self, bool)
    self.mIsShowAutoFight = bool
    if bool then
        self:setVisibleByScale(true)
        self:updateHeroItem()
    else
        self:setVisibleByScale(false)
        self:setActionLiveId(0)
    end
end

-- 设置行动战员
function setActionLiveId(self, liveId)
    if (not self.mIsShowAutoFight and liveId > 0) or not self.mHeroHeadItem then
        return
    end
    self.mLiveId = liveId
    local attList = fight.SceneManager:getSideThingIDs(1)
    table.sort(attList, self.heroSort)

    if attList and #attList > 0 then
        for i = 1, #attList do
            local liveVo = fight.SceneManager:getThing(attList[i])
            if liveVo:getRaceType() == 0 then
                local item = self.mHeroHeadItem[i]
                item:getChildGO("mSelected"):SetActive(false)
                if attList[i] == liveId then
                    item:getChildGO("mSelected"):SetActive(true)
                end
            end
        end
    end
end

-- 关闭技能选择
function onCloseSelectSkill(self)
    self.mGroupSelectSkill:SetActiveLocal(false)
    self.mSelectSkillPrevent:SetActiveLocal(false)

    if self.mCurRoleItem then
        gs.TransQuick:LPosY(self.mCurRoleItem:getChildTrans("mGroupHead"), 0)
    end
end

-- 打开技能选择
function updateSkill(self, liveId, roleItem)
    self.mGroupSelectSkill:SetActiveLocal(true)
    self.mSelectSkillPrevent:SetActiveLocal(true)

    self.mCurLiveId = liveId

    if self.mCurRoleItem then
        gs.TransQuick:LPosY(self.mCurRoleItem:getChildTrans("mGroupHead"), 0)
    end
    self.mCurRoleItem = roleItem

    if self.mCurRoleItem then
        gs.TransQuick:LPosY(self.mCurRoleItem:getChildTrans("mGroupHead"), 15)

        local parentPos = self:getChildTrans("AutoFightLayout"):InverseTransformPoint(self.mCurRoleItem:getChildTrans("mGroupHead").position)
        gs.TransQuick:LPosX(self.mGroupSelectSkill.transform, parentPos.x)

        -- 边界判断
        local globalPos = self:getChildTrans("AutoFightGroup"):InverseTransformPoint(self.mCurRoleItem:getChildTrans("mGroupHead").position)
        local maxW = globalPos.x + self.mGroupSelectSkill.transform.rect.width / 2
        local w, h = ScreenUtil:getScreenSize()
        if maxW > w / 2 then
            local curX = parentPos.x - (maxW - w / 2)
            gs.TransQuick:LPosX(self.mGroupSelectSkill.transform, curX)
        end

        if StorageUtil:getBool1(gstor.FIGHT_SHOW_AUTO_HP) then
            gs.TransQuick:LPosY(self.mGroupSelectSkill.transform, 107)
        else
            gs.TransQuick:LPosY(self.mGroupSelectSkill.transform, 65)
        end
    end


    local itemIndex = self:getSkillItemIndex(liveId)
    self:setSeletSkillItem(itemIndex, false)

    local side, heroId = fight.FightManager:parseUniqueID(self.mCurLiveId)
    local skillDatas = fight.FightManager:getHeroSkillList(liveId)
    if skillDatas then
        for _, skillTmpVo in ipairs(skillDatas) do
            local skillRo = skillTmpVo:skillRo()
            local posIdx = skillTmpVo:getSkillPos()
            if posIdx == 1 then
                self.mSkill1:setHeroID(heroId)
                self.mSkill1:setSkillID(skillRo:getRefID(), self.mCurLiveId)
                self.mSkill1:setIcon(UrlManager:getIconPath("skill/" .. skillRo:getIcon()))
                self.mSkill1:setState(fightUI.FightSkillItemState.NORMAL)
                self.mSkill1:setSoul(skillTmpVo:skillCost())
            end
            if posIdx == 2 then
                self.mSkill2:setHeroID(heroId)
                self.mSkill2:setSkillID(skillRo:getRefID(), self.mCurLiveId)
                self.mSkill2:setIcon(UrlManager:getIconPath("skill/" .. skillRo:getIcon()))
                self.mSkill2:setState(fightUI.FightSkillItemState.NORMAL)
                self.mSkill2:setSoul(skillTmpVo:skillCost())

            end
        end
    end
end

-- 设置技能选中
function setSeletSkillItem(self, index, isChange)
    if isChange then
        self:onCloseSelectSkill()

        if self.mSelectIndex == index then
            return
        end
        local type = 0
        for k, v in pairs(fight.FightDef.AUTO_FIGHT_SKILL_RULE) do
            if v == index then
                type = k
                break
            end
        end
        fight.FightManager:reqAutoFightSkillChange(self.mCurLiveId, type)

        if self.mCurRoleItem then
            local nameLan = self:getSelectSkillNameLan(nil, index)
            self.mCurRoleItem:setText("mTxtSkillName", nameLan)
        end
    end

    self.mSelectIndex = index


    self.selectItem1:getChildGO("mImgSelected"):SetActive(index == 1)
    self.selectItem2:getChildGO("mImgSelected"):SetActive(index == 2)
    self.selectItem3:getChildGO("mImgSelected"):SetActive(index == 3)
end

-- 战员排序
function heroSort(id1, id2)
    local aliveVo = fight.SceneManager:getThing(id1)
    local bliveVo = fight.SceneManager:getThing(id2)
    if aliveVo:getRaceType() ~= bliveVo:getRaceType() then
        return aliveVo:getRaceType() < bliveVo:getRaceType()
    else
        return id1 < id2
    end
end

-- 更新战员头像
function updateHeroItem(self)
    self:recoverHeroHeadItem()

    local attList = fight.SceneManager:getSideThingIDs(1)
    table.sort(attList, self.heroSort)

    for i = 1, 5 do
        local item = SimpleInsItem:create(self:getChildGO("GroupSkillHeadItem"), self:getChildTrans("mGroupHeroHead"), "FightAutoFightViewSkillHeadItem")
        self:setHpVisible(item, false)
        if attList and i <= #attList then
            local id = attList[i]
            local liveVo = fight.SceneManager:getThing(id)
            if liveVo:getRaceType() == 0 then
                local sprite = gs.ResMgr:Load(UrlManager:getBgPath("fightUI/fightui_bg_1.png"))
                if sprite then
                    if sprite.texture then
                        item:getChildGO("mImgHeadIcon"):GetComponent(ty.AutoRefImage).material:SetTexture("_Mask", sprite.texture)
                    else
                        item:getChildGO("mImgHeadIcon"):GetComponent(ty.AutoRefImage).material:SetTexture("_Mask", sprite)
                    end
                end

                item:getChildGO("mImgHeadIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getHeroHeadUrlByModel(liveVo:getModelID()), false)
                -- item:getChildGO("mImgEleIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getHeroEleTypeIconUrl(heroVo.eleType), false)
                item:getChildGO("mImgStopAct"):SetActive(false)
                item:addUIEvent("mGroupHead", function()
                    if not liveVo:isDead() then
                        self:updateSkill(liveVo.id, item)
                    end
                end)

                self:setGuideTrans("guide_fight_auto_Hero_" .. i, item:getChildTrans("mGroupHead"))

                local nameLan = self:getSelectSkillNameLan(liveVo.id)
                item:setText("mTxtSkillName", nameLan)

                item:getChildGO("mImgHeadEmpty"):SetActive(false)
                item:getChildGO("mImgHeadIcon"):SetActive(true)
                item:getChildGO("mImgHeadIcon"):GetComponent(ty.CanvasGroup).alpha = 1
                -- item:getChildGO("mImgEleIcon"):SetActive(true)
                item:getChildGO("mTxtSkillName"):SetActive(true)

                item:getChildGO("mGroupMon"):SetActive(false)
                item:getChildGO("mGroupWeak"):SetActive(false)

                self:setHpVisible(item, true)
            else
                item:getChildGO("mImgHeadEmpty"):SetActive(true)
                item:getChildGO("mImgHeadIcon"):SetActive(false)
                -- item:getChildGO("mImgEleIcon"):SetActive(false)
                item:getChildGO("mImgStopAct"):SetActive(false)
                item:getChildGO("mTxtSkillName"):SetActive(false)
            end
        else
            item:getChildGO("mImgHeadEmpty"):SetActive(true)
            item:getChildGO("mImgHeadIcon"):SetActive(false)
            -- item:getChildGO("mImgEleIcon"):SetActive(false)
            item:getChildGO("mImgStopAct"):SetActive(false)
            item:getChildGO("mTxtSkillName"):SetActive(false)
        end
        table.insert(self.mHeroHeadItem, item)
    end
end

-- 回收项
function recoverHeroHeadItem(self)
    if self.mHeroHeadItem then
        for i, v in pairs(self.mHeroHeadItem) do
            v:poolRecover()
            -- UIEffectMgr:addEffect("fx_ui_fight_release", v:getChildTrans("mGroupHead"))
        end
    end
    self.mHeroHeadItem = {}
end

-- 更新状态
function updateState(self)
    if not self.mIsShowAutoFight then
        return
    end
    local attList = fight.SceneManager:getSideThingIDs(1)
    table.sort(attList, self.heroSort)

    if attList and #attList > 0 then
        for i = 1, #attList do
            local item = self.mHeroHeadItem[i]
            local liveVo = fight.SceneManager:getThing(attList[i])
            if liveVo:getRaceType() == 0 then
                if liveVo:isDead() then
                    item:getChildGO("mImgHeadIcon"):GetComponent(ty.CanvasGroup).alpha = 0.3
                    item:getChildGO("mImgStopAct"):SetActive(true)
                    item:getChildGO("mImgStopAct"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getFightUIPath("fight_icon_13.png"), true)
                    self:setHpVisible(item, false)
                else
                    local isControl = false
                    local bDict = liveVo:getBuffDataDict()
                    if bDict then
                        for buffRefID, v in pairs(bDict) do
                            local bRo = Buff.BuffRoMgr:getBuffRo(buffRefID)
                            if bRo then
                                local fID = bRo:getFid()
                                if BuffDef.checkIsControlBuff(fID) then
                                    isControl = true
                                    break
                                end
                            end
                        end
                    end

                    if isControl then
                        -- item:getChildGO("mImgHeadIcon"):GetComponent(ty.CanvasGroup).alpha = 0.3
                        item:getChildGO("mImgStopAct"):SetActive(true)
                        item:getChildGO("mImgStopAct"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getFightUIPath("fight_icon_14.png"), true)
                    else
                        item:getChildGO("mImgHeadIcon"):GetComponent(ty.CanvasGroup).alpha = 1
                        item:getChildGO("mImgStopAct"):SetActive(false)
                    end
                    -- item:getChildGO("mImgHeadIcon"):GetComponent(ty.CanvasGroup).alpha = 1
                    -- item:getChildGO("mImgStopAct"):SetActive(false)

                    self:setHpVisible(item, true)
                    self:updateBar(item, liveVo)
                    self:updateBuffIcon(item, liveVo)
                end
            end
        end
    end
end

-- hp条
function setHpVisible(self, item, bVisible)
    local isVisible = bVisible
    if not StorageUtil:getBool1(gstor.FIGHT_SHOW_AUTO_HP) then
        isVisible = false
    end
    if item:getChildGO("mGroupHeadHp") then
        item:getChildGO("mGroupHeadHp"):SetActiveLocal(isVisible)
        item:getChildGO("mGroupBuff"):SetActive(isVisible)
    end
end

function updateBar(self, item, liveVo)
    self.mRoleHpBar = item:getChildGO("mRoleHpBar"):GetComponent(ty.ProgressBarHp)
    self.mRoleHpBar:SetValue(liveVo:getAtt(AttConst.HP), liveVo:getAtt(AttConst.HP_MAX), true, 0.7)

    if (liveVo:getAtt(AttConst.SHIELD) > 0) then
        item:getChildGO("mRoleShieldBarBg"):SetActiveLocal(true)

        gs.TransQuick:SizeDelta01(item:getChildGO("mRoleShieldBar").transform, 88 * (liveVo:getAtt(AttConst.SHIELD) * 1 / liveVo:getAtt(AttConst.SHIELD_MAX)))
    else
        item:getChildGO("mRoleShieldBarBg"):SetActiveLocal(false)
    end
end

-- 更新buff
function updateBuffIcon(self, item, liveVo)
    if not self.m_buffIcons then
        self.m_buffIcons = {}
    end
    if not self.m_buffIcons[liveVo.id] then
        self.m_buffIcons[liveVo.id] = {}
    end
    local tmpIcons = self.m_buffIcons[liveVo.id]
    self.m_buffIcons[liveVo.id] = {}

    item:getChildGO("mImgOmitBg"):SetActive(false)

    local buffQueue = BuffHandler:getAllBuff(liveVo:getLiveID())
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
                        tIcon:addOnParent(item:getChildTrans("mGroupBuff"))
                    else
                        table.remove(tmpIcons, 1)
                    end
                    tIcon:setIcon(UrlManager:getBuffIconUrl(buffIcon))

                    local bdata = liveVo:getBuffData(v:getRefID())
                    tIcon:setTxtData(bdata[1], bdata[2])
                    table.insert(self.m_buffIcons[liveVo.id], tIcon)

                    if StorageUtil:getBool1(gstor.FIGHT_SHOW_AUTO_HP_BUFF) ~= true then
                        if #buffQueue > 4 and #self.m_buffIcons[liveVo.id] >= 3 then
                            item:getChildTrans("mImgOmitBg"):SetSiblingIndex(4)
                            item:getChildGO("mImgOmitBg"):SetActive(true)
                            break
                        end
                    end
                end
            end
        end
    end
    for _, v in ipairs(tmpIcons) do
        v:destroy()
    end
end



-- 获取选中的技能名称语言包(传index 临时获取未保存服务器的选择)
function getSelectSkillNameLan(self, liveId, index)
    local itemIndex = index and index or self:getSkillItemIndex(liveId)
    local nameLanId = 3080
    if itemIndex == 1 then
        nameLanId = 3078
    elseif itemIndex == 2 then
        nameLanId = 3079
    elseif itemIndex == 3 then
        nameLanId = 3080
    end
    return nameLanId
end

-- 获取技能选中
function getSkillItemIndex(self, liveId)
    local curHeroData = fight.FightManager:getHero(liveId)
    local autoMsgIndex = curHeroData.auto_battle_rule
    local itemIndex = fight.FightDef.AUTO_FIGHT_SKILL_RULE[autoMsgIndex]
    return itemIndex
end

function destroy(self, isAuto)
    self:recoverHeroHeadItem()
    super.destroy(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]