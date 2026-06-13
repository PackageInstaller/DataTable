local M = BaseClass("ComPopupMopUpTipsCtrl", BaseUICtrl)

function M:Init()
    self.m_tipsFormat = ConfigHelper.GetLocalString(5217)
    self._view.node_content:onClick(Bind(self, self.OnClickTips))
end

function M:OnEnter(mission)
    self.m_mission = mission
    self._view.node_content.pivot = Vector2.up
    local localPosition = self._view.node_content.localPosition
    localPosition.x = 0
    self._view.node_content.localPosition = localPosition
    self:_ShowTipsContent()
end

function M:_ShowTipsContent()
    local ret, num = string.gsub(self.m_mission.chapterLabel, "<color%=(.-)%>", "<color=#5784F7>")
    if num <= 0 then ret = string.format("<color=#5784F7>%s</color>", ret) end
    self._view.txt_name:SetText(string.format(self.m_tipsFormat, ret))
    -- 0.5秒内打开
    self._view.node_content:SetDoLocalMoveX(-410, 0.5):OnTweenComplete(function()
        --显示3秒
        self._view.node_content:SetDoLocalMoveX(-410, 3):OnTweenComplete(function()
            -- 0.5秒内关闭
            self._view.node_content:SetDoLocalMoveX(0, 0.5):OnTweenComplete(function()
                self:Close()
            end)
        end)
    end)
end

function M:OnClickTips(go)
    -- ModuleMgr:GetInstance():ChangeModule(
    --     ModuleConfig.Dorm.id,
    --     self.m_selectData.HeroId
    -- )
end

return M
