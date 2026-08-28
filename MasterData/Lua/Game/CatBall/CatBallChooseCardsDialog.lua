---{
---    teamType: Constants.EditTeamCatType 必传
---    levelId: teamType == Constants.EditTeamCatType.PreFight 必传
---    teamIndex: teamType == Constants.EditTeamCatType.PreFight 可选 默认1
---}

--region global define
local isNull = isNull
--endregion

--region import
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type CatBallUtils
local CatBallUtils                = import("Game.CatBall.CatBallUtils")
--endregion

--region define

local UICommonFilterMBEnvPath     = "Game.Behaviours.UICommonFilterMB"
local SkillAndAttributeEnvPath    = "Game.CatBall.CatBallChooseCardsSkillAndAttributeNode"
local CatBallChooseCatCellEnvPath = "Game.CatBall.CatBallChooseCatCell"

local StoreKey                    = "CatBallChooseCardsDialog"

local SortType                    = Constants.UISortType.CatBallChoose

local EditTeamCatType             = Constants.EditTeamCatType
local DataProvidePath = {
    [EditTeamCatType.PreFight] = "Game.CatBall.DataProvide.CatBallChooseCardsPreFightDataProvide",
    [EditTeamCatType.Operates] = "Game.CatBall.DataProvide.CatBallChooseCardsOperatesDataProvide",
}


--endregion

--- from: Assets/BundleResources/Prefabs/FightTeam/CatballChooseCardsDialog.prefab
---@class CatBallChooseCardsDialog
---@field Env                           	CatBallChooseCardsDialog                
---@field controller                    	Engine.UI.UILuaDialog                   
---@field NoSelect                      	UnityEngine.CanvasGroup               
---@field SkillAndGraffiti              	UnityEngine.RectTransform               
---@field ImgAttributeIcon              	Engine.UI.ImageAlterable                
---@field LevelUpButton                 	UnityEngine.RectTransform               
---@field StarLevel                     	StarProgressNode                        
---@field CatName                       	UnityEngine.UI.Text                     
---@field CardInfo                      	UnityEngine.CanvasGroup               
---@field LeftRoot                      	UnityEngine.RectTransform               
---@field ConfirmButton                 	UnityEngine.RectTransform               
---@field CancelButton                  	UnityEngine.RectTransform               
---@field TxtNumber                     	Game.Native.Common.UISwitchTextMeshPro  
---@field ImgPower                      	Game.Native.Common.UISwitchImage        
---@field TotalTeam                     	UnityEngine.RectTransform               
---@field CommonFilterNode              	UnityEngine.RectTransform               
---@field TxtNum                        	Game.Native.Common.UISwitchTextMeshPro  
---@field TxtTitle                      	Game.Native.Common.UISwitchText         
---@field ToFight                       	UnityEngine.RectTransform               
---@field ChooseCardsView               	Engine.UI.AutoFixSizeListView           
local CatBallChooseCardsDialog = Class('CatBallChooseCardsDialog')


function CatBallChooseCardsDialog:__init()
    self._isInitList        = false
    self._curSelectCatIndex = 0
    self.teamIndex = nil
    self._attrNodes         = {}
    
end


function CatBallChooseCardsDialog:__delete()
    self.controller = nil
    self.teamIndex = nil
end

function CatBallChooseCardsDialog:OnFocus(focus)

end


function CatBallChooseCardsDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:OnInit()
    end))
    return coWait
end

function CatBallChooseCardsDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:FreshUI()
        self:FreshToFightTitle()
        self:FreshToFightNum()
    end))
    return coWait
end


function CatBallChooseCardsDialog:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function CatBallChooseCardsDialog:OnInit()
    self:InitData()
    self:InitAction()
    self:InitUI()
end

function CatBallChooseCardsDialog:InitData()
    local argument         = self.controller.Argument.parameters
    ---@type Constants.EditTeamCatType
    self._teamType         = argument.teamType or Constants.EditTeamCatType.PreFight    --团队类型 1：战前 2：经营
    if not isNull(argument.levelId) then
        self.questId = argument.levelId
    end

    if not isNull(argument.teamIndex) then
        self.teamIndex = argument.teamIndex
    end


    local luaPath          = DataProvidePath[self._teamType]
    ---@type CatBallChooseCardsPreFightDataProvide | CatBallChooseCardsOperatesDataProvide
    local dataProvider     = import(luaPath)
    dataProvider:OnInit(argument)
    self._maxTeamCatBallCount     = dataProvider:GetMaxTeamCatBallCount()
    self._isHideToFight    = self._maxTeamCatBallCount <= 1
    self._dataProvider     = dataProvider

    self._maxSelectCatBallNum = dataProvider:GetMaxSelectCatBallNum()
    self._isSingle = self._maxSelectCatBallNum <= 1

    self._isShowLevelUpBtn = dataProvider.GetIsShowLevelUpBtn == nil or dataProvider:GetIsShowLevelUpBtn()
    
end

function CatBallChooseCardsDialog:InitAction()
    local Bind            = Bind
    local SetButtonAction = SetButtonAction
    SetButtonAction(self.LevelUpButton, Bind(self, self.OnClickLevelUpBtnAction))
    SetButtonAction(self.ConfirmButton, Bind(self, self.OnClickConfirmButtonAction))
    SetButtonAction(self.CancelButton,  Bind(self, self.OnClickCancelButtonAction))

end

function CatBallChooseCardsDialog:InitUI()
    KTool.SetActive(self.LeftRoot.gameObject, true)
    KTool.SetActive(self.LevelUpButton.gameObject, self._isShowLevelUpBtn)
    GameUtils.UpdateUIShowStateByCanvasGroup(self.CardInfo, false)
    GameUtils.UpdateUIShowStateByCanvasGroup(self.NoSelect, true)

    KTool.SetActive(self.ToFight.gameObject, not self._isHideToFight)
end

--endregion 


--region logic 

function CatBallChooseCardsDialog:FreshUI()
    self:FreshFilterNode()
    
end

function CatBallChooseCardsDialog:FreshFilterNode()
    ---@type UICommonFilterMB
    local filterNodeEnv = self:GetFilterNodeEnv()
    if isNull(filterNodeEnv) then return end
    filterNodeEnv:SetCallback(self._dataProvider:GetCatBallEntityList(), function(data)
        self._catBallEntityList = self:GetSortData(data)
        if self._selectCatEggDojo then
            self._curSelectCatIndex = 0
            local id = self._selectCatEggDojo.id
            for index, value in ipairs(self._catBallEntityList) do
                if value.dojo.id == id then
                    self._curSelectCatIndex = index
                    break
                end
            end
        end

        self:FreshGridView()

    end, SortType)
    filterNodeEnv:SetFilterClass(self._dataProvider:GetFilterType())
    filterNodeEnv:RestoreState(StoreKey, function(data)
        self._catBallEntityList = self:GetSortData(data)
        self:FreshGridView()

    end)
end

function CatBallChooseCardsDialog:GetSortData(data)
    local t1 = {}
    local t2 = {}
    local catIdToIndex = self._dataProvider:GetPlayerCatId2Index()
    for i, v in pairs(data) do
        local index = catIdToIndex[v.dojo.id]
        if not isNull(index) then
            table.insert(t1,v)
        else
            table.insert(t2,v)
        end
    end

    ---保证有序 里面肯定都是有Index 并且Index不一样的 所以不用考虑其他情况
    table.sort(t1,function(a,b)
        local aIndex = catIdToIndex[a.dojo.id]
        local bIndex = catIdToIndex[b.dojo.id]
        return aIndex < bIndex
    end)

    table.insertto(t1,t2)

    return t1
end

function CatBallChooseCardsDialog:FreshGridView()
    local count = #self._catBallEntityList
    if self._isInitList then
        self.ChooseCardsView:SetListItemCount(count)
    else
        self._isInitList = true
        self.ChooseCardsView:InitListView(count, Bind(self, self.OnGetItemByIndex))
    end

end

function CatBallChooseCardsDialog:OnGetItemByIndex(cell, idx)
    if idx < 0 then return nil end

    ---@type CatBallChooseCatCell
    local nodeEnv = CfUtils.GetLuaScr(cell, CatBallChooseCatCellEnvPath)
    if isNull(nodeEnv) then
        return nil
    end

    local index = idx + 1

    local dataProvider = self._dataProvider
    nodeEnv:SetCallback(function (catBallEntity)
        self.isLimitCat = GameUtils.IsLimitCat(self.questId,catBallEntity.dojo.id,self.teamIndex)
        self:OnClickCatCellAction(catBallEntity.dojo, nodeEnv, index)
    end)
    nodeEnv:SetDeleteCallback(function (catBallEntity) 
        local playerCatId = catBallEntity.dojo.id
        dataProvider:ClearTeamCatById(playerCatId)
        self:FreshToFightNum()

        local isHide = self._curSelectCatIndex == 0 or self._curSelectCatIndex == index
        GameUtils.UpdateUIShowStateByCanvasGroup(self.CardInfo, not isHide)
        GameUtils.UpdateUIShowStateByCanvasGroup(self.NoSelect, isHide)
        return index ~= nil

    end)
    
    ---@type CatBallEntity
    local catBallEntity = self._catBallEntityList[index]
    local isLimit = GameUtils.IsLimitCat(self.questId,catBallEntity.dojo.id,self.teamIndex)
    nodeEnv:FreshUI(catBallEntity, dataProvider:GetPlayerCatId2Index(), self._maxTeamCatBallCount, self._curSelectCatIndex == index, isLimit)

    return cell
end


function CatBallChooseCardsDialog:FreshToFightTitle()
    if self._isHideToFight then
        return
    end
end

function CatBallChooseCardsDialog:FreshToFightNum()
    if self._isHideToFight then
        return
    end
    local dataProvider = self._dataProvider
    local count        = table.count(dataProvider:GetPlayerCatId2Index())
    local maxCount     = self._maxSelectCatBallNum
    self.TxtNum.text   = string.format("%s/%s", count, maxCount)
    self.TxtNum.Status = count >= maxCount and 2 or 1

end

function CatBallChooseCardsDialog:FreshCatInfo()
    ---@type CatEggDojo
    local catEggDojo = self._selectCatEggDojo
    local skillAndAttributeEnv = self:GetSkillAndAttributeEnv()
    if isNotNull(skillAndAttributeEnv) then
        skillAndAttributeEnv:FreshUI(catEggDojo) 
    end

    local catId      = catEggDojo.catId
    ---@type CatBallVo
    local catBallVo  = CatBallUtils.GetCatBallVo(catId)

    self.ImgAttributeIcon:LoadSprite(CatBallUtils.GetAttributeIcon(catBallVo.types, catBallVo.subtype))
    self.StarLevel:SetStarNo(catBallVo.starMax, catEggDojo.star)
    self.CatName.text = catBallVo.name

end


--endregion 


--region get/set 

---GetFilterNodeEnv
---@return UICommonFilterMB
function CatBallChooseCardsDialog:GetFilterNodeEnv()
    if isNull(self._filterNodeEnv) then
        self._filterNodeEnv = CfUtils.GetLuaScr(self.CommonFilterNode.gameObject, UICommonFilterMBEnvPath)
    end
    return self._filterNodeEnv
end

---GetSkillAndAttributeEnv
---@return CatBallChooseCardsSkillAndAttributeNode
function CatBallChooseCardsDialog:GetSkillAndAttributeEnv()
    if isNull(self._skillAndAttributeEnv) then
        self._skillAndAttributeEnv = CfUtils.GetLuaScr(self.SkillAndGraffiti.gameObject, SkillAndAttributeEnvPath)
    end
    return self._skillAndAttributeEnv
end

---endregion 


--region handler 

---OnClickCatCellAction
---@param catEggDojo CatEggDojo
---@param nodeEnv CatBallChooseCatCell
function CatBallChooseCardsDialog:OnClickCatCellAction(catEggDojo, nodeEnv, index)
    local dataProvider = self._dataProvider
    local teamIndex, oldPlayerCatId = dataProvider:AddTeamCat(catEggDojo)
    local isSingle = self._isSingle
    local isShowCardInfo
    if index ~= self._curSelectCatIndex then
        if isSingle then
            isShowCardInfo = teamIndex ~= nil
            if self._curSelectCatIndex > 0 then
                self:FreshCellSelectAndChoose(self._curSelectCatIndex, false)
            elseif isSingle and oldPlayerCatId then
                --- 获取下 旧的猫所在的列表下标 并且重置下选择状态
                ---@param value CatBallEntity
                for listIndex, value in ipairs(self._catBallEntityList) do
                    if value.dojo.id == oldPlayerCatId then
                        self:FreshCellSelectAndChoose(listIndex, false)
                        break
                    end
                end
            end
            self:FreshCellSelectAndChooseByEnv(nodeEnv, isShowCardInfo, teamIndex)
        else
            if self._curSelectCatIndex > 0 then
                self:FreshCellSelectAndChoose(self._curSelectCatIndex, false)
            end
            isShowCardInfo = true
            self:FreshCellSelectAndChooseByEnv(nodeEnv, true, teamIndex)
        end
        self._curSelectCatIndex = index

    else
        isShowCardInfo = not isSingle or teamIndex ~= nil
        self:FreshCellSelectAndChooseByEnv(nodeEnv, isShowCardInfo, teamIndex)

    end

    GameUtils.UpdateUIShowStateByCanvasGroup(self.CardInfo, isShowCardInfo)
    GameUtils.UpdateUIShowStateByCanvasGroup(self.NoSelect, not isShowCardInfo)
    if self._selectCatEggDojo == nil or catEggDojo.id ~= self._selectCatEggDojo.id then
        self._selectCatEggDojo = catEggDojo
        self:FreshCatInfo()
    end
    self:FreshToFightNum()

end

function CatBallChooseCardsDialog:FreshCellSelectAndChoose(index, isShow, teamIndex)
    ---@type Engine.Modules.LuaBehaviour
    local luaBehaviour = self.ChooseCardsView:GetShownItemByItemIndex(index - 1)
    if isNull(luaBehaviour) then return end
    local env = luaBehaviour.Env
    self:FreshCellSelectAndChooseByEnv(env, isShow, teamIndex)
end

---FreshCellSelectAndChooseByEnv
---@param env CatBallChooseCatCell
---@param isShow boolean 是否显示选中框
---@param teamIndex number 团队下标
function CatBallChooseCardsDialog:FreshCellSelectAndChooseByEnv(env, isShow, teamIndex)
    if isNull(env) then return end
    if isShow ~= nil then
        env:FreshSelectState(isShow)
    end
    if self._isSingle or (teamIndex ~= nil) then
        env:FreshChooseShowState(self._maxSelectCatBallNum, teamIndex,nil,self.isLimitCat)
    end
end

function CatBallChooseCardsDialog:OnClickLevelUpBtnAction()
    if self._selectCatEggDojo == nil then return end

    local ids = {}
    ---@type CatBallEntity[]
    local catBallEntityList = self._catBallEntityList
    for index, value in ipairs(catBallEntityList) do
        if not value.isFragment then
            table.insert(ids, value.dojo.id)
        end
    end
    local playerCatId = self._selectCatEggDojo.id
    CfUtils.DialogOpen(Constants.UITypeIds.CatBallCultivateDialog, {playerCatId = playerCatId, ids = ids}, UICommonUtils.GetShowDialogArguments(), true)
    
end

function CatBallChooseCardsDialog:OnClickConfirmButtonAction()
    local isLimitCat = self._dataProvider:IsLimitCat(self.questId,self.teamIndex)
    if isLimitCat then
        GameUtils.Toast(localize("无法选择受限猫球"))
    else
        self._dataProvider:SaveTeamCats()
        self:OnClickCancelButtonAction()
    end
end

function CatBallChooseCardsDialog:OnClickCancelButtonAction()
    CfUtils.DialogBack()
end

---endregion 


return CatBallChooseCardsDialog

