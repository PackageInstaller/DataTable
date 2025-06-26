module("hero.HeroBraceletsTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("hero/tab/HeroBraceletsTab.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.m_curHeroId = nil
    self.mEquipGrid = nil
    self.m_simpleObjList = {}
end

function configUI(self)
    super.configUI(self)
    self.m_groupContent = self:getChildGO("GroupContent")
    
    self.m_equipNode = self:getChildTrans("EquipNode")
    self.mTxtName = self:getChildGO("TextName"):GetComponent(ty.Text)
    self.m_textNameShadow = self:getChildGO("TextNameShadow"):GetComponent(ty.Text)
    self.m_textNameSuffix = self:getChildGO("TextNameSuffix"):GetComponent(ty.Text)

    self.m_textCurLvl = self:getChildGO("TextCurLvl"):GetComponent(ty.Text)
    self.m_textNextLvl = self:getChildGO("TextNextLvl"):GetComponent(ty.Text)

    self.m_groupRefineLvl = self:getChildGO("GroupRefineLvl")
    self.m_itemRefineLvl = self:getChildGO("ItemRefineLvl")
    
    self.m_groupAttr = self:getChildGO("GroupAttr")
    self.m_textAttrTitle = self:getChildGO("TextAttrTitle"):GetComponent(ty.Text)
    self.m_groupAttrList = self:getChildTrans("GroupAttrList")
    self.m_attrItem = self:getChildGO("AttrItem")
    
    self.m_groupSkill = self:getChildGO("GroupSkill")
    self.m_textSkillTitle = self:getChildGO("TextSkillTitle"):GetComponent(ty.Text)
    self.m_textSkillName = self:getChildGO("TextSkillName"):GetComponent(ty.Text)
    self.m_textSkillDes = self:getChildGO("TextSkillDes"):GetComponent(ty.Text)

    self.m_btnSelect = self:getChildGO("BtnSelect")
    self.m_btnBuild = self:getChildGO("BtnBuild")
    self.m_imgBuild = self.m_btnBuild:GetComponent(ty.AutoRefImage)

    self.m_groupEmpty = self:getChildGO("GroupEmpty")
    self.m_textEmpty_1 = self:getChildGO("TextEmpty_1"):GetComponent(ty.Text)
    self.m_textEmpty_2 = self:getChildGO("TextEmpty_2"):GetComponent(ty.Text)
end

function active(self, args)
    super.active(self, args)
    -- hero.HeroEquipManager:addEventListener(hero.HeroEquipManager.HERO_EQUIP_LIST_UPDATE, self.__onEquipUpdateHandler, self)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.__onBagUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_DATA_UPDATE, self.__onUpdateHeroDetailDataHandler, self)
    hero.HeroFlagManager:addEventListener(hero.HeroFlagManager.FLAG_UPDATE, self.onBubbleUpdateHandler, self)

    local heroId = args.heroId
    self:setData(heroId)
end

function deActive(self)
    super.deActive(self)
    -- hero.HeroEquipManager:removeEventListener(hero.HeroEquipManager.HERO_EQUIP_LIST_UPDATE, self.__onEquipUpdateHandler, self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.__onBagUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.HERO_DATA_UPDATE, self.__onUpdateHeroDetailDataHandler, self)
    hero.HeroFlagManager:removeEventListener(hero.HeroFlagManager.FLAG_UPDATE, self.onBubbleUpdateHandler, self)
    self:__resetSimpleObjList()
    if(self.mEquipGrid)then
        self.mEquipGrid:poolRecover()
        self.mEquipGrid = nil
    end
end

function initViewText(self)
    self.m_textNameSuffix.text = _TT(4318) --"手环"
    self.m_textAttrTitle.text = _TT(1030) --"属性"
    self.m_textSkillTitle.text = _TT(1041) --"技能"
    self.m_textEmpty_1.text = _TT(4319) --"- 无手环 -"
    self.m_textEmpty_2.text = _TT(4320) --"- 您未穿戴任何手环 -"
    self:setBtnLabel(self.m_btnBuild, 4321, "培养")
end

function addAllUIEvent(self)
    self:addUIEvent(self.m_btnSelect, self.__onClickSelectHandler)
    self:addUIEvent(self.m_btnBuild, self.__onClickBuildHandler)
end

-- 选择手环
function __onClickSelectHandler(self)
    local curHeroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    GameDispatcher:dispatchEvent(EventName.OPEN_BRACELETS_BAG_PANEL, {heroId = curHeroVo.id, slotPos = PropsEquipSubType.SLOT_7})
end

function __onClickBuildHandler(self)
    local curHeroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    local equipVo = curHeroVo:getEquipByPos(PropsEquipSubType.SLOT_7)
    if(equipVo)then
        GameDispatcher:dispatchEvent(EventName.OPEN_BRACELETS_BUILD_PANEL, { equipVo = equipVo })
    else
        gs.Message.Show(_TT(4322))--请先穿戴手环
    end
end

function __onEquipUpdateHandler(self, args)
    self:__updateView()
end

function __onBagUpdateHandler(self, args)
    self:__updateView()
end

function __onUpdateHeroDetailDataHandler(self, args)
    local heroId = args.heroId
    if (self.m_curHeroId == heroId) then
        self:__updateView()
    end
end

function onBubbleUpdateHandler(self, args)
    local heroId = args.heroId
    if (heroId == self.m_curHeroId) then
        if (args.flagType == hero.HeroFlagManager.FLAG_CAN_WEAR_BRACELETS) then
            self:__updateColorUpBubbleView(args.flagType, args.isFlag)
        end
    end
end

function __updateColorUpBubbleView(self, flagType, isFlag)
    if (not flagType and not isFlag) then
        isFlag = isFlag and isFlag or hero.HeroFlagManager:getFlag(self.m_curHeroId, hero.HeroFlagManager.FLAG_CAN_WEAR_BRACELETS)
    end
    if (isFlag) then
        RedPointManager:add(self.m_btnSelect.transform, nil, 79, 19)
    else
        RedPointManager:remove(self.m_btnSelect.transform)
    end
end

function setData(self, cusHeroId)
    self.m_curHeroId = cusHeroId
    local heroVo = hero.HeroManager:getHeroVo(cusHeroId)
    if (heroVo:checkIsPreData()) then
        return
    end
    
    self:__updateView()
    self:__updateColorUpBubbleView()
end

function __updateView(self)
    local curHeroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    local equipVo = curHeroVo:getEquipByPos(PropsEquipSubType.SLOT_7)
    if(equipVo)then
        if (self.m_selectEquipDataLoadCompleteHandler) then
            equipVo:removeEventListener(equipVo.UPDATE_EQUIP_DETAIL_DATA, self.m_selectEquipDataLoadCompleteHandler, self)
            self.m_selectEquipDataLoadCompleteHandler = nil
        end
        if (equipVo:getTotalAttr() == nil) then
            self.m_selectEquipDataLoadCompleteHandler = function()
                self:__updateView()
            end
            equipVo:addEventListener(equipVo.UPDATE_EQUIP_DETAIL_DATA, self.m_selectEquipDataLoadCompleteHandler, self)
            return
        end

        self:__resetSimpleObjList()

        self.m_groupContent:SetActive(true)
        self.m_groupEmpty:SetActive(false)
        self:setBtnLabel(self.m_btnSelect, 4323, "替换")
        self.m_imgBuild:SetGray(false)

        if(self.mEquipGrid)then
            self.mEquipGrid:poolRecover()
            self.mEquipGrid = nil
        end
        self.mEquipGrid = EquipGrid2:create(self.m_equipNode, equipVo, 0.55)
        self.mEquipGrid:setClickEnable(false)

        self.mTxtName.text = equipVo.name
        self.m_textNameShadow.text = equipVo.name

        self.m_textCurLvl.text = equipVo.strengthenLvl .. " /"
        local breakUpConfigVo = equipBuild.EquipStrengthenManager:getBreakUpConfigVo(equipVo.tid, equipVo.tuPoRank)
        if(breakUpConfigVo)then
            self.m_textNextLvl.text = HtmlUtil:size("LV", 18) .. "\n" .. breakUpConfigVo.equipTargetLvl
        else
            self.m_textNextLvl.text = ""
        end
        
        -- 属性显示
        local totalAttrList, totalAttrDic = equipVo:getTotalAttr()
        local nuclearAttrList, nuclearAttrDic = equipVo:getNuclearAttr()
        local attachAttrList, attachAttrDic = equipVo:getTuPoAttachAttr()
        for i = 1, #totalAttrList do
            local attrVo = totalAttrList[i]
            local attrTValue = 0
            -- 总属性 = 基础属性 + 核能属性 + 突破附加属性，所以这里如果有核能属性或突破附加属性，则需要进行相减
            -- 过滤核能属性
            local nuclearAttr = nuclearAttrDic[attrVo.key]
            if  nuclearAttr then
                attrTValue = (attrVo.value - nuclearAttr)
            else
                attrTValue = attrVo.value
            end
            -- 过滤激活了的突破附加属性
            local attachAttrVo = attachAttrDic[attrVo.key]
            if attachAttrVo and attachAttrVo.isActive then
                attrTValue = (attrVo.value - attachAttrVo.value)
            else
                attrTValue = attrVo.value
            end
            if (attrTValue > 0) then
                local item = SimpleInsItem:create(self.m_attrItem, self.m_groupAttrList, "HeroBraceletsTabViewm_attrItem")
                item:getChildGO("TextAttrName"):GetComponent(ty.Text).text = AttConst.getName(attrVo.key)
                item:getChildGO("TextAttrValue"):GetComponent(ty.Text).text = AttConst.getValueStr(attrVo.key, attrTValue)
                table.insert(self.m_simpleObjList, item)
            end
        end

        -- 技能显示
        local skillEffectList, skillEffectDic = equipVo:getSkillEffect()
        if (skillEffectList and #skillEffectList > 0) then
            self.m_groupSkill:SetActive(true)
            for i = 1, #skillEffectList do
                local skillVo = fight.SkillManager:getSkillRo(skillEffectList[i].skillId)
                local des = equip.EquipSkillManager:getSkillDes(equipVo, skillEffectList[i])
                self.m_textSkillName.text = skillVo:getName()
                self.m_textSkillDes.text = des
            end
        else
            self.m_groupSkill:SetActive(false)
        end

        local isCanRefine = braceletsBuild.BraceletsRefineManager:isCanRefine(equipVo.tid)
        if(isCanRefine)then
            self.m_groupRefineLvl:SetActive(true)
            local maxRefineLvl = braceletsBuild.BraceletsRefineManager:getMaxRefineLvl(equipVo.tid)
            for lvl = 1, maxRefineLvl do
                local item = SimpleInsItem:create(self.m_itemRefineLvl, self.m_groupRefineLvl.transform, "HeroBraceletsTabViewm_itemRefineLvl")
                item:getChildGO("ImgRefineLvl"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getBraceletsRefineLvlIconUrl(equipVo.refineLvl < lvl), true)
                table.insert(self.m_simpleObjList, item)
            end
        else
            self.m_groupRefineLvl:SetActive(false)
        end
    else
        self.m_groupContent:SetActive(false)
        self.m_groupEmpty:SetActive(true)
        self:setBtnLabel(self.m_btnSelect, 4324, "安装")
        self.m_imgBuild:SetGray(true)
    end

    self:__updateGuide()
end

-- 回收精炼等级图标预制体
function __resetSimpleObjList(self)
    if(self.m_simpleObjList)then
        for _, obj in pairs(self.m_simpleObjList) do
            obj:poolRecover()
        end
    end
    self.m_simpleObjList = {}
end

function __updateGuide(self)
    -- local curHeroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    -- if (curHeroVo.id == 1) then
    --     self:setGuideTrans("hero_lvlup_btn_lvlup_" .. curHeroVo.id, self.m_btnLvlUpRect)
    -- end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
