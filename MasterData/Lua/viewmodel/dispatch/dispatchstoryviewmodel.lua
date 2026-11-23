







require("ViewModel/Dispatch/DispatchStoryItem")
local objs = {
    leftGroup = {path = "root/Mask/Group/LeftGroup", type = UITool.GameObject},
    rightGroup = {path = "root/Mask/Group/RightGroup", type = UITool.GameObject},
    leftNoneStory = {path = "root/Mask/Group/LeftNoneStory", type = UITool.GameObject},
    rightNoneStory = {path = "root/Mask/Group/RightNoneStory", type = UITool.GameObject},
    closeBtn = {path = "root/Mask/Group/CloseBtn", type = UITool.Button},
    leftPageBtn = {path = "root/Mask/Group/LeftPageBtn", type = UITool.Button},
    rightPageBtn = {path = "root/Mask/Group/RightPageBtn", type = UITool.Button},
    groupAnim = {path = "root/Mask/Group", type = UITool.Animator}
}

local this = {

    leftStoryItem = nil,

    rightStoryItem = nil,
    newStoryID = nil,
    configDic = {},
    leftHideAnimName = "ani_DispatchStoryViewModel_Group_L1",
    leftShowAnimName = "ani_DispatchStoryViewModel_Group_L2",
    rightHideAnimName = "ani_DispatchStoryViewModel_Group_R1",
    rightShowAnimName = "ani_DispatchStoryViewModel_Group_R2"
}

this.before_awake = function()
    this.leftStoryItem = DispatchStoryItem.New(this.leftGroup, this.OnGetReward)
    this.rightStoryItem = DispatchStoryItem.New(this.rightGroup, this.OnGetReward)
    SetActive(this.closeBtn.gameObject, false)
end

this.before_active = function()
    local datas = DispatchData.GetStoryDatas()
    if datas == nil then
        return
    end
    local datasLen = NumTool.GetLen(datas)
    this.foreachLen = 0
    if datasLen % 2 ~= 0 then
        this.foreachLen = math.floor(datasLen / 2) + 1
    else
        this.foreachLen = math.floor(datasLen / 2)
    end
    this.lastBigStroyIndex = nil
    for i = 0, this.foreachLen - 1 do
        local leftIndex = i * 2 + 1
        local rightIndex = i * 2 + 2
        local leftData = datas[leftIndex]
        local rightData = datas[rightIndex]
        if this.newStoryID == nil then
            if leftData ~= nil and leftData.status == DispatchData.GetRewardStatus.CanGet then
                this.lastBigStroyIndex = i
                this.leftStoryItem:SetData(leftData)
            end
            if this.lastBigStroyIndex == nil and rightData ~= nil and rightData.status == DispatchData.GetRewardStatus.CanGet then
                this.lastBigStroyIndex = i
                this.rightStoryItem:SetData(rightData)
            end
        else
            if leftData ~= nil and tostring(leftData.config.ID) == this.newStoryID then
                this.lastBigStroyIndex = i
                this.leftStoryItem:SetData(leftData)
            end
            if rightData ~= nil and tostring(rightData.config.ID) == this.newStoryID then
                this.lastBigStroyIndex = i
                this.rightStoryItem:SetData(rightData)
            end
        end
        if this.lastBigStroyIndex ~= nil then
            break
        end
    end
    if this.lastBigStroyIndex == nil then
        this.lastBigStroyIndex = 0
    end
    this.SetPageData()
end

this.SetPageBtnVisible = function()
    if this.foreachLen <= 1 then
        this.leftPageBtn.interactable = false
        this.rightPageBtn.interactable = false
    elseif this.lastBigStroyIndex == 0 then
        this.leftPageBtn.interactable = false
        this.rightPageBtn.interactable = true
    elseif this.lastBigStroyIndex + 1 >= this.foreachLen then
        this.leftPageBtn.interactable = true
        this.rightPageBtn.interactable = false
    else
        this.leftPageBtn.interactable = true
        this.rightPageBtn.interactable = true
    end
end

this.SetPageData = function()
    local datas = DispatchData.GetStoryDatas()
    if datas == nil then
        return
    end
    local leftData = datas[this.lastBigStroyIndex * 2 + 1]
    local rightData = datas[this.lastBigStroyIndex * 2 + 2]
    if leftData ~= nil then
        this.leftStoryItem:SetData(leftData)
    end
    if rightData ~= nil then
        this.rightStoryItem:SetData(rightData)
    end
    local showLeftGroup = leftData ~= nil and (leftData.status == DispatchData.GetRewardStatus.CanGet or leftData.status == DispatchData.GetRewardStatus.Got)
    local showRightGroup = rightData ~= nil and (rightData.status == DispatchData.GetRewardStatus.CanGet or rightData.status == DispatchData.GetRewardStatus.Got)
    SetActive(this.leftGroup, showLeftGroup == true)
    SetActive(this.rightGroup, showRightGroup == true)
    SetActive(this.leftNoneStory, showLeftGroup == false)
    SetActive(this.rightNoneStory, showRightGroup == false)
    this.SetPageBtnVisible()
end



this.OnGetReward = function(item)
    if item.data.status == DispatchData.GetRewardStatus.Got then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23720")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local data = {
        NarrativeId = tostring(item.data.config.ID)
    }
    local onsuccess = function(result)
        local res = json.decode(result)
        if res.code ~= 0 then
            return
        end
        local reward = json.encode(res.result)
        LuaMgr.ShowItemRewared(reward)
        this.SetPageData()
    end
    ApiMgr.Request("dispatchRegular/storyReward", data, true, onsuccess, nil, true)
end

this.OnClickCloseBtn = function()
    LuaMgr.Back()
end

this.OnClickLeftPageBtn = function()
    this.lastBigStroyIndex = this.lastBigStroyIndex - 1
    this.lastBigStroyIndex = math.max(this.lastBigStroyIndex, 0)
    this.SetPageAnim()
end

this.OnClickRightPageBtn = function()
    this.lastBigStroyIndex = this.lastBigStroyIndex + 1
    this.lastBigStroyIndex = math.min(this.lastBigStroyIndex, this.foreachLen - 1)
    this.SetPageAnim()
end

this.SetPageAnim = function()
    this.groupAnim:Play(this.leftHideAnimName)
    this.groupAnim:Play(this.rightHideAnimName)
    local callBack = function()
        this.SetPageData()
        this.groupAnim:Play(this.leftShowAnimName)
        this.groupAnim:Play(this.rightShowAnimName)
    end
    if this.sequence ~= nil then
        this.sequence:Kill()
        this.sequence = nil
    end
    this.sequence = DOTWeen:Sequence()
    this.sequence:AppendInterval(0.5):OnComplete(callBack)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.closeBtn, this.OnClickCloseBtn)
        LuaMgr.AddClick(this.leftPageBtn, this.OnClickLeftPageBtn)
        LuaMgr.AddClick(this.rightPageBtn, this.OnClickRightPageBtn)
    end,
    before_active = function(vm)
        if vm.behaviour.Params ~= nil and vm.behaviour.Params.Length > 0 then
            this.newStoryID = tostring(vm.behaviour.Params[0])
        end
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickCloseBtn)
        LuaMgr.RemoveClick(this.leftPageBtn, this.OnClickLeftPageBtn)
        LuaMgr.RemoveClick(this.rightPageBtn, this.OnClickRightPageBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)