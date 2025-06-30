-- @FileName:   FieldExplorationDupItem_213.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-08-23 17:20:27
-- @Copyright:   (LY) 2023 雷焰网络

module("game.fieldExploration.view.FieldExplorationDupItem_213", Class.impl(SimpleInsItem))

-- 设置data
function setData(self, dup_id, lastDup_id)
    self.mLastDup_id = lastDup_id
    self.mDupConfigVo = fieldExploration.FieldExplorationManager:getDupConfigVO(dup_id)

    self:getChildGO("mTextName_Normal"):GetComponent(ty.Text).text = self.mDupConfigVo.name
    self:getChildGO("mTextName_Select"):GetComponent(ty.Text).text = self.mDupConfigVo.name

    self.isCanPlay = fieldExploration.FieldExplorationManager:getDupIsOpen(lastDup_id, dup_id)

    if self.isCanPlay then
        local starCount = fieldExploration.FieldExplorationManager:getPlayerDupStar(dup_id)
        for i = 1, 3 do
            self:getChildGO("mImgStar_" .. i):SetActive(starCount >= i)
        end
    end

    self:getChildGO("mRedImg"):SetActive(self.isCanPlay and not StorageUtil:getBool1(FieldExplorationConst.DupNewOpenStr .. dup_id))

    self:getChildGO("mInfo"):SetActive(self.isCanPlay)
    self:getChildGO("mLock"):SetActive(not self.isCanPlay)

    self:addUIEvent("mBtnClick", self.onClick)
end

function onClick(self)
    local isOpen = true
    if not table.empty(self.mDupConfigVo.begin_time) then
        local openDt = os.time(self.mDupConfigVo.begin_time)
        isOpen = GameManager:getClientTime() > openDt
    end

    if not isOpen then
        local data = self.mDupConfigVo.begin_time
        local str = string.format("%02d/%02d %02d:%02d%s", data.month, data.day, data.hour, data.min, _TT(92026))
        gs.Message.Show(str)
        return
    end

    if self.mLastDup_id ~= 0 then
        local lastRecord = fieldExploration.FieldExplorationManager:getPlayerDupRecord(self.mLastDup_id)
        if lastRecord <= 0 then
            gs.Message.Show(_TT(99569))
            return
        end
    end

    if self.isSelect then return end

    StorageUtil:saveBool1(FieldExplorationConst.DupNewOpenStr .. self.mDupConfigVo.dup_id, true)
    self:getChildGO("mRedImg"):SetActive(self.isCanPlay and not StorageUtil:getBool1(FieldExplorationConst.DupNewOpenStr .. self.mDupConfigVo.dup_id))

    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)

    self:select()
    GameDispatcher:dispatchEvent(EventName.SELECT_FIELDEXPLORATION_DUP, self.mDupConfigVo.dup_id)
end

function select(self)
    self.isSelect = true
    self:refreshSelectState()
end

function unSelect(self)
    self.isSelect = false
    self:refreshSelectState()
end

function refreshSelectState(self)
    self:getChildGO("mNormal"):SetActive(not self.isSelect)
    self:getChildGO("mSelect"):SetActive(self.isSelect)
end

return _M
