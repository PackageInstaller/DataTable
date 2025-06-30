module("manual.ManualBracelesInfoView", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("manual/ManualBracelesInfoView.prefab")
destroyTime = 0 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
--构造函数
function ctor(self, args)
    super.ctor(self, args)
    self:setSize(1334, 750);
    self:setBg("manual_bg.jpg", false, "manual")
    self:setTxtTitle("烙痕")
end

function initData(self)
    self.mAttrItems = {}
    self.mPropItems = {}
    self.mGameObjectItems = {}
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
    self.mGroupItem = self:getChildTrans("mGroupItem")
    self.AttrContent = self:getChildTrans("AttrContent")
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtColor = self:getChildGO("mTxtColor"):GetComponent(ty.Text)
    self.mImgColor = self:getChildGO("mImgColor"):GetComponent(ty.Image)
    self.mRightAni = self:getChildGO("mGroupRight"):GetComponent(ty.Animator)
    self.mTxtAbstractDec = self:getChildGO("mTxtAbstractDec"):GetComponent(ty.Text)

    --gs.GoUtil.RemoveComponent(self:getChildGO("mScrollView"),ty.ScrollEffect)
    --self.mScrollEffect = gs.GoUtil.AddComponent(self:getChildGO("mScrollView"),ty.ScrollEffect)
    self.mScrollEffect = self:getChildGO("mScrollView"):GetComponent(ty.ScrollEffect)
    --self.mScrollEffect = self:getChildGO("mScrollView"):GetComponent(ty.ScrollEffect)
end

--激活
function active(self, args)
    super.active(self, args)
    self.curData = args.curData
    self.dataList = args.dataList
    self.mIndex = table.indexof01(self.dataList, self.curData.tid)
    MoneyManager:setMoneyTidList()
    self:updateBtnState(self.mIndex)
    self:init()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoveAttrItem()
    self:recoverPropsItem()

    if self.mScrollEffect then
        self.mScrollEffect:OnClearAllItem()
    end

end

-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    super.onCloseAllCall(self)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnDetails, self.onClickOpenDetailsView)
end

function init(self)
    local gameObject = {}
    for _, item in ipairs(self.mPropItems) do
        local itemObject = item:getGo().gameObject
        if itemObject then
            table.insert(gameObject, itemObject)
        end
    end
    local index = self.mIndex > 0 and (self.mIndex - 1) or self.mIndex
    self.mScrollEffect:OnClearAllItem()
    self.mScrollEffect:setSelectIndex(index)
    self.mScrollEffect:setList(gameObject, function(curSelect)
        if self.mInit then
            self.mInit = false
        else
            self.mRightAni:SetTrigger("show")
        end

        self:updateView(curSelect)
        --self:updateBtnState(curSelect)
    end)
end

--打开详情页面
function onClickOpenDetailsView(self)

end

function initViewText(self)
end

function updateBtnState(self, curIndex)
    local data = self.dataList
    if data[curIndex] then
        self.curData = equip.EquipManager:getEquipConfigVo(data[curIndex])
        self:updateView()
        self:updatePropsShowView()
    end
end

function updateView(self, index)
    if index then
        local data = self.dataList
        self.curData = equip.EquipManager:getEquipConfigVo(data[index])
    end
    if self.curData and self.curData:getIsNew() then
        GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.MANUAL_BRACELET, id = self.curData.tid })
    end

    self:recoveAttrItem()
    local propConfigVo = props.PropsManager:getPropsConfigVo(self.curData.tid)
    local color = "2c98f3ff"
    local colorName = _TT(80001)
    if propConfigVo.color == 3 then
        colorName = _TT(80002)
        color = "e571ecff"
    elseif propConfigVo.color == 4 then --极品
        colorName = _TT(80003)
        color = "efad50ff"
    end
    self.mImgColor.color = gs.ColorUtil.GetColor(color)
    self.mTxtColor.text = hero.getColorName(propConfigVo.color)
    self.mTxtName.text = propConfigVo.name
    for k, v in pairs(self.curData.defaultAttrList) do
        local keyName = AttConst.getName(v[1])
        local item = SimpleInsItem:create(self.mAttrItem, self.AttrContent, "ManualBracelesInfoViewattritem")
        local itemKey = item:getChildGO("mTxtAttrName"):GetComponent(ty.Text)
        local itemValue = item:getChildGO("mTxtAttrValue"):GetComponent(ty.Text)
        itemKey.text = keyName
        itemValue.text = AttConst.getValueStr(v[1], v[2])
        table.insert(self.mAttrItems, item)
    end
    -- local skillVo = fight.SkillManager:getSkillRo(self.curData.skillId)
    local desc = self.curData:getSkillDesc()
    desc = string.gsub(desc, "038008", "18ec68") --替换关键字色
    self.mTxtAbstractDec.text = desc --skillVo:getDesc()
end

function updatePropsShowView(self)
    self:recoverPropsItem()

    for k, v in pairs(self.dataList) do
        local item = SimpleInsItem:create(self.mPropItem, self.mGroupItem, "ManualBracelesInfoViewPropsShowItem")
        local propConfigVo = props.PropsManager:getPropsConfigVo(v)
        local mBtnClick = item:getChildGO("mBtnClick")
        local mImgProp = item:getChildGO("mImgProp"):GetComponent(ty.AutoRefImage)
        local mTextName = item:getChildGO("mTextName"):GetComponent(ty.Text)
        local mImgIconBg = item:getChildGO("mImgIconBg"):GetComponent(ty.AutoRefImage)
        -- local mImgShadow = item:getChildGO("mImgShadow"):GetComponent(ty.AutoRefImage)
        mImgIconBg:SetImg(UrlManager:getPackPath("manual/manual_bracelets_" .. propConfigVo.color .. ".png"), true)

        -- if propConfigVo.subType == PropsEquipSubType.SLOT_7 and propConfigVo.type == PropsType.EQUIP then
        --     mImgProp:SetImg(UrlManager:getBraceletIconUrl(propConfigVo.tid), true)
        -- else
        mImgProp:SetImg(UrlManager:getIconPath(propConfigVo.icon), true)
        -- end

        --mImgProp:SetImg(UrlManager:getIconPath(propConfigVo.icon), true)
        mTextName.text = propConfigVo.name
        local path = "manual/manual_bracelets_" .. propConfigVo.color .. "_01.png"
        -- mImgShadow:SetImg(UrlManager:getPackPath(path), false)
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