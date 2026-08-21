---@class BattleLosePanel : BattleLosePanel_Generate
---##################### 【BattleLosePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【BattleLosePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local BattleLosePanel = require "BattleLosePanel_Generate"
local BattleCore = require "BattleCore"
local failedAudioPath = string.format(Config.AudioPath.SE, "fight_failed")

function BattleLosePanel:InitLogic(data)

end

--function BattleLosePanel:StartCreating(time)
--
--end

--function BattleLosePanel:StartEnter(time)
--
--end

--function BattleLosePanel:StartRemoving(time)
--
--end

--function BattleLosePanel:StartExit(time)
--
--end

function BattleLosePanel:OnOpen(data, initiative)

    DLuaTimer:DoAfter(0.5, function()
        self:play2DSound(failedAudioPath)
    end)
    AudioMgr:StopCurrBgm(0.5)
    UIMgr:endDepositToast(GE.DepositToastType.Battle)
    self.tipsText.text.text = LocalStrEnum.BattleFailPrompt
end

--function BattleLosePanel:OnClose(initiative)
--
--end

--function BattleLosePanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function BattleLosePanel:OnRefresh(data)
--
--end

--[[
/RetryBtn onClick 
--]]
function BattleLosePanel:retryBtn_ScaleButton_onClick(retryBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
	local newPlayerLevel = {10101, 10102}
    for _, levelId in pairs(newPlayerLevel) do
        local battleMgr = BattleCore:getBattleMgr()
        local cfg = battleMgr:getLevelConfig()
        if cfg and cfg.id == levelId then
            --新手关卡失败，直接回到登录界面
            StateMgr:ChangeToState(GameFlowState.LoginState)
            return
        end
    end

    local battleMgr = BattleCore:getBattleMgr()
    battleMgr:clear()
    UIMgr:closeUI(self)
    LoadingMgr:SetLoadingStart(function()
        StateMgr:BackLastState()
    end, nil, nil, "BattleLosePanel")
end

--[[
/BackBtn onClick 
--]]
function BattleLosePanel:backBtn_ScaleButton_onClick(backBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    local newPlayerLevel = {10101, 10102}
    for _, levelId in pairs(newPlayerLevel) do
        local battleMgr = BattleCore:getBattleMgr()
        local cfg = battleMgr:getLevelConfig()
        if cfg and cfg.id == levelId then
            --新手关卡失败，直接回到登录界面
            StateMgr:ChangeToState(GameFlowState.LoginState)
            return
        end
    end

    local battleMgr = BattleCore:getBattleMgr()
    battleMgr:clear()
    UIMgr:closeUI(self)
    LoadingMgr:SetLoadingStart(function()
        StateMgr:BackLastState()
    end, nil, nil, "BattleLosePanel2")
end

return BattleLosePanel
