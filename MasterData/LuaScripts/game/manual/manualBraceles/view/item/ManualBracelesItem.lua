module("manual.ManualBracelesItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mImgProp = self:getChildGO("mImgProp"):GetComponent(ty.AutoRefImage)
    -- self.mImgJob = self:getChildGO("mImgJob"):GetComponent(ty.AutoRefImage)
    self.mTextName = self:getChildGO("mTextName"):GetComponent(ty.Text)
    -- self.mTextUnLock = self:getChildGO("mTextUnLock"):GetComponent(ty.Text)
    self.mBtnClick = self:getChildGO("mBtnClick")
    self.mNewTans = self:getChildGO("mNewTans")
    self.mImgIconBg = self:getChildGO("mImgIconBg"):GetComponent(ty.AutoRefImage)
    self:addOnClick(self.mBtnClick, self.onClickHandler)
end

function setData(self, param)
    super.setData(self, param)
    local selectVo = self.data
    self.propConfigVo = props.PropsManager:getPropsConfigVo(selectVo.tid)

    self.isUnLock = manual.ManualManager:jugEquipHasUnlock(self.propConfigVo.color, selectVo.tid)
    self:getChildGO("mGroupLocked"):SetActive(not self.isUnLock)
    self.mImgIconBg:SetImg(UrlManager:getPackPath("manual/manual_bracelets_" .. self.propConfigVo.color .. ".png"), false)

    self.mImgProp:SetImg(UrlManager:getIconPath(self.propConfigVo.icon), true)
    -- if self.propConfigVo.subType == PropsEquipSubType.SLOT_7 and self.propConfigVo.type == PropsType.EQUIP then
    --     self.mImgProp:SetImg(UrlManager:getBraceletIconUrl(selectVo.tid), false)
    -- else
    --     self.mImgProp:SetImg(UrlManager:getIconPath(self.propConfigVo.icon), false)
    -- end
    self.mNewTans:SetActive(selectVo:getIsNew())
    self.mTextName.text = self.propConfigVo.name
end

function onClickHandler(self)
    if self.isUnLock then
        local tabIndex = manual.ManualManager:getLastIndex()
        local colorType = manual.getTabList(manual.ManualType.SolderingMark)[tabIndex].colorType
        GameDispatcher:dispatchEvent(EventName.OPEN_BRACELES_DETAIL, { curData = self.data, dataList = manual.ManualManager:getUnlockEquipList(colorType) })
    else
        gs.Message.Show(_TT(80026))
    end
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    self:removeOnClick(self.mBtnClick, self.onClickHandler)
    super.onDelete(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]