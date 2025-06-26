-- @FileName:   FieldExplorationDupItem_220.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-08-23 17:20:27
-- @Copyright:   (LY) 2023 雷焰网络

module("game.fieldExploration.view.FieldExplorationDupItem_220", Class.impl(SimpleInsItem))

-- 设置data
function setData(self, dup_id, lastDup_id, statrPos, endPos, lineParent)
    self.mLastDup_id = lastDup_id
    self.mDupConfigVo = fieldExploration.FieldExplorationManager:getDupConfigVO(dup_id)

    self:getChildGO("mTextName_Normal"):GetComponent(ty.Text).text = self.mDupConfigVo.name
    self:getChildGO("mTextName_Select"):GetComponent(ty.Text).text = self.mDupConfigVo.name

    self.isCanPlay = true
    local isOpen = true

    if self.mLastDup_id ~= 0 then
        local lastRecord = fieldExploration.FieldExplorationManager:getPlayerDupRecord(self.mLastDup_id)
        if lastRecord <= 0 then
            self.isCanPlay = false
        end
    end

    -- if self.isCanPlay then
    if not table.empty(self.mDupConfigVo.begin_time) then
        local openDt = os.time(self.mDupConfigVo.begin_time)
        isOpen = GameManager:getClientTime() > openDt
    end

    if not isOpen then
        local data = self.mDupConfigVo.begin_time
        local str = string.format("%02d/%02d %02d:%02d%s", data.month, data.day, data.hour, data.min, _TT(92026))
        self:getChildGO("mTextOpenTime"):GetComponent(ty.Text).text = str
    end
    -- end

    self:getChildGO("OpenTime"):SetActive(not isOpen)

    local isPass = fieldExploration.FieldExplorationManager:getPlayerDupRecord(dup_id) ~= 0
    self:getChildGO("mIsNormalPass"):SetActive(isPass)
    self:getChildGO("mIsSelectPass"):SetActive(isPass)

    self:getChildGO("mRedImg"):SetActive(self.isCanPlay and not StorageUtil:getBool1(FieldExplorationConst.DupNewOpenStr .. dup_id) and fieldExploration.FieldExplorationManager:getPlayerDupRecord(dup_id) == 0)
    self:getChildGO("mLock"):SetActive(not self.isCanPlay or not isOpen)
    self:getChildGO("mInfo"):SetActive(self.isCanPlay and isOpen)

    local mImgLine01 = self:getChildGO("mImgLine01")
    if statrPos and endPos then
        local distance = math.abs(gs.Vector2.Distance(statrPos, endPos))

        local anchoredPosition = endPos - statrPos
        local angle = gs.Vector2.Angle(anchoredPosition, gs.Vector2.down)
        angle = anchoredPosition.x > 0 and angle * 1 or angle *- 1
        local mImgLine01_rect = mImgLine01:GetComponent(ty.RectTransform)
        mImgLine01_rect.sizeDelta = gs.Vector2(2, distance)
        mImgLine01_rect.localEulerAngles = gs.Vector3(0, 0, angle)

        mImgLine01:SetActive(true)
        self:getChildGO("mImgLine02"):SetActive(self.isCanPlay)
    else
        mImgLine01:SetActive(false)
    end
    mImgLine01.transform:SetParent(lineParent)

    self:addUIEvent("mBtnClick", self.onClick)
end

-- 回收
function recover(self)
    self:getChildTrans("mImgLine01"):SetParent(self.m_trans)
    self:getChildTrans("mImgLine01"):GetComponent(ty.RectTransform).anchoredPosition = gs.VEC2_ZERO
    super.recover(self)
end

function onClick(self)
    if self.mLastDup_id ~= 0 then
        local lastRecord = fieldExploration.FieldExplorationManager:getPlayerDupRecord(self.mLastDup_id)
        if lastRecord <= 0 then
            gs.Message.Show(_TT(99569))
            return
        end
    end

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
