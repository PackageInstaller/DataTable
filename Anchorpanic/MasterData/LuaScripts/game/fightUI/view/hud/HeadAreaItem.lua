module("fightUI.HeadAreaItem", Class.impl(fightUI.HUDItem))

function ctor(self)
    super.ctor(self)
    self.m_prefabName = UrlManager:getUIPrefabPath("fight/liveui/HeadAreaItem1.prefab")
    -- self.m_prefabName = "HeadAreaItem.prefab"
    self.m_point = nil
    self.m_parent = nil
    self.m_liveVo = nil
    -- hp条
    self.mRoleHpBar = nil
    self.mRoleHpBarGO = nil
    self.mMonHpBar = nil
    self.mMonHpBarGO = nil
    -- 怒气条
    -- self.m_rageBar = nil
    -- self.m_rageBarGO = nil
    -- 护盾条
    self.mRoleShieldBar = nil
    self.mRoleShieldBarGO = nil
    self.mMonShieldBarBg = nil
    self.mMonShieldBarBgGO = nil

    self.mGroupBuff = nil
    self.m_buffIcons = {}
    self.m_isShowing = false

    self.m_otherIcons = {}

    self.m_buffEleDataDict = {}
    self.m_reactionQueue = {}

    self.mWeaknessDic = {}
    self.mHpSectionHash = {}
end

function destroy(self)
    if self.m_recationTween then
        self.m_recationTween:Kill()
        self.m_recationTween = nil
    end
    self:closeArea()
    --print("HeadAreaItem=========================destroy")
    super.destroy(self)
end

function onRecover(self)
    if self.m_recationTween then
        self.m_recationTween:Kill()
        self.m_recationTween = nil
    end
    self:closeArea()
    super.onRecover(self)
end
-- 初始化数据
function initData(self, rootGo)
    super.initData(self, rootGo)

    self.mGroupRole = self:getChildGO("mGroupRole")
    self.mGroupMon = self:getChildGO("mGroupMon")
    -- self.mTxtLvl = self:getChildGO("mTxtLvl"):GetComponent(ty.Text)

    self.mImgLocalBg = self:getChildGO("mImgLocalBg")
    self.mImgLocal = self:getChildGO("mImgLocal"):GetComponent(ty.AutoRefImage)

    self.mRoleHpBarGO = self:getChildGO("mRoleHpBar")
    self.mRoleHpInsBarGO = self:getChildGO("mRoleHpInsBar")
    self.mRoleHpBar = self.mRoleHpBarGO:GetComponent(ty.ProgressBarHp)

    -- self.m_rageBarGO = self:getChildGO("HeadRageBar")
    -- self.m_rageBar = self.m_rageBarGO:GetComponent(ty.Image)
    self.mRoleShieldBarGO = self:getChildGO("mRoleShieldBar")
    self.mRoleShieldBarBgGO = self:getChildGO("mRoleShieldBarBg")
    self.mRoleShieldBar = self.mRoleShieldBarGO:GetComponent(ty.Image)



    self.mMonHpBarGO = self:getChildGO("mMonHpBar")
    self.mMonHpInsBarGO = self:getChildGO("mMonHpInsBar")
    self.mMonHpBar = self.mMonHpBarGO:GetComponent(ty.ProgressBarHp)

    -- self.m_rageBarGO = self:getChildGO("HeadRageBar")
    -- self.m_rageBar = self.m_rageBarGO:GetComponent(ty.Image)
    self.mMonShieldBarGO = self:getChildGO("mMonShieldBar")
    self.mMonShieldBarBgGO = self:getChildGO("mMonShieldBarBg")
    self.mMonShieldBar = self.mMonShieldBarGO:GetComponent(ty.Image)

    self.mMonStunBarBg = self:getChildGO("mMonStunBarBg")
    self.mMonStunBarGO = self:getChildGO("mMonStunBar")
    self.mMonStunBar = self.mMonStunBarGO:GetComponent(ty.Image)

    self.mMonStunBar2GO = self:getChildGO("mMonStunBar2")
    self.mMonStunBar2 = self.mMonStunBar2GO:GetComponent(ty.Image)


    self.mGroupBuff = self:getChildTrans("mGroupBuff")
    self.mGroupOther = self:getChildTrans("mGroupOther")

    self.mGroupEleReaction = self:getChildTrans("mGroupEleReaction")
    self.mBuffEleLayout = self.mGroupEleReaction:GetComponent(ty.HorizontalLayoutGroup)

    self.mGroupWeak = self:getChildTrans("mGroupWeak")
    self.mGroupMonHpSection = self:getChildTrans("mGroupMonHpSection")

    self.mImgOmitBg = self:getChildTrans("mImgOmitBg")

    self.mRoleHpBarGO:SetActiveLocal(false)
    self.mRoleHpInsBarGO:SetActiveLocal(false)
    -- self.m_rageBarGO:SetActiveLocal(false)
    -- self.mRoleShieldBarGO:SetActiveLocal(false)
    self.mRoleShieldBarBgGO:SetActiveLocal(false)

    self.mMonHpBarGO:SetActiveLocal(false)
    self.mMonHpInsBarGO:SetActiveLocal(false)
    self.mMonShieldBarBgGO:SetActiveLocal(false)

    self.mMonStunBarBg:SetActiveLocal(false)
    self.mMonStunBarGO:SetActiveLocal(false)
    self.mMonStunBar2GO:SetActiveLocal(false)

    if self.m_liveVo:isAttacker() == 1 then
        -- local img = self.mRoleHpBarGO:GetComponent(ty.AutoRefImage)
        -- img:SetImg(UrlManager:getFightUIPath("fight_bar_6.png"))
        -- img = self.mRoleHpInsBarGO:GetComponent(ty.AutoRefImage)
        -- img:SetImg(UrlManager:getFightUIPath("fight_bar_6.png"))
        self.mGroupRole:SetActiveLocal(true)
        self.mGroupMon:SetActiveLocal(false)
    else
        self.mGroupRole:SetActiveLocal(false)
        self.mGroupMon:SetActiveLocal(true)
    end
end

function addBuffEle(self, buffRefID)
    local eleData = self.m_buffEleDataDict[buffRefID]
    if not eleData then
        local buffRo = Buff.BuffRoMgr:getBuffRo(buffRefID)
        if buffRo and buffRo:getEleUiIcon() ~= nil and #buffRo:getEleUiIcon() > 0 then
            local eleIcon = fightUI.FightBuffEleIcon.new()
            eleIcon:setup(UrlManager:getUIPrefabPath("fight/liveui/BuffEleIcon.prefab"))
            eleIcon:addOnParent(self.mGroupEleReaction)
            eleIcon:setIcon(UrlManager:getIconPath("buffEle/" .. buffRo:getEleUiIcon()))
            eleIcon:setElePrefab(UrlManager:get3DBuffPath(buffRo:getEleUiEffect()))
            eleData = {}
            eleData.eleIcon = eleIcon
            self.m_buffEleDataDict[buffRefID] = eleData
        end
    else
        eleData.isRemove = false
    end
end

function removeBuffEle(self, buffRefID)
    local eleData = self.m_buffEleDataDict[buffRefID]
    if eleData then
        if eleData.isRecation == true then
            eleData.isRemove = true
            return
        end
        if eleData.eleIcon then
            eleData.eleIcon:destroy()
        end
        self.m_buffEleDataDict[buffRefID] = nil
    end
end

function clearBuffEle(self)
    if self.m_recationTween then
        self.m_recationTween:Kill()
        self.m_recationTween = nil
    end
    self.mBuffEleLayout.spacing = 0
    for key, eleData in pairs(self.m_buffEleDataDict) do
        if eleData.eleIcon then
            eleData.eleIcon:destroy()
        end
    end
    self.m_buffEleDataDict = {}
    self.m_reactionQueue = {}
end

function reactionBuffEle(self, buffRefID1, buffRefID2, eleRo)
    local eleData1 = self.m_buffEleDataDict[buffRefID1]
    local eleData2 = self.m_buffEleDataDict[buffRefID2]
    if eleData1 and eleData2 then
        eleData1.isRecation = true
        eleData2.isRecation = true
        if self.m_recationTween then
            table.insert(self.m_reactionQueue, { buffRefID1, buffRefID2, eleRo })
            return
        end
        local reactionBuffPath = UrlManager:get3DBuffPath("UI_Attribute_chufa.prefab");
        local reactionEffGo = gs.GOPoolMgr:Get(reactionBuffPath)
        if reactionEffGo then
            gs.TransQuick:SetParentOrg(reactionEffGo.transform, self.mGroupEleReaction)
            gs.TransQuick:LPosY(reactionEffGo.transform, 26)

            local function _reactionEffFinishCall()
                if not gs.GoUtil.IsGoNull(reactionEffGo) then
                    gs.GOPoolMgr:Recover(reactionEffGo, reactionBuffPath)
                end
            end
            RateLooper:setTimeout(2, nil, _reactionEffFinishCall)
        end
        local function _progressCall(val)
            self.mBuffEleLayout.spacing = val
        end

        local function _closeCall()
            self.m_recationTween = nil
            eleData1.isRecation = nil
            eleData2.isRecation = nil
            if eleData1.isRemove == true then
                self.m_buffEleDataDict[buffRefID1] = nil
                if eleData1.eleIcon then
                    eleData1.eleIcon:destroy()
                end
            end
            if eleData2.isRemove == true then
                self.m_buffEleDataDict[buffRefID2] = nil
                if eleData2.eleIcon then
                    eleData2.eleIcon:destroy()
                end
            end
            local reactionData = self.m_reactionQueue[1]
            if reactionData then
                table.remove(self.m_reactionQueue, 1)
                self:reactionBuffEle(reactionData[1], reactionData[2], reactionData[3])
            end

            if eleRo then
                fightUI.FightFlyUtil:fly3DImg(UrlManager:getFightArtfontPath(eleRo:getSpIcon()), self.m_liveVo:getCurPos(), self.m_liveVo:isAttacker() == 1)
                local travel = STravelFactory:travel02(nil, 3, nil, self.m_liveVo:getLiveID())
                travel:setPerfData(UrlManager:get3DBuffPath(eleRo:getEffect()), nil, 1.5)
                travel:setSimplePoint(1)
                travel:start()
            end
            if table.nums(self.m_buffEleDataDict) > 1 then
                self.mBuffEleLayout.spacing = 2
            end
        end

        local function _openCall()
            self.m_recationTween = gs.DT.DoTweenEx.DOProgressFloatVal(2, -52, 0.1, _progressCall)
            self.m_recationTween:OnComplete(_closeCall)
        end

        self.m_recationTween = gs.DT.DoTweenEx.DOProgressFloatVal(-52, 2, 0.2, _progressCall)
        self.m_recationTween:OnComplete(_openCall)
    else
        local reactionData = self.m_reactionQueue[1]
        if reactionData then
            table.remove(self.m_reactionQueue, 1)
            self:reactionBuffEle(reactionData[1], reactionData[2], reactionData[3])
        end
    end
end
--point 为挂点
--parent 为UI图层节点
function setData(self, point, parent, liveVo)
    self.m_point = point
    self.m_parent = parent
    self.m_liveVo = liveVo
    -- self.m_prefabName = "HeadAreaItem1.prefab"
    -- if self.m_liveVo:isAttacker()==1 then
    --     self.m_prefabName = "HeadAreaItem1.prefab"
    -- else
    --     self.m_prefabName = "HeadAreaItem2.prefab"        
    -- end
    self:setup(self.m_prefabName)
    self.m_rTrans:SetParent(self.m_parent, false)
    -- self.m_rTrans:SetSiblingIndex(30 - self:getColumn() * 10)
    gs.TransQuick:UIPos(self.m_rTrans, -9999, -9999)
    self:setVisibleByScale(false)
    -- self:setLv(self.m_liveVo:getAtt(AttConst.LV))
    if self.m_liveVo.m_raceType == 1 then
        local mVo = monster.MonsterManager:getMonsterVo01(self.m_liveVo.tid)
        if mVo then
            self:setProfessionType(mVo.professionType)
        end

        if self.m_liveVo.tid == sysParam.SysParamManager:getValue(85) then
            self:setGuideTrans("funcTips_guide_HeadArea_MonsterHp", self.mMonStunBarBg.transform)
            self:setGuideTrans("funcTips_guide_HeadArea_MonsterWeak", self.mGroupWeak.transform)
        end
    else
        local hVo = hero.HeroManager:getHeroConfigVo(self.m_liveVo.tid)
        if hVo then
            self:setProfessionType(hVo.professionType)
        end
    end
end

function setLv(self, lv)
    -- self.mTxtLvl.text = "" .. lv
end

function setName(self, name)
end

-- function setActive(self, isActive)
--     super.setActive(self, isActive)
--     if isActive==true then
--         self:showArea()
--     else
--         self:closeArea()
--     end
-- end

function setProfessionType(self, professionType)
    -- self.mImgLocal:SetImg(UrlManager:getFightUIPath(string.format("fight_local_%s.png", professionType)), false)
end

function updateProfessionType(self)
    -- if StorageUtil:getBool1(gstor.FIGHT_SHOW_PROFESSIONTYPE) then
    --     self.mImgLocalBg:SetActive(false)
    -- else
    --     self.mImgLocalBg:SetActive(true)
    -- end
end


function showArea(self)
    -- print("showArea 111111111")
    if self.m_isShowing == true then return end
    -- print("showArea 2222222222222")
    if self.m_point and not gs.GoUtil.IsTransNull(self.m_point) and self.m_parent and self.m_rTrans then
        if gs.CameraMgr:IsInSCCamera(self.m_point) then

            -- 修正因为镜头俯角导致血条偏低问题
            local targetNum = self:getColumn()
            local offsetY = 10
            if targetNum == 1 then
                offsetY = 25
            elseif targetNum == 2 then
                offsetY = 15
            end
            gs.CameraMgr:World2UIOffset(self.m_point, self.m_parent, self.m_rTrans, 0, offsetY)
            gs.TransQuick:PosZ(self.m_rTrans, 0)
        else
            gs.TransQuick:UIPos(self.m_rTrans, -9999, -9999)
        end
        RateLooper:removeFrameByIndex(self.m_updateSn)
        self.m_updateSn = RateLooper:addFrame(0.1, 0, self, self.update)
        -- print("showArea 3333333333333333")
        self:setVisibleByScale(true)
        self:setHpVisible(true)
        self:setBuffVisible(true)
        self:setStunVisible(true)
        if self.m_liveVo:getAtt(AttConst.SHIELD) > 0 then
            self:setShieldVisible(true)
        end
        self.m_isShowing = true
        self:updateBuffIcon()

        self:updateProfessionType()

        self:updateWeak()
        self:createHpSection()

        GameDispatcher:addEventListener(EventName.FIGHT_SETTING_SAVE, self.onSettingSave, self)
    end
end

-- 设置界面关闭（可能有改动）
function onSettingSave(self)
    self:updateBuffIcon()
end

function closeArea(self)
    self:setVisibleByScale(false)
    -- self:setHpVisible(false)
    self:setShieldVisible(false)
    self:setStunVisible(false)
    RateLooper:removeFrameByIndex(self.m_updateSn)
    self.m_updateSn = 0
    self.m_isShowing = false

    self:recoverWeakList()
    self:recoverHpSectionList()
    GameDispatcher:removeEventListener(EventName.FIGHT_SETTING_SAVE, self.onSettingSave, self)
end

-- hp条
function setHpVisible(self, bVisible)
    if self.mRoleHpBarGO then
        self.mRoleHpBarGO:SetActiveLocal(bVisible)
        self.mRoleHpInsBarGO:SetActiveLocal(bVisible)
        self.mMonHpBarGO:SetActiveLocal(bVisible)
        self.mMonHpInsBarGO:SetActiveLocal(bVisible)
        if bVisible == true then
            self.mRoleHpBar:SetValue(self.m_liveVo:getAtt(AttConst.HP), self.m_liveVo:getAtt(AttConst.HP_MAX), true, 0.7)
            self.mMonHpBar:SetValue(self.m_liveVo:getAtt(AttConst.HP), self.m_liveVo:getAtt(AttConst.HP_MAX), true, 0.7)
            -- self.mRoleHpBar.fillAmount = self.m_liveVo:getAtt(AttConst.HP)*1.0/self.m_liveVo:getAtt(AttConst.HP_MAX)
            -- self.mRoleHpBar:SetValue(self.m_liveVo:getAtt(AttConst.HP), self.m_liveVo:getAtt(AttConst.HP_MAX))
        end
    end
    -- if self.m_rageBarGO then
    --     self.m_rageBarGO:SetActiveLocal(bVisible)
    --     if bVisible == true then
    --         self.m_rageBar.fillAmount = self.m_liveVo:getAtt(AttConst.MP) * 1 / self.m_liveVo:getAtt(AttConst.MP_MAX)
    --     end
    -- end
end

-- 护盾条
function setShieldVisible(self, bVisible)
    if self.mRoleShieldBarGO then
        self.mRoleShieldBarBgGO:SetActiveLocal(bVisible)
        self.mMonShieldBarBgGO:SetActiveLocal(bVisible)
        if bVisible == true then
            -- self.mRoleShieldBar.fillAmount = self.m_liveVo:getAtt(AttConst.SHIELD) * 1 / self.m_liveVo:getAtt(AttConst.SHIELD_MAX)
            gs.TransQuick:SizeDelta01(self.mRoleShieldBarGO.transform, 88 * (self.m_liveVo:getAtt(AttConst.SHIELD) * 1 / self.m_liveVo:getAtt(AttConst.SHIELD_MAX)))
            gs.TransQuick:SizeDelta01(self.mMonShieldBarGO.transform, 88 * (self.m_liveVo:getAtt(AttConst.SHIELD) * 1 / self.m_liveVo:getAtt(AttConst.SHIELD_MAX)))
        end
    end
end

-- 硬直条
function setStunVisible(self, bVisible)
    if self.mMonStunBarGO then
        local isShow = (self.m_liveVo:getAtt(AttConst.STUN_MAX) > 0)
        bVisible = isShow and bVisible
        self.mMonStunBarGO:SetActiveLocal(bVisible)
        self.mMonStunBar2GO:SetActiveLocal(bVisible)
        self.mMonStunBarBg:SetActiveLocal(bVisible)
        if bVisible == true then
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
    end
end

function updateBar(self)
    -- self:showArea()
    self.mRoleHpBar:SetValue(self.m_liveVo:getAtt(AttConst.HP), self.m_liveVo:getAtt(AttConst.HP_MAX), true, 0.7)
    self.mMonHpBar:SetValue(self.m_liveVo:getAtt(AttConst.HP), self.m_liveVo:getAtt(AttConst.HP_MAX), true, 0.7)
    -- self.mRoleHpBar.fillAmount = self.m_liveVo:getAtt(AttConst.HP)*1.0/self.m_liveVo:getAtt(AttConst.HP_MAX)

    if self.m_liveVo:getAtt(AttConst.STUN_RESUME) > 0 then
        self.mMonStunBarGO:SetActiveLocal(false)
        self.mMonStunBar2GO:SetActiveLocal(true)
        self.mMonStunBar2.fillAmount = self.m_liveVo:getAtt(AttConst.STUN_RESUME) * 1 / self.m_liveVo:getAtt(AttConst.STUN_MAX)
    else
        self.mMonStunBarGO:SetActiveLocal(true)
        self.mMonStunBar2GO:SetActiveLocal(false)
        self.mMonStunBar.fillAmount = self.m_liveVo:getAtt(AttConst.STUN) * 1 / self.m_liveVo:getAtt(AttConst.STUN_MAX)
    end

    -- self.m_rageBar.fillAmount = self.m_liveVo:getAtt(AttConst.MP) * 1 / self.m_liveVo:getAtt(AttConst.MP_MAX)
    if (self.m_liveVo:getAtt(AttConst.SHIELD) > 0) then
        self.mRoleShieldBarBgGO:SetActiveLocal(true)
        self.mMonShieldBarBgGO:SetActiveLocal(true)

        -- self.mRoleShieldBar.fillAmount = self.m_liveVo:getAtt(AttConst.SHIELD) * 1 / self.m_liveVo:getAtt(AttConst.SHIELD_MAX)
        gs.TransQuick:SizeDelta01(self.mRoleShieldBarGO.transform, 88 * (self.m_liveVo:getAtt(AttConst.SHIELD) * 1 / self.m_liveVo:getAtt(AttConst.SHIELD_MAX)))
        gs.TransQuick:SizeDelta01(self.mMonShieldBarGO.transform, 88 * (self.m_liveVo:getAtt(AttConst.SHIELD) * 1 / self.m_liveVo:getAtt(AttConst.SHIELD_MAX)))
    else
        self.mRoleShieldBarBgGO:SetActiveLocal(false)
        self.mMonShieldBarBgGO:SetActiveLocal(false)
    end

    self:updateHpSection(self.m_liveVo:getAtt(AttConst.HP), self.m_liveVo:getAtt(AttConst.HP_MAX))
end

function setBuffVisible(self, bVisible)
    if self.mGroupBuff then
        self.mGroupBuff.gameObject:SetActiveLocal(bVisible)
        if bVisible == true then
            self:updateBuffIcon()
        end
    end
end

function updateBuffIcon(self)
    if self.m_isShowing ~= true then return end
    local tmpIcons = self.m_buffIcons
    self.m_buffIcons = {}
    local tmpOtherIcons = self.m_otherIcons
    self.m_otherIcons = {}

    self.mImgOmitBg.gameObject:SetActive(false)

    local buffQueue = BuffHandler:getAllBuff(self.m_liveVo:getLiveID())
    --print("updateBuffIcon 000000===", self.m_liveVo:getModelID(), table.empty(buffQueue))
    if buffQueue then
        -- local buffMsg = ""
        for i, v in ipairs(buffQueue) do
            -- buffMsg = buffMsg..string.format("[%d] ", v:getRefID())
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

                    if StorageUtil:getBool1(gstor.FIGHT_HIDE_INFO) then
                        if #buffQueue > 4 and #self.m_buffIcons >= 3 then
                            self.mImgOmitBg:SetSiblingIndex(4)
                            self.mImgOmitBg.gameObject:SetActive(true)
                            break
                        end
                    end
                end
                --print("updateBuffIcon===", v:getRefID(), tostring(buffRo:getIsShow()))
                -- 加其它数据图标
                if buffRo:getIsShow() == 1 then
                    local bdata = self.m_liveVo:getBuffData(v:getRefID())
                    -- print("updateBuffIcon=2222222==", v:getRefID(), tostring(buffRo:getIsShow()), tostring(bdata[2]))
                    for i = 1, bdata[2] do
                        local go = tmpOtherIcons[1]
                        if not go then
                            go = gs.ResMgr:LoadGO(UrlManager:getUIPrefabPath("fight/liveui/FightOtherIcon.prefab"))
                            if go then
                                go.transform:SetParent(self.mGroupOther, false)
                            end
                        else
                            table.remove(tmpOtherIcons, 1)
                        end
                        if go then
                            table.insert(self.m_otherIcons, go)
                        end
                    end
                end
            end
        end
        -- print(self.m_liveVo:getLiveID(), " 当前buff ", buffMsg)
    end
    for _, v in ipairs(tmpIcons) do
        v:destroy()
    end
    for _, go in ipairs(tmpOtherIcons) do
        gs.GameObject.Destroy(go)
    end
end

-- 更新弱点格子
function updateWeak(self)
    self:recoverWeakList()
    if self.m_liveVo:getRaceType() == 1 then
        local monsterVo = self.m_liveVo:getOrgData()
        for i = 1, #monsterVo.weak_point do
            local item = SimpleInsItem:create(self:getChildGO("GroupWeakItem"), self.mGroupWeak, "HeadAreaItemWeakItem")
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
function showWeakBreak(self, type)
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

-- 更新血条阶段
function createHpSection(self)
    self:recoverHpSectionList()
    if self.m_liveVo:getRaceType() == 1 then
        local monsterVo = self.m_liveVo:getRaceVo()
        for i = 1, #monsterVo.hpSection do
            local rate = monsterVo.hpSection[i]
            local item = SimpleInsItem:create(self:getChildGO("GroupMonHpSectionItem"), self.mGroupMonHpSection, "HeadAreaItemHpSectionItem")
            gs.TransQuick:LPosX(item:getTrans(), -self.mGroupMonHpSection.rect.width * (rate / 100))
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
    if self.m_liveVo:getRaceType() == 1 and table.nums(self.mHpSectionHash) > 0 then
        local monsterVo = self.m_liveVo:getRaceVo()
        for i = 1, #monsterVo.hpSection do
            local rate = monsterVo.hpSection[i]
            if (1 - (hp / hpMax)) >= (rate / 100) then
                local item = self.mHpSectionHash[rate]
                if item then
                    item:poolRecover()
                    self.mHpSectionHash[rate] = nil
                end
            end
        end
    end
end

-- 战斗单位所在列数
function getColumn(self)
    local col = string.sub(self.m_liveVo:getGridID(), 3, 3)
    return tonumber(col)
end

function update(self)
    if self.m_point and not gs.GoUtil.IsTransNull(self.m_point) and self.m_parent and self.m_rTrans and gs.CameraMgr:IsInSCCamera(self.m_point) then
        -- print("showArea 444444444")
        -- 修正因为镜头俯角导致血条偏低问题
        local targetNum = self:getColumn()
        local offsetY = 10
        if targetNum == 1 then
            offsetY = 25
        elseif targetNum == 2 then
            offsetY = 15
        end
        gs.CameraMgr:World2UIOffset(self.m_point, self.m_parent, self.m_rTrans, 0, offsetY)
        gs.TransQuick:LPosZ(self.m_rTrans, 0)
    else
        -- print("showArea 555555555555")
        gs.TransQuick:UIPos(self.m_rTrans, -9999, -9999)
    end
end

return _M

--------------[[ 替换语言包自动生成，请勿修改！]]    