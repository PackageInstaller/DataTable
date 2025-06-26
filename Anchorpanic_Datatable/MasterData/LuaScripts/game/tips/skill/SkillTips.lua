--[[ 
-----------------------------------------------------
@filename       : SkillTips
@Description    : 战员多技能tips
@date           : 2021-03-22 16:59:42
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("tips.SkillTips", Class.impl(tips.BaseTips))

UIRes = UrlManager:getUIPrefabPath("tips/SkillTips.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1275, 549)
end

--析构函数
function dtor(self)
    super.dtor(self)
end

-- 初始化数据
function initData(self)
    self.m_instance = nil
    self.m_skillIdList = nil
    self.m_skillId = nil
    self.m_heroVo = nil
    self.m_skillItemList = {}
end

--初始化UI
function configUI(self)
    super.configUI(self)

    self.m_skillSelectContent = self.m_childTrans['SkillSelectContent']
    self.m_textPreviewTitle = self.m_childTrans['TextPreviewTitle']:GetComponent(ty.Text)
    self.m_textPreviewTitleEn = self.m_childTrans['TextPreviewTitleEn']:GetComponent(ty.Text)

    self.m_groupCost = self:getChildGO('GroupCost')
    self.m_textCostTip = self.m_childTrans['TextCostTip']:GetComponent(ty.Text)
    self.m_textCurSkillTitle = self.m_childTrans['TextCurSkillTitle']:GetComponent(ty.Text)
    self.m_imgCurSkillTitle = self.m_childTrans['ImgCurSkillTitle']:GetComponent(ty.AutoRefImage)
    self.m_textNextSkillTitle = self.m_childTrans['TextNextSkillTitle']:GetComponent(ty.Text)

    self.m_textCost = self.m_childTrans['TextCost']:GetComponent(ty.Text)
    self.mTxtName = self.m_childTrans['TextName']:GetComponent(ty.Text)

    self.m_textDes_1 = self.m_childTrans['TextDes_1']:GetComponent(ty.Text)
    self.m_textDes_2 = self.m_childTrans['TextDes_2']:GetComponent(ty.Text)
    self.m_imgNextSkillTitle = self:getChildTrans('ImgNextSkillTitle')

    self.m_imgPreview = self:getChildGO('ImgPreview')

    for i = 1, 4 do
        local item = nil
        if i <= 2 then
            item = gs.GameObject.Instantiate(self:getChildGO("SkillLeftItem"))
        elseif i <= 4 then
            item = gs.GameObject.Instantiate(self:getChildGO("SkillExItem"))
        end
        item.transform:SetParent(self.m_skillSelectContent, false)
        item:SetActive(true)
        table.insert(self.m_skillItemList, item)

        self:addOnClick(item, function()
            self:onSelectSkill(i)
        end)
    end
end

function active(self, args)
    super.active(self, args)
    self.m_skillIdList = args.skillIdList
    self.m_skillId = args.skillId
    self.m_heroVo = args.heroVo

    self:__updateView()
end

function deActive(self)
    super.deActive(self)
end

function initViewText(self)
    self.m_textPreviewTitle.text = _TT(27012)--"技能演示"
    self.m_textPreviewTitleEn.text = _TT(27013)--"DEMONSTRATION"
    self.m_textCostTip.text = _TT(27014)--"电量消耗"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.m_imgPreview, self.__onClickPreviewHandler)
end

function __updateView(self)
    self:__updateLeftSkillIconList()
    self:__updateSkillDes()
end

function __updateSkillDes(self)
    local skillVo = fight.SkillManager:getSkillRo(self.m_skillId)
    local strActive = ""
    local needColor = hero.HeroColorUpManager:getColorByHeroTidAndSkillId(self.m_heroVo.tid, self.m_skillId)
    if(needColor ~= nil and self.m_heroVo.color < needColor)then
        strActive = HtmlUtil:colorAndSize(_TT(4060, hero.getColorName(needColor)), "26d5d3ff", 18)
    end
    self.mTxtName.text = skillVo:getName() .. strActive

    local skillType = skillVo:getType()
    if (skillType == fight.FightDef.SKILL_TYPE_ACTIVE_SKILL or skillType == fight.FightDef.SKILL_TYPE_FINAL_SKILL) then
        self.m_groupCost:SetActive(true)
        self.m_textCost.text = "x" .. skillVo:getCost()
    else
        self.m_groupCost:SetActive(false)
    end

    self.m_textCurSkillTitle.text = fight.FightDef.GetSkillTypeName(skillType)
    self.m_textDes_1.text = skillVo:getDesc()

    local titleId = skillType == fight.FightDef.SKILL_TYPE_AOYI_SKILL and 3 or 1
    self.m_imgCurSkillTitle:SetImg(UrlManager:getPackPath(string.format("alertView/tips_skill_title_%s.png", titleId)), true)

    local militaryRankConfigVo = hero.HeroMilitaryRankManager:getVoByHeroTidAndSkillId(self.m_heroVo.tid, skillVo:getRefID())
    if (militaryRankConfigVo) then
        self.m_textDes_2.gameObject:SetActive(true)
        self.m_imgNextSkillTitle.gameObject:SetActive(true)

        local strengthSkillVo = fight.SkillManager:getSkillRo(militaryRankConfigVo.unlockSkillId)
        if (self.m_heroVo.militaryRank >= militaryRankConfigVo.lvl) then
            self.m_textDes_2.text = strengthSkillVo:getDesc()
            self.m_textNextSkillTitle.text = _TT(1340) .. militaryRankConfigVo:getName()
        else
            self.m_textDes_2.text = strengthSkillVo:getDesc()
            self.m_textNextSkillTitle.text = _TT(1340) .. militaryRankConfigVo:getName() .. HtmlUtil:color(_TT(4066), "264dd5ff")
        end

        self.m_textNextSkillTitle:GetComponent(ty.ContentSizeFitter):SetLayoutHorizontal()
        gs.LayoutRebuilder:ForceRebuildLayoutImmediate(self.m_textNextSkillTitle.transform)
        self.m_imgNextSkillTitle:GetComponent(ty.ContentSizeFitter):SetLayoutHorizontal()
        gs.LayoutRebuilder:ForceRebuildLayoutImmediate(self.m_imgNextSkillTitle)
    else
        self.m_textDes_2.gameObject:SetActive(false)
        self.m_imgNextSkillTitle.gameObject:SetActive(false)
    end
end

-- 更新左侧技能列表
function __updateLeftSkillIconList(self)
    self.skillVoList = {}
    for i, v in ipairs(self.m_skillIdList) do
        local skillVo = fight.SkillManager:getSkillRo(v)
        table.insert(self.skillVoList, skillVo)
    end
    table.sort(self.skillVoList, function(a, b)
        return a:getType() < b:getType()
    end)

    -- self.exSkillVo = nil
    for i, item in ipairs(self.m_skillItemList) do
        local skillVo = self.skillVoList[i]
        local icon = item.transform:Find("ImgSelectSkillIcon"):GetComponent(ty.AutoRefImage)
        local selectIcon = item.transform:Find("ImgSelect")
        local noIcon = item.transform:Find("ImgNo")

        icon.gameObject:SetActive(false)
        selectIcon.gameObject:SetActive(false)
        noIcon.gameObject:SetActive(true)

        if skillVo then
            icon.gameObject:SetActive(true)
            icon:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), true)
            noIcon.gameObject:SetActive(false)
        end

        if skillVo and self.m_skillId == skillVo:getRefID() then
            selectIcon.gameObject:SetActive(true)
        end
    end
end

-- 选中技能
function onSelectSkill(self, index)
    local item = nil
    local selectIcon = nil
    local skillVo = self.skillVoList[index]
    if index ~= #self.m_skillItemList and not skillVo then
        return
    end

    for i, item in ipairs(self.m_skillItemList) do
        selectIcon = item.transform:Find("ImgSelect")
        selectIcon.gameObject:SetActive(false)
    end

    local skillVo = self.skillVoList[index]
    item = self.m_skillItemList[index]
    selectIcon = item.transform:Find("ImgSelect")
    selectIcon.gameObject:SetActive(true)
    self.m_skillId = skillVo:getRefID()

    self:__updateSkillDes()
end

function __onClickPreviewHandler(self)
    gs.Message.Show(_TT(71316))
end

-- 在资源销毁前，对需要回收的资源进行回收处理
function recover(self)
    super.recover(self)
    self:initData()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(4066):	"(未解锁)"
	语言包: _TT(1340):	"军阶-"
	语言包: _TT(1340):	"军阶-"
	语言包: _TT(71316):	"敬请期待"
]]
