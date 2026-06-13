
--- 遭遇战赛季结算
local EncounterSeasonSettlementCtrl = BaseClass("EncounterSeasonSettlementCtrl",BaseUICtrl)
local M = EncounterSeasonSettlementCtrl

local difficlutLanguageIds = {"简单","普通" ,"困难"}

function M:Init()
    self._view.clickBg:onClick(Bind(self,self._OnClickBg))
end

function M:_OnClickBg(go)
    self:Close()
end

function M:OnEnter(encounteData)
    self._view.state_bg:SetState(encounteData:GetDifficulty()+1)
    self.m_enData = encounteData
    local diffcutly = self.m_enData:Diffculty() + 1
    local fromDiffculity = self.m_enData:Diffculty() 
    local cycle = self.m_enData:GetCycleId()
    local cycleImgPath = "UI/SpritePics/encounter/ui_sidecabin_number_" .. string.format("%02d",diffcutly) .. "_" .. string.format("%02d",cycle)
    self._view.img_cycle_num:SetPic(cycleImgPath)
    self._view.txt_fromDiffcult:SetText(fromDiffculity)
    self._view.txt_toDiffcult:SetText(diffcutly)
end

return EncounterSeasonSettlementCtrl