---
--- Created by Eric.
--- DateTime: 2022/10/8 11:31
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local AdvancedTrainingComponent

local KCookie = CS.Engine.Lib.KCookie

------------ import ------------

------------ define ------------

------------ define ------------


--- from: Assets/BundleResources/Prefabs/AdvancedTraining/AdvancedTrainingDialog.prefab
---@class AdvancedTrainingDialog
---@field Env                           	AdvancedTrainingDialog
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field FontStyleButton               	UnityEngine.RectTransform
---@field CommonGoodsList               	UnityEngine.RectTransform
---@field ListView                      	UnityEngine.RectTransform
---@field RightList                     	UnityEngine.RectTransform
---@field NormalGroup                     	UnityEngine.RectTransform
---@field Cell4                         	UnityEngine.RectTransform
---@field Cell3                         	UnityEngine.RectTransform
---@field Cell2                         	UnityEngine.RectTransform
---@field Cell1                         	UnityEngine.RectTransform
---@field Top                           	UnityEngine.RectTransform
---@field Bottom                        	UnityEngine.RectTransform
local AdvancedTrainingDialog = Class("AdvancedTrainingDialog")
function AdvancedTrainingDialog:__init()
    self.typeVo = {}
    self.selectType = nil
    self.selectLuaIndex = nil
    self.questIds = {}

end

function AdvancedTrainingDialog:__delete()
    self.typeVo = nil
    self.selectType = nil
    self.selectLuaIndex = nil
    self.questIds = nil



    self.controller = nil
end

function AdvancedTrainingDialog:Awake()
    AdvancedTrainingComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.AdvancedTrainingComponent)

end

function AdvancedTrainingDialog:OnFocus(focus)
end

function AdvancedTrainingDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        GameUtils.Request(
                Interfaces.SeniorDungeonHome,
                {},
                function(request, response)
                    if checkInt(response.errCode) == 0 then
                        AdvancedTrainingComponent:InitHomeData(response.data)--这边初始的数据供其他子节点使用
                        self.typeVo = CfUtils.GetWholeVo(AutoIds.IdSetting2747, "AdvancedTrainingTypeVo")
                        self:SetSelectLevelIndex()
                        self:FreshTypeNode()
                        SetButtonAction(self.FontStyleButton, function()
                            UIModule.OpenDialog({ id = Constants.UITypeIds.UIFightTeamChoose,
                                                  parameters = { levelId = self.questIds[self.selectLuaIndex] } },
                                    { { id = Constants.UITypeIds.AdvancedTrainingDialog }})
                        end)
                    end
                end
        )
    end))
    return coWait
end

function AdvancedTrainingDialog:SetSelectLevelIndex()
    local cacheLevelId = KCookie.Get("AdvancedTrainingQuest")

    if cacheLevelId then
        local vo = QuestConfMgr:GetInstance():GetQuestVoById(cacheLevelId)
        self.selectType = vo.type
        self.questIds = AdvancedTrainingComponent:GetQuestIdsByType(vo.type)
        self.selectLuaIndex = checkNumber(table.keyof(self.questIds, checkString(cacheLevelId)))
        KCookie.Set("AdvancedTrainingQuest")
    else
        self.selectType = nil
    end

end

function AdvancedTrainingDialog:FreshTypeNode()
    for i, v in pairs(self.typeVo) do
        local typeNode = self["Cell"..v.id]
        if typeNode then
            if (not isNull(self.selectType)) and checkNumber(v.id) == checkNumber(self.selectType) then
                self:OnSelectType(self.selectType, true)
            end
            local cardRoot = typeNode.transform:Find("AnimRoot/Card/BtnCardNormalNode")
            local imgCard = cardRoot.transform:Find("ImgCard")
            local levelNumber = cardRoot.transform:Find("TxtLevelNumber")
            local name = cardRoot.transform:Find("TxtLicense")
            local finalNode = cardRoot.transform:Find("UIFX_AdvancedTrainingDialogCellFinish")
            local enterName = typeNode.transform:Find("AnimRoot/SelectBgGroup/TxtName")
            KTool.SetActive(finalNode, AdvancedTrainingComponent:IsAllPassByType(v.id))
            CfUtils.FillImage(imgCard, v.enterImage)
            local level = AdvancedTrainingComponent:GetMaxPassLevelByType(v.id)
            CfUtils.FillText(levelNumber, level)
            CfUtils.FillText(name, v.name)
            CfUtils.FillText(enterName, v.enterName)
            --local btnNode = cardRoot
            SetButtonAction(cardRoot, function ()
                self:OnSelectType(v.id)
            end)
        end
    end

end

function AdvancedTrainingDialog:FreshSelectStatus(isSelect)
    if self.selectType then
        local node = self["Cell"..self.selectType]
        if isSelect then
            node.transform:SetParent(self.Top)
        else
            node.transform:SetParent(self.Bottom)
            for i, v in pairs(self.typeVo) do
                if self.selectType ~= v.id then
                    local typeNode = self["Cell"..v.id]
                    if typeNode then
                        local animRoot = typeNode.transform:Find("AnimRoot")
                        CfUtils.PlayAnimator(animRoot, isSelect and "Selecting" or "Unselected")
                    end
                end
            end
        end
        local animRoot = node.transform:Find("AnimRoot")
        CfUtils.PlayAnimator(animRoot, isSelect and "Selecting" or "Unselected")
    else
        
        for i, v in pairs(self.typeVo) do
            local typeNode = self["Cell"..v.id]
            if typeNode then
                local animRoot = typeNode.transform:Find("AnimRoot")
                CfUtils.PlayAnimator(animRoot, isSelect and "Selecting" or "Unselected")
            end
        end
    end
    
end

function AdvancedTrainingDialog:OnSelectType(type, isCache)
    if (type ~= self.selectType) or isCache then
        self:FreshSelectStatus(false)
        self.selectType = type

        self:RepairLeftPanelPos()
        KTool.SetActive(self.RightList, true)
        KTool.SetActive(self.NormalGroup, false)
        self:FreshSelectStatus(true)

        self.questIds = AdvancedTrainingComponent:GetQuestIdsByType(type)
        print("======>>"..table.dump(self.questIds))
        self.selectLuaIndex = 1
        for k, v in pairs(self.questIds) do
            local isUnlockQuest = QuestConfMgr:GetInstance():IsUnlockQuest(v)
            if isUnlockQuest then
                self.selectLuaIndex = checkNumber(k)
            end
        end
        self:OnClickQuest()


        if not self.ListView.IsListViewInit then
            self.ListView:InitListView(#self.questIds, Bind(self, self.OnGetItemByIndex))
        else
            GameUtils.ReloadData(self.ListView, #self.questIds)
        end
        self.ListView:MovePanelToItemIndex(self.selectLuaIndex - 1)



    end
end

function AdvancedTrainingDialog:RepairLeftPanelPos()

end

function AdvancedTrainingDialog:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local luaIndex = index + 1
    local cell = listView:NewListViewItem("Cell")
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, "Game.UI.DailyQuest.DailyQuestCell")
    if nodeEnv then
        local questId = self.questIds[luaIndex]
        nodeEnv:FreshBaseUI({ questId = questId })
        local isSelected = luaIndex == self.selectLuaIndex
        nodeEnv:FreshSelectStatus(isSelected)
        nodeEnv:SetBtnCallBack(function()
            local isUnlockQuest = QuestConfMgr:GetInstance():IsUnlockQuest(questId)
            if isUnlockQuest then
                if luaIndex ~= self.selectLuaIndex then
                    --屏蔽掉重复点击当前选择的toggle
                    nodeEnv:FreshSelectStatus(true)
                    local preNodeGo = self.ListView:GetShownItemByItemIndex(self.selectLuaIndex - 1)
                    if preNodeGo then
                        local preNodeEnv = CfUtils.GetLuaScr(preNodeGo.gameObject, "Game.UI.DailyQuest.DailyQuestCell")
                        preNodeEnv:FreshSelectStatus(false)
                    end
                    self.selectLuaIndex = luaIndex
                    self:OnClickQuest()
                end
            else
                GameUtils.Toast(localize("通关前一难度后解锁"))
                return
            end
        end)
    end
    return cell
end

function AdvancedTrainingDialog:OnClickQuest()
    local questId = self.questIds[self.selectLuaIndex]


    local typeNode = self["Cell"..self.selectType]
    if typeNode then
        local questVo = QuestConfMgr:GetInstance():GetQuestVoById(questId)
        local txt = typeNode.transform:Find("AnimRoot/SelectBgGroup/ContentGroup/TxtContent")
        local conditionData = QuestConfMgr:GetInstance():GetQuestConditionWithMoreCf(questVo.conditionId, questVo.conditionValue)
        print("---->>"..table.dump(conditionData))
        CfUtils.FillText(txt, conditionData.desc)
    end

    --奖励
    local rewardData = RewardConfMgr:GetInstance():GetTeamShowRewardData(questId)
    if not rewardData then
        return
    end
    local t = {}
    local count = 1
    for i = 1, table.count(rewardData) do
        if count < 4 then
            local data = rewardData[i]
            if data.type == Constants.TeamShowRewardType.StarType then
                --领取过的不显示
                if not QuestConfMgr:GetInstance():IsPassAndCompleteAllCdtQuest(questId) then
                    table.insert(t, rewardData[i])
                    count = count + 1
                end
            elseif data.type == Constants.TeamShowRewardType.FristType then
                --领取过的不显示
                if not QuestConfMgr:GetInstance():IsPassQuest(questId) then
                    table.insert(t, rewardData[i])
                    count = count + 1
                end
            else
                table.insert(t, rewardData[i])
                count = count + 1
            end
        end
    end
    local rewardEnv = CfUtils.GetLuaScr(self.CommonGoodsList, "Game.Behaviours.CommonGoodsList")
    rewardEnv:FreshBaseUI(t)
end

function AdvancedTrainingDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return AdvancedTrainingDialog