--[[   
     战斗UI  盟约技能item
]]
module('fightUI.FightForcesSkillItem', Class.impl('lib.component.BaseNode'))

local SKILL_CD_TOTAL_TIME = 0.2

function initData(self, rootGo)
    super.initData(self, rootGo)
    self:addOnClick(self.m_go, self.onSkillClick)

    self.mImgIcon = self:getChildGO('mImgIcon'):GetComponent(ty.AutoRefImage)
    self.mImgIconBg = self:getChildGO('mImgIconBg'):GetComponent(ty.AutoRefImage)

    self.mImgMask = self:getChildGO('mImgMask')
    -- self.mImgMask:SetActiveLocal(false)

    self.mImgCd = self:getChildGO('mImgCd'):GetComponent(ty.AutoRefImage)
    self.mStorage = self:getChildGO('mStorage'):GetComponent(ty.Image)

    self.mGroupEff = self:getChildTrans("mGroupEff")
end

-- 点击释放技能
function onSkillClick(self)
    if self.mCallBack then
        self.mCallBack(self.mCallObject, self.mSkillRo)
    end
    if self.mSkillRo and fight.FightManager:getForcesSkillEnergy() >= self.mSkillRo:getCost() then
        if not self.clickEfx then
            self.clickEfx = self:addEffect("fx_ui_common_player_skill_click", self.mGroupEff)
        else
            self.clickEfx.effectGo:SetActive(false)
            self.clickEfx.effectGo:SetActive(true)
        end
    end
end

-- 设置技能数据
function setSkillData(self, skillRo)
    self.mSkillRo = skillRo
    self:setSkillIcon()
end

-- 设置技能图标
function setSkillIcon(self)
    local path = UrlManager:getIconPath("skill/" .. self.mSkillRo:getIcon())
    self.mImgIcon:SetImg(path, false)
    self.mImgIconBg:SetImg(path, false)
end

-- 设置技能点击回调
function setSkillCall(self, callObject, callBack)
    self.mCallObject = callObject
    self.mCallBack = callBack
end

-- 更新状态
function updateState(self)
    if not self.mSkillRo then
        return
    end
    -- if fight.FightManager:getForcesSkillEnergy() >= self.mSkillRo:getCost() then
    --     self.mImgMask:SetActiveLocal(false)
    -- else
    --     self.mImgMask:SetActiveLocal(true)
    -- end
    local val = fight.FightManager:getForcesSkillEnergy() / self.mSkillRo:getCost()

    self.mImgCd.fillAmount = 1 - val
    self.mStorage.fillAmount = val

    if val >= 1 then
        if not self.isShowEff then
            self.isShowEff = true
            self:addEffect("fx_ui_common_player_skill", self.mGroupEff)
        end
    else
        if self.isShowEff then
            self.isShowEff = false
            self:removeEffect("fx_ui_common_player_skill")
        end
    end


    -- if not self.mSkillCdMaskH then
    --     self.mSkillCdMaskH = self.mImgMask.transform.rect.height
    -- end
    --  gs.TransQuick:SizeDelta02(self.mImgMask.transform, self.mSkillCdMaskH * val)

end

-- 移除
function destroy(self)
    self:removeOnClick(self.m_go)
    self:removeEffect("fx_ui_common_player_skill")
    RateLooper:removeFrameByIndex(self.m_skillCDSn)

    super.destroy(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]