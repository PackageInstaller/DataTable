module("hero.HeroGrowSkillUpSucPanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("hero/success/HeroGrowSkillUpSucPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗


--构造函数
function ctor(self)
    super.ctor(self)
    -- self:setSize(0, 0)
    self:setTxtTitle("")
end


function configUI(self)
    super.configUI(self)

    self.mGroupOld = self:getChildGO("GroupOld")
    self.mGroupOld:SetActive(false)
    self.mRectOld = self.mGroupOld:GetComponent(ty.RectTransform)
    self.mTextOldSkillDes = self:getChildGO("TextOldSkillDes"):GetComponent(ty.Text)
    self.mTextOldSkillLvl = self:getChildGO("TextOldSkillLvl"):GetComponent(ty.Text)
    self.mGroupActiveSkillItem_1 = self:getChildGO("GroupActiveSkillItem_1")
    self.mGroupActiveSkillItem_2 = self:getChildGO("GroupActiveSkillItem_2")
    
    self.mGroupCur = self:getChildGO("GroupCur")
    self.mGroupCur:SetActive(false)
    self.mRectCur = self.mGroupCur:GetComponent(ty.RectTransform)
    self.mTextCurSkillDes = self:getChildGO("TextCurSkillDes"):GetComponent(ty.Text)
    self.mTextCurSkillLvl = self:getChildGO("TextCurSkillLvl"):GetComponent(ty.Text)

end

function active(self, args)
    super.active(self, args)
    self:setData(args)
end

function deActive(self)
    super.deActive(self)
    LoopManager:removeTimer(self, self.__updateCurSkillLvl)
    if self.twenn1_pos then
        self.twenn1_pos:Kill()
    end
    if self.tween2_pos then
        self.tween2_pos:Kill()
    end
end

function setData(self, args)
     
    self.mHeroVo = args.hero_id
    self.mSkillId = args.present_skill_effect[1].skill_id
    self.mSkillLvl = args.present_skill_effect[1].skill_lv
    self.mCurValue = args.present_skill_effect[1].effect_values[1].value / 100
    self.mNextValue = args.next_skill_effect[1].effect_values[1].value / 100
    self.mSkillVo = fight.SkillManager:getSkillRo(self.mSkillId)

    self:__updateSkillItem(self.mGroupActiveSkillItem_1, self.mHeroVo, self.mSkillId, self.mSkillLvl - 1, false)
    self:__updateSkillItem(self.mGroupActiveSkillItem_2, self.mHeroVo, self.mSkillId, self.mSkillLvl, true)
    
    self.mGroupOld:SetActive(true)
    self.mGroupCur:SetActive(true)
end

function initViewText(self)
end

function addAllUIEvent(self)
end

function getOpenSoundPath(self)
    return UrlManager:getUIBaseSoundPath("ui_upgrade.prefab")
end

function __updateSkillItem(self, skillItemGo, heroVo, skillId, skillLvl, isCur)
    local childGos, childTrans = GoUtil.GetChildHash(skillItemGo)

 
    childGos['ImgSkill']:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getSkillIconPath(self.mSkillVo:getIcon()), true)
    childGos['TextSkillLvl']:GetComponent(ty.Text).text =  "Lv."..skillLvl
    
    if(isCur)then
        self.mTextCurSkillDes.text = string.substitute(self.mSkillVo:getDesc(),self.mCurValue)
        self.mTextCurSkillLvl.text = skillLvl
    else
        self.mTextOldSkillDes.text = string.substitute( self.mSkillVo:getDesc(),self.mNextValue)
        self.mTextOldSkillLvl.text = skillLvl
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
