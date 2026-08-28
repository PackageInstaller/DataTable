---@type OverseaClubCatCarMgr
local Mgr = import("Game.UI.Club.CatCar.OverseaClubCatCarMgr"):GetInstance()
---@type OverseaClubCatCarUtils
local OverseaClubCatCarUtils = import("Game.UI.Club.CatCar.OverseaClubCatCarUtils")

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCatCarSpeedDialog.prefab > name: NormalRoad
---@class OverseaClubCatCarSpeedNormalPanel
---@field Env                           	OverseaClubCatCarSpeedNormalPanel       
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field BottomRoadBg                  	UnityEngine.RectTransform               	@ 0    
---@field BtnNowScore                   	UnityEngine.RectTransform               	@ 1    
---@field ImgScore                      	UnityEngine.RectTransform               	@ 2    
---@field GradeGroup                    	UnityEngine.RectTransform               	@ 3    
---@field ClubScore                     	UnityEngine.RectTransform               	@ 4    
---@field TxtClubPoints                 	UnityEngine.RectTransform               	@ 5    
---@field BtnStartDice                  	UnityEngine.RectTransform               	@ 6    
---@field ImgDiceIcon                   	UnityEngine.RectTransform               	@ 7    
---@field ImgDiceIconNone               	UnityEngine.RectTransform               	@ 8    
---@field RemainTimes                   	UnityEngine.RectTransform               	@ 9    
---@field TxtRemainNum                  	UnityEngine.RectTransform               	@ 10   
---@field BtnSubmit                     	UnityEngine.RectTransform               	@ 11   
---@field TxtPersonalPotints            	UnityEngine.RectTransform               	@ 12   
---@field ImgCar                        	UnityEngine.RectTransform               	@ 13   
---@field CarOnRoad                     	UnityEngine.RectTransform               	@ 14   
---@field NowRaceRewardTips             	UnityEngine.RectTransform               	@ 15   
---@field ImgGoodsIcon                  	UnityEngine.RectTransform               	@ 16   
---@field ClubRewardTips                	UnityEngine.RectTransform               	@ 17   
---@field BossTimeRemind                	UnityEngine.RectTransform               	@ 18   
---@field TextDesc1                     	UnityEngine.RectTransform               	@ 19   
---@field TextDesc2                     	UnityEngine.RectTransform               	@ 20   
---@field TextTime                      	UnityEngine.RectTransform               	@ 21   
---@field TextDesc4                     	UnityEngine.RectTransform               	@ 22   
local OverseaClubCatCarSpeedNormalPanel = Class("OverseaClubCatCarSpeedNormalPanel")

---@class OverseaClubCatCarSpeedNormalPanel.InputData

function OverseaClubCatCarSpeedNormalPanel:__init()
    self.controller = nil
    self.events = {}
    self.events[ClubUtils.EventName.Dice_Submit] = Events.AddListener(ClubUtils.EventName.Dice_Submit,Bind(self,self.OnSubmitPoints))
    self.events[ClubUtils.EventName.Dice_Call] = Events.AddListener(ClubUtils.EventName.Dice_Call,Bind(self,self.OnDiceCall))
    self.events[ClubUtils.EventName.Loading_End] = Events.AddListener(ClubUtils.EventName.Loading_End,function()
        if self.controller.gameObject.activeSelf == true then
            CfUtils.SetActive(self.BossTimeRemind,true)    
        end
    end)
end

function OverseaClubCatCarSpeedNormalPanel:__delete()
    self.controller = nil
    for i, v in pairs(self.events) do
        Events.RemoveListener(i,v)
    end
end

function OverseaClubCatCarSpeedNormalPanel:Awake()
    SetButtonAction(self.BtnNowScore,Bind(self,self.OnNowScoreClick))
    SetButtonAction(self.BtnStartDice,Bind(self,self.OnStartDiceClick))
    
    CfUtils.SetActive(self.ClubRewardTips,false)
    
    --CoStart(function()
    --    CoYield(0.75)
    --    self:InitCars()
    --    for i, v in pairs(self.cacheCars) do
    --        ---@type OverseaClubCatCarNode
    --        local lua = CfUtils.GetLuaScr(v,"Game.UI.Club.CatCar.Speed.OverseaClubCatCarNode")
    --        lua:SetIdle()
    --    end
    --end)

    self:InitCarsView()
end

---@param inData OverseaClubCatCarSpeedNormalPanel.InputData
function OverseaClubCatCarSpeedNormalPanel:RefreshData(inData)
    self.inData = inData
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function OverseaClubCatCarSpeedNormalPanel:RefreshUI()
    self:RefreshGradeView()
    self:RefreshDice()
    self:RefreshBossTimeRemain()
    
    --Test
    --CoStart(function()
    --    Mgr.Server.dojo.catCarInfo.clubCatCarPoint = 0
    --    while true and isNotNull(self.GradeGroup) do
    --        Mgr.Server.dojo.catCarInfo.clubCatCarPoint = checkNumber(Mgr.Server.dojo.catCarInfo.clubCatCarPoint) + 10
    --        self:RefreshGradeView()
    --        self:RefreshDice()
    --        CoYield(0.1)
    --    end
    --end)
    
end

function OverseaClubCatCarSpeedNormalPanel:RefreshGradeView()
    ---@type OverseaClubCatCarDojo.CatCarInfo
    local carOnRoadData = Mgr.Server.dojo.catCarInfo
    local curPoints = checkNumber(Mgr.Server.dojo.clubScore)
    for i = 1,5 do
        local node = self.GradeGroup:Find("OverseaClubCatCarGradeNode"..i)
        ---@type ClubCatCarSpeedGradeVo
        local vo = CfUtils.GetCfVo(AutoIds.IdSetting6281,"ClubCatCarSpeedGradeVo",i)
        if node and vo then
            ---@type OverseaClubCatCarGradeNode
            local lua = CfUtils.GetLuaScr(node,"Game.UI.Club.CatCar.Speed.OverseaClubCatCarGradeNode")
            local nodeData = {
                desc = localize("_num_辆到达",{_num_ = carOnRoadData.catCarArriveNum[tostring(i)] or 0}),
                grade = i,
                isDrawed = table.isContain(carOnRoadData.drawCarTrackIds,tostring(i)),
                curPoints = curPoints,
                carGo = self.ImgCar,
                tipsBoard = self.ClubRewardTips
            }
            lua:RefreshData(nodeData)
        end
    end
    ---@type ClubCatCarSpeedGradeVo
    local curVo = OverseaClubCatCarUtils:GetCurSpeedGradeVo(curPoints)
    --CfUtils.FillImage(self.ImgScore,OverseaClubCatCarUtils:GetGradeImgName(curVo.grade))
    CfUtils.SetUISwitchImage(self.ImgScore, curVo.grade)
    --CfUtils.FillImage(self.ImgGoodsIcon,GoodsConfMgr:GetInstance():GetPhotoPathById(curVo.showProgressRewards))
    local showGoodId = self:GetCurPrizePoolFirstItemId()
    CfUtils.FillImage(self.ImgGoodsIcon,GoodsConfMgr:GetInstance():GetPhotoPathById(showGoodId))
    
    local nextVo = OverseaClubCatCarUtils:GetNextSpeedGradeVo(curPoints)
    local nextGrade = nextVo and nextVo.grade or curVo.grade
    local nextNode = self.GradeGroup:Find("OverseaClubCatCarGradeNode"..nextGrade)
    if nextNode then
        local pos = nextNode:Find("Normal/NowGrade").position
        local pos2 = self.ClubScore.position
        self.ClubScore.position = Vector3(pos.x,pos2.y,pos2.z)
    end
    if nextVo then
        CfUtils.FillText(self.TxtClubPoints,string.format("<#FF16A9>%d</color>/%d",curPoints,nextVo.mileage))
    else
        CfUtils.FillText(self.TxtClubPoints,string.format("<#FF16A9>%d</color>",curPoints))
    end
end

function OverseaClubCatCarSpeedNormalPanel:RefreshDice()
    local carOnReadData = Mgr.Server.dojo.catCarInfo
    CfUtils.FillText(self.TxtPersonalPotints,Mgr.Server.dojo.playerScore)
    local totalCount = checkNumber(ClubUtils.GetParamValue(ClubUtils.ParamsId.Dice_Submit_Count))
    local playerDiceLeftTime = totalCount - checkNumber(carOnReadData.submitDiceTimes)
    if playerDiceLeftTime <=0 then
        CfUtils.SetActive(self.ImgDiceIconNone,true)
        CfUtils.SetActive(self.RemainTimes,false)
        return 
    end
    
    if checkNumber(carOnReadData.playerDiceTimesLeft)  > 0 then
        CfUtils.SetActive(self.ImgDiceIconNone,false)
        CfUtils.SetActive(self.RemainTimes,true)
        --已经投掷但没提交,显示上少一次
        if carOnReadData.playerDiceNumber ~= nil and table.count(carOnReadData.playerDiceNumber) ~= 0 then
            playerDiceLeftTime = playerDiceLeftTime - 1
        end
        CfUtils.FillText(self.TxtRemainNum,string.format("%d/%d",playerDiceLeftTime,totalCount))
    else
        CfUtils.SetActive(self.ImgDiceIconNone,true)
        CfUtils.SetActive(self.RemainTimes,false)
    end
end

function OverseaClubCatCarSpeedNormalPanel:RefreshBossTimeRemain()
    local dayIndex = OverseaClubCatCarUtils:GetTodayIndex()
    local row = CfUtils.GetCfLine(AutoIds.IdSetting6286,dayIndex)
    if row then
        CfUtils.FillText(self.TextDesc1,CfUtils.GetCfDataByLine(row,"text1",Constants.DataType.LocalString))
        CfUtils.FillText(self.TextDesc2,CfUtils.GetCfDataByLine(row,"text2",Constants.DataType.LocalString))
        CfUtils.FillText(self.TextDesc4,CfUtils.GetCfDataByLine(row,"text3",Constants.DataType.LocalString))
    end
    CfUtils.SetActive(self.TextTime,false)
end

function OverseaClubCatCarSpeedNormalPanel:InitCarsView()
    self:InitCars()
    local dojo = Mgr.Server.dojo
    ---@type OverseaClubCatCarDojo.RankInfo
    local rankInfo1 = dojo.catCarInfo.selfRankInfo
    if rankInfo1 == nil then
        rankInfo1 = {}
        rankInfo1.clubName = ClubUtils.GetClubComp():GetHomeDojo().name
        rankInfo1.ranking = 0
        rankInfo1.score = 0
        rankInfo1.playerInfo = {}
    end
    ---@type OverseaClubCatCarNode
    local lua1 = CfUtils.GetLuaScr(self.car1,"Game.UI.Club.CatCar.Speed.OverseaClubCatCarNode")
    lua1:RefreshData({playerClubScore = dojo.clubScore,clubCatCatInfo = rankInfo1, movePerformance = true})

    if dojo.catCarInfo.otherRankInfo[1] then
        self:SetCar(dojo.catCarInfo.otherRankInfo[1],self.car2)
    else
        CfUtils.SetActive(self.car2,false)
    end

    if dojo.catCarInfo.otherRankInfo[2] then
        self:SetCar(dojo.catCarInfo.otherRankInfo[2],self.car3)
    else
        CfUtils.SetActive(self.car3,false)
    end
    self.cacheRankInfo = dojo.catCarInfo.otherRankInfo or {}
end

function OverseaClubCatCarSpeedNormalPanel:PerformOverTake(overtake)
    local dojo = Mgr.Server.dojo
    --刷新赛道1
    ---@type OverseaClubCatCarDojo.RankInfo
    local rankInfo1 = dojo.catCarInfo.selfRankInfo
    if rankInfo1 == nil then
        rankInfo1 = {}
        rankInfo1.clubName = ClubUtils.GetClubComp():GetHomeDojo().name
        rankInfo1.ranking = 0
        rankInfo1.score = 0
        rankInfo1.playerInfo = {}
    end
    ---@type OverseaClubCatCarNode
    local lua1 = CfUtils.GetLuaScr(self.car1,"Game.UI.Club.CatCar.Speed.OverseaClubCatCarNode")
    lua1:RefreshData({playerClubScore = dojo.clubScore,clubCatCatInfo = rankInfo1, movePerformance = true})

    if overtake then
        if table.count(self.cacheRankInfo) == 2 then
            self.carOrder = not self.carOrder    
        end
        if table.count(dojo.catCarInfo.otherRankInfo) > 1 then
            if self.carOrder then
                table.sort(dojo.catCarInfo.otherRankInfo,function(a,b)
                    return a.score < b.score
                end)
            else
                table.sort(dojo.catCarInfo.otherRankInfo,function(a,b)
                    return a.score > b.score
                end)
            end
        end
    end
    
    self:PerformOverTake__(self.car2, self.car2B, self.cacheRankInfo[1],dojo.catCarInfo.otherRankInfo[1])
    self:PerformOverTake__(self.car3, self.car3B, self.cacheRankInfo[2],dojo.catCarInfo.otherRankInfo[2])
    self.cacheRankInfo = dojo.catCarInfo.otherRankInfo
end

---@param rankInfo OverseaClubCatCarDojo.RankInfo
---@param rankInfoNew OverseaClubCatCarDojo.RankInfo
function OverseaClubCatCarSpeedNormalPanel:PerformOverTake__(car, carB, rankInfo, rankInfoNew)
    if rankInfo then
        if rankInfoNew then
            if rankInfo.clubName == rankInfoNew.clubName then
                self:SetCar(rankInfoNew,car,false,false)
            else
                self:SetCar(rankInfoNew,car,true,false)
                carB.position = car.position
                self:SetCar(rankInfo,carB,false,true)
            end
        else
            self:SetCar(rankInfo,car,false,true)
        end
    else
        if rankInfoNew then
            self:SetCar(rankInfoNew,car,true,false)
        end
    end
end

function OverseaClubCatCarSpeedNormalPanel:SetCar(rankInfo,car,enter,exit)
    ---@type OverseaClubCatCarNode
    local lua = CfUtils.GetLuaScr(car,"Game.UI.Club.CatCar.Speed.OverseaClubCatCarNode")
    lua:RefreshData({playerClubScore = Mgr.Server.dojo.clubScore,clubCatCatInfo = rankInfo, movePerformance = true, enter = enter, exit = exit})
end

function OverseaClubCatCarSpeedNormalPanel:OnSubmitPoints(isOvertake)
    self:PerformOverTake(isOvertake)
    self:RefreshUI()
end

function OverseaClubCatCarSpeedNormalPanel:OnDiceCall()
    self:RefreshDice()
end

function OverseaClubCatCarSpeedNormalPanel:InitCars()
    if self.carInited then
        return
    end
    self.carInited = true
    self.car1 = self.CarOnRoad:Find("OverseaClubCatCarOnRoadNode1")
    self.car2 = self.CarOnRoad:Find("OverseaClubCatCarOnRoadNode2")
    self.car3 = self.CarOnRoad:Find("OverseaClubCatCarOnRoadNode3")
    self.car2B = self.CarOnRoad:Find("OverseaClubCatCarOnRoadNode2B")
    self.car3B = self.CarOnRoad:Find("OverseaClubCatCarOnRoadNode3B")
    self.cacheCars = {self.car2,self.car1,self.car3}
    
    self.carOrder = true -- true 二赛道在前
end

function OverseaClubCatCarSpeedNormalPanel:OnNowScoreClick()
    --CfUtils.DialogOpen(Constants.UITypeIds.ActivityGachaponSkinDialog)
    CfUtils.DialogOpen(Constants.UITypeIds.OverseaClubCatCarTrackRewardPopup,{grade = Mgr.Server.dojo.clubCatCarLevel })
end

function OverseaClubCatCarSpeedNormalPanel:OnStartDiceClick()
    local carOnReadData = Mgr.Server.dojo.catCarInfo
    local totalCount = checkNumber(ClubUtils.GetParamValue(ClubUtils.ParamsId.Dice_Submit_Count))
    local playerDiceLeftTime = totalCount - checkNumber(carOnReadData.submitDiceTimes)
    if playerDiceLeftTime <=0 then
        return
    end
    CfUtils.SetActive(self.BtnStartDice,false)
    CfUtils.DialogOpen(Constants.UITypeIds.OverseaClubCatCarRollDiceDialog,{closeCallback = function() 
        CfUtils.SetActive(self.BtnStartDice,true)
    end})
end

function OverseaClubCatCarSpeedNormalPanel:GetCurPrizePoolFirstItemId()
    local result
    ---@type ClubCatCarSpeedGradeVo
    local speedVo = CfUtils.GetCfVo(AutoIds.IdSetting6281,"ClubCatCarSpeedGradeVo",Mgr.Server.dojo.clubCatCarLevel)
    local firstRewardsGroup = CfUtils.GetCfData(AutoIds.IdSetting6282,speedVo.Jackpot,"firstRewardsGroup",Constants.DataType.String)
    local poolRewardsIds = CfUtils.GetIdGroupData(AutoIds.IdSetting6283,firstRewardsGroup)
    if poolRewardsIds and #poolRewardsIds > 0 then
        result = CfUtils.GetCfData(AutoIds.IdSetting6283,poolRewardsIds[1],"roleId",Constants.DataType.Int)
    end
    return result
end

function OverseaClubCatCarSpeedNormalPanel:OnDestroy()
    self:Delete()
end
return OverseaClubCatCarSpeedNormalPanel