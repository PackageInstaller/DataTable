module("SkillGrid", Class.impl(BaseComponent))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("commonGrid/SkillGrid.prefab")

function __initData(self)
    super.__initData(self)
    -- 一些常用的脚本
    self.mImgSkillBg = nil
    self.mImgSkill = nil
    self.mGoSkillCost = nil
    self.mTextSkillCost = nil
    self.mGoSkillLvl = nil
    self.mTextSkillLvl = nil
    self.mImgSkillDefine = nil
    self.mTextSkillDefine = nil
    self.mTxtName = nil
    self.mImgName = nil
    self.mImgLock = nil
    self.mIsShowGroupDetail = true
    --------------------------------------------- 数据源 self.m_data 为 {skillVo, heroVo} ---------------------------------------------
end

-- 创建技能格子
function create(self, parent, cusData, cusScale, cusIsAsyn, finishCall)
    local item = self:poolGet()
    item:setData({skillVo = fight.SkillManager:getSkillRo(cusData.skillId), heroVo = cusData.heroVo, skillLv = cusData.skillLv}, cusIsAsyn, finishCall)
    item:setParent(parent)
    item:setScale(cusScale)
    return item
end

function __updateCustomView(self)
    self:setIsUnLockVisible(false)
    self:setNameVisible(false)
    if (self.m_isLoadFinish) then
        self.mImgLock = self.mImgLock or self.m_childGos["mImgLock"]
        self.mImgName = self.mImgName or self.m_childGos["mImgName"]
        self.mGoSkillLvl = self.mGoSkillLvl or self.m_childGos["ImgSkillLvl"]
        self.mGoSkillCost = self.mGoSkillCost or self.m_childGos["ImgSkillCost"]
        self.mTxtName = self.mTxtName or self.m_childGos["mTxtName"]:GetComponent(ty.Text)
        self.mImgSkill = self.mImgSkill or self.m_childGos["ImgSkill"]:GetComponent(ty.AutoRefImage)
        self.mTextSkillLvl = self.mTextSkillLvl or self.m_childGos["TextSkillLvl"]:GetComponent(ty.Text)
        self.mImgSkillBg = self.mImgSkillBg or self.m_childGos["ImgSkillBg"]:GetComponent(ty.AutoRefImage)
        self.mTextSkillCost = self.mTextSkillCost or self.m_childGos["TextSkillCost"]:GetComponent(ty.Text)
        self.mImgSkillDefine = self.mImgSkillDefine or self.m_childGos["ImgSkillDefine"]:GetComponent(ty.Image)
        self.mTextSkillDefine = self.mTextSkillDefine or self.m_childGos["TextSkillDefine"]:GetComponent(ty.Text)
        self.m_childGos["GroupDetail"]:SetActive(self.mIsShowGroupDetail)
        local heroVo = self:getData().heroVo
        local skillVo = self:getData().skillVo
        local skillType = skillVo:getType()
        local skillSubType = skillVo:getSubType()
        self.mTxtName.text = skillVo:getName()
        self.mImgSkill:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), true)

        -- local skillLv = self:getData().skillLv
        -- if skillLv then
        --     self.mGoSkillLvl:SetActive(true)
        --     self.mTextSkillLvl.text = "" .. skillLv
        -- else
            self.mGoSkillLvl:SetActive(false)
        --     self.mTextSkillLvl.text = ""
        -- end

        if (#skillVo:getLocation() >= 2) then
            self.mImgSkillDefine.color = gs.ColorUtil.GetColor(skillVo:getLocation()[1])
            self.mTextSkillDefine.text = _TT(skillVo:getLocation()[2])
        else
            self.mImgSkillDefine.color = gs.ColorUtil.GetColor("FFFFFF00")
            self.mTextSkillDefine.text = ""
        end
        self.mImgSkillDefine.gameObject:SetActive(false) -- 不显示
        if (skillType == fight.FightDef.SKILL_TYPE_NORMAL_ATTACK) then -- 普攻技能
            self.mGoSkillCost:SetActive(false)
            self.mTextSkillCost.text = ""
            self.mImgSkillBg:SetImg(UrlManager:getCommon5Path("common_0055.png"), true)
        elseif (skillType == fight.FightDef.SKILL_TYPE_ACTIVE_SKILL or skillType == fight.FightDef.SKILL_TYPE_FINAL_SKILL) then -- 主动技能
            self.mGoSkillCost:SetActive(skillVo:getCost() > 0)
            self.mTextSkillCost.text = skillVo:getCost()
            self.mImgSkillBg:SetImg(UrlManager:getCommon5Path("common_0055.png"), true)
        elseif (skillType == fight.FightDef.SKILL_TYPE_AOYI_SKILL) then -- 奥义技能
            self.mGoSkillCost:SetActive(false)
            self.mTextSkillCost.text = ""
            self.mImgSkillBg:SetImg(UrlManager:getCommon5Path("common_0055.png"), true)
        elseif (skillType == fight.FightDef.SKILL_TYPE_PASSIVE_SKILL) then -- 被动技能
            if (skillSubType == fight.FightDef.PASSIVE_SKILL_SUB_TYPE_STAR) then -- 潜能技能
                self.mGoSkillCost:SetActive(false)
                self.mTextSkillCost.text = ""
                self.mImgSkillBg:SetImg(UrlManager:getCommon5Path("common_0055.png"), true)
            elseif (skillSubType == fight.FightDef.PASSIVE_SKILL_SUB_TYPE_MILITAY) then -- 军阶技能
                self.mGoSkillCost:SetActive(false)
                self.mTextSkillCost.text = ""
                self.mImgSkillBg:SetImg(UrlManager:getCommon5Path("common_0055.png"), true)
            end
        elseif (skillType == fight.FightDef.SKILL_TYPE_FORCES) then
            self.mGoSkillCost:SetActive(skillVo:getCost() > 0)
            self.mTextSkillCost.text = skillVo:getCost()
            self.mImgSkillBg:SetImg(UrlManager:getPackPath("covenant/covenant_23.png"), true)
        else
            self.mGoSkillCost:SetActive(false)
            self.mTextSkillCost.text = ""
            self.mImgSkillBg:SetImg(UrlManager:getCommon4Path("common_1429.png"), true)

            Debug:log_error("SkillGrid", "没有对应技能类型" .. skillType)
        end
    end
end

function setCostShow(self, show)
    self.mGoSkillCost:SetActive(show)
end

function __initGo(self)
    local rect = self.m_uiGo:GetComponent(ty.RectTransform)
    gs.TransQuick:UIPos(rect, 0, 0, 0)
    gs.TransQuick:Anchor(rect, 0.5, 0.5, 0.5, 0.5)
    gs.TransQuick:Scale(rect, 1, 1, 1)
    local width, height = self:getSize()
    gs.TransQuick:SizeDelta(rect, width, height)
end

function __removeEventList(self)
end

function __addEventList(self)
end

-- 点击默认触发
function __onDefaultClickHandler(self)
    local heroVo = self:getData().heroVo
    local skillVo = self:getData().skillVo
    local skillType = skillVo:getType()
    local skillSubType = skillVo:getSubType()
    -- if (skillType ~= fight.FightDef.SKILL_TYPE_NORMAL_ATTACK) then
    TipsFactory:skillTips(nil, skillVo:getRefID(), heroVo, false)
    -- end
end

-- 取图标矩
function getIconRect(self)
    return self.m_childTrans["ImgSkill"]:GetComponent(ty.RectTransform)
end

function getSize(self)
    return 124, 124
end

function setIsUnLockVisible(self, visible)
    if (self.m_isLoadFinish) then
        self.m_childGos["mImgLock"]:SetActive(visible)
    end
end

function setNameVisible(self, visible)
    if (self.m_isLoadFinish) then
        self.m_childGos["mImgName"]:SetActive(visible)
    end
end

function setDetailVisible(self, visible)
    self.mIsShowGroupDetail = visible
    if (self.m_isLoadFinish) then
        self.m_childGos["GroupDetail"]:SetActive(visible)
    end
end

return _M
