local DormPuzzleItemCtrl = BaseClass("DormPuzzleItemCtrl")
local M = DormPuzzleItemCtrl

function M:__init(view)
    self._view = view
    self._view.Activate.transform:onClick(Bind(self, self.OnClickItem))
    self._view.Img.transform:onClick(Bind(self, self.OnClickImage))
    self._view.Mask.transform:onClick(Bind(self, self.OnClickMask))
    self.rect = self._view.transform:rectTransform()
    self.clickRewardCallback = EventMgr:AddListener(UIMessageNames.DORM_PUZZLE_CLICKREWARD, Bind(self, self.RewardCallback))
end

function M:RewardCallback(groupChildId)
    if self.data.isActive then
        return
    end
    for key, value in pairs(groupChildId) do
        if self._view.groupChildId == value and not self.data.canActive then
            self:PlayShack()
            return
        end
    end
end 

function M:PlayShack()
    if self.tween then
        return
    end
    self.tween = self.rect:SetDoShakePosition(1.5, 5, 4)
    self.tween:OnTweenComplete(function() self.tween = nil end)
end 

function M:OnClickMask(go)
    if not self.data.canActive then
        GameHelper.PlayAudioById(1412)
        local itemCfg = ConfigHelper.GetCfgByLua("item", self.data.cfg.costItem)
        local tips = ConfigHelper.GetLocalString(1313)
        local name = ConfigHelper.GetLocalString(itemCfg.name)
        GameHelper.Tips(string.format(tips, name))
        self:PlayShack()
    end
end 

function M:OnClickItem(go)
    if self.data.canActive then
        DormPuzzleActivityDataMgr:GetInstance():RequestFlipCardActive(self._view.groupChildId,Bind(self,self.FlipCardActiveCallback))
    end
end

function M:OnClickImage()
    local isComplete =  DormPuzzleActivityDataMgr:GetInstance():CheckAllComplete()
    if isComplete then
        local res = DormPuzzleActivityDataMgr:GetInstance():GetActivityRoomFlipCfg().image
        UIContextMgr:GetInstance():Show("DormShowGirlUI", res)
    end
end

function M:FlipCardActiveCallback(idx)
    self.data = DormPuzzleActivityDataMgr:GetInstance():GetCardByGroupChildId(idx)
    --播放翻牌动画
    self._view.Activate.gameObject:SetActive(false)
    self._view.Card:StartFront()
    GameHelper.PlayAudioById(1413)
end 

function M:UpdateData(data)
    self.data = data
    self._view.Img:SetPic(self.data.cfg.icon)
    if self.data.isActive then
        self._view.State:SetState(1)
    else
        if self.data.canActive then
            self._view.State:SetState(3)
        else
            self._view.State:SetState(2)
        end
    end
end 

function M:OnDispose()
    self.rect = nil
    EventMgr:RemoveListener(UIMessageNames.DORM_PUZZLE_CLICKREWARD, self.clickRewardCallback)
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return DormPuzzleItemCtrl
