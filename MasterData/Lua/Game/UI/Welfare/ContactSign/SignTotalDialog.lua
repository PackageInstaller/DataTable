local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local GameObject = CS.UnityEngine.GameObject
local cs_coroutine = require 'XLua.cs_coroutine'
local util = require "XLua.util"
local Yielders = CS.Engine.Lib.Yielders
---@type PlayerComponent
local PlayerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/DailyCheck/DailyCheck3.prefab > name: DailyCheck3
---@class SignTotalDialog
---@field Env                           	SignTotalDialog                         
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field UIFX_Progress                 	UnityEngine.RectTransform               	@ 0    
---@field Slider                        	UnityEngine.UI.Slider                   	@ 1    
---@field RewardNode                    	UnityEngine.RectTransform               	@ 2    
---@field Root                          	UnityEngine.RectTransform               	@ 3    
---@field ListView                      	UnityEngine.RectTransform               	@ 4    
---@field BtnRefresh                    	UnityEngine.RectTransform               	@ 5    
---@field ScrollView                    	SuperScrollView.LoopListView2           	@ 6    
---@field BtnRoleNameNode               	UnityEngine.RectTransform               	@ 7    
---@field BossDrawingNode               	Game.Native.Common.DrawingNode          	@ 8    
---@field BtnReceive                    	UnityEngine.RectTransform               	@ 9    
---@field DisplayNode                   	UnityEngine.RectTransform               	@ 10   
---@field ImgBg                         	UnityEngine.RectTransform               	@ 11   
---@field UIFX_GetGlow                  	UnityEngine.RectTransform               	@ 12   
---@field BtnCalender                   	UnityEngine.RectTransform               	@ 13   
---@field TotalTextNumber               	UnityEngine.RectTransform               	@ 14   
---@field Left                          	UnityEngine.RectTransform               	@ 15   
---@field DayCell1                      	Engine.Modules.LuaBehaviour             	@ 16   
---@field DayCell2                      	Engine.Modules.LuaBehaviour             	@ 17   
---@field DayCell3                      	Engine.Modules.LuaBehaviour             	@ 18   
---@field DayCell4                      	Engine.Modules.LuaBehaviour             	@ 19   
---@field DayCell5                      	Engine.Modules.LuaBehaviour             	@ 20   
---@field DayCell6                      	Engine.Modules.LuaBehaviour             	@ 21   
---@field DayCell7                      	Engine.Modules.LuaBehaviour             	@ 22   
---@field ImgSymbol                     	UnityEngine.RectTransform               	@ 23   
---@field TextDesc                      	UnityEngine.RectTransform               	@ 24   
---@field BtnReceiveImgBg               	UnityEngine.RectTransform               	@ 25   
---@field BtnRefreshTextDesc            	UnityEngine.RectTransform               	@ 26   
---@field Content                       	UnityEngine.RectTransform               	@ 27   
---@field RewardDisplay                 	UnityEngine.RectTransform               	@ 28   
local SignTotalDialog = Class('SignTotalDialog')

function SignTotalDialog:__init()
    self.totalDay = nil
    self.weekType = 1
    self.weekIndex = 1
    self.responseData = nil
    self.permanentProgressDetails = nil
    self.currentTime = self:GetCurrentTime()
    -- 当前天零点
    self.currentZeroTime = math.floor(self.currentTime / 86400) * 86400  
    self.unlockTime = nil
    self.originUnlockTime = nil
    self.RefreshEvent  =  Events.AddListener("SignTotalDialogRefreshEvent" , Bind(self, self.Refresh))
    self.co = nil
end
function SignTotalDialog:__delete()
    self.totalDay = nil
    self.currentTime = nil
    self.wday = nil
    self.weekType = nil 
    self.permanentProgressDetails = nil
    self.unlockTime = nil
    self.originUnlockTime = nil
    if self.RefreshEvent then
        Events.RemoveListener("SignTotalDialogRefreshEvent" , self.RefreshEvent)
        self.RefreshEvent = nil
    end
    if self.co then
        cs_coroutine.stop(self.co)
        self.co = nil
    end
end



function SignTotalDialog:Awake()

end


function SignTotalDialog:Refresh()
    GameUtils.Request(Interfaces.ContactSignInHome , {},function(request, response)
        if checkNumber(response.errCode) ~= 0 then return end
        self.responseData = response.data
          ---@type PlayerComponent
        local PlayerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
        local playerDojo = PlayerComponent:GetPlayerDojo()
        self.originUnlockTime = self.responseData.unlockTime
        self.responseData.unlockTime = self.responseData.unlockTime
        self.unlockTime = self.responseData.unlockTime
        -- 获取当前最新签到的index 
        self.weekIndex = self:GetWeekIndex()
        -- self.responseData.unlockTime = self.responseData.unlockTime - playerDojo:GetClientTimezone() + playerDojo:GetServerTimezone()
        self.responseData.continuousDay = checkInt(self.responseData.continuousDay) 
        if not KTool.IsActive(self.Root.gameObject) then
            KTool.SetActive(self.Root , true)    
        end
        self:InitData()
        -- self:CompleteWeekDayTime()
        self:InitUI()
        self:InitBtnClick()
    end)
end

function SignTotalDialog:GetWeekIndex()
    ---@type PlayerComponent
    local PlayerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
    local playerDojo = PlayerComponent:GetPlayerDojo()
    local currentTime = 1 
    local index = 1
    local weekDays = self:GetWeekData(1).signInData
    -- 时间戳服务端和客户端是相同的 
    for i = #weekDays ,1, -1 do
        local oneData = weekDays[i]
        if checkInt(oneData.status) ==1  or checkInt(oneData.status) == 2  then
            index = i 
            break
        end
    end 
    return index
end

function SignTotalDialog:InitUI()
    self:InitWeekCell()
    self:UpdateWeekBtn()
    self:UpdateWeekRewards()
    self:UpdateBtnRefreshBtn()
    self:RefreshList()
    self:UpdateCardUI()
    self:UpdateContactNumUI()
end
--- func 更新CardUI 的显示
function SignTotalDialog:UpdateCardUI()
    local cardId = self:GetCurrentShowCardId()
    self:FreshRoleNameNode(cardId)   
end


--- 初始化weekCell 
function SignTotalDialog:InitWeekCell()
    self:CompleteWeekDayTime()
    local weekDays = self:GetWeekData(self.weekType)
    local signInData = weekDays.signInData
    for i =1 , #signInData do
        ---@type Engine.Modules.LuaBehaviour
        local DayCell =  self["DayCell" .. i]
        KTool.SetActive(DayCell.gameObject , true)
        ---@type OneSignCell
        local ENV = DayCell.Env
        if isNull(DayCell.Env) then
            DayCell:Init()
            ENV = DayCell.Env
        end
        local dayData = signInData[i]
        ENV:RefeshUI(dayData.day , dayData.dayTime ,self.unlockTime , self.currentTime , self.weekType ,dayData.status , dayData.rewards , self)
    end
end

function SignTotalDialog:InitBtnClick()
    SetButtonAction(self.BtnRefresh , function ()
        if self.weekType == 1 then
            self.weekType = 2 
        else 
            self.weekType = 1
        end
        self:InitWeekCell()
        self:UpdateWeekBtn()
        self:UpdateBtnRefreshBtn()
        self:UpdateWeekRewards()
    end)
    
    SetButtonAction(self.BtnCalender , function ()
        UIModule.OpenDialog({ id = Constants.UITypeIds.SignCalendarDialog ,parameters = {
            originSignData = self:GetContactDays() ,
            unlockTime = self.originUnlockTime  , 
            currentTime = self.currentTime 
        } })
    end)
    SetButtonAction(self.BtnReceive , function()
        local status = self:IsDrawWeekRewardsByType(self.weekType)
        if status == 1 then
            GameUtils.Toast(localize("奖励已领取"))
            return
        end
        if status == -1 then
            GameUtils.Toast(localize("本周签到未完成"))
            return
        end
        GameUtils.Request(Interfaces.ContactSignWeeklyDraw , {type = self.weekType} , function(request, response)
            if checkNumber(response.errCode) ~= 0 then return end
            local jsonData = response.data
            local rewards = checkTable(jsonData.rewards)
            if #rewards > 0 then
                GoodsUtils.DrawRewards(rewards)
                UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = rewards } })
            end
            local weekData =  self:GetWeekData()
            weekData.status = 1
            self:UpdateWeekBtn()
            self:UpdateWeekRewards()
        end)    
    end)
end
function SignTotalDialog:UpdateWeekRewards()
    local rewards = self.weekType == 1 and self.responseData.weekSignRewards   or  self.responseData.lastWeekRewards 
    for i =1 , #rewards do
        local DisplayNode = self.RewardDisplay.transform:Find("DisplayNode_" .. i )
        if isNull(DisplayNode) then
            ---@type UnityEngine.GameObject
            DisplayNode =  GameObject.Instantiate(self.DisplayNode , self.RewardDisplay )
            DisplayNode.name = "DisplayNode_" .. i 
            KTool.SetActive(DisplayNode , true)
        end
        local goodsData = rewards[i]
        local goodPath = GoodsConfMgr:GetInstance():GetPhotoPathById(goodsData.goodsId)
        local ImgGoodsIcon = DisplayNode.transform:Find("ImgGoodsIcon")
        CfUtils.FillImage(ImgGoodsIcon ,goodPath)
        local TextNumber = DisplayNode.transform:Find("Number/TextNumber")

        CfUtils.FillText(TextNumber , "x" .. goodsData.num )
    end
    local isDraw = self:IsDrawWeekRewardsByType(self.weekType)
    if isDraw == 0 then
        CfUtils.PlayAnimation(self.Right  , "DailyCheck3_Reward") 
    else 
        CfUtils.StopAnimation(self.Right  , "DailyCheck3_Reward") 
        CfUtils.SetActive(self.UIFX_GetGlow.gameObject , false)
    end

end
--- func desc 更新btn 领取的状态
function SignTotalDialog:UpdateWeekBtn()
    local weekType = self.weekType 
    local weekData = self:GetWeekData(weekType)
    local isDraw = self:IsDrawWeekRewardsByType(weekType)
    if weekData.status ==  1 then
        CfUtils.FillText(self.TextDesc , localize("已领取")) 
        CfUtils.SetUISwitchImage(self.BtnReceiveImgBg , 2)
        return 
    end
    if isDraw ==  -1 then
        CfUtils.SetUISwitchImage(self.BtnReceiveImgBg ,2)
    else 
        CfUtils.SetUISwitchImage(self.BtnReceiveImgBg ,1)
        CfUtils.SetUISwitchImage(self.ImgBg , 1)
    end
    CfUtils.FillText(self.TextDesc , localize("领取周奖励"))
end
-- function SignTotalDialog:UpdateDrawSignRewardsUI(weekType, dayNum ,day)
--     local isDraw = self:IsDrawWeekRewardsByType(self.type)
--     self:UpdateSignDay({dayNum})
--     self:UpdateWeekDay(day , weekType)
--     local nextIsDraw = self:IsDrawWeekRewardsByType(self.type)
--     self.totalDay = self:GetSignTotal()
--     if nextIsDraw ~= isDraw then
--         self:UpdateWeekBtn()
--         self:UpdateWeekRewards()
--     end
--     self:UpdateContactNumUI()
--     self:RefreshList()
-- end
function SignTotalDialog:UpdateBtnRefreshBtn()
    local isHaveLastWeek = (self.currentZeroTime -  self.unlockTime ) > (self.weekIndex -1) * 86400
    if not isHaveLastWeek then
        KTool.SetActive(self.BtnRefresh.gameObject , false)
        return 
    end
    local text = self.weekType == 1 and   localize("切换上周") or localize("切换本周")
    CfUtils.FillText(self.BtnRefreshTextDesc , text)
end
--- func desc 获取周数据
---@param weekType integer @ 周类型 1 本周 2 上周
function SignTotalDialog:GetWeekData(weekType)
    if weekType == 1 then
        return self.responseData.weekSignData
    else 
        if isNull(self.responseData.lastWeekSignData) then
            return {}
        end
        return self.responseData.lastWeekSignData
    end
end

--- func desc 是否可以领取周奖励
---@param weekType any
function SignTotalDialog:IsDrawWeekRewardsByType(weekType)
    local weekData = self:GetWeekData(weekType)
    local signInData = weekData.signInData
    local isDraw = 0 
    if checkInt(weekData.status) == 1 then
        return 1
    end
    for k, v in pairs(signInData) do
        if checkInt(v.status) == Constants.GetStatus.Not then
            isDraw = -1 
            break 
        end
    end
    return isDraw 
end
--- func desc 补全周数据的dayTime 
function SignTotalDialog:CompleteWeekDayTime()
    local signInData = self.responseData.lastWeekSignData.signInData
    local distanceDay = 7 + self.weekIndex
    for i = 1 , 7 do 
        local dayTime =  self.currentZeroTime - (distanceDay - i ) * 86400
        signInData[i].dayTime =  dayTime
    end     
    local weekSignData = self.responseData.weekSignData.signInData
    for i = 1 , 7 do
        local dayTime = self.currentZeroTime - (self.weekIndex - i ) * 86400
        weekSignData[i].dayTime = dayTime
    end
end

function SignTotalDialog:InitData()
    self.totalDay = self.responseData.continuousDay
    -- self.unlockTime , _ = self:GetTimeAndWday(self.responseData.unlockTime)
    self:CompleteWeekDayTime()
    self:CompleteContactDays()
end
--- func desc 更新cardId 的显示
---@param cardId integer @ 卡牌id 
function SignTotalDialog:FreshRoleNameNode(cardId)
    local scr = CfUtils.GetLuaScr(self.BtnRoleNameNode, "Game.UI.Common.CommonBtnRoleNameNode")
    if scr then
        scr:RefreshSelf(cardId, nil, function(cardId)
            local GachaponUtils = import('Game.Gachapon.GachaponUtils')
            GachaponUtils.OpenDetail(cardId, { { id = Constants.UITypeIds.UIWelfareMainDialog } })
        end)
    end
    local vo = CardConfMgr:GetInstance():GetCardByRefId(cardId)
    self.BossDrawingNode:Execute(vo.defaultSkin)
end

--- func desc 获取当前要显示的卡
function SignTotalDialog:GetCurrentShowCardId()
    local contactRewards = self:GetPermanentProgressData()
    local index  = 1
    for k, v in pairs(contactRewards) do
       if  checkInt(v.hasDrawn)  == 0 then
            index = k 
            break
       end
    end
    local cardSameId = 0
    for i = index , #contactRewards do
        ---@type ContactSignInVo 
        local  goodsData  = contactRewards[i].rewards[1]
        local goodsType = GoodsUtils.GetIdType(goodsData.goodsId)
        if goodsType == Constants.IDType.GoodsSameCard then
            cardSameId =  goodsData.goodsId
            break
        end 
    end     
    if checkInt(cardSameId) == 0 then
        local contactRewards = self:GetPermanentProgressData()
        for i = index , 1, -1 do
            local oneContactRewards  = contactRewards[i]
            local goodsData = oneContactRewards.rewards[1]
            local goodsType = GoodsUtils.GetIdType(goodsData.goodsId)
            if goodsType == Constants.IDType.GoodsSameCard then
                cardSameId =  goodsData.goodsId
                break
            end 
        end
    end
    if cardSameId ~= 0  then
         ---@type GoodsSameCardVo
        local GoodsSameCardVo = CfUtils.GetCfVo(AutoIds.IdSetting710, "GoodsSameCardVo" , cardSameId)
        return GoodsSameCardVo.cardId
    else 
        return 120008
    end
end

function SignTotalDialog:GetMoveCellIndex()
    local contactRewards = self:GetPermanentProgressData()
    local index  = 0 
    for k, v in pairs(contactRewards) do
       if  checkInt(v.hasDrawn) == 0 then
            index = k 
            break
       end
    end
    return index
end

function SignTotalDialog:UpdateCellDataByDay(day)
    local day = checkInt(day)
    local contactRewards = self:GetPermanentProgressData()
    for k, v in pairs(contactRewards) do
       if  checkInt(v.day) == day then
            v.hasDrawn = 1
            break
       end
    end
end
function SignTotalDialog:GetCellDataIndexByDay(day)
    local day = checkInt(day)
    local contactRewards = self:GetPermanentProgressData()
    local index  = 0 
    for k, v in pairs(contactRewards) do
       if  checkInt(v.day) == day then
            index = k 
            break
       end
    end
    return index 
end
function SignTotalDialog:RefreshList()
    local taskCount = table.count(self.responseData.permanentProgressData)
    if not self.ScrollView.IsListViewInit then
        local listInitParam = CS.SuperScrollView.LoopListViewInitParam.CopyDefaultInitParam()
        local listItemData  = self.ScrollView:GetItemPrefabConfData("Cell")
        local itemSizeDelta = listItemData.mItemPrefab.transform.sizeDelta
        local listItemSize  = self.ScrollView.IsVertList and itemSizeDelta.y or itemSizeDelta.x
        listInitParam.mItemDefaultWithPaddingSize = listItemSize + listItemData.mPadding
        self.ScrollView:InitListView(taskCount, Bind(self, self.OnGetItemByIndex), listInitParam)
        self.ScrollView:OnItemSizeChanged()  
    else
        GameUtils.ReloadData(self.ScrollView, taskCount)
    end
    local preWidth = self.ScrollView.ContainerTrans.rect.width
    self.ScrollView.mOnDragingAction = function()
        local  currentWidth  = self.ScrollView.ContainerTrans.rect.width
        if currentWidth == preWidth then
            return
        end
        preWidth = currentWidth
        self:SetSliderPercentByWidth(currentWidth)
    end
    local index = self:GetMoveCellIndex()
    self.ScrollView:MovePanelToItemIndex(index - 1) 
    if self.co  then
       cs_coroutine.stop(self.co)
       self.co = nil
    end
    self.co = cs_coroutine.start(function ()
        while not self.ScrollView.IsListViewInitComplete do 
            cs_coroutine.yield_return(Yielders.EndOfFrame)
        end
        self:SetSliderPercentByWidth(self.ScrollView.ContainerTrans.rect.width)
    end)
end

function SignTotalDialog:SetSliderPercentByWidth(width)
    local totalDay = self:GetSignTotal()
    local cellWidth = 176
    local cellWidthAndDis = 189
    local count = 0 
    local permanentProgressData = self:GetPermanentProgressData()
    for i  = 1 , #permanentProgressData do
        local oneData = permanentProgressData[i]
        if i == 1 then
            if totalDay >= checkInt(oneData.day)  then
                count = count +  cellWidth/2 
            else 
                count = count +   totalDay/ oneData.day * cellWidth/2 
                break
            end      
        else 
            if totalDay >= checkInt(oneData.day)  then
                count = count +  cellWidthAndDis
            else 
                local lastData = permanentProgressData[i -1]
                count = count  + (totalDay - lastData.day ) * cellWidthAndDis/(oneData.day - lastData.day )
                break
            end
        end
    end
    self.Slider.value = count / self.ScrollView.ContainerTrans.rect.width
end
--endregion init

--region handler
---列表刷新
function SignTotalDialog:OnGetItemByIndex(listView, index)
    local luaIndex = index + 1
    local cell = listView:NewListViewItem("Cell")
    ---@type SignContactCell
    local nodeEnv = CfUtils.GetLuaScr(cell, "Game.UI.Welfare.ContactSign.SignContactCell")
    if nodeEnv then
        nodeEnv:RefreshUI(self.responseData.permanentProgressData[luaIndex] , self.totalDay , function (day)
            GameUtils.Request(Interfaces.ContactSignPermanentDraw , {day = day} , function(request, response)
                if checkNumber(response.errCode) ~= 0 then return end
                local jsonData = response.data
                GoodsUtils.DrawRewards(jsonData.rewards)
                if #jsonData.rewards > 0 then
                    UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = jsonData.rewards } })
                end
                self:UpdateCellDataByDay(day)
                local index = self:GetCellDataIndexByDay(day)
                self.ScrollView:RefreshItemByItemIndex(index - 1)
            end)            
        end)
    end
    return cell
end

function SignTotalDialog:UpdateContactNumUI()
    CfUtils.FillText(self.TotalTextNumber  , self:GetSignTotal()) 
end


---desc 获取当前零点时间戳 和当前的星期
function SignTotalDialog:GetCurrentTime()
    ---@type PlayerComponent
    local PlayerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
    local playerDojo = PlayerComponent:GetPlayerDojo()
    local serverTime =  PlayerComponent:GetPlayerDojo():GetServerTime() 
    return serverTime
end
--- func desc 返回解锁零点时间戳
---@param time integer @ 时间戳
function SignTotalDialog:GetTimeAndWday(time)
    local date = os.date("*t" , time)
    local time =  os.time({year = date.year, month = date.month, day = date.day, hour = 0 ,min = 0 ,sec = 0})
    local wday = 1
    if date.wday == 1 then
        wday = 7 
    else 
        wday = date.wday  - 1 
    end
    return time , wday
end

--- func desc 补全签到数据
function SignTotalDialog:CompleteContactDays()
    local count = math.ceil((self.currentTime - self.originUnlockTime)/86400)
    local contactDays = self:GetContactDays()
    for i =1 , count do
        if isNull(contactDays[i])  then
            contactDays[i] = 0
        end
    end
end
function SignTotalDialog:GetContactDays()
    self.permanentProgressDetails = {}
    if isNotNull(self.responseData.permanentProgressDetail) then
        local index = 0
        for i in string.gmatch(self.responseData.permanentProgressDetail, "%d") do
            index = index + 1
            self.permanentProgressDetails[index] = tonumber(i)
        end
    end
    return self.permanentProgressDetails
end
function SignTotalDialog:GetPermanentProgressData()
    return self.responseData.permanentProgressData
end

--- 获取签到的总天数
function SignTotalDialog:GetSignTotal()
    local contactDays = self:GetContactDays()
    local count = 0 
    for i =#contactDays -1 ,1, -1  do
        if contactDays[i] == 1 then
            count = count + 1
        else 
            break
        end
    end
    if contactDays[#contactDays] == 1 then
        count = count + 1
    end
    return count
end

function SignTotalDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end



return SignTotalDialog

