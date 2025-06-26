--[[
-----------------------------------------------------
@filename       : SingleHeroInfoView
@Description    : 单英雄介绍
@date           : 2023-5-12 16:58:49
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.role.view.SingleHeroInfoView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("role/SingleHeroInfoView.prefab")

panelType = -1-- 窗口类型 1 全屏 2 弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 1 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isAdapta = 1--是否开启适配刘海 0 否 1 是

--构造函数
function ctor(self)
    super.ctor(self)
    -- self:setSize(0, 0)
end
--析构
function dtor(self)
end

function initData(self)
    self.mStarList = {}
    self.mEquipGridList = {}
    self.mSkillList = {}
end

-- 初始化
function configUI(self)
    --左展示部分
    self.gImgBg = self:getChildGO("gImgBg")
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mImgJobBg = self:getChildGO("mImgJobBg")
    self.mGroupStar = self:getChildGO("mGroupStar")
    self.mGroupSkillBg = self:getChildGO("mGroupSkillBg")
    self.mBtnCloseTips = self:getChildGO("mBtnCloseTips")
    self.mImgEleTypeBg = self:getChildGO("mImgEleTypeBg")
    self.mGroupBracelets = self:getChildGO("mGroupBracelets")
    self.mEquipTipsTrans = self:getChildTrans("mEquipTipsTrans")
    self.mImgBraceletsStar = self:getChildGO("mImgBraceletsStar")
    self.mTxtLvl = self:getChildGO("mTxtLvl"):GetComponent(ty.Text)
    self.mTxtJob = self:getChildGO("mTxtJob"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mGroupBraceletsStar = self:getChildTrans("mGroupBraceletsStar")
    self.mImgJob = self:getChildGO("mImgJob"):GetComponent(ty.AutoRefImage)
    self.mTxtEleType = self:getChildGO("mTxtEleType"):GetComponent(ty.Text)
    self.mImgJob = self:getChildGO("mImgJob"):GetComponent(ty.AutoRefImage)
    self.mImgColorBg = self:getChildGO("mImgColorBg"):GetComponent(ty.Image)
    self.mTxtBracelets = self:getChildGO("mTxtBracelets"):GetComponent(ty.Text)
    self.mIconHero = self:getChildGO("mIconHero"):GetComponent(ty.AutoRefImage)
    self.mImgUnderlight = self:getChildGO("mImgUnderlight"):GetComponent(ty.Image)
    self.mTxtBraceletsLv = self:getChildGO("mTxtBraceletsLv"):GetComponent(ty.Text)
    self.mImgEleType = self:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)
    self.mImgEleType = self:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)
    self.mIconBracelets = self:getChildGO("mIconBracelets"):GetComponent(ty.AutoRefImage)
    --属性
    self.mGroupAtt = self:getChildTrans("mGroupAtt")
    self.mTxtAttTitle = self:getChildGO("mTxtAttTitle"):GetComponent(ty.Text)
    --技能
    self.mGroupSkill = self:getChildTrans("mGroupSkill")
    self.mGroupTalentSkill = self:getChildTrans("mGroupTalentSkill")
    self.mTxtSkillTitle = self:getChildGO("mTxtSkillTitle"):GetComponent(ty.Text)

    --芯片
    self.mEuipItem = self:getChildGO("mEuipItem")
    self.mImgNoEquip = self:getChildGO("mImgNoEquip")
    self.mGroupEquip = self:getChildTrans("mGroupEquip")
end

--激活
function active(self, args)
    super.active(self, args)
    if args.heroVo then
        self.heroVo = args.heroVo
    else
        self.heroVo = hero.HeroManager:getHeroConfigVo(args.heroTid)
    end
    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverAttrItem()
    self:recoverSkillItem()
    self:recoverEquipGrid()
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
    self.mTxtAttTitle.text = _TT(1030)
    self.mTxtSkillTitle.text = _TT(1041)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.gImgBg, self.onClickClose)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
    self:addUIEvent(self.mBtnCloseTips, self.closeEquipTips)
    self:addUIEvent(self.mGroupBracelets, self.openBraceletTips)
    -- self:addUIEvent(self.mBtnShowAttr, self.onShowAttr)
end
--只适配左上角按钮
function getAdaptaTrans(self)
    return self.mBtnClose.transform
end

function onShowAttr(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_ATTR_LIST_PANEL, {heroVo = self.heroVo})
end

function showEquipTips(self, equipVo, parent)
    if (equipVo) then
        if (not self.equipTips) then
            self.equipTips = equipBuild.EquipInfoTipsItem:poolGet()
        end
        self.equipTips:setData(equipVo, false, function ()
            self.equipTips:setHideHero(false)
        end)
        self.equipTips:setParent(parent)

        if nowEquip == nil then
            self.equipTips:setContrastActive(false)
        end
        self.mBtnCloseTips:SetActive(true)
    else
        if self.equipTips then
            self.equipTips:poolRecover()
            self.equipTips = nil
        end
        self.mBtnCloseTips:SetActive(false)
    end
end

function closeEquipTips(self)
    if self.equipTips then
        self.equipTips:poolRecover()
        self.equipTips = nil
    end
    self.mBtnCloseTips:SetActive(false)
end

function updateView(self)
    self:updateBaseInfo()
    self:updateStarLvl()
    self:updateAttr()
    self:updateSkill()
    self:updateEquip()
end

-- 更新基础信息
function updateBaseInfo(self)
    self.mTxtName.text = self.heroVo.name
    self.mTxtLvl.text = self.heroVo.lvl and _TT(3072, self.heroVo.lvl) or _TT(3072, 1)
    self.mImgEleTypeBg:SetActive(false)
    self.mImgJobBg:SetActive(false)
    -- self.mTxtDuty.text = hero.getDefineName(self.heroVo.defineType)
    self.mIconHero:SetImg(UrlManager:getHeroHeadUrlByModel(self.heroVo:getHeroModel()), true)
    -- self.mImgColor:SetImg(UrlManager:getPackPath(string.format("role4/role_hero_color_%s.png", self.heroVo.color)), true)
    self.mImgJob:SetImg(UrlManager:getMonsterJobSmallIconUrl(self.heroVo.professionType), false)
    if self.heroVo.eleType ~= nil then
        self.mImgEleTypeBg:SetActive(true)
        self.mImgEleType:SetImg(UrlManager:getHeroEleTypeIconUrl(self.heroVo.eleType), false)
        local color, name = hero.getHeroTypeName(self.heroVo.eleType)
        self.mTxtEleType.text = HtmlUtil:color(name, color)
    end
    if self.heroVo.professionType ~= nil then
        self.mImgJobBg:SetActive(true)
        self.mImgJob:SetImg(UrlManager:getHeroJobSmallIconUrl(self.heroVo.professionType), false)
        self.mTxtJob.text = hero.getProfessionName(self.heroVo.professionType)
    end

    local isShowRes = true
    if self.heroVo.__cname ~= hero.HeroVo.__cname and self.heroVo.__cname ~= hero.OtherHeroVo.__cname then
        isShowRes = false
        self:getChildGO("mImgResBg"):SetActive(isShowRes)
        return
    end

    local resonanceCount = self.heroVo:getActivesSkillResonanceCount()
    isShowRes = resonanceCount > 0
    if (isShowRes) then
        local imgType = self.m_childGos["mImgRes"]:GetComponent(ty.AutoRefImage)
        imgType:SetImg(string.format("arts/ui/icon/heroResonance/progress_%s.png", resonanceCount), false)
    end
    self:getChildGO("mImgResBg"):SetActive(isShowRes)
end

function returnPower(self)
    GameDispatcher:dispatchEvent(EventName.REQ_HERO_INIT_POWER, {heroTid = self.heroVo.tid})
    return "????"
end

-- 更新进化等级
function updateStarLvl(self)
    if self.heroVo.evolutionLvl == nil then
        self.mGroupStar:SetActive(false)
    else
        self.mGroupStar:SetActive(true)
        for i = 1, 6 do
            local color = i <= self.heroVo.evolutionLvl and gs.ColorUtil.GetColor("ffffffff") or gs.ColorUtil.GetColor("5c697aff")
            self:getChildGO("mImgStar_" .. i):GetComponent(ty.AutoRefImage).color = color
        end
    end
end

-- 更新属性
function updateAttr(self)
    self:recoverAttrItem()
    local showAttrList = {AttConst.HP_MAX, AttConst.ATTACK, AttConst.DEFENSE, AttConst.SPEED}
    for i, key in ipairs(showAttrList) do
        local item = SimpleInsItem:create(self:getChildGO("GroupAttItem"), self.mGroupAtt, "SingleHeroInfoViewAttItem")
        item:setText("mTxtAttName", nil, AttConst.getName(key))
        item:setText("mTxtAttValue", nil, AttConst.getValueStr(key, self:getAttrValue(key)))
        table.insert(self.attrList, item)
    end
end

-- 回收项
function recoverAttrItem(self)
    if self.attrList then
        for i, v in pairs(self.attrList) do
            v:poolRecover()
        end
    end
    self.attrList = {}
end
-- 更新技能
function updateSkill(self)
    self:recoverSkillItem()
    for i, skillId in ipairs(self.heroVo.baseSkillIdList) do
        local skillVo = fight.SkillManager:getSkillRo(skillId)
        local item = SimpleInsItem:create(self.mGroupSkillBg, self.mGroupSkill, "SingleHeroInfoViewSkillItem")
        local imgUrl = (skillVo:getType() == fight.FightDef.SKILL_TYPE_NORMAL_ATTACK) and UrlManager:getCommon5Path("common_0055.png") or UrlManager:getCommon5Path("common_0055.png")
        item:getChildGO("mImgSkillBg"):GetComponent(ty.AutoRefImage):SetImg(imgUrl, false)
        item:getChildGO("mImgSkill"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), false)
        item:getChildGO("mImgLvBg"):SetActive((table.indexof(self.heroVo.activeSkillList, skillId) ~= false))
        local skillLv = self.heroVo:getActivePassiveSkill(skillVo:getRefID()) + self.heroVo:getExtraLv(skillVo:getRefID())
        if self.heroVo:getActiveSkill(skillVo:getRefID()) then
            skillLv = self.heroVo:getActiveSkill(skillVo:getRefID()) + self.heroVo:getExtraLv(skillVo:getRefID())
        end
        item:getChildGO("mTxtLv"):GetComponent(ty.Text).text = _TT(3072, skillLv)
        item:getChildGO("mImgLock"):SetActive((not table.indexof(self.heroVo.activeSkillList, skillId)))
        item:addUIEvent(nil, function()
            if (table.indexof(self.heroVo.activeSkillList, skillId) ~= false) then
                TipsFactory:skillTips(nil, skillId, self.heroVo)
            end
        end)
        table.insert(self.mSkillList, item)
    end
    for i, skillId in ipairs(self.heroVo.inBornSkill) do
        local skillVo = fight.SkillManager:getSkillRo(skillId)
        local item = SimpleInsItem:create(self.mGroupSkillBg, self.mGroupTalentSkill, "SingleHeroInfoViewSkillItem")
        item:getChildGO("mImgSkillBg"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0055.png"), false)
        item:getChildGO("mImgLvBg"):SetActive((table.indexof(self.heroVo.activePassSkillList, skillId) ~= false))
        item:getChildGO("mImgSkill"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), false)
        item:getChildGO("mTxtLv"):GetComponent(ty.Text).text = _TT(3072, self.heroVo:getActivePassiveSkill(skillVo:getRefID()) + self.heroVo:getExtraLv(skillVo:getRefID()))
        item:getChildGO("mImgLock"):SetActive((not table.indexof(self.heroVo.activePassSkillList, skillId)))
        item:addUIEvent(nil, function()
            if (table.indexof(self.heroVo.activePassSkillList, skillId) ~= false) then
                TipsFactory:skillTips(nil, skillId, self.heroVo)
            end
        end)
        table.insert(self.mSkillList, item)
    end
end

function openBraceletTips(self)
    if self.mBraceletsVo then
        TipsFactory:closeBraceletTips()
        self.mBraceletTips = TipsFactory:openBraceletTips({curHeroid = self.heroVo.id, equipVo = self.mBraceletsVo, openType = BraceletTipConstOpenType.OtherHero})
        if self.mBraceletTips then
            self.mBraceletTips:showMask()
        end
    end
end

-- 回收项
function recoverSkillItem(self)
    if #self.mSkillList > 0 then
        for i, v in ipairs(self.mSkillList) do
            v:poolRecover()
        end
        self.mSkillList = {}
    end
end

-- 更新芯片
function updateEquip(self)
    self:recoverEquipGrid()
    for i = 1, 6 do
        local item = SimpleInsItem:create(self.mEuipItem, self:getChildTrans("mEquipTrans" .. i), "SingleHeroInfoViewmEuipItem")
        item:getChildGO("mTxtPos"):GetComponent(ty.Text).text = PropsEquipSubTypeStr[i]
        item:getChildGO("mImgColor"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor("82898Cff")
        item:getChildGO("mEuipIcon"):SetActive(false)
        item:getChildGO("mImgLvBg"):SetActive(false)
        for _, EquipVo in ipairs(self.heroVo.otherPlayerEquipList) do
            item:getChildGO("mGroupHas"):SetActive(i <= EquipVo.subType)
            if i == EquipVo.subType then
                item:getChildGO("mEuipIcon"):SetActive(true)
                item:getChildGO("mImgLvBg"):SetActive(true)
                item:getChildGO("mTxtLv"):GetComponent(ty.Text).text = _TT(3072, EquipVo.strengthenLvl)
                item:getChildGO("mImgColor"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor(hero.getEquipColor(EquipVo.color))
                item:getChildGO("mEuipIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(EquipVo.icon), true)
                item:addUIEvent(nil, function()
                    self:showEquipTips(EquipVo, self.mEquipTipsTrans)
                end)
                local remakePosAttrList, remakePosAttrDic = EquipVo:getRemakeAttr()
                if table.nums(remakePosAttrDic) ~= 0 then
                    for index = 1, 6 do
                        if index <= table.nums(remakePosAttrDic) then
                            local starItem = SimpleInsItem:create(item:getChildGO("mImgStar"), item:getChildTrans("mGroupStarTrans"), "SingleHeroInfoViewmImgStar")
                            table.insert(self.mStarList, starItem)
                        end
                    end
                end
            end
        end

        table.insert(self.mEquipGridList, item)
    end
    self:updateBracelets()
end
--更新手环
function updateBracelets(self)
    self.mImgUnderlight.gameObject:SetActive(false)
    self.mTxtBracelets.gameObject:SetActive(true)
    for _, EquipVo in ipairs(self.heroVo.otherPlayerEquipList) do
        if EquipVo.subType == 7 then
            self.mImgUnderlight.gameObject:SetActive(true)
            self.mTxtBracelets.gameObject:SetActive(false)
            self.mIconBracelets:SetImg(UrlManager:getPropsIconUrl(EquipVo.tid), false)
            self.mTxtBraceletsLv.text = _TT(3072, EquipVo.strengthenLvl)
            --self.mImgColorBg.color = gs.ColorUtil.GetColor(hero.getBraceletsColor(EquipVo.color))
            --self.mImgUnderlight.color = gs.ColorUtil.GetColor(hero.getBraceletsColor(EquipVo.color))
            self.mBraceletsVo = EquipVo
            local remakePosAttrList, remakePosAttrDic = EquipVo:getRemakeAttr()
            if EquipVo.refineLvl > 0 then
                for index = 1, 6 do
                    if index <= EquipVo.refineLvl then
                        local starItem = SimpleInsItem:create(self.mImgBraceletsStar, self.mGroupBraceletsStar, "SingleHeroInfoViewmImgBraceletsStar")
                        table.insert(self.mStarList, starItem)
                    end
                end
                break
            end
        end
    end
end

function recoverEquipGrid(self)
    if (self.mEquipGridList) then
        for i = 1, #self.mEquipGridList do
            self.mEquipGridList[i]:poolRecover()
        end
        self.mEquipGridList = {}
    end
    if (#self.mStarList > 0) then
        for i = 1, #self.mStarList do
            self.mStarList[i]:poolRecover()
        end
        self.mStarList = {}
    end
end

-- 获取战员属性（有实体属性的不然拿基础属性）
function getAttrValue(self, key)
    if self.heroVo.attrDic then
        return self.heroVo.attrDic[key]
    end
    return self.heroVo.basicAttrDic[key]
end

return _M

--[[ 替换语言包自动生成，请勿修改！
语言包: _TT(1044):"芯片"
语言包: _TT(1041):"技能"
语言包: _TT(1030):"属性"
]]
