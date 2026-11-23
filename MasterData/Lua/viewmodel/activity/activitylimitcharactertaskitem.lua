ActivityLimitCharacterTaskItem = {}

ActivityLimitCharacterTaskItem.__index = ActivityLimitCharacterTaskItem

local objs = {
    anim = { path = "Obj", type = "Animator" },
    bg1 = { path = "Obj/Bg/Bg1", type = "GameObject" },
    name = { path = "Obj/Name", type = "Text" },
    rewardGo =  { path = "Obj/Reward", type = "GameObject" },
    reward =  { path = "Obj/Reward/GoodsItem", type = "GoodsViewModel" },
    dynamicAvatar = { path = "Obj/DynamicAvatar", type = "GameObject" },
    playerDynamicAvatar = { path = "Obj/DynamicAvatar", type = "PlayerDynamicAvatar" },
    ClickArea = { path = "Obj/ClickArea", type = "Button" },
    GetBtn = { path = "Obj/Btn/Get", type = "Button" },
    GetGo = { path = "Obj/Btn/Get", type = "GameObject" },
    ProgressGo = { path = "Obj/Btn/Progress", type = "GameObject" },
    FinishedGo = { path = "Obj/Btn/Finished", type = "GameObject" },
    mask = { path = "Obj/Mask", type = "GameObject" },
}

function ActivityLimitCharacterTaskItem.New()
    local self = {}
    setmetatable(self, ActivityLimitCharacterTaskItem)
    return self
end

function ActivityLimitCharacterTaskItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.transform = self.gameObject:GetComponent("RectTransform")

    self.OnClickArea = function()
        self.data.OnClickArea(self.data.index)
    end
    self.OnClickGetBtn = function()
        self.data.OnClickGetBtn(self.data.id)
    end
    LuaMgr.AddClick(self.ClickArea, self.OnClickArea)
    LuaMgr.AddClick(self.GetBtn, self.OnClickGetBtn)
    SetActive(self.anim.gameObject, false)
end

function ActivityLimitCharacterTaskItem:SetData(data)
    self.data = data.data

    self.name.text = self.data.nameStr

    local showDynamicAvatar = not IsNullOrEmpty(self.data.dynamicAvatarId)
    if showDynamicAvatar then
        self.playerDynamicAvatar:AppointAvatar(self.data.dynamicAvatarId)
    else
        self.reward:SetData(self.data.showReward.id, self.data.showReward.count, 1, 0.6, false);
    end
    SetActive(self.bg1, self.data.isFinish)
    SetActive(self.rewardGo, not showDynamicAvatar)
    SetActive(self.dynamicAvatar, showDynamicAvatar)
    SetActive(self.GetGo, self.data.isCanGet)
    SetActive(self.ProgressGo, self.data.isProgress)
    SetActive(self.FinishedGo, self.data.isFinish)
    SetActive(self.mask, self.data.isFinish)

    if self.data.hide then
        self:PlayAnim("ActivityLimitCharacterTaskItem_Hide")
    else
        self:PlayAnim("ActivityLimitCharacterTaskItem_Idle")
    end

    SetActive(self.gameObject, true)
end

function ActivityLimitCharacterTaskItem:PlayAnim(animName)
    SetActive(self.anim.gameObject, true)
    self.anim:Play(animName,0,0)
    self.data.playAnim = false
end

function ActivityLimitCharacterTaskItem:Clear()
    self.data = nil
    SetActive(self.gameObject, false)
end

function ActivityLimitCharacterTaskItem:Destroy()
    if (self.OnClickArea ~= nil) then
        LuaMgr.RemoveClick(self.ClickArea, self.OnClickArea)
        self.OnClickArea = nil
    end
    if (self.OnClickGetBtn ~= nil) then
        LuaMgr.RemoveClick(self.GetBtn, self.OnClickGetBtn)
        self.OnClickGetBtn = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end