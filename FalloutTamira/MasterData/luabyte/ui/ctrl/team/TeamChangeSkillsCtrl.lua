local M = BaseClass("TeamChangeSkillsCtrl", BaseUICtrl)
local tInsert = table.insert

function M:Init()
    self._view.mask:onClick(Bind(self, self.Close))
    self._view.confirm:onClick(Bind(self, self._OnClickConfirm))

    self._skillScroll = require("Framework.UI.Component.CircularScrollView").New(self._view.skillList)
    self._skillScroll:Init(require("UI.Ctrl.Team.TeamChangeSkillItemCtrl"), require("UI.View.Team.TeamChangeSkillItemView"))
    self._skillScroll:SetCreateItemCallback(Bind(self, self._OnCreateCallback))
    self._skillNum = GameHelper.GetParamter(183)
    if self._skillNum <= 0 then
        self._skillNum = 2
    end
end

function M:OnEnter(teamId, isEncounter)
    self._skillList = {}
    local commandSkills = nil
    self._teamData = GlobalTeamConfMgr:GetInstance().Mgr:GetTeamById(teamId)
    commandSkills = self._teamData and self._teamData.CommanderSkills or {}

    local skillDatas = CmderSkillMgr:GetUnlockSkills()
    local cmderSkills = {}

    if self._teamData then
        for i = 1, #commandSkills, 1 do
            local cmdId = commandSkills[i]

            if cmdId > 0 then
                cmderSkills[cmdId] = true
            end
        end
    end

    for _, value in ipairs(skillDatas) do
        value.IsChoose = cmderSkills[value.Config.cmdID] == true

        if value.IsChoose then
            tInsert(self._skillList, value.Config.cmdID)
        end
    end

    self._skillScroll:SetDataList(skillDatas)
end

-- 点击设置退出键
function M:OnDeviceBack()
    return self:OnBack()
end

function M:OnBack()
    self:Close()
    return true
end

function M:OnClose()
    self._skillList = {}
    self._teamData = nil
end

-- 确认技能按钮
function M:_OnClickConfirm(go)
    local selectCommandSkillIds = {}
    if self._teamData then
        self._teamData.CommanderSkills = self._skillList
        GlobalTeamConfMgr:GetInstance().Mgr:RequestUpdateTeam(self._teamData)
    else
        GameHelper.TipsById(4140)
    end
    self:Close()
end

function M:_OnCreateCallback(itemCtrl)
    itemCtrl:SetSelectCallback(function(data)
        if data.IsChoose then
            if #self._skillList >= self._skillNum then
                data.IsChoose = false
                GameHelper.TipsById(4141)
                return
            end

            tInsert(self._skillList, data.Config.cmdID)
        else
            for i = #self._skillList, 1, -1 do
                if self._skillList[i] == data.Config.cmdID then
                    table.remove(self._skillList, i)
                    break
                end
            end
        end

        self._skillScroll:UpdateList()
        -- end
    end)
end

return M
