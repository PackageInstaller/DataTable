---@class CoveProps
local CoveProps = class("CoveProps")

---@param id integer
---@param gameObject UnityEngine.GameObject
function CoveProps:ctor(id, gameObject)

    self.id = id
    self.gameObject = gameObject
    self.transform = gameObject.transform

    self.uiRoot = self.transform:Find("UIRoot").gameObject
    ---@type ScaleButton
    self.eventBtn = self.transform:Find("UIRoot/UICanvas/EventBtnP/EventBtn"):GetComponent(TypeInfo.ScaleButton)

    self.eventBtn.onClick:RemoveAllListeners()
    self.eventBtn.onClick:AddListener(BindCallback_NoParams(self, self.OnEventBtnClick))
    
    ---@type Spine.Unity.SkeletonGraphic
    self.resourceSpine = self.eventBtn.transform:Find("resourceEmote/EmoteSpine"):GetComponent(TypeInfo.SkeletonAnimation)


    local serverData = Me:GetCovePropsInfo(self.id)
    local isActive = serverData ~= nil and serverData.rewards ~= nil and #serverData.rewards > 0
    self.uiRoot:SetActive(isActive)
    if isActive then
       self:PlayResourceIdleEffect() 
    end

    ---@type UnityEngine.Animator
    self.animator = self.transform:Find("RoleRoot/model"):GetComponent(TypeInfo.Animator)
end

function CoveProps:OnEventBtnClick()
    local serverData = Me:GetCovePropsInfo(self.id)
    local isActive = serverData ~= nil and serverData.rewards ~= nil and #serverData.rewards > 0
    if not isActive then
        self.uiRoot:SetActive(false)
        return
    end
    Me:ReportHomelandCovePropsGetRewardReq(self.id, function(data)
        self:RecvGetReward(data.rewardList)
    end)
end

function CoveProps:PlayResourceOpenEffect()
    self.uiRoot:SetActive(true)
    self.resourceSpine.AnimationState:SetAnimation(0, "appear", false)
    self.resourceSpine.AnimationState:AddAnimation(0, "idle", true, 0)
end

function CoveProps:PlayResourceIdleEffect()
    self.uiRoot:SetActive(true)
    self.resourceSpine.AnimationState:AddAnimation(0, "idle", true, 0)
end

function CoveProps:PlayResourceCloseEffect()

	self.uiRoot:SetActive(false)
    --[[
    self.uiRoot:SetActive(true)
    self.resourceSpine.AnimationState:SetAnimation(0, "appear", false)
    local startTime = self.resourceSpine.Skeleton.Data:FindAnimation("appear").Duration

    DLuaTimer:DoAfter(startTime, function ()
		self.uiRoot:SetActive(false)
    end)
    ]]
end

---播放交互动画
---@param type integer 事件类型
function CoveProps:PlayInteractEffect(type)
    local toggle = "action" .. type
    self.animator:SetTrigger(toggle)
end


---交互成功返回
function CoveProps:RecvInteractionSuccess()
    local isActive = self.uiRoot.activeSelf
    local nowActive = true
    if isActive == nowActive then
       return
    end
    self.uiRoot:SetActive(nowActive)
    self:PlayResourceOpenEffect()
end


---@param rewards RewardInfo[]?
function CoveProps:RecvGetReward(rewards)
    self:PlayResourceCloseEffect()
    if rewards == nil or #rewards == 0 then
        return
    end
    --GameMsgMgr:sendEvent(GameMsgType.PlayGetRewardEffect, {worldPos = self.eventBtn.transform.position, rewards = rewards})
end


return CoveProps
