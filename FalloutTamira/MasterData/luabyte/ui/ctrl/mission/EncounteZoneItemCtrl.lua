local M = BaseClass("EncounteZoneItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

function M:Init()
    self.m_index = 0
    self.m_zoneData = nil
    self.m_callback = nil
    self._view:onClick(Bind(self, self.OnClickItem))
    self._view.tf_remainTime.onComplete = Bind(self,self.OnTimer)
end

function M:UpdateItem(data, idx)
    self.m_index = idx
    self.m_zoneData = data 
    local nameId = self.m_zoneData:ZoneNameId()
    self._view.img_zoneIcon:SetPic(self.m_zoneData:IconPath())
    --self._view.txt_enName:SetText(self.m_zoneData:ZoneNameIdEn())
    self._view.txt_cnName:SetText(nameId)
    local passState = self.m_zoneData:ZoneState() 
    local fristPass = passState == EncountConst.EEncountZoneState.EFirstPass or passState == EncountConst.EEncountZoneState.EAllPass
    local secondPass = passState == EncountConst.EEncountZoneState.ESecondPass or passState == EncountConst.EEncountZoneState.EAllPass
    self._view.node_pass:SetActive(fristPass and secondPass)
    --4种情况  1：A领，B未领；2：B领，A未领；3、A、B都领 ；4：A、B双通关，并且全部领
    self._view.node_proc:SetActive(  not fristPass or not secondPass )
    self._view.node_leftOn:SetActive(fristPass )
    self._view.node_leftOff:SetActive(not fristPass )
    self._view.node_rightOn:SetActive(secondPass )
    self._view.node_rightOff:SetActive(not secondPass )
    self._isUnlock = data:GetOpenTime() < TimeUtil.GetNowTimeStamp()
    local diffcutly = self.m_zoneData:GetDiffculty()
    self._view.state_diffcult:SetState(diffcutly+1)
    if self._isUnlock == nil then 
        self._isUnlock = true 
    end
    self:SetUnLockState(fristPass,secondPass)
    self._view.tf_remainTime:SetActive(not self._isUnlock)
    -- if not self._isUnlock then
    --     self._view.tf_remainTime.timeFormat = "{0}后开启"
    --     self._view.tf_remainTime:SetTime(data:GetOpenTime())
    --     self._view.state_unlock:SetState(1)
    -- elseif not fristPass or not secondPass then 
    --     self._view.state_unlock:SetState(2)
    -- else
    --     self._view.state_unlock:SetState(3)
    -- end
    --self._view.trans_lock:SetActive(not self._isUnlock)
end

function M:SetUnLockState(fristPass,secondPass)
    if not self._isUnlock then
        self._view.tf_remainTime.timeFormat = "{0}后开启"
        self._view.tf_remainTime:SetTime(self.m_zoneData:GetOpenTime())
        self._view.state_unlock:SetState(1)
    elseif not fristPass or not secondPass then 
        self._view.state_unlock:SetState(2)
    else
        self._view.state_unlock:SetState(3)
    end
end

function M:Dispose()
    self._view.tf_remainTime.onComplete = nil
    self.m_zoneData = nil
    self.m_callback = nil
    M.super.Dispose(self)
end

function M:SetClickCallback(action)
    self.m_callback = action
end

function M:OnClickItem(go)
    if not self._isUnlock then 
        GameHelper.Tips(6184)
        return 
    end
    if self.m_callback then
        self.m_callback(self.m_index)
    end
end

function M:OnTimer()
    self._isUnlock = true
    local rewardState = self.m_zoneData:ZoneState() 
    local fristPass = rewardState == EncountConst.EEncountZoneState.EFirstPass or rewardState == EncountConst.EEncountZoneState.EAllPass
    local secondPass = rewardState == EncountConst.EEncountZoneState.ESecondPass or rewardState == EncountConst.EEncountZoneState.EAllPass
    self._view.tf_remainTime:SetActive(false)
    self:SetUnLockState(fristPass,secondPass)
    
end


return M
