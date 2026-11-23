GiftCharacterTaskItem = {}

GiftCharacterTaskItem.__index = GiftCharacterTaskItem

local objs = {
    anim = { path = "Obj", type = "Animator" },
    bg_normal = { path = "Obj/Bg_normal", type = "GameObject" },
    bg_finish = { path = "Obj/Bg_finish", type = "GameObject" },
    name = { path = "Obj/Bg_normal/Name", type = "Text" },
    name1 = { path = "Obj/Bg_finish/Name", type = "Text" },
    rewardGo =  { path = "Obj/Reward", type = "GameObject" },
    reward =  { path = "Obj/Reward/GoodsItem", type = "GoodsViewModel" },
    dynamicAvatar = { path = "Obj/DynamicAvatar", type = "GameObject" },
    playerDynamicAvatar = { path = "Obj/DynamicAvatar", type = "PlayerDynamicAvatar" },
    ClickArea = { path = "Obj/ClickArea", type = "Button" },
    ClickBtn = { path = "Obj/Btn", type = "Button" },
    GetGo = { path = "Obj/Btn/Get", type = "GameObject" },
    ProgressGo = { path = "Obj/Btn/Progress", type = "GameObject" },
    FinishedGo = { path = "Obj/Btn/Finished", type = "GameObject" },
}

function GiftCharacterTaskItem.New()
    local self = {}
    setmetatable(self, GiftCharacterTaskItem)
    return self
end

function GiftCharacterTaskItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.transform = self.gameObject:GetComponent("RectTransform")

    self.OnClickArea = function()
        self.data.OnClickArea(self.data.index)
    end
    self.OnClickGetBtn = function()
        if self.data.isCanGet then
            self.data.OnClickGetBtn(self.data.id)
        end
    end
    LuaMgr.AddClick(self.ClickArea, self.OnClickArea)
    LuaMgr.AddClick(self.ClickBtn, self.OnClickGetBtn)
    SetActive(self.anim.gameObject, false)
end

function GiftCharacterTaskItem:SetData(data)
    self.data = data.data

    self.name.text = self.data.nameStr
    self.name1.text = self.data.nameStr

    local showDynamicAvatar = not IsNullOrEmpty(self.data.dynamicAvatarId)
    if showDynamicAvatar then
        self.playerDynamicAvatar:AppointAvatar(self.data.dynamicAvatarId)
    else
        self.reward:SetData(self.data.showReward.id, self.data.showReward.count, 1, 0.6, true);
    end
    SetActive(self.bg_normal, not self.data.isFinish)
    SetActive(self.bg_finish, self.data.isFinish)
    SetActive(self.rewardGo, not showDynamicAvatar)
    SetActive(self.dynamicAvatar, showDynamicAvatar)
    SetActive(self.GetGo, self.data.isCanGet)
    SetActive(self.ProgressGo, self.data.isProgress)
    SetActive(self.FinishedGo, self.data.isFinish)

    if self.data.hide then
        self:PlayAnim("ActivityLimitCharacterTaskItem_Hide")
    else
        self:PlayAnim("ActivityLimitCharacterTaskItem_Idle")
    end

    SetActive(self.gameObject, true)
end

function GiftCharacterTaskItem:PlayAnim(animName)
    SetActive(self.anim.gameObject, true)
    self.anim:Play(animName,0,0)
    self.data.playAnim = false
end

function GiftCharacterTaskItem:Clear()
    self.data = nil
    SetActive(self.gameObject, false)
end

function GiftCharacterTaskItem:Destroy()
    if (self.OnClickArea ~= nil) then
        LuaMgr.RemoveClick(self.ClickArea, self.OnClickArea)
        self.OnClickArea = nil
    end
    if (self.OnClickGetBtn ~= nil) then
        LuaMgr.RemoveClick(self.ClickBtn, self.OnClickGetBtn)
        self.OnClickGetBtn = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end