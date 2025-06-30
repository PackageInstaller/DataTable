-- @FileName:   DanKeStageItem.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2024-01-31 15:58:03
-- @Copyright:   (LY) 2023 雷焰网络

module("game.danke.view.DanKeStageItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mTextName = self:getChildGO("mTextName"):GetComponent(ty.Text)
    self.mLock = self:getChildGO("mLock")
    self.mStarGroup = self:getChildGO("mStarGroup")
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

        GameDispatcher:dispatchEvent(EventName.DANKE_STAGE_SELECT, self.data.config.id)
    end)
end

function addEventListener(self)
    GameDispatcher:addEventListener(EventName.DANKE_STAGE_SELECT, self.onSelect, self)
end

function removeEventListener(self)
    GameDispatcher:removeEventListener(EventName.DANKE_STAGE_SELECT, self.onSelect, self)
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

    self.mTextName.text = _TT(self.data.config.stage_name)

    self.mLock:SetActive(self.data.lock)

    if not self.data.lock then
        self.mStarGroup:SetActive(true)
        local passStar = danke.DanKeManager:getPassStageMaxStar(self.data.config.id)
        for i = 1, 3 do
            self.m_childGos["mImgStar_" .. i]:SetActive(i <= passStar)
        end
    else
        self.mStarGroup:SetActive(false)
    end

    self:onSelect(danke.DanKeManager:getStage_id())
end

function onSelect(self, stage_id)
    self.mImgSelect:SetActive(stage_id == self.data.config.id)
end

return _M
