module("tips.SkillTipsNew", Class.impl(tips.BaseTips))

UIRes = UrlManager:getUIPrefabPath("tips/SkillTipsNew.prefab")

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
    self.mSkillGrid = nil
    self.mSkillData = {}
end

--初始化UI
function configUI(self)
    super.configUI(self)

    self.mGroupTop = self:getChildGO("GroupTop")
    self.mRectTop = self.mGroupTop:GetComponent(ty.RectTransform)
    self.mImgSkill = self:getChildGO("ImgSkill"):GetComponent(ty.AutoRefImage)
    self.mSkillGridNode = self:getChildTrans('SkillGridNode')
    self.mTextActive = self:getChildGO("TextActive"):GetComponent(ty.Text)
    self.mTextSkillName = self:getChildGO("TextSkillName"):GetComponent(ty.Text)
    self.mTextSkillLv = self:getChildGO("TextSkillLv"):GetComponent(ty.Text)
    self.mImgSkillType = self:getChildGO("mImgSkillType"):GetComponent(ty.Image)
    self.mTxtSkillType = self:getChildGO("mTxtSkillType"):GetComponent(ty.Text)

    self.mGoLock = self:getChildGO("GoLock")
    self.mImgSkillFormation = self:getChildGO("mImgSkillFormation"):GetComponent(ty.AutoRefImage)
    self.mTxtCostNum = self:getChildGO("mTxtCostNum"):GetComponent(ty.Text)

    -- self.mGroupBottom = self:getChildGO("GroupBottom")
    -- self.mRectBottom = self.mGroupBottom:GetComponent(ty.RectTransform)
    self.mRectDes = self:getChildGO("TextSkillDes"):GetComponent(ty.RectTransform)

    self.mTextSkillDes = self:getChildGO("TextSkillDes"):GetComponent(ty.TMP_Text)
    self.TextSkillDesLink = self:getChildGO("TextSkillDes"):GetComponent(ty.TextMeshProLink)
    self.TextSkillDesLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)
end

function active(self, args)
    super.active(self, args)
    self.mSkillId = args.skillId
    if args.skillData then
        for k, v in pairs(args.skillData) do
            table.insert(self.mSkillData, v / 100)
        end
        -- self.mSkillData = tonumber(args.skillData.preValue) / 100
    end
    self.mHeroVo = args.heroVo
    self:__updateView()
end

--非激活
function deActive(self)
    super.deActive(self)
    if(self.mSkillGrid)then
        self.mSkillGrid:poolRecover()
        self.mSkillGrid = nil
    end
end

function initViewText(self)
    super.initViewText(self)
end

function __updateView(self)
    local skillVo = fight.SkillManager:getSkillRo(self.mSkillId)
    local skillType = skillVo:getType()
    local skillSubType = skillVo:getSubType()

    if(self.mSkillGrid)then
        self.mSkillGrid:poolRecover()
        self.mSkillGrid = nil
    end
    local gridCallBack = function()
        if self.mSkillGrid then
            self.mSkillGrid:setCostShow(false)
        end
    end

    local extraLv = 0
    if self.mHeroVo.getExtraLv ~= nil then
        self.mHeroVo:getExtraLv(skillVo:getRefID())
    end
    local PassiveSkill = 1
    if self.mHeroVo.getActivePassiveSkill ~= nil then
        PassiveSkill = self.mHeroVo:getActivePassiveSkill(skillVo:getRefID())
    end
    local skillLv = PassiveSkill + extraLv
    if self.mHeroVo.getActiveSkill ~= nil and self.mHeroVo:getActiveSkill(skillVo:getRefID()) then
        skillLv = self.mHeroVo:getActiveSkill(skillVo:getRefID()) + extraLv
    end

    self.mSkillGrid = SkillGrid:create(self.mSkillGridNode, {skillId = self.mSkillId, heroVo = self.mHeroVo, skillLv = skillLv}, 1, true, gridCallBack)

    local activeStr = ""
    if (skillType == fight.FightDef.SKILL_TYPE_ACTIVE_SKILL or skillType == fight.FightDef.SKILL_TYPE_FINAL_SKILL) then
        local needColor = hero.HeroColorUpManager:getColorByHeroTidAndSkillId(self.mHeroVo.tid, self.mSkillId)
        if(needColor ~= nil and self.mHeroVo.color < needColor)then
            activeStr = string.substitute(_TT(1160), hero.getColorName(needColor)) -- 品质达{0}解锁
        end
    elseif(skillType == fight.FightDef.SKILL_TYPE_PASSIVE_SKILL)then
        if(skillSubType == fight.FightDef.PASSIVE_SKILL_SUB_TYPE_STAR)then
            local needStar = hero.HeroStarManager:getHeroSkillStarLvl(self.mHeroVo.tid, self.mSkillId)
            local evolutionLvl = self.mHeroVo.evolutionLvl or 0
            if(needStar ~= nil and evolutionLvl < needStar)then
                local double = needStar / 2
                local single = needStar % 2
                local res = ""
                for i = 1, double do
                    res = res.."★"
                end
                for j = 1, single do
                    res = res.."☆"
                end
                activeStr = string.substitute(_TT(1161), res) -- 星级达{0}解锁
            end
        elseif(skillSubType == fight.FightDef.PASSIVE_SKILL_SUB_TYPE_MILITAY)then
            local militaryRankConfigVo = hero.HeroMilitaryRankManager:getVoByHeroTidAndUnLockSkillId(self.mHeroVo.tid, self.mSkillId)
            if (militaryRankConfigVo and self.mHeroVo.militaryRank < militaryRankConfigVo.lvl) then
                activeStr = string.substitute("(" .. _TT(1173) .. ")", militaryRankConfigVo:getName()) -- 军阶达{0}解锁
            end
        end
    end

    self.mImgSkill:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), true)
    self.mTextActive.text = "" --activeStr 屏蔽不显示了
    self.mTextSkillName.text = skillVo:getName()

    self.mTextSkillLv.text = "Lv."..skillLv
    if(skillVo:getRoundCd() == 0) then
        self.mTxtCostNum.text = "无"
    else
        self.mTxtCostNum.text = skillVo:getRoundCd() .. "回合"
    end
    -- self.mTxtSkillType.text = skillVo.type

    -- self.mImgSkillType.color = gs.ColorUtil.GetColor("1ca845ff")
    self.mImgSkillFormation.gameObject:SetActive(not (skillVo:getScope() == 0))
    self.mImgSkillFormation:SetImg(UrlManager:getHeroSkillRangeIconUrl(skillVo:getScope()), true)
    -- type
    -- self.mGoLock:SetActive(activeStr ~= "")
    local skillUpVo = hero.HeroSkillUpManager:getSkillUpConfigVo(self.mHeroVo.tid, self.mSkillId, 1)
    local desc = nil
    if not skillUpVo then
        desc = fight.SkillManager:getHeroSkillDesc(self.mSkillId, self.mHeroVo)
    else
        desc = skillUpVo.skillDes
    end
    -- self.mTextSkillDes.text = desc
    self.mTextSkillDes.text = string.substituteArr(desc, self.mSkillData)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
