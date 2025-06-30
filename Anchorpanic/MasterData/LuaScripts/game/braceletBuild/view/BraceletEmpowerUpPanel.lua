-- @FileName:   BraceletEmpowerUpPanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-09-21 15:08:56
-- @Copyright:   (LY) 2023 雷焰网络

module("braceletBuild.BraceletEmpowerUpPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("braceletBuild/BraceletEmpowerUpPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
escapeClose = 0 -- 是否能通过esc关闭窗口
escapeClose = 0 -- 是否能通过esc关闭窗口

--构造函数
function ctor(self)
    super.ctor(self)
    -- self:setTxtTitle("")
end

-- 初始化数据
function initData(self)

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
    self.mTxtTitle.text = _TT(93109)
    self.mTextCancel.text = _TT(93112)
    self.mTextSure.text = _TT(93113)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnSure, self.onClickSure)
    self:addUIEvent(self.mBtnCancel, self.onClickCancel)
end

function active(self, args)
    super.active(self, args)
    self.m_NewAttr = args

    self.mEquipVo = braceletBuild.BraceletBuildManager:getOpenEquipVo()
    self.mCurAttrList = self.mEquipVo:getBracelet_remake_attr()

    self.m_AttrItemList = {}

    if table.empty(self.mCurAttrList) then
        self.mLateAttr:SetActive(false)
        self.mBtnSure:SetActive(false)
        self.mBtnCancel:SetActive(false)
        self.mClose.raycastTarget = false
    else
        self.mLateAttr:SetActive(true)
        self.mBtnSure:SetActive(true)
        self.mBtnCancel:SetActive(true)
        self.mClose.raycastTarget = true

        local curAttr = self.mCurAttrList
        for i = 1, #curAttr do
            if not curAttr[i].is_lock then
                local attrItem = SimpleInsItem:create(self.AttItem, self.mLateAttrContent, "BraceletEmpowerUpPanel_attrItem")
                self.m_AttrItemList[i] = attrItem

                attrItem:getChildGO("mTextAttValue"):GetComponent(ty.Text).text = string.format("<size=26><color=#ffffff>%s</color></size>/%s", curAttr[i].level, curAttr[i].maxLevel)

                attrItem:getChildGO("mImgAttrDown"):SetActive(false)
                attrItem:getChildGO("mImgAttrUp"):SetActive(false)

                local attrNameStr = AttConst.getName(curAttr[i].attrType)
                local attrValue = AttConst.getValueStr(curAttr[i].attrType, curAttr[i].attrValue)
                local attrValueStr = string.format("<color=#FFFFFF>+%s</color>", attrValue)

                attrItem:getChildGO("mTextAttrValueDesc"):GetComponent(ty.Text).text = attrNameStr .. attrValueStr
            end
        end
    end

    local newAttr = self.m_NewAttr.bracelet_remake_attr
    for i = 1, #newAttr do
        if not newAttr[i].is_lock then
            local attrItem = SimpleInsItem:create(self.AttItem, self.mCurAttrContent, "BraceletEmpowerUpPanel_attrItem")
            self.m_AttrItemList[i] = attrItem

            attrItem:getChildGO("mTextAttValue"):GetComponent(ty.Text).text = string.format("<size=26><color=#ffffff>%s</color></size>/%s", newAttr[i].level, newAttr[i].maxLevel)
            local attrNameStr = AttConst.getName(newAttr[i].attrType)

            attrItem:getChildGO("mImgAttrDown"):SetActive(false)
            attrItem:getChildGO("mImgAttrUp"):SetActive(false)

            local color = "FFFFFF"
            if self.mCurAttrList[i] and self.mCurAttrList[i].attrType == newAttr[i].attrType then
                if newAttr[i].attrValue < self.mCurAttrList[i].attrValue then
                    color = "fa3a2b"
                elseif newAttr[i].attrValue > self.mCurAttrList[i].attrValue then
                    color = "18ec68"
                end

                attrItem:getChildGO("mImgAttrDown"):SetActive(newAttr[i].attrValue < self.mCurAttrList[i].attrValue)
                attrItem:getChildGO("mImgAttrUp"):SetActive(newAttr[i].attrValue > self.mCurAttrList[i].attrValue)
            end

            local attrValue = AttConst.getValueStr(newAttr[i].attrType, newAttr[i].attrValue)
            local attrValueStr = string.format("<color=#%s>+%s</color>", color, attrValue)
            attrItem:getChildGO("mTextAttrValueDesc"):GetComponent(ty.Text).text = attrNameStr .. attrValueStr
        end
    end
end

function deActive(self)
    super.deActive(self)

end

function onSaveAttr(self, isSave, langId)
    if langId ~= nil then
        UIFactory:alertMessge(_TT(langId), true, function ()
            GameDispatcher:dispatchEvent(EventName.REQ_HERO_BRA_SAVE_ATTR, {equipId = self.mEquipVo.id, isSave = isSave})
        end, nil, nil, true)
    else
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_BRA_SAVE_ATTR, {equipId = self.mEquipVo.id, isSave = isSave})
    end
end

function isAttrChange(self)
    local newAttr = self.m_NewAttr.bracelet_remake_attr
    for i = 1, #newAttr do
        if newAttr[i].level ~= self.mCurAttrList[i].level then
            return true
        end
    end
    return false
end

function onClickSure(self)
    if self:isAttrChange() then
        local isAllDown = true --是否所有的属性都比现有属性低

        local curAttr = self.mCurAttrList
        for i = 1, #curAttr do
            if not curAttr[i].is_lock then
                if self.m_NewAttr.bracelet_remake_attr[i].level > curAttr[i].level or self.m_NewAttr.bracelet_remake_attr[i].attrType ~= curAttr[i].attrType then
                    isAllDown = false
                    break
                end
            end
        end

        if isAllDown then
            self:onSaveAttr(true, 93123)
        else

            self:onSaveAttr(true)
        end
    else
        self:onSaveAttr(true)
    end
end

function onClickCancel(self)
    if self:isAttrChange() then
        local isAllUp = true --是否所有的属性都比现有的属性高

        local newAttr = self.m_NewAttr.bracelet_remake_attr
        for i = 1, #newAttr do
            if not newAttr[i].is_lock then
                if newAttr[i].level >= newAttr[i].maxLevel then
                    self:onSaveAttr(false, 93121)
                    return
                elseif isAllUp and newAttr[i].level < self.mCurAttrList[i].level or newAttr[i].attrType ~= self.mCurAttrList[i].attrType then
                    isAllUp = false
                end
            end
        end

        if isAllUp then
            self:onSaveAttr(false, 93122)
        else
            self:onSaveAttr(false)
        end
    else
        self:onSaveAttr(false)
    end
end

return _M
