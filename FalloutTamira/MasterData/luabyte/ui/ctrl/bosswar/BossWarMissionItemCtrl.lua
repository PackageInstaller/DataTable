local M = BaseClass("BossWarMissionItemCtrl")
local levelPath = "UI/SpritePics/simulation/ui_simulation_text_%02d"
local levelColors = {
    [1] = "3D9C7A",
    [2] = "3A84CA",
    [3] = "8946C7",
    [4] = "D7A231",
    [5] = "C62828"
}

function M:__init(view)
    self._view = view
    self._view.btn_mask:onClick(Bind(self, self.OnClickMask))
end

function M:OnDispose()
    self.m_data = nil
    self.m_index = nil
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

function M:UpdateItem(data, idx)
    if not data then return end

    local level = data:BattleLevel()
    self.m_data = data -- BossWarData
    self.m_index = idx
    self._view.img_head:SetPic(data:BossIcon())
    self._view.txt_name:SetText(data:BossName())
    self._view.txt_openTips:SetText(data:OpenTips())
    self._view.txt_level:SetColorTo16(levelColors[level])
    self._view.img_level:SetColorTo16(levelColors[level])
    self._view.txt_index:SetText(string.format("%02d", idx))
    self._view.img_level:SetPic(string.format(levelPath, level))

    local curStage, stageNum, percent = data:BloodStage()
    self._view.txt_rNum:SetText(tostring(stageNum))
    self._view.txt_lNum:SetText(tostring(stageNum - curStage))
    self._view.txt_blood:SetText(string.format("%d<size=20>%%</size>", percent))
    self._view.img_barFill:SetFillAmount(percent / 100)
    MissionHelper.SetBossBloodBar(self._view.img_bloodBar, curStage + 1)
    MissionHelper.SetBossBloodBar(self._view.img_barFill, curStage)
    if data:IsOpen() then
        if (percent <= 0) and ((curStage + 1) >= stageNum) then
            self._view.uiState:SetState(2) -- 已通过
        else
            self._view.uiState:SetState(1) -- 进行中
        end
        self._view.grayGroup:SetGrays(false)
    else
        self._view.uiState:SetState(3) -- 未开启
        self._view.grayGroup:SetGrays(true)
    end
end

function M:OnClickMask(go)
    if not self.m_data then return end

    if not self.m_data:IsOpen() then
        GameHelper.TipsById(self.m_data:OpenTips())
        return
    end
    UIContextMgr:GetInstance():Show("BossWarReadyUI", self.m_data, self.m_index)
end

return M
