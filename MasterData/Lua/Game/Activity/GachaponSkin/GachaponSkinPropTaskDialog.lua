---@type ActivityGachaponSkinMgr
local ActivityGachaponSkinMgr = import('Game.Activity.GachaponSkin.ActivityGachaponSkinMgr'):GetInstance()


--- from: Assets/BundleResources/Prefabs/GachaponSkin/GachaponSkinTaskDialog.prefab > name: GachaponSkinTaskDialog
---@class GachaponSkinPropTaskDialog
---@field Env                           	GachaponSkinPropTaskDialog              
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnDrawAll                    	UnityEngine.UI.Button                   	@ 0    
---@field TxtTime                       	UnityEngine.RectTransform               	@ 1    
---@field BtnClose                      	UnityEngine.RectTransform               	@ 2    
---@field TaskListView                  	SuperScrollView.LoopListView2           	@ 3    
local GachaponSkinPropTaskDialog = Class("GachaponSkinPropTaskDialog")
GachaponSkinPropTaskDialog.CloseEvent = "GachaponSkinPropTaskDialogCloseEvent"
local GACHAPON_SKIN_CONFIG = {
    --- 113001  活动类型
    ["113001"] ={
        TASK = Interfaces.ActivitySkinCallTask ,
        TASK_REWARDS = Interfaces.ActivitySkinCallReceiveTaskRewards ,
        ID = AutoIds.IdSetting6143,
        VO = "GachaSkinTaskVo",
    },
    ["113002"] = {
        TASK = Interfaces.ActivitySkinLotteryTask ,
        TASK_REWARDS = Interfaces.ActivitySkinLotteryTaskRewards ,
        ID = AutoIds.IdSetting6210,
        VO = "GachaponSkinPropTaskVo",
    },
    ["5011"] = {
        TASK = Interfaces.ActivitySkinTreasureTask ,
        TASK_REWARDS = Interfaces.ActivitySkinTreasureTaskRewards ,
        ID = AutoIds.IdSetting6726,
        VO = "GachaSkinTreasureTaskVo",
    }
}
---@class GachaponSkinPropTaskDialog.InputData
---@field activityUuid number

function GachaponSkinPropTaskDialog:__init()
    self.controller = nil
end

function GachaponSkinPropTaskDialog:__delete()
    self.controller = nil
end

function GachaponSkinPropTaskDialog:Awake()
    SetButtonAction(self.BtnClose.gameObject, function()
        self.controller:Close()
    end)
    
    SetButtonAction(self.BtnDrawAll.gameObject,Bind(self,self.OnClickDrawAll))
    
    CfUtils.SetActive(self.TxtTime.gameObject, false)
end

function GachaponSkinPropTaskDialog:OnInitialize() --LuaBehaviour 没有
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        ---@type GachaponSkinPropTaskDialog.InputData
        self.data = initParams
        local configData  =  self:GetConfig()
        self.severBack = false
        GameUtils.Request(configData.TASK, { activityUuid = self.data.activityUuid }, function(request, response)
            self.severBack = true
            if checkNumber(response.errCode) ~= 0 then
                return
            end
            self.tasks = checkTable(response.data.tasks)
            self:RefreshUI()
        end)
        
        while not self.severBack do
            CoYield()
        end
    end)
end

function GachaponSkinPropTaskDialog:GetConfig()
   return GACHAPON_SKIN_CONFIG[tostring(self.data.type)]
end

function GachaponSkinPropTaskDialog:RefreshUI()
    self:RefreshList()
end

function GachaponSkinPropTaskDialog:RefreshList()
    self:SortTaskData()
    if not self.TaskListView.IsListViewInit then
        self.TaskListView:InitListView(#self.tasks, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(self.TaskListView, #self.tasks)
    end
end

function GachaponSkinPropTaskDialog:SortTaskData()
    table.sort(self.tasks, function(a, b)
        if a.status == b.status then
            return a.id < b.id
        else
            if a.status == 1 then
                return true
            elseif a.status == 0 then
                return b.status ~= 1
            else
                return false
            end
        end
    end)
end

function GachaponSkinPropTaskDialog:OnGetItemByIndex(listView, index)
    local cell = listView:NewListViewItem("Cell")
    ---@type GachaponSkinPropTaskCell
    local env = CfUtils.GetLuaScr(cell, "Game.Activity.GachaponSkin.GachaponSkinPropTaskCell")
    ---@type GachaponSkinPropTaskCell.InputData
    local data = {}
    local configData  =  self:GetConfig()
    ---@type GachaponSkinPropTaskVo
    local vo = CfUtils.GetCfVo(configData.ID, configData.VO, self.tasks[index + 1].id)
    if vo then
        data.desc = vo.desc
        data.progress = self.tasks[index + 1].progress
        data.target = vo.taskContenNum
        data.rewardList = {{goodsId = vo.rewardId, goodsNum = vo.rewardNum}}
        data.status = self.tasks[index + 1].status
        data.openType = vo.openType
        data.openParameter = vo.openParameter
        data.taskId = self.tasks[index + 1].id
        env:RefreshData(data, Bind(self, self.OnClickDrawButton))    
    end
    return cell
end

function GachaponSkinPropTaskDialog:OnClickDrawButton(taskId)
   self:DrawRequest(self.data.activityUuid , taskId)
end

function GachaponSkinPropTaskDialog:OnClickDrawAll()
    local canDrawNum = self:GetCanDrawNum()
    if canDrawNum > 0 then
        self:DrawRequest(self.data.activityUuid , 0)
    end
end

function GachaponSkinPropTaskDialog:DrawRequest(activityUuid , taskId)
    local configData  =  self:GetConfig()
    GameUtils.Request(configData.TASK_REWARDS, { activityUuid = activityUuid, taskId = taskId }, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        
        local receiveTaskIds = checkTable(response.data.receiveTaskIds)
        for i, v in ipairs(self.tasks) do
            for j, k in ipairs(receiveTaskIds) do
                if v.id == k then
                    v.status = 2
                end
            end
        end
        local rewards = checkTable(response.data.rewards)
        GoodsUtils.DrawRewards(rewards,true)
        CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, { rewards = rewards })
        self:RefreshUI()
    end)
end

function GachaponSkinPropTaskDialog:OnFinalize()
    local redNum = self:GetCanDrawNum()
    Events.Broadcast(GachaponSkinPropTaskDialog.CloseEvent, {redNum =redNum ,activityUuid = self.data.activityUuid })
end
---@private
function GachaponSkinPropTaskDialog:GetCanDrawNum()
    local result = 0
    for i = 1, #self.tasks do
        if self.tasks[i].status == Constants.GetStatus.Can then
            result = result + 1
        end
    end
    return result
end

return GachaponSkinPropTaskDialog