--[[ 
-----------------------------------------------------
@filename       : DupChallengeEnterItem
@Description    : 挑战副本入口item
@date           : 2021-01-28 10:55:05
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('dup.DupChallengeEnterItem', Class.impl(BaseComponent))

UIRes = UrlManager:getUIPrefabPath('dupChallenge/DupChallengeItem.prefab')

function __initData(self)
    super.__initData(self)
    self.mImgBg = nil
    self.mTxtLocal = nil
    self.mTxtInfo = nil
    self.mTxtTime = nil
    self.mImgPass = nil
    self.mTxtPass = nil
    self.mBtnGroup = nil
    self.mProgressBar = nil
    self.mCanvasGroup = nil
    self.mTxtPro = nil
    LoopManager:removeTimerByIndex(self.timerId)
    self.timerId = nil

    LoopManager:clearTimeout(self.tweenId)
    self.tweenId = nil
end

-- 更新其他的信息显示
function __updateCustomView(self)

    self.mCanvasGroup = self:getChildGO("mBtnGroup"):GetComponent(ty.CanvasGroup)
    self:__updateState()
    self:__updateInfo()
    self:__updateTime()
    self:__updateRed()
    if not funcopen.FuncOpenManager:isOpen(self:getData().funcopenId) then
        return
    end
    self:__updateProgress()
end

function resShow(self)
    if (self.m_isLoadFinish and not gs.GoUtil.IsCompNull(self.m_uiGo:GetComponent(ty.UIDoTween))) then
        self.mCanvasGroup.gameObject:SetActive(true)
    end
end

function __tweenStart(self, time)
    local function callTween()
        if (self.m_isLoadFinish and not gs.GoUtil.IsCompNull(self.m_uiGo:GetComponent(ty.UIDoTween))) then
            self.mCanvasGroup.gameObject:SetActive(true)
            self.m_uiGo:GetComponent(ty.UIDoTween):BeginTween()
        end
    end

    self.tweenId = LoopManager:setTimeout(time, self, callTween)
end

-- function setTime(self,time)
--     self:__tweenStart(time)
-- end

function __removeEventList(self)
    if self.mBtnGroup then
        self:removeOnClick(self.mBtnGroup, self.onClickItemHandler)
    end
end

function __addEventList(self)
    if not self.mBtnGroup then
        self.mBtnGroup = self.m_childGos["mBtnGroup"]
    end
    self:addOnClick(self.mBtnGroup, self.onClickItemHandler)
end

function __updateInfo(self)
    if (self.m_isLoadFinish) then
        if not self.mImgBg then
            self.mImgBg = self.m_childGos["mImgBg"]:GetComponent(ty.AutoRefImage)
        end

        self.m_childGos["mDupName"]:GetComponent(ty.Text).text = self:getData().name

        if self:getData().type == 0 then
            self.mImgBg:SetImg(UrlManager:getPackPath("dup4/dup_challenge_enter_no.png"), true)
        else
            self.mImgBg:SetImg(UrlManager:getPackPath(string.format("dup4/dup_challenge_enter_%d.png", self:getData().type)), true)
            local isPass = seabed.SeabedManager:getSeabedEndIsPass()
            if self:getData().type == DupType.Seaded and isPass then
                self.mImgBg:SetImg(UrlManager:getPackPath(string.format("dup4/dup_challenge_enter_%d_end.png", self:getData().type)), true)
            end
            
        end
    end
end

function __updateProgress(self)
    if (self.m_isLoadFinish) then

        if not self.mTxtLocal then
            self.mTxtLocal = self.m_childGos["mTxtLocal"]:GetComponent(ty.Text)
        end
        if not self.mTxtInfo or not self.mTxtPro then
            self.mTxtInfo = self.m_childGos["mTxtInfo"]:GetComponent(ty.Text)
            self.mTxtPro = self.m_childGos["mTxtPro"]:GetComponent(ty.Text)
        end

        self.m_childGos["mBtnGroup"]:GetComponent(ty.CanvasGroup).alpha = 1
        self.m_childGos["mGroupInfo"]:SetActive(true)
        self.m_childGos["mMask"]:SetActive(false)

        self:getChildGO("mTxtPro"):SetActive(false)
        self:getChildGO("mProgressBar"):SetActive(false)
        if self:getData().type == DupType.DUP_CLIMB_TOWER or self:getData().type == DupType.Element and funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_CHELLENGE_TOWER, false) then
            self:getChildGO("mMask"):SetActive(true)
            self.mProBar = self:getChildGO("Bar"):GetComponent(ty.Image)
            self:getChildGO("mProgressBar"):SetActive(true)
            self:getChildGO("mTxtPro"):SetActive(true)
            local id = dup.DupClimbTowerManager:curDupId()
            local k, _ = dup.DupClimbTowerManager:getDupName(id)
            local areaId = dup.DupClimbTowerManager:maxAreaId()
            local progress = dup.DupClimbTowerManager:getDupProgressByAreaId(areaId)
            self.mTxtPro.text = math.floor(progress * 100) .. "%"
            self.mTxtRate = self:getChildGO("mTxtRate"):GetComponent(ty.Text)
            self.mTxtRate.text = "(" .. math.floor(progress * 100) .. "%)"
            self.mProBar.fillAmount = progress
            self.mTxtInfo.text = k
        elseif self:getData().type == DupType.DUP_CODE_HOPE and funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_CODE_HOPE, false) then
            local curVaue, maxValue, args = dup.DupChallengeManager:getDupProgress(self:getData().type)
            self.mTxtLocal.text = _TT(24501)--"当前位置"
            self.mTxtInfo.text = args .. "(" .. string.format("%.2f", curVaue / maxValue) * 100 .. "%)"
        elseif self:getData().type == DupType.DUP_MAZE and funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_MAZE, false) then
            -- 迷宫入口屏蔽显示进度

        end
    end
end

function __updateTime(self)
    if not self.mTxtTime then
        self.mTxtTime = self.m_childGos["mTxtTime"]:GetComponent(ty.Text)
    end

    if self:getData().type == DupType.DUP_CODE_HOPE then
        self.m_childGos["reTime"]:SetActive(false)
    elseif self:getData().type == DupType.DUP_IMPLIED then

        -- 每周一5点重置
        local onTimer = function()
            self.mTxtTime.text = _TT(71318, self:getResetTimeStr())
        end
        self.timerId = LoopManager:addTimer(1, 0, self, onTimer)
        onTimer()
    elseif self:getData().type == DupType.DUP_APOSTLE_WAR then
        -- 每周一5点重置
        local onTimer = function()
            self.mTxtTime.text = _TT(71318, dup.DupApostlesWarManager:getResetTimeStr())
        end
        self.timerId = LoopManager:addTimer(1, 0, self, onTimer)
        onTimer()
    elseif self:getData().type == DupType.DUP_MAZE then
        -- 迷宫屏蔽重置
        self.m_childGos["reTime"]:SetActive(false)
        -- -- 每周一5点重置
        -- local onTimer = function()
        --     self.mTxtTime.text =  _TT(71318, self:getResetTimeStr())
        -- end
        -- self.timerId = LoopManager:addTimer(1, 0, self, onTimer)
        -- onTimer()
    elseif self:getData().type == DupType.DUP_CLIMB_TOWER or self:getData().type == DupType.Element then
        self.m_childGos["reTime"]:SetActive(false)
    elseif self:getData().type == DupType.RogueLike then
        self.m_childGos["reTime"]:SetActive(false)
    elseif self:getData().type == DupType.Doundless then
        local onTimer = function()
            self.mTxtTime.text = _TT(71318, self:getResetTimeStr())
        end
        self.timerId = LoopManager:addTimer(1, 0, self, onTimer)
        onTimer()
    elseif self:getData().type == DupType.Seaded then
        self.m_childGos["reTime"]:SetActive(false)
    else
        self.mTxtTime.text = ""
    end
end

-- 每周一5点重置
function getResetTimeStr(self)
    local currentTime = GameManager:getClientTime()
    local reamainTime = GameManager:getWeekResetTime() - currentTime
    return TimeUtil.getFormatTimeBySeconds_1(reamainTime)
end

function __updateState(self)
    if (self.m_isLoadFinish) then
        if self:getData().type == 0 then
            self.m_childGos["mImgLock"]:SetActive(false)
            self.m_childGos["mImgPass"]:SetActive(false)
            self.m_childGos["mGroupInfo"]:SetActive(false)
            self.m_childGos["mBtnGroup"]:GetComponent(ty.CanvasGroup).alpha = 1
            return
        end

        if not funcopen.FuncOpenManager:isOpen(self:getData().funcopenId) then
            -- 未开启
            self.m_childGos["mImgLock"]:SetActive(true)
            self.m_childGos["mImgPass"]:SetActive(false)
            self.m_childGos["mGroupInfo"]:SetActive(false)
            return
        end

        if not self.mImgPass then
            self.mImgPass = self.m_childGos["mImgPass"]
        end

        local infoVo = dup.DupMainManager:getDupInfoData(self:getData().type)
        if not infoVo and self:getData().type == DupType.DUP_CLIMB_TOWER then
            -- 未开放
            self.m_childGos["mGroupInfo"]:SetActive(false)
            self.mImgPass:SetActive(false)
            return
        end

        if self:isPass() then
            -- 已通关
            self.m_childGos["mImgLock"]:SetActive(false)
            self.m_childGos["mGroupInfo"]:SetActive(false)
            self.mImgPass:SetActive(false)
            --self.mTxtPass.text = _TT(120)--"已通关"
            return
        end
        self.m_childGos["mImgLock"]:SetActive(false)
        self.m_childGos["mGroupInfo"]:SetActive(true)
        self.mImgPass:SetActive(false)
    end
end

function isPass(self)
    local infoVo = dup.DupMainManager:getDupInfoData(self:getData().type)
    local curId = 0
    if self:getData().type == DupType.DUP_CODE_HOPE then
        -- 代号·希望特殊处理
        curId = dup.DupCodeHopeManager:curDupId()
    elseif self:getData().type == DupType.DUP_IMPLIED then
        return false
    elseif self:getData().type == DupType.DUP_APOSTLE_WAR then
        return false
    elseif self:getData().type == DupType.DUP_MAZE then
        return false
    elseif self:getData().type == DupType.RogueLike then
        return false
    elseif self:getData().type == DupType.Element then
        return false
    elseif self:getData().type == DupType.Doundless then
        return false
    elseif self:getData().type == DupType.Seaded then
        return false
    else
        curId = infoVo.curId
    end
    if curId == 0 then
        return true
    end
    return false
end

function onClickItemHandler(self)
    if self:getData().type == 0 then
        gs.Message.Show(_TT(1021))
        return
    end
    if (self:getData().type == DupType.DUP_CLIMB_TOWER or self:getData().type == DupType.Element) then
        self:getData().type = dup.DupClimbTowerManager:getInDeep() and dup.DupClimbTowerManager.hasDeepData and DupType.Element or DupType.DUP_CLIMB_TOWER
    end
    if (self:getData().type == DupType.DUP_CLIMB_TOWER) then
        dup.DupClimbTowerManager:setPosIndex()
    elseif (self:getData().type == DupType.Element) then
        dup.DupClimbTowerManager:setDeepPosIndex()
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_CHALLENGE_DUP, self:getData().type)
end

function __updateRed(self)
    if (self.m_isLoadFinish) then
        local flag = false
        if self:getData().type == DupType.DUP_CODE_HOPE then
            flag = dup.DupCodeHopeManager:checkFlag()
        end
        if self:getData().type == DupType.DUP_APOSTLE_WAR then
            flag = dup.DupApostlesWarManager:checkFlag()
        end
        if self:getData().type == DupType.DUP_CLIMB_TOWER or self:getData().type == DupType.Element then
            flag = dup.DupClimbTowerManager:getFlag()
            mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_ADVENTURE, flag, funcopen.FuncOpenConst.FUNC_ID_CHELLENGE_TOWER)
        end

        if self:getData().type == DupType.RogueLike then
            flag = cycle.CycleManager:getRedFlag() or cycle.CycleTalentManager:getRedFlag()
        end

        if self:getData().type == DupType.Doundless then
            flag = doundless.DoundlessManager:getRedFlag()
        end

        if self:getData().type == DupType.Seaded then
            flag = seabed.SeabedManager:getRedFlag()
        end

        if flag then
            RedPointManager:add(self.m_childGos["mBtnGroup"].transform, nil, 110.5, 197)
        else
            RedPointManager:remove(self.m_childGos["mBtnGroup"].transform)
        end
    end
end

function poolRecover(self)
    if (self.m_isLoadFinish) then
        LoopManager:clearTimeout(self.timerId)
        self.tweenId = nil

        LoopManager:clearTimeout(self.tweenId)
        self.tweenId = nil
        RedPointManager:remove(self.m_childGos["mBtnGroup"].transform)
    end
    super.poolRecover(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]