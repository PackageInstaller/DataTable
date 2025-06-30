-- @FileName:   ShootBrickStageItem.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2024-01-31 15:58:03
-- @Copyright:   (LY) 2023 雷焰网络

module("game.shootBrick.view.ShootBrickStageItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mTextName = self:getChildGO("mTextName"):GetComponent(ty.Text)
    self.mLock = self:getChildGO("mLock")
    self.mStarGroup = self:getChildGO("mStarGroup")
    self.mRayPoint = self:getChildTrans("mRayPoint")
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.UIObject, function()
        if not self.data.config:isOpen() then
            local data = self.data.config.begin_time
            local str = string.format("%02d/%02d %02d:%02d%s", data.month, data.day, data.hour, data.min, _TT(92026))
            gs.Message.Show(str)
            return
        end

        if self.data.lock then
            gs.Message.Show(_TT(99569))
            return
        end

        self:refreshDupRedPoint()

        GameDispatcher:dispatchEvent(EventName.SHOOTBRICK_STAGE_SELECT, self.data.config.id)
    end)
end

function addEventListener(self)
    GameDispatcher:addEventListener(EventName.SHOOTBRICK_STAGE_SELECT, self.onSelect, self)
end

function removeEventListener(self)
    GameDispatcher:removeEventListener(EventName.SHOOTBRICK_STAGE_SELECT, self.onSelect, self)
end

function active(self)
    super.active(self)

    self:addEventListener()
end

function deActive(self)
    super.deActive(self)

    self:removeEventListener()
end

function setData(self, data)
    super.setData(self, data)

    self.mTextName.text = self.data.config:getName()

    self.mLock:SetActive(self.data.lock)

    if not self.data.lock then
        self.mStarGroup:SetActive(true)
        local passStar = shootBrick.ShootBrickManager:getPassStageStar(self.data.config.id)
        for i = 1, 3 do
            self.m_childGos["mImgStar_" .. i]:SetActive(i <= passStar)
        end
    else
        self.mStarGroup:SetActive(false)
    end

    self:onSelect(shootBrick.ShootBrickManager:getSelectDup_id())
    self:refreshDupRedPoint()
end

function onSelect(self, dupId)
    self.mImgSelect:SetActive(dupId == self.data.config.id)
    if dupId == self.data.config.id then
        StorageUtil:saveBool1(gstor.SHOOTBRICK_DUPNEWOPENSTR .. self.data.config.id, true)
    end
end

function refreshDupRedPoint(self)
    if shootBrick.ShootBrickManager:getDupShowRed(self.data.config) then
        RedPointManager:add(self.mRayPoint, nil, 0, 0)
    else
        RedPointManager:remove(self.mRayPoint)
    end
end

return _M
