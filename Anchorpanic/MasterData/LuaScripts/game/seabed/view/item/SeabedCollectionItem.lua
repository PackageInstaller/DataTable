module("seabed.SeabedCollectionItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mImgBg = self.UIObject:GetComponent(ty.AutoRefImage)

    self.mBuffBg = self:getChildGO("mBuffBg"):GetComponent(ty.AutoRefImage)
    self.mCollectionBg = self:getChildGO("mCollectionBg"):GetComponent(ty.AutoRefImage)

    self.mSelected = self:getChildGO("mSelected")
    self.mImgProps = self:getChildGO("mImgProps"):GetComponent(ty.AutoRefImage)
    self.mImgLocked = self:getChildGO("mImgLocked")
    self.mSelected = self:getChildGO("mSelected")
    self.mImgColorLine = self:getChildGO("mImgColorLine"):GetComponent(ty.AutoRefImage)
    self.isSelected = false
    self.mSelected:SetActive(false)
    self.mBtnClick = self:getChildGO("mBtnClick")
    self:addOnClick(self.mBtnClick, self.onClickHandler)

end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
end

function setData(self, data)
    super.setData(self, data)
    self.data = data
    self.id = data.id
    self.has = data.has
    local taskType = data.taskType

    if seabed.SeabedBattleType.Collage == taskType then
        self.mBuffBg.gameObject:SetActive(false)
        self.mCollectionBg.gameObject:SetActive(true)
    elseif seabed.SeabedBattleType.Buff == taskType then
        local index = 102 + data.color
        local path = "common_0" .. index .. ".png"
        self.mBuffBg:SetImg(UrlManager:getCommon5Path(path), false)
        self.mImgColorLine.color = gs.ColorUtil.GetColor(ColorUtil:getPropLineColor(data.color))
        self.mBuffBg.gameObject:SetActive(true)
        self.mCollectionBg.gameObject:SetActive(false)
    end
    -- if self.has then
    --     self.mImgProps.color = gs.ColorUtil.GetColor("FFFFFFFF")
    -- else
    --     self.mImgProps.color = gs.ColorUtil.GetColor("4D4D4DFF")
    -- end
    

    self.mImgProps.gameObject:SetActive(true)
    self.mImgProps:SetImg(UrlManager:getIconPath(data.icon), false)
    --self.mImgProps.color = gs.ColorUtil.GetColor("FFFFFFFF")
    self.mImgLocked:SetActive(self.has == false)
    self.mBtnClick:SetActive(true)
    self.mSelected:SetActive(data.isSelect)
end

function onClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.ON_CLICK_SEABED_COLLECTION_ITEM, self.data)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
