---
--- Created by thl
---
local KTool = CS.Engine.Lib.KTool
local CoWait = CS.Engine.Lib.CoWait
local UIModule = CS.Engine.UI.UIModule
local RectTransform = CS.UnityEngine.RectTransform
local util = require "XLua.util"
local DailyQuestComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.DailyQuestComponent)
local KCookie = CS.Engine.Lib.KCookie
local TypeKCookie = "DailySelectType"
local DailyQuestCellPath = "Game.UI.FightReady.UIFightDaily.UIFightMapDailyTypeCell"

---@class UIFightMap
---@field Root                          	UnityEngine.RectTransform               
---@field LevelRoot                     	UnityEngine.RectTransform               
---@field ButtonNode                    	UnityEngine.RectTransform               
---@field ToggleGroup                   	UnityEngine.RectTransform               
---@field Content                       	UnityEngine.RectTransform               
---@field EngryPoint                    	UnityEngine.RectTransform               
---@field RewardBoxImage                	UnityEngine.RectTransform               
---@field Name                          	UnityEngine.RectTransform               
---@field DailyRewardBox                	UnityEngine.RectTransform               
---@field DailyLevelNode                	UnityEngine.RectTransform               
local UIFightMap = Class("UIFightMap")

--- lua 初始化
function UIFightMap:__init()
    self._allData = {}
    self._curDojo = nil                    --当前选择的类型
    self._curChallengeQuestId = nil        --当前应该挑战的关卡id
end

function UIFightMap:__delete()
    self._allData = {}
    self._curDojo = nil
    self._curChallengeQuestId = nil        --当前应该挑战的关卡id
end

function UIFightMap:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        CfUtils.PlayAnimator(self.Root, "Go")
    end))
    return coWait
end
function UIFightMap:Awake()
    self.EventEnergyBoxPointChange = Events.AddListener(Constants.EventNames.EnergyBoxPointChange, Bind(self, self.OnEnergyBoxPointChange))
    self.EventEVENT_GUIDE_CUSTOM_UI_BEHAVIOR = Events.AddListener(Constants.EventNames.EVENT_GUIDE_CUSTOM_UI_BEHAVIOR, Bind(self, self.OnEVENT_GUIDE_CUSTOM_UI_BEHAVIOR))
    self.EventDailyQuestUpRefresh = Events.AddListener(Constants.EventNames.DailyQuestUpRefresh, Bind(self, self.OnDailyQuestUpRefresh))

    local copyType = 0
    local argument = self.controller.Argument.parameters
    if argument then
        copyType = checkNumber(argument.copyType)  --副本类型
    end

    if copyType == 0 then
        copyType = KCookie.Get(TypeKCookie)
    end
    self._curDojo = DailyQuestComponent:GetDailyQuestDojoByType(copyType)

    self:InitData()
    --默认选第一个
    if not self._curDojo then
        self._curDojo = self._allData[1]
    end 
    self:FillTypes()

    self:RefreshLevels()
    self:FillEnergyBox()
end

--初始化数据
function UIFightMap:InitData()
    self._allData = {}
    local t = DailyQuestComponent:GetDailyQuestsData()
    if not t then
        return
    end
    
    for k, v in pairs(t) do
        table.insert(self._allData, v)
    end

    table.sort(self._allData, function(a, b)
        local fVo = QuestConfMgr:GetInstance():GetDailyQuestTypeVoByType(a.type)
        local tVo = QuestConfMgr:GetInstance():GetDailyQuestTypeVoByType(b.type)
        if fVo and tVo then
            return checkNumber(fVo.sequence) < checkNumber(tVo.sequence)
        end
        return false
    end)
end

function UIFightMap:FillTypes()
    if not self._allData then
        return
    end

    for k, v in pairs(self._allData) do
        local go = CfUtils.InstantiateGo(self.ButtonNode, self.ToggleGroup)
        if go then
            go.name = "cell"..v.type
            local scr = CfUtils.GetLuaScr(go, DailyQuestCellPath)
            if scr then
                scr:FreshNode(v, function()
                    if checkNumber(self._curDojo.type) == checkNumber(v.type) then
                        return
                    end

                    local lastGo 
                    if self._curDojo then
                        lastGo = self.ToggleGroup.transform:Find("cell"..self._curDojo.type)
                    end
                    if lastGo then
                        local lastScr = CfUtils.GetLuaScr(lastGo, DailyQuestCellPath)
                        if lastScr then
                            lastScr:RefreshSelectImage(false)
                        end
                    end

                    self._curDojo = v
                    KCookie.Set(TypeKCookie, v.type)
                    scr:RefreshSelectImage(true)

                    CfUtils.PlayAnimator(self.Root, "Go")
                    self:RefreshLevels()
                    self:FillEnergyBox()
                end)

                if checkNumber(v.type) == checkNumber(self._curDojo.type) then
                    scr:RefreshSelectImage(true)
                end
            end
            KTool.SetActive(go, true)
        end
    end
end

--刷新章节的关卡
function UIFightMap:RefreshLevels()
    local allQuestIds = QuestConfMgr:GetInstance():GetDailyQuestIdsByType(self._curDojo.type)
    if not allQuestIds then
        return
    end

    if checkNumber(self._curDojo.newestPassedQuest) == 0 then
        if allQuestIds[1] then
            self._curChallengeQuestId = allQuestIds[1]
        end
    else
        if allQuestIds[#allQuestIds] then
            if checkNumber(self._curDojo.newestPassedQuest) == checkNumber(allQuestIds[#allQuestIds]) then
                self._curChallengeQuestId = allQuestIds[#allQuestIds]
            else
                --关卡id只会递增
                self._curChallengeQuestId = checkNumber(self._curDojo.newestPassedQuest) + 1
            end
        end
    end
    if self.Content.transform.childCount < #allQuestIds + 1 then
        for i = self.Content.transform.childCount + 1, #allQuestIds + 1 do
            CfUtils.InstantiateGo(self.DailyLevelNode, self.Content)
        end
    end

    for i = 1, #allQuestIds do
        local questId = allQuestIds[i]
        local name = "level"..questId
        local go = self.Content.transform:GetChild(i)
        --[[
        if not go then
            go = CfUtils.InstantiateGo(self.DailyLevelNode, self.Content)
            go.name = name
        end
        ]]
        if go then
            go.name = name
            self:FillLevelNode(go, allQuestIds[i])
        end
    end

    for i = #allQuestIds + 1, self.Content.childCount do
        local go = self.Content.transform:Find("level"..i)
        if go then
            KTool.SetActive(go, false)
        end
    end

    local vo = QuestConfMgr:GetInstance():GetQuestVoById(allQuestIds[#allQuestIds])
    if vo then
        local pos = CfUtils.Split(vo.location)
        local goWidth = self.DailyLevelNode:GetComponent(typeof(RectTransform)).sizeDelta.x
        if pos then
            local size = self.Content:GetComponent(typeof(RectTransform)).sizeDelta
            self.Content:GetComponent(typeof(RectTransform)).sizeDelta = Vector2(checkNumber(pos[1]) + goWidth * 0.5, size.y)
        end

        vo = QuestConfMgr:GetInstance():GetQuestVoById(self._curChallengeQuestId)
        if vo then
            pos = CfUtils.Split(vo.location)
            if pos then
                local screenW = UIModule.RootCanvas.transform:GetComponent("RectTransform").rect.width
                if checkNumber(pos[1]) > screenW then
                    local vF = self.Content.transform.localPosition
                    local vD = Vector3(checkNumber(pos[1]) - screenW + goWidth * 0.5, 0, 0)
                    self.Content.transform.localPosition = vF - vD
                end
            end
        end
    end
end

function UIFightMap:FillLevelNode(go, id)
    local data =  QuestConfMgr:GetInstance():GetQuestVoById(id)
    if not go or not data then
        return
    end
    local env = CfUtils.GetLuaScr(go, "Game.UI.FightReady.UIFightDaily.UIFightMapDailyQuestCell")
    if env then
        env:RefreshLevelInfo(data.id, checkNumber(self._curChallengeQuestId) == data.id)
    end
    KTool.SetActive(go, true)
end

--刷新能源宝箱
function UIFightMap:FillEnergyBox()
    local isUp = checkNumber(self._curDojo.energyBoxRemainTime) > 0
    KTool.SetActive(self.DailyRewardBox, isUp)

    if isUp then
        local boxId = checkNumber(self._curDojo.energyBoxId)
        local vo = CfUtils.GetCfVo(AutoIds.IdSetting311, "EnergyBoxVo", boxId)
        if vo then
            CfUtils.FillText(self.TotalEnergy, vo.consumeEnergy)
            CfUtils.FillText(self.DailyRewardBox.transform:Find("CurEnergy"), string.format("%d<size=30>/%d</size>", self._curDojo.energyPoint, vo.consumeEnergy))
            CfUtils.FillText(self.Name, vo.name)

            local dailyTypeVo = CfUtils.GetCfVo(AutoIds.IdSetting310, "DailyTypeVo", self._curDojo.type)
            if dailyTypeVo then
                CfUtils.FillImage(self.EngryPoint, GoodsConfMgr:GetInstance():GetPhotoPathById(dailyTypeVo.energyPointItem))
            end

            CfUtils.FillImage(self.RewardBoxImage, vo.icon)
            SetButtonAction(self.RewardBoxImage, Bind(self, self.OnDailyRewardBox))
        end
    end
end

function UIFightMap:OnDailyRewardBox()
    UIModule.OpenDialog({ id = Constants.UITypeIds.UIDailyEnergyBox, parameters = { curDailyType = self._curDojo.type } })
end

function UIFightMap:OnFocus(focus)
    if focus then
        GameUtils.UpdateNavBarShowState(true, false)
    end
end

function UIFightMap:GetIndex(type)
    if not self._allData then
        return -1
    end
    for k, v in pairs(self._allData) do
        if checkNumber(v.type) == checkNumber(type) then
            return k
        end 
    end
    return -1
end

function UIFightMap:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end

function UIFightMap:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
            if not isNull(self) then
                Events.RemoveListener(Constants.EventNames.EnergyBoxPointChange, self.EventEnergyBoxPointChange)
                Events.RemoveListener(Constants.EventNames.EVENT_GUIDE_CUSTOM_UI_BEHAVIOR, self.EventEVENT_GUIDE_CUSTOM_UI_BEHAVIOR)
                Events.RemoveListener(Constants.EventNames.DailyQuestUpRefresh, self.EventDailyQuestUpRefresh)
            end
            self.controller = nil
            self:Delete()
            --lua层的gc需要
            self = nil
        end)
    )
    return coWait
end

--
function UIFightMap:OnEnergyBoxPointChange(body)
    self:FillEnergyBox()
end

function UIFightMap:OnDailyQuestUpRefresh(body)
    if not body then
        return
    end
    --如果是当前选择的
    if checkNumber(body.type) == checkNumber(self._curDojo.type) then
        self:FillEnergyBox()
    end
end

--引导
function UIFightMap:OnEVENT_GUIDE_CUSTOM_UI_BEHAVIOR(body)
    if not body then
        return
    end

    if checkNumber(self._curDojo.type) ~= body.type then
        local go = self.ToggleGroup.transform:Find("cell"..body.type)
        if go then
            local scr = CfUtils.GetLuaScr(go, DailyQuestCellPath)
            if scr then
                scr:OnDailyCellClickAction()
            end
        end
    end

    local vo = QuestConfMgr:GetInstance():GetQuestVoById(body.questId)
    if vo then
        self.Content.transform.localPosition = Vector3(0, self.Content.transform.localPosition.y, 0)
        local goWidth = self.DailyLevelNode:GetComponent(typeof(RectTransform)).sizeDelta.x
        local pos = CfUtils.Split(vo.location)
        if pos then
            local screenW = UIModule.RootCanvas.transform:GetComponent("RectTransform").rect.width
            if checkNumber(pos[1]) > screenW then
                local vF = self.Content.transform.localPosition
                local vD = Vector3(checkNumber(pos[1]) - screenW + goWidth * 0.5, 0, 0)
                self.Content.transform.localPosition = vF + vD
            end
        end
    end
end

return UIFightMap
