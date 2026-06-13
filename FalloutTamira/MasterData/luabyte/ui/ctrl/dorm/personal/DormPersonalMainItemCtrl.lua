local M = BaseClass("DormPersonalMainItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

function M:Init()
    self.m_data = nil
    self.m_openCfg = nil
    self._view.transform.localEulerAngles = Vector3.zero
    self._view.btn_mask:onClick(Bind(self, self.OnClickMask))
    self._view.node_locked:onClick(Bind(self, self.OnClickLocked))
    self.module = ModuleMgr:GetInstance():GetCurrentModule()
end

function M:UpdateItem(data, idx)
    if data == nil then return end
    self.m_data = data
    local mission = self.m_data.MissionCfg
    -- 状态1：已达到好感度等级且已完成该关卡
    local isPass = self.m_data.IsPass()
    self._view.node_complete:SetActive(isPass)
    self._view.img_banner:SetPic(mission.banner)
    self._view.txt_name:SetText(mission.name)
    self._view.txt_index:SetText(string.format("%02d", idx))

    self._view.cs_gray.UseGray = false
    self._view.node_tipsBG:SetActive(false)
    if not isPass then     -- 未通关
        local lockId = self.m_data.FirstLock()
        if lockId > 0 then -- 未解锁
            self.m_openCfg = ConfigHelper.GetCfgByLua("openCondition", lockId)
            local unlockType = OpenConditionConst.UnlockType.HeroFavor
            if self.m_openCfg.unlockType == unlockType then
                -- 状态4：未达到好感度等级叠暗显示
                self._view.node_doing:SetActive(false)
                self._view.node_locked:SetActive(true)
                self._view.cs_gray.UseGray = true
            else
                -- 状态3：已达到好感度等级但未解锁未完成
                self._view.node_tipsBG:SetActive(true)
                self._view.node_doing:SetActive(false)
                self._view.node_locked:SetActive(false)
            end
        else -- 全部解锁
            -- 状态2：已达到好感度等级但未完成该关卡
            self._view.node_doing:SetActive(self.m_data.IsPrePass())
            self._view.node_locked:SetActive(false)
            self.m_openCfg = nil
        end
    else -- 已通关
        self._view.node_doing:SetActive(false)
        self._view.node_locked:SetActive(false)
        self.m_openCfg = nil
    end
    if self.m_openCfg then self._view.txt_tips:SetText(self.m_openCfg.tips) end
end

function M:Dispose()
    self.m_data = nil
    self.m_openCfg = nil
    M.super.Dispose(self)
end

function M:OnClickLocked(go)
    if self.m_openCfg then
        GameHelper.TipsById(self.m_openCfg.tips)
    end
end

function M:OnClickMask(go)
    if not self.m_data.IsOpen() then
        GameHelper.TipsById(10022) -- 功能模块已经关闭
        return
    end

    if self.m_data.IsPass() then
        DormDataMgr:EnterPersonalCopy(self.m_data)
        return
    end

    if not self.m_data.IsPrePass() then
        GameHelper.TipsById(5207) -- 完成上一关卡解锁！
        return
    elseif self.m_openCfg then
        GameHelper.TipsById(self.m_openCfg.tips)
        return
    end

    if self.m_data.MissionCfg.roomTask > 0 then
        local activityChapterId =  DormPuzzleActivityDataMgr:GetInstance():GetChapterId()
        if self.m_data.MissionCfg.chapterID == activityChapterId then
            if self.module.activityEvent ~= 0 and self.module.activityTask ~= self.m_data.MissionCfg.roomTask then
                GameHelper.TipsById(1002141) -- 尚未接取任务
            else
                DormDataMgr:EnterPersonalCopy(self.m_data)
            end
        else
            if self.module.roomEvent ~= 0 and self.module.roomTask ~= self.m_data.MissionCfg.roomTask then
                GameHelper.TipsById(1002141) -- 尚未接取任务
            else
                DormDataMgr:EnterPersonalCopy(self.m_data)
            end
        end 
    else
        DormDataMgr:EnterPersonalCopy(self.m_data)
    end
end

return M
