------------ import ------------
local util = require "XLua.util"
local CoWait = CS.Engine.Lib.CoWait
local Yielders = CS.Engine.Lib.Yielders
local UIModule = CS.Engine.UI.UIModule
local KTool = CS.Engine.Lib.KTool
local UIBattlingCtrlMgr = import("Game.UI.UIBattling.UIBattlingCtrlMgr")
local Text = CS.UnityEngine.UI.Text
------------ import ------------

------------ define ------------
local pathMissionDesc = "TxtCondition"
local Animations = {
    Common = "StartDialog_Enter",
    Target = "StartDialog_Enter_Target",
}
------------ define ------------

---@class UIBattleStartDialog
---@field ItemGroup2                    	UnityEngine.RectTransform
---@field ItemGroup1                    	UnityEngine.RectTransform
---@field ItemGroup                     	UnityEngine.RectTransform
---@field DefaultNode                   	UnityEngine.RectTransform
---@field PVPNode                       	UnityEngine.RectTransform
---@field TxtHand                       	UnityEngine.UI.Text
---@field Txt_BattleName                	UnityEngine.UI.Text
---@field RootAnimator                  	Animancer.NamedAnimancerComponent
local UIBattleStartDialog = Class("UIBattleStartDialog")

function UIBattleStartDialog:__init()
end

function UIBattleStartDialog:__delete()
    self.pathAnimation = nil
    self.listConditions = nil
    self.controller = nil
    self = nil
end

function UIBattleStartDialog:Awake()
    self.pathAnimation = Animations.Common
end

function UIBattleStartDialog:OnInitialize()
end

function UIBattleStartDialog:OnShow()
    local coWait = CoWait.Start():Coroutine(
            util.cs_generator(
                    function()
                        -- print("->TryPlay:UIBattleStartDialog:OnShow", checkString(self.pathAnimation))
                        self:SetPVEBattleName()
                        self.RootAnimator:TryPlay(checkString(self.pathAnimation))
                        UIBattlingTools.PlayAudio(UISheets.UI_Battle.ui_battle_start)
                        coroutine.yield(Yielders.GetWaitForSeconds(1.5))
                        UIModule.CloseDialog(self.controller)
                    end
            )
    )
    return coWait
end

function UIBattleStartDialog:OnFinalize()
    xTry(function()
        UIBattlingCtrlMgr:GetInstance():SetBooleanWaveDialogShowState(false)
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end)
end

function UIBattleStartDialog:SetPVEBattleName()
    local questId = UIBattlingDataMgr:GetQuestId()
    if isNotNull(questId) then
        local questVo = QuestConfMgr:GetInstance():GetQuestVoById(questId)
        if isNotNull(questVo) then
            local strBattleName = checkString(questVo.name)
            local strBattleLabel = checkString(questVo.label)
            KTool.SetActive(self.DefaultNode.gameObject, isNotNull(strBattleName))
            if isNotNull(self.Txt_BattleName) then
                local questType = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
                if checkNumber(questType) == Constants.IDType.QuestMainChallenge then
                    -- 困难主线不显示label
                    self.Txt_BattleName.text = string.format("%s",strBattleName)
                else
                    self.Txt_BattleName.text = string.format("%s %s",strBattleName, strBattleLabel)
                end
            end
        end
    end
end

return UIBattleStartDialog
