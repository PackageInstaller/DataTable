module("hero.HeroStarUpItem", Class.impl("lib.component.BaseItemRender"))


function onInit(self, go)
    super.onInit(self, go)
    self.mImgSkillTrans = self:getChildTrans("mImgSkillTrans")
    self.mImgSkillDefine = self:getChildGO("mImgSkillDefine")
    self.mSkillName = self:getChildGO("mTxtSkillName"):GetComponent(ty.Text)
    self.mNeedStar = self:getChildGO("mTxtNeedColor"):GetComponent(ty.Text)
    self.mTxtSkillDefine = self:getChildGO("mTxtSkillDefine"):GetComponent(ty.Text)    
    self.mTxtSkillExplain = self:getChildGO("mTxtSkillExplain"):GetComponent(ty.TMP_Text)
    self.mTxtSkillExplainLink = self:getChildGO("mTxtSkillExplain"):GetComponent(ty.TextMeshProLink)
    self.mTxtSkillExplainLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)
end

function initViewText(self)
end

function setData(self, param)
    super.setData(self, param)
    self.heroId = self.data.heroId
    self.heroTid = self.data.heroTid
    if self.heroId then
        self.mHeroVo = hero.HeroManager:getHeroVo(self.heroId)
    else
        self.mHeroVo = hero.HeroManager:getHeroConfigVo(self.heroTid)
    end
    self.heroStar = self.data.star
    self.currentStar = self.data.currentStar
    self.skillId = self.data.skillId
    local skillVo = fight.SkillManager:getSkillRo(self.skillId)
    self.mTxtSkillExplain.text = skillVo:getDesc()
    self.mImgSkillDefine:SetActive(#skillVo:getLocation() >= 2)
    if (#skillVo:getLocation() >= 2) then
        self.mTxtSkillDefine.text = _TT(skillVo:getLocation()[2])
    else
        self.mTxtSkillDefine.text = ""
    end
    if self.mSkillItem ~= nil then
        self.mSkillItem:poolRecover()
    end
    if not self.mSkillItem then
        self.mSkillItem = SkillGrid:create(self.mImgSkillTrans, { skillId = self.skillId, heroVo = self.mHeroVo }, 1, false)
        self.mSkillItem:setDetailVisible(false)
    end
    self.mSkillName.text = skillVo:getName()
    if self.heroStar >= self.currentStar then
        self.mNeedStar.gameObject:SetActive(false)
    else
        self.mNeedStar.gameObject:SetActive(true)
        local curIntegers, curDecimals = math.modf(self.currentStar / 2)
        local s = ""
        for i = 1, curIntegers do
            s = s .. "★"
        end
        if (curDecimals > 0) then
            s = s .. "☆"
        end

        s = _TT(1300, s)
        self.mNeedStar.color = gs.ColorUtil.GetColor("FA4343ff")
        self.mNeedStar.text = s
    end
end

function deActive(self)
    super.deActive(self)
    if self.mSkillItem then
        self.mSkillItem:poolRecover()
        self.mSkillItem = nil
    end
end

function onDelete(self)
    super.onDelete(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1098):	"已解锁"
]]