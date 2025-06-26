module("tips.NormalSkillTipsNew", Class.impl(tips.BaseTips))

UIRes = UrlManager:getUIPrefabPath("tips/NormalSkillTipsNew.prefab")

isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)

    self.gBtnClose:SetActive(false)
    if(self.base_childGos["gImgBg2"])then
        self.base_childGos["gImgBg2"]:SetActive(false)
    end
    if(self.base_childGos["gImgBg3"])then
        self.base_childGos["gImgBg3"]:SetActive(false)
    end
end

-- 初始化数据
function initData(self)
end

--初始化UI
function configUI(self)
    super.configUI(self)
    self.mGroupTop = self:getChildGO("GroupTop")
    self.mRectTop = self.mGroupTop:GetComponent(ty.RectTransform)
    self.mImgSkill = self:getChildGO("ImgSkill"):GetComponent(ty.AutoRefImage)
    self.mTextActive = self:getChildGO("TextActive"):GetComponent(ty.Text)
    self.mTextSkillName = self:getChildGO("TextSkillName"):GetComponent(ty.Text)
    self.mTextSkillType = self:getChildGO("TextSkillType"):GetComponent(ty.Text)
    self.mGoLock = self:getChildGO("GoLock")

    self.mGroupBottom = self:getChildGO("GroupBottom")
    self.mRectBottom = self.mGroupBottom:GetComponent(ty.RectTransform)
    self.mRectDes = self:getChildGO("TextSkillDes"):GetComponent(ty.RectTransform)
    self.TextSkillDes = self:getChildGO("TextSkillDes"):GetComponent(ty.TMP_Text)
    self.TextSkillDesLink = self:getChildGO("TextSkillDes"):GetComponent(ty.TextMeshProLink)
    self.TextSkillDesLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)

    self.mSkillContent = self:getChildTrans("SkillContent")
end

function active(self, args)
    super.active(self, args)
    
    self.mSkillId = args.skillId
    self.mHeroVo = args.heroVo

    self.preValue = args.preValue / 100

    self:__updateView()
end

--非激活
function deActive(self)
    super.deActive(self)
    self:__removeFrameSn()
end

function initViewText(self)
    super.initViewText(self)
end

function __updateView(self)
    local skillVo = fight.SkillManager:getSkillRo(self.mSkillId)
    local skillCost = skillVo:getCost()
    local skillType = skillVo:getType()

    local activeStr = ""
    if (skillType == fight.FightDef.SKILL_TYPE_ACTIVE_SKILL or skillType == fight.FightDef.SKILL_TYPE_FINAL_SKILL) then
        local needColor = hero.HeroColorUpManager:getColorByHeroTidAndSkillId(self.mHeroVo.tid, self.mSkillId)
        if(needColor~= nil and self.mHeroVo.color < needColor)then
            activeStr = _TT(1160, hero.getColorName(needColor))
        end
    elseif(skillType == fight.FightDef.SKILL_TYPE_PASSIVE_SKILL)then
        self:getChildGO("GoLock"):SetActive()
    end

    --self.mImgSkill:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), true)

    

    if self.skillGrid ~=nil then
        self.skillGrid:poolRecover()
    end
    self.skillGrid = SkillGrid:create(self.mSkillContent, {skillId = self.mSkillId, heroVo = self.mHeroVo}, 1)
    
    self.skillGrid:setClickEnable(false)
    
    self.mTextActive.text = activeStr
    self.mTextSkillName.text = skillVo:getName()
    self.mTextSkillType.text = fight.FightDef.GetSkillTypeName(skillType)
    self.mTextSkillDes.text = string.substitute(skillVo:getDesc(),self.preValue)
    self:getChildGO("GoLock"):SetActive(activeStr ~= "")
    
    local h = gs.LayoutUtility.GetPreferredSize(self.mRectDes, 1) + 60  -- 上下间距40 
    h = math.max(h, 149)
    h = math.min(h, 430)
    gs.TransQuick:SizeDelta02(self.mRectBottom, h)
end

function __removeFrameSn(self)
    if (self.mFrameSn) then
        LoopManager:removeFrameByIndex(self.mFrameSn)
        self.mFrameSn = nil
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1160):	"品质达{0}解锁"
]]
