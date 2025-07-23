-- @FileName:   SandPlayHappyFarmTaskItem.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-09-05 10:32:34
-- @Copyright:   (LY) 2024 锚点降临

module("game.sandPlay.view.SandPlayHappyFarmTaskItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mTextName = self:getChildGO("mTextName"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mSelect = self:getChildGO("mSelect")
    self.mClick = self:getChildGO("mClick")
end

function active(self)
    super.active(self)

    GameDispatcher:addEventListener(EventName.SANDPLAY_HAPPYFARM_TASKSELECT, self.onSelect, self)

    self.mSelect:SetActive(false)
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mClick, function()
        GameDispatcher:dispatchEvent(EventName.SANDPLAY_HAPPYFARM_TASKSELECT, self.data)
    end)
end

function setData(self, data)
    super.setData(self, data)

    self.mTextName.text = data:getName()
    self.mImgIcon:SetImg(data:getIcon(), false)

    if sandPlay.SandPlayManager:getHappyFarmTaskRedStateById(self.data) then
        RedPointManager:add(self:getChildTrans("mRedPoint"), nil, 0, 0)
    else
        RedPointManager:remove(self:getChildTrans("mRedPoint"))
    end
end

function onSelect(self, data)
    self.mSelect:SetActive(self.data.id == data.id)
end

function deActive(self)
    super.deActive(self)

    GameDispatcher:removeEventListener(EventName.SANDPLAY_HAPPYFARM_TASKSELECT, self.onSelect, self)
end

return _M
