module("game.purchase.fashionShop.view.item.FashionSceneItem", Class.impl("lib.component.BaseItemRender"))
--对应的ui文件
function onInit(self, go)
    super.onInit(self, go)

    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mImgHas = self:getChildGO("mImgHas")

    self.mGroupTime = self:getChildGO("mGroupTime")
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
end

function setIsSelect(self, isSelect)
    self.mImgSelect:SetActive(isSelect)
end

function initData(self)
    super.initData(self)
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)

    if self.time then
        LoopManager:removeTimerByIndex(self.time)
        self.time = nil
    end
end

function addAllUIEvent(self)
    self:addUIEvent(self.mImgIcon.gameObject, self.onClickSelectHandler)
end

function onClickSelectHandler(self)
    GameDispatcher:dispatchEvent(EventName.UPDATE_SELECT_FASHION_SCENE, self.mData)
end

function setData(self, param)
    super.setData(self, param)
    self.mData = param
    if param.isSelect == nil then
        param.isSelect = false
    end
    self:setIsSelect(param.isSelect)
    self.mImgHas:SetActive(purchase.FashionShopManager:getFashionSceneOrPairtsIsBuy(param.id))
    self.mImgIcon:SetImg(UrlManager:getFashionComboPath(param.configChildVo.icon), false)

    self.mGroupTime:SetActive(self.mData:getTime() > 0)
    if self.mData:getTime() > 0 then

        if self.time then
            LoopManager:removeTimerByIndex(self.time)
            self.time = nil
        end
        self:updateTime()
        self.time = LoopManager:addTimer(1, 0, self, self.updateTime)
    end
end

function updateTime(self)
    self.mTxtTime.text = TimeUtil.getFormatTimeBySeconds_10(self.mData:getTime())

    if self.mData:getTime() <= 0 then
        GameDispatcher:dispatchEvent(EventName.UPDATE_FASHION_COMBO_VIEW)
    end
end

return _M
