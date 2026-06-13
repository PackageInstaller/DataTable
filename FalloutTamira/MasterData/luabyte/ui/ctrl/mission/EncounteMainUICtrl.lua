local M = BaseClass("EncounteMainUICtrl", BaseUICtrl)

local itemCtrl = require("UI.Ctrl.Mission.EncounteZoneItemCtrl")
local itemView = require("UI.View.Mission.EncounteZoneItemView")

function M:Init()
    self._view.node_loopList:Init(itemCtrl, itemView)
    self._view.node_loopList:SetCreateItemCallback(Bind(self, self.OnCreateItem))
    --self._view.trans_diffcultyBtn:onClick(Bind(self,self._OnClickDiffculty))
    self._view.reward_area:onClick(Bind(self,self._OnReward))
    self._view.word_icon:onClick(Bind(self,self._OnClickWord))
    self._encount_gain_Hander = EventMgr:AddListener(UIMessageNames.ENCOUNT_GAIN_AWARD,Bind(self,self._OnGainNotice))
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.ENCOUNT_GAIN_AWARD,self._encount_gain_Hander)
    M.super.OnDispose(self)
end

function M:_OnReward(go)
    UIContextMgr:GetInstance():Show("EncounterAwardDetails",self.m_enData)
end

function M:_OnGainNotice()
    self:OnEnter(self.m_enData)
end

-- function M:_OnClickDiffculty(go)
--     local titleId = 5644 
--     local contentId = 5645
--     UIContextMgr:GetInstance():Show("ComTipsPopupUI",titleId, contentId)
-- end

function M:OnEnter(data)
    PlayerPrefTools.SetPlayerPrefs("EncounteFirstIn", 1)
    self.m_enData = data
    self._view.img_backPic:SetPic(self.m_enData:GetBackground())
    self._view.txt_showTime:SetText(self.m_enData:GetOpenTimeZone())
    self:_SetSeasonEntry()
    self:_InitZoneList()
    self:_RefreshSeasonAndCycleState()
    local list = self.m_enData:GetZoneDatas()
    local alreadyGain = 0 
    for i = 1, #list do
        alreadyGain = alreadyGain + list[i]:GetAlreadyGain()
    end
    self._view.reward_progressTf:SetText( alreadyGain ..  "/" .. #list*2 )
    local cycleOrder,totalCycle = EncounterHelper.GetCycleOrder(self.m_enData:GetCreateTick())
    self._view.battle_progress:SetProgress(cycleOrder,totalCycle)
    --设置周期词条
    self._view.word_icon:SetPic(self.m_enData:SeaosonIcon())
    self._view.word_txt:SetText(self.m_enData:SeasonEntryName())
    local entry = self.m_enData:SeasonEntry()
    self._view.word_area:SetActive(entry and #entry > 0 and entry[1] > 0 )
end

function M:_OnClickWord(go)
    UIContextMgr:GetInstance():Show("EncounterSeasonOpen", self.m_enData:GetDifficulty(), self.m_enData:GetCycleId())
end

--点击设置退出键
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true 
end


--刷新赛季和周期显示
function M:_RefreshSeasonAndCycleState()
    
    local diffcutly = self.m_enData:Diffculty()
    self._view.state_bg:SetState(diffcutly+1)
    local cycle = self.m_enData:GetCycleId()
    self._view.img_cycle_num:SetInfo(diffcutly,cycle)
end

function M:OnBack()
    self:Close()
    return false
end

function M:OnClose()
    
end

function M:_SetSeasonEntry()
    --self._view.node_seasonTag:SetActive(false)
    -- if self.m_enData:Diffculty() == EncountConst.EEncountDifficult.EDifficulty then
    --     self._view.txt_seasonTag:SetText(self.m_enData:SeasonEntryName())
    -- elseif self.m_enData:Diffculty() == EncountConst.EEncountDifficult.EMedium then
    --     self._view.txt_seasonTag:SetText(self.m_enData:WeakenEntryNames())
    -- else
    --     self._view.node_seasonTag:SetActive(false)
    -- end
end

function M:OnCreateItem(ctrl)
    ctrl:SetClickCallback(function(idx)
        --设置遭遇战的所有数据
        EnTeamConfMgr:GetInstance():SetEncouter(self.m_enData, idx)

        local zoneData = self.m_enData:GetZoneDataByIdx(idx)
        --通关通一半
        if zoneData:ZoneState() == EncountConst.EEncountZoneState.EFirstPass or zoneData:ZoneState() == EncountConst.EEncountZoneState.ESecondPass then 
            -- local selectMengagementMissionId = 0 
            -- if zoneData:ZoneState() == EncountConst.EEncountZoneState.EFirstPass then 
            --     selectMengagementMissionId = zoneData:GetEMissionCfg(EncountConst.EEncountTeamType.EteamB).id
            -- elseif zoneData:ZoneState() == EncountConst.EEncountZoneState.ESecondPass then 
            --     selectMengagementMissionId = zoneData:GetEMissionCfg(EncountConst.EEncountTeamType.ETeamA).id
            -- end
            -- UIContextMgr:GetInstance():Show("EncounterChoose", self.m_enData, idx , selectMengagementMissionId )
            UIContextMgr:GetInstance():Show("EncounterStageUI", self.m_enData, idx)
        else
            UIContextMgr:GetInstance():Show("EncounterStageUI", self.m_enData, idx)
        end
    end)
end

function M:_InitZoneList()
    local list = self.m_enData:GetZoneDatas()
    self._view.node_loopList:SetDataList(list)
end

return M
