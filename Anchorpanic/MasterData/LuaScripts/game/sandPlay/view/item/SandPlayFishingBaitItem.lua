-- @FileName:   SandPlayFishingBaitItem.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-12-20 14:48:32
-- @Copyright:   (LY) 2023 雷焰网络

module("sandPlay.SandPlayFishingBaitItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTextBaitName = self:getChildGO("mTextBaitName"):GetComponent(ty.Text)
    self.mTextNum = self:getChildGO("mTextNum"):GetComponent(ty.Text)

    self.mSelect = self:getChildGO("mSelect")
end

function setData(self, data)
    super.setData(self, data)

    self.mImgIcon:SetImg(UrlManager:getPropsIconUrl(self.data.id), false)

    local propsConfigVo = props.PropsManager:getPropsConfigVo(self.data.id)
    self.mTextBaitName.text = propsConfigVo:getName()

    local count = bag.BagManager:getPropsCountByTid(self.data.id)
    local color = count <= 0 and "fa3a2b" or"ffffff"
    self.mTextNum.text = string.format("<color=#%s>%s</color>", color, count)

    self:refreshSelect()
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.UIObject, function()
        sandPlay.SandPlayManager:setFishingBait(self.data.id)
    end)
end

function active(self)
    super.active(self)

    GameDispatcher:addEventListener(EventName.SANDPLAY_FISHING_BAITSELECT, self.refreshSelect, self)
end

function deActive(self)
    super.deActive(self)

    GameDispatcher:removeEventListener(EventName.SANDPLAY_FISHING_BAITSELECT, self.refreshSelect, self)
end

function refreshSelect(self)
    local isSelect = sandPlay.SandPlayManager:getFishingBait() == self.data.id
    self.mSelect:SetActive(isSelect)
end

return _M
