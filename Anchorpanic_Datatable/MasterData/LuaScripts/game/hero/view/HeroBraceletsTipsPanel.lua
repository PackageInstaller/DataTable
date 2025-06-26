module('hero.HeroBraceletsTipsPanel', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath('hero/HeroBraceletsTipsPanel.prefab')
panelType = -1
isBlur = 0
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
end

-- -- 初始化数据
function initData(self)
    self.mTipsAttrList = {}
    self.mStarDic = {}
end

function setMask(self)
    super.setMask(self)
    local trigger = self.mask:GetComponent(ty.LongPressOrClickEventTrigger)
    trigger:SetIsPassEvent(true)
end

function configUI(self)
    super.configUI(self)
    -------------------------------------------------------------showTips-------------------------------------------------------------

    -- self.mRepTips:SetActive(false)
    self.mTipsBtnClose = self:getChildGO("mTipsBtnClose")
    self.mTxtEquipInfo = self:getChildGO("mTxtEquipInfo"):GetComponent(ty.Text)
    self.mTxtEquipLv = self:getChildGO("mTxtEquipLv"):GetComponent(ty.Text)
    self.mTipsAttrScroll = self:getChildGO("mTipsAttrScroll"):GetComponent(ty.ScrollRect)
    self.mTipsAttrItem = self:getChildGO("mTipsAttrItem")
    self.mTxtTipsSkill = self:getChildGO("mTxtTipsSkill"):GetComponent(ty.Text)
    self.mTipsRelGroup = self:getChildTrans("mTipsRelGroup")
    self.mTipsTxtDes = self:getChildGO("mTipsTxtDes"):GetComponent(ty.Text)
end

function active(self, args)
    super.active(self, args)
    self.mCurHeroId = args.curHeroid
    self.mSelectEquip = args.equipVo
    self.mOpenType = args.openType
    self:onUpdateRepTipsHandler()
end

function deActive(self)
    cusLog("deactive")
    super.deActive(self)
    self:clearTipsAttrItems()
    self:clearStarItems()
end

function addAllUIEvent(self)
    self:addUIEvent(self.mTipsBtnClose, self.close)
end

-- 展示tips内容
function onUpdateRepTipsHandler(self)
    self.m_childGos["mIsTipsCurrent"]:SetActive( self.mOpenType == 1)
    if self.mOpenType == 1 then
        local equipVo = braceletBuild.BraceletBuildManager:getHeroCanHaveEquip(self.mCurHeroId)
        if equipVo then
            self.mTxtEquipInfo.text = equipVo.name
            self.mTxtEquipLv.text = "Lv." .. equipVo.refineLvl
            local mBraceletsVo = braceletBuild.BraceletBuildManager:getRefineConfigVo(equipVo.tid, equipVo.refineLvl)
            self.mTipsTxtDes.text = mBraceletsVo.des
            --mBraceletsVo.skillEffectList.
            local skillVo = fight.SkillManager:getSkillRo(mBraceletsVo.tid)
            self.mTxtTipsSkill.text = skillVo:getName()

            self:clearTipsAttrItems()
            -- 创建tips主词条
            local mainAttrList, _ = equipVo:getMainAttr()
            for i = 1, #mainAttrList do
                local attrVo = mainAttrList[i]
                local attrTValue = attrVo.value

                self.mTipsAttrList[i] = SimpleInsItem:create(self.mTipsAttrItem, self.mTipsAttrScroll.content, "HeroBraceletsTipsPaneltipsAttrItem")
                self.mTipsAttrList[i]:getChildGO("mTxtAttrName"):GetComponent(ty.Text).text = AttConst.getName(attrVo.key)
                local attrValue = self.mTipsAttrList[i]:getChildGO("mTxtAttrValue"):GetComponent(ty.Text)
                attrValue.text = AttConst.getValueStr(attrVo.key, attrTValue)
                attrValue.color = AttConst.ATTACK == attrVo.key and gs.ColorUtil.GetColor("fa3a2bff")
                or gs.ColorUtil.GetColor("18ec68ff")
            end

            self:clearStarItems()
            local maxRefineLvl = braceletBuild.BraceletBuildManager:getMaxRefineLvl(equipVo.tid)
            local mStr = maxRefineLvl > equipVo.refineLvl and "bracelet/bracelet_refine_1.png" or "bracelet/bracelet_refine_2.png"
            for i = 1, maxRefineLvl do
                self.mStarDic[i] = SimpleInsItem:create(self.m_childGos["mImgTipsRel"], self.mTipsRelGroup, "HeroBraceletsTipsPanelrefineItem" )
                local img = self.mStarDic[i]:getGo():GetComponent(ty.AutoRefImage)
                if i > equipVo.refineLvl then

                    img.color = gs.ColorUtil.GetColor("82898cff")
                else
                    img.color = gs.ColorUtil.GetColor("ffffffff")
                end
                img:SetImg(UrlManager:getPackPath(mStr), false)
            end
        else
            return
        end
    else --暂时未知这段的内容 todo整合
        self.mTxtEquipInfo.text =   self.mSelectEquip.name
        self.mTxtEquipLv.text = "Lv." ..   self.mSelectEquip.refineLvl
        local mBraceletsVo = braceletBuild.BraceletBuildManager:getRefineConfigVo(  self.mSelectEquip.tid,   self.mSelectEquip.refineLvl)
        self.mTipsTxtDes.text = mBraceletsVo.des
        --mBraceletsVo.skillEffectList.
        local skillVo = fight.SkillManager:getSkillRo(mBraceletsVo.tid)
        self.mTxtTipsSkill.text = skillVo:getName()

        self:clearTipsAttrItems()
        -- 创建tips主词条
        local mainAttrList, _ =   self.mSelectEquip:getMainAttr()
        for i = 1, #mainAttrList do
            local attrVo = mainAttrList[i]
            local attrTValue = attrVo.value

            self.mTipsAttrList[i] = SimpleInsItem:create(self.mTipsAttrItem, self.mTipsAttrScroll.content, "HeroBraceletsTipsPaneltipsAttrItem")
            self.mTipsAttrList[i]:getChildGO("mTxtAttrName"):GetComponent(ty.Text).text = AttConst.getName(attrVo.key)
            local attrValue = self.mTipsAttrList[i]:getChildGO("mTxtAttrValue"):GetComponent(ty.Text)
            attrValue.text = AttConst.getValueStr(attrVo.key, attrTValue)
            attrValue.color = AttConst.ATTACK == attrVo.key and gs.ColorUtil.GetColor("fa3a2bff")
            or gs.ColorUtil.GetColor("18ec68ff")
        end

        self:clearStarItems()
        local maxRefineLvl = braceletBuild.BraceletBuildManager:getMaxRefineLvl(  self.mSelectEquip.tid)
        local mStr = maxRefineLvl >   self.mSelectEquip.refineLvl and "bracelet/bracelet_refine_1.png" or "bracelet/bracelet_refine_2.png"
        for i = 1, maxRefineLvl do
            self.mStarDic[i] = SimpleInsItem:create(self.m_childGos["mImgTipsRel"], self.mTipsRelGroup, "HeroBraceletsTipsPanelrefineItem")
            local img = self.mStarDic[i]:getGo():GetComponent(ty.AutoRefImage)
            if i >   self.mSelectEquip.refineLvl then

                img.color = gs.ColorUtil.GetColor("82898cff")
            else
                img.color = gs.ColorUtil.GetColor("ffffffff")
            end
            img:SetImg(UrlManager:getPackPath(mStr), false)
        end
    end
end

-- 清理tips的主词条
function clearTipsAttrItems(self)
    if next(self.mTipsAttrList) then
        for _, item in pairs(self.mTipsAttrList) do
            item:poolRecover()
        end
        self.mTipsAttrList = {}
    end
end

-- 清理星级的主词条
function clearStarItems(self)
    if next(self.mStarDic) then
        for _, item in pairs(self.mStarDic) do
            item:poolRecover()
        end
        self.mStarDic = {}
    end
end



return _M