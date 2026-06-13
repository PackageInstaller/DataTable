local BubbleBoxCtrl = BaseClass("BubbleBoxCtrl")
local M = BubbleBoxCtrl

function M:__init(view)
    self._view = view
    self._view.Button.transform:onClick(Bind(self, self._OnClickBtn))
    self._roomStory = 0
    self._roomStoryLevel = 0
    self._storyStage = 0
    self._synchronizationPosition = false
end

function M:UpdateData(heroId, roomStory, roomStroyLevel, storyStage)
    self.heroId = heroId
    self._roomStory = roomStory
    self._roomStoryLevel = roomStroyLevel
    self._storyStage = storyStage
    self:SceneToUI()
end

--点击开始宿舍剧情
function M:_OnClickBtn(go)
    if self._roomStory ~= 0 then
        UIContextMgr:GetInstance():Show("FavorStory", self.heroId, DormConst.StoryType.roomStory, self._roomStory, nil, self._roomStoryLevel)
    else
        UIContextMgr:GetInstance():Show("FavorStory", self.heroId, DormConst.StoryType.roomStory, self._storyStage, nil, nil)
    end

    UIContextMgr:GetInstance():Close("Dorm")
end

function M:Enable(v)
    self._view:SetActive(v)
end

function M:SceneToUI()
    if self._synchronizationPosition == false then
        local csType = typeof(CS.GameX.SceneToUI)
        --local targetTransform = DormHelper:GetHeadTrans()
        local scene2UI = targetTransform:GetComponent(csType)

        if not scene2UI then
            scene2UI = targetTransform.gameObject:AddComponent(csType)
        end

        scene2UI.uiFlag = self._view.transform
        self._synchronizationPosition = true
    end
end

function M:OnDispose()
    self._roomStory = 0
    self._roomStoryLevel = 0
    self._storyStage = 0
    self._synchronizationPosition = false
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return BubbleBoxCtrl
