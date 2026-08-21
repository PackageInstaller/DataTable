module("equipBuild.EquipEmpowerPreparePanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("equipBuild/EquipEmpowerPreparePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
escapeClose = 0 -- 是否能通过esc关闭窗口
escapeClose = 0 -- 是否能通过esc关闭窗口

-- 构造函数
function ctor(self)
    super.ctor(self)
    -- self:setTxtTitle("")
end

-- 初始化数据
function initData(self)
    self.mAttrItemList = {}

end

function configUI(self)
    self.AttItem = self:getChildGO("AttItem")

    self.mLateAttr = self:getChildGO("mLateAttr")
    self.mCurAttr = self:getChildGO("mCurAttr")

    self.mCurAttrContent = self:getChildTrans("mCurAttr")
    self.mLateAttrContent = self:getChildTrans("mLateAttrContent")

    self.mBtnSure = self:getChildGO("mBtnSure")
    self.mBtnCancel = self:getChildGO("mBtnCancel")

    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)

    self.mClose = self:getChildGO("mClose"):GetComponent(ty.Image)

    self.mTextCancel = self:getChildGO("mTextCancel"):GetComponent(ty.Text)
    self.mTextSure = self:getChildGO("mTextSure"):GetComponent(ty.Text)
end

function initViewText(self)
    self.mTxtTitle.text = _TT(71481)
    self.mTextCancel.text = _TT(93112)
    self.mTextSure.text = _TT(93113)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnSure, self.onClickSure)
    self:addUIEvent(self.mBtnCancel, self.onClickCancel)
end

function active(self, args)
    super.active(self, args)
    self.m_NewAttr = args.newAttr

    self.mEquipVo = equipBuild.EquipStrengthenManager:getOpenEquipVo()
    self.mCurAttrList = self.mEquipVo:getTuPoAttachAttr()

    self.m_AttrItemList = {}

    local curAttr = self.mCurAttrList
    for i = 1, #curAttr do
        if not curAttr[i].isLock then
            local attrItem = SimpleInsItem:create(self.AttItem, self.mLateAttrContent, "EquipEmpowerUpPanel_attrItem")
            self.m_AttrItemList[i] = attrItem
            local attrNameStr = AttConst.getName(curAttr[i].key)
            attrItem:getChildGO("mTextAttDesc"):GetComponent(ty.Text).text = attrNameStr
            local attrValue = AttConst.getValueStr(curAttr[i].key, curAttr[i].value)
            attrItem:getChildGO("mTextAttrValueDesc"):GetComponent(ty.Text).text = attrValue
            table.insert(self.mAttrItemList, attrItem)
        end
    end

    local newAttr = self.m_NewAttr
    for i = 1, #newAttr do
        if newAttr[i].is_lock ~= 1 then
            local attrItem = SimpleInsItem:create(self.AttItem, self.mCurAttrContent, "EquipEmpowerUpPanel_attrItem")
            local attrNameStr = AttConst.getName(newAttr[i].key)
            attrItem:getChildGO("mTextAttDesc"):GetComponent(ty.Text).text = attrNameStr
            local attrValue = AttConst.getValueStr(newAttr[i].key, newAttr[i].value)
            attrItem:getChildGO("mTextAttrValueDesc"):GetComponent(ty.Text).text = attrValue
            table.insert(self.mAttrItemList, attrItem)
        end
    end
end

function deActive(self)
    for i = 1, #self.mAttrItemList, 1 do
        self.mAttrItemList[i]:poolRecover()
    end
    self.mAttrItemList = {}
    super.deActive(self)
end

function onClickSure(self)
    GameDispatcher:dispatchEvent(EventName.REQ_SURE_EMPOWER_RESULT, {
        equipId = self.mEquipVo.id,
        isSave = 1
    })
end

function onClickCancel(self)
    GameDispatcher:dispatchEvent(EventName.REQ_SURE_EMPOWER_RESULT, {
        equipId = self.mEquipVo.id,
        isSave = 0
    })
end

return _M
