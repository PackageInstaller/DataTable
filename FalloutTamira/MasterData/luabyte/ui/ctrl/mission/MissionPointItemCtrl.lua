local M = BaseClass("MissionPointItemCtrl")
local MissionDataMgr = MissionDataMgr:GetInstance()

function M:__init(view)
    self._view = view
    self.m_position = nil
    self.m_callback = nil
    self.m_mission = nil
    self.m_openCfg = nil
    self.m_isPass = false
    self.m_chapterType = 0
    self.m_isDouble = false
    -- self.m_doubleGroupId = nil
    self.m_trans = self._view.transform
    self._view.img_banner:onClick(Bind(self, self.OnClickItem))
    self.m_starGroup = { self._view.star1, self._view.star2, self._view.star3, self._view.star4 }
    -- coroutine.start(function()
    --     coroutine.waitforseconds(0.1)
    --     if not self._view then return end
    --     self:SetAnimatorState()
    -- end)
end

function M:OnDispose()
    self.m_trans = nil
    self.m_isPass = nil
    self.m_mission = nil
    self.m_openCfg = nil
    self.m_callback = nil
    self.m_position = nil
    self.m_isDouble = nil
    self.m_starGroup = nil
    self.m_chapterType = nil
    -- self.m_doubleGroupId = nil
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

function M:OnClickItem(go)
    if self.m_callback then
        if self.m_openCfg then
            GameHelper.TipsById(self.m_openCfg.tips)
            return
        end
        self.m_callback(self)
    end
end

function M:SetActive(isOn)
    self._view:SetActive(isOn)
end

function M:SetName(name)
    self._view.gameObject.name = name
end

function M:GetMission()
    return self.m_mission
end

function M:SetParent(parent)
    self._view:SetParent(parent, true)
end

function M:SetInfo(mission, isDouble)
    local id = mission.id
    self.m_mission = mission
    self.m_isDouble = isDouble
    -- self.m_doubleGroupId = itemGroupId
    self.m_chapterType = self.m_mission.Chapter.type
    self.m_isPass = MissionDataMgr:IsMissionPassById(id)

    local picPath = self.m_mission.picture
    local position = self.m_mission.position
    local isBoss = self.m_mission.ifBoss == 1
    local openId = self.m_mission.openCondition
    local starNum = MissionDataMgr:GetMissionStar(id)
    local notEmpty = not string.isNullOrEmpty(picPath)
    local lockId = GameHelper.CSGetFirstLockReason(openId)
    local isHard = MissionHelper.Is4StarMission(self.m_mission)

    for i, t in ipairs(self.m_starGroup) do t:SetActive(starNum >= i) end
    self._view.missionState:SetState(isBoss and 3 or (isHard and 2 or 1))
    self.m_position = Vector3.New(position[0], position[1], position[2])
    self.m_openCfg = ConfigHelper.GetCfgByLua("openCondition", lockId)
    if notEmpty then self._view.img_picture:SetPic(picPath) end
    self._view.missionLab:SetText(self.m_mission.chapterLabel)
    self._view.lockState:SetState((lockId > 0) and 2 or 1)
    self._view.img_banner:SetPic(self.m_mission.banner)
    self.m_trans.localPosition = self.m_position
    self._view.img_picture:SetActive(notEmpty)
    self._view.star4bg:SetActive(isHard)
    self.m_trans:SetAsFirstSibling()

    self:_RefrehPostion()
    self:_RefreshDouble()
    self:_RefreshShowItem()
    self:SetSelectState(false)
end

function M:SetSelectState(value)
    -- 1:选中，2:取消(非当前)，3:取消(当前)
    local state = value and 1 or (self.m_isPass and 2 or 3)
    self._view.selectState:SetState(state)
end

function M:SetClickCllback(action)
    self.m_callback = action
end

-- 此接口Start开始执行才能生效，需延迟执行
function M:SetAnimatorState()
    -- if self.m_isPass then
    --     self._view.ticAnim:DORewind()
    -- else
    --     self._view.ticAnim:DORestart()
    -- end
end

function M:_RefrehPostion()
    local lineTrans = self._view.line
    local isActive = not self.m_mission.IsHead
    lineTrans:SetActive(isActive)
    if not isActive then return end

    local preMission, target = self.m_mission.PrevMission, nil
    if preMission then
        local prePos = preMission.position
        target = Vector3.New(prePos[0], prePos[1], prePos[2])
    else
        target = self.m_position
    end

    local ori = self.m_position
    local lineH = lineTrans.rect.height
    local x = Vector3.Distance(target, ori)
    local atan2 = Mathf.Atan2(target.y - ori.y, target.x - ori.x)
    local angle = atan2 * 180 / Mathf.PI        -- 角度
    lineTrans.rotation = Quaternion.Euler(0, 0, angle)
    lineTrans.sizeDelta = Vector2.New(x, lineH) -- 长度
    lineTrans.localPosition = Vector3.zero
    local missionId = self.m_mission.id
    if MissionDataMgr:GetPassCountById(missionId) <= 0 then
        local keyName = "StagePointItemUnlock" .. tostring(missionId)
        if PlayerPrefTools.GetPlayerPrefsInt(keyName, 0) == 0 then
            self._view.lineAnim:Play("StagePointItemUnlock", -1, 0)
            PlayerPrefTools.SetPlayerPrefs(keyName, 1)
        end
    end
end

function M:_RefreshDouble()
    self._view.doubleTag:SetActive(self.m_isDouble)
    -- if self.m_doubleGroupId and self.m_doubleGroupId then
    --     local itemGroup = ConfigHelper.GetCfgByLua("itemGroup", self.m_doubleGroupId)
    --     if itemGroup then
    --         local itemId = itemGroup.items[0]
    --         local item = ConfigHelper.GetCfgByLua("item", itemId)
    --         if item and item.type == BagConst.ItemType.EIT_Hero then
    --             self._view.heroTag:SetActive(true)
    --             self._view.heroImg:SetPic(item.icon)
    --         else
    --             self._view.heroTag:SetActive(false)
    --         end
    --     end
    --     return
    -- end
    -- 双倍奖励道具显示标签，目前版本不显示
    self._view.heroTag:SetActive(false)
end

function M:GetUpRightLocalPos(trans)
    local worldPos = self.m_trans:WorldCorners()[2]
    return trans:InverseTransformPoint(worldPos)
end

function M:CloseDouble()
    self.m_isDouble = false
    self._view.doubleTag:SetActive(self.m_isDouble)
end

function M:_RefreshShowItem()
    local itemId = self.m_mission.showItem
    if itemId and itemId > 0 then
        local item = ConfigHelper.GetCfgByLua("item", itemId)
        if item then
            self._view.itemTag:SetActive(true)
            self._view.itemIcon:SetPic(item.icon)
            self._view.itemRare:SetState(item.quality)
        else
            Logger.LogError("item is nil, id = " .. itemId)
        end
    else
        self._view.itemTag:SetActive(false)
    end
end

function M:SetSiblingIndex(idx)
    self.m_trans:SetSiblingIndex(idx)
end

return M
