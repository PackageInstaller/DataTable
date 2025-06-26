--[[ 
-----------------------------------------------------
@filename       : SingleSkillTips
@Description    : 单个主动技能tips
@date           : 2021-03-25 17:01:13
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("tips.SingleSkillTips", Class.impl(tips.BaseTips))

UIRes = UrlManager:getUIPrefabPath("tips/SingleSkillTips.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)

    self.gBtnClose:SetActive(false)
    if (self.base_childGos["gImgBg2"]) then
        self.base_childGos["gImgBg2"]:SetActive(false)
    end
    if (self.base_childGos["gImgBg3"]) then
        self.base_childGos["gImgBg3"]:SetActive(false)
    end
end
 -- 
-- 初始化数据
function initData(self)
    self.mNextSkillGrid = nil
end

--初始化UI
function configUI(self)
    super.configUI(self)

    -- self.mGroupRect = self:getChildGO("Group"):GetComponent(ty.RectTransform)
    -- self.mContentRect = self:getChildGO("Content"):GetComponent(ty.RectTransform)

    self.mGroupTop = self:getChildGO("mGroupTop")
    self.mImgCurSkillDefine = self:getChildGO('mImgCurSkillDefine'):GetComponent(ty.Image)
    self.mTextCurSkillDefine = self:getChildGO('mTextCurSkillDefine'):GetComponent(ty.Text)
    self.mTextCurSkillName = self:getChildGO('mTextCurSkillName'):GetComponent(ty.Text)
    self.mTextCurSkillLvl = self:getChildGO('mTextCurSkillLvl'):GetComponent(ty.Text)

    self.mTextCurSkillDes = self:getChildGO("mTextCurSkillDes"):GetComponent(ty.TMP_Text)
    self.mTextCurSkillDesLink = self:getChildGO("mTextCurSkillDes"):GetComponent(ty.TextMeshProLink)
    self.mTextCurSkillDesLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)

    self.mGroupBottom = self:getChildGO("mGroupBottom")
    self.mTextNextSkillTitle = self:getChildGO('mTextNextSkillTitle'):GetComponent(ty.Text)
    self.mTextNextSkillName = self:getChildGO('mTextNextSkillName'):GetComponent(ty.Text)
    self.mTextNextUnLockTip = self:getChildGO('mTextNextUnLockTip'):GetComponent(ty.Text)

    self.mTextNextSkillDes = self:getChildGO("mTextNextSkillDes"):GetComponent(ty.TMP_Text)
    self.mTextNextSkillDesLink = self:getChildGO("mTextNextSkillDes"):GetComponent(ty.TextMeshProLink)
    self.mTextNextSkillDesLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)

    self.mNextSkillGridNode = self:getChildTrans("mNextSkillGridNode")
    self.mImgNextSkillLock = self:getChildGO("mImgNextSkillLock")

    self.mImgSkillIcon = self:getChildGO("mImgSkillIcon"):GetComponent(ty.AutoRefImage)
end

function active(self, args)
    super.active(self, args)

    self.mSkillId = args.skillId
    self.mHeroVo = args.heroVo
    self:__updateView()
end

--非激活
function deActive(self)
    super.deActive(self)
    if (self.mNextSkillGrid) then
        self.mNextSkillGrid:poolRecover()
        self.mNextSkillGrid = nil
    end
end

function initViewText(self)
    super.initViewText(self)
    self.mTextNextSkillTitle.text = _TT(27028)
end

function __updateView(self)
    local skillVo = fight.SkillManager:getSkillRo(self.mSkillId)
    local skillLvl = nil
    local skillUpVo = nil
    if self.mHeroVo.getActiveSkill then
        skillLvl = self.mHeroVo:getActiveSkill(skillVo:getRefID())
    end
    skillUpVo = hero.HeroSkillUpManager:getSkillUpConfigVo(self.mHeroVo.tid, skillVo:getRefID(), skillLvl)
    self.mImgSkillIcon:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()))
    if (#skillVo:getLocation() >= 2) then
        self.mImgCurSkillDefine.color = gs.ColorUtil.GetColor(skillVo:getLocation()[1])
        self.mTextCurSkillDefine.text = _TT(skillVo:getLocation()[2])
    else
        self.mImgCurSkillDefine.color = gs.ColorUtil.GetColor("FFFFFF00")
        self.mTextCurSkillDefine.text = ""
    end
    
    local strActive = ""
    self.mTextCurSkillName.text = skillVo:getName() .. strActive
    self.mTextCurSkillDes.text = skillUpVo:getDesc()

    if (self.mHeroVo and self.mHeroVo.activeSkillDic and self.mHeroVo.activeSkillDic[skillVo:getRefID()]) then
        self.mTextCurSkillLvl.text = "<size=14>Lv.</size>" .. self.mHeroVo.activeSkillDic[skillVo:getRefID()]
    else
        self.mTextCurSkillLvl.text = ""
    end

    local militaryRankConfigVo = hero.HeroMilitaryRankManager:getVoByHeroTidAndSkillId(self.mHeroVo.tid, skillVo:getRefID())
    if (militaryRankConfigVo) then
        self.mGroupBottom:SetActive(true)

        local strengthSkillVo = fight.SkillManager:getSkillRo(militaryRankConfigVo.unlockSkillId)
        self.mTextNextSkillName.text = strengthSkillVo:getName()
        if (self.mHeroVo.militaryRank ~= nil and self.mHeroVo.militaryRank >= militaryRankConfigVo.lvl) then
            self.mTextNextUnLockTip.text = ""
            self.mImgNextSkillLock:SetActive(false)
        else
            self.mTextNextUnLockTip.text = string.substitute(_TT(1173), militaryRankConfigVo:getName())
            self.mImgNextSkillLock:SetActive(true)
        end
        self.mTextNextSkillDes.text = strengthSkillVo:getDesc()
        if (self.mNextSkillGrid) then
            self.mNextSkillGrid:poolRecover()
            self.mNextSkillGrid = nil
        end
        self.mNextSkillGrid = SkillGrid:create(self.mNextSkillGridNode, { skillId = strengthSkillVo:getRefID(), heroVo = self.mHeroVo }, 0.85)
    else
        self.mGroupBottom:SetActive(false)
    end

    -- gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mContentRect) --立即刷新
    -- local h = gs.LayoutUtility.GetPreferredSize(self.mContentRect, 1)
    -- h = math.max(h, 149)
    -- h = math.min(h, 430)
    -- gs.TransQuick:SizeDelta02(self.mGroupRect, h)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27028):	"军阶效果"
]]
