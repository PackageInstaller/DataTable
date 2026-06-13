local M = BaseClass("ComTextTipsCtrl", BaseUICtrl)

function M:Init()
    self.m_closeCallback = nil
    self._view.mask:onClick(Bind(self, self.Close))
end

--[[
    state:uiState   1:文本 2:图标+文本
    worldPos:需要对齐的世界坐标原点
    alignDir：被tips对齐的方向
    canvasTrans：被点击UI的canvas的transform
    rectSize：被点击UI的大小
    tipsPivot：tips的对齐方向
]]
function M:OnEnter(data)
    local state = data.state or 1
    self._view.uiState:SetState(state)

    -- 是否需要对齐
    if self._view.isAlign == 1 then
        local pos = data.canvasTrans:InverseTransformPoint(data.worldPos)
        local dir = data.alignDir
        local size = data.rectSize
        local posX = pos.x + dir.x * size.x
        local posY = pos.y + dir.y * size.y
        self._view.content.pivot = data.tipsPivot
        self._view.content.localPosition = Vector3.New(posX, posY, 0)
    end

    if state == 1 then
        self._view.txt_title:SetText(data.title)
        self._view.txt_desc:SetText(data.content)
    elseif state == 2 then
        self.m_closeCallback = data.closeCallback
        self:_OpenSkillInfoView(data.battleLevelId, data.isCurrent)
    end
end

function M:_OpenSkillInfoView(battleLevelId, isCurrent)
    local battleLevelConfig = ConfigHelper.GetCfg("battleLevel", battleLevelId)
    self._view.appendPanel:SetActive(not isCurrent)
    self:_SetBasicSkillInfo(battleLevelConfig)
end

function M:_SetBasicSkillInfo(battleLevelCfg)
    self._view.skillIcon_image:SetPic(battleLevelCfg.icon)
    self._view.describe_text:SetText(battleLevelCfg.skillDesc)
    self._view.skillName_text:SetText(battleLevelCfg.skillName)
    self._view.cost_Parent:SetActive(battleLevelCfg.skillCost > 0)

    if (battleLevelCfg.skillCost ~= 0) then
        self._view.cost_text:SetText(tostring(battleLevelCfg.skillCost))
    end
    if (battleLevelCfg.skillType ~= 0) then
        self._view.skillTypeState:SetState(battleLevelCfg.skillType + 1)
    end
    if (#battleLevelCfg.desc > 0) then
        local appendEffectDes = ""
        for _, id in ipairs(battleLevelCfg.desc) do
            appendEffectDes = appendEffectDes .. ConfigHelper.GetLocalString(id) .. " "
        end
        self._view.txt_AppendEffect:SetText(appendEffectDes)
    end
end

function M:OnClose()
    if self.m_closeCallback then
        self.m_closeCallback()
        self.m_closeCallback = nil
    end
end

return M
