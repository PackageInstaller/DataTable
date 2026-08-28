---@type OverseaClubCatCarMgr
local Mgr = import("Game.UI.Club.CatCar.OverseaClubCatCarMgr"):GetInstance()
---@type OverseaClubCatCarUtils
local OverseaClubCatCarUtils = import("Game.UI.Club.CatCar.OverseaClubCatCarUtils")

local UIRaycastBlocker = CS.Engine.UI.UIRaycastBlocker.Instance

local OpenAnimName = "OverseaClubCatCarScrapeRewardDialog_JackpotNode_Open"
local ResetAnimName = "OverseaClubCatCarScrapeRewardDialog_JackpotNode_Reset"

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCatCarScrapeRewardDialog.prefab > name: OverseaClubCatCarScrapeRewardDialog
---@class OverseaClubCatCarScrapeRewardDialog
---@field Env                           	OverseaClubCatCarScrapeRewardDialog     
---@field controller                    	Engine.UI.UILuaDialog                   
---@field TextTime                      	UnityEngine.RectTransform               	@ 0    
---@field RewardLoopView                	SuperScrollView.LoopListView2           	@ 1    
---@field ScrapeAnimNode                	UnityEngine.RectTransform               	@ 2    
---@field ImgGrade                      	UnityEngine.RectTransform               	@ 3    
---@field BtnView                       	UnityEngine.RectTransform               	@ 4    
---@field Scrape                        	UnityEngine.RectTransform               	@ 5    
---@field TxtScrapeTitle                	UnityEngine.RectTransform               	@ 6    
---@field TxtScrapeNum                  	UnityEngine.RectTransform               	@ 7    
---@field TxtHaveNum                    	UnityEngine.RectTransform               	@ 8    
---@field TxtRecord                     	UnityEngine.RectTransform               	@ 9    
---@field BtnRecord                     	UnityEngine.RectTransform               	@ 10   
---@field Record                        	UnityEngine.RectTransform               	@ 11   
---@field BtnCloseRecord                	UnityEngine.RectTransform               	@ 12   
---@field RecordLoopView                	SuperScrollView.LoopListView2           	@ 13   
local OverseaClubCatCarScrapeRewardDialog = Class("OverseaClubCatCarScrapeRewardDialog")

---@class OverseaClubCatCarScrapeRewardDialog.InputData

function OverseaClubCatCarScrapeRewardDialog:__init()
    self.controller = nil
end

function OverseaClubCatCarScrapeRewardDialog:__delete()
    self.controller = nil
end

function OverseaClubCatCarScrapeRewardDialog:Awake()
    SetButtonAction(self.BtnView,Bind(self,self.OnRewardViewClick))
    SetButtonAction(self.Scrape,Bind(self,self.OnScrapeClick))
    SetButtonAction(self.BtnRecord,Bind(self,self.OnRecordClick))
    SetButtonAction(self.BtnCloseRecord,function() CfUtils.SetActive(self.Record.gameObject,false) end)
    
    CfUtils.SetActive(self.Record.gameObject,false)
end

function OverseaClubCatCarScrapeRewardDialog:RefreshTopGoods()
    GameUtils.RefreshTopGoods(Constants.UITypeIds.OverseaClubCatCarScrapeRewardDialog)
end

---@param inData OverseaClubCatCarScrapeRewardDialog.InputData
function OverseaClubCatCarScrapeRewardDialog:RefreshData(inData)
    self.inData = inData
    
    
    
    
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end

    if checkNumber(Mgr.Server.dojo.convertCallNum) ~= 0 then
        CfUtils.SetActive(self.controller.gameObject, false)
        CfUtils.DialogOpen(Constants.UITypeIds.OverseaClubCatCarBossSettlementDialog,{scrapePanel = self.controller.gameObject})
    end
end

function OverseaClubCatCarScrapeRewardDialog:RefreshUI()
    local scrapeDojo = Mgr.Server.dojo.catCarCallInfo
    CfUtils.FillText(self.TextTime, localize("活动时间：_time_",{_time_ = OverseaClubCatCarUtils:GetActivityDurationTime()}))
    CfUtils.SetUISwitchImage(self.ImgGrade,Mgr.Server.dojo.clubCatCarLevel)
    local calledItem = scrapeDojo.callConf[checkNumber(scrapeDojo.calledId)]
    if calledItem then
        CfUtils.FillText(self.TxtScrapeTitle,OverseaClubCatCarUtils:GetRewardLevelName(calledItem.type))
        CfUtils.FillText(self.TxtScrapeNum,"No."..calledItem.id)
    end
    
    CfUtils.FillText(self.TxtHaveNum,localize("拥有奖卷：_num_",{_num_ = scrapeDojo.playerCallNum}))
    CfUtils.FillText(self.TxtRecord,OverseaClubCatCarUtils:GetScrapeRewardDesc(scrapeDojo.callLog[1]))
    
    self:RefreshRewardList()
end

function OverseaClubCatCarScrapeRewardDialog:RefreshRewardList()
    self.rewardGroups = OverseaClubCatCarUtils:GroupCallConfByType(Mgr.Server.dojo.catCarCallInfo.callConf)
    
    if not self.RewardLoopView.IsListViewInit then
        self.RewardLoopView:InitListView(#self.rewardGroups, Bind(self, self.OnGetRewardItemByIndex))
    else
        GameUtils.ReloadData(self.RewardLoopView, #self.rewardGroups)
    end
end

function OverseaClubCatCarScrapeRewardDialog:OnGetRewardItemByIndex(listView, index)
    local cell --= listView:NewListViewItem("OverseaClubCatCarScrapeRewardNode")
    ---@type OverseaClubCatCarScrapeRewardNode.InputData
    local data = self.rewardGroups[index + 1]
    if data.type == 3 then
        cell = listView:NewListViewItem("OverseaClubCatCarScrapeRewardNode3")
    else
        cell = listView:NewListViewItem("OverseaClubCatCarScrapeRewardNode")
    end
    ---@type OverseaClubCatCarScrapeRewardNode
    local lua = CfUtils.GetLuaScr(cell, "Game.UI.Club.CatCar.Scrape.OverseaClubCatCarScrapeRewardNode")
    lua:RefreshData(self.rewardGroups[index + 1])
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(cell.transform)
    return cell
end

function OverseaClubCatCarScrapeRewardDialog:OnRewardViewClick()
    CfUtils.DialogOpen(Constants.UITypeIds.OverseaClubCatCarLottoRewardPopup)
end

function OverseaClubCatCarScrapeRewardDialog:OnScrapeClick()
    if checkNumber(Mgr.Server.dojo.catCarCallInfo.playerCallNum) == 0 then
        GameUtils.Toast(localize("奖卷不足"))
        return
    end
    
    Mgr.Server:ReqCallPool(function()
        CoStart(function()
            UIRaycastBlocker:AddCondition("ScrapeAnim")
            local animTime  = CfUtils.GetAnimationTime(self.ScrapeAnimNode, OpenAnimName)
            self:RefreshUI()
            self:RefreshTopGoods()
            CfUtils.PlayAnimation(self.ScrapeAnimNode, OpenAnimName)
            CoYield(animTime + 0.5)
            CfUtils.PlayAnimation(self.ScrapeAnimNode, ResetAnimName)
            UIRaycastBlocker:RemoveCondition("ScrapeAnim")
        end)
    end)
end

function OverseaClubCatCarScrapeRewardDialog:OnRecordClick()
    Mgr.Server:ReqLogs(function()
        self:RefreshRecordList()
    end)
end

function OverseaClubCatCarScrapeRewardDialog:RefreshRecordList()
    if Mgr.Server.dojo.catCarCallInfo.log == nil or #Mgr.Server.dojo.catCarCallInfo.log == 0 then
        GameUtils.Toast(localize("暂无抽奖记录"))
        return
    end
    CfUtils.SetActive(self.Record.gameObject,true)
    if not self.RecordLoopView.IsListViewInit then
        self.recordSelectIndex = 0
        self.RecordLoopView:InitListView(#Mgr.Server.dojo.catCarCallInfo.log, Bind(self, self.OnGetRecordItemByIndex))
    else
        GameUtils.ReloadData(self.RecordLoopView, #Mgr.Server.dojo.catCarCallInfo.log)
    end
end

function OverseaClubCatCarScrapeRewardDialog:OnGetRecordItemByIndex(listView, index)
    local cell = listView:NewListViewItem("OverseaClubCatCarScrapeRecordNode")
    ---@type OverseaClubCatCarScrapeRecordNode
    local lua = CfUtils.GetLuaScr(cell, "Game.UI.Club.CatCar.Scrape.OverseaClubCatCarScrapeRecordNode")
    
    local data = Mgr.Server.dojo.catCarCallInfo.log[index + 1]
    data.selected = index == self.recordSelectIndex
    lua:RefreshData(data,function()
        if self.recordSelectIndex == index then
            return
        end
        local preItem = self.RecordLoopView:GetShownItemByIndex(self.recordSelectIndex)
        if preItem then
            ---@type OverseaClubCatCarScrapeRecordNode
            local preLua = CfUtils.GetLuaScr(preItem, "Game.UI.Club.CatCar.Scrape.OverseaClubCatCarScrapeRecordNode")
            preLua:Select(false)
        end
        self.recordSelectIndex = index
        lua:Select(true)
    end)
    return cell
end

return OverseaClubCatCarScrapeRewardDialog