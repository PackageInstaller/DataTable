local UIAwakenSkillCtrl = BaseClass("UIAwakenSkillCtrl")
local M = UIAwakenSkillCtrl
local sfmt = string.format

function M:__init(view)
    self._view = view
    self._view.labDesc:SetOnClick(Bind(self, self.OnClickCurHrefWord))
end

function M:Update(data)
    self._data = data

    self._view.icon:SetPic(data.skillIcon)
    self._view.labName:SetText(data.skillName)
    self._view.labDesc:SetText(data.skillDesc)
    self._view.state:SetState(data.isOpen and 1 or 2)
    if not data.isOpen then
        local openTips = sfmt(ConfigHelper.GetLocalString(5804), data.openLevel)
        self._view.labGet:SetText(openTips)
    end
end

function M:SetActive(state)
    self._view:SetActive(state)
end

function M:OnClickCurHrefWord(hrefName, centerX, centerY)
    local alignDir = Vector2.New( -0.5, 0) --点击处 -- 以点击文字的锚点居中为标准，对齐点在右侧居中位置
    local tipsPivot = Vector2.New(1, 0.5) --弹出框 -- tips以左侧居中点对齐文字的对齐点
    local worldPos = Vector3.New(centerX, centerY, 0)
    self._view.labDesc:ShowHrefWordTips(hrefName, worldPos, alignDir, tipsPivot)
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
    end
    self._view = nil
end

return UIAwakenSkillCtrl
