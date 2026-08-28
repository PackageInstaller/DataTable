---
--- Created by Eric.
--- DateTime: 2022/11/21 16:44
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local cs_coroutine = require 'XLua.cs_coroutine'

------------ import ------------

------------ define ------------

------------ define ------------


--- from: Assets/BundleResources/Prefabs/SnowFestival/SnowFestivalMainDialog121501.prefab
---@class SnowFestivalMainDialog
---@field Env                           	SnowFestivalMainDialog
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field AnimRoot                      	UnityEngine.Animator
---@field RemindTask                    	UnityEngine.RectTransform
---@field ImgBan                        	UnityEngine.RectTransform
---@field BtnTask                       	UnityEngine.RectTransform
---@field RemindReview                  	UnityEngine.RectTransform
---@field BtnPlotReview                 	UnityEngine.RectTransform
---@field BtnDrawCard                   	UnityEngine.RectTransform
---@field BtnHelp                       	UnityEngine.RectTransform
---@field TextTime                      	UnityEngine.RectTransform
---@field OpenAnim                      	UnityEngine.RectTransform
---@field Close                         	UnityEngine.RectTransform
---@field Slider                        	UnityEngine.UI.Slider
---@field Open                          	UnityEngine.RectTransform
local SnowFestivalMainDialog = Class("SnowFestivalMainDialog")
function SnowFestivalMainDialog:__init()
    
end

function SnowFestivalMainDialog:__delete()
    


    self.controller = nil
end

function SnowFestivalMainDialog:Awake()
    self.EventPlotPlay = Events.AddListener(Constants.EventNames.IsPlotPlaying, Bind(self, self.PlotPlaying))
    GameUtils.BindRedPoint(Constants.RedPointConst.MainActivitySnowFestival , self.BtnTask)
end

function SnowFestivalMainDialog:PlotPlaying(isPlotPlaying)
    self.controller.gameObject.transform.localPosition = isPlotPlaying and Vector3(9999, 9999, 9999) or Vector3(0, 0, 0)
end

function SnowFestivalMainDialog:OnFocus(focus)
end

function SnowFestivalMainDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
    end))
    return coWait
end

function SnowFestivalMainDialog:OnShow()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.SnowFestivalComponent)
        self.activityDojo = comp:GetActivityDojo()
        GameUtils.Request(
                Interfaces.ActivityIceSnowFestivalHome,
                {activityUuid = self.activityDojo.id},
                function(request, response)
                    if checkInt(response.errCode) == 0 then
                        comp:InitHomeData(response.data)
                        self.data = comp:GetHomeData()
                        print("---->>"..table.dump(response.data, nil, 3))
                        self:SetBtnAction()



                        self:FreshBaseUI()
                        self:FreshProgress()
                        self:CheckRedPoint()
                    end
                end
        )
    end))
    return coWait
end
function SnowFestivalMainDialog:CheckRedPoint()
    local num = 0 
    if isNotNull(self.data.taskRedDotHint) and checkInt(self.data.taskRedDotHint) >= 0 then
        num = 1
    end
    if num == 0 then
        local point = checkInt(self.data.point)
        local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.SnowFestivalComponent)
        ---@type SnowFestivalPlotVo[]
        local plotConfigData = comp:GetPlotConfigData()
        -- 是否有可解锁的剧情 
        for k, v in pairs(plotConfigData) do
            local id = checkInt(v.id)
            local isHave = false
            for kk , vv in pairs(self.data.unlockedPlotIds or {}) do
                if checkInt(vv) == id then
                    isHave = true
                    break
                end
            end 
            if not isHave then
                print(v.id )
                print(v.unlockPoint )
                if checkInt(self.data.point) >= checkInt(v.unlockPoint) then
                    num = 1 
                    break
                end 
            end
        end
    end
    
    if num == 0 then
        local unlockedPlotIdsNum = table.count(self.data.unlockedPlotIds or {}) 
        local receivedPlotIdsNum = table.count(self.data.receivedPlotIds or {}) 
        if unlockedPlotIdsNum > receivedPlotIdsNum then
            num = 1
        end
    end
    GameUtils.SetRedPointNum(Constants.RedPointConst.MainActivitySnowFestival , num)
    GameUtils.InvokeRedPointCallBack(Constants.RedPointConst.MainActivitySnowFestival)
end

function SnowFestivalMainDialog:SetBtnAction()

    local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.SnowFestivalComponent)
    local activityConfigData = comp:GetActivityConfigData()
    SetButtonAction(self.BtnDrawCard.gameObject, function()
        self:__ExecuteJump(activityConfigData.moduleId, activityConfigData.jumpPool)
    end)

    SetButtonAction(self.BtnHelp.gameObject, function()
        CfUtils.ShowModuleToast(activityConfigData.ruleID)
    end)

    SetButtonAction(self.BtnPlotReview.gameObject, function()
        UIModule.OpenDialog({ id = Constants.UITypeIds.SnowFestivalPlotReviewDialog, parameters = {
            --cb = function (status)
            --end
        }},

                {
                    --{id = Constants.UITypeIds.UIActivityMainDialog}
                })
    end)
    
    SetButtonAction(self.BtnTask.gameObject, function()
        local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.SnowFestivalComponent)
        local isEnd = comp:IsEnd()
        if isEnd then
            GameUtils.Toast(localize("入口已关闭"))
            return
        end
        UIModule.OpenDialog({ id = Constants.UITypeIds.SnowFestivalScoreTaskDialog, parameters = {
            --cb = function (status)
            --end
        }},

                {
                    {id = Constants.UITypeIds.SnowFestivalMainDialog}
                })
    end)
end


function SnowFestivalMainDialog:FreshBaseUI()
    local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.SnowFestivalComponent)
    local startTime =  self.activityDojo.startTime
    local endTime =  self.activityDojo.endTime
    CfUtils.FillText(self.TextTime, os.date("%Y.%m.%d", startTime).."-"..os.date("%Y.%m.%d  %H:%M", endTime))
    --CfUtils.FillText(self.TextTime.transform, os.date("%Y.%m.%d", startTime).." 5:00:00 ~ "..os.date("%Y.%m.%d", endTime).." 4:59:59")
    CfUtils.FillText(self.RemindTask, table.count(self.data.unlockedPlotIds))
    KTool.SetActive(self.RemindReview, comp.isUnlockNewPlot)
    local isEnd = comp:IsEnd()
    KTool.SetActive(self.ImgBan, isEnd)
end

function SnowFestivalMainDialog:FreshProgress()
    local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.SnowFestivalComponent)

    local numerator, denominator = comp:GetProgressNumber()
    local progress = numerator / denominator
    self.Slider.value = progress
    local isEnd = comp:IsEnd()
    self.AnimRoot:SetBool("isFinish", progress > 1)
    self.AnimRoot:SetBool("isOpen", progress == 1)
    self.AnimRoot:Play("enter")
    KTool.SetActive(self.OpenAnim, progress >= 1 and (not isEnd))
    KTool.SetActive(self.Open, progress < 1 and (not isEnd))
    KTool.SetActive(self.Close, isEnd)

    --local isFinish = 
    
end

function SnowFestivalMainDialog:__ExecuteJump(moduleId, param)
    local blocker = CS.Engine.UI.UIRaycastBlocker.Instance
    blocker:AddCondition("__ExecuteJump")
    local goodsConfMgr = GoodsConfMgr:GetInstance()
    xTry(function()
        cs_coroutine.start(function()
            Events.Broadcast(Constants.EventNames.MainHomeRoleActive, { isShow = false })
            --[[
            local isShow = false
            GameUtils.ShowBlackOverlay(nil, function()
                while not isShow do
                    coroutine.yield(Yielders.EndOfFrame)
                end
            end)
            coroutine.yield(WaitForSeconds(0.5))
            ]]
            local row = goodsConfMgr:GetJumpModuleRow(moduleId)
            if row then
                if not goodsConfMgr:CheckIsCanJump(row) then
                    blocker:RemoveCondition("__ExecuteJump")
                    return
                end
                --self:DisEnabledCanvas()
                cs_coroutine.yield_return(goodsConfMgr:ExecuteJump(row, {}, 0, nil, param))
            end
            --coroutine.yield(WaitForSeconds(5))
            --isShow = true
            blocker:RemoveCondition("__ExecuteJump")
        end)
    end, function()
        print_to_file(debug.traceback())
        blocker:RemoveCondition("__ExecuteJump")
    end)
end

function SnowFestivalMainDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        Events.RemoveListener(Constants.EventNames.IsPlotPlaying, self.EventPlotPlay)
        GameUtils.RemoveRedPointCallBack(Constants.RedPointConst.MainActivitySnowFestival)
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return SnowFestivalMainDialog