---
--- Created by Eric.
--- DateTime: 2022/6/10 15:33
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local MediumPTActivityComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.MediumPTActivityComponent)

------------ import ------------

------------ define ------------

------------ define ------------


--- from: Assets/BundleResources/Prefabs/Common/CommonActivityListDialog.prefab
---@class CommonActivityListDialog
---@field Env                           	CommonActivityListDialog
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field FontStyleButton               	UnityEngine.RectTransform
---@field Text2                         	UnityEngine.UI.Text
---@field TaskList                      	SuperScrollView.LoopListView2
---@field BtnRoleNameNode               	UnityEngine.RectTransform
---@field ImgIcon                       	Engine.UI.RawImageAlterable
---@field TexNumber                     	TMPro.TextMeshProUGUI
---@field ImgRole                       	UnityEngine.RectTransform
---@field ImgBg                         	Engine.UI.RawImageAlterable
local CommonActivityListDialog = Class("CommonActivityListDialog")
function CommonActivityListDialog:__init()
    self.rewardsDojo = {}
    self.rewardsData = {}--排序后的数据
    self.isShowCV  = nil

end

function CommonActivityListDialog:__delete()
    self.rewardsDojo = nil
    self.rewardsData = nil
    self.isShowCV  = nil


    self.controller = nil
end

function CommonActivityListDialog:Awake()
    --local parameters = self.controller.Argument.parameters
    local initParams = self.controller.Argument.parameters or {}
    self.isShowCV = (initParams.isShowCV == nil) or initParams.isShowCV
    local activityConf = MediumPTActivityComponent.activityConf
    self.ImgBg:LoadSprite(activityConf.showCardBg)
    local skinVo = CardConfMgr:GetInstance():GetCardDefaultSkinByCardId(activityConf.showCard)
    self.ImgRole.gameObject:EnsureComponent(typeof(CS.Game.Native.Common.DrawingNode)):Execute(checkNumber(skinVo.skinId), -1, -1, "hdCardDrawing")


    --self.ImgRole:LoadSprite(skinVo.hdCardDrawing)
    self.TexNumber.text = MediumPTActivityComponent.rewardsPoint
    local currencyVo = GoodsConfMgr:GetGoodsVoById(activityConf.ptItem)
    self.ImgIcon:LoadSprite(currencyVo.photoPath)

    local env = CfUtils.GetLuaScr(self.BtnRoleNameNode, "Game.UI.Common.CommonBtnRoleNameNode")
    if env then
        env:RefreshSelf(activityConf.showCard, nil, nil, true , nil , self.isShowCV )
    end

    self.rewardsDojo = MediumPTActivityComponent.rewardsInfo
    self:SortRewardsData()
    if not self.TaskList.IsListViewInit then
        self.TaskList:InitListView(#self.rewardsData, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(self.TaskList, #self.rewardsData)
    end

    local curTime = os.time()
    local StoreUtils = import('Game.UI.Store.StoreUtils')
    self.Text2.text = StoreUtils.FormatTime(MediumPTActivityComponent.activityPlotQuest.closeTime - curTime, true)

    local redPointCount = self:GetUnclaimedTaskCount()
    KTool.SetActive(self.FontStyleButton, redPointCount > 0)
    SetButtonAction(self.FontStyleButton, function ()
        local redPointCountNew = self:GetUnclaimedTaskCount()
        if redPointCountNew > 0 then
            self:GetMainTaskRewards(nil)
        end
    end)

end



function CommonActivityListDialog:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem("Cell")
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, "Game.UI.Common.CommonActivityListCell")
    if nodeEnv then
        local luaIndex = index + 1
        local data = self.rewardsData[luaIndex]
        nodeEnv:FreshBaseUI(data)
        nodeEnv:SetBtnCallBack(function()
            self:GetMainTaskRewards(data.id)
        end)
    end
    return cell
end

function CommonActivityListDialog:SortRewardsData()
    local canList = {}
    local notList = {}
    local getList = {}
    for k, v in pairs(self.rewardsDojo) do
        if v.status == Constants.GetStatus.Can then
            table.insert(canList, v)
        elseif v.status == Constants.GetStatus.Not then
            table.insert(notList, v)
        elseif v.status == Constants.GetStatus.Has then
            table.insert(getList, v)
        end
    end
    self.rewardsData = {}
    for k, v in pairs(canList) do
        table.insert(self.rewardsData, v)
    end
    for k, v in pairs(notList) do
        table.insert(self.rewardsData, v)
    end
    for k, v in pairs(getList) do
        table.insert(self.rewardsData, v)
    end
end

function CommonActivityListDialog:MaintainTaskStatus(id)
    if id then
        for i, v in pairs(self.rewardsDojo) do
            if checkNumber(id) == checkNumber(v.id) and checkNumber(v.status) == Constants.GetStatus.Can then
                v.status = Constants.GetStatus.Has
            end
        end
    else
        for i, v in pairs(self.rewardsDojo) do
            if checkNumber(v.status) == Constants.GetStatus.Can then
                v.status = Constants.GetStatus.Has
            end
        end
    end
    self:SortRewardsData()
end

function CommonActivityListDialog:GetMainTaskRewards(id)
    local activityUuid = MediumPTActivityComponent.activityPlotQuest.activityUuid
    GameUtils.Request(
            Interfaces.ActivityPlotQuestDrawReward,
            {rewardId = id, activityUuid = activityUuid},
            function(request, response)
                if checkInt(response.errCode) == 0 then
                    --数据维护
                    self:MaintainTaskStatus(id)
                    --入包
                    GoodsUtils.DrawRewards(response.data.rewards)
                    --刷新货币栏
                    GameUtils.UpdateNavBarShowGoods({
                        Constants.Currency.HpId,
                        Constants.Currency.GoldId,
                        Constants.Currency.FreeDiamondId,
                    })
                    --打开通用获取UI
                    UIModule.OpenDialog(
                            {
                                id = Constants.UITypeIds.UICommonRewardPop,
                                parameters = { rewards = response.data.rewards }
                            }
                    )
                    GameUtils.ReloadData(self.TaskList, #self.rewardsData)
                    --红点
                    local redPointCount = self:GetUnclaimedTaskCount()
                    KTool.SetActive(self.FontStyleButton, redPointCount > 0)
                end
            end
    )
end

function CommonActivityListDialog:GetUnclaimedTaskCount()
    local count = 0
    for i, v in pairs(self.rewardsDojo) do
        if checkNumber(v.status) == Constants.GetStatus.Can then
            count = count + 1
        end
    end
    return count
end


function CommonActivityListDialog:OnFocus(focus)
end

function CommonActivityListDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end

function CommonActivityListDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return CommonActivityListDialog