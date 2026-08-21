---@class AuditingPanel : AuditingPanel_Generate
---##################### 【AuditingPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【AuditingPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local AuditingPanel = require "AuditingPanel_Generate"

function AuditingPanel:InitLogic(data)
    self.healthText:FadeIn(1.5, function()
        DLuaTimer:DoAfter(1.5, function ()
            self.healthText:FadeOut(1, function()
                StateMgr:ChangeToState(GameFlowState.LoginState)
            end)
        end)
    end)
end

--function AuditingPanel:StartCreating(time)
--
--end

--function AuditingPanel:StartEnter(time)
--
--end

--function AuditingPanel:StartRemoving(time)
--
--end

--function AuditingPanel:StartExit(time)
--
--end

--function AuditingPanel:OnOpen(data, initiative)
--
--end

--function AuditingPanel:OnClose(initiative)
--
--end

--function AuditingPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function AuditingPanel:OnRefresh(data)
--
--end

return AuditingPanel
