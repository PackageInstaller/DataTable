module("manual.ManualModuleInfoView", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("manual/ManualModuleInfoView.prefab")
destroyTime = 0 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
--构造函数
function ctor(self, args)
    super.ctor(self, args)
    self:setSize(1334, 750);
    self:setBg("manual_bg.jpg", false, "manual")
    self:setTxtTitle("模组")
end

function initData(self)
    self.mAttrItems = {}
    self.mPropItems = {}
    self.mInit = true
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mBtnNext = self:getChildGO("mBtnNext")
    self.mBtnLast = self:getChildGO("mBtnLast")
    self.mAttrItem = self:getChildGO("mAttrItem")
    self.mPropItem = self:getChildGO("mPropItem")
    self.mBtnDetails = self:getChildGO("mBtnDetails")
    self.mItemTrans = self:getChildTrans("mItemTrans")
    self.AttrContent = self:getChildTrans("AttrContent")
    self.mImgColor = self:getChildGO("mImgColor"):GetComponent(ty.Image)
    self.mTxtColor = self:getChildGO("mTxtColor"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtAbstractDec = self:getChildGO("mTxtAbstractDec"):GetComponent(ty.Text)
    self.mScrollEffect = self:getChildGO("Scroll View"):GetComponent(ty.ScrollEffect)
    self.mAni = self:getChildGO("mGroupRight"):GetComponent(ty.Animator)
end

--激活
function active(self, args)
    super.active(self, args)
    self.curData = args.curData
    self.dataList = args.dataList
    self.mIndex = table.indexof01(self.dataList, self.curData.suitId)
    MoneyManager:setMoneyTidList()
    self:updateBtnState(self.mIndex)
    self:init()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    if self.mScrollEffect then
        self.mScrollEffect:OnClearAllItem()
    end
    self:recoveAttrItem()
    self:recoverPropsItem()
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnDetails, self.onClickOpenDetailsView)
end

--打开详情页面
function onClickOpenDetailsView(self)

end

function init(self)
    local gameObjList = {}
    for _, item in ipairs(self.mPropItems) do
        table.insert(gameObjList, item:getGo().gameObject)
    end
    local index = self.mIndex > 0 and (self.mIndex - 1) or self.mIndex
    self.mScrollEffect:setSelectIndex(index)
    self.mScrollEffect:setList(gameObjList, function(curSelect)
        if self.mInit then
            self.mInit = false
        else
            self.mAni:SetTrigger("show")
        end
        self:updateView(curSelect)
        --self:updateBtnState(curSelect)
    end)
end
--点击回调
function onClickHandler(self, curSelect)

end

function initViewText(self)
end

function updateView(self, index)
    if index then
        local data = self.dataList
        self.curData = equip.EquipSuitManager:getEquipSuitConfigVo(data[index])
    end
    if self.curData and self.curData:getIsNew() then
        GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.MANUAL_CHIP, id = self.curData.suitId })
    end

    self:recoveAttrItem()
    local propConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(self.curData.suitId)
    self.mTxtName.text = propConfigVo.name
    if self.curData.suitSkillId_2 > 0 then
        local skillVo = fight.SkillManager:getSkillRo(self.curData.suitSkillId_2)
        local keyName = skillVo.m_name
        local item = SimpleInsItem:create(self.mAttrItem, self.AttrContent, "attritem_Module")
        local itemKey = item:getChildGO("mTxtAttrName"):GetComponent(ty.Text)
        local itemValue = item:getChildGO("mTxtAttrValue"):GetComponent(ty.Text)
        itemKey.text = keyName
        itemValue.text = skillVo.mDescTip
        table.insert(self.mAttrItems, item)
    end

    if self.curData.suitSkillId_4 > 0 then
        local skillVo_2 = fight.SkillManager:getSkillRo(self.curData.suitSkillId_4)
        local keyName_2 = skillVo_2.m_name
        local item_2 = SimpleInsItem:create(self.mAttrItem, self.AttrContent, "attritem_Module")
        local itemKey_2 = item_2:getChildGO("mTxtAttrName"):GetComponent(ty.Text)
        local itemValue_2 = item_2:getChildGO("mTxtAttrValue"):GetComponent(ty.Text)
        itemKey_2.text = keyName_2
        itemValue_2.text = skillVo_2.mDescTip
        -- itemValue.text = AttConst.getValueStr(skillVo.m_skillAttr[self.curData.suitSkillId_2].key, skillVo.m_skillAttr[self.curData.suitSkillId_2].value)
        table.insert(self.mAttrItems, item_2)
    end
    -- self.mTxtAbstractDec.text = skillVo.m_desc

end

function updateBtnState(self, curIndex)
    local data = self.dataList
    if data[curIndex] then
        self.curData = equip.EquipSuitManager:getEquipSuitConfigVo(data[curIndex])
        self:updateView()
        self:updatePropsShowView()
    end
end

function updatePropsShowView(self)
    self:recoverPropsItem()
    for k, v in pairs(self.dataList) do
        local item = SimpleInsItem:create(self.mPropItem, self.mItemTrans, "PropsShowItem2")
        local propConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(v)
        local mImgLock = item:getChildGO("mImgLock")
        local mImgProp = item:getChildGO("mImgProp"):GetComponent(ty.AutoRefImage)
        local mTextName = item:getChildGO("mTextName"):GetComponent(ty.Text)
        local mBtnClick = item:getChildGO("mBtnClick")
        local mImgIconBg = item:getChildGO("mImgIconBg"):GetComponent(ty.AutoRefImage)
        local mImgShadow = item:getChildGO("mImgShadow"):GetComponent(ty.AutoRefImage)
        local isHas = manual.ManualModuleManager:checkModuleIsUnlock(self.curData.suitId)
        mImgLock:SetActive(not isHas)
        mImgIconBg:SetImg(UrlManager:getPackPath("manual/manual_17.png"), true)
        mImgProp:SetImg(UrlManager:getIconPath(propConfigVo.icon), true)
        mImgShadow:SetImg(UrlManager:getPackPath("manual/manual_18.png"), true)
        mTextName.text = propConfigVo.name
        local equipVo = equip.EquipManager:getEquipConfigVo(v)
        item:setArgs({ index = k, vo = equipVo })
        table.insert(self.mPropItems, item)

    end
end

function recoveAttrItem(self)
    if #self.mAttrItems > 0 then
        for k, v in ipairs(self.mAttrItems) do
            v:poolRecover()
        end
        self.mAttrItems = {}
    end
end

function recoverPropsItem(self)
    if #self.mPropItems > 0 then
        for k, v in pairs(self.mPropItems) do
            v:poolRecover()
        end
        self.mPropItems = {}
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]