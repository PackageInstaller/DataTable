module("hero.HeroSkillUpSucPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("hero/success/HeroSkillUpSucPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    -- self:setSize(0, 0)
    self:setTxtTitle("")
end

-- 初始化数据
function initData(self)
    self.mHeroVo = nil
    self.mSkillId = nil
    self.mSkillLvl = nil

    self.tween1Time = 0.6
    self.tween2Time = 0.6

    self.twenn1_pos = nil
    self.tween2_pos = nil
end

function configUI(self)
    super.configUI(self)
    
    self.mTextTitle_1 = self:getChildGO("TextTitle_1"):GetComponent(ty.Text)
    self.mTextTitle_2 = self:getChildGO("TextTitle_2"):GetComponent(ty.Text)

    self.mGroupOld = self:getChildGO("GroupOld")
    self.mGroupOld:SetActive(false)
    self.mRectOld = self.mGroupOld:GetComponent(ty.RectTransform)
    self.mTextOldSkillDes = self:getChildGO("TextOldSkillDes"):GetComponent(ty.Text)
    self.mTextOldSkillLvl = self:getChildGO("TextOldSkillLvl"):GetComponent(ty.Text)
    self.mGroupActiveSkillItem_1 = self:getChildGO("GroupActiveSkillItem_1")
    
    self.mGroupCur = self:getChildGO("GroupCur")
    self.mGroupCur:SetActive(false)
    self.mRectCur = self.mGroupCur:GetComponent(ty.RectTransform)
    self.mTextCurSkillDes = self:getChildGO("TextCurSkillDes"):GetComponent(ty.Text)
    self.mTextCurSkillLvl = self:getChildGO("TextCurSkillLvl"):GetComponent(ty.Text)
    self.mGroupActiveSkillItem_2 = self:getChildGO("GroupActiveSkillItem_2")
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

function initViewText(self)
    self.mTextTitle_1.text = _TT(1299)
    self.mTextTitle_2.text = _TT(1299)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mGroupActiveSkillItem_1, self.__onSkillTipHandler)
    self:addUIEvent(self.mGroupActiveSkillItem_2, self.__onSkillTipHandler)
end

function getOpenSoundPath(self)
    return UrlManager:getUIBaseSoundPath("ui_upgrade.prefab")
end

function __onSkillTipHandler(self)
    TipsFactory:skillTips(nil, self.mSkillId, self.mHeroVo)
end

function setData(self, args)
    self.mHeroVo = args.heroVo
    self.mSkillId = args.skillId
    self.mSkillLvl = args.skillLvl

    self:__updateSkillItem(self.mGroupActiveSkillItem_1, self.mHeroVo, self.mSkillId, self.mSkillLvl - 1, false)
    self:__updateSkillItem(self.mGroupActiveSkillItem_2, self.mHeroVo, self.mSkillId, self.mSkillLvl, true)

    self:__updateOldSkillLvl()
    LoopManager:addTimer(self.tween1Time, 1, self, self.__updateCurSkillLvl)
end

function __updateOldSkillLvl(self)
    local defY = self.mRectOld.anchoredPosition.y
    gs.TransQuick:UIPosY(self.mRectOld, defY + 100)
    self.twenn1_pos = TweenFactory:move2LPosY(self.mRectOld, defY, self.tween1Time, gs.DT.Ease.OutQuad)

    self.mGroupOld:SetActive(true)
    self.mGroupCur:SetActive(false)
end

function __updateCurSkillLvl(self)
    local defY = self.mRectCur.anchoredPosition.y
    gs.TransQuick:UIPosY(self.mRectCur, defY + 100)
    self.tween2_pos = TweenFactory:move2LPosY(self.mRectCur, defY, self.tween2Time, gs.DT.Ease.OutQuad)
    
    self.mGroupCur:SetActive(true)
end

function __updateSkillItem(self, skillItemGo, heroVo, skillId, skillLvl, isCur)
    local childGos, childTrans = GoUtil.GetChildHash(skillItemGo)

    local skillVo = fight.SkillManager:getSkillRo(skillId)

    local skillUpVo = hero.HeroSkillUpManager:getSkillUpConfigVo(heroVo.tid, skillId, skillLvl)
    childGos['ImgSkill']:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), true)
    childGos['TextSkillLvl']:GetComponent(ty.Text).text =  "Lv."..skillLvl
    
    -- if(skillVo:getType() == fight.FightDef.SKILL_TYPE_ACTIVE_SKILL)then     -- 主动技能
    --     childGos['ImgSkillCost']:SetActive(true)
    --     childGos['TextSkillCost']:GetComponent(ty.Text).text = skillVo:getCost()
    -- elseif(skillVo:getType() == fight.FightDef.SKILL_TYPE_AOYI_SKILL)then   -- 奥义技能
    --     childGos['ImgSkillCost']:SetActive(false)
    --     childGos['TextSkillCost']:GetComponent(ty.Text).text = ""
    -- end

    if(isCur)then
        self.mTextCurSkillDes.text = skillUpVo.skillDes
        self.mTextCurSkillLvl.text = skillLvl
    else
        self.mTextOldSkillDes.text = skillUpVo.skillDes
        self.mTextOldSkillLvl.text = skillLvl
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1299):	"升级成功"
	语言包: _TT(1299):	"升级成功"
]]
