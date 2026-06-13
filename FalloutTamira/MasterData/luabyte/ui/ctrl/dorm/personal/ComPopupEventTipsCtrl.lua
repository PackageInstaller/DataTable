local M = BaseClass("ComPopupEventTipsCtrl", BaseUICtrl)

function M:Init()
    self.m_queue = {}
    self.m_selectData = nil
    self._view.node_content:onClick(Bind(self, self.OnClickTips))
end

function M:OnEnter(list)
    self.m_queue = list

    self._view.node_content.pivot = Vector2.one
    local localPosition = self._view.node_content.localPosition
    localPosition.x = 0
    self._view.node_content.localPosition = localPosition
    self:_ShowTipsContent()
end

function M:OnClose()
    self.m_queue = {}
    self.m_selectData = nil
end

function M:_ShowTipsContent()
    self.m_selectData = self.m_queue[1]
    local missionId = self.m_selectData.MissionCfg.id
    local chapterId = self.m_selectData.MissionCfg.ChapterId
    self._view.txt_name:SetText(self.m_selectData.MissionCfg.name)
    PlayerPrefTools.SetPlayerPrefs("Chapter" .. chapterId, missionId)
    table.remove(self.m_queue, 1)
    -- 0.5秒内打开
    self._view.node_content:SetDoLocalMoveX(410, 0.5):OnTweenComplete(function()
        --显示3秒
        self._view.node_content:SetDoLocalMoveX(410, 3):OnTweenComplete(function()
            -- 0.5秒内关闭
            self._view.node_content:SetDoLocalMoveX(0, 0.5):OnTweenComplete(function()
                if #self.m_queue <= 0 then
                    self:Close()
                    return
                end
                self:_ShowTipsContent()
            end)
        end)
    end)
end

function M:OnClickTips(go)
    if not self.m_selectData then return end

    -- 关闭点击跳转
    -- ModuleMgr:GetInstance():ChangeModule(
    --     ModuleConfig.Dorm.id,
    --     self.m_selectData.HeroId
    -- )
end

return M
