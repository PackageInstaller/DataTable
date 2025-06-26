module("tips.BraceletTips", Class.impl(View))

panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
UIRes = UrlManager:getUIPrefabPath("tips/BraceletTips.prefab")
isBlur = 0 -- 是否

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
end

-- 初始化数据
function initData(self)
    self.mTipsAttrList = {}
    self.mStarDic = {}
end

-- 析构函数
function dtor(self)
    super.dtor(self)
end

function setMask(self)
    -- super.setMask(self)
    -- local trigger = self.mask:GetComponent(ty.LongPressOrClickEventTrigger)
    -- trigger:SetIsPassEvent(true)
end

-- 外部调用
function showMask(self)
    super.setMask(self)
end

-- 初始化UI
function configUI(self)
    super.configUI(self)

    self.mRepTips = self:getChildTrans("mRepTips"):GetComponent(ty.RectTransform)
    self.mTipsBtnClose = self:getChildGO("mTipsBtnClose")
    self.mTxtEquipInfo = self:getChildGO("mTxtEquipInfo"):GetComponent(ty.Text)
    self.mTxtEquipLv = self:getChildGO("mTxtEquipLv"):GetComponent(ty.Text)
    self.mTipsAttrScroll = self:getChildGO("mTipsAttrScroll"):GetComponent(ty.ScrollRect)
    self.mTipsAttrItem = self:getChildGO("mTipsAttrItem")
    self.mTxtTipsSkill = self:getChildGO("mTxtTipsSkill"):GetComponent(ty.Text)
    self.mTipsRelGroup = self:getChildTrans("mTipsRelGroup")
    self.mTipsTxtDes = self:getChildGO("mTipsTxtDes"):GetComponent(ty.TMP_Text)
    self.mTipsTxtDes_tmpLink = self:getChildGO("mTipsTxtDes"):GetComponent(ty.TextMeshProLink)
    self.mTipsTxtDes_tmpLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)


    self.mGroupEmpower = self:getChildGO("mGroupEmpower")
    self.mEmpowerContent = self:getChildTrans("mEmpowerContent")

    self.mBtnLock = self:getChildGO("mBtnLock")
    -- self.mBtnLock:SetActive(false)
    -- self.mBtnLockImg = self.mBtnLock:GetComponent(ty.AutoRefImage)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnLock, self.onLockClickHandler)
end

function onLockClickHandler(self)
    local isLock = self.mSelectEquip.isLock == 0 and 1 or 0
    GameDispatcher:dispatchEvent(EventName.REQ_PROPS_LOCK_CHANGE, {
        propsVo = self.mSelectEquip,
        isLock = isLock
    })
end

function active(self, args)
    super.active(self, args)
    self.mSelectEquip = args.equipVo
    self.mOpenType = args.openType
    self.mParentTran = args.parentTran
    self.mSelectEquip:addEventListener(props.PropsVo.UPDATE, self.onUpdateRepTipsHandler, self)
    self.mSelectEquip:addEventListener(self.mSelectEquip.UPDATE_EQUIP_DETAIL_DATA, self.onUpdateRepTipsHandler, self)

    self:onUpdateRepTipsHandler()
end

function deActive(self)
    super.deActive(self)

    self.mSelectEquip:removeEventListener(props.PropsVo.UPDATE, self.onUpdateRepTipsHandler, self)
    self.mSelectEquip:removeEventListener(self.mSelectEquip.UPDATE_EQUIP_DETAIL_DATA, self.onUpdateRepTipsHandler, self)
    self.mSelectEquip = nil
    self:clearTipsAttrItems()
    self:clearStarItems()
end

-- 展示tips内容
function onUpdateRepTipsHandler(self)

    self.mTxtEquipInfo.text = self.mSelectEquip.name
    self.mTxtEquipLv.text = "Lv." .. self.mSelectEquip.strengthenLvl
    local mBraceletsVo = braceletBuild.BraceletBuildManager:getRefineConfigVo(self.mSelectEquip.tid,
    self.mSelectEquip.refineLvl)
    self.mTipsTxtDes.text = mBraceletsVo.des

    local skillVo = fight.SkillManager:getSkillRo(mBraceletsVo.tid)
    self.mTxtTipsSkill.text = skillVo:getName()

    self:getChildGO("mImgLock"):SetActive(self.mSelectEquip.isLock == 1)
    self:getChildGO("mImgUnlock"):SetActive(self.mSelectEquip.isLock ~= 1)

    self.mBtnLock:SetActive(self.mOpenType == BraceletTipConstOpenType.BraceletSelf)

    self:clearTipsAttrItems()
    -- 创建tips主词条
    local mainAttrList, _ = self.mSelectEquip:getMainAttr()
    for i = 1, #mainAttrList do
        local attrVo = mainAttrList[i]
        local attrTValue = attrVo.value

        local item = SimpleInsItem:create(self.mTipsAttrItem, self.mTipsAttrScroll.content, "BraceletTipstipsAttrItem")
        table.insert(self.mTipsAttrList, item)

        item:getChildGO("mTxtAttrName"):GetComponent(ty.Text).text = AttConst.getName(attrVo.key)
        local attrValue = item:getChildGO("mTxtAttrValue"):GetComponent(ty.Text)
        attrValue.text = AttConst.getValueStr(attrVo.key, attrTValue)
        -- 去掉了攻击力红色的判断 太怪异的颜色
        -- attrValue.color = --AttConst.ATTACK == attrVo.key and gs.ColorUtil.GetColor("fa3a2bff") or
        --                       gs.ColorUtil.GetColor("18ec68ff")
    end

    --显示赋能词条
    local equipBracelet_remake_attr = self.mSelectEquip:getBracelet_remake_attr()
    self.mGroupEmpower:SetActive(not table.empty(equipBracelet_remake_attr))

    for i = 1, #equipBracelet_remake_attr do
        local item = SimpleInsItem:create(self.mTipsAttrItem, self.mEmpowerContent, "BraceletTipstipsAttrItem")
        table.insert(self.mTipsAttrList, item)

        local key = equipBracelet_remake_attr[i].attrType
        local value = equipBracelet_remake_attr[i].attrValue

        item:getChildGO("mTxtAttrName"):GetComponent(ty.Text).text = AttConst.getName(key)
        item:getChildGO("mTxtAttrValue"):GetComponent(ty.Text).text = AttConst.getValueStr(key, value)
    end

    self:clearStarItems()
    local maxRefineLvl = braceletBuild.BraceletBuildManager:getMaxRefineLvl(self.mSelectEquip.tid)
    local mStr = maxRefineLvl > self.mSelectEquip.refineLvl and "bracelet/bracelet_refine_1.png" or
    "bracelet/bracelet_refine_2.png"
    for i = 1, maxRefineLvl do
        self.mStarDic[i] = SimpleInsItem:create(self.m_childGos["mImgTipsRel"], self.mTipsRelGroup, "BraceletTipsrefineItem")
        local img = self.mStarDic[i]:getGo():GetComponent(ty.AutoRefImage)
        if i > self.mSelectEquip.refineLvl then
            img.color = gs.ColorUtil.GetColor("82898cff")
        else
            img.color = gs.ColorUtil.GetColor("ffffffff")
        end
        img:SetImg(UrlManager:getPackPath(mStr), false)
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

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

return _M
