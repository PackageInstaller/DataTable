local M = BaseClass("MainPreheatActivityUICtrl", BaseUICtrl)

function M:Init()
    self._view.itemPfb:EnablePopItem(true)
    self.m_itemPfbs = { self._view.itemPfb }
    self._view.playState:onClick(Bind(self, self.OnClickVideo))
    self._view.btn_award:onClick(Bind(self, self.OnClickAward))
    self._view.btn_supply:onClick(Bind(self, self.OnClickSupply))

    local ctrl = require("UI.Ctrl.Activity.MainPreheatActivityItemCtrl")
    local view = require("UI.View.Activity.MainPreheatActivityItemView")
    self._view.looplist:Init(ctrl, view)
    self._view.looplist:SetCreateItemCallback(Bind(self, self.OnCreateItem))
end

function M:OnEnter(data)
    local cfgs = ConfigHelper.GetCfgsByLua("activityAddMission", { activityId = data:ActivityId() })
    local activityAddMission = cfgs and cfgs[1] or nil
    if not activityAddMission then
        Logger.LogError("activityAddMission is nil")
        return
    end

    self.m_activityData = data
    self.m_context = self:GetContext()
    self.m_pvPath = activityAddMission.pv
    self.m_actAddMission = activityAddMission
    self._view.txt_actTime:SetText(TimeUtil.GetTimeFormat(data:EndTime(), "%y/%m/%d/%H:%M"))

    local listDatas, openIdx, comingIdx = {}, nil, nil
    local actAddId = activityAddMission.id
    local groupIds = activityAddMission.openChapterReward
    local rewardDes = activityAddMission.openChapterrewardDes
    local openChapterPics = activityAddMission.openChapterPicture
    local openSmallPics = activityAddMission.openChapterSmallPicture
    for i, id in ipairs(activityAddMission.openChapter) do
        local items = {}
        local itemGroup = ConfigHelper.GetCfgByLua("itemGroup", groupIds[i])
        if itemGroup then
            local cnts = itemGroup.cnts
            for j, itemId in ipairs(itemGroup.items or {}) do
                table.insert(items, { Id = itemId, Num = cnts[j] })
            end
        else
            Logger.LogError("itemGroup is nil. 检查配表, id = " .. tostring(groupIds[i]))
        end
        table.insert(listDatas, {
            ChapterId = id,
            Chapter = ConfigHelper.GetCfgByLua("chapter", id),
            SmallPic = openSmallPics[i],
            ChapterPic = openChapterPics[i],
            IsNew = false,
            OpenStr = "",
            IsSelect = false,
            Rewards = items,
            OpenTime = 0,
            RewardDesc = rewardDes[i],
            IsAward = function()
                return self.m_context:IsAward(actAddId, i)
            end
        })
        if not openIdx then openIdx = #listDatas end
    end

    local newSmallPics = activityAddMission.comingChapterSmallPicture
    local newChapterPics = activityAddMission.comingChapterPicture
    local openStamp = activityAddMission.comingChapterOpenTime
    local openStr = TimeUtil.GetTimeFormat(openStamp, "%y/%m/%d")
    for i, id in ipairs(activityAddMission.comingChapter) do
        table.insert(listDatas, {
            ChapterId = id,
            Chapter = ConfigHelper.GetCfgByLua("chapter", id),
            SmallPic = newSmallPics[i],
            ChapterPic = newChapterPics[i],
            IsNew = true,
            OpenStr = openStr,
            IsSelect = false,
            Rewards = {},
            OpenTime = openStamp,
            RewardDesc = 0,
        })
        if not comingIdx then comingIdx = #listDatas end
    end
    local selectIdx
    if TimeUtil.GetNowTimeStamp() > openStamp then
        selectIdx = comingIdx or openIdx
    else
        selectIdx = openIdx
    end
    listDatas[selectIdx].IsSelect = true
    self:_UpdatePanel(listDatas[selectIdx])
    self._view.looplist:SetDataList(listDatas)
    self._view.looplist:AlignmentContentPosition(selectIdx, 1)

    local subIds = self.m_activityData:SubActivityIds()
    local activity = ConfigHelper.GetCfgByLua("activity", subIds[1] or 0)
    if activity then
        self._view.img_icon:SetPic(activity.icon)
        self._view.txt_label:SetText(activity.name)
    else
        Logger.LogError("activity is nil, id = " .. tostring(subIds[1] or 0))
    end
end

function M:OnDispose()
    self.m_pvPath = nil
    self.m_context = nil
    self.m_activityData = nil
    self.m_actAddMission = nil
    M.super.OnDispose(self)
end

function M:OnClickAward(go)
    if not self.m_selectData or self.m_selectData.IsAward() then return end
    local id = self.m_selectData.ChapterId
    local isPass = MissionDataMgr:GetInstance():IsPassedChapter(id)
    if isPass then
        local request = { ChapterId = id, EntryId = self.m_activityData:ActivityId(), SubId = self.m_actAddMission.id }
        self.m_context:SendChapterActAward(request, function(rewards)
            local itemDic = {}
            for _, item in ipairs(rewards or {}) do
                local num = itemDic[item.Id] or 0
                itemDic[item.Id] = item.Cnt + num
            end
            GameHelper.ShowGetItems(itemDic)
            self:_UpdateAwardBtnState()
            IRedPointMgr:ForceCheck(RedPointConst.MainPreheatRedPointChecker)
        end)
    end
end

function M:OnClickSupply(go)
    local subIds = self.m_activityData:SubActivityIds()
    MissionHelper.OpenMissionActivityShop(subIds[1] or 0)
end

function M:OnCreateItem(ctrl)
    ctrl:SetCallback(function(data)
        local id = data.ChapterId
        for _, v in ipairs(self._view.looplist:GetDataList()) do
            v.IsSelect = v.ChapterId == id
        end
        self:_UpdatePanel(data)
        self._view.looplist:UpdateList()
    end)
end

function M:OnClickVideo(go)
    local state = self._view.playState:GetState()
    if state == 2 then
        self._view.videoPlayer:Play()
        self._view.playState:SetState(1)
    else
        self._view.videoPlayer:Pause()
        self._view.playState:SetState(2)
    end
end

function M:_UpdateRewards(items)
    for i, v in ipairs(items) do
        local itemPfb = self.m_itemPfbs[i]
        if not itemPfb then
            itemPfb = self._view.itemPfb:Instantiate()
            self.m_itemPfbs[i] = itemPfb
            itemPfb:EnablePopItem(true)
        end
        itemPfb:SetActive(true)
        itemPfb:SetInfo(v.Id, ItemNumberType.TOTLE, v.Num)
    end

    for _ = #items + 1, #self.m_itemPfbs do
        self.m_itemPfbs:SetActive(false)
    end
end

function M:_UpdateAwardBtnState()
    if self.m_selectData.IsAward() then
        self._view.btn_award:SetState(3)
    else
        local id = self.m_selectData.ChapterId
        local isPass = MissionDataMgr:GetInstance():IsPassedChapter(id)
        self._view.btn_award:SetState(isPass and 1 or 2)
    end
end

function M:_UpdatePanel(data)
    self.m_selectData = data
    local isNew = data.IsNew
    self._view.img_pic:SetPic(data.ChapterPic)
    self._view.rectRight:SetActive(not isNew)
    self._view.rectDown:SetActive(isNew)
    if isNew then
        if not string.isNullOrEmpty(self.m_pvPath) then
            self._view.videoPlayer:SetActive(true)
            self._view.videoPlayer:Play(self.m_pvPath)
            self._view.playState:SetState(1)
        else
            self._view.videoPlayer:SetActive(false)
        end
    else
        self._view.videoPlayer:SetActive(false)
        self._view.txt_name:SetText(data.Chapter.name)
        self:_UpdateRewards(data.Rewards)
        self:_UpdateAwardBtnState()
    end
end

return M
