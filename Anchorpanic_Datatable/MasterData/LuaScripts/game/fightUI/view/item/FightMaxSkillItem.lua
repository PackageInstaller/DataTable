--[[   
     战斗UI下方技能区域 技能item
]]
module('fightUI.FightMaxSkillItem', Class.impl(fightUI.FightSkillItem))

function initData(self, rootGo)
    super.initData(self, rootGo)
    self.mImgSkillCdGO = self:getChildGO('mImgSkillCd')
    self.mImgSkillCd = self.mImgSkillCdGO:GetComponent(ty.AutoRefImage)
    self.mStorageGO = self:getChildGO('mStorage')
    self.mStorage = self.mStorageGO:GetComponent(ty.Image)

    -- self.m_skillPowerMask = self:getChildTrans('SkillPowerMask')
end

function setSkillID(self, skillID, liveId)
    super.setSkillID(self, skillID, liveId)
    if skillID ~= nil and self.m_lastSetSkillID ~= skillID then
        self:removeLooper()
    end

    if skillID ~= nil then
        self.m_lastSetSkillID = skillID
    end
end

function setActive(self, isActive)
    super.setActive(self, isActive)
    if not isActive then
        self:removeLooper()
    end
end

-- 获取最大怒气值（就是cd值）
function getMaxRage(self)
    return fight.FightManager:getMaxRage(self.mLiveId)
end

function setCurVal(self, curVal)
    if self.m_stateType == fightUI.FightSkillItemState.LOCK then return end
    if not self.m_go then return end

    -- if self.m_targetVal and self.m_targetVal > 0 and curVal == 0 then
    --     self.mImgSkillIcon:SetGray(true)
    --     if not self.isSelect then
    --         self:addEffect("fx_ui_fight_skill_select", self.m_trans)
    --         self.isSelect = true
    --     end

    --     self.m_targetVal = curVal
    --     self.m_cdCurVal = self.m_targetVal

    --     self:updateEffect()
    --     return
    -- end

    -- if self.m_cdCurVal == curVal then return end
    -- if self.m_targetVal == nil then
    -- self.m_targetVal = curVal
    self.m_cdCurVal = curVal
    self:updateValState()
    -- else
    --     self.m_targetVal = curVal
    --     local v = 10
    --     self.m_tVal = (self.m_targetVal - self.m_cdCurVal) / v
    --     if self.m_skillCDTimeSn then
    --         RateLooper:removeTimerByIndex(self.m_skillCDTimeSn)
    --     end
    --     self.m_skillCDTimeSn = RateLooper:addFrame(1, v, self, self.updateVal)
    -- end
end

function updateVal(self)
    if self.m_stateType == fightUI.FightSkillItemState.LOCK then return end
    self.m_cdCurVal = self.m_cdCurVal + self.m_tVal
    if self.m_cdCurVal == self.m_targetVal then
        self:removeLooper()
    end
    self:updateValState()
end

function updateValState(self)
    if self.m_stateType == fightUI.FightSkillItemState.LOCK then return end
    if not self.m_go then return end
    local val = self.m_cdCurVal / self:getMaxRage()
    self.mStorageGO:SetActive(true)
    if val > 1 then
        val = 1
    elseif val <= 0 then
        val = 0
        self.mStorageGO:SetActive(false)
    end

    self.mImgSkillCd.fillAmount = 1 - val
    self.mStorage.fillAmount = val

    -- self.m_skillPowerMask.fillAmount = 1 - val
    -- if not self.mPowerMaskH then
    --     self.mPowerMaskH = self.m_skillPowerMask.rect.height
    -- end

    -- gs.TransQuick:SizeDelta02(self.m_skillPowerMask, self.mPowerMaskH * val)

    self:updateEffect()
end

function removeLooper(self)
    RateLooper:removeTimerByIndex(self.m_skillCDTimeSn)
    self.m_skillCDTimeSn = nil
    self.m_targetVal = nil
end

function destroy(self)
    self:removeLooper()
    self.isShowEffing = false
    super.destroy(self)
end

function setState(self, stateType)
    super.setState(self, stateType)
    if self.m_stateType == fightUI.FightSkillItemState.LOCK then
        self.mImgSkillCdGO:SetActiveLocal(false)
    end

    self:updateEffect()
end

function _normalState(self)
    if self.isSelect then
        return
    end
    self.mImgSkillIcon:SetGray(false)
    self.mImgSkillIconGo:SetActiveLocal(true)
    self.mImgSoulBgGo:SetActiveLocal(false)
    self.mImgSelect:SetActiveLocal(false)
    self.mImgSkillCdGO:SetActiveLocal(true)
    self.mImgSkillTypeGo:SetActiveLocal(true)
end

-- 播放可释放特效
function showPromptEffect(self)
    -- 奥义不用
end

function updateEffect(self)
    -- 因为存在浮点误差，无法正确比较两个值完全相等  (math.abs(self:getMaxRage() - self.m_cdCurVal) < 0.0001)
    -- print("===============", math.abs(self:getMaxRage() - self.m_cdCurVal))
    if self.m_stateType == fightUI.FightSkillItemState.NORMAL and (math.abs(self:getMaxRage() - self.m_cdCurVal) < 0.0001) then
        if not self.isShowEffing then
            self:addEffect("fx_ui_common_aoyibaofa", self:getChildTrans("mGroupEff"), 0, 0, nil)
            self.isShowEffing = true
        end
    else
        self:removeEffect("fx_ui_common_aoyibaofa", self:getChildTrans("mGroupEff"))
        self.isShowEffing = false
    end
end

-- 显示选择特效
function showSelectEfx(self)
    if not self.isSelect and self.m_stateType == fightUI.FightSkillItemState.NORMAL then
        self:addEffect("fx_ui_fight_skill_select", self:getChildTrans("mGroupEff"))
        self.isSelect = true
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]