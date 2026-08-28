------------ import ------------
local util = require "XLua.util"
local cs_coroutine = require("XLua.cs_coroutine")
local CoWait = CS.Engine.Lib.CoWait
local UIModule = CS.Engine.UI.UIModule
local KTool = CS.Engine.Lib.KTool
local Yielders = CS.Engine.Lib.Yielders
------------ import ------------

------------ define ------------
------------ define ------------

---@class UIBattlingCutInDialog
---@field SkillCutInRoot                	Engine.Modules.LuaBehaviour
local UIBattlingCutInDialog = Class("UIBattlingCutInDialog")

function UIBattlingCutInDialog:__init()
    self.showData = nil -- 显示Data
    self.showType = 0 -- 显示类型 1: BossCutIn 2: SKillCutIn
    self.showSkillCutInPanelLB = nil -- 展示技能 CutIn Panel
    self.eventShowSkillCutInEnd = nil -- 技能 CutIn 展示结束
    self.coPlayerCutInEnd = nil
end

function UIBattlingCutInDialog:__delete()
    self.showData = nil
    self.showType = nil
    self.showSkillCutInPanelLB = nil
    self.eventShowSkillCutInEnd = nil
    self.coPlayerCutInEnd = nil
    self.coProtectClose = nil
    self.controller = nil
    self = nil
end

function UIBattlingCutInDialog:Awake()
    self.controller.MarkPoolable = true ---缓存界面
    self.showSkillCutInPanelLB = self.SkillCutInRoot
    ---@type Engine.UI.UIArgument
    local argument = self.controller.Argument
    self.showType = argument.parameters.showType
    self.showData = argument.parameters.data
    self.eventShowSkillCutInEnd = Events.AddListener(Constants.EventNames.BattleCutInEnd, Bind(self, self.ShowCutInEnd))
    
    self.coProtectClose = cs_coroutine.start(function()
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(20))
        if not IsNull(self.coPlayerCutInEnd) then
            cs_coroutine.stop(self.coPlayerCutInEnd)
        end
        self:ProtectClose()
    end)
end

function UIBattlingCutInDialog:OnShow()
    xTry(function()
        if self.showType == 1 then  -- BossCutIn
            --if not IsNull(self.BossCutInRoot) then
            --    self.BossCutInRoot:Play(AnimationName)
            --    while self.BossCutInRoot.IsPlaying do
            --        coroutine.yield()
            --    end
            --    self:CloseDialog()
            --end
        elseif self.showType == 2 then  -- SkillCutIn
            if not IsNull(self.showSkillCutInPanelLB) then
                self.showSkillCutInPanelLB:Init()
                --UIBattlingTools.PlayAudio(nil) --todo暂无音效
                self.showSkillCutInPanelLB.Env:ShowCutIn(self.showData)
                --cs_coroutine.yield_return(self.showSkillCutInPanelLB.Env:ShowCutIn(self.showData))
            end
        end
        UIBattlingTools.PlayAudio(UISheets.UI_Battle.ui_battle_cuting)
    end)
end

function UIBattlingCutInDialog:OnInitialize()
end

function UIBattlingCutInDialog:OnFinalize()
    xTry(function()
        -- print("->UIBattlingCutInDialog:OnFinalize")
        Events.RemoveListener(Constants.EventNames.BattleCutInEnd, self.eventShowSkillCutInEnd)
        if self.coPlayerCutInEnd then
            cs_coroutine.stop(self.coPlayerCutInEnd)
        end
        if self.coProtectClose then
            cs_coroutine.stop(self.coProtectClose)
            self.coProtectClose = nil
        end
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end)
end

---SetBossImgPath
---展示 Boss 信息
---@param data table @ { bossId , roleId }
function UIBattlingCutInDialog:SetBossImgPath(data)
    --local bossId = data.bossId
    --local roleId = data.roleId
    --local skinId = UIBattlingDataMgr:GetSkinIdByRoleId(roleId)
    --local bossName = UIBattlingTools.GetMonsterVoById(bossId).name
    ----self.BossImg:Execute(skinId, 2)
    --if not isNull(self.NameText) then
    --    self.NameText.text = tostring(bossName)
    --end
end

---ShowCutInEnd
function UIBattlingCutInDialog:ShowCutInEnd()
    self.coPlayerCutInEnd = cs_coroutine.start(function()
        if (not isNull(self.showSkillCutInPanelLB)) and (not isNull(self.showSkillCutInPanelLB.Env)) then
            cs_coroutine.yield_return(self.showSkillCutInPanelLB.Env:PlayCutInEnd())
        end

        -- 这样关闭是为了其他监听关闭的地方如果有使用while进行等待的，可以有一帧的时间缓冲
        Events.Broadcast(Constants.EventNames.BattleCutInStartCloseDialog)  -- 先通知开始关闭了
        cs_coroutine.yield_return()                                         -- 然后等一帧
        KTool.SetActive(self.controller.gameObject, false)                  -- 防止不能立即关闭，这里直接隐藏
        UIModule.CloseDialog(self.controller)                               -- 开始关闭
    end)
end

---CloseDialog
---关闭页面
function UIBattlingCutInDialog:CloseDialog()
    Events.Broadcast(Constants.EventNames.BattleCutInStartCloseDialog)
    UIModule.CloseDialog(self.controller)
end

function UIBattlingCutInDialog:ProtectClose()
    self.controller.MarkPoolable = false
    self:CloseDialog()
end

return UIBattlingCutInDialog
