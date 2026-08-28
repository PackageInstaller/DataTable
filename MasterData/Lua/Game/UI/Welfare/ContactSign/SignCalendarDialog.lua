local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local date = require('Frame.date')
---@type PlayerComponent
local PlayerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/DailyCheck/DailyCheckCalendarDialog.prefab > name: DailyCheckCalendarDialog
---@class SignCalendarDialog
---@field Env                           	SignCalendarDialog                      
---@field controller                    	Engine.UI.UILuaDialog                   
---@field NotSignInTxt                  	UnityEngine.RectTransform               	@ 0    
---@field SelectTextNumber              	UnityEngine.RectTransform               	@ 1    
---@field ImgGoodsIcon                  	UnityEngine.RectTransform               	@ 2    
---@field ConsumeTxt                    	UnityEngine.RectTransform               	@ 3    
---@field TextYear                      	UnityEngine.RectTransform               	@ 4    
---@field TextMonth                     	UnityEngine.RectTransform               	@ 5    
---@field BtnMinus                      	UnityEngine.RectTransform               	@ 6    
---@field BtnPlus                       	UnityEngine.RectTransform               	@ 7    
---@field ScrollView                    	SuperScrollView.LoopGridView            	@ 8    
---@field BtnSignup                     	UnityEngine.RectTransform               	@ 9    
---@field ContactSignInParamterVo                   ContactSignInParamterVo
local SignCalendarDialog = Class('SignCalendarDialog')
function SignCalendarDialog:__init()
    self.calendarMap = {}
    self.selectDayMap = {}
    self.originSignData = {}
    self.zeroUnlockTime = nil
    self.zeroUnlockDayId = nil
    self.ContactSignInParamterVo = CfUtils.GetCfVo(AutoIds.IdSetting6306,"ContactSignInParamterVo" , "1")
    self.signMapData = {
    }
    self.noSignMapData = {
    }
    self.selectMonthData = {}
    self.totalDay = nil
    self.minDataMonthID = nil
    self.lastDataMonthID = nil
    self.currentMonthID = nil
    self.nowDayId = nil
    self.serverTime = nil
    self.isNeedRefresh = false
end


function SignCalendarDialog:__delete()
    self.calendarMap = nil
    self.selectDayMap = nil
    self.originSignData = nil
    self.zeroUnlockTime = nil
    self.zeroUnlockDayId = nil
    self.ContactSignInParamterVo = nil
    self.signMapData = nil
    self.selectMonthData = nil
    self.totalDay = nil
    self.minDataMonthID = nil
    self.lastDataMonthID = nil
    self.currentMonthID = nil
    self.nowDayId = nil
    self.serverTime = nil
end


function SignCalendarDialog:Awake()
  
end

function SignCalendarDialog:GetZeroUnlockTime()
    if isNull(self.zeroUnlockTime) then
        local unlockData =  os.date("*t" , self:GetUnLockTime())
        local zeroUnlcokTime =  os.time({day = unlockData.day , month = unlockData.month , year = unlockData.year ,hour=0, minute=0, second=0}) 
        self.zeroUnlockTime = zeroUnlcokTime
        self.zeroUnlockDayId =  string.format("%d-%02d-%02d",unlockData.year  ,  unlockData.month  ,unlockData.day  ) 
    end
    return self.zeroUnlockTime
end

function SignCalendarDialog:InitBindClick()
    SetButtonAction(self.BtnMinus , function()
        local monthID = self:GetSwithMonth(-1 , self.currentMonthID)
        self:RefreshMomnth(monthID)        
        self:FreshUI()
    end)
    SetButtonAction(self.BtnPlus , function()
        local monthID = self:GetSwithMonth(1,self.currentMonthID)
        self:RefreshMomnth(monthID)
        self:FreshUI()
    end)
    SetButtonAction(self.BtnSignup , function ()
        self:ContactSignIn()
    end)
    SetButtonAction(self.BtnClose , function ()
        UIModule.CloseDialog(self.controller)
    end)
end

function SignCalendarDialog:ChangeOriginData(dates)
    table.sort(dates , function (a, b )
        return a < b 
    end)
    local maxDay = dates[#dates]
    local index = 1
    for i = 1 , maxDay do 
        if IsNull(self.originSignData[i])  then
            self.originSignData[i] = 0
        end
        if dates[index] == i then
            self.originSignData[i] = 1 
            index = index + 1
        end
    end     
end

function SignCalendarDialog:ContactSignIn()
    if  table.count(self.selectDayMap) == 0 then
        GameUtils.Toast(localize("请选择补签日期"))
        return
    end
    local selectCount = table.count(self.selectDayMap)
    local ownerNum = GoodsUtils.GetThingNo(self.ContactSignInParamterVo.expend)
    local consumNum = self.ContactSignInParamterVo.num * selectCount
    if consumNum > ownerNum  then
        GameUtils.Toast(localize("道具不足"))
        return
    end
    local dates = {}
    local dates = table.keys(self.selectDayMap)
    for i =1 , #dates do
        local date = dates[i] 
        dates[i] = self.noSignMapData[date] 
    end
    GameUtils.Request(Interfaces.ContactReplenishmentSignIn ,{days = table.concat(dates,",")} , function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        self.isNeedRefresh = true
        local jsonData = response.data
        if isNotNull(jsonData.rewards) and table.count(jsonData.rewards) > 0 then
            UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = jsonData.rewards } })
        end
        local rewards = isNotNull(jsonData.rewards) and clone(jsonData.rewards)  or {}
        rewards[#rewards+1] = {
            goodsId = self.ContactSignInParamterVo.expend , 
            num = - consumNum
        }
        GoodsUtils.DrawRewards(rewards)
        self:ChangeOriginData(dates)
        table.merge(self.signMapData , self.selectDayMap)
        -- TODO 扣除道具
        self.selectDayMap = {}
        self:RefreshMomnth(self.currentMonthID)
        self:FreshUI()
    end)
end     

function SignCalendarDialog:RefreshMomnth(monthID)
    self.currentMonthID = monthID
    self:RefreshList()    
    local nextMonthID = self:GetSwithMonth(1 , monthID)
    local isNormal = self:IsNormal(nextMonthID)
    KTool.SetActive(self.BtnPlus , isNormal)
    local lastMonthID = self:GetSwithMonth(-1 , monthID)
    isNormal = self:IsNormal(lastMonthID)
    KTool.SetActive(self.BtnMinus , isNormal)
end     

function SignCalendarDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        self.originSignData = initParams.originSignData
        self.unlockTime = initParams.unlockTime
        self.currentTime = initParams.currentTime
        self.minDataMonthID = self:GetMonthID(self:GetUnLockTime())
        self.currentMonthID = self:GetMonthID(self:GetServerCurrentTime())
        self.nowDayId = os.date("%Y-%m-%d" , self:GetServerCurrentTime())
        self:GetZeroUnlockTime()
        self.maxMonthID  = self.currentMonthID 
        local goodPath = GoodsConfMgr:GetInstance():GetPhotoPathById(self.ContactSignInParamterVo.expend)
        CfUtils.FillImage(self.ImgGoodsIcon , goodPath )
        self:InsertSignMapData()
        self:InitBindClick()
        self:RefreshMomnth(self.currentMonthID)
        self:FreshUI()
        printInfo('--enter this')
    end)
end



function SignCalendarDialog:FreshUI()
    if isNull(self.totalDay) then
        self.totalDay  = math.ceil((self:GetServerCurrentTime() - self:GetUnLockTime())/86400) 
    end
    CfUtils.FillText(self.NotSignInTxt , self.totalDay - table.count(self.signMapData))
    local selectCount = table.count(self.selectDayMap)
    CfUtils.FillText(self.SelectTextNumber ,selectCount)
    local dates =  string.split(self.currentMonthID ,"-")
    CfUtils.FillText(self.TextYear , dates[1])
    CfUtils.FillText(self.TextMonth , dates[2])
    CfUtils.FillText(self.ConsumeTxt ,selectCount * self.ContactSignInParamterVo.num)
end

function SignCalendarDialog:InsertSignMapData()
    local date = os.date("*t",self.unlockTime)
    local date2 = {
        year = checkInt(date.year) ,
        month = checkInt(date.month) ,
        day = checkInt(date.day) 
    }
    for i = 1 , #self.originSignData do
        if self.originSignData[i] == 1 then
            self.signMapData[string.format("%s-%02d-%02d",date2.year ,date2.month ,date2.day)] = i
        else 
            self.noSignMapData[string.format("%s-%02d-%02d",date2.year ,date2.month ,date2.day)] = i 
        end
        if date2.day >= 28 and date2.month == 2 then
            local isRui = false
            if date2.year % 4 == 0 then
                if not (date2.year % 100 == 0 and  date2.year % 400 == 0) then
                else 
                    isRui = true
                end   
            end
            if isRui then
                if date2.day == 29 then
                    date2.day = 0
                    date2.month = date2.month +1
                end
            else 
                date2.month = date2.month + 1    
                date2.day = 0
            end
        elseif  date2.month == 1 or 
        date2.month == 3 or 
        date2.month == 5 or 
        date2.month == 7 or
        date2.month == 8 or 
        date2.month == 10 or 
        date2.month == 12 then
            if date2.day == 31 then
                if date2.month == 12 then
                    date2.month = 1
                    date2.year =  date2.year +1
                    date2.day = 0
                else 
                    date2.month = date2.month + 1  
                    date2.day =  0
                end
                
            end
        else
            if date2.day == 30  then
                date2.month = date2.month + 1
                date2.day = 0
            end 
        end 
        date2.day = date2.day + 1
    end
end
function SignCalendarDialog:GetUnLockTime()
    return self.unlockTime
end

function SignCalendarDialog:IsNormal(monthID)
    if monthID >= self.minDataMonthID and monthID <= self.maxMonthID then
        return true
    end
    return false 
end

function SignCalendarDialog:GetServerCurrentTime()
    local playerDojo = PlayerComponent:GetPlayerDojo()
    return playerDojo:GetServerTime()
end

function SignCalendarDialog:GetSwithMonth(addReduce ,str)
    local dates =  string.split(str , "-")
    if addReduce > 0 then
        if checkInt(dates[2]) == 12 then
            dates[2] = 1
            dates[1] = dates[1] +1
        else 
            dates[2] = dates[2] + 1
        end 
    else 
        if checkInt(dates[2]) == 1 then
            dates[2] = 12
            dates[1] = dates[1] -1
        else 
            dates[2] = dates[2] - 1
        end 
    end
    local monthID = string.format("%s-%02d", dates[1] ,dates[2])
    return monthID
end



function SignCalendarDialog:RefreshList()
    local monthData = self:GetMonthData(self.currentMonthID)
    self.selectMonthData = monthData
    if not self.ScrollView.IsListViewInit then
        self.ScrollView:InitGridView(#monthData, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(self.ScrollView, #monthData)
    end
end

function SignCalendarDialog:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cellNode = listView:NewListViewItem("Cell")
    ---@type SignCalendarCell
    local nodeEnv  = CfUtils.GetLuaScr(cellNode, "Game.UI.Welfare.ContactSign.SignCalendarCell")
    if nodeEnv then
        local dayStr = self.selectMonthData[index+1]
        local isUnlock = dayStr < self.nowDayId and dayStr >= self.zeroUnlockDayId
        nodeEnv:RefreshUI(dayStr , self.signMapData[dayStr] ~= nil , self.selectDayMap[dayStr] ~=nil , isUnlock , dayStr >= self.zeroUnlockDayId)
        nodeEnv:SetCallBack(function (dayStr , isSelect)
            if isSelect then
                self.selectDayMap[dayStr] = true
            else 
                self.selectDayMap[dayStr] = nil
            end
            self:FreshUI()
        end)
    end
    return cellNode
end

--- 获取按钮获取月份ID
function SignCalendarDialog:GetMonthID(time)
    local date = os.date("*t" , time)
    local month = date.month
    local year = date.year
    local ymID= string.format("%s-%02d", year ,month)
    return ymID
end

function SignCalendarDialog:GetMonthData(str)
    if self.calendarMap[str] then
        return self.calendarMap[str]
    end
    local dates =  string.split(str , "-")
    local time = os.time({day = 1 , month = checkInt(dates[2] ), year = checkInt(dates[1]) ,hour=0, minute=0, second=0})
    return self:GetMontherCalender(time)
end
--- 获取按钮日历数据
function SignCalendarDialog:GetMontherCalender(time)
    local ymID = self:GetMonthID(time)
    if isNotNull(self.calendarMap[ymID]) then
        return self.calendarMap[ymID]
    end
    local date = os.date("*t" , time)
    local month = date.month
    local year = date.year
    local day = 1
    local nextMonth = month
    local nextYear = year
    if month == 12 then
        nextMonth = 1
        nextYear =  year + 1 
    else 
        nextMonth = month + 1
        nextYear =  year
    end
    local oneTime =  os.time({day = 1 , month = month , year = year ,hour=0, minute=0, second=0})
    local twoTime =  os.time({day = 1 , month = nextMonth , year = nextYear ,hour=0, minute=0, second=0})
    local monthDay = checkInt((twoTime - oneTime)/86400) 
    local oneDate = os.date("*t" ,oneTime)
    local wday = oneDate.wday  - 1 
    local data = {
        "0","0","0","0","0","0","0",
        "0","0","0","0","0","0","0",
        "0","0","0","0","0","0","0",
        "0","0","0","0","0","0","0",
        "0","0","0","0","0","0","0",
        "0","0","0","0","0","0","0"
    }
    self.calendarMap[ymID] = data
    for i = 1, monthDay do  
        data[i+wday] = string.format("%s-%02d" , ymID , i)
    end
    return data
end


function SignCalendarDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        if self.isNeedRefresh then
            Events.Broadcast("SignTotalDialogRefreshEvent" , {})
        end
        self:Delete()
    end)
end


return SignCalendarDialog
