--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/ActivityCatGirlPK12003201/ActivityCatGirlPKGetTicketDialog.prefab > name: ActivityCatGirlPKGetTicketDialog
---@class ActivityCatGirlPKGetTicketDialog
---@field Env                           	ActivityCatGirlPKGetTicketDialog        
---@field controller                    	Engine.UI.UILuaDialog                   
---@field EmptyClose                    	UnityEngine.RectTransform               	@ 0    
---@field TxtGoodsName                  	UnityEngine.RectTransform               	@ 1    
---@field TxtHold                       	UnityEngine.RectTransform               	@ 2    
---@field GoodNode1                     	Engine.Modules.LuaBehaviour             	@ 3    
---@field BtnGet1                       	UnityEngine.RectTransform               	@ 4    
---@field BtnGo1                        	UnityEngine.RectTransform               	@ 5    
---@field Slider1                       	UnityEngine.UI.Slider                   	@ 6    
---@field TitleText1                    	UnityEngine.RectTransform               	@ 7    
---@field Slider2                       	UnityEngine.UI.Slider                   	@ 8    
---@field BtnGet2                       	UnityEngine.RectTransform               	@ 9    
---@field BtnGo2                        	UnityEngine.RectTransform               	@ 10   
---@field TitleText2                    	UnityEngine.RectTransform               	@ 11   
---@field GoodNode2                     	Engine.Modules.LuaBehaviour             	@ 12   
---@field NameTxt1                      	UnityEngine.RectTransform               	@ 13   
---@field NameTxt2                      	UnityEngine.RectTransform               	@ 14   
---@field Text2                         	UnityEngine.RectTransform               	@ 15   
---@field Text1                         	UnityEngine.RectTransform               	@ 16   
---@field ButtonGet                     	UnityEngine.RectTransform               	@ 17   
---@field TxtRefresh                    	UnityEngine.RectTransform               	@ 18   
---@field UIEffectCaptured              	UGUI.Effects.UIEffectCapturedImage      	@ 19   
---@field ImgGoodsIcon                  	UnityEngine.RectTransform               	@ 20   
local ActivityCatGirlPKGetTicketDialog = Class('ActivityCatGirlPKGetTicketDialog')
local cs_coroutine = require 'XLua.cs_coroutine'
local Yielders = CS.Engine.Lib.Yielders

---@type ActivityVoteComponent
local ActivityVoteComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.ActivityVoteComponent)
local KTool = CS.Engine.Lib.KTool
function ActivityCatGirlPKGetTicketDialog:__init()
end


function ActivityCatGirlPKGetTicketDialog:__delete()
end


function ActivityCatGirlPKGetTicketDialog:Awake()
    SetButtonAction(self.EmptyClose , function ()
        CS.Engine.UI.UIModule.BackDialog()
    end)
    SetButtonAction(self.ButtonGet , function ()
        local goodsConfMgr = GoodsConfMgr:GetInstance()
        local row = goodsConfMgr:GetJumpModuleRow(802)
        goodsConfMgr:ExecuteJump(row, {})
    end)
end


function ActivityCatGirlPKGetTicketDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        
    end)
end

function ActivityCatGirlPKGetTicketDialog:OnShow()
    return CoWaitDo(function()
        -- local initParams = self.controller.Argument.parameters or {}
        -- self:UpdateDailyTask()
        self:UpdateDailyTask()
       self:OnCapter()
       
    end)
end
function ActivityCatGirlPKGetTicketDialog:OnCapter()
    cs_coroutine.start(function ()
        local isExits = UICommonUtils.CheckIsExistsBlackOverLay()
        if isExits then
            while UICommonUtils.CheckIsExistsBlackOverLay() do
                CoYield()
            end
            self.UIEffectCaptured:Capture()
        else
            self.UIEffectCaptured:Capture()
        end
    end)
end


function ActivityCatGirlPKGetTicketDialog:UpdateDailyTask()
    CfUtils.FillImage(self.ImgGoodsIcon , GoodsConfMgr:GetInstance():GetPhotoPathById(ActivityVoteComponent:GetVoteGoodsId()))
    CfUtils.FillText(self.TxtRefresh , localize("每日5点刷新"))
    local voteGoodsId = ActivityVoteComponent:GetVoteGoodsId()
    ---@type GoodsVo
    local GoodVo = GoodsConfMgr:GetInstance():GetGoodsVoById(voteGoodsId)
    local name = GoodVo.name 
    CfUtils.FillText(self.TxtGoodsName , name)
    CfUtils.FillText(self.TxtHold ,localize("持有:_num_" , { _num_ = GoodsUtils.GetThingNo(voteGoodsId)}) )
    local cells = {
        {GoodNode = self.GoodNode1 , BtnGet = self.BtnGet1 , BtnGo = self.BtnGo1 , Slider=self.Slider1,  TitleText = self.TitleText1 , NameTxt = self.NameTxt1 , Text = self.Text1  },
        {GoodNode = self.GoodNode2 , BtnGet = self.BtnGet2 , BtnGo = self.BtnGo2, Slider=self.Slider2,  TitleText = self.TitleText2 ,NameTxt = self.NameTxt2, Text = self.Text2 }
    }
    local dialyTask = ActivityVoteComponent:GetDailyTask()
    for i = 1 , 2 do
        local oneCell = cells[i]
        local data = dialyTask[i]
        local targetNum = data.targetNum
        local id = data.id 
        local progress = data.progress
        local rewardData = data.rewards[1]
        local status = data.status
        if status == Constants.GetStatus.Not then
            KTool.SetActive(oneCell.BtnGo , checkInt(data.openType)  > 0 )
            KTool.SetActive(oneCell.BtnGet , false)
        elseif status == Constants.GetStatus.Can then
            KTool.SetActive(oneCell.BtnGo , false)
            KTool.SetActive(oneCell.BtnGet , true)    
        elseif status == Constants.GetStatus.Has then
            KTool.SetActive(oneCell.BtnGo , true)
            KTool.SetActive(oneCell.BtnGet , false)
            CfUtils.FillText(oneCell.Text , localize("已领取"))
        end
        if isNotNull(data.desc) then
            CfUtils.FillText(oneCell.NameTxt , data.desc)    
        end
        local GoodNode = oneCell.GoodNode
        ---@type GoodNodeMB
        local ENV = CfUtils.GetLuaScr(GoodNode, "Game.Behaviours.GoodNodeMB") 
        ENV:Reload({
            goodsId = rewardData.goodsId,
            isShowNo = true,
            text = "x" .. rewardData.num,
        })
        ENV:SetClickButtonAction(function(goodsId)
            local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
            GameUtils.ShowCommonTipsBoard(GoodNode, vo.name, vo.desc, vo.quality, vo.id, true)
        end)
        SetButtonAction(oneCell.BtnGet , function ()
            GameUtils.Request(Interfaces.ActivityVoteDrawDailyTaskReward , {activityUuid = ActivityVoteComponent:GetActivityUuid() ,taskId = id } , function(request, response)
                if checkNumber(response.errCode) ~= 0 then return end
                local jsonData = response.data
                GoodsUtils.DrawRewards(jsonData.rewards ,true)
                CS.Engine.UI.UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = jsonData.rewards } })
                data.status = Constants.GetStatus.Has
                KTool.SetActive(oneCell.BtnGo , true)
                KTool.SetActive(oneCell.BtnGet , false)
                CfUtils.FillText(oneCell.Text , localize("已领取"))
                CfUtils.FillText(self.TxtHold ,localize("持有:_num_" , { _num_ = GoodsUtils.GetThingNo(voteGoodsId)}) )
            end)
        end) 
        SetButtonAction(oneCell.BtnGo , function ()
            if data.status == Constants.GetStatus.Has then
                GameUtils.Toast(localize("已经领取奖励"))
                return
            end
            local goodsConfMgr = GoodsConfMgr:GetInstance()
            local row = goodsConfMgr:GetJumpModuleRow(data.openType)
            goodsConfMgr:ExecuteJump(row, {})
        end)
        CfUtils.FillText( oneCell.TitleText, string.format("(<size=30><color=#545454>%s</color></size>/%s) ", progress , targetNum) ) 
        CfUtils.SetSliderPercent(oneCell.Slider,progress / targetNum)
    end
    
end
function ActivityCatGirlPKGetTicketDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


return ActivityCatGirlPKGetTicketDialog
