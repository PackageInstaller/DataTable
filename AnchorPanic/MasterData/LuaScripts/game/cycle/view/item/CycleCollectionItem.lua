module("cycle.CycleCollectionItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mSelected = self:getChildGO("mSelected")
    self.mImgProps = self:getChildGO("mImgProps"):GetComponent(ty.AutoRefImage)
    self.mImgLocked = self:getChildGO("mImgLocked")
    self.mSelected = self:getChildGO("mSelected")
    self.isSelected = false
    self.mSelected:SetActive(false)
    self.mBtnClick = self:getChildGO("mBtnClick")
    self:addOnClick(self.mBtnClick, self.onClickHandler)

end


function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.COLLETION_ITEM_SELECTED, self.updateIsSelected, self)
    if cycle.CycleManager:checkIsCollectionSelected(self.id) then
        self.isSelected = true
    else
        self.isSelected = false
    end
    self.mSelected:SetActive(self.isSelected)

end

function deActive(self)
    super.deActive(self)
    self.mSelected:SetActive(false)
    GameDispatcher:removeEventListener(EventName.COLLETION_ITEM_SELECTED, self.updateIsSelected, self)
end


function setData(self, data)
    super.setData(self, data)
    self.data = data
    self.id = data.id
    self.has = data.has
    if self.data then
        if self.data.has then
            self.mImgProps.gameObject:SetActive(true)
            self.mImgProps:SetImg(UrlManager:getCycelCollectionIcon(data.icon), false)
            self.mImgProps.color = gs.ColorUtil.GetColor("FFFFFFFF")
            self.mImgLocked:SetActive(false)
            self.mBtnClick:SetActive(true)
        else
            local mTabViewType = cycle.CycleManager:getCollectTabViewType()
            if mTabViewType == COLLECTION_TYPE.ALL or mTabViewType == COLLECTION_TYPE.LACK then
                self.mImgProps.gameObject:SetActive(true)
                self.mImgProps:SetImg(UrlManager:getCycelCollectionIcon(data.icon), false)
                self.mImgProps.color = gs.ColorUtil.GetColor("4D4D4DFF")
                self.mImgLocked:SetActive(true)
                self.mBtnClick:SetActive(true)
            elseif mTabViewType == COLLECTION_TYPE.POSSESS then
                self.mImgProps.gameObject:SetActive(false)
                self.mImgLocked:SetActive(false)
                self.mBtnClick:SetActive(false)
            end

        end
    else
        self:deActive()
    end
end

function onClickHandler(self)
    cycle.CycleManager:setCollectionSelect(self.data)
end

function updateIsSelected(self)
    self.isSelected =cycle.CycleManager:checkIsCollectionSelected(self.id) 
    self.mSelected:SetActive(self.isSelected)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
