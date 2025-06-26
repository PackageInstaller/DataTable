module("manual.ManualModuleItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mNewTans = self:getChildGO("mNewTans")
    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mImgLock = self:getChildGO("mImgLock")
    self.mImgProp = self:getChildGO("mImgProp"):GetComponent(ty.AutoRefImage)
    -- self.mImgJob = self:getChildGO("mImgJob"):GetComponent(ty.AutoRefImage)
    self.mTextName = self:getChildGO("mTextName"):GetComponent(ty.Text)
    -- self.mTextUnLock = self:getChildGO("mTextUnLock"):GetComponent(ty.Text)
    self.mBtnClick = self:getChildGO("mBtnClick")
    self.mImgIconBg = self:getChildGO("mImgIconBg"):GetComponent(ty.AutoRefImage)
    self:addOnClick(self.mBtnClick, self.onClickHandler)
end

function setData(self, param)
    super.setData(self, param)
    local selectVo = self.data
    self.propConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(selectVo.suitId)
    self.isUnLock = manual.ManualModuleManager:checkModuleIsUnlock(selectVo.suitId)
    self.mImgLock:SetActive(not self.isUnLock)
    self.mImgIconBg:SetImg(UrlManager:getPackPath("manual/manual_17.png"), false)
    self.mImgProp:SetImg(UrlManager:getIconPath(self.propConfigVo.icon), true)
    self.mTextName.text = self.propConfigVo.name
    self.mNewTans:SetActive(selectVo:getIsNew())
end

function onClickHandler(self)
    if self.isUnLock then
        if self.data:getIsNew() then
            GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.MANUAL_CHIP, id = self.data.suitId })
        end
        GameDispatcher:dispatchEvent(EventName.OPEN_MODULE_DETAIL, { curData = self.data, dataList = manual.ManualModuleManager:getUnlockModuleList() })
    else
        gs.Message.Show("模组尚未解锁")
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