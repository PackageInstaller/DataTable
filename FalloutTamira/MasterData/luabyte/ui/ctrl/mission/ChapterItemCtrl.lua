local M = BaseClass("ChapterItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))
local MainType = ChapterConst.EChapterType.ECT_Main

function M:Init()
    self.m_data = nil
    self.m_chapter = nil
    self.m_aniName = nil
    self.m_callback = nil
    self.m_isMain = false
    self._view.transform.localEulerAngles = Vector3.zero
    self._view.lockTag:onClick(Bind(self, self.OnClickLock))
    self._view.tgl_normal:onClick(Bind(self, self.OnSelected))
end

function M:UpdateItem(data, idx)
    if data == nil then return end

    self.m_data = data
    self.m_chapter = self.m_data.Chapter
    self.m_isMain = self.m_chapter.type == MainType

    self:_UpdateSelectState()

    self._view.txt_name:SetText(self.m_chapter.name)
    self._view.txt_title:SetText(self.m_chapter.chapterName)
    self._view.txt_index:SetText(string.format("%02d", idx - 1))

    self._view.redPoint:SetParam(0, self.m_chapter.id)
    self._view.redPoint:SetParam(1, self.m_chapter.id)
    self._view.redPoint:Check()
end

function M:SetItemState(fun)
    self.m_callback = fun
end

function M:Dispose()
    self.m_data = nil
    self.m_isMain = nil
    self.m_chapter = nil
    self.m_aniName = nil
    self.m_callback = nil
    M.super.Dispose(self)
end

function M:OnClickLock(go)
    -- 通关上一章解锁
    if self.m_isMain then
        GameHelper.TipsById(479)
    else
        local lockId = GameHelper.CSGetFirstLockReason(self.m_chapter.openCondition)
        if lockId > 0 then
            local openCfg = ConfigHelper.GetCfgByLua("openCondition", lockId)
            if openCfg then
                GameHelper.TipsById(openCfg.tips)
            else
                Logger.LogError("[openCondition] is nil, id = " .. lockId)
            end
        end
    end
end

function M:_UpdateSelectState()
    local isSelect = self.m_data.IsSelect
    self._view.tgl_normal:SetIsOn(isSelect, false)
    self._view.selectState:SetState(self.m_isMain and 1 or 2)
    if isSelect then
        if self.m_data.IsPass then
            -- 5.选中_已通过
            self._view.itemState:SetState(5)
        else
            -- 6.选中_已解锁未通过
            self._view.itemState:SetState(6)
        end
    else
        if self.m_data.IsPass then
            --1.未选中_已通过
            self._view.itemState:SetState(1)
        else
            if self.m_data.IsUnlock then
                --2.未选中_已解锁未通过
                self._view.itemState:SetState(2)
            else
                if self.m_data.PostIndex == 1 then
                    --3.未选中_未解锁_显示章节名
                    self._view.itemState:SetState(3)
                else -- PostIndex = 2/3
                    --4.未选中_未解锁_不显示信息
                    self._view.itemState:SetState(4)
                end
            end
        end
    end
end

function M:OnSelected(go)
    if self.m_callback then
        self.m_callback(self.m_data)
    end
end

return M
